Return-Path: <linux-kernel+bounces-31027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC61E8327BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D80D1F238EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2274C3BB;
	Fri, 19 Jan 2024 10:35:51 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B733EA60
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660550; cv=none; b=RWm6Hvbko0qAgTsmRBzsptC/0HBDwe7EkDdz41P+IZVR1rVsNf19eAPaVVzzWJuDTwizUasbUu+EacoyuSvKis40Wq90ibsEqHOyiIInJtAAY4eOBhrranqpT8u2oekuc2jGEQVD2dR+a3iaQTYVGXHH1xKpn2wnbxYBOc7J9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660550; c=relaxed/simple;
	bh=3dEAuadRtgX48I3fDLt441/VU2N0O2dLDz2qBeYEnCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DViKmUXVEPymRn7+9lFewFU85tJiaUipA4tW4o7Q+0HR97XaRsjtk6WettTkHeuX0deoc0xsUWvK/SA/KelxNmCpWo94vLoYQipg/MngV6jd0tBYWCqoGC/ZppkmnMtNDjzSNZif9sW4zgVXWLKyzuPXf3JwPCvZ7wIkrXM8GOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp64t1705660495t7k8890j
X-QQ-Originating-IP: kpWPaONTxxvy0nOEGrSxFq1akJ6vzcOttZF/rCEqrtY=
Received: from [10.4.6.71] ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Jan 2024 18:34:53 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: 4g9JbZ7lBbGYt5f2YVZ9RuBGDo2jTI9EeLQs3oNfXqrhUBaFQVqPrhhoJcJJ1
	ER1ylXifWxfMxWYKz9hF5gfbKgCzQ4idJ6F796Sg96DfHuVwv6g7okYYi+PY3MIUefL3ny+
	9RHZi5hZRA3pQ/GN1g7yOts83rk0lLNGwQMVhKkRNRAAARFiGtrC/24H5K8R8svRDKZcU10
	60uwPXeAVoOu4bWiDTqdS4/vhXc3/BybQJS4emGBRbiEHPceo8mF7NA/ytodyM6SwDBCTQ9
	phIiAS+OsjWTH1x2HC8xkpPzQhxfIgWnZYWy/koKv5dNXFm4dLt/0+6/RetUr2EiktDPY9B
	06RYMgpZgJFMo3G9OEqFKKLURyFZoOmUKETKrCv78KYYkQ1GGI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9538942234933522215
Message-ID: <231AC634A34EBAF4+1a989394-a60f-4088-86ee-fe1344e7999f@tinylab.org>
Date: Fri, 19 Jan 2024 18:34:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V2] riscv: Support RANDOMIZE_KSTACK_OFFSET
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 keescook@chromium.org, guoren@kernel.org, bjorn@rivosinc.com,
 jszhang@kernel.org, conor.dooley@microchip.com, andy.chiu@sifive.com,
 samitolvanen@google.com, coelacanthushex@gmail.com, dlemoal@kernel.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
References: <20231109133751.212079-1-songshuaishuai@tinylab.org>
From: Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <20231109133751.212079-1-songshuaishuai@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-2


Hi, palmer:

在 2023/11/9 21:37, Song Shuai 写道:
> Inspired from arm64's implement -- commit 70918779aec9
> ("arm64: entry: Enable random_kstack_offset support")
> 
> Add support of kernel stack offset randomization while handling syscall,
> the offset is defaultly limited by KSTACK_OFFSET_MAX() (i.e. 10 bits).
> 
> In order to avoid trigger stack canaries (due to __builtin_alloca) and
> slowing down the entry path, use __no_stack_protector attribute to
> disable stack protector for do_trap_ecall_u() at the function level.
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
Just a Reminder in case you miss this one.

> ---
> Changes since V1:
> https://lore.kernel.org/linux-riscv/20231101064423.1906122-1-songshuaishuai@tinylab.org/
> - fix whitespace errors Damien pointed out
> - add Acked-by and Reviewed-by tags
> 
> ---
>   arch/riscv/Kconfig        |  1 +
>   arch/riscv/kernel/traps.c | 17 ++++++++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6d..0e843de33f0c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -100,6 +100,7 @@ config RISCV
>   	select HAVE_ARCH_KGDB_QXFER_PKT
>   	select HAVE_ARCH_MMAP_RND_BITS if MMU
>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>   	select HAVE_ARCH_SECCOMP_FILTER
>   	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>   	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 19807c4d3805..a1a75163fb81 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -6,6 +6,7 @@
>   #include <linux/cpu.h>
>   #include <linux/kernel.h>
>   #include <linux/init.h>
> +#include <linux/randomize_kstack.h>
>   #include <linux/sched.h>
>   #include <linux/sched/debug.h>
>   #include <linux/sched/signal.h>
> @@ -296,7 +297,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>   	}
>   }
>   
> -asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
> +asmlinkage __visible __trap_section  __no_stack_protector
> +void do_trap_ecall_u(struct pt_regs *regs)
>   {
>   	if (user_mode(regs)) {
>   		long syscall = regs->a7;
> @@ -308,10 +310,23 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>   
>   		syscall = syscall_enter_from_user_mode(regs, syscall);
>   
> +		add_random_kstack_offset();
> +
>   		if (syscall >= 0 && syscall < NR_syscalls)
>   			syscall_handler(regs, syscall);
>   		else if (syscall != -1)
>   			regs->a0 = -ENOSYS;
> +		/*
> +		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> +		 * so the maximum stack offset is 1k bytes (10 bits).
> +		 *
> +		 * The actual entropy will be further reduced by the compiler when
> +		 * applying stack alignment constraints: 16-byte (i.e. 4-bit) aligned
> +		 * for RV32I or RV64I.
> +		 *
> +		 * The resulting 6 bits of entropy is seen in SP[9:4].
> +		 */
> +		choose_random_kstack_offset(get_random_u16());
>   
>   		syscall_exit_to_user_mode(regs);
>   	} else {

-- 
Thanks
Song Shuai

