Return-Path: <linux-kernel+bounces-44547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DA184240D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496DE28748C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A635B6BB38;
	Tue, 30 Jan 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GueB1uq5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E526BB2C;
	Tue, 30 Jan 2024 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615180; cv=none; b=I1U4FqpLzarprCW03wiRa0oqhseUSO6reuU2miZm+36mlPfE0kxHMhRG6c0Qd20KwsXXXbSkx/W/dHNDoqlEJnRq303DHd04ZKHIkt0fbNtJrPyEVmxsofyBpG+D7Ht322IHMWnbwe0xYcjzQN+mVgarW8LgmbwiXWvlHD4vQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615180; c=relaxed/simple;
	bh=06r+eoDIdb0wUNK9nK1o7FDcwKFdTlsuHuRKweLT1c4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TP1WCV2mqilf35Y8LGnCFcXHh/DLBOR2L72iiLQMsgvQZc4EzZv3C9CKO9Bh4/0y9BBc9SIlW5qO5eu3gMSiostjPt2uRiX65JrdnQxucCUg96360oifWSOs11N7VgeLxiKSmnvLkHxdMMWqpDuVJj3nORGsDyyWyEu5BzdeKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GueB1uq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08963C43390;
	Tue, 30 Jan 2024 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706615179;
	bh=06r+eoDIdb0wUNK9nK1o7FDcwKFdTlsuHuRKweLT1c4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GueB1uq5VGej0m02UI0z6szNNF68tqP4GszcsjFOcw63xgdIneA5HtrM61SmR5G1N
	 qktGiqME3S+1Y0PEjqFDj2Zvdm79wGhhUtSSuFxc0uoOpNSKAND8GN5r5D6VctVrr6
	 FtcA34kp6rgV7zHn510vSmqNLGCns4S6qh6Jb27so0QrVL+oYtx4Bi2IOGBAa8qA6q
	 +kWsj9IQAi9WRO0/wSuiQrI/c+QXXREzkPQW5h/Qffj00WPpkb0+WNxE2omlQE1qU8
	 T3KZuavUIGgRulenfQ+iDBYvihanGQ9iUUVyG4mjOMkxyMD5HuylFg899ls+EkKVg2
	 yxxXuoVZgb60A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
 linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <CAK9=C2UYCKUBKggtM606orH2mBu_AbTdB5-R5AP1M0t-LsEbEQ@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87r0hzuw87.fsf@all.your.base.are.belong.to.us>
 <87le87uulb.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UYCKUBKggtM606orH2mBu_AbTdB5-R5AP1M0t-LsEbEQ@mail.gmail.com>
Date: Tue, 30 Jan 2024 12:46:16 +0100
Message-ID: <87cytjvybb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> On Tue, Jan 30, 2024 at 1:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>
>> > Anup Patel <apatel@ventanamicro.com> writes:
>> >
>> >> The RISC-V AIA specification is ratified as-per the RISC-V internatio=
nal
>> >> process. The latest ratified AIA specifcation can be found at:
>> >> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interr=
upts-1.0.pdf
>> >>
>> >> At a high-level, the AIA specification adds three things:
>> >> 1) AIA CSRs
>> >>    - Improved local interrupt support
>> >> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>> >>    - Per-HART MSI controller
>> >>    - Support MSI virtualization
>> >>    - Support IPI along with virtualization
>> >> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>> >>    - Wired interrupt controller
>> >>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI genera=
tor)
>> >>    - In Direct-mode, injects external interrupts directly into HARTs
>> >>
>> >> For an overview of the AIA specification, refer the AIA virtualization
>> >> talk at KVM Forum 2022:
>> >> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualizat=
ion_in_KVM_RISCV_final.pdf
>> >> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>> >>
>> >> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or h=
igher).
>> >>
>> >> These patches can also be found in the riscv_aia_v12 branch at:
>> >> https://github.com/avpatel/linux.git
>> >>
>> >> Changes since v11:
>> >>  - Rebased on Linux-6.8-rc1
>> >>  - Included kernel/irq related patches from "genirq, irqchip: Convert=
 ARM
>> >>    MSI handling to per device MSI domains" series by Thomas.
>> >>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH=
19,
>> >>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>> >>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233=
@linutronix.de/)
>> >>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanis=
m.
>> >>  - Updated IMSIC driver to support per-device MSI domains for PCI and
>> >>    platform devices.
>> >
>> > Thanks for working on this, Anup! I'm still reviewing the patches.
>> >
>> > I'm hitting a boot hang in text patching, with this series applied on
>> > 6.8-rc2. IPI issues?
>>
>> Not text patching! One cpu spinning in smp_call_function_many_cond() and
>> the others are in cpu_relax(). Smells like IPI...
>
> I tried bootefi from U-Boot multiple times but can't reproduce the
> issue you are seeing.

Thanks! I can reproduce without EFI, and simpler command-line:

qemu-system-riscv64 \
  -bios /path/to/fw_dynamic.bin \
  -kernel /path/to/Image \
  -append 'earlycon console=3Dtty0 console=3DttyS0' \
  -machine virt,aia=3Daplic-imsic \
  -no-reboot -nodefaults -nographic \
  -smp 4 \
  -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
  -device virtio-rng-device,rng=3Drng0 \
  -m 4G -chardev stdio,id=3Dchar0 -serial chardev:char0

I can reproduce with your upstream riscv_aia_v12 plus the config in the
gist [1], and all latest QEMU/OpenSBI:

QEMU: 11be70677c70 ("Merge tag 'pull-vfio-20240129' of https://github.com/l=
egoater/qemu into staging")
OpenSBI: bb90a9ebf6d9 ("lib: sbi: Print number of debug triggers found")
Linux: d9b9d6eb987f ("MAINTAINERS: Add entry for RISC-V AIA drivers")

Removing ",aia=3Daplic-imsic" from the CLI above completes the boot (i.e.
panicking about missing root mount ;-))


Bj=C3=B6rn

[1] https://gist.githubusercontent.com/bjoto/bac563e6dcaab68dba1a5eaf675d51=
aa/raw/ff6208fb17f27819dbe97ace7d034f385d2db657/gistfile1.txt



