Return-Path: <linux-kernel+bounces-103615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49E87C1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56401282D01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E92745E1;
	Thu, 14 Mar 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="SYG6U/af"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BD74434
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436536; cv=none; b=eV39Rw9ykTqzuoQ1Vf3KNseCDZiXwajozr5LVxYm5VHUQtYoN43cP48q2Pn+Ax1gybD+jCemUpnFxCAssciuCpoGDRMXTmLKqLXxJFccRNXhYJipAly7Ob6cwwC8CBPB+VdcxZVAObLnG++4y4OoRVaYKLIesaMEW/36emlPxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436536; c=relaxed/simple;
	bh=twfwIwv/zv/IkYMneJKoVYs7yj75wWjU7/p/yYsLBHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCHc7V1FBou5+2fNaWPp1PO8ODmiJjjH5QHoivGNN5sAOOYYrEJOEy1UwHsxvEIHBnSGZI0TFTWQZMwfR1XZxsnJmtd9Xwueitv4QRzsWCtOdTOFSt49pCcpgPUg+rOYAqkDF1c0I/lJDa4YYBVJZeAqbtSW1zSmV3d7v2Ou4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=SYG6U/af; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43095d80832so5051721cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710436534; x=1711041334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9B4CXRFsjej7KTIynVIuz7r6GJvXz0ei6DUmelRAZHg=;
        b=SYG6U/afZC9nupoYqohQh++izfwcWhZlf2XzYuHm5bBOeytWhgPhjH3eTykjubeKET
         PoVFIAiz1Ic4nCqT8y3OEnZRYjEMnWmwFmJmVp/ha0huRGktcQ8tURtpd7hrOpU2g8Ti
         u7uwqxG4/S5TBaOizqYWg2OyZNG6eB7R/ZyeQvmQDwMCLD0eA+hW+XOeuyN3AXmAuiny
         /smMZKwAxRVw+7qp1deiwSMDo6U88xzv4BotVOA0nQWQcQnjhIBDgv9EeIeQcpK1bCI9
         yoKapOtF9trraaR0YcOqqfLxQ+5CchWHX8Ni16sa3qEBktmAsUDq7N2bDfHUNcUEhJi8
         fY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436534; x=1711041334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9B4CXRFsjej7KTIynVIuz7r6GJvXz0ei6DUmelRAZHg=;
        b=n9UrmMwWCD5/bDi7r5diP0Pfws+XwJu6Ho9S9kuPKZ1nq973QcaSOPYlYXIvYdZfVI
         QPGzfCxwmJwT62VoMxgzuIsO2e8SezcQmOm442imZdjG273P6l9+c6ZGvcIRbiIqwryd
         3jKmJltuL1fH/NEWjNlqlgLMLh0DGD5VZd1rG5WXaKbOvLaArDWyTePpSWD+E7ygowE8
         BytZuv9P03ACMfSc/InUM8IyDN7i5Bik5F3CzyujONVspkHKW5hMaQgDWH9hA7Lkq+en
         5LvJjCuQVJaX0OWhSJm1yCcutHZJN9/c03KdPWG1YpMMsWatQHpEykTlM478H6ag18Jk
         kvZQ==
X-Gm-Message-State: AOJu0Yxbc1dG4w50i8yMdnLddyAg4X/TCUjEtVKrGqLfq9pPiQ2zyAWd
	LEtdeG/XnZYho/1dXW7/BdEForGSDaiRRbN36IvKKBNNb7bYHmACDsZlexx/rtX/1yiCRIBg7aI
	Du8qyWQMW7UI0/QRiWVMppgOPnGaLkk4SVOfjVQ==
X-Google-Smtp-Source: AGHT+IFcsQ5Nlg5NEiqBm3DwbkibUkhYMw9DyW8AcuUZ2SO3yMvSThREoaam/CVmQhCQlWZCaZqK8GR5uh9TcgEMS+I=
X-Received: by 2002:ac8:5a0b:0:b0:42f:3093:b4bf with SMTP id
 n11-20020ac85a0b000000b0042f3093b4bfmr2576867qta.37.1710436533416; Thu, 14
 Mar 2024 10:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-9-pasha.tatashin@soleen.com> <CAEr6+EDfGyJG3481RUWTamGiG2aNPDWjqSGRJaKGova-Yj8SUw@mail.gmail.com>
In-Reply-To: <CAEr6+EDfGyJG3481RUWTamGiG2aNPDWjqSGRJaKGova-Yj8SUw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Mar 2024 13:14:56 -0400
Message-ID: <CA+CK2bBZAVc8p04WAZy6yL5dZQuFqj89mGq3V4oxwLQ7Urc5Sw@mail.gmail.com>
Subject: Re: [RFC 08/14] fork: separate vmap stack alloction and free calls
To: Jeff Xie <xiehuan09@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

> I've discovered that the function free_vmap_stack() can trigger a warning.
> It appears that free_vmap_stack() should handle interrupt context and
> task context separately as vfree().

Hi Jeff,

Thank you for reporting this. Yes, it appears free_vmap_stack() may
get called from the interrupt context, and yet we call
remove_vm_area() that takes locks. I will fix it in the next version
similar to the way you suggested by adding an in_interrupt() case.

Thank you,
Pasha

