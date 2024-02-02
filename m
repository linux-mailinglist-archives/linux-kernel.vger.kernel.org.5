Return-Path: <linux-kernel+bounces-50115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F613847471
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5811F2F2D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA414691C;
	Fri,  2 Feb 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b34+tFD9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C01468F5;
	Fri,  2 Feb 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890525; cv=none; b=s0Pc89Tc3brV26oYTRVPoWmMjM4CH03vBcXIIBZIyPZzeF3p8Pbc8cUWq41fB5t8PZR4tpxinb6zDOKyIyBkQ2fTppRfFlMzAhlR70N/Xluqew21xOqxN8QfuqsWWgrqT6NB9evjNGjZEvSZUUr1xnlacMxYRaph9rMM30HqGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890525; c=relaxed/simple;
	bh=JjWwTx3dbGV3vSIYCVLEwe0WOZa5VXEB7MWk/5AUvm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgGJ/Ejq+iPC5K4Jw+S53Gh1zhoEdGxNXkNFQtahfMr/Qe/X95AKPGRu6GYcOOP1DJOo22nKAfH0Sg28N7w2tOtK9b8XIHR/HqkWaA35XBCmccOVF3jlIimso8HuZcaODvYUTmPIt6nbf4u+xNCjMz77Xrh9pjzm1VI6U73V6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b34+tFD9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1E9I98N24XpXmgIY1g1LYAtG7hN20wn0otmf8A1dmM4=; b=b34+tFD9/zbAzrAyS5YMtMBwOF
	kFitV1PhRYXfTnp1ztW4eJL6euiFaJP5jcmIQ2do4bVcoOm8VC8gnvdDIc7gSopZg4/LqWXRGH5g1
	W+2nZnT0I49N5dTwZaIOMx2ed3XOZ+Fr2IvfZB4i4P2cbRgvMZmMT839c8EOmKCbM5DNsRlxM0eO/
	7g9BlmjQ7CJMRoyTnKKhXMMUz10nK7CZ494N+mrwnvH05KyVV1WFZVDZdth2SgkDTBQun2glWJ4EX
	nZUcn0QbR2j2agKFpiQ/wU3H3WF9QK1daZheNN6lUsTNqTCn3wPY/b02aUX4oaHjoMu3iTWTwDE/z
	tJOqCkkg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVwCG-0000000CFPs-3uV6;
	Fri, 02 Feb 2024 16:15:21 +0000
Message-ID: <e6127bb4-c423-4028-aed6-7357a90440d6@infradead.org>
Date: Fri, 2 Feb 2024 08:15:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ksmbd: Add kernel-doc for ksmbd_extract_sharename()
 function
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, linkinjeon@kernel.org,
 sfrench@samba.org
Cc: senozhatsky@chromium.org, tom@talpey.com, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240202081317.128980-1-yang.lee@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240202081317.128980-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/2/24 00:13, Yang Li wrote:
> The ksmbd_extract_sharename() function lacked a complete kernel-doc
> comment. This patch adds parameter descriptions and detailed function
> behavior to improve code readability and maintainability.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/smb/server/misc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
> index 9e8afaa686e3..1a5faa6f6e7b 100644
> --- a/fs/smb/server/misc.c
> +++ b/fs/smb/server/misc.c
> @@ -261,6 +261,7 @@ char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name)
>  
>  /**
>   * ksmbd_extract_sharename() - get share name from tree connect request
> + * @um: pointer to a unicode_map structure for character encoding handling
>   * @treename:	buffer containing tree name and share name
>   *
>   * Return:      share name on success, otherwise error

-- 
#Randy

