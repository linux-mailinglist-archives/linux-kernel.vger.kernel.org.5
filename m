Return-Path: <linux-kernel+bounces-53099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9284A0A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C3E1F2307E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE145962;
	Mon,  5 Feb 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WIbCxkMf"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B14594C;
	Mon,  5 Feb 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153971; cv=none; b=SB06ZvTmA33Df2Vw3MLe7wkieDjbForVn7hMkpYBTkkEYe/In63HC9AaJHXu7F6VXlD7UxL1MRg8i+0iGxlK8OrsT0yozWjkTPundNr9wkWPIvZOQ8uODtnf/7+AAxhvYLgW8siw++OE7qpEFZEfEXQCD7a0XZGEkftwAqcR5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153971; c=relaxed/simple;
	bh=8i7lcxh/x4uQunS+AlvlgqrIx4AVsofuwd7cPq+3coM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CO8GaMx44xp/xcoew2FsfXdhatFqXvlxhzG2QRGF7KRXpnxjMn1CohrFAYRL37HMvt5l/38L+ZnB+0a+LV/ItPJkFrqMEp/7SVf9sxFIv9PBlY31ZCdEklGYFXp6DwH/yo8zHs31vRw8BulIsU2tDGH/Tl++s2QzxoxvjYk6GdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WIbCxkMf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BFD8145AC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707153969; bh=qr/2lpiQ89AbjIDEIndmFpZxXbjgeKgLt4sGWgqQabg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WIbCxkMfr/JvlOBfMgcqc6W0D/fOhFgRWBeja/Im5CqnIL7MKuiQ8acdKRIwozE3N
	 naqLwrjT4AaSSbiu0FEktZLnAtRmPQKhEld0RLbBmn53q5r7ZmVWHgf4MyIYORG1rw
	 90NZzO+kSSKcOXb162BhtcJHyFuuGInRe0JyMRaxA6+4/HAOSCOkd6yPcsI5QpCGcL
	 oAUpeeE3gqk/7ZQwzoxMWsdxa2ymb5hOckWU6Aw2QCFaZzBq0ki0tv7mf7DcikRyMh
	 hQ9HNXnbyO11zdN5A7fvt8sA5/ZclDHy4+hhLXVX8km665KU0ImpA9MZ9QnDVWGO4f
	 7PPFFMkvsYoZQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BFD8145AC9;
	Mon,  5 Feb 2024 17:26:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 trivial@kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] Documentation: admin-guide: tainted-kernels.rst: Add
 missing article and comma
In-Reply-To: <20240205132409.1957-1-thorsten.blum@toblux.com>
References: <20240205132409.1957-1-thorsten.blum@toblux.com>
Date: Mon, 05 Feb 2024 10:26:08 -0700
Message-ID: <874jemvn4f.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@toblux.com> writes:

> - Add missing article "the"
> - s/above example/example above/
> - Add missing comma after introductory clause to improve readability
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon

