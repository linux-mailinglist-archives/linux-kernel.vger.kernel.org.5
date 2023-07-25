Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A061760C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjGYIAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjGYIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:00:18 -0400
X-Greylist: delayed 720 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 01:00:09 PDT
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95CB31AA;
        Tue, 25 Jul 2023 01:00:09 -0700 (PDT)
Received: from [192.168.124.11] (unknown [61.150.43.67])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 6045E1C1D3F;
        Tue, 25 Jul 2023 07:39:07 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1690270751;
        bh=UIpvXwW/xYdqfcSUiumRa/BDuejdVgL9+aeWG6qzvZc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=l0Ogp2Jztzf2tuQRa4V+OiBiBuuYsgHYJ9u1/RO3NX+XfwORTTfVmAV+lP+1AC8Wn
         aTZIhsudoVovrUkjFsNy1jkdkvQ0d4sQlfDhddF+wc4faCrWqwh5TozdZMAd/z9Xd5
         QFK0sxQqYcbLL8RhqaFjdCVKS/IWTtAbrIYOep3hH8Z2LNLyULMolSoWAvUsP4QnuX
         Fn+rIAAbkjaFbnNjPv3z3eOvKkmgrhA+fyUYMrdAmoA/smVMJT5a5wEKVI84WMlqSb
         M9qlu62g8Ppm6z0/guG/XHlqJlm30Ylpghju9fICr2LWBoIJdHAkUFujQQ3IsdpkMY
         oUsU/CV/w/BIw==
Message-ID: <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 25 Jul 2023 15:38:58 +0800
In-Reply-To: <20230617161529.2092-1-jszhang@kernel.org>
References: <20230617161529.2092-1-jszhang@kernel.org>
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

Hi Jisheng,

On Sun, 2023-06-18 at 00:15 +0800, Jisheng Zhang wrote:
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> tree files for the core module and the development board.
>=20
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.

Thanks for the excellent work, but when I tried to boot Linux 6.5.0-rc3
on my Lichee Pi 4A it fails with:

## Flattened Device Tree blob at 01f00000
   Booting using the fdt blob at 0x1f00000
   Using Device Tree in place at 0000000001f00000, end 0000000001f050c4

Starting kernel ...

