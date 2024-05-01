Return-Path: <linux-kernel+bounces-165700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237D8B8FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82781F23FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC681607BB;
	Wed,  1 May 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SRkJzVs8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787CA1607A8;
	Wed,  1 May 2024 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589830; cv=none; b=bZnNZ642F3jBDrV8pjSgv9hPzHVfXly3i9h/ok0Qoz4FPeglv9sVqkJdKlT7FHCJeGs/2PEdmHEQSpfC+obLtxSrgRF5K9x0CX61U4oJ/VU1gemGis7PdpsLV9fjUQPPeeqg6D2nvaSECzvrZbtblYSHCVGMIbikTKMgTuz7CAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589830; c=relaxed/simple;
	bh=0aoNKXX8hWE0H+YlLw7f66VrTZxQWRpKPdrqMg24ySE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FlGCx658jshjV7XAtB8FV3hjVnH8QT5L9HNzxS/ILHT8FPHrYVkci25YON2cXeLDppUeMSKofkOsOqtNqc9tXD6fSotqczr21CnvfBASmiahShpS/ZhiruYcDT1kW8/ihdVwnhtLcCBJHdGNbFHdvWZt/2nK7uewrTwt8OUFjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SRkJzVs8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5F46147C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714589821; bh=4xnLp8OdJ5uSBbLV1KZq5CLFPr7xzGKpCJEQ3FB3DAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SRkJzVs87gjmPX0/pAPwI6xs+zY2cyy/tOjPno1u8hq4/9N6fD/iN4SnODv2eodWd
	 BVmq/WPRqpuM/ihNtExfghfg+0Vh40tD1dClc4XokbeNPsDv/+421lekHIuGrtzV1l
	 8yuD4wUP1HTgn/n3QoVlnKT4Bk8QvvwxHvyVTGsYy0bxh0bArGYicqpGUbmJA1wl5J
	 iRqDBSL8LPm+K/oyyU0CBgNCOjav2oWpKYg23pAJWO+WtYolgqvn+UUuWh1XCqQa49
	 rXwqkN5WuJhSBaktxPhkHku7AM7R7m/ODRgiWkwjCpTDC1XFoF3uHFkSj2+h7XPfMt
	 hgN7vdnQX2wnA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5F46147C42;
	Wed,  1 May 2024 18:57:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Utkarsh Tripathi <utripathi2002@gmail.com>, akiyks@gmail.com
Cc: Utkarsh Tripathi <utripathi2002@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] Sphinx error fixed for inline literal end-string by
 changing $type_constant2 in kernel-doc script to include "*" unicode
 character in highlights_rst.
In-Reply-To: <20240501175730.23326-1-utripathi2002@gmail.com>
References: <b9e4bedb-6678-42ed-9ac1-c10179be5b69@gmail.com>
 <20240501175730.23326-1-utripathi2002@gmail.com>
Date: Wed, 01 May 2024 12:57:00 -0600
Message-ID: <87r0elbbsz.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Utkarsh Tripathi <utripathi2002@gmail.com> writes:

> The kernel-doc script uses the $type_constant2 variable to match
> expressions used to find embedded type information. The current
> implementation of $type_constant2 does not include the "*" unicode
> character, which is used to highlight inline literals in the
> documentation. This causes a Sphinx error when the inline literal
> end-string is used in the documentation.

So I need to look a bit further at the actual change, but I do have a
couple of comments on the patch itself.  First, the text above is a
reasonable description of the problem, as a changelog should have.  That
said, the subject line could be a bit shorter and to the point.

This text below:

> This commit follows the pattern of the commit
> 8aaf297a0dd6 ("docs: scripts: kernel-doc: accept bitwise negation like ~@var")
> and takes inspiration from the following commit
> 69fc23efc7e5 ("kernel-doc: Add unary operator * to $type_param_ref").
>
> Thanks Akira, for your suggestions, I have made the required changes.
> I am fairly new to the kernel community, so if I am making 
> any mistakes while making patches and replying to mails,
> please let me know, it will be very helpful.

..doesn't belong in the changelog.  If you put comments like this below
the "---" line, then the maintainer won't have to edit them out when
applying the patch.

> Signed-off-by: Utkarsh Tripathi <utripathi2002@gmail.com>
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> Suggested-by: Akira Yokosawa <akiyks@gmail.com>

Did Akira offer you that Reviewed-by tag?  I haven't seen it (which
doesn't mean it didn't happen).  If it was not explicitly given to you,
though, you cannot put it here.

Thanks,

jon

