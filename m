Return-Path: <linux-kernel+bounces-103945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA4687C6DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AA4B21F77
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183957475;
	Fri, 15 Mar 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS1QqDLE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA46FB1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464263; cv=none; b=HTBZWB+HyL2P8RjwdHdnzq93zHItmNM1K4zG9UGxG7X9K6PcIsaZ91dxFlMqCUsgOuvzxew6xUFHEVW0KMzpkctopOjFvP4P3Eg02uUgMdImbJWIgxP/R6p4CEIX07wexSep9KCAt59r/Zp0MrnEY7AXewlJiY89cLd56joJe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464263; c=relaxed/simple;
	bh=215x3v8qoP0Ks9i9qgH9FBugiHdYJHoaoU8UFZ5kF64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFb3FLmIko3PlgClcT5IlZeLYUsQ+LoCWU39GhRK3d0eWXG2SBaGNSpXfEv7zjIFyQARyiw36UocT7XPCOY5dVexFeJegjcT7At6BLv6xmSOE33iALRtAMiMjyI0GU9FGGP8AljFVCHsStCLlZznJnthJskcjtshoU+lQ8kK1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS1QqDLE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513d3746950so1433291e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710464259; x=1711069059; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l+Dk+YUYvQmQj5sLZsNLU0Ysy1WLbQTGbM3QwlVIT8=;
        b=kS1QqDLEjO6wJqGYfA56Pn9/ZRx2Xbff2uInzoA1hq74nBye2ACWudYPKGDO6Cn8GH
         LZa8UGTyR9CY576is+i8rO89LxsQaXAemDKrvkivPjPtPfCY7zxjCBpS/aa6Wg9EtSGY
         L3h7iuvfXETGC7abNJ81Lf1qRxBW3hFBSo3WDwZRFbtYSf4R0sEV0SvgJExcqfUVvaJH
         2loF2cZ/9cRAH7VY4mkiXqL5xSRAPmLBbh+sfO+zlo70tb/gYWWvE4FkCxH/0D5VnEu2
         RL2cCwkkDCr6Pn9K0A/MukSez6WVB5Lpj+1pRfVB46oeyGI6B6ugLXPtXWarvcXEmZae
         2TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710464259; x=1711069059;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1l+Dk+YUYvQmQj5sLZsNLU0Ysy1WLbQTGbM3QwlVIT8=;
        b=eapRaMDnM2QeewH3N33jXFhKEMVomvFFSmJSoEanLXyD5fUqTVWngO2d/McJ2mTIpW
         1JvDsJDE8aMnsMYYL+ZC9i0spiv4JhehCjmurFmDxKH+S8D3oqlnd4/pQ0vew2wRK+Ow
         dO+qEEXkFNH2jsDIrkpno3CM9wbJt248ONKo74StX4sv7VSb++ek0VflQZcC1WJLP6/9
         W/0to7rg+QXAel8C9XgoP4o8lKmzFIuNd/QKj0Dp6BIw6+X+34OftOWPfmG19fuyBPVB
         oOMUx0g27A2D86SB38bHyZVoQQAygruhQaonUo/4zDPYRBqydKWLxpl/V/ba48WVHW7E
         3wzA==
X-Forwarded-Encrypted: i=1; AJvYcCX6BkzQsJB1/31IY2cuDzbRBu4K+p8FID1IgiU8HeyS9L2bw/5Y4zwb5SFgfWLeWGhWEN5AKEpbEG+TEl2VXgx+CT0JwEiQ+d7Hwelm
X-Gm-Message-State: AOJu0YznLr0kpWlpCLqEnk4vzoTNRPZG62Uk2ZCMGUkXQeburC6vegJj
	fVQnvHYzOetHnBf4zaq8Qj8/Il43LSI8+K/FL27dNE/0keMklk1u
X-Google-Smtp-Source: AGHT+IHAKKbQMyzmZ9hfvUEhs5jCagOylVPdifyxV1v4fz5xj6k1b1rk63iZ1z+Qjo+y4bETiR9XLg==
X-Received: by 2002:a05:6512:5d6:b0:513:2c56:f5e2 with SMTP id o22-20020a05651205d600b005132c56f5e2mr1196150lfo.60.1710464258928;
        Thu, 14 Mar 2024 17:57:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h9-20020a170906110900b00a4665cd5664sm1170400eja.119.2024.03.14.17.57.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2024 17:57:38 -0700 (PDT)
Date: Fri, 15 Mar 2024 00:57:37 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with
 LOAD_PHYSICAL_ADDR
Message-ID: <20240315005737.yxisrooskigl4zef@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
 <20240313075839.8321-3-richard.weiyang@gmail.com>
 <ZfF/ekjP9R91dw2j@gmail.com>
 <20240314032320.iug2hvzyblychanu@master>
 <ZfLCoZXQ4kp2TeB+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfLCoZXQ4kp2TeB+@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Mar 14, 2024 at 10:25:53AM +0100, Ingo Molnar wrote:
