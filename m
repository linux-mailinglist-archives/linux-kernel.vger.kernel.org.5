Return-Path: <linux-kernel+bounces-31671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82D833256
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF31F228D3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17BEA5A;
	Sat, 20 Jan 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ho1LQC68"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574ACA44
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705715442; cv=none; b=MGVJs+EAEgw6YHg4MtTJcTXBAwErq779kaMCJmy9YTYcXVSavb45GMjk4FwaEY4IDFo+BUdBBpkc8m1Sd1kENnuoyodZjLlO17SmkLEJv7xre+oQu/V5tf60QwaoZ88ecs1cJpgmvRp6LFG3SQIOPMljNKZHJHgvKf+ngmDwVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705715442; c=relaxed/simple;
	bh=O7s8USHbxoqxDXLq7fcXICPH7eLjuiqDm+UsSQyRD7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAb/zcSNP9P0WixN3x7gaFSyqVML3wnXFrwD5vFVHq9rP5KjEYiNt3swZamf7JBZsIQ8xOqos6WMcEzVZmGfN/sUV8tBsOpLMjUsZE9MZfM2D44UL/Ywav0rUUengsMio3mOniBNukVvNSeVyk4vo28Glg01zMqa2HtOV5xxu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ho1LQC68; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc36e501e1so1034842a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705715439; x=1706320239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XOITpQ5DIMR2IaudgN0/DW6CNyk3x4Ig/+XyjN/PP8=;
        b=Ho1LQC68BuGClK4xY4BuygIHtKMqAa1qTPXwXr8GMo2j8azawFZVne0J4OHZXd0xEf
         FGvjDrHXPfJGtw+62K1OncO8Z2W9tAWqG/CNZtJKYXWNJn8Ghq6mri3+R+t+IwAM9WQ8
         r0xfzwYQoYuQZ7cZ2LQs4sLWDCm2QtK6gQjdI3q8K3eNS7F+eWnByu2ImBKrdpnzzlVf
         W8JiuwGjhhds/ouSC+IHWUnnZvxKx7WX69GugtDq0avep0GK/MjkACEhLOEZgVVd9hP0
         U2FYdx+40T1V9iw4Ux+s0kCcfQ5GCTB6/W743uIC3FtI6If+KID6hTzrFd4vgwi7Jw4R
         5W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705715439; x=1706320239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XOITpQ5DIMR2IaudgN0/DW6CNyk3x4Ig/+XyjN/PP8=;
        b=tHBm8Qb3XmvnRtB9EwjijV3BH3LLLnUIRHyPo/WGehokt97YyVBpTIrmV9hY7GDWPb
         p+8TYEpevxyNi+q6mCBnNXGQg1gHVQyvmekFj4Uy9qMcVCXOEwLRqCzmjS89ExVo46r/
         YrSaGocDkra2behXrKGEAG/GYLHTO/stXP+IJHgr4vVkM3679vk1MlwJGwuOomMVU6S8
         LNh8Gq7JDtdw8o0rehyCZv13p9rhxh0w5mosb998RXTpW+FnZJ99hqgyxMQXZLYp149W
         UCWDCFhp76folt9wU8N0rtYED6FfameecPL6TdTmGEFPCwuIKz7ylZPkMbE0RCRI1/3G
         CwIQ==
X-Gm-Message-State: AOJu0YzsWEV0J7KEw90JnDz6xlJfz9Fv6Pb9BkwrP4n/DO4UT+4hDAIX
	GfpHFbt4z4Rkc8mMNc4JsAeJ2jFfSmO4C4IIG+aCgl/xV+EXM5T7vjZNEFoeYUQ=
X-Google-Smtp-Source: AGHT+IGkhCllEapg0R5O7qaHZ0AI3ph1OReFqFBoj0J72zCVnKpl8RZyjHh02StLZzQXRNmMLGfiWQ==
X-Received: by 2002:a9d:6212:0:b0:6dc:5e1:3d89 with SMTP id g18-20020a9d6212000000b006dc05e13d89mr762369otj.17.1705715439125;
        Fri, 19 Jan 2024 17:50:39 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id u24-20020a63f658000000b005cda7a1d72dsm4086546pgj.74.2024.01.19.17.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 17:50:38 -0800 (PST)
