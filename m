Return-Path: <linux-kernel+bounces-44029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A7841C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008561C234A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61414EB49;
	Tue, 30 Jan 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkNCOetc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F164C60E;
	Tue, 30 Jan 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599004; cv=none; b=TgZ2c5eD/62we/+QI3F9cE/ss2adFDXiOb2GZzIRN244oK1QrdVAozBXzgf9oDi7GBtt1qY7LIz1KaX6eu+CIFf7vWirT1k1iEaFwaj9VcvNaPJ9QyPiq4tUhDV8XzaP/zx/XrlZ5qKyCDXAKM8uAHpilgEJFj/dihr604s1A8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599004; c=relaxed/simple;
	bh=ARcz4USU8r0bRTopPYmnEjrWA2aM7F+R+t/FlFe8cxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Utrl1YWp7TL3PjEU3fCa4Wn2y+uh9GEx6pByBByZaowmAJL6zUsy77A3r7weF44bmVzcyp/wb7+hFRNp69YJUP7n3BxySnA+qua3OmMkpMLF2wniW2UlTtZ+QPRdmxTjejy5a5lHVCD3+V513x6QEgekqsyMTAmf7/6sRf9y5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkNCOetc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E2CC433F1;
	Tue, 30 Jan 2024 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706599004;
	bh=ARcz4USU8r0bRTopPYmnEjrWA2aM7F+R+t/FlFe8cxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AkNCOetcPQd/Ss2HAxzXim17RcJFMDQvHN4QdOlOPN6s+/8ptoinzsCrStflmHeoQ
	 lMNxXo4ox70cTmfL3P2Rxz1He1sLBAOhdwGB2jxxztRWg6hWHjKmLXdCZ5TM+JONwe
	 Y6q4S2iAcbkoyplDUboaXJq4n4nJ+u6pm6kSI64VvjykVFBOR1OFnJlm/pkuMtXGf7
	 1+16nZOL1MV8YOhUNss5ZyRyH2Q8CaXeVGf412n269FBrGp9tb+A1jZb1TxryvRoNk
	 BhfNxjsocrlh7+QEN6OTIdDC/5BfQ8LHTmH88RySf/Gxwou7hcwVo6jNgnTZe0Uj2+
	 fMorUxt4KrQMg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, Atish
 Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
Date: Tue, 30 Jan 2024 08:16:40 +0100
Message-ID: <87r0hzuw87.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> The RISC-V AIA specification is ratified as-per the RISC-V international
> process. The latest ratified AIA specifcation can be found at:
> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts=
-1.0.pdf
>
> At a high-level, the AIA specification adds three things:
> 1) AIA CSRs
>    - Improved local interrupt support
> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>    - Per-HART MSI controller
>    - Support MSI virtualization
>    - Support IPI along with virtualization
> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>    - Wired interrupt controller
>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
>    - In Direct-mode, injects external interrupts directly into HARTs
>
> For an overview of the AIA specification, refer the AIA virtualization
> talk at KVM Forum 2022:
> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_=
in_KVM_RISCV_final.pdf
> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>
> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or highe=
r).
>
> These patches can also be found in the riscv_aia_v12 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v11:
>  - Rebased on Linux-6.8-rc1
>  - Included kernel/irq related patches from "genirq, irqchip: Convert ARM
>    MSI handling to per device MSI domains" series by Thomas.
>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH19,
>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@lin=
utronix.de/)
>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanism.
>  - Updated IMSIC driver to support per-device MSI domains for PCI and
>    platform devices.

Thanks for working on this, Anup! I'm still reviewing the patches.

I'm hitting a boot hang in text patching, with this series applied on
6.8-rc2. IPI issues?

I'm booting with U-boot UEFI.

kernel config:
https://gist.github.com/bjoto/bac563e6dcaab68dba1a5eaf675d51aa

QEMU 8.2.0/OpenSBI 1.4:
  | qemu-system-riscv64 \
  | 	-machine virt,acpi=3Doff,aia=3Daplic-imsic \
  | 	-cpu rv64,v=3Dtrue,vlen=3D256,elen=3D64,h=3Dtrue,zbkb=3Don,zbkc=3Don,z=
bkx=3Don,zkr=3Don,zkt=3Don,svinval=3Don,svnapot=3Don,svpbmt=3Don \
  | 	-smp 4 \
  | 	-object rng-random,filename=3D/dev/urandom,id=3Drng0 \
  | 	-device virtio-rng-device,rng=3Drng0 \
  | 	-append "root=3D/dev/vda2 rw earlycon console=3Dtty0 console=3DttyS0 p=
anic=3D-1 oops=3Dpanic sysctl.vm.panic_on_oom=3D1" \
  |     -m 4G \
  |     ...

Last lines from the kernel:
  | ...
  | goldfish_rtc 101000.rtc: registered as rtc0=20=20=20=20=20=20=20=20=20=
=20=20=20=20
  | goldfish_rtc 101000.rtc: setting system clock to 2024-01-30T06:39:28 UT=
C (1706596768)=20=20=20=20=20=20=20=20=20=20=20=20=20=20

Same kernel boots w/ "-machine virt,acpi=3Doff" (AIA is *not* enabled).

Related or not, I got this splat (once) a ftrace kselftest:
  | # selftests: ftrace: ftracetest-ktap
  | Unable to handle kernel paging request at virtual address 5a5a5a5a5a5a5=
ac2
  | Oops [#1]
  | Modules linked in: drm fuse i2c_core drm_panel_orientation_quirks backl=
ight dm_mod configfs ip_tables x_tables [last unloaded: trace_printk]
  | CPU: 2 PID: 19691 Comm: ls Tainted: G        W          6.8.0-rc2-kself=
test_plain #1
  | Hardware name: riscv-virtio,qemu (DT)
  | epc : set_top_events_ownership+0x14/0x5c
  |  ra : eventfs_get_attr+0x2e/0x50
  | epc : ffffffff80533aa4 ra : ffffffff80533b1a sp : ff20000001cebc70
  |  gp : ffffffff8258b860 tp : ff6000008623e240 t0 : ffffffff80533a98
  |  t1 : ffffffff825b6b60 t2 : 0000000000000008 s0 : ff20000001cebc80
  |  s1 : ffffffff8233c000 a0 : ff6000009224e9b8 a1 : ff20000001cebd28
  |  a2 : ff20000001cebd98 a3 : 000000000000025e a4 : ffffffff80000000
  |  a5 : 5a5a5a5a5a5a5a5a a6 : 0000000000000000 a7 : 0000000000735049
  |  s2 : 000000000000025e s3 : ff20000001cebd98 s4 : ff6000009224e9b8
  |  s5 : ff20000001cebd28 s6 : ffffffffffffff9c s7 : ff6000008ac6a1c0
  |  s8 : 00007fff9f685d80 s9 : 0000000000000000 s10: 00007fffd4550ef0
  |  s11: 0000000000000000 t3 : 0000000000000001 t4 : 0000000000000016
  |  t5 : ffffffff818145be t6 : ff6000009233d77e
  | status: 0000000200000120 badaddr: 5a5a5a5a5a5a5ac2 cause: 0000000000000=
00d
  | [<ffffffff80533aa4>] set_top_events_ownership+0x14/0x5c
  | Code: b297 ffad 82e7 d302 1141 e422 0800 3783 ff85 cb89 (57b8) 8b09=20
  | ---[ end trace 0000000000000000 ]---

This might be unrelated, but the hang above is on every boot.


Bj=C3=B6rn

