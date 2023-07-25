Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11121761D02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjGYPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjGYPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA12C1BF8;
        Tue, 25 Jul 2023 08:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC24616DE;
        Tue, 25 Jul 2023 15:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC804C433C9;
        Tue, 25 Jul 2023 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690297836;
        bh=HOET60UVofZD/GiNoqKT9q8+mrxfWMeXPfBn0chYin4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHlTuFs485Ip/OU2fbMYnpl5ujjMu7dQpmnrVaQHDTKsK6Ex3OlFlTNutW6dProvK
         3ysdF+dxYKLRkmppc+Fa+JHwFVGK+2mthn02BUwqRunC/qbRGSzgHCytDdmmyhaiID
         FkhVMu3HQG7TrLxG16mhOEg1qe3tmGB/nKj+t6+JKiX3NwEzNZLguJH8Socxx8NkD0
         h8WCRUq8/9DbkT9f9zN6A0QcsBZtwJrP2BP3aR+AinJyDr3r7hDDtY9kmn1t3/CHnp
         POmu3UuYvE/f01dl9nj+3LQqnYYj41b7d0UfZtU7yaMGqsWKF69i1v5mAY70VocNrF
         1D4qXmhl1Vq4A==
Date:   Tue, 25 Jul 2023 22:58:57 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Xi Ruoyao <xry111@linuxfromscratch.org>
Cc:     Xi Ruoyao <xry111@linuxfromscratch.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZL/jMYL3akl78ZZN@xhacker>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
 <20230725-unheard-dingy-42f0fafe7216@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725-unheard-dingy-42f0fafe7216@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:52:09AM +0100, Conor Dooley wrote:
> Hey,
> 
> On Tue, Jul 25, 2023 at 03:38:58PM +0800, Xi Ruoyao wrote:
> > Hi Jisheng,
> > 
> > On Sun, 2023-06-18 at 00:15 +0800, Jisheng Zhang wrote:
> > > Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> > > module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> > > tree files for the core module and the development board.
> > > 
> > > Support basic uart/gpio/dmac drivers, so supports booting to a basic
> > > shell.
> > 
> > Thanks for the excellent work, but when I tried to boot Linux 6.5.0-rc3
> > on my Lichee Pi 4A it fails with:
> > 
> > ## Flattened Device Tree blob at 01f00000
> >    Booting using the fdt blob at 0x1f00000
> >    Using Device Tree in place at 0000000001f00000, end 0000000001f050c4
> > 
> > Starting kernel ...
> > 
> > [    0.000000] Linux version 6.5.0-rc3 (lfs@stargazer) (riscv64-lfs-linux-gnu-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP PREEMPT Tue Jul 25 13:38:20 CST 2023
> > [    0.000000] Machine model: Sipeed Lichee Pi 4A
> > [    0.000000] SBI specification v0.3 detected
> > [    0.000000] SBI implementation ID=0x1 Version=0x9
> > [    0.000000] SBI TIME extension detected
> > [    0.000000] SBI IPI extension detected
> > [    0.000000] SBI RFENCE extension detected
> > [    0.000000] earlycon: uart0 at MMIO32 0x000000ffe7014000 (options '115200n8')
> > [    0.000000] printk: bootconsole [uart0] enabled
> > [    0.000000] efi: UEFI not found.
> > [    0.000000] OF: reserved mem: 0x0000000000000000..0x000000000003ffff (256 KiB) nomap non-reusable mmode_resv0@0
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
> > [    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000000000-0x000000000003ffff]
> > [    0.000000]   node   0: [mem 0x0000000000040000-0x00000001ffffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000001ffffffff]
> > [    0.000000] SBI HSM extension detected
> > [    0.000000] riscv: base ISA extensions acdfim
> > [    0.000000] riscv: ELF capabilities acdfim
> > [    0.000000] percpu: Embedded 17 pages/cpu s38184 r0 d31448 u69632
> > [    0.000000] Kernel command line: console=ttyS0,115200 earlycon loglevel=7
> > [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> > [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2064384
> > [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> > [    0.000000] software IO TLB: area num 4.
> > [    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000fffff000] (64MB)
> > [    0.000000] Memory: 8145304K/8388608K available (4922K kernel code, 4786K rwdata, 2048K rodata, 2148K init, 393K bss, 243304K reserved, 0K cma-reserved)
> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> > [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> > [    0.000000] rcu:     RCU event tracing is enabled.
> > [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
> > [    0.000000]  Trampoline variant of Tasks RCU enabled.
> > [    0.000000]  Tracing variant of Tasks RCU enabled.
> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> > [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> > [    0.000000] riscv-intc: 64 local interrupts mapped
> > [    0.000000] Oops - load access fault [#1]
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc3 #1
> > [    0.000000] Hardware name: Sipeed Lichee Pi 4A (DT)
> > [    0.000000] epc : __plic_toggle+0x5a/0x62
> > [    0.000000]  ra : __plic_init.isra.0+0x2d0/0x462
> > [    0.000000] epc : ffffffff802ce8ec ra : ffffffff80618816 sp : ffffffff80e03c90
> > [    0.000000]  gp : ffffffff80ec5bb8 tp : ffffffff80e10d40 t0 : ffffffd900045940
> > [    0.000000]  t1 : 0000000000000002 t2 : ffffffd90004a10c s0 : ffffffd9fef6ed68
> > [    0.000000]  s1 : ffffffd900045680 a0 : ffffffc801002080 a1 : 0000000000000002
> > [    0.000000]  a2 : 0000000000000000 a3 : 00000000000000f4 a4 : 0000000000000001
> > [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000b40 a7 : ffffffd900045940
> > [    0.000000]  s2 : ffffffd9fef6ed78 s3 : ffffffff80ef9630 s4 : 0000000000000001
> > [    0.000000]  s5 : ffffffd9ffff5af8 s6 : 0000000000000001 s7 : ffffffff80815d68
> > [    0.000000]  s8 : 0000000000000008 s9 : 0000000000000000 s10: ffffffff80815d68
> > [    0.000000]  s11: ffffffff80b1b1b8 t3 : ffffffff80c003d0 t4 : 0000000000000001
> > [    0.000000]  t5 : 0000000000000003 t6 : 0000000000000001
> > [    0.000000] status: 8000000201800100 badaddr: 000000ffd8002080 cause: 0000000000000005
> > [    0.000000] [<ffffffff802ce8ec>] __plic_toggle+0x5a/0x62
> > [    0.000000] [<ffffffff8061ffc8>] of_irq_init+0x14a/0x248
> > [    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
> > [    0.000000] [<ffffffff806034f6>] init_IRQ+0xc6/0x100
> > [    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
> > [    0.000000] Code: 0007 c319 9123 00e7 8082 000f 0140 411c 000f 0820 (c593) fff5 
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Kernel panic - not syncing: Fatal exception in interrupt
> > 
> > I guess I'm either using some unsupported configuration or making some
> > stupid mistakes, but I cannot find any documentation about how to
> > configure the mainline kernel for Lichee Pi 4A properly.  Could you give
> > some pointers?
> 
> Are you using the vendor OpenSBI? IIRC, and the lads can probably
> correct me here, you need to have an OpenSBI that contains
> https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6
> which the vendor supplied OpenSBI does not have.

To ruoyao,

I believe Conor has provided enough details and given you the clues.
And I believe you were using the legacy opensbi. If you still reproduce
the issue with the latest opensbi generic platform, plz provided full
uart log from openSBI to the kernel panic point.
> 
> > And this line
> > 
> > Memory: 8145304K/8388608K available (4922K kernel code, 4786K rwdata, 2048K rodata, 2148K init, 393K bss, 243304K reserved, 0K cma-reserved)
> > 
> > does not match my hardware (my board is a 16 GB DRAM variant).  So in
> > the future we'll need multiple DTs for all the variants?
> 
> A bootloader stage would ideally patch the DT that the kernel ends up
> getting. If you're loading your own dtb, you can do it easily in U-Boot
> after you extract it from your FIT image or whatever. I have no idea
> what the vendor U-Boot does.

uboot can modify the dtb memory node on the fly ;)

> 
> Thanks,
> Conor.


