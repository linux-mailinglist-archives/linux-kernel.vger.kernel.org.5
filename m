Return-Path: <linux-kernel+bounces-79496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80795862346
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CD8B23046
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19779EE;
	Sat, 24 Feb 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VSvZBdZK"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A894C64
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708758205; cv=none; b=RoxKPgZA8YPTzZAbdtl8QoNrDNNxvQNfoUrKiqOHzgbGPJfLjXOf9Kfn5GUyfKzKOPS73VV/y9U8J/EkA7leigxBzEt7809qzkqFU4D8c22B06EWAIyPONrZFhJddcWXGvxtElmU+DvTFwHz4Kfz7aXl7X7i3PUMNnt6H/MjOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708758205; c=relaxed/simple;
	bh=utaGe6uiwmTzfIPUETzW6TdxvHgjXUvrLSvV7bTUk1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPPt0PxLqse5PsVvegirPUONMTYIqVsJaUj3r6NN1njfUh2GVMlkpzeN1N44X/cYau7c2JSS6YEPurIROVeWlF4G26vZrPXyOJ07oKiQmbbfGdPwI16ZDs2cwUZtRMhcYUgOzA0Wz2wy27yiUSA0QQF5MTIBvJ2SNvVnI8gZGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VSvZBdZK; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id dm40rzOJHZc8Edm40rwRmA; Sat, 24 Feb 2024 08:03:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708758194;
	bh=zaAjgqWRp0nSEMfAmosrEZOp1z8vjHJIuWxUPoa7WkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VSvZBdZKYhsNiDW8JxPaQzxWnHDOaMaKcAM4JqFg4F8d/+vG7jv38iWioTRuuUQfC
	 iveiJ+tP6CGRu92fGMWoyQuc7AuEYUP1SsAUfHg/MAd7zHj1z/ZItqswOSUxYbdptC
	 Vf17LRufwaS6QS7q+ietTgBokFSY8o8U1+7/p/pdU+MSIupxCZThLpFweD77KA9OY1
	 dXr6/qUlsEZy8XocbC1FFuAF8H7qpP972BOtd8ZebxEo6LVNkVd+oLy6WexFwrx7DL
	 U9GpjYXnJZTjocKqkpE2lCBmo6Rlp3S3/dEWaxeMBTy0kOeTtyBmSe/B8On8FaVKIC
	 eIoaEw9xkOOyg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 24 Feb 2024 08:03:14 +0100
X-ME-IP: 92.140.202.140
Message-ID: <c45d16c6-abab-4132-a499-c231dcedebb2@wanadoo.fr>
Date: Sat, 24 Feb 2024 08:03:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] mm: enumerate all gfp flags
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, petr@tesarici.cz, keescook@chromium.org,
 pasha.tatashin@soleen.com, mhocko@suse.com, kernel-team@android.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240224015800.2569851-1-surenb@google.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240224015800.2569851-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 24/02/2024 à 02:58, Suren Baghdasaryan a écrit :
> Introduce GFP bits enumeration to let compiler track the number of used
> bits (which depends on the config options) instead of hardcoding them.
> That simplifies __GFP_BITS_SHIFT calculation.
> 
> Suggested-by: Petr Tesařík <petr@tesarici.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> Changes from v4 [1]:
> - Split from the series [2] as a stand-alone patch, per Michal Hocko
> - Added Reviewed-by, per Pasha Tatashin
> - Added Acked-by, per Michal Hocko
> 
> [1] https://lore.kernel.org/all/20240221194052.927623-7-surenb@google.com/
> [2] https://lore.kernel.org/all/20240221194052.927623-1-surenb@google.com/
> 
>   include/linux/gfp_types.h | 90 +++++++++++++++++++++++++++------------
>   1 file changed, 62 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 1b6053da8754..868c8fb1bbc1 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -21,44 +21,78 @@ typedef unsigned int __bitwise gfp_t;
>    * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
>    */
>   
> +enum {
> +	___GFP_DMA_BIT,
> +	___GFP_HIGHMEM_BIT,
> +	___GFP_DMA32_BIT,
> +	___GFP_MOVABLE_BIT,
> +	___GFP_RECLAIMABLE_BIT,
> +	___GFP_HIGH_BIT,
> +	___GFP_IO_BIT,
> +	___GFP_FS_BIT,
> +	___GFP_ZERO_BIT,
> +	___GFP_UNUSED_BIT,	/* 0x200u unused */

Hi,

what is the need to have this ___GFP_UNUSED_BIT now?

> +	___GFP_DIRECT_RECLAIM_BIT,
> +	___GFP_KSWAPD_RECLAIM_BIT,
> +	___GFP_WRITE_BIT,
> +	___GFP_NOWARN_BIT,
> +	___GFP_RETRY_MAYFAIL_BIT,
> +	___GFP_NOFAIL_BIT,
> +	___GFP_NORETRY_BIT,
> +	___GFP_MEMALLOC_BIT,
> +	___GFP_COMP_BIT,
> +	___GFP_NOMEMALLOC_BIT,
> +	___GFP_HARDWALL_BIT,
> +	___GFP_THISNODE_BIT,
> +	___GFP_ACCOUNT_BIT,
> +	___GFP_ZEROTAGS_BIT,
> +#ifdef CONFIG_KASAN_HW_TAGS
> +	___GFP_SKIP_ZERO_BIT,
> +	___GFP_SKIP_KASAN_BIT,
> +#endif
> +#ifdef CONFIG_LOCKDEP
> +	___GFP_NOLOCKDEP_BIT,
> +#endif
> +	___GFP_LAST_BIT
> +};

