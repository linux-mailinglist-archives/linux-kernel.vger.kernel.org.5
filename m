Return-Path: <linux-kernel+bounces-154373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B909E8ADB59
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BCB283C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6228F505;
	Tue, 23 Apr 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9c6SyQV"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB802C9D;
	Tue, 23 Apr 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834001; cv=none; b=DUVkp4BKu/z2LBXKHzuF2dR/SwMpQKi048fE9lClZ92Wao0MMz7hqJyLd9xlFsm1Qlwx7VGXxf9w11gDmZpyl4MRbSWDgtWD4c2E7AA2zP6Xt3A6Ezsa0rDPbC2OG26deZcP3v5ca8/0rEqkXX6o46pyFn2KMNZXNmqAjJlUPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834001; c=relaxed/simple;
	bh=AYvl5/tKfehzEvfn1QvhwiBj1YykPAdSg/NNSJeVgdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrksmAV1spl5IwMjTnlrxvXwygk4ahVABvIM5oiwiACXQLaHjiy36Y2bst82BZorKmGflviFJnZJ9h03Xy7ujGmzLLgydD5SKIv8ergxOXIKbqGVLoK/1RxjV5IIYTMHbP+hdyYv3FQlnXCrXWA7cm2enHAWhRJFfkBHUI7CnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9c6SyQV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a587831809eso36225066b.1;
        Mon, 22 Apr 2024 17:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713833997; x=1714438797; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1S1kfWumcZcjZToCT/1OGHc7wgMisGaT5sJOxcAyC8=;
        b=G9c6SyQV4XS0YdV361BXLBpxQnZt5KcEDy4xMxmGfJzR6KbCJUWU1a2hl2Utp3weyD
         dRYGMmKn0uDLgZsms3TK0W7W50WK+R35Hv4jd5dOUqSrRnlr/8G8TYwE2e7goh7qKwl1
         T7cFxZgaSzrRcAxiY7bYSwXmqxIchDAKbW/TF/x7sgSAn8eimt2hGcxV8BiqH/LZZ4Za
         SROIk3Har3VWrgUE0v04hEQT+T6EkS/Zb4TC/bBw8R7Q4rPn+kivv/9WjoRfYsQ7w65p
         i++2f9mihojKQRf1PSUw6KK8ftth/K6bsIwv48xNUVlkmGULSmODFsPc0LvIk+3O2ULr
         UKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713833997; x=1714438797;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D1S1kfWumcZcjZToCT/1OGHc7wgMisGaT5sJOxcAyC8=;
        b=dhBDzSTZNMjB3W9tLXCUzKIG7/G6psf/GseQ5JPByyRZ4jgQ2wl8WAkmTkulrUFuhB
         Gb/ICfNFmEgSG3HOkzRSYVRc/8pteiBc96LfbvYuDPDbQzb5c7PmhBN/545xxZNOLV9M
         HZNQugI2UzGTopBu4tC4grZeftDpLWdQv0lSOcO3lB8bPHbrx9JqGM4BO+icF/jA4erc
         5hvc5MDNFma9W4+3uyjRg41AI3rBVmXhgJsbMhYbL312hGlEkiXj8Gpxi83ExTFxGaUv
         4i8wf22k8coIroBCiRkXJm58c5J3vxdAqpBODzLfyevtYJV0bI77wttJMQB8lsI5OPbQ
         xhXA==
X-Forwarded-Encrypted: i=1; AJvYcCW8F0XfZnoRsVGMMIm895t4PQDInMnIF+2V31iR+ajFGBv0H0ssws9xXBcE9JVVwO2BaBaO+Ssyg71V+HcAmbsd86jJaDfQK+YJq/md
X-Gm-Message-State: AOJu0YzwzgTPvCmQzDccLJ99GqxLEH+Ray4TbxP3nm7c1umvWXez9fSg
	9WTnNa6nPINvYR+z4sYPkh0xfnk3naRBgVZfqsqynbUUQkJ8K8LV
