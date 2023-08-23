Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12248785185
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjHWHaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjHWHaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:30:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E239410DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:29:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26f4bc74131so2178277a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1692775768; x=1693380568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQyRJaLJ0Vdq482Vz1CbhnNMe+eNXMe7OHL5O4+mSs0=;
        b=QAZxJ6pGQmtcqioPpzn/4WblexT0U8AYg/55rmaWGER3ByUumRMTiKAfj2AT/MSK/b
         R1tqcaHwEvM+S5PQlsr7dz5psJc3gswh5CeTKBRE1ZT4wyVg2PrjF19oeQpBA7503wfH
         yzeOhN3K2VdVZkxay6kMmwQBNarMwfTZE6TuuUZdTFHP3+v7/iJZB3NoRK2/HXVFuDY2
         YDfGkhEdZgqFsd4EEiA/Fz4m+3EyP/gFKii7ZMptSJ+QdJqJGiSyiPYtJuRIfNO3vLd6
         YEE2bb7RWeTwUzKIhVHiF7+uCrfv348eECbc36/P2nLRWvU0Ic2DGYcgF65Yt6ryL4tj
         gjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775768; x=1693380568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQyRJaLJ0Vdq482Vz1CbhnNMe+eNXMe7OHL5O4+mSs0=;
        b=gmT6aRdogG6WG7pF6+ryb5ODtc7ijHfWM6jYAcImseSHkfHCA18dfjB3fXOeeDjMpT
         9IHKBPS8qoGkvxuFO7h3hvW+Ggu9F08Y5DXKjsoNswzc5wq8N/dA22Y1Mha3muv6QsH5
         qGrFaK4pYsysQ88ckQZ0JtngiNc0KWrZUxKcY962U2ac6VKHQ74FJFPm1cSXsu8hOGfP
         mIF+RDPoZynu4fdurGzkU9kz7VNwh/OJImiltA/bCTZsh21FObU8c0xXGupodR3ctPak
         ZMo1U6R9HoDDT6RVHhrTtFr9phdVwMcD4g7TDTspMXBQToDAkf9QNreEBdbUj6H1F/eV
         l+fA==
X-Gm-Message-State: AOJu0YyZhZMisnohxMAYYubTDFaJlVNgXBUge7jK1NVVnAIk0LFTWb9a
        jG2TwEZcoYzK8JhihySweEIh/g==
X-Google-Smtp-Source: AGHT+IG2fwoJAgUq1yrPjRJnc6/Lp+FnQ0nBgjxV0+tv4HFMZAWtfXTO7ZfyJZa658JYP1HyfSBr/Q==
X-Received: by 2002:a17:90b:1b49:b0:26d:4d1c:5395 with SMTP id nv9-20020a17090b1b4900b0026d4d1c5395mr17562346pjb.18.1692775768345;
        Wed, 23 Aug 2023 00:29:28 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.128])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090a024500b00262e604724dsm11585407pje.50.2023.08.23.00.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 00:29:27 -0700 (PDT)
Message-ID: <47834714-1a9b-90f0-cebb-229d5dfcf31b@monstr.eu>
Date:   Wed, 23 Aug 2023 09:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] microblaze: Make virt_to_pfn() a static inline
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230808-virt-to-phys-microblaze-v1-1-e6df710fe0a1@linaro.org>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20230808-virt-to-phys-microblaze-v1-1-e6df710fe0a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/23 10:40, Linus Walleij wrote:
> Making virt_to_pfn() a static inline taking a strongly typed
> (const void *) makes the contract of a passing a pointer of that
> type to the function explicit and exposes any misuse of the
> macro virt_to_pfn() acting polymorphic and accepting many types
> such as (void *), (unitptr_t) or (unsigned long) as arguments
> without warnings.
> 
> Move the function down in the file so __pa() exists in our
> scope, and it compiles. This in turn requires moving __pa()
> as it depends on __virt_to_phys() that was below. (Lazy macro
> evaluation conflicts with strict function ordering.)
> 
> Make a symmetric change to pfn_to_virt() so we have type
> checking both ways.
> 
> Due to this the <asm/page.h> file being included into some
> assembly files, some further inclusion guards are needed
> to make sure assembly keeps compiling.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/microblaze/include/asm/page.h | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> index 337f23eabc71..86a4ce07c192 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -99,9 +99,6 @@ extern int page_is_ram(unsigned long pfn);
>   # define phys_to_pfn(phys)	(PFN_DOWN(phys))
>   # define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
>   
> -# define virt_to_pfn(vaddr)	(phys_to_pfn((__pa(vaddr))))
> -# define pfn_to_virt(pfn)	__va(pfn_to_phys((pfn)))
> -
>   #  define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
>   #  define page_to_virt(page)   __va(page_to_pfn(page) << PAGE_SHIFT)
>   #  define page_to_phys(page)     (page_to_pfn(page) << PAGE_SHIFT)
> @@ -109,11 +106,6 @@ extern int page_is_ram(unsigned long pfn);
>   #  define ARCH_PFN_OFFSET	(memory_start >> PAGE_SHIFT)
>   # endif /* __ASSEMBLY__ */
>   
> -#define	virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
> -
> -# define __pa(x)	__virt_to_phys((unsigned long)(x))
> -# define __va(x)	((void *)__phys_to_virt((unsigned long)(x)))
> -
>   /* Convert between virtual and physical address for MMU. */
>   /* Handle MicroBlaze processor with virtual memory. */
>   #define __virt_to_phys(addr) \
> @@ -125,6 +117,25 @@ extern int page_is_ram(unsigned long pfn);
>   #define tovirt(rd, rs) \
>   	addik rd, rs, (CONFIG_KERNEL_START - CONFIG_KERNEL_BASE_ADDR)
>   
> +#ifndef __ASSEMBLY__
> +
> +# define __pa(x)	__virt_to_phys((unsigned long)(x))
> +# define __va(x)	((void *)__phys_to_virt((unsigned long)(x)))
> +
> +static inline unsigned long virt_to_pfn(const void *vaddr)
> +{
> +	return phys_to_pfn(__pa(vaddr));
> +}
> +
> +static inline const void *pfn_to_virt(unsigned long pfn)
> +{
> +	return __va(pfn_to_phys((pfn)));
> +}
> +
> +#define	virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
> +
> +#endif /* __ASSEMBLY__ */
> +
>   #define TOPHYS(addr)  __virt_to_phys(addr)
>   
>   #endif /* __KERNEL__ */
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230808-virt-to-phys-microblaze-4afdf2bcf96c
> 
> Best regards,

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
