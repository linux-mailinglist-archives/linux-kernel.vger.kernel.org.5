Return-Path: <linux-kernel+bounces-157595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B237A8B135A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA572842B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1974BE4;
	Wed, 24 Apr 2024 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YY2K3pO5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3372E83C;
	Wed, 24 Apr 2024 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986154; cv=none; b=XLVnQsH0CNzQMP2dCkcYCh0xQmvSdwZnKCvREdrgHHQsCowXe24E9O0qgI6Oju9jPTtBOR0H8q4KqWcmjGZ2Ftbjojr7IfmyVOa2K0ZVEIZonAjlQ5f6DTwsGZxYrpoesydhq4nt6qFmCP3gU/R8v2lkiHJTYiFOq3ZKa1BcxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986154; c=relaxed/simple;
	bh=rmwxgcxlUdc52wL5EaUESjL4xF5FuwTjEzqI95uds0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Js4T0XXGvIcX1t33f8/hmP7ThjyDBIvL77vKdujvqsPHxQdoa4Rw96cDNN6VhTXUbTLuWIDiZ2OI6UhQ/O/W+LseYtesdeo7PcHczBM/gapwmq8EjQyjmddRarZAyJ8t3nplfZiKB5jluN4WN3i00DVOefTeYJR2Ae3bQt7cW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YY2K3pO5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0BF4447C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713986153; bh=eT4DMkSX1KqZnImT4LXh1T9r6WFTUp9YLsLSh6290ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YY2K3pO5g02e+5BvRN3Kjp4M+EpSDSd2gwq0efMwYeH0uHua5nPb/Usl7FANLumXR
	 TBBINjR0+9i/cezi2Rnd6JvTZjF2U2mP32r7+NWuWk1H50e9yVVlOzpZggJH4zOtx2
	 waIAOxhbjxLvYvVs9kUZL5NpkVslMETBVgYGYcuh4gveOruSPThujsW8drFwI31x+6
	 7onJaxRH9vbvRgWzV7nZ6kH5HeUuImA4auBOq3TrGqFcAMs71/7QE08BhLrefn3Tun
	 9d6UbUjGjruClPGO1e58DS/jsLhlwLu3I47yJr/NzZlwQ6ULYezOwRV913LwL3aEeR
	 mnBXEazeKV7Eg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0BF4447C41;
	Wed, 24 Apr 2024 19:15:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lbulwahn@redhat.com>, Akira Yokosawa <akiyks@gmail.com>,
 linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in DOCUMENTATION
In-Reply-To: <20240417101429.240495-1-lukas.bulwahn@redhat.com>
References: <20240417101429.240495-1-lukas.bulwahn@redhat.com>
Date: Wed, 24 Apr 2024 13:15:52 -0600
Message-ID: <87v846shav.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lbulwahn@redhat.com> writes:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 1e596d5eff3d ("docs: Detect variable fonts and suggest denylisting
> them") adds the new script check-variable-fonts.sh and intends to refer to
> it in the DOCUMENTATION section in MAINTAINERS. However, the file entry
> refers to scripts/check-variable-font.sh. Note the missing "s".
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
>
> Repair this new file entry in the DOCUMENTATION section.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4356b28ce625..250c8f8caa08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6493,7 +6493,7 @@ S:	Maintained
>  P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
> -F:	scripts/check-variable-font.sh
> +F:	scripts/check-variable-fonts.sh
>  F:	scripts/documentation-file-ref-check

Applied, thanks.

jon

