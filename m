Return-Path: <linux-kernel+bounces-45057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54996842B33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F8C1F2470F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4595914E2E2;
	Tue, 30 Jan 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNGWS6E1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754C14E2C6;
	Tue, 30 Jan 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636986; cv=none; b=V5Znex3TpRluNntu9Ls3MUGBHE6GiAPQDXAOa/jJR65nKJQTj2TOhGPTbdW8a+lcfMc4Lz+/p1dLoPujNI8cenr88PK7tWo0myWQGc+V0BH1yT5y6HUn04rfzTp2ecSTwzGp0uIV9ohJFD6/+NQn+BHzyjJ3r/5Mud1tj/9YS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636986; c=relaxed/simple;
	bh=kJXV07MUEtVMdHdtaRR8e9hS/CbpfxS5S2lVSsh0ySE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYzsv3hVlv4zaom0dO3Yo1PyHOpexliwOLO8/zPRI4V7vSn65cf+/VRHFubQWQl5c2ieeG2ksqHR4t3U5ljRpmjRd7kWsazUGv0Waq2X9+I/MLA6r0SkNvdeo6gEbAgZbweRezraiqBT6KYqbZvOKSAvQPELkUZvhiqNcMDPe6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNGWS6E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A5AC433F1;
	Tue, 30 Jan 2024 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706636985;
	bh=kJXV07MUEtVMdHdtaRR8e9hS/CbpfxS5S2lVSsh0ySE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RNGWS6E1+r+i86yta7lM/wwbLQFCTqiOSrr4oO10AKhC+Gmfa9LEqJ509yXcmUX5l
	 mBUZ+/bBuLRToL4EPlQUHnkax7paTNm8wDqCtriag7/E/fTEA4JRJ/pkOs0vwpd5t3
	 hX/Vr/p1rIMA+Te2WvFD9Kqq4fxuDhsy3Cr4OuvfUYo1eBNlhCe5ZpbpzpQfL+B8jH
	 2bMhji0bvJJBKhmNa1K5pgaJxldJ5DF0cuTBtjHnZJe+fTvtxerSK6YDkUB+HkRsCX
	 1dRZ7CbTwKiJxpj6A3zL5J1rI2DIM/Jauv+wKyerfclcM0fCe1sSprvrWKDEBRWDML
	 pANTOMb3R2ugA==
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
In-Reply-To: <CAK9=C2UEpbd+pHAMg-AuP-fTPZVho16u69oSjOHhsR11HTwiew@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87r0hzuw87.fsf@all.your.base.are.belong.to.us>
 <87le87uulb.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UYCKUBKggtM606orH2mBu_AbTdB5-R5AP1M0t-LsEbEQ@mail.gmail.com>
 <87cytjvybb.fsf@all.your.base.are.belong.to.us>
 <87ttmuq3m7.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UEpbd+pHAMg-AuP-fTPZVho16u69oSjOHhsR11HTwiew@mail.gmail.com>
Date: Tue, 30 Jan 2024 18:49:43 +0100
Message-ID: <87fryeognc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> On Tue, Jan 30, 2024 at 8:18=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>
>> > Anup Patel <apatel@ventanamicro.com> writes:
>> >
>> >> On Tue, Jan 30, 2024 at 1:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@=
kernel.org> wrote:
>> >>>
>> >>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>> >>>
>> >>> > Anup Patel <apatel@ventanamicro.com> writes:
>> >>> >
>> >>> >> The RISC-V AIA specification is ratified as-per the RISC-V intern=
ational
>> >>> >> process. The latest ratified AIA specifcation can be found at:
>> >>> >> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-in=
terrupts-1.0.pdf
>> >>> >>
>> >>> >> At a high-level, the AIA specification adds three things:
>> >>> >> 1) AIA CSRs
>> >>> >>    - Improved local interrupt support
>> >>> >> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>> >>> >>    - Per-HART MSI controller
>> >>> >>    - Support MSI virtualization
>> >>> >>    - Support IPI along with virtualization
>> >>> >> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>> >>> >>    - Wired interrupt controller
>> >>> >>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI ge=
nerator)
>> >>> >>    - In Direct-mode, injects external interrupts directly into HA=
RTs
>> >>> >>
>> >>> >> For an overview of the AIA specification, refer the AIA virtualiz=
ation
>> >>> >> talk at KVM Forum 2022:
>> >>> >> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtual=
ization_in_KVM_RISCV_final.pdf
>> >>> >> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>> >>> >>
>> >>> >> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (=
or higher).
>> >>> >>
>> >>> >> These patches can also be found in the riscv_aia_v12 branch at:
>> >>> >> https://github.com/avpatel/linux.git
>> >>> >>
>> >>> >> Changes since v11:
>> >>> >>  - Rebased on Linux-6.8-rc1
>> >>> >>  - Included kernel/irq related patches from "genirq, irqchip: Con=
vert ARM
>> >>> >>    MSI handling to per device MSI domains" series by Thomas.
>> >>> >>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, P=
ATCH19,
>> >>> >>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>> >>> >>     https://lore.kernel.org/linux-arm-kernel/20221121135653.20861=
1233@linutronix.de/)
>> >>> >>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mech=
anism.
>> >>> >>  - Updated IMSIC driver to support per-device MSI domains for PCI=
 and