X-Google-Smtp-Source: AGHT+IFzpLw9nEva6OJ5kCoyLjNHFqQVWWtqBTvd+80O9kCRfoEUCH4vTUADnt3MW7IcHM/erUEZqw==
X-Received: by 2002:a17:907:6d27:b0:a58:7f5f:7ba with SMTP id sa39-20020a1709076d2700b00a587f5f07bamr54991ejc.52.1713833997367;
        Mon, 22 Apr 2024 17:59:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t21-20020a17090616d500b00a51a5c8ea6fsm6378272ejd.193.2024.04.22.17.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2024 17:59:56 -0700 (PDT)
Date: Tue, 23 Apr 2024 00:59:56 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, masahiroy@kernel.org,
	nathan@kernel.org, nicolas@fjasle.eu, peterz@infradead.org,
	jpoimboe@kernel.org, leitao@debian.org, petr.pavlu@suse.com,
	richard.weiyang@gmail.com, ruanjinjie@huawei.com,
	ndesaulniers@google.com, jgross@suse.com
Subject: Re: [PATCH] x86: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20240423005956.rxxq6zezbmw4ylkc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240422060556.1226848-1-liuyuntao12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422060556.1226848-1-liuyuntao12@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)

Hi, Yuntao

I am not that familiar with this, so got some questions below.

On Mon, Apr 22, 2024 at 06:05:56AM +0000, Yuntao Liu wrote:
>The current x86 architecture does not yet support the
>HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. x86 is widely used in
>embedded scenarios, and enabling this feature would be beneficial for
>reducing the size of the kernel image.
>
>In order to make this work, we keep the necessary tables by annotating
>them with KEEP, also it requires further changes to linker script to KEEP
>some tables and wildcard compiler generated sections into the right place.
>
>Enabling CONFIG_UNWINDER_ORC or CONFIG_MITIGATION_RETPOLINE will enable
>the objtool's --orc and --retpoline parameters, which will alter the
>layout of the binary file, thereby preventing gc-sections from functioning
>properly. Therefore, HAVE_LD_DEAD_CODE_DATA_ELIMINATION should only be
>selected when they are not enabled.
>
>Enabling CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT will use vmlinux.o
>instead of performing the slow LTO link again. This can also prevent
>gc-sections from functioning properly. Therefore, using this optimization
>when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
>
>The size comparison of zImage is as follows:
>x86_def_defconfig  i386_defconfig    tinyconfig
>10892288           10826240          607232          no dce
>10748928           10719744          529408          dce
>1.3%               0.98%             12.8%           shrink
>
>When using smaller config file, there is a significant reduction in the
>size of the zImage.
>---
> arch/x86/Kconfig              |  1 +
> arch/x86/kernel/vmlinux.lds.S | 24 ++++++++++++------------
> scripts/link-vmlinux.sh       |  2 +-
> 3 files changed, 14 insertions(+), 13 deletions(-)
>
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index a902680b6537..92dfbc8ee4e7 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -247,6 +247,7 @@ config X86
> 	select HAVE_FUNCTION_ERROR_INJECTION
> 	select HAVE_KRETPROBES
> 	select HAVE_RETHOOK
>+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !CONFIG_UNWINDER_ORC && !CONFIG_MITIGATION_RETPOLINE

How to make sure only these two config affect the function?

