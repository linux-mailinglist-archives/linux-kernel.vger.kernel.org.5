Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B137636BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjGZMuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjGZMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:50:13 -0400
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98FE81FF5;
        Wed, 26 Jul 2023 05:49:22 -0700 (PDT)
Received: from localhost.localdomain (xry111.site [89.208.246.23])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 9EEF41C1E1F;
        Wed, 26 Jul 2023 12:48:11 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1690375697;
        bh=nEcWm6IY8z0lmi0iw5ltF4n3BXetvjRkE909x/Ombzg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=d5Tg/STs6lECc/r/PVYVVjxJyMl9mSenXNnbo2hJ33ZZfqGYvTso+eT2rxe4yMZYS
         r5N5bO/MeUz9iAGeBDjDgFDUircAf57YeHScQ29XpkXSgUj4Ln9r7Dmdnh7CyXDjtc
         k4keION+i28qpCtQ59yPjdoutaNHGHbXqX1TBR4y5icpovej7tTSzgEa2xjEN5nWC8
         YIv7u5ZLEGjej4rf4OTinm+i7/xs9nzUh0hCHfhaDYJjOjUasov+td+oSynOGtwbCE
         Sso8Zcx2HVNmH68px0q7ake/J+ZvQOZleQNBekMNlCtY8+M/sLduPkuVpto3wOqy3N
         y3+ltQLlCipHQ==
Message-ID: <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Date:   Wed, 26 Jul 2023 20:48:08 +0800
In-Reply-To: <ZL/jMYL3akl78ZZN@xhacker>
References: <20230617161529.2092-1-jszhang@kernel.org>
         <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
         <20230725-unheard-dingy-42f0fafe7216@wendy> <ZL/jMYL3akl78ZZN@xhacker>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 22:58 +0800, Jisheng Zhang wrote:
> > Are you using the vendor OpenSBI? IIRC, and the lads can probably
> > correct me here, you need to have an OpenSBI that contains
> > https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b=
9fb31623a42ced45f38ea6
> > which the vendor supplied OpenSBI does not have.
>=20
> To ruoyao,
>=20
> I believe Conor has provided enough details and given you the clues.
> And I believe you were using the legacy opensbi. If you still reproduce
> the issue with the latest opensbi generic platform, plz provided full
> uart log from openSBI to the kernel panic point.

Thanks you all for the help!

I downloaded the latest opensbi 1.3.1 and put fw_dynamic.bin in the
generic directory into /boot (renamed not to overwritten the vendor
one), then loaded it onto address 0 from the vendor u-boot.  Now the
plic issue was gone, but another panic happened.  Log is pasted at the
end of this mail.

I've not set up an initramfs, so I'm expecting a panic after all, but I
think it should be "VFS: cannot mount root fs" or something, not
"unexpected interrupt cause".

Is it a problem with vendor u-boot?  Should I try loading a latest u-
boot from the vendor one, and then load the kernel with the new u-boot?

Or maybe my toolchain (GCC 13.1.0, Binutils-2.40, with no patches) can
miscompile the kernel?

## Flattened Device Tree blob at 46000000
   Booting using the fdt blob at 0x46000000
   Using Device Tree in place at 0000000046000000, end 00000000460050c4

Starting kernel ...


OpenSBI v1.3.1
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|___/_____|
        | |
        |_|

Platform Name             : Sipeed Lichee Pi 4A
Platform Features         : medeleg
Platform HART Count       : 4
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 3000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : ---
Platform Shutdown Device  : ---
Platform Suspend Device   : ---
Platform CPPC Device      : ---
Firmware Base             : 0x0
Firmware Size             : 224 KB
Firmware RW Offset        : 0x20000
Firmware RW Size          : 96 KB
Firmware Heap Offset      : 0x2e000
Firmware Heap Size        : 40 KB (total), 2 KB (reserved), 9 KB (used), 28=
 KB (free)
Firmware Scratch Size     : 4096 B (total), 760 B (used), 3336 B (free)
Runtime SBI Version       : 1.0

