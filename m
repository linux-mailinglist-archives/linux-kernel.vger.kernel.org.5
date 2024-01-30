Return-Path: <linux-kernel+bounces-44379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE5584212A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02E31F24E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2C860DDB;
	Tue, 30 Jan 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dM1vBXPX"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DF18E25
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610214; cv=none; b=YoxTXReSh0hN5UyJ6prpGKn6hoOKgzQoMsm9/6jIXz944cvUdfdwJ4OrrTp8MUn8/EAGjgaOKT0FYegBLpBYoHH/EgrkcKi3xhHRpV8lWiZKf3klLfC2iI4fcZ4dhTHcQIoMV1OE5Fr4Dy9OoA/+DUba3wMb1i2iA6ykAqh/l3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610214; c=relaxed/simple;
	bh=rSs5jbaQJrEwdTvYkwC7kETcqx4xzL2gcWSliTGqJNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgHp5VtEZpB0xqeQ4Ni4mW2MYPGso6GbPQ3TXH5rWjUnsfaq/3YzmDjIKU98ZW4i3h5ku6VjZOEOXaQ8gUMtARc+PUSG2Huf77UTFYG/IYh/g4cmqcpsAABEdpJpWqlizVS7S7PYNk+Zwp/pL7l5nhrjKb7IjlQZAdJk9CAxE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dM1vBXPX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-510faac8c57so2525832e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706610210; x=1707215010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMo8RglOzaILzYjpns+fU8LSDTWLjiXiMi3AAaJjhkA=;
        b=dM1vBXPXl7op/i94rcVfSpmeP39t7M7O5UmA9k+dK+Aq1RLG4w4do3aXDcuTmDILmr
         gNwGNocerOAdQMkL5Tvm5FQtkATSpL4BnjC4gHXPy1rDRdQ2F4OUewgYYIHkPTaW4VJH
         eIn7+q/ar0JesINJTp2iJEHFnv2Vomd832hjnEljrB/cl0akJtmyIynCywi15uaucVJB
         rtqDW2O601JK4Gs8FvN2jAKpAMxySeTaDJwS4+gBXvqC/pqvN7Nai9KArgha83MINYSz
         Id4qJ1vXQXV529e2tTdAi8Ar6lLjuo2fuiodjkHV/PTPEAb631yxzagEWfJLyS6MMxL1
         uh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610210; x=1707215010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMo8RglOzaILzYjpns+fU8LSDTWLjiXiMi3AAaJjhkA=;
        b=rOsINn/FlWUrSxZsW0Tr1NiTZpx7pyf9YUh0iHVI3APKTKG8hrszCDwZrS2On49pJh
         BjvZCedOOsqr+AFe01h/PZgLAevhXdvBog5SC2sXELFHAU3RSq8ebZzReXJU7dF/5hBK
         50e63p6If+mP8XQ8Z3/xQsMypjq/ga68x0Jnp1jNZEdNg2KvxsQdudOHrXt6kcSeo/w/
         IZNcLLUamzWNGlgS7fSxFQd0lT9Z2IM91Vh8JAS2OWjhIPake6p9vewz/h+khEG1dJ9v
         CWt8nXgXx5uOpf/nU4TmByCyzAjUlxvnGt2QGo4V9VrgxtLx0qp+EUTLm5ai+rA/WOXF
         8qQA==
X-Gm-Message-State: AOJu0Yz+uP5vr028poHJ7D3ZqmbLvbdJiEZ7vBFiqBhtzmjEeT6N1Kje
	uh5iik5MpSry89xrwr1F4jpeIn0B4LArnB/E3DXMLyc5iWPDOgNBkXv8UtgU7bgPcbcsof0Fukg
	kRuB2CfRjqZWEpFwqfU/wn9OAXG/KjBllp7zjDA==
X-Google-Smtp-Source: AGHT+IE/P7LMYfR74CNxCDg55CwovY7HZYs2EcX6liqWXQ78s0zyHAAOICgnZCFa9MtzxRsaqiSrpQzOLr1T3lzotfw=
X-Received: by 2002:a05:6512:1196:b0:510:194e:4e07 with SMTP id
 g22-20020a056512119600b00510194e4e07mr519794lfr.26.1706610209274; Tue, 30 Jan
 2024 02:23:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87r0hzuw87.fsf@all.your.base.are.belong.to.us> <87le87uulb.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87le87uulb.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 30 Jan 2024 15:53:17 +0530
Message-ID: <CAK9=C2UYCKUBKggtM606orH2mBu_AbTdB5-R5AP1M0t-LsEbEQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
> > Anup Patel <apatel@ventanamicro.com> writes:
> >
> >> The RISC-V AIA specification is ratified as-per the RISC-V internation=
al
> >> process. The latest ratified AIA specifcation can be found at:
> >> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interru=
pts-1.0.pdf
> >>
> >> At a high-level, the AIA specification adds three things:
> >> 1) AIA CSRs
> >>    - Improved local interrupt support
> >> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> >>    - Per-HART MSI controller
> >>    - Support MSI virtualization
> >>    - Support IPI along with virtualization
> >> 3) Advanced Platform-Level Interrupt Controller (APLIC)
> >>    - Wired interrupt controller
> >>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generat=
or)
> >>    - In Direct-mode, injects external interrupts directly into HARTs
> >>
> >> For an overview of the AIA specification, refer the AIA virtualization
> >> talk at KVM Forum 2022:
> >> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualizati=
on_in_KVM_RISCV_final.pdf
> >> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
> >>
> >> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or hi=
gher).
> >>
> >> These patches can also be found in the riscv_aia_v12 branch at:
> >> https://github.com/avpatel/linux.git
> >>
> >> Changes since v11:
> >>  - Rebased on Linux-6.8-rc1
> >>  - Included kernel/irq related patches from "genirq, irqchip: Convert =
ARM
> >>    MSI handling to per device MSI domains" series by Thomas.
> >>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH1=
9,
> >>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
> >>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@=
linutronix.de/)
> >>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanism=
.
> >>  - Updated IMSIC driver to support per-device MSI domains for PCI and
> >>    platform devices.
> >
> > Thanks for working on this, Anup! I'm still reviewing the patches.
> >
> > I'm hitting a boot hang in text patching, with this series applied on
> > 6.8-rc2. IPI issues?
>
> Not text patching! One cpu spinning in smp_call_function_many_cond() and
> the others are in cpu_relax(). Smells like IPI...

I tried bootefi from U-Boot multiple times but can't reproduce the
issue you are seeing.

Here's my boot log ...

$ qemu-system-riscv64 -M virt,aia=3Daplic-imsic -m 256M -display none
-serial stdio -bios
opensbi/build/platform/generic/firmware/fw_jump.bin -kernel
/u-boot/u-boot.bin -device
loader,file=3D./build-riscv64/arch/riscv/boot/Image,addr=3D0x84000000
-drive file=3D./rootfs_riscv64.ext2,format=3Draw,id=3Dhd0 -device
virtio-blk-device,drive=3Dhd0 -device virtio-net-device,netdev=3Deth0
-netdev user,id=3Deth0 -object rng-random,filename=3D/dev/urandom,id=3Drng0
-device virtio-rng-device,rng=3Drng0 -append "root=3D/dev/vda rootwait rw
console=3DttyS0 earlycon" -smp 8

OpenSBI v1.4-8-gbb90a9e
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name             : riscv-virtio,qemu
Platform Features         : medeleg
Platform HART Count       : 8
Platform IPI Device       : aia-imsic
Platform Timer Device     : aclint-mtimer @ 10000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : syscon-reboot
Platform Shutdown Device  : syscon-poweroff
Platform Suspend Device   : ---
Platform CPPC Device      : ---
Firmware Base             : 0x80000000
Firmware Size             : 395 KB
Firmware RW Offset        : 0x40000
Firmware RW Size          : 139 KB
Firmware Heap Offset      : 0x56000
Firmware Heap Size        : 51 KB (total), 3 KB (reserved), 12 KB
(used), 36 KB (free)
Firmware Scratch Size     : 4096 B (total), 328 B (used), 3768 B (free)
Runtime SBI Version       : 2.0

Domain0 Name              : root
Domain0 Boot HART         : 7
Domain0 HARTs             : 0*,1*,2*,3*,4*,5*,6*,7*
Domain0 Region00          : 0x0000000000100000-0x0000000000100fff M:
(I,R,W) S/U: (R,W)
Domain0 Region01          : 0x0000000010000000-0x0000000010000fff M:
(I,R,W) S/U: (R,W)
Domain0 Region02          : 0x000000000c000000-0x000000000c007fff M:
(I,R,W) S/U: ()
Domain0 Region03          : 0x0000000024000000-0x0000000024007fff M:
(I,R,W) S/U: ()
Domain0 Region04          : 0x0000000002000000-0x000000000200ffff M:
(I,R,W) S/U: ()
Domain0 Region05          : 0x0000000080000000-0x000000008003ffff M:
(R,X) S/U: ()
Domain0 Region06          : 0x0000000080040000-0x000000008007ffff M:
(R,W) S/U: ()
Domain0 Region07          : 0x0000000000000000-0xffffffffffffffff M:
() S/U: (R,W,X)
Domain0 Next Address      : 0x0000000080200000
Domain0 Next Arg1         : 0x0000000082200000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes
Domain0 SysSuspend        : yes

Boot HART ID              : 7
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdch
Boot HART ISA Extensions  : smaia,sstc,zicntr,zihpm,zicboz,zicbom,sdtrig
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 2 bits
Boot HART PMP Address Bits: 54
Boot HART MHPM Info       : 16 (0x0007fff8)
Boot HART Debug Triggers  : 2 triggers
Boot HART MIDELEG         : 0x0000000000001666
Boot HART MEDELEG         : 0x0000000000f0b509


U-Boot 2023.10 (Nov 07 2023 - 18:28:29 +0530)

CPU:   rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpaus=
e_zihpm_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_smaia_ssaia_sstc_svadu
Model: riscv-virtio,qemu
DRAM:  256 MiB
Core:  37 devices, 16 uclasses, devicetree: board
Flash: 32 MiB
Loading Environment from nowhere... OK
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
No working controllers found
Net:   eth0: virtio-net#1
Working FDT set to 8ef1f870
Hit any key to stop autoboot:  0
=3D> bootefi ${kernel_addr_r}:0x1600000 ${fdtcontroladdr}
No EFI system partition
No EFI system partition
Failed to persist EFI variables
Booting /MemoryMapped(0x0,0x84000000,0x1600000)
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
[    0.000000] Linux version 6.8.0-rc1-00039-gd9b9d6eb987f
(anup@anup-ubuntu-vm) (riscv64-unknown-linux-gnu-gcc (g2ee5e430018)
12.2.0, GNU ld (GNU Binutils) 2.40.0.20230214) #67 SMP Sat Jan 27
17:20:09 IST 2024
[    0.000000] random: crng init done
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] SBI specification v2.0 detected
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x10004
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] SBI DBCN extension detected
[    0.000000] earlycon: ns16550a0 at MMIO 0x0000000010000000 (options '')
[    0.000000] printk: legacy bootconsole [ns16550a0] enabled
[    0.000000] efi: EFI v2.10 by Das U-Boot
[    0.000000] efi: RTPROP=3D0x8df05040 SMBIOS=3D0x8df01000 RNG=3D0x8c97204=
0
MEMRESERVE=3D0x8c971040
[    0.000000] OF: reserved mem:
0x0000000080000000..0x000000008003ffff (256 KiB) nomap non-reusable
mmode_resv0@80000000
[    0.000000] OF: reserved mem:
0x0000000080040000..0x000000008007ffff (256 KiB) nomap non-reusable
mmode_resv1@80040000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x000000008fffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008007ffff]
[    0.000000]   node   0: [mem 0x0000000080080000-0x000000008df00fff]
[    0.000000]   node   0: [mem 0x000000008df01000-0x000000008df01fff]
[    0.000000]   node   0: [mem 0x000000008df02000-0x000000008df04fff]
[    0.000000]   node   0: [mem 0x000000008df05000-0x000000008df05fff]
[    0.000000]   node   0: [mem 0x000000008df06000-0x000000008df06fff]
[    0.000000]   node   0: [mem 0x000000008df07000-0x000000008df08fff]
[    0.000000]   node   0: [mem 0x000000008df09000-0x000000008df09fff]
[    0.000000]   node   0: [mem 0x000000008df0a000-0x000000008df19fff]
[    0.000000]   node   0: [mem 0x000000008df1a000-0x000000008f741fff]
[    0.000000]   node   0: [mem 0x000000008f742000-0x000000008f742fff]
[    0.000000]   node   0: [mem 0x000000008f743000-0x000000008fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000008ffff=
fff]
[    0.000000] SBI HSM extension detected
[    0.000000] Falling back to deprecated "riscv,isa"
[    0.000000] riscv: base ISA extensions acdfhim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 20 pages/cpu s41464 r8192 d32264 u81920
[    0.000000] Kernel command line: root=3D/dev/vda rootwait rw
console=3DttyS0 earlycon
[    0.000000] Dentry cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.000000] Inode-cache hash table entries: 16384 (order: 5, 131072
bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 64512
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:of=
f
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0xff1bfffffea00000 - 0xff1bffffff000000
 (6144 kB)
[    0.000000]       pci io : 0xff1bffffff000000 - 0xff1c000000000000
 (  16 MB)
[    0.000000]      vmemmap : 0xff1c000000000000 - 0xff20000000000000
 (1024 TB)
[    0.000000]      vmalloc : 0xff20000000000000 - 0xff60000000000000
 (16384 TB)
[    0.000000]      modules : 0xffffffff01582000 - 0xffffffff80000000
 (2026 MB)
[    0.000000]       lowmem : 0xff60000000000000 - 0xff60000010000000
 ( 256 MB)
[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff
 (2047 MB)
[    0.000000] Memory: 217364K/262144K available (9190K kernel code,
4939K rwdata, 4096K rodata, 2252K init, 489K bss, 44780K reserved, 0K
cma-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_id=
s=3D8.
[    0.000000] rcu:     RCU debug extended QS entry/exit.
[    0.000000]     Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped using AIA
[    0.000000] riscv-imsic: imsics@28000000: providing IPIs using interrupt=
 1
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] clocksource: riscv_clocksource: mask:
0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120
ns
[    0.000087] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps
every 4398046511100ns
[    0.001406] riscv-timer: Timer interrupt in S-mode is available via
sstc extension
[    0.007310] Console: colour dummy device 80x25
[    0.014343] Calibrating delay loop (skipped), value calculated
using timer frequency.. 20.00 BogoMIPS (lpj=3D40000)
[    0.018315] pid_max: default: 32768 minimum: 301
[    0.020982] LSM: initializing lsm=3Dcapability,integrity
[    0.023969] Mount-cache hash table entries: 512 (order: 0, 4096
bytes, linear)
[    0.025231] Mountpoint-cache hash table entries: 512 (order: 0,
4096 bytes, linear)
[    0.066845] RCU Tasks Trace: Setting shift to 3 and lim to 1
rcu_task_cb_adjust=3D1.
[    0.068829] riscv: ELF compat mode supported
[    0.069115] ASID allocator using 16 bits (65536 entries)
[    0.080952] rcu: Hierarchical SRCU implementation.
[    0.081712] rcu:     Max phase no-delay instances is 1000.
[    0.086381] Remapping and enabling EFI services.
[    0.093736] smp: Bringing up secondary CPUs ...
[    0.162264] smp: Brought up 1 node, 8 CPUs
[    0.186107] devtmpfs: initialized
[    0.199725] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.200634] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.203482] pinctrl core: initialized pinctrl subsystem
[    0.213664] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.218255] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocat=
ions
[    0.221185] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[    0.222099] audit: initializing netlink subsys (disabled)
[    0.228028] audit: type=3D2000 audit(0.168:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    0.230906] cpuidle: using governor menu
[    0.289647] cpu2: Ratio of byte access time to unaligned word
access is 7.20, unaligned accesses are fast
[    0.289661] cpu3: Ratio of byte access time to unaligned word
access is 5.94, unaligned accesses are fast
[    0.289652] cpu4: Ratio of byte access time to unaligned word
access is 7.13, unaligned accesses are fast
[    0.289625] cpu6: Ratio of byte access time to unaligned word
access is 10.28, unaligned accesses are fast
[    0.289615] cpu1: Ratio of byte access time to unaligned word
access is 8.04, unaligned accesses are fast
[    0.290252] cpu5: Ratio of byte access time to unaligned word
access is 7.13, unaligned accesses are fast
[    0.299499] cpu7: Ratio of byte access time to unaligned word
access is 6.58, unaligned accesses are fast
[    0.326695] cpu0: Ratio of byte access time to unaligned word
access is 7.78, unaligned accesses are fast
[    0.354371] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.354767] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.361699] ACPI: Interpreter disabled.
[    0.363441] iommu: Default domain type: Translated
[    0.364215] iommu: DMA domain TLB invalidation policy: strict mode
[    0.368128] SCSI subsystem initialized
[    0.371067] usbcore: registered new interface driver usbfs
[    0.371912] usbcore: registered new interface driver hub
[    0.372389] usbcore: registered new device driver usb
[    0.375075] efivars: Registered efivars operations
[    0.389652] vgaarb: loaded
[    0.443368] clocksource: Switched to clocksource riscv_clocksource
[    0.449125] pnp: PnP ACPI: disabled
[    0.499449] NET: Registered PF_INET protocol family
[    0.500979] IP idents hash table entries: 4096 (order: 3, 32768
bytes, linear)
[    0.507062] tcp_listen_portaddr_hash hash table entries: 128
(order: 0, 4096 bytes, linear)
[    0.507775] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.508351] TCP established hash table entries: 2048 (order: 2,
16384 bytes, linear)
[    0.508930] TCP bind hash table entries: 2048 (order: 5, 131072
bytes, linear)
[    0.509942] TCP: Hash tables configured (established 2048 bind 2048)
[    0.511459] UDP hash table entries: 256 (order: 2, 24576 bytes, linear)
[    0.512262] UDP-Lite hash table entries: 256 (order: 2, 24576 bytes, lin=
ear)
[    0.514937] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.521225] RPC: Registered named UNIX socket transport module.
[    0.521913] RPC: Registered udp transport module.
[    0.522324] RPC: Registered tcp transport module.
[    0.522656] RPC: Registered tcp-with-tls transport module.
[    0.523178] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.523787] PCI: CLS 0 bytes, default 64
[    0.529358] workingset: timestamp_bits=3D46 max_order=3D16 bucket_order=
=3D0
[    0.537946] NFS: Registering the id_resolver key type
[    0.539478] Key type id_resolver registered
[    0.539918] Key type id_legacy registered
[    0.540656] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.542911] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[    0.544894] 9p: Installing v9fs 9p2000 file system support
[    0.548517] NET: Registered PF_ALG protocol family
[    0.549459] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 245)
[    0.550658] io scheduler mq-deadline registered
[    0.552112] io scheduler kyber registered
[    0.552442] io scheduler bfq registered
[    0.556517] riscv-imsic: imsics@28000000:  hart-index-bits: 3,
guest-index-bits: 0
[    0.556955] riscv-imsic: imsics@28000000: group-index-bits: 0,
group-index-shift: 24
[    0.557403] riscv-imsic: imsics@28000000: per-CPU IDs 255 at base
PPN 0x0000000028000000
[    0.557699] riscv-imsic: imsics@28000000: total 2032 interrupts availabl=
e
[    0.561962] pci-host-generic 30000000.pci: host bridge
/soc/pci@30000000 ranges:
[    0.563422] pci-host-generic 30000000.pci:       IO
0x0003000000..0x000300ffff -> 0x0000000000
[    0.564475] pci-host-generic 30000000.pci:      MEM
0x0040000000..0x007fffffff -> 0x0040000000
[    0.565013] pci-host-generic 30000000.pci:      MEM
0x0400000000..0x07ffffffff -> 0x0400000000
[    0.566349] pci-host-generic 30000000.pci: Memory resource size
exceeds max for 32 bits
[    0.567633] pci-host-generic 30000000.pci: ECAM at [mem
0x30000000-0x3fffffff] for [bus 00-ff]
[    0.569300] pci-host-generic 30000000.pci: PCI host bridge to bus 0000:0=
0
[    0.570172] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.570559] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.570969] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7ffffff=
f]
[    0.571595] pci_bus 0000:00: root bus resource [mem 0x400000000-0x7fffff=
fff]
[    0.573646] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
conventional PCI endpoint
[    0.654069] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.659475] SuperH (H)SCI(F) driver initialized
[    0.675004] loop: module loaded
[    0.680024] e1000e: Intel(R) PRO/1000 Network Driver
[    0.680162] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.684590] usbcore: registered new interface driver uas
[    0.685245] usbcore: registered new interface driver usb-storage
[    0.686530] mousedev: PS/2 mouse device common for all mice
[    0.693125] syscon-poweroff poweroff: pm_power_off already claimed
for sbi_srst_power_off
[    0.694774] syscon-poweroff: probe of poweroff failed with error -16
[    0.698092] sdhci: Secure Digital Host Controller Interface driver
[    0.698484] sdhci: Copyright(c) Pierre Ossman
[    0.699333] Synopsys Designware Multimedia Card Interface Driver
[    0.699869] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.700673] usbcore: registered new interface driver usbhid
[    0.700920] usbhid: USB HID core driver
[    0.701501] riscv-pmu-sbi: SBI PMU extension is available
[    0.702263] riscv-pmu-sbi: 16 firmware and 18 hardware counters
[    0.702618] riscv-pmu-sbi: Perf sampling/filtering is not supported
as sscof extension is not available
[    0.709934] NET: Registered PF_INET6 protocol family
[    0.723647] Segment Routing with IPv6
[    0.724210] In-situ OAM (IOAM) with IPv6
[    0.724882] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.727936] NET: Registered PF_PACKET protocol family
[    0.729289] 9pnet: Installing 9P2000 support
[    0.729796] Key type dns_resolver registered
[    0.763394] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers
[    0.772054] riscv-aplic d000000.aplic: 96 interrupts forwared to
MSI base 0x0000000028000000
[    0.775578] virtio_blk virtio0: 1/0/0 default/read/poll queues
[    0.782792] virtio_blk virtio0: [vda] 65536 512-byte logical blocks
(33.6 MB/32.0 MiB)
[    0.827635] printk: legacy console [ttyS0] disabled
[    0.830784] 10000000.serial: ttyS0 at MMIO 0x10000000 (irq =3D 14,
base_baud =3D 230400) is a 16550A
[    0.833076] printk: legacy console [ttyS0] enabled
[    0.833076] printk: legacy console [ttyS0] enabled
[    0.833856] printk: legacy bootconsole [ns16550a0] disabled
[    0.833856] printk: legacy bootconsole [ns16550a0] disabled
[    0.843499] goldfish_rtc 101000.rtc: registered as rtc0
[    0.844980] goldfish_rtc 101000.rtc: setting system clock to
2024-01-30T10:19:33 UTC (1706609973)
[    0.848495] clk: Disabling unused clocks
[    0.884046] EXT4-fs (vda): warning: mounting unchecked fs, running
e2fsck is recommended
[    0.891369] EXT4-fs (vda): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode:
disabled.
[    0.892199] ext4 filesystem being mounted at /root supports
timestamps until 2038-01-19 (0x7fffffff)
[    0.892644] VFS: Mounted root (ext4 filesystem) on device 254:0.
[    0.895564] devtmpfs: mounted
[    0.986847] Freeing unused kernel image (initmem) memory: 2252K
[    0.988406] Run /sbin/init as init process
mount: mounting devtmpfs on /dev failed: Device or resource busy
           _  _
          | ||_|
          | | _ ____  _   _  _  _
          | || |  _ \| | | |\ \/ /
          | || | | | | |_| |/    \
          |_||_|_| |_|\____|\_/\_/

               Busybox Rootfs

Please press Enter to activate this console.
/ #
/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
      CPU6       CPU7
 10:        103        116         58        214         96         47
        78         52  RISC-V INTC   5 Edge      riscv-timer
 11:          0         44          0          0          0          0
         0          0  APLIC-MSI-d000000.aplic   8 Level     virtio0
 12:          0          0          0          0          0          0
         0          0  APLIC-MSI-d000000.aplic   7 Level     virtio1
 13:          0          0          0          6          0          0
         0          0  APLIC-MSI-d000000.aplic   6 Level     virtio2
 14:          0          0          0          0         64          0
         0          0  APLIC-MSI-d000000.aplic  10 Level     ttyS0
 15:          0          0          0          0          0          0
         0          0  APLIC-MSI-d000000.aplic  11 Level
101000.rtc
IPI0:         4          9         12          6          5         10
        13          7  Rescheduling interrupts
IPI1:       605        477        442        315        392        434
       405        417  Function call interrupts
IPI2:         0          0          0          0          0          0
         0          0  CPU stop interrupts
IPI3:         0          0          0          0          0          0
         0          0  CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0          0          0
         0          0  IRQ work interrupts
IPI5:         0          0          0          0          0          0
         0          0  Timer broadcast interrupts
/ #
/ #
/ # poweroff
/ # umount: devtmpfs busy - remounted read-only
[   24.504316] EXT4-fs (vda): re-mounted
00000000-0000-0000-0000-000000000000 ro. Quota mode: disabled.
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to[   26.543142] reboot: Power down


Regards,
Anup

