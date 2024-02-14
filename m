Return-Path: <linux-kernel+bounces-65780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B58551C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0534D1C21F69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD81C12AAE0;
	Wed, 14 Feb 2024 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0SpdxzaY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76812A154
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934154; cv=none; b=XstySqEc0Ed0XfW8EdsF2k49Wxt9XoAZ0sO6B8A8zbJubsF7LaJCSTwYZoboSegcXgt0WL/kAaNk2Qvrn8hUqt3omB7q0f+MPtv7q17MfnJQj0QvvfQToeTjByEwI5volQH4TU76kxxf+bAs1aYLWIqJltMdarsKMwBbWyUoB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934154; c=relaxed/simple;
	bh=igfMvEZGLTS+1WsnQQCYCia30RltHib/bWawTo+VSTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhSJiPyU7PNgUmALMKakIRjc4bM0qSc0ctp8v/fZl48E6LzSVAMt8WBfgUmUmO4FJwFlhr5cySMmHX0XksJUGn68mgHhyX4yUcuq1R9/VM9T2C4jK6XvWVY2Gcl6uWvEhREg5LpzAF67PMu9dUVqegtg5NjVUbdV22HN8JX7aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0SpdxzaY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZugzDEBZhrkjmLBI0RiloC/ti6l8aNWxtJdo3x/XM4M=; b=0SpdxzaYqSdCHA+xBEbr7belHM
	7W9Sra9ahCpI7VYCNtau+EWZRe2D+WFWdRrX/Xt38JYky6AKBetfIihpXvQ4/S/GQCLBCyS2AhvUe
	doe6Rgim1E0QQLDS1gxf+Q1Vwi1GiDGhuTl3gyZyqcLK0o08uGP28ujFDZ9yqR2kVkTNEoq6imAxc
	pj/zRzyUA9hxCVNDdQifVmyimfbX31Tx2nqneASZjEoCPev8UwLCBm0sN7mBdL3+Dg4IOqlB6TztD
	VD7nEDbuF7Av/weAUSK/qVk/LnjsNLb6ucjovGD4W1dKqFnf9xkPttwu0+v+Xkb8alpUTdQs2kc1u
	Yfu1OlZA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raJh1-0000000DsKu-1sWc;
	Wed, 14 Feb 2024 18:09:11 +0000
Message-ID: <9cba3b78-1020-4337-a1f9-5857a297aee4@infradead.org>
Date: Wed, 14 Feb 2024 10:09:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] kernel.h: Move upper_*_bits() and lower_*_bits()
 to wordpath.h
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>
References: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/24 09:26, Andy Shevchenko wrote:
> The wordpart.h header is collecting APIs related to the handling
> parts of the word (usually in byte granularity). The upper_*_bits()
> and lower_*_bits() are good candidates to be moved to there.
> 
> This helps to clean up header dependency hell with regard to kernel.h
> as the latter gathers completely unrelated stuff together and slows
> down compilation (especially when it's included into other header).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Kees, since wordpart.h is now only in your tree, this is supposed
> to go there as well.

after someone corrects the Subject (wordpath -> wordpart).

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


> 
>  include/linux/kernel.h   | 30 ++----------------------------
>  include/linux/wordpart.h | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 5f74733391ed..d718fbec72dd 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -33,6 +33,8 @@
>  #include <linux/sprintf.h>
>  #include <linux/static_call_types.h>
>  #include <linux/instruction_pointer.h>
> +#include <linux/wordpart.h>
> +
>  #include <asm/byteorder.h>
>  
>  #include <uapi/linux/kernel.h>
> @@ -52,34 +54,6 @@
>  }					\
>  )
>  
> -/**
> - * upper_32_bits - return bits 32-63 of a number
> - * @n: the number we're accessing
> - *
> - * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
> - * the "right shift count >= width of type" warning when that quantity is
> - * 32-bits.
> - */
> -#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
> -
> -/**
> - * lower_32_bits - return bits 0-31 of a number
> - * @n: the number we're accessing
> - */
> -#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
> -
> -/**
> - * upper_16_bits - return bits 16-31 of a number
> - * @n: the number we're accessing
> - */
> -#define upper_16_bits(n) ((u16)((n) >> 16))
> -
> -/**
> - * lower_16_bits - return bits 0-15 of a number
> - * @n: the number we're accessing
> - */
> -#define lower_16_bits(n) ((u16)((n) & 0xffff))
> -
>  struct completion;
>  struct user;
>  
> diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
> index c9e6bd773ebd..f6f8f83b15b0 100644
> --- a/include/linux/wordpart.h
> +++ b/include/linux/wordpart.h
> @@ -2,6 +2,35 @@
>  
>  #ifndef _LINUX_WORDPART_H
>  #define _LINUX_WORDPART_H
> +
> +/**
> + * upper_32_bits - return bits 32-63 of a number
> + * @n: the number we're accessing
> + *
> + * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
> + * the "right shift count >= width of type" warning when that quantity is
> + * 32-bits.
> + */
> +#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
> +
> +/**
> + * lower_32_bits - return bits 0-31 of a number
> + * @n: the number we're accessing
> + */
> +#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
> +
> +/**
> + * upper_16_bits - return bits 16-31 of a number
> + * @n: the number we're accessing
> + */
> +#define upper_16_bits(n) ((u16)((n) >> 16))
> +
> +/**
> + * lower_16_bits - return bits 0-15 of a number
> + * @n: the number we're accessing
> + */
> +#define lower_16_bits(n) ((u16)((n) & 0xffff))
> +
>  /**
>   * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
>   * @x: value to repeat

-- 
#Randy