Domain0 Name              : root
Domain0 Boot HART         : 0
Domain0 HARTs             : 0*,1*,2*,3*
Domain0 Region00          : 0x000000ffdc008000-0x000000ffdc00bfff M: (I,R,W=
) S/U: ()
Domain0 Region01          : 0x000000ffdc000000-0x000000ffdc007fff M: (I,R,W=
) S/U: ()
Domain0 Region02          : 0x0000000000000000-0x000000000001ffff M: (R,X) =
S/U: ()
Domain0 Region03          : 0x0000000000020000-0x000000000003ffff M: (R,W) =
S/U: ()
Domain0 Region04          : 0x0000000000000000-0xffffffffffffffff M: (R,W,X=
) S/U: (R,W,X)
Domain0 Next Address      : 0x0000000040200000
Domain0 Next Arg1         : 0x0000000046000000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes
Domain0 SysSuspend        : yes

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART Priv Version    : v1.11
Boot HART Base ISA        : rv64imafdcvx
Boot HART ISA Extensions  : time
Boot HART PMP Count       : 0
Boot HART PMP Granularity : 0
Boot HART PMP Address Bits: 0
Boot HART MHPM Count      : 16
Boot HART MIDELEG         : 0x0000000000000222
Boot HART MEDELEG         : 0x000000000000b109
[    0.000000] Linux version 6.5.0-rc3 (lfs@stargazer) (riscv64-lfs-linux-g=
nu-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP PREEMPT Tue Jul 25 =
13:38:20 CST 2023
[    0.000000] Machine model: Sipeed Lichee Pi 4A
[    0.000000] SBI specification v1.0 detected
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x10003
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] earlycon: uart0 at MMIO32 0x000000ffe7014000 (options '11520=
0n8')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000000000000000..0x000000000001ffff (12=
8 KiB) nomap non-reusable mmode_resv0@0
[    0.000000] OF: reserved mem: 0x0000000000020000..0x000000000003ffff (12=
8 KiB) nomap non-reusable mmode_resv1@20000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000003ffff]
[    0.000000]   node   0: [mem 0x0000000000040000-0x00000001ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000001fffff=
fff]
[    0.000000] SBI HSM extension detected
[    0.000000] riscv: base ISA extensions acdfim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 17 pages/cpu s38184 r0 d31448 u69632
[    0.000000] Kernel command line: earlycon console=3DttyS0,115200
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 20643=
84
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:of=
f
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000ff=
fff000] (64MB)
[    0.000000] Memory: 8145300K/8388608K available (4922K kernel code, 4786=
K rwdata, 2048K rodata, 2148K init, 393K bss, 243308K reserved, 0K cma-rese=
rved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_id=
s=3D4.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped
[    0.000000] plic: interrupt-controller@ffd8000000: mapped 240 interrupts=
 with 4 handlers for 8 contexts.
[    0.000000] riscv: providing IPIs using SBI IPI extension
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max=
_cycles: 0x1623fa770, max_idle_ns: 881590404476 ns
[    0.000001] sched_clock: 64 bits at 3000kHz, resolution 333ns, wraps eve=
ry 4398046511097ns
[    0.008488] Console: colour dummy device 80x25
[    0.012944] Kernel panic - not syncing: unexpected interrupt cause
[    0.012952] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc3 #1
[    0.012964] Hardware name: Sipeed Lichee Pi 4A (DT)
[    0.012970] Call Trace:
[    0.012976] [<ffffffff80004c38>] walk_stackframe+0x0/0x7e
[    0.013002] [<ffffffff804c868c>] dump_stack_lvl+0x34/0x4e
[    0.013022] [<ffffffff804c1334>] panic+0xf2/0x292
[    0.013035] [<ffffffff802cddc0>] riscv_intc_irq+0x34/0x38
[    0.013052] [<ffffffff804c8716>] handle_riscv_irq+0x66/0xa6
[    0.059145] ---[ end Kernel panic - not syncing: unexpected interrupt ca=
use ]---