>> >>> >>    platform devices.
>> >>> >
>> >>> > Thanks for working on this, Anup! I'm still reviewing the patches.
>> >>> >
>> >>> > I'm hitting a boot hang in text patching, with this series applied=
 on
>> >>> > 6.8-rc2. IPI issues?
>> >>>
>> >>> Not text patching! One cpu spinning in smp_call_function_many_cond()=
 and
>> >>> the others are in cpu_relax(). Smells like IPI...
>> >>
>> >> I tried bootefi from U-Boot multiple times but can't reproduce the
>> >> issue you are seeing.
>> >
>> > Thanks! I can reproduce without EFI, and simpler command-line:
>> >
>> > qemu-system-riscv64 \
>> >   -bios /path/to/fw_dynamic.bin \
>> >   -kernel /path/to/Image \
>> >   -append 'earlycon console=3Dtty0 console=3DttyS0' \
>> >   -machine virt,aia=3Daplic-imsic \
>> >   -no-reboot -nodefaults -nographic \
>> >   -smp 4 \
>> >   -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
>> >   -device virtio-rng-device,rng=3Drng0 \
>> >   -m 4G -chardev stdio,id=3Dchar0 -serial chardev:char0
>> >
>> > I can reproduce with your upstream riscv_aia_v12 plus the config in the
>> > gist [1], and all latest QEMU/OpenSBI:
>> >
>> > QEMU: 11be70677c70 ("Merge tag 'pull-vfio-20240129' of https://github.=
com/legoater/qemu into staging")
>> > OpenSBI: bb90a9ebf6d9 ("lib: sbi: Print number of debug triggers found=
")
>> > Linux: d9b9d6eb987f ("MAINTAINERS: Add entry for RISC-V AIA drivers")
>> >
>> > Removing ",aia=3Daplic-imsic" from the CLI above completes the boot (i=
e.
>> > panicking about missing root mount ;-))
>>
>> More context; The hang is during a late initcall, where an ftrace direct
>> (register_ftrace_direct()) modification is done.
>>
>> Stop machine is used to call into __ftrace_modify_call(). Then into the
>> arch specific patch_text_nosync(), where flush_icache_range() hangs in
>> flush_icache_all(). From "on_each_cpu(ipi_remote_fence_i, NULL, 1);" to
>> on_each_cpu_cond_mask() "smp_call_function_many_cond(mask, func, info,
>> scf_flags, cond_func);" which never returns from "csd_lock_wait(csd)"
>> right before the end of the function.
>>
>> Any ideas? Disabling CONFIG_HID_BPF, that does the early ftrace code
>> patching fixes the boot hang, but it does seem related to IPI...
>>
> Looks like flush_icache_all() does not use the IPIs (on_each_cpu()
> and friends) correctly.
>
> On other hand, the flush_icache_mm() does the right thing by
> doing local flush on the current CPU and IPI based flush on other
> CPUs.
>
> Can you try the following patch ?
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 55a34f2020a8..a3dfbe4de832 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -19,12 +19,18 @@ static void ipi_remote_fence_i(void *info)
>
>  void flush_icache_all(void)
>  {
> +    cpumask_t others;
> +
>      local_flush_icache_all();
>
> +    cpumask_andnot(&others, cpu_online_mask, cpumask_of(smp_processor_id=
()));
> +    if (cpumask_empty(&others))
> +        return;
> +
>      if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
> -        sbi_remote_fence_i(NULL);
> +        sbi_remote_fence_i(&others);
>      else
> -        on_each_cpu(ipi_remote_fence_i, NULL, 1);
> +        on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
>  }
>  EXPORT_SYMBOL(flush_icache_all);

Unfortunately, I see the same hang. LMK if you'd like me to try anything
else.


Bj=C3=B6rn