> [root@JeffXie ]# poweroff
> [root@JeffXie ]# umount: devtmpfs busy - remounted read-only
> [   93.036872] EXT4-fs (vda): re-mounted
> 2e1f057b-471f-4c08-a7b8-611457b221f2 ro. Quota mode: none.
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system poweroff
> [   94.043540] ------------[ cut here ]------------
> [   94.043977] WARNING: CPU: 0 PID: 0 at kernel/smp.c:786
> smp_call_function_many_cond+0x4e5/0x550
> [   94.044744] Modules linked in:
> [   94.045024] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.8.0-00014-g82270db6e1f0 #91
> [   94.045697] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.15.0-1 04/01/2014
> [   94.046399] RIP: 0010:smp_call_function_many_cond+0x4e5/0x550
> [   94.046914] Code: 48 8b 78 08 48 c7 c1 a0 84 16 81 4c 89 f6 e8 22
> 11 f6 ff 65 ff 0d 23 38 ec 7e 0f 85 a1 fc ff ff 0f 1f 44 00 00 e9 97
> fc ff ff <0f> 0b e9 61
> [   94.048509] RSP: 0018:ffffc90000003e48 EFLAGS: 00010206
> [   94.048965] RAX: ffffffff82cb3fd0 RBX: ffff88811862cbc0 RCX: 0000000000000003
> [   94.049598] RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
> [   94.050226] RBP: ffff8881052c5090 R08: 0000000000000000 R09: 0000000000000001
> [   94.050861] R10: ffffffff82a060c0 R11: 0000000000008847 R12: ffff888102eb3500
> [   94.051480] R13: ffff88811862b800 R14: ffff88811862cc38 R15: 0000000000000000
> [   94.052109] FS:  0000000000000000(0000) GS:ffff888118600000(0000)
> knlGS:0000000000000000
> [   94.052812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   94.053318] CR2: 00000000004759e0 CR3: 0000000002a2e000 CR4: 0000000000750ef0
> [   94.053955] PKRU: 55555554
> [   94.054203] Call Trace:
> [   94.054433]  <IRQ>
> [   94.054632]  ? __warn+0x84/0x140
> [   94.054925]  ? smp_call_function_many_cond+0x4e5/0x550
> [   94.055362]  ? report_bug+0x199/0x1b0
> [   94.055697]  ? handle_bug+0x3c/0x70
> [   94.056010]  ? exc_invalid_op+0x18/0x70
> [   94.056350]  ? asm_exc_invalid_op+0x1a/0x20
> [   94.056728]  ? smp_call_function_many_cond+0x4e5/0x550
> [   94.057179]  ? __pfx_do_kernel_range_flush+0x10/0x10
> [   94.057622]  on_each_cpu_cond_mask+0x24/0x40
> [   94.057999]  flush_tlb_kernel_range+0x98/0xb0
> [   94.058390]  free_unmap_vmap_area+0x2d/0x40
> [   94.058768]  remove_vm_area+0x3a/0x70
> [   94.059094]  free_vmap_stack+0x15/0x60
> [   94.059427]  rcu_core+0x2bf/0x980
> [   94.059735]  ? rcu_core+0x244/0x980
> [   94.060046]  ? kvm_clock_get_cycles+0x18/0x30
> [   94.060431]  __do_softirq+0xc2/0x292
> [   94.060760]  irq_exit_rcu+0x6a/0x90
> [   94.061074]  sysvec_apic_timer_interrupt+0x6e/0x90
> [   94.061507]  </IRQ>
> [   94.061704]  <TASK>
> [   94.061903]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   94.062367] RIP: 0010:default_idle+0xf/0x20
> [   94.062746] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90
> 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 33 b4 2a
> 00 fb f4 <fa> c3 cc c0
> [   94.064342] RSP: 0018:ffffffff82a03e70 EFLAGS: 00000212
> [   94.064805] RAX: ffff888118628608 RBX: ffffffff82a0c980 RCX: 0000000000000000
> [   94.065429] RDX: 4000000000000000 RSI: ffffffff82725be8 RDI: 000000000000a14c
> [   94.066066] RBP: 0000000000000000 R08: 000000000000a14c R09: 0000000000000001
> [   94.066705] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   94.067311] R13: 0000000000000000 R14: ffffffff82a0c030 R15: 00000000000000ac
> [   94.067936]  default_idle_call+0x2c/0xd0
> [   94.068284]  do_idle+0x1ce/0x210
> [   94.068584]  cpu_startup_entry+0x2a/0x30
> [   94.068931]  rest_init+0xc5/0xd0
> [   94.069224]  arch_call_rest_init+0xe/0x30
> [   94.069597]  start_kernel+0x58e/0x8d0
> [   94.069929]  x86_64_start_reservations+0x18/0x30
> [   94.070353]  x86_64_start_kernel+0xc6/0xe0
> [   94.070725]  secondary_startup_64_no_verify+0x16d/0x17b
> [   94.071189]  </TASK>
> [   94.071392] ---[ end trace 0000000000000000 ]---
> [   95.040718] e1000e: EEE TX LPI TIMER: 00000000
> [   95.055005] ACPI: PM: Preparing to enter system sleep state S5
> [   95.055619] reboot: Power down
>
>
>  ./scripts/faddr2line ./vmlinux smp_call_function_many_cond+0x4e5/0x550
> smp_call_function_many_cond+0x4e5/0x550:
> smp_call_function_many_cond at kernel/smp.c:786 (discriminator 1)
>
>  756 static void smp_call_function_many_cond(const struct cpumask *mask,
>  757                                         smp_call_func_t func, void *info,
>  758                                         unsigned int scf_flags,
>  759                                         smp_cond_func_t cond_func)
> [...]
>  781          * When @wait we can deadlock when we interrupt between
> llist_add() and
>  782          * arch_send_call_function_ipi*(); when !@wait we can
> deadlock due to
>  783          * csd_lock() on because the interrupt context uses the same csd
>  784          * storage.
>  785          */
>  786         WARN_ON_ONCE(!in_task());
> // <<< warning here
> [...]
>
>
>
> --
> Thanks,
> JeffXie