>
>* Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> On Wed, Mar 13, 2024 at 11:29:33AM +0100, Ingo Molnar wrote:
>> >
>> >* Wei Yang <richard.weiyang@gmail.com> wrote:
>> >
>> >> Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
>> >> CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
>> >> LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
>> >> which is only used to define __START_KERNEL.
>> >> 
>> >> Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
>> >> <asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
>> >> <asm/page_types.h>.
>> >> 
>> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >> ---
>> >>  arch/x86/include/asm/boot.h       | 5 -----
>> >>  arch/x86/include/asm/page_types.h | 8 +++++---
>> >>  2 files changed, 5 insertions(+), 8 deletions(-)
>> >> 
>> >> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
>> >> index a38cc0afc90a..12cbc57d0128 100644
>> >> --- a/arch/x86/include/asm/boot.h
>> >> +++ b/arch/x86/include/asm/boot.h
>> >> @@ -6,11 +6,6 @@
>> >>  #include <asm/pgtable_types.h>
>> >>  #include <uapi/asm/boot.h>
>> >>  
>> >> -/* Physical address where kernel should be loaded. */
>> >> -#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>> >> -				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>> >> -				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>> >> -
>> >>  /* Minimum kernel alignment, as a power of two */
>> >>  #ifdef CONFIG_X86_64
>> >>  # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
>> >> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
>> >> index 86bd4311daf8..acc1620fd121 100644
>> >> --- a/arch/x86/include/asm/page_types.h
>> >> +++ b/arch/x86/include/asm/page_types.h
>> >> @@ -31,10 +31,12 @@
>> >>  
>> >>  #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
>> >>  
>> >> -#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
>> >> -				      CONFIG_PHYSICAL_ALIGN)
>> >> +/* Physical address where kernel should be loaded. */
>> >> +#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>> >> +				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>> >> +				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>> >
>> >I agree with this simplification, but the ALIGN() expression is far easier 
>> >to read, so please keep that one instead of the open-coded version.
>> >
>> 
>> I just tried to define LOAD_PHYSICAL_ADDR by ALIGN, but face a compile error
>> on compressed/head_[32|64].o.
>> 
>> $ make arch/x86/boot/compressed/head_64.o
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND objtool
>>   INSTALL libsubcmd_headers
>>   AS      arch/x86/boot/compressed/head_64.o
>> arch/x86/boot/compressed/head_64.S: Assembler messages:
>> arch/x86/boot/compressed/head_64.S:154: Error: junk (0x1000000,0x200000)' after expression
>> arch/x86/boot/compressed/head_64.S:154: Error: number of operands mismatch for 16' after expression
>> arch/x86/boot/compressed/head_64.S:157: Error: junk mov'
>> arch/x86/boot/compressed/head_64.S:330: Error: junk (0x1000000,0x200000)' after expression
>> arch/x86/boot/compressed/head_64.S:330: Error: number of operands mismatch for 16' after expression
>> arch/x86/boot/compressed/head_64.S:333: Error: junk movq'
>> 
>> If my understanding is correct, the reason is linkage.h defines ALIGN, which
>> is ".balign xxx". Maybe this is why original LOAD_PHYSICAL_ADDR doesn't use
>> ALIGN.
>
>linkage.h defines __ALIGN, which is different from ALIGN().
>

linkage.h defines ALIGN to __ALIGN which is different from what we expect.

>Also, a number of .S files seem to be using some sort of ALIGN() method 
>within arch/x86/, according to:
>
>   git grep 'ALIGN(' -- 'arch/x86/*.S'

I tried below command by append '\<' to ALIGN 

    git grep '\<ALIGN(' -- 'arch/x86/*.S'

>
>> So is this ok to keep the open-coded definition?
>
>It would be nice to figure out why ALIGN() appears to be working in other 
>cases in .S files, while not in this case.
>

Here is grep result

arch/x86/boot/compressed/vmlinux.lds.S:	.data :	ALIGN(0x1000) {
arch/x86/boot/compressed/vmlinux.lds.S:		. = ALIGN(. + 4, 0x200);
arch/x86/boot/compressed/vmlinux.lds.S:	. = ALIGN(L1_CACHE_BYTES);
arch/x86/boot/compressed/vmlinux.lds.S:		. = ALIGN(8);	/* For convenience during zeroing */
arch/x86/boot/compressed/vmlinux.lds.S:       . = ALIGN(PAGE_SIZE);
arch/x86/boot/compressed/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
arch/x86/kernel/vmlinux.lds.S:#define X86_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(HPAGE_SIZE);				\
arch/x86/kernel/vmlinux.lds.S:#define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
arch/x86/kernel/vmlinux.lds.S:#define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PMD_SIZE);					\
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);					\
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PMD_SIZE);					\
arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(PAGE_SIZE);				\
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(HPAGE_SIZE);
arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(HPAGE_SIZE);
arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(4);
arch/x86/realmode/rm/realmode.lds.S:		. = ALIGN(16);
arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(PAGE_SIZE);
arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(128);
arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(4);
arch/x86/um/vdso/vdso-layout.lds.S:	. = ALIGN(0x100);

It looks all happens in link script, not assembly source code.

And other grep result with "ALIGN" are:

    SYM_CODE_START_NOALIGN
    SYM_CODE_START_LOCAL_NOALIGN
    SYM_FUNC_START_NOALIGN
    SYM_FUNC_START_LOCAL_NOALIGN
    SYM_INNER_LABEL_ALIGN

which are defined in linkage.h.

>Thanks,
>
>	Ingo

-- 
Wei Yang
Help you, Help me

