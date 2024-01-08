Return-Path: <linux-kernel+bounces-19834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2988274E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EBD284245
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C552F8E;
	Mon,  8 Jan 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4IxSJcC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D252F67
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6da0d1d6674so2075314b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704730737; x=1705335537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6UbnHUaDEZ0tHtRuGsVaM5NXl7yr0voDbpPVjwhDrU=;
        b=a4IxSJcCt78ombwuovXESqjt6bTRf+5Bs23Wh3MTc/GdKbSc29m396BZvt4DpXwI+T
         TP6EuKHUXHlk40UEeEsSRRLDdaNgHrADgCMHmr38wiQOMCV5zSK1wpSvrdcZYSuknQbx
         J3gLzC7FDCyb+cMKuv3lnF7zaE9Vjy79rzdYgDJrGf6psiXK+/TvUSpj+C8dYiQe2um3
         09Tt64Porf8Ir4t5YIA+oqvDBNl2Thifz5JzZq78eVzhL1uNH126ClT5k+Pb/+G68thF
         Y1TJUujm9QGJnOTG0g6JSVvdS4EWJlZfigjN0T6f9K8OXYxoU/MPqNcziK+YwH2mXXIF
         lGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704730737; x=1705335537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6UbnHUaDEZ0tHtRuGsVaM5NXl7yr0voDbpPVjwhDrU=;
        b=pLFq94b9arAbmzJCVnPRh9QhN99PW4SHQutOtP8qcJkZNlLhj3wsuyElwjYGgE79Xa
         zws8Nic/a5Cxmi4o4dz1HTHWhBpPO+EfHrHNqjOO20V1RPVryWbbbuL/VAz+a7K8+6z0
         ICvLKNp1QKq4TOqzdS73pmc0t/HkGEzSbmsbabnbPFaCbFLlqdUb3Kw05KHbHfPLJx9m
         PqZ+vrPZnlmkDAz4TKelibH7xeP2kSj20IU2ou/OjTwCw3E9FG0kkxQuwsTT/kX1nsQi
         nz5LbCuks1aKWEqKXONigA3uT+EO62FJ8v1NsceqzXtZMTU/HfuBEbmu+PXy9JCn73nu
         jI6A==
X-Gm-Message-State: AOJu0YxPFerE5LWTvZhD1Y+8DtRsqJORk53v49wnE7lzTrln7GAewtUy
	mp+SZUK7xNzHN3K+CyTzrw3hXkEZhaaHlFpkMQ==
X-Google-Smtp-Source: AGHT+IGP134QxPNnVt9d/GOX48MKL/guXrbUkXwLMFPO4rBnsGNxIIFH+A5wQfHNyWP9f8dH/+7lmINTybs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a12:b0:6d9:b64f:517e with SMTP id
 p18-20020a056a000a1200b006d9b64f517emr569254pfh.2.1704730736975; Mon, 08 Jan
 2024 08:18:56 -0800 (PST)
Date: Mon, 8 Jan 2024 08:18:55 -0800
In-Reply-To: <20240107122847.27740-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240107122847.27740-1-kirill.shutemov@linux.intel.com>
Message-ID: <ZZwgbz4J_R8E1_uQ@google.com>
Subject: Re: [PATCHv2] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Jan 07, 2024, Kirill A. Shutemov wrote:
> @@ -220,6 +222,33 @@ SYM_CODE_START(trampoline_start64)
>  	lidt	tr_idt(%rip)
>  	lgdt	tr_gdt64(%rip)
>  
> +	/* Check if paging mode has to be changed */
> +	movq	%cr4, %rax
> +	xorq	tr_cr4(%rip), %rax

This is buggy, tr_cr4 is only 4 bytes.  And even if tr_cr4 were 8 bytes, the reason
why nothing showed up in testing is also why only 4 bytes need to be XOR'd: the
upper 32 bits of the result are never consumed.

> +	andq	$X86_CR4_LA57, %rax

Nit, this can be TEST instead of AND, e.g. I was looking to see if RAX was used
anywhere in the flow.  And in theory it's possible a CPU could support uop fusing
for TEST+Jcc but not AND+Jcc, cause shaving a cycle in this code is obviously
super important ;-)

And as above, testl, not testq.

> +	jnz	.L_switch_paging
> +
> +	/* Paging mode is correct proceed in 64-bit mode */
> +
> +	LOCK_AND_LOAD_REALMODE_ESP lock_rip=1
> +
> +	movw	$__KERNEL_DS, %dx
> +	movl	%edx, %ss
> +	addl	$pa_real_mode_base, %esp
> +	movl	%edx, %ds
> +	movl	%edx, %es
> +	movl	%edx, %fs
> +	movl	%edx, %gs
> +
> +	movl	$pa_trampoline_pgd, %eax
> +	movq	%rax, %cr3
> +
> +	jmpq	*tr_start(%rip)
> +.L_switch_paging:
> +	/*
> +	 * To switch between 4- and 5-level paging modes, it is necessary
> +	 * to disable paging. This must be done in the compatibility mode.
> +	 */
>  	ljmpl	*tr_compat(%rip)
>  SYM_CODE_END(trampoline_start64)
>  
> -- 
> 2.41.0
> 

