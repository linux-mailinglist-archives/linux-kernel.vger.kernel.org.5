Return-Path: <linux-kernel+bounces-39177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD9983CC12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC621C23A00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F08F135A75;
	Thu, 25 Jan 2024 19:20:09 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B6135A53
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210408; cv=none; b=LRU/9kmWbnJcIZyNvaDXzUJVghTSdwc7iHvnYl5fVHhl0baC2+m9DdC/e9pCjBf/pWzqpzan6geik/moqSmtr5nsUyN+Agj0uRW95h5BIn44A61XMotWvVUZtwFMjzxR7yCrqcYXd7dXv7/2LCXfHQukvJ8GMneXnoQVbYjApeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210408; c=relaxed/simple;
	bh=iHK+P/yjc+RliUtT4Pg2LhAkWsWAshl8zjdFQpJ0ia4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/oxzEj35qpPXvvO+KTgVnF95uJYDtQPmTX6Sb75+o2x0aSQ7WKtIygRMaAvY/x9+ByMzXSiOor4KIe73DYBAYSG/Yj/Hgfr+sVeW0EWgO6QVWh3knwX8m2CFLAF65nAyVJOIu3ddC/Y10bsuVZCXRxU2cYxWCi8HVnc9CEmgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TLVMH3KJdz9tLb;
	Thu, 25 Jan 2024 19:52:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PxrJCW9UbmCs; Thu, 25 Jan 2024 19:52:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TLVMH2KzFz9tCB;
	Thu, 25 Jan 2024 19:52:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 48AC98B775;
	Thu, 25 Jan 2024 19:52:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id eldIfBa_Yrhw; Thu, 25 Jan 2024 19:52:59 +0100 (CET)
Received: from [192.168.232.44] (unknown [192.168.232.44])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F28DE8B765;
	Thu, 25 Jan 2024 19:52:58 +0100 (CET)
Message-ID: <462d76fc-ae1d-42c4-8d84-5465f5be98d4@csgroup.eu>
Date: Thu, 25 Jan 2024 19:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/fadump: update kernel logs before fadump crash
 begins
Content-Language: fr-FR
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mpe@ellerman.id.au
Cc: mahesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 hbathini@linux.ibm.com, linuxppc-dev@ozlabs.org
References: <20200606044506.44551-1-sourabhjain@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20200606044506.44551-1-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 06/06/2020 à 06:45, Sourabh Jain a écrit :
> When we hit the fadump crash via the panic path the pstore update is
> missing. This is observed when commit 8341f2f222d7 ("sysrq: Use panic()
> to force a crash") changed the sysrq-trigger to take panic path instead
> of die path.
> 
> The PPC panic event handler addresses the system panic in two different
> ways based on the system configuration. It first allows the FADump (if
> configured) to handle the kernel panic else forwards the call to platform
> specific panic function. Now pstore update is missing only if FADump
> handles the kernel panic, the platform-specific panic function do update
> the pstore by calling panic_flush_kmsg_end function.
> 
> The simplest approach to handle this issue is to add pstore update in PPC
> panic handler before FADump handles the panic. But this leads to multiple
> pstore updates in case FADump is not configured and platform-specific
> panic function serves the kernel panic.
> 
> Hence the function panic_flush_kmsg_end (used by the platform-specific
> panic function to update the kernel logs) is split into two functions, one
> will update the pstore (called in ppc panic event handler) and others will
> flush the kmsg on the console (called in platform specific panic function).

Is this patch still relevant ?

It is still awaiting in patchwork and I see it has produced sparse 
warnings 
(https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200606044506.44551-1-sourabhjain@linux.ibm.com/)

In addition, it doesn't apply anymore so I'll discard it. Please 
re-submit if still needed.

Christophe



> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/bug.h         |  2 ++
>   arch/powerpc/kernel/setup-common.c     |  1 +
>   arch/powerpc/kernel/traps.c            | 12 +++++++++++-
>   arch/powerpc/platforms/ps3/setup.c     |  2 +-
>   arch/powerpc/platforms/pseries/setup.c |  2 +-
>   5 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index 338f36cd9934..9268551a69bc 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -118,6 +118,8 @@ extern void _exception_pkey(struct pt_regs *, unsigned long, int);
>   extern void die(const char *, struct pt_regs *, long);
>   extern bool die_will_crash(void);
>   extern void panic_flush_kmsg_start(void);
> +extern void panic_flush_kmsg_dump(void);
> +extern void panic_flush_kmsg_console(void);
>   extern void panic_flush_kmsg_end(void);
>   #endif /* !__ASSEMBLY__ */
>   
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 7f8c890360fe..2d546a9e8bb1 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -699,6 +699,7 @@ static int ppc_panic_event(struct notifier_block *this,
>   	 * want interrupts to be hard disabled.
>   	 */
>   	hard_irq_disable();
> +	panic_flush_kmsg_dump();
>   
>   	/*
>   	 * If firmware-assisted dump has been registered then trigger
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 82a3438300fd..bb6bc19992b3 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -169,15 +169,25 @@ extern void panic_flush_kmsg_start(void)
>   	bust_spinlocks(1);
>   }
>   
> -extern void panic_flush_kmsg_end(void)
> +extern void panic_flush_kmsg_dump(void)
>   {
>   	printk_safe_flush_on_panic();
>   	kmsg_dump(KMSG_DUMP_PANIC);
> +}
> +
> +extern void panic_flush_kmsg_console(void)
> +{
>   	bust_spinlocks(0);
>   	debug_locks_off();
>   	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>   }
>   
> +extern void panic_flush_kmsg_end(void)
> +{
> +	panic_flush_kmsg_dump();
> +	panic_flush_kmsg_console();
> +}
> +
>   static unsigned long oops_begin(struct pt_regs *regs)
>   {
>   	int cpu;
> diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
> index b29368931c56..f96ba34284a1 100644
> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -101,7 +101,7 @@ static void ps3_panic(char *str)
>   	printk("   System does not reboot automatically.\n");
>   	printk("   Please press POWER button.\n");
>   	printk("\n");
> -	panic_flush_kmsg_end();
> +	panic_flush_kmsg_console();
>   
>   	while(1)
>   		lv1_pause(1);
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 0c8421dd01ab..66ecb88c4b8e 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -788,7 +788,7 @@ static void __init pSeries_setup_arch(void)
>   
>   static void pseries_panic(char *str)
>   {
> -	panic_flush_kmsg_end();
> +	panic_flush_kmsg_console();
>   	rtas_os_term(str);
>   }
>   

