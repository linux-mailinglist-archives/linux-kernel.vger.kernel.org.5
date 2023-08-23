Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A48785172
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjHWH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHWH0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:26:35 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47299E47
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:26:21 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-570fde9baadso761084eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1692775580; x=1693380380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFfLC1rnQb4Eqk6ms3+DfKXasmKQ8OJ9ZIKvJTzscKk=;
        b=T0smctul6WTKEdmQqUCQur6FqXearwsoc0/Tykj7oPEttGohUDRmZaGXBr3rc2LMQi
         if7+JvvA3GS6TcAzQTs1XU9+ZuaSzknm2pe6DwGm97laczE/qHXsrGUxBQnVjyMpd3TM
         DUTYJhjtbKf3l8RfZ/jA5sfUTsrXfpy5mqKJXhoJ+1Jd4lTQuDxrVKbZoDlGk5PvAp9k
         KGL5TgoxuEoQ8lXJ36a+KIQi5+GUg4KAIHcgh73YtzkUkuXFwMbHDCx4CYuruZleuCa+
         txPO/Jk+K4rEwyt+0KUre1yiXS2jCasSgSw5SVDIj58VmmUoUxP6F7X/3Z8Rp8T7yNKH
         LZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775580; x=1693380380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFfLC1rnQb4Eqk6ms3+DfKXasmKQ8OJ9ZIKvJTzscKk=;
        b=WPW/dTTv03wnmfolXeK2x6ixQiY/uU4aRUjKg4oFNCpiP6qq/JgtLnO3YzgQIL17C0
         eN9/SK7ALKHzCsI9WE1WPcZzTUDlP9K+OctA/ldTQVy3wduFrZ1uLdr78bxcAGxqDuHX
         2gHlBv4Z85Q6XgWKNCk15j1wxNCN9b2FwwJOaE2nsIzVCQPsH+Ygr/CKEZVAOaPzw4Vt
         SqcpisKTurg8knN6hW+fmhNhmhSCKASq74nOqh17K/QIiLii8YstmDyDeLeBzldhPJ9j
         l8fvPuzAIilAqEYc3kARlgWm+bAXDGsZVgyUfZ8zuMoorhYPfJMGHO4EE+bGuir2XtcU
         Jxhw==
X-Gm-Message-State: AOJu0YzRIUFVk+6nzR6IG1ZrHXj6UjusbQsEvaKjlKgjbV5T4982fHPh
        95gWKOMwHgZa9Jv3DPPtoWdwvQ==
X-Google-Smtp-Source: AGHT+IGaEhQLXG+wclX9zFTl+ZlqCPd77r8BO61+fzDgIiQ0psBVrQPzh9G0NlVCjsqBnK6tzeubuA==
X-Received: by 2002:a05:6808:2a62:b0:3a7:7d4:4f91 with SMTP id fu2-20020a0568082a6200b003a707d44f91mr13104258oib.14.1692775580566;
        Wed, 23 Aug 2023 00:26:20 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.128])
        by smtp.gmail.com with ESMTPSA id w29-20020a63935d000000b00563df2ba23bsm9016870pgm.50.2023.08.23.00.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 00:26:19 -0700 (PDT)
Message-ID: <227c8466-31a4-1f8d-a3f5-2c469220bcdd@monstr.eu>
Date:   Wed, 23 Aug 2023 09:26:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] microblaze: Remove zalloc_maybe_bootmem()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org
References: <bfb1601cac24d7ef8e741c83f9301e4a5a87a0b5.1692124505.git.christophe.leroy@csgroup.eu>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <bfb1601cac24d7ef8e741c83f9301e4a5a87a0b5.1692124505.git.christophe.leroy@csgroup.eu>
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



On 8/15/23 20:36, Christophe Leroy wrote:
> Last user of zalloc_maybe_bootmem() was removed by
> commit 4308e3c9e1ea ("microblaze/PCI: Remove unused allocation & free
> of PCI host bridge structure")
> 
> Remove it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/microblaze/include/asm/setup.h |  2 --
>   arch/microblaze/mm/init.c           | 16 ----------------
>   2 files changed, 18 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
> index 3657f5e78a3d..bf2600f75959 100644
> --- a/arch/microblaze/include/asm/setup.h
> +++ b/arch/microblaze/include/asm/setup.h
> @@ -25,7 +25,5 @@ void machine_shutdown(void);
>   void machine_halt(void);
>   void machine_power_off(void);
>   
> -extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
> -
>   # endif /* __ASSEMBLY__ */
>   #endif /* _ASM_MICROBLAZE_SETUP_H */
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index 353fabdfcbc5..3827dc76edd8 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -270,22 +270,6 @@ asmlinkage void __init mmu_init(void)
>   	memblock_dump_all();
>   }
>   
> -void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
> -{
> -	void *p;
> -
> -	if (mem_init_done) {
> -		p = kzalloc(size, mask);
> -	} else {
> -		p = memblock_alloc(size, SMP_CACHE_BYTES);
> -		if (!p)
> -			panic("%s: Failed to allocate %zu bytes\n",
> -			      __func__, size);
> -	}
> -
> -	return p;
> -}
> -
>   static const pgprot_t protection_map[16] = {
>   	[VM_NONE]					= PAGE_NONE,
>   	[VM_READ]					= PAGE_READONLY_X,

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

