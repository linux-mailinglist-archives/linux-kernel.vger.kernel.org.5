Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DC7763A93
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjGZPN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjGZPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CACC2D60;
        Wed, 26 Jul 2023 08:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3900961B24;
        Wed, 26 Jul 2023 15:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BBDC433C8;
        Wed, 26 Jul 2023 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690384353;
        bh=TaNQS6vezap8TMfB8Xkt30Oq/Pvt03VIwITKYfftyXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hY8UibfovAuSx0h2d3GTSH0r+8igwCNe5MijA1/gWN1nz6aWLLCUoCwW4+GlcUXI8
         W8wSjaIVQXAduJsdsa8aYpKTmlgxwZDMBBDyYYK9g4ZbiQiDYJtq6WsX3pkGQ4oB2r
         cgYqEiY+KiLu/nIljvxVWN2mdmYeI+3L/CRBJKLHBk8ddaqdye3//J8Z6A1Y8KPOk0
         uQjZXfknZZM3zJpr2FteCS+jNovoY3tl8nCL14wWYMpcUjJijI3GBKVMN0/4W09ArE
         zWnnbTK1E8xGJiZt01mOgy6StUo6VzmwuOVXOXjGfrXMchW2HAt/xt03X2rCBPGkYO
         vXPayYYspBoAQ==
Date:   Wed, 26 Jul 2023 23:00:55 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Xi Ruoyao <xry111@linuxfromscratch.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
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
Message-ID: <ZME1J4mpVf5yth32@xhacker>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
 <20230725-unheard-dingy-42f0fafe7216@wendy>
 <ZL/jMYL3akl78ZZN@xhacker>
 <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:48:08PM +0800, Xi Ruoyao wrote:
> On Tue, 2023-07-25 at 22:58 +0800, Jisheng Zhang wrote:
> > > Are you using the vendor OpenSBI? IIRC, and the lads can probably
> > > correct me here, you need to have an OpenSBI that contains
> > > https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6
> > > which the vendor supplied OpenSBI does not have.
> > 
> > To ruoyao,
> > 
> > I believe Conor has provided enough details and given you the clues.
> > And I believe you were using the legacy opensbi. If you still reproduce
> > the issue with the latest opensbi generic platform, plz provided full
> > uart log from openSBI to the kernel panic point.
> 
> Thanks you all for the help!
> 
> I downloaded the latest opensbi 1.3.1 and put fw_dynamic.bin in the
> generic directory into /boot (renamed not to overwritten the vendor
> one), then loaded it onto address 0 from the vendor u-boot.  Now the
> plic issue was gone, but another panic happened.  Log is pasted at the
> end of this mail.
> 
> I've not set up an initramfs, so I'm expecting a panic after all, but I
> think it should be "VFS: cannot mount root fs" or something, not
> "unexpected interrupt cause".
> 
> Is it a problem with vendor u-boot?  Should I try loading a latest u-
> boot from the vendor one, and then load the kernel with the new u-boot?

which dts r u using? see below.

> 
> Or maybe my toolchain (GCC 13.1.0, Binutils-2.40, with no patches) can
> miscompile the kernel?
> 
> ## Flattened Device Tree blob at 46000000
>    Booting using the fdt blob at 0x46000000
>    Using Device Tree in place at 0000000046000000, end 00000000460050c4
> 
> Starting kernel ...
> 
> 
> OpenSBI v1.3.1
>    ____                    _____ ____ _____
>   / __ \                  / ____|  _ \_   _|
>  | |  | |_ __   ___ _ __ | (___ | |_) || |
>  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>  | |__| | |_) |  __/ | | |____) | |_) || |_
>   \____/| .__/ \___|_| |_|_____/|___/_____|
>         | |
>         |_|
> 
> Platform Name             : Sipeed Lichee Pi 4A
> Platform Features         : medeleg
> Platform HART Count       : 4
> Platform IPI Device       : aclint-mswi
> Platform Timer Device     : aclint-mtimer @ 3000000Hz
> Platform Console Device   : uart8250
> Platform HSM Device       : ---
> Platform PMU Device       : ---
> Platform Reboot Device    : ---
> Platform Shutdown Device  : ---
> Platform Suspend Device   : ---
> Platform CPPC Device      : ---
> Firmware Base             : 0x0
> Firmware Size             : 224 KB
> Firmware RW Offset        : 0x20000
> Firmware RW Size          : 96 KB
> Firmware Heap Offset      : 0x2e000
> Firmware Heap Size        : 40 KB (total), 2 KB (reserved), 9 KB (used), 28 KB (free)
> Firmware Scratch Size     : 4096 B (total), 760 B (used), 3336 B (free)
> Runtime SBI Version       : 1.0
> 
> Domain0 Name              : root
> Domain0 Boot HART         : 0
> Domain0 HARTs             : 0*,1*,2*,3*
> Domain0 Region00          : 0x000000ffdc008000-0x000000ffdc00bfff M: (I,R,W) S/U: ()
> Domain0 Region01          : 0x000000ffdc000000-0x000000ffdc007fff M: (I,R,W) S/U: ()
> Domain0 Region02          : 0x0000000000000000-0x000000000001ffff M: (R,X) S/U: ()
> Domain0 Region03          : 0x0000000000020000-0x000000000003ffff M: (R,W) S/U: ()
> Domain0 Region04          : 0x0000000000000000-0xffffffffffffffff M: (R,W,X) S/U: (R,W,X)
> Domain0 Next Address      : 0x0000000040200000
> Domain0 Next Arg1         : 0x0000000046000000
> Domain0 Next Mode         : S-mode
> Domain0 SysReset          : yes
> Domain0 SysSuspend        : yes
> 
> Boot HART ID              : 0
> Boot HART Domain          : root
> Boot HART Priv Version    : v1.11
> Boot HART Base ISA        : rv64imafdcvx

