Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF6A80F8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377533AbjLLVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377456AbjLLVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:09:18 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577BBE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:09:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d06fffdb65so37280265ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702415362; x=1703020162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4klJ8l6fLfAZKVWPgko1830CXSL6+WluuhkBtOdryM=;
        b=Qd2J5mn2We4mnkEiCEls1VCkboYBr+dlfGZLimYXMEv0Fr125YcU6FhbelmsrYUlmw
         yhQt8l+jB6J2+Q4mBW1zIR8AdecT02FZYwsyxw/wDV1bfn/r3PlC0W0QI0XOMK0nh3uq
         SaswAESNfrahm+MVvzj67Lh7E9XIfSP4O2hlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702415362; x=1703020162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4klJ8l6fLfAZKVWPgko1830CXSL6+WluuhkBtOdryM=;
        b=XjaPFxw6kM5FXIoNPYOzcpHmmtyfeYI6isgtJTn925ZAYo/GUqBUTDHF7ntSpKdoPa
         WTY1eZGAGbNbnWIXfMz+2Vs8xIeAtXe7tjHDzqWC9aBBHI4Q9HYmw5WbLZEN+wRF3Rt0
         aSW4ewwXPXiv4C4+eUWBlZDI3aPTBVUjLkXbB7Rs3ssU+qFhctHZK3VT0MpyC8zEcGdj
         CocdIfdwCN1MPwK7tHxMyV3sBNynxmPO76gXCX7JBSDszbqbuY5JOLsRcCrU2VtM1p3s
         RiXV4ZHlTtt7Hi1R/iOD3x7oeptMSKyLXBobg+abbzXzMWpYBOD4CiSVYIkKmoVKJ7nP
         UGVw==
X-Gm-Message-State: AOJu0Yw3GGAHtJdUKi96jkqXrG2Edolg7Yv9ivxtjtHCfGc0ClNQr/rP
        DES2V9L9/AduMbaNiiZL9Mostg==
X-Google-Smtp-Source: AGHT+IHtd7FszDMGirD1ZPy4kL3dQAz8QrpOLMzWyFxONZj+kxreJ+VdZCKjnt0WLVGQPyhmEcczVA==
X-Received: by 2002:a17:903:2446:b0:1d0:6ffd:6e6b with SMTP id l6-20020a170903244600b001d06ffd6e6bmr4102435pls.99.1702415362621;
        Tue, 12 Dec 2023 13:09:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b001d347a98e7asm114457plh.260.2023.12.12.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:09:22 -0800 (PST)
Date:   Tue, 12 Dec 2023 13:09:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3] ELF: AT_PAGE_SHIFT_MASK -- supply userspace with
 available page shifts
Message-ID: <202312121307.D6605DCD@keescook>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <8582f7c9-b49d-4d21-8948-59d580e5317c@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8582f7c9-b49d-4d21-8948-59d580e5317c@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:44:33PM +0300, Alexey Dobriyan wrote:
> Report available page shifts in arch independent manner, so that
> userspace developers won't have to parse /proc/cpuinfo hunting
> for arch specific strings.
> 
> Main users are supposed to be libhugetlbfs-like libraries which try
> to abstract huge mappings across multiple architectures. Regular code
> which queries hugepage support before using them benefits too because
> it doesn't have to deal with descriptors and parsing sysfs hierarchies
> while enjoying the simplicity and speed of getauxval(AT_PAGE_SHIFT_MASK).
> 
> Note!
> 
> This is strictly for userspace, if some page size is shutdown due
> to kernel command line option or CPU bug workaround, than it must
> not be reported in aux vector!
> 
> x86_64 machine with 1 GiB pages:
> 
> 	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
> 	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00
> 
> x86_64 machine with 2 MiB pages only:
> 
> 	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
> 	00000040  1d 00 00 00 00 00 00 00  00 10 20 00 00 00 00 00
> 
> AT_PAGESZ always reports one smallest page size which is not interesting.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
> 	v3: better comment and changelog
> 	v2: switch to page shifts, rename to ARCH_AT_PAGE_SHIFT_MASK
> 
>  arch/x86/include/asm/elf.h  |   12 ++++++++++++
>  fs/binfmt_elf.c             |    3 +++
>  include/uapi/linux/auxvec.h |   13 +++++++++++++
>  3 files changed, 28 insertions(+)
> 
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -358,6 +358,18 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
>  
>  #define COMPAT_ELF_ET_DYN_BASE	(TASK_UNMAPPED_BASE + 0x1000000)
>  
> +#define ARCH_AT_PAGE_SHIFT_MASK					\
> +	do {							\
> +		u32 val = 1 << 12;				\
> +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> +			val |= 1 << 21;				\
> +		}						\
> +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> +			val |= 1 << 30;				\
> +		}						\
> +		NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, val);		\
> +	} while (0)
> +
>  #endif /* !CONFIG_X86_32 */
>  
>  #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)

If I can get an Ack from x86 maintainers for this, I can carry it in my
execve tree.

Thanks for the updates to the commit log and comments, it reads better
now.

-Kees

> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -240,6 +240,9 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  #endif
>  	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
>  	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
> +#ifdef ARCH_AT_PAGE_SHIFT_MASK
> +	ARCH_AT_PAGE_SHIFT_MASK;
> +#endif
>  	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
>  	NEW_AUX_ENT(AT_PHDR, phdr_addr);
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
> --- a/include/uapi/linux/auxvec.h
> +++ b/include/uapi/linux/auxvec.h
> @@ -33,6 +33,19 @@
>  #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
>  #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
>  
> +/*
> + * All page sizes supported by CPU encoded as bitmask.
> + *
> + * Example: x86_64 system with pse, pdpe1gb /proc/cpuinfo flags
> + * reports 4 KiB, 2 MiB and 1 GiB page support.
> + *
> + *	$ LD_SHOW_AUXV=1 $(which true) | grep -e AT_PAGE_SHIFT_MASK
> + *	AT_PAGE_SHIFT_MASK: 0x40201000
> + *
> + * For 2^64 hugepage support please contact your Universe sales representative.
> + */
> +#define AT_PAGE_SHIFT_MASK	29
> +
>  #define AT_EXECFN  31	/* filename of program */
>  
>  #ifndef AT_MINSIGSTKSZ

-- 
Kees Cook