Does it make sense to have something like:
   BUILD_BUG_ON(___GFP_LAST_BIT > BITS_PER_LONG, "blah");
(should we need to use BIT_ULL() one day)

> +
>   /* Plain integer GFP bitmasks. Do not use this directly. */
> -#define ___GFP_DMA		0x01u
> -#define ___GFP_HIGHMEM		0x02u
> -#define ___GFP_DMA32		0x04u
> -#define ___GFP_MOVABLE		0x08u
> -#define ___GFP_RECLAIMABLE	0x10u
> -#define ___GFP_HIGH		0x20u
> -#define ___GFP_IO		0x40u
> -#define ___GFP_FS		0x80u
> -#define ___GFP_ZERO		0x100u
> +#define ___GFP_DMA		BIT(___GFP_DMA_BIT)
> +#define ___GFP_HIGHMEM		BIT(___GFP_HIGHMEM_BIT)
> +#define ___GFP_DMA32		BIT(___GFP_DMA32_BIT)
> +#define ___GFP_MOVABLE		BIT(___GFP_MOVABLE_BIT)
> +#define ___GFP_RECLAIMABLE	BIT(___GFP_RECLAIMABLE_BIT)
> +#define ___GFP_HIGH		BIT(___GFP_HIGH_BIT)
> +#define ___GFP_IO		BIT(___GFP_IO_BIT)
> +#define ___GFP_FS		BIT(___GFP_FS_BIT)
> +#define ___GFP_ZERO		BIT(___GFP_ZERO_BIT)
>   /* 0x200u unused */

Keeping this comment here is now useless, IMHO.

CJ

> -#define ___GFP_DIRECT_RECLAIM	0x400u
> -#define ___GFP_KSWAPD_RECLAIM	0x800u
> -#define ___GFP_WRITE		0x1000u
> -#define ___GFP_NOWARN		0x2000u
> -#define ___GFP_RETRY_MAYFAIL	0x4000u
> -#define ___GFP_NOFAIL		0x8000u
> -#define ___GFP_NORETRY		0x10000u
> -#define ___GFP_MEMALLOC		0x20000u
> -#define ___GFP_COMP		0x40000u
> -#define ___GFP_NOMEMALLOC	0x80000u
> -#define ___GFP_HARDWALL		0x100000u
> -#define ___GFP_THISNODE		0x200000u
> -#define ___GFP_ACCOUNT		0x400000u
> -#define ___GFP_ZEROTAGS		0x800000u
> +#define ___GFP_DIRECT_RECLAIM	BIT(___GFP_DIRECT_RECLAIM_BIT)
> +#define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
> +#define ___GFP_WRITE		BIT(___GFP_WRITE_BIT)
> +#define ___GFP_NOWARN		BIT(___GFP_NOWARN_BIT)
> +#define ___GFP_RETRY_MAYFAIL	BIT(___GFP_RETRY_MAYFAIL_BIT)
> +#define ___GFP_NOFAIL		BIT(___GFP_NOFAIL_BIT)
> +#define ___GFP_NORETRY		BIT(___GFP_NORETRY_BIT)
> +#define ___GFP_MEMALLOC		BIT(___GFP_MEMALLOC_BIT)
> +#define ___GFP_COMP		BIT(___GFP_COMP_BIT)
> +#define ___GFP_NOMEMALLOC	BIT(___GFP_NOMEMALLOC_BIT)
> +#define ___GFP_HARDWALL		BIT(___GFP_HARDWALL_BIT)
> +#define ___GFP_THISNODE		BIT(___GFP_THISNODE_BIT)
> +#define ___GFP_ACCOUNT		BIT(___GFP_ACCOUNT_BIT)
> +#define ___GFP_ZEROTAGS		BIT(___GFP_ZEROTAGS_BIT)
>   #ifdef CONFIG_KASAN_HW_TAGS
> -#define ___GFP_SKIP_ZERO	0x1000000u
> -#define ___GFP_SKIP_KASAN	0x2000000u
> +#define ___GFP_SKIP_ZERO	BIT(___GFP_SKIP_ZERO_BIT)
> +#define ___GFP_SKIP_KASAN	BIT(___GFP_SKIP_KASAN_BIT)
>   #else
>   #define ___GFP_SKIP_ZERO	0
>   #define ___GFP_SKIP_KASAN	0
>   #endif
>   #ifdef CONFIG_LOCKDEP
> -#define ___GFP_NOLOCKDEP	0x4000000u
> +#define ___GFP_NOLOCKDEP	BIT(___GFP_NOLOCKDEP_BIT)
>   #else
>   #define ___GFP_NOLOCKDEP	0
>   #endif
> -/* If the above are modified, __GFP_BITS_SHIFT may need updating */
>   
>   /*
>    * Physical address zone modifiers (see linux/mmzone.h - low four bits)
> @@ -249,7 +283,7 @@ typedef unsigned int __bitwise gfp_t;
>   #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>   
>   /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT ___GFP_LAST_BIT
>   #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
>   
>   /**
> 
> base-commit: 603c04e27c3e9891ce7afa5cd6b496bfacff4206


