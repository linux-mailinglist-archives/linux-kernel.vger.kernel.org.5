Return-Path: <linux-kernel+bounces-44767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559E84271F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC85A2876F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD87CF2F;
	Tue, 30 Jan 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccPzonpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60C6D1AD;
	Tue, 30 Jan 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626100; cv=none; b=FDuM6SwXorn830a99IXkbU/K3l6xd+kXSUDTaN0i81K2xyomfwTJbscARynV6sFr4f/u/+YIAoI9pWjgp+OhCwx7wuKxa8maPook1pz9HLUIR5ve3e4ca6UIOwHHAhHEhtmA2V017/o9ZUhwdlToRk5jzzCyYt4b5SJGzR2ixLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626100; c=relaxed/simple;
	bh=dFAmHTWb/k1pUfbCz9xzZr84exg5dJcjVhp+IOIvovc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PF/fu8bPH+ZK4EFdYcS8al9Hff2fI/XbFINthi/L9aNz+FZIf+VgdQTOuoxiQF7j/8TtX77YeWUD1qy2B5PEYzhimXa7heTpAUJqM/ABhLMyF539fNoK7pAsLDa9piNJW/FPp9FJFl/7nrwANa5ETyvFoSYhn6mQhwgvZ8yqxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccPzonpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B276C433A6;
	Tue, 30 Jan 2024 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626099;
	bh=dFAmHTWb/k1pUfbCz9xzZr84exg5dJcjVhp+IOIvovc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ccPzonpXZvS27V5JUZNxi0kUahPAKekIQhGPusg5QPgTYp8CfRCxAG1AJZA9N0i5r
	 Smf4s1pkGTIx/Ufs6ChVkqS5oMliJQ1UEcjAIqxXF6qLuh//tbujZ14JO9PQbTL65T
	 zDJ0mpHj5wTLvsVJU2F2rSxwM9qDBF3EOZArP9/fuXWbtQU9SThQ/+iuPREFvBzZtm
	 dYa9E51PI0w/22pMi0A59p+YHzdrg/JwYhbIHgAmjTWUi12o2zxJjZHkh2owElCHQ3
	 hCHMUJqu6ORBj3Q3Pv8WB8yZExflQfLFij3NLdzBQHRaab7VaNrrd/F0yV8LgXQsr0
	 wUcASiikCITfg==
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
In-Reply-To: <87cytjvybb.fsf@all.your.base.are.belong.to.us>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87r0hzuw87.fsf@all.your.base.are.belong.to.us>
 <87le87uulb.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UYCKUBKggtM606orH2mBu_AbTdB5-R5AP1M0t-LsEbEQ@mail.gmail.com>
 <87cytjvybb.fsf@all.your.base.are.belong.to.us>
Date: Tue, 30 Jan 2024 15:48:16 +0100
Message-ID: <87ttmuq3m7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Anup Patel <apatel@ventanamicro.com> writes:
>
>> On Tue, Jan 30, 2024 at 1:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>>
>>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>>
>>> > Anup Patel <apatel@ventanamicro.com> writes:
>>> >
>>> >> The RISC-V AIA specification is ratified as-per the RISC-V internati=
onal
>>> >> process. The latest ratified AIA specifcation can be found at:
>>> >> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-inter=
rupts-1.0.pdf
>>> >>
>>> >> At a high-level, the AIA specification adds three things:
>>> >> 1) AIA CSRs
>>> >>    - Improved local interrupt support
>>> >> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>>> >>    - Per-HART MSI controller
>>> >>    - Support MSI virtualization
>>> >>    - Support IPI along with virtualization
>>> >> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>>> >>    - Wired interrupt controller
>>> >>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI gener=
ator)
>>> >>    - In Direct-mode, injects external interrupts directly into HARTs
>>> >>
>>> >> For an overview of the AIA specification, refer the AIA virtualizati=
on
>>> >> talk at KVM Forum 2022:
>>> >> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualiza=
tion_in_KVM_RISCV_final.pdf
>>> >> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>>> >>
>>> >> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or =
higher).
>>> >>
>>> >> These patches can also be found in the riscv_aia_v12 branch at:
>>> >> https://github.com/avpatel/linux.git
>>> >>
>>> >> Changes since v11:
>>> >>  - Rebased on Linux-6.8-rc1
>>> >>  - Included kernel/irq related patches from "genirq, irqchip: Conver=
t ARM
>>> >>    MSI handling to per device MSI domains" series by Thomas.
>>> >>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATC=
H19,
>>> >>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>>> >>     https://lore.kernel.org/linux-arm-kernel/20221121135653.20861123=
3@linutronix.de/)
>>> >>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechani=
sm.
>>> >>  - Updated IMSIC driver to support per-device MSI domains for PCI and
>>> >>    platform devices.
>>> >
>>> > Thanks for working on this, Anup! I'm still reviewing the patches.
>>> >
>>> > I'm hitting a boot hang in text patching, with this series applied on
>>> > 6.8-rc2. IPI issues?
>>>
>>> Not text patching! One cpu spinning in smp_call_function_many_cond() and
>>> the others are in cpu_relax(). Smells like IPI...
>>
>> I tried bootefi from U-Boot multiple times but can't reproduce the
>> issue you are seeing.
>
> Thanks! I can reproduce without EFI, and simpler command-line:
>
> qemu-system-riscv64 \
>   -bios /path/to/fw_dynamic.bin \
>   -kernel /path/to/Image \
>   -append 'earlycon console=3Dtty0 console=3DttyS0' \
>   -machine virt,aia=3Daplic-imsic \
>   -no-reboot -nodefaults -nographic \
>   -smp 4 \
>   -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
>   -device virtio-rng-device,rng=3Drng0 \
>   -m 4G -chardev stdio,id=3Dchar0 -serial chardev:char0
>
> I can reproduce with your upstream riscv_aia_v12 plus the config in the
> gist [1], and all latest QEMU/OpenSBI:
>
> QEMU: 11be70677c70 ("Merge tag 'pull-vfio-20240129' of https://github.com=
/legoater/qemu into staging")
> OpenSBI: bb90a9ebf6d9 ("lib: sbi: Print number of debug triggers found")
> Linux: d9b9d6eb987f ("MAINTAINERS: Add entry for RISC-V AIA drivers")
>
> Removing ",aia=3Daplic-imsic" from the CLI above completes the boot (i.e.
> panicking about missing root mount ;-))

More context; The hang is during a late initcall, where an ftrace direct
(register_ftrace_direct()) modification is done.

Stop machine is used to call into __ftrace_modify_call(). Then into the
arch specific patch_text_nosync(), where flush_icache_range() hangs in
flush_icache_all(). From "on_each_cpu(ipi_remote_fence_i, NULL, 1);" to
on_each_cpu_cond_mask() "smp_call_function_many_cond(mask, func, info,
scf_flags, cond_func);" which never returns from "csd_lock_wait(csd)"
right before the end of the function.

Any ideas? Disabling CONFIG_HID_BPF, that does the early ftrace code
patching fixes the boot hang, but it does seem related to IPI...


