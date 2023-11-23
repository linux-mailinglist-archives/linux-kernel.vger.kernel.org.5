Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA36F7F5C09
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbjKWKPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjKWKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:15:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB92D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:15:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so92249166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700734506; x=1701339306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoA9bSh51T9SvqQw+ewuo5HRp8g8P63XMDowzZKBiBs=;
        b=SCMGeaXf9l1rs9qCJM2nsuN0H5Z+KYbA3+vsyAdEGjrY6NdNorNL5j+vMPkvSejoWv
         Tfa0N2BkbwH/rn2zXPs2ma5UOb6T4SzuLfCY8pbykSqeh0Jnat1wHo/bY57gCttKoHUy
         jtRGZNbaZeCFLHT2f+ajzvmqrhtu1qgEb8/4ttcf+15Xf/tt4IBC6HE83iG6oWfzZFQs
         ecLhvG9DXl2L7rKegS7G9NQNkJij1z5nuEX72Eg5/Ob0p0tQbY7ChBALRjIJtSLsn7TQ
         8ucKOJ5bR6JxhOwjUGawWI9KXNhBhuYdP0JXCp632B7t1WNdSllwFPOiDeZVhl03fh0l
         BdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734506; x=1701339306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoA9bSh51T9SvqQw+ewuo5HRp8g8P63XMDowzZKBiBs=;
        b=u/KeTyrl1W8HhCZ6O8b3VKiBrffmBjj0gvPUjzMh8s3/9eNwVgSLjRlwGVyDXHgjuL
         NikUGkp4/zh4ObX9RCfSpX9WY8FZtfL/jMnoI019nBM67NQ/kkHPovDgnYLiuL1NWjgs
         AYB/qsY6lyYlFpCEcTUp/S+PZXFLXvM98TMDhhz4erbnfrohWnDyYmvRh3gvG9A/UODQ
         D8im0R9eRpmBqM4a5/71xeXr8atKxk4qvrKZTrVVyC3p393Wy/R96Q1ad4tZqZ4ZYF8c
         7BWejVpHDiG3DK1azUGsVqtiGv2Zd3dEhhn4e8wMWqF8cy6g6ziVyyDLbGgNuZUhXQB/
         ObsA==
X-Gm-Message-State: AOJu0Yzo/BWoc7qMhlRBcXlOL2Ve8S0ZUo4IYK0NEU+TAXEKR1ThUJhO
        hrLbQMIlgogdCdYvmqynMdo=
X-Google-Smtp-Source: AGHT+IEhuRzgH8zLk2VtVE23K1d63E+V/lOzYIufjhWJi+b6D0dqKLBbgHvwTulD7OQPEqBJVklfhA==
X-Received: by 2002:a17:906:20d8:b0:9ba:2fe3:c97e with SMTP id c24-20020a17090620d800b009ba2fe3c97emr3832365ejc.11.1700734505716;
        Thu, 23 Nov 2023 02:15:05 -0800 (PST)
Received: from gmail.com (1F2EF67D.nat.pool.telekom.hu. [31.46.246.125])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b009f2b7282387sm582304eja.46.2023.11.23.02.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:15:05 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 23 Nov 2023 11:15:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Michael Roth <michael.roth@amd.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3] x86: Ensure input to pfn_to_kaddr() is treated as a
 64-bit type
Message-ID: <ZV8mJhI3SRRQL/u4@gmail.com>
References: <20231122163700.400507-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122163700.400507-1-michael.roth@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael Roth <michael.roth@amd.com> wrote:

> On 64-bit platforms, the pfn_to_kaddr() macro requires that the input
> value is 64-bits in order to ensure that valid address bits don't get
> lost when shifting that input by PAGE_SHIFT to calculate the physical
> address to provide a virtual address for.
> 
> One such example is in pvalidate_pages() (used by SEV-SNP guests), where
> the GFN in the struct used for page-state change requests is a 40-bit
> bit-field, so attempts to pass this GFN field directly into
> pfn_to_kaddr() ends up causing guest crashes when dealing with addresses
> above the 1TB range due to the above.
> 
> Fix this issue with SEV-SNP guests, as well as any similar cases that
> might cause issues in current/future code, by using a inline function,
> instead of the macro, so that the input is implicitly cast to the
> expected 64-bit input type prior to performing the shift operation.
> 
> While it might be argued that the issue is on the caller side, other
> archs/macros have taken similar approaches to deal with instances like
> this, such as commit e48866647b48 ("ARM: 8396/1: use phys_addr_t in
> pfn_to_kaddr()").
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
> v3:
>   - Use an inline function instead of a macro to handle the cast (Peter)
> v2:
>   - Move the cast down into pfn_to_kaddr() to fix other possible
>     instances (Dave)
>   - Rename from "x86/sev: Fix overflow when computing address for
>     PVALIDATE"
> 
>  arch/x86/include/asm/page.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index d18e5c332cb9..aa8930da42fd 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -66,10 +66,14 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
>   * virt_addr_valid(kaddr) returns true.
>   */
>  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
> -#define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
>  extern bool __virt_addr_valid(unsigned long kaddr);
>  #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
>  
> +static inline void *pfn_to_kaddr(unsigned long pfn)
> +{
> +	return __va(pfn << PAGE_SHIFT);
> +}

Makes sense I guess.

Note that in the tip:x86/mm commit I changed it to __always_inline, as we 
typically do for such low level MM helpers. Delta patch below.

Thanks,

	Ingo

==============>

 arch/x86/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index aa8930da42fd..1b93ff80b43b 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -69,7 +69,7 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
-static inline void *pfn_to_kaddr(unsigned long pfn)
+static __always_inline void *pfn_to_kaddr(unsigned long pfn)
 {
 	return __va(pfn << PAGE_SHIFT);
 }