[    0.000000] Linux version 6.5.0-rc3 (lfs@stargazer) (riscv64-lfs-linux-g=
nu-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP PREEMPT Tue Jul 25 =
13:38:20 CST 2023
[    0.000000] Machine model: Sipeed Lichee Pi 4A
[    0.000000] SBI specification v0.3 detected
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x9
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] earlycon: uart0 at MMIO32 0x000000ffe7014000 (options '11520=
0n8')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000000000000000..0x000000000003ffff (25=
6 KiB) nomap non-reusable mmode_resv0@0
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
[    0.000000] Kernel command line: console=3DttyS0,115200 earlycon logleve=
l=3D7
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
[    0.000000] Memory: 8145304K/8388608K available (4922K kernel code, 4786=
K rwdata, 2048K rodata, 2148K init, 393K bss, 243304K reserved, 0K cma-rese=
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
[    0.000000] Oops - load access fault [#1]
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc3 #1
[    0.000000] Hardware name: Sipeed Lichee Pi 4A (DT)
[    0.000000] epc : __plic_toggle+0x5a/0x62
[    0.000000]  ra : __plic_init.isra.0+0x2d0/0x462
[    0.000000] epc : ffffffff802ce8ec ra : ffffffff80618816 sp : ffffffff80=
e03c90
[    0.000000]  gp : ffffffff80ec5bb8 tp : ffffffff80e10d40 t0 : ffffffd900=
045940
[    0.000000]  t1 : 0000000000000002 t2 : ffffffd90004a10c s0 : ffffffd9fe=
f6ed68
[    0.000000]  s1 : ffffffd900045680 a0 : ffffffc801002080 a1 : 0000000000=
000002
[    0.000000]  a2 : 0000000000000000 a3 : 00000000000000f4 a4 : 0000000000=
000001
[    0.000000]  a5 : 0000000000000000 a6 : 0000000000000b40 a7 : ffffffd900=
045940
[    0.000000]  s2 : ffffffd9fef6ed78 s3 : ffffffff80ef9630 s4 : 0000000000=
000001
[    0.000000]  s5 : ffffffd9ffff5af8 s6 : 0000000000000001 s7 : ffffffff80=
815d68
[    0.000000]  s8 : 0000000000000008 s9 : 0000000000000000 s10: ffffffff80=
815d68
[    0.000000]  s11: ffffffff80b1b1b8 t3 : ffffffff80c003d0 t4 : 0000000000=
000001
[    0.000000]  t5 : 0000000000000003 t6 : 0000000000000001
[    0.000000] status: 8000000201800100 badaddr: 000000ffd8002080 cause: 00=
00000000000005
[    0.000000] [<ffffffff802ce8ec>] __plic_toggle+0x5a/0x62
[    0.000000] [<ffffffff8061ffc8>] of_irq_init+0x14a/0x248
[    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
[    0.000000] [<ffffffff806034f6>] init_IRQ+0xc6/0x100
[    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
[    0.000000] Code: 0007 c319 9123 00e7 8082 000f 0140 411c 000f 0820 (c59=
3) fff5=20
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Fatal exception in interrupt

I guess I'm either using some unsupported configuration or making some
stupid mistakes, but I cannot find any documentation about how to
configure the mainline kernel for Lichee Pi 4A properly.  Could you give
some pointers?

And this line

Memory: 8145304K/8388608K available (4922K kernel code, 4786K rwdata, 2048K=
 rodata, 2148K init, 393K bss, 243304K reserved, 0K cma-reserved)

does not match my hardware (my board is a 16 GB DRAM variant).  So in
the future we'll need multiple DTs for all the variants?

> NOTE: the thead cpu reset dt-binding and DT node are removed in v3. This
> makes secondary CPUs unable to be online. However, minimal th1520
> support is better than nothing. And the community has been working on
> and will work on the cpu reset dt-binding, for example, Conor, Guo and
> Jessica are discussing about it, I have seen valuable comments and
> inputs from them. I believe we can add back cpu reset in next
> development window.
>=20
> Thanks
>=20
> Since v2:
> =C2=A0 - remove thead cpu-rst dt-binding doc and its DT node from th1520.=
dtsi
> =C2=A0 - collect Reviewed-by and Acked-by tags
> =C2=A0 - update uart reg size as suggested by Yixun
> =C2=A0 - Add Guo Ren and Fu Wei as THEAD SoCs Maintainers
>=20
> Since v1:
> =C2=A0 - add missing plic, clint, th1520 itself dt-bindings
> =C2=A0 - use c900-plic
> =C2=A0 - s/light/th1520
> =C2=A0 - add dt-binding for T-HEAD CPU reset
> =C2=A0 - enable ARCH_THEAD in defconfig
> =C2=A0 - fix all dtbs_check error/warning except the CPU RESET, see above=
.
>=20
> Jisheng Zhang (8):
> =C2=A0 dt-bindings: interrupt-controller: Add T-HEAD's TH1520 PLIC
> =C2=A0 dt-bindings: timer: Add T-HEAD TH1520 clint
> =C2=A0 dt-bindings: riscv: Add T-HEAD TH1520 board compatibles
> =C2=A0 riscv: Add the T-HEAD SoC family Kconfig option
> =C2=A0 riscv: dts: add initial T-HEAD TH1520 SoC device tree
> =C2=A0 riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
> =C2=A0 MAINTAINERS: add entry for T-HEAD RISC-V SoC
> =C2=A0 riscv: defconfig: enable T-HEAD SoC
>=20
> =C2=A0.../sifive,plic-1.0.0.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> =C2=A0.../devicetree/bindings/riscv/thead.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 29 ++
> =C2=A0.../bindings/timer/sifive,clint.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 8 +
> =C2=A0arch/riscv/Kconfig.socs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0arch/riscv/boot/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0arch/riscv/boot/dts/thead/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0.../dts/thead/th1520-lichee-module-4a.dtsi=C2=A0=C2=A0=C2=A0 |=C2=
=A0 38 ++
> =C2=A0.../boot/dts/thead/th1520-lichee-pi-4a.dts=C2=A0=C2=A0=C2=A0 |=C2=
=A0 32 ++
> =C2=A0arch/riscv/boot/dts/thead/th1520.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 422 ++++++++++++++++++
> =C2=A0arch/riscv/configs/defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A011 files changed, 541 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/riscv/thead.ya=
ml
> =C2=A0create mode 100644 arch/riscv/boot/dts/thead/Makefile
> =C2=A0create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-module-4=
a.dtsi
> =C2=A0create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dt=
s
> =C2=A0create mode 100644 arch/riscv/boot/dts/thead/th1520.dtsi
>=20

