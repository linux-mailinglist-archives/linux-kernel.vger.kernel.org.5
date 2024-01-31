Return-Path: <linux-kernel+bounces-46901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED4844640
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DA6B22985
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E85212F581;
	Wed, 31 Jan 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="T5SxKhAA"
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80912DD84;
	Wed, 31 Jan 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721802; cv=pass; b=r2ttYtRCJoMky9DAIlAoXaF0A2ZMUgthSYJ2J/WpyIP4V8uDfvLfEwcayHLFfm5aVA+I5JuYogSJSBk+KID/iI7fBZENnSWMsou7Lc3IDlQ+gtjs/J1mhUyUpZmXyHHnjV1WffIYZOgkwL+d4k7sYKWphy+Pu8Qz5X0bisoO3ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721802; c=relaxed/simple;
	bh=OkbyR1eOud37M5OLwfX1vWYkrALqqo3FGkCmHla/MMA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=pB4xvcP5dTCnXtZRWcPk+IEU2twgSD3YLBVV3g7sJTdic7D7nr41jQOkt6bHmmDVuDvCCNwh2vcivR7BcrSstlCQfWsgkxrKt4kMQf9Yh4mUQJkMVhdZoXbzcY8Zf/S5vPeWF9DtQJCq8blyI8ui2EzoYwLXkhv0bM9DsWi+aWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=T5SxKhAA; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <e0861faa7b564362e384783d4e52e38c@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1706721797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7jJIaYqMSfxPjtLTr60DeUKvzsmBPgfKadAEZC9wwo=;
	b=T5SxKhAAJiH0NWcSdazzl+wRI6/ATIDRkkLlsiQNj6P+XSRcZbj16uQSZC0qMDWHAm/t32
	y3POA/YOv31Sz7HR3CLt+qJJexg5TUwkuKcp5NJTBbFLZzZnu9zaEDytRQivcziCm+AZWH
	LMgHe6mCtAMfq17ajMJCzLrvpP5ktkIwK78qGV82ODHXyN8rT0x2zsb3tG5RiAFgCsrTzy
	NH74VvHMxbJKrFOC0ImAbgSq1Zfq9XhmDUE/MQUqsX4418pw5a2QvC9/S7qhsFiMZ1WXUL
	mhzMCgYV1wv98suc2P4xMB91L0BXTjcy8EBwMzcdjcoQOHF8uG6EldVD2ldU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1706721797; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7jJIaYqMSfxPjtLTr60DeUKvzsmBPgfKadAEZC9wwo=;
	b=C7S5PNyeFynbMjNaJdSIVnEfbdRFQhB66SkNb1tyfxDZGujMTB0pCmkhAgVK0B/IzSCNn1
	DAFhaayE8FIoBcoPKWW/aZ+0d9i7F7bfeTiHJ5DggJGzVECZnNjp757YOVxmGKTbFj1oc9
	7EUdrv8LuXa8AwB/9Sak9f74/9s76JnCe15r3D0Trtna3aMjyINxdnnEbQu95upfGYiDWH
	MiDCKRwrq3JZfXl2IuDN2jJ53NpTh6XV15v+VU1vfKKZMBuzf9p1Es70dUre7kXa3rO1Ji
	vVf1fYcK5zOWB4CBmewCsiBV4Hg/MYs4GAkvoyAtLLbwpAZviVA4gi8fLQQGLA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1706721797; a=rsa-sha256;
	cv=none;
	b=o37iH5DlZhudX0g7wrQFXivWYBlZfw6KV7qoPJAOAGnneqnGleIIuyAbIJCgSkfaJercFA
	C3wJSco9alFsazIkS88c9WTPVBCfqUiTAlYmkz2x/KW8rBkWJ9+ODTPvF3Zr4QMbyrGaAI
	tQ1FMh0x1QNMcTKe7c9+xnOZnGfrxfdmGBxAngqv5a3U7ww6sF3xf0MW2VYeXOHpeOGHc5
	tGudQ+zfB1Jrnx5O6JrqvOJDG9iCcS0yk0Oah8eGvnuN7xNPAUiTVqtezehrQKk6AnpWOX
	BKHyojikbjpT6meialC9E4L4rrFOFFHt60tZVArrThILfV7IQDYxKBswH/fnwA==
From: Paulo Alcantara <pc@manguebit.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steve French <sfrench@samba.org>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] smb: client: Fix a NULL vs IS_ERR() check in
 wsl_set_xattrs()
In-Reply-To: <571c33b3-8378-49fd-84e1-57f622ef6db5@moroto.mountain>
References: <571c33b3-8378-49fd-84e1-57f622ef6db5@moroto.mountain>
Date: Wed, 31 Jan 2024 14:23:13 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Carpenter <dan.carpenter@linaro.org> writes:

> This was intended to be an IS_ERR() check.  The ea_create_context()
> function doesn't return NULL.
>
> Fixes: 1eab17fe485c ("smb: client: add support for WSL reparse points")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/smb/client/reparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara <pc@manguebit.com>

