Return-Path: <linux-kernel+bounces-143585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A2F8A3B26
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29219B22821
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1B81CA95;
	Sat, 13 Apr 2024 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JP8NVTO5"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03401C6AF
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712986769; cv=none; b=jrDN7ieZtqO/8jtFotk4PthbLcdUmLB6VLHZmiPPFjPghUt5aH3L8FzDGFSiJ78b87Mcy/doPl7pjpfEDn1PR++nm0DsVeYqWkvjpcRAnJn2ekd3RLNrkqDVNIxo821pV6+EKvCwaOrUUKrY+KQoXEetHM95IoMwkIoTeDtvYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712986769; c=relaxed/simple;
	bh=g/C/tm5r/C38U7huz6QtN90K2bB9A2rvRkkIVIk3EoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DnX3wFBdUGKeNOe/4Gc4pBz4K2Tv/6RxeOoRQlPtf39qN7/DaY3upWJ9ERL1KR5gnSaYZVzzdL4Si/dNl9lEy/cVd4AHnkeXnfQ6uHJL7kyzGY8+wxzBSxGuWRiugJ1s2MMjxoxGYY8zd2Na3Q8/ijJgMdkQPPSYNodIqO8+WwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JP8NVTO5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=QTSuGpXav9BZermSpdxyipeJ0eawJWt3Wail1BIGJBQ=; b=JP8NVTO5JfOIZFeNxqUOMVBvPn
	DMW/LzsNDggeqWWxniTYoeznnXq2lpMoSq7+4hiNhKtBhAIDLUCVlkfQaeEYW7Gy+wm+TEi5xQtAm
	6fyUy+uS2RmqKjNotV4O78tuMSAnVoh3IXkzcuFPqfgdzp7DNp5R10vhtx8VICt7c0shrqEIbovPh
	xWX7wruDHHQhB1bnuCid+7O1FunXvIqA8QSZilEh1HwmpypxotKSz64Qao7TNzX8aq2BWON5xgWrs
	l2SpQsl23lSsNlShXTiTgt+Tn2PbJiFGNUERKVxvwjEO3fEKGnJtriazk6i9vLBmdKKC+P8aMcLJA
	KGYNrvyw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvW6n-00000002SN4-2ZOy;
	Sat, 13 Apr 2024 05:39:25 +0000
Message-ID: <96b7f74b-548c-451c-b08e-86173db2e40a@infradead.org>
Date: Fri, 12 Apr 2024 22:39:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/linux/bitops.h: Fix function fns
To: Chin-Chun Chen <chinchunchen2001@gmail.com>, linux-kernel@vger.kernel.org
References: <20240413052850.9419-1-chinchunchen2001@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240413052850.9419-1-chinchunchen2001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 10:28 PM, Chin-Chun Chen wrote:
> Modified the function fns to resolve a calculation error by:
> 1. Reducing n first.
> 2. Adding 1 at the end to get the correct index.
> 
> This commit improves the accuracy and reliability of the code.
> 
> Signed-off-by: Chin-Chun Chen <chinchunchen2001@gmail.com>
> ---
>  include/linux/bitops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 2ba557e067fe..2457610f74eb 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -258,8 +258,8 @@ static inline unsigned long fns(unsigned long word, unsigned int n)
>  
>  	while (word) {
>  		bit = __ffs(word);
> -		if (n-- == 0)
> -			return bit;
> +		if (--n == 0)
> +			return bit + 1;
>  		__clear_bit(bit, &word);
>  	}
>  
> 
> base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854

Hi,

Please send your patch to some maintainer.
People don't browse the mailing list for patches to pick up.


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