> 	select HAVE_LIVEPATCH			if X86_64
> 	select HAVE_MIXED_BREAKPOINTS_REGS
> 	select HAVE_MOD_ARCH_SPECIFIC
>diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>index 3509afc6a672..aeee2b9b6a6a 100644
>--- a/arch/x86/kernel/vmlinux.lds.S
>+++ b/arch/x86/kernel/vmlinux.lds.S
>@@ -253,7 +253,7 @@ SECTIONS
> 
> 	.x86_cpu_dev.init : AT(ADDR(.x86_cpu_dev.init) - LOAD_OFFSET) {
> 		__x86_cpu_dev_start = .;
>-		*(.x86_cpu_dev.init)
>+		KEEP(*(.x86_cpu_dev.init))

How you choose the sections to keep?

If my understanding is correct, keep the sections is for gc-section. Sounds we
need to keep all possible section, otherwise it would mis-behave?

> 		__x86_cpu_dev_end = .;
> 	}
> 
>@@ -261,7 +261,7 @@ SECTIONS
> 	.x86_intel_mid_dev.init : AT(ADDR(.x86_intel_mid_dev.init) - \
> 								LOAD_OFFSET) {
> 		__x86_intel_mid_dev_start = .;
>-		*(.x86_intel_mid_dev.init)
>+		KEEP(*(.x86_intel_mid_dev.init))
> 		__x86_intel_mid_dev_end = .;
> 	}
> #endif
>@@ -275,21 +275,21 @@ SECTIONS
> 	. = ALIGN(8);
> 	.retpoline_sites : AT(ADDR(.retpoline_sites) - LOAD_OFFSET) {
> 		__retpoline_sites = .;
>-		*(.retpoline_sites)
>+		KEEP(*(.retpoline_sites))
> 		__retpoline_sites_end = .;
> 	}
> 
> 	. = ALIGN(8);
> 	.return_sites : AT(ADDR(.return_sites) - LOAD_OFFSET) {
> 		__return_sites = .;
>-		*(.return_sites)
>+		KEEP(*(.return_sites))
> 		__return_sites_end = .;
> 	}
> 
> 	. = ALIGN(8);
> 	.call_sites : AT(ADDR(.call_sites) - LOAD_OFFSET) {
> 		__call_sites = .;
>-		*(.call_sites)
>+		KEEP(*(.call_sites))
> 		__call_sites_end = .;
> 	}
> #endif
>@@ -298,7 +298,7 @@ SECTIONS
> 	. = ALIGN(8);
> 	.ibt_endbr_seal : AT(ADDR(.ibt_endbr_seal) - LOAD_OFFSET) {
> 		__ibt_endbr_seal = .;
>-		*(.ibt_endbr_seal)
>+		KEEP(*(.ibt_endbr_seal))
> 		__ibt_endbr_seal_end = .;
> 	}
> #endif
>@@ -307,7 +307,7 @@ SECTIONS
> 	. = ALIGN(8);
> 	.cfi_sites : AT(ADDR(.cfi_sites) - LOAD_OFFSET) {
> 		__cfi_sites = .;
>-		*(.cfi_sites)
>+		KEEP(*(.cfi_sites))
> 		__cfi_sites_end = .;
> 	}
> #endif
>@@ -320,7 +320,7 @@ SECTIONS
> 	. = ALIGN(8);
> 	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> 		__alt_instructions = .;
>-		*(.altinstructions)
>+		KEEP(*(.altinstructions))
> 		__alt_instructions_end = .;
> 	}
> 
>@@ -330,13 +330,13 @@ SECTIONS
> 	 * get the address and the length of them to patch the kernel safely.
> 	 */
> 	.altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
>-		*(.altinstr_replacement)
>+		KEEP(*(.altinstr_replacement))
> 	}
> 
> 	. = ALIGN(8);
> 	.apicdrivers : AT(ADDR(.apicdrivers) - LOAD_OFFSET) {
> 		__apicdrivers = .;
>-		*(.apicdrivers);
>+		KEEP(*(.apicdrivers));
> 		__apicdrivers_end = .;
> 	}
> 
>@@ -406,7 +406,7 @@ SECTIONS
> 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
> 		__brk_base = .;
> 		. += 64 * 1024;		/* 64k alignment slop space */
>-		*(.bss..brk)		/* areas brk users have reserved */
>+		KEEP(*(.bss..brk))	/* areas brk users have reserved */
> 		__brk_limit = .;
> 	}
> 
>@@ -432,7 +432,7 @@ SECTIONS
> 	. = ALIGN(HPAGE_SIZE);
> 	.init.scratch : AT(ADDR(.init.scratch) - LOAD_OFFSET) {
> 		__init_scratch_begin = .;
>-		*(.init.scratch)
>+		KEEP(*(.init.scratch))
> 		. = ALIGN(HPAGE_SIZE);
> 		__init_scratch_end = .;
> 	}
>diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>index 7862a8101747..7287b5a9f17d 100755
>--- a/scripts/link-vmlinux.sh
>+++ b/scripts/link-vmlinux.sh
>@@ -60,7 +60,7 @@ vmlinux_link()
> 	# skip output file argument
> 	shift
> 
>-	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
>+	if [ is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT ] && [ ! is_enabled CONFIG_LD_DEAD_CODE_DATA_ELIMINATION ]; then
> 		# Use vmlinux.o instead of performing the slow LTO link again.
> 		objs=vmlinux.o
> 		libs=
>-- 
>2.34.1

-- 
Wei Yang
Help you, Help me

