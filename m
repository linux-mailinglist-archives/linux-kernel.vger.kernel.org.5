Return-Path: <linux-kernel+bounces-105256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8E87DB1F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5761F22174
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706A91BDCE;
	Sat, 16 Mar 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="absq+SH9"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937071C680
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710611066; cv=none; b=pvLXSiPVZEfW4ZlJvEavtfF5juYJqyFXgSGbyWjWXWipAQTvcjQRTT8NzPTxcJztuTLZpWKkmIXScBHopvVL82zMEsjjPMAjWNJf+j914OS+jy3Uv06L2oShaG3jEh4M0NAZ+pa5HzitTTojGe0dOunwCBLT3Q7sEXLoRaP7yE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710611066; c=relaxed/simple;
	bh=H0cz6CbTCRWe/XVyXnCi7+W3j/Eyr6osz1fH2TCeaV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEBYRyTjSNvKAcqzRXbpRNM6TwVUhtmEigwxUsiMJGrADlSkfg3TswklrbcbHNO5K/roN6+Fec+fFNjh2TW6IwYadrW6qSMv0hxUKeG8TV1G1sxZVB8dZD1PIQRAD9DoOf9sJaW6sR7j/wtQSHiKM/WigYSmkSq3ALnRojHdRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=absq+SH9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso4174058a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710611063; x=1711215863; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlOPx4bh6miYqFelxPoKy1dJ+yYpc/SaiWQnZS5iwG0=;
        b=absq+SH9s9zpQFn7MuuVVbbBQknK8WpMloROGFoJ4UWuEx7j38WOrjn33bP98KAahs
         2jh4yDRpkoJEaiWPlXw0cwL0fTvmwMYrFCuqMsin/lVTdUtTSrrfZe3HRMPIST8UVZCG
         VzcPLT/DIu4Te15wRurugnWscQ8Xd/vfglVPGOisGldr4B0fMlVZQ2pr+d/SwJLITrcY
         RlEOnxyUz8RG+94Uo3gbFpSk35e1JbBZXIO/MqfoIV/xzD7coom16gy61tTXOG5LgGDU
         hQRt2+kbICd/GagyFoLhW32PAqKegKH2WHbaioYcQ83irdEiWtv9amC1xDSpSdNZ4bnq
         hleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710611063; x=1711215863;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rlOPx4bh6miYqFelxPoKy1dJ+yYpc/SaiWQnZS5iwG0=;
        b=istSiPaS5D30+ABVGW4HQLcVP3J1CI/e0bty8SwOJ1JalBYOWoCBfKdplPmAty70In
         AAJe3tIeC0T4WJyItfc6eH3olBsPttyKu16OR5NXp0U5evnDBDt3B+7UPH0KcPF3VxnR
         4KREMgnJ0vnLJtgpnuzm2aOedhQb2VuIytYNWNvNeLYIZsjRcFx46mzRiv1tT/98bFEw
         96NiSfXWeJo1/F9mL2N1hhrrztUGL4u9sU2NcZPvoTc3A0c+mOVVxR4spJ6AD3cB2Vf8
         J3nPJYcJNTRF+DgQa2K9vz8jvHy4AIx992kekMCLf/pOTRQM73DI/Q8DFtnmgyaSDDu5
         8jgA==
X-Forwarded-Encrypted: i=1; AJvYcCVl2ORnenPoasBNoegw2KMIvAW1/suQrab/pPIrXmDdqqd7QcbwZbh9LUo8wtUl4OfpjBIw1jkXdUYaiqb4Ffo618oY4hkY09mBwhSi
X-Gm-Message-State: AOJu0YziA4s0qCjr4TIa9uei7msKwkeIxYDunotZGn9D3/q9LUAqm+Sa
	3wezHVk8dxqKznZxM39UlqH9GhmjM3klCM2wSXHHCKyXa+5HC4rr