what? I don't think the mainline dts provide v and x. 

> Boot HART ISA Extensions  : time
> Boot HART PMP Count       : 0
> Boot HART PMP Granularity : 0
> Boot HART PMP Address Bits: 0
> Boot HART MHPM Count      : 16
> Boot HART MIDELEG         : 0x0000000000000222
> Boot HART MEDELEG         : 0x000000000000b109
> [    0.000000] Linux version 6.5.0-rc3 (lfs@stargazer) (riscv64-lfs-linux-gnu-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP PREEMPT Tue Jul 25 13:38:20 CST 2023
> [    0.000000] Machine model: Sipeed Lichee Pi 4A
> [    0.000000] SBI specification v1.0 detected
> [    0.000000] SBI implementation ID=0x1 Version=0x10003
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] earlycon: uart0 at MMIO32 0x000000ffe7014000 (options '115200n8')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: 0x0000000000000000..0x000000000001ffff (128 KiB) nomap non-reusable mmode_resv0@0
> [    0.000000] OF: reserved mem: 0x0000000000020000..0x000000000003ffff (128 KiB) nomap non-reusable mmode_resv1@20000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000000003ffff]
> [    0.000000]   node   0: [mem 0x0000000000040000-0x00000001ffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000001ffffffff]
> [    0.000000] SBI HSM extension detected
> [    0.000000] riscv: base ISA extensions acdfim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 17 pages/cpu s38184 r0 d31448 u69632
> [    0.000000] Kernel command line: earlycon console=ttyS0,115200
> [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2064384
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.000000] software IO TLB: area num 4.
> [    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000fffff000] (64MB)
> [    0.000000] Memory: 8145300K/8388608K available (4922K kernel code, 4786K rwdata, 2048K rodata, 2148K init, 393K bss, 243308K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
> [    0.000000]  Trampoline variant of Tasks RCU enabled.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] plic: interrupt-controller@ffd8000000: mapped 240 interrupts with 4 handlers for 8 contexts.
> [    0.000000] riscv: providing IPIs using SBI IPI extension
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x1623fa770, max_idle_ns: 881590404476 ns
> [    0.000001] sched_clock: 64 bits at 3000kHz, resolution 333ns, wraps every 4398046511097ns
> [    0.008488] Console: colour dummy device 80x25
> [    0.012944] Kernel panic - not syncing: unexpected interrupt cause
> [    0.012952] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc3 #1
> [    0.012964] Hardware name: Sipeed Lichee Pi 4A (DT)
> [    0.012970] Call Trace:
> [    0.012976] [<ffffffff80004c38>] walk_stackframe+0x0/0x7e
> [    0.013002] [<ffffffff804c868c>] dump_stack_lvl+0x34/0x4e
> [    0.013022] [<ffffffff804c1334>] panic+0xf2/0x292
> [    0.013035] [<ffffffff802cddc0>] riscv_intc_irq+0x34/0x38
> [    0.013052] [<ffffffff804c8716>] handle_riscv_irq+0x66/0xa6
> [    0.059145] ---[ end Kernel panic - not syncing: unexpected interrupt cause ]---
> 