Date: Fri, 19 Jan 2024 17:50:36 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] RISC-V: mm: fix mmap behavior in sv48 address space
Message-ID: <Zasm7D/bQH9XGHvf@ghost>
References: <tencent_F3B3B5AB1C9D704763CA423E1A41F8BE0509@qq.com>
 <tencent_871D1B705162CE42D21BD1F86E0447B44709@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_871D1B705162CE42D21BD1F86E0447B44709@qq.com>

On Mon, Jan 15, 2024 at 03:58:30AM +0800, Yangyu Chen wrote:
> A commit add2cc6b6515 ("RISC-V: mm: Restrict address space for
> sv39,sv48,sv57") from patch[1] restricts regular mmap return address in the
> sv48 space if the address hint is not above the sv48 userspace address.
> However, this commit treats the address wrong which only use sv48 if the
> hint address is above sv48 user address space. Actually, it should use sv48
> if the address is above sv39 user address space. Moreover, the original

It is not valid to use any address in sv48 in this case. It is designed
to provide an address that is in sv39 to guarantee that the application
is able to handle any address that is returned by mmap. If, for example,
the application asks for the address 1<<42, it expects that all of the
bits above 42 are not used. The address provided by mmap must not
contain those bits, so it uses the sv39 address space.

- Charlie

> patch code looks very complex in logic, we can simplify it with min marco.
> 
> [1]. https://lore.kernel.org/r/20230809232218.849726-2-charlie@rivosinc.com
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/include/asm/processor.h | 39 ++++++------------------------
>  1 file changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index e1944ff0757a..7ead6a3e1f12 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -9,6 +9,7 @@
>  #include <linux/const.h>
>  #include <linux/cache.h>
>  #include <linux/prctl.h>
> +#include <linux/minmax.h>
>  
>  #include <vdso/processor.h>
>  
> @@ -18,37 +19,13 @@
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>  #define STACK_TOP_MAX		TASK_SIZE
>  
> -#define arch_get_mmap_end(addr, len, flags)			\
> -({								\
> -	unsigned long mmap_end;					\
> -	typeof(addr) _addr = (addr);				\
> -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> -		mmap_end = STACK_TOP_MAX;			\
> -	else if ((_addr) >= VA_USER_SV57)			\
> -		mmap_end = STACK_TOP_MAX;			\
> -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> -		mmap_end = VA_USER_SV48;			\
> -	else							\
> -		mmap_end = VA_USER_SV39;			\
> -	mmap_end;						\
> -})
> -
> -#define arch_get_mmap_base(addr, base)				\
> -({								\
> -	unsigned long mmap_base;				\
> -	typeof(addr) _addr = (addr);				\
> -	typeof(base) _base = (base);				\
> -	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
> -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> -		mmap_base = (_base);				\
> -	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
> -		mmap_base = VA_USER_SV57 - rnd_gap;		\
> -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> -		mmap_base = VA_USER_SV48 - rnd_gap;		\
> -	else							\
> -		mmap_base = VA_USER_SV39 - rnd_gap;		\
> -	mmap_base;						\
> -})
> +#define arch_get_mmap_end(addr, len, flags) \
> +	((addr) >= DEFAULT_MAP_WINDOW ? STACK_TOP_MAX :\
> +	 min(DEFAULT_MAP_WINDOW, STACK_TOP_MAX))
> +
> +#define arch_get_mmap_base(addr, base) \
> +	((addr) >= DEFAULT_MAP_WINDOW ? base :\
> +	 min(base, DEFAULT_MAP_WINDOW))
>  
>  #else
>  #define DEFAULT_MAP_WINDOW	TASK_SIZE
> -- 
> 2.43.0
> 

