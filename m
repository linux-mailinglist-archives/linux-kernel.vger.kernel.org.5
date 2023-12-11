Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7BD80C096
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjLKFOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKFOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:14:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6829D9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:14:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0966C433C8;
        Mon, 11 Dec 2023 05:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702271651;
        bh=1RaacpWnTkL7X+JkkZCzrmMSUdmiLmbVja5/lwCyjQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j1k87/K7XA8EUz7Zf98AZPRZyBK3naglI6189/lN0rxULeWuXjMdwpoAWl6KaQDu7
         3blzWA81dIIb5kC62NvxjL2YeGPGNpo134fVU1OIWCZ8wISzfCfIHLmlVGVMjdoPZG
         ypL9U5OwRcNAf1U7n98XUq7ZJFwB4M6SkzSNXqE+3pRpe0S0TGnprKad8mHpY0EmG7
         5em7IPy2y3vOan4UyOPX4/fva1R2mmdUqcqVGk1AiRcjfacx76VCU6M0WuYEAjcXh4
         T6ORZDmE3uH9ZfnxzMcYRaWZ9lpYmUfPqCmUtVmz1kaPKNOxj7IfYhmyOtAPd0VHzM
         xA7qcayxQqJ7Q==
Date:   Mon, 11 Dec 2023 14:14:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, jgross@suse.com, ravi.v.shankar@intel.com,
        mhiramat@kernel.org, andrew.cooper3@citrix.com,
        jiangshanlai@gmail.com, nik.borisov@suse.com, shan.kang@intel.com
Subject: Re: [PATCH v13 01/35] x86/cpufeatures,opcode,msr: Add the WRMSRNS
 instruction support
Message-Id: <20231211141403.09e3f2d81eb499ba44035fef@kernel.org>
In-Reply-To: <20231205105030.8698-2-xin3.li@intel.com>
References: <20231205105030.8698-1-xin3.li@intel.com>
        <20231205105030.8698-2-xin3.li@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Dec 2023 02:49:50 -0800
Xin Li <xin3.li@intel.com> wrote:

> WRMSRNS is an instruction that behaves exactly like WRMSR, with
> the only difference being that it is not a serializing instruction
> by default. Under certain conditions, WRMSRNS may replace WRMSR to
> improve performance.
> 
> Add its CPU feature bit, opcode to the x86 opcode map, and an
> always inline API __wrmsrns() to embed WRMSRNS into the code.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> 
> Changes since v12:
> * Merge the 3 WRMSRNS patches into one (Borislav Petkov).
> * s/cpu/CPU/g (Borislav Petkov).
> * Shorten the WRMSRNS description (Borislav Petkov).
> ---
>  arch/x86/include/asm/cpufeatures.h       |  1 +
>  arch/x86/include/asm/msr.h               | 18 ++++++++++++++++++
>  arch/x86/lib/x86-opcode-map.txt          |  2 +-
>  tools/arch/x86/include/asm/cpufeatures.h |  1 +
>  tools/arch/x86/lib/x86-opcode-map.txt    |  2 +-
>  5 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 149cc5d5c2ae..a903fc130e49 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -325,6 +325,7 @@
>  #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
>  #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
>  #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
> +#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
>  #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
>  #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
>  #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 65ec1965cd28..c284ff9ebe67 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -97,6 +97,19 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
>  		     : : "c" (msr), "a"(low), "d" (high) : "memory");
>  }
>  
> +/*
> + * WRMSRNS behaves exactly like WRMSR with the only difference being
> + * that it is not a serializing instruction by default.
> + */
> +static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
> +{
> +	/* Instruction opcode for WRMSRNS; supported in binutils >= 2.40. */
> +	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
> +		     "2:\n"
> +		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
> +		     : : "c" (msr), "a"(low), "d" (high));
> +}
> +
>  #define native_rdmsr(msr, val1, val2)			\
>  do {							\
>  	u64 __val = __rdmsr((msr));			\
> @@ -297,6 +310,11 @@ do {							\
>  
>  #endif	/* !CONFIG_PARAVIRT_XXL */
>  
> +static __always_inline void wrmsrns(u32 msr, u64 val)
> +{
> +	__wrmsrns(msr, val, val >> 32);
> +}
> +
>  /*
>   * 64-bit version of wrmsr_safe():
>   */
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index 5168ee0360b2..1efe1d9bf5ce 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -1051,7 +1051,7 @@ GrpTable: Grp6
>  EndTable
>  
>  GrpTable: Grp7
> -0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
> +0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
>  1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
>  2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
>  3: LIDT Ms
> diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
> index 4af140cf5719..26a73ae18a86 100644
> --- a/tools/arch/x86/include/asm/cpufeatures.h
> +++ b/tools/arch/x86/include/asm/cpufeatures.h
> @@ -322,6 +322,7 @@
>  #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
>  #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
>  #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
> +#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
>  #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
>  #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
>  #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
> diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
> index 5168ee0360b2..1efe1d9bf5ce 100644
> --- a/tools/arch/x86/lib/x86-opcode-map.txt
> +++ b/tools/arch/x86/lib/x86-opcode-map.txt
> @@ -1051,7 +1051,7 @@ GrpTable: Grp6
>  EndTable
>  
>  GrpTable: Grp7
> -0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
> +0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
>  1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
>  2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
>  3: LIDT Ms
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