X-Google-Smtp-Source: AGHT+IE/6UuvgH4S2ZUOEEQHu0TwBcXQ9GqV+a20Y9NTcoCYfBi/uw9msjT8cK7E3IDSxPWmU3uY/w==
X-Received: by 2002:a05:6402:2486:b0:566:4dc1:522c with SMTP id q6-20020a056402248600b005664dc1522cmr6122074eda.15.1710611062549;
        Sat, 16 Mar 2024 10:44:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id cn25-20020a0564020cb900b00568c3a2f4f8sm604630edb.74.2024.03.16.10.44.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2024 10:44:21 -0700 (PDT)
Date: Sat, 16 Mar 2024 17:44:21 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with
 LOAD_PHYSICAL_ADDR
Message-ID: <20240316174421.qopi246lswetcrss@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
 <20240313075839.8321-3-richard.weiyang@gmail.com>
 <ZfF/ekjP9R91dw2j@gmail.com>
 <20240314032320.iug2hvzyblychanu@master>
 <ZfLCoZXQ4kp2TeB+@gmail.com>
 <20240315005737.yxisrooskigl4zef@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315005737.yxisrooskigl4zef@master>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Mar 15, 2024 at 12:57:37AM +0000, Wei Yang wrote:
>On Thu, Mar 14, 2024 at 10:25:53AM +0100, Ingo Molnar wrote:
>>
>>* Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>>> On Wed, Mar 13, 2024 at 11:29:33AM +0100, Ingo Molnar wrote:
>>> >
>>> >* Wei Yang <richard.weiyang@gmail.com> wrote:
>>> >
>>> >> Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
>>> >> CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
>>> >> LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
>>> >> which is only used to define __START_KERNEL.
>>> >> 
>>> >> Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
>>> >> <asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
>>> >> <asm/page_types.h>.
>>> >> 
>>> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> >> ---
>>> >>  arch/x86/include/asm/boot.h       | 5 -----
>>> >>  arch/x86/include/asm/page_types.h | 8 +++++---
>>> >>  2 files changed, 5 insertions(+), 8 deletions(-)
>>> >> 
>>> >> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
>>> >> index a38cc0afc90a..12cbc57d0128 100644
>>> >> --- a/arch/x86/include/asm/boot.h
>>> >> +++ b/arch/x86/include/asm/boot.h
>>> >> @@ -6,11 +6,6 @@
>>> >>  #include <asm/pgtable_types.h>
>>> >>  #include <uapi/asm/boot.h>
>>> >>  
>>> >> -/* Physical address where kernel should be loaded. */
>>> >> -#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>>> >> -				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>>> >> -				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>>> >> -
>>> >>  /* Minimum kernel alignment, as a power of two */
>>> >>  #ifdef CONFIG_X86_64
>>> >>  # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
>>> >> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
>>> >> index 86bd4311daf8..acc1620fd121 100644
>>> >> --- a/arch/x86/include/asm/page_types.h
>>> >> +++ b/arch/x86/include/asm/page_types.h
>>> >> @@ -31,10 +31,12 @@
>>> >>  
>>> >>  #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
>>> >>  
>>> >> -#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
>>> >> -				      CONFIG_PHYSICAL_ALIGN)
>>> >> +/* Physical address where kernel should be loaded. */
>>> >> +#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>>> >> +				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>>> >> +				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>>> >
>>> >I agree with this simplification, but the ALIGN() expression is far easier 
>>> >to read, so please keep that one instead of the open-coded version.
>>> >
>>> 
>>> I just tried to define LOAD_PHYSICAL_ADDR by ALIGN, but face a compile error
>>> on compressed/head_[32|64].o.
>>> 
>>> $ make arch/x86/boot/compressed/head_64.o
>>>   CALL    scripts/checksyscalls.sh
>>>   DESCEND objtool
>>>   INSTALL libsubcmd_headers
>>>   AS      arch/x86/boot/compressed/head_64.o
>>> arch/x86/boot/compressed/head_64.S: Assembler messages:
>>> arch/x86/boot/compressed/head_64.S:154: Error: junk (0x1000000,0x200000)' after expression
>>> arch/x86/boot/compressed/head_64.S:154: Error: number of operands mismatch for 16' after expression
>>> arch/x86/boot/compressed/head_64.S:157: Error: junk mov'
>>> arch/x86/boot/compressed/head_64.S:330: Error: junk (0x1000000,0x200000)' after expression
>>> arch/x86/boot/compressed/head_64.S:330: Error: number of operands mismatch for 16' after expression
>>> arch/x86/boot/compressed/head_64.S:333: Error: junk movq'
>>> 
>>> If my understanding is correct, the reason is linkage.h defines ALIGN, which
>>> is ".balign xxx". Maybe this is why original LOAD_PHYSICAL_ADDR doesn't use
>>> ALIGN.
>>
>>linkage.h defines __ALIGN, which is different from ALIGN().
>>
>
>linkage.h defines ALIGN to __ALIGN which is different from what we expect.
>
>>Also, a number of .S files seem to be using some sort of ALIGN() method 
>>within arch/x86/, according to:
>>
>>   git grep 'ALIGN(' -- 'arch/x86/*.S'
>
>I tried below command by append '\<' to ALIGN 
>
>    git grep '\<ALIGN(' -- 'arch/x86/*.S'
>
>>
>>> So is this ok to keep the open-coded definition?
>>
>>It would be nice to figure out why ALIGN() appears to be working in other 
>>cases in .S files, while not in this case.
>>
>
>Here is grep result
>
>arch/x86/boot/compressed/vmlinux.lds.S:	.data :	ALIGN(0x1000) {
>arch/x86/boot/compressed/vmlinux.lds.S:		. = ALIGN(. + 4, 0x200);
>arch/x86/boot/compressed/vmlinux.lds.S:	. = ALIGN(L1_CACHE_BYTES);
>arch/x86/boot/compressed/vmlinux.lds.S:		. = ALIGN(8);	/* For convenience during zeroing */
>arch/x86/boot/compressed/vmlinux.lds.S:       . = ALIGN(PAGE_SIZE);
>arch/x86/boot/compressed/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>arch/x86/kernel/vmlinux.lds.S:#define X86_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(HPAGE_SIZE);				\
>arch/x86/kernel/vmlinux.lds.S:#define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
>arch/x86/kernel/vmlinux.lds.S:#define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PMD_SIZE);					\
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);					\
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PMD_SIZE);					\
>arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(PAGE_SIZE);				\
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(8);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
>arch/x86/kernel/vmlinux.lds.S:	. = ALIGN(HPAGE_SIZE);
>arch/x86/kernel/vmlinux.lds.S:		. = ALIGN(HPAGE_SIZE);
>arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(4);
>arch/x86/realmode/rm/realmode.lds.S:		. = ALIGN(16);
>arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(PAGE_SIZE);
>arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(128);
>arch/x86/realmode/rm/realmode.lds.S:	. = ALIGN(4);
>arch/x86/um/vdso/vdso-layout.lds.S:	. = ALIGN(0x100);
>
>It looks all happens in link script, not assembly source code.
>
>And other grep result with "ALIGN" are:
>
>    SYM_CODE_START_NOALIGN
>    SYM_CODE_START_LOCAL_NOALIGN
>    SYM_FUNC_START_NOALIGN
>    SYM_FUNC_START_LOCAL_NOALIGN
>    SYM_INNER_LABEL_ALIGN
>
>which are defined in linkage.h.
>

Hi, Ingo

Take another look into the usage.

In linkage.h, we have following definition:

    #ifdef __ASSEMBLY__
    
    #ifndef LINKER_SCRIPT
    #define ALIGN __ALIGN
    #endif
    
    #endif

We would include linkage.h from .S and .lds.S. We both define __ASSEMBLY__ in
command line when building these target, but we would define LINKER_SCRIPT
when building .lds from .lds.S. This introduces the different behavior of
ALIGN.

    * For .S, ALING is replaced by __ALIGN and then to .balign xxx
    * For .lds, ALIGN is is not expanded, which is a lds keyword

Also linkage.h may be included in .c, e.g. head64.c. But we don't define
__ASSEMBLY__ in command line, which leads the ALIGN undefined until kernel.h
is included.

>>Thanks,
>>
>>	Ingo
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

