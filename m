Return-Path: <linux-kernel+bounces-48720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E984603F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B292876D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290038405F;
	Thu,  1 Feb 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0ZdmOBJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002A84FA8;
	Thu,  1 Feb 2024 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813153; cv=none; b=r6DMQKvLW30Yb8yIS0y4/xsQa0EQS/roP9zc57AZs7L2UYwh/hy7vPWNDp6vpiqgJCIMLpxUKy3rjS+hsYYk97I1mWdZxJhPpB9bG/OS0CA3t5nVfLyE3l2WAbNrosowN+IhPTPfaJxJhpqyrs0fOAr6mSmnMCuy0ZB0040Qyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813153; c=relaxed/simple;
	bh=2o/ahhkt5Da88tuJdKbbZRhXmWTFExDo+7XxsQ7oVYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/Hdbw9EtNpdL1GJA5HjV2cwS7ejDG4fuA2/LEmUCbvp27anV2TpJBqaeuJY7v8pGcLz86oVIs1DItrnWM8l5kAs9+W5CMp5mBSrP0NKFEuvx5K3jTG6FmzNDh96o15fY3n6rGwyl13l8aHqBqxlas3xjznmtNX4fl8a2X5YsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0ZdmOBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC48C433F1;
	Thu,  1 Feb 2024 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706813150;
	bh=2o/ahhkt5Da88tuJdKbbZRhXmWTFExDo+7XxsQ7oVYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=S0ZdmOBJIASmEToKqAwweWHUharcJbrOm7XEwIlMbJbqU/Z5d6O7MgLhMLxToW7fa
	 3qMOum1NuNKAXFxEv3wcvbsTYvBIxQukjg2XqhPlmV01Hxd6Hx806YBnI1QgWp1v3L
	 d+qmvY7J8fOteYOtKlpVON3n7u0fakqBBkRM/BQZ5RIgvvu+FHoxFyBBlUE/h7D3XQ
	 u0yRqoptcebxxI2OM7Dadf0GhXbQ8jpre0VXXrk0IuiKeTbggqilJesyAyhNPWIjr+
	 Ew4QD2ajVA8cTj1FbLwH2sLI1Jcb3Mz//nwbTIXOFPf8v4zCqU4TXvxD9G/4P6hQ6Z
	 egzTErOJ3GB6w==
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
In-Reply-To: <CAK9=C2UX0sRb5UbLdm8xwe1dP=x+enJRYzAuCPf6MdHTLTC_Cw@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87r0hzuw87.fsf@all.your.base.are.belong.to.us>
 <87le87uulb.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UYCKUBKggtM606orH2mBu_AbTdB5-R5AP1M0t-LsEbEQ@mail.gmail.com>
 <87cytjvybb.fsf@all.your.base.are.belong.to.us>
 <87ttmuq3m7.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UEpbd+pHAMg-AuP-fTPZVho16u69oSjOHhsR11HTwiew@mail.gmail.com>
 <87fryeognc.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UX0sRb5UbLdm8xwe1dP=x+enJRYzAuCPf6MdHTLTC_Cw@mail.gmail.com>
Date: Thu, 01 Feb 2024 19:45:47 +0100
Message-ID: <87v878dnvo.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> On Tue, Jan 30, 2024 at 11:19=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > On Tue, Jan 30, 2024 at 8:18=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
>> >>
>> >> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>> >>
>> >> > Anup Patel <apatel@ventanamicro.com> writes:
>> >> >
>> >> >> On Tue, Jan 30, 2024 at 1:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjo=
rn@kernel.org> wrote:
>> >> >>>
>> >> >>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>> >> >>>
>> >> >>> > Anup Patel <apatel@ventanamicro.com> writes:
>> >> >>> >
>> >> >>> >> The RISC-V AIA specification is ratified as-per the RISC-V int=
ernational
>> >> >>> >> process. The latest ratified AIA specifcation can be found at:
>> >> >>> >> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv=
-interrupts-1.0.pdf
>> >> >>> >>
>> >> >>> >> At a high-level, the AIA specification adds three things:
>> >> >>> >> 1) AIA CSRs
>> >> >>> >>    - Improved local interrupt support
>> >> >>> >> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>> >> >>> >>    - Per-HART MSI controller
>> >> >>> >>    - Support MSI virtualization
>> >> >>> >>    - Support IPI along with virtualization
>> >> >>> >> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>> >> >>> >>    - Wired interrupt controller
>> >> >>> >>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI=
 generator)
>> >> >>> >>    - In Direct-mode, injects external interrupts directly into=
 HARTs
>> >> >>> >>
>> >> >>> >> For an overview of the AIA specification, refer the AIA virtua=
lization
>> >> >>> >> talk at KVM Forum 2022:
>> >> >>> >> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virt=
ualization_in_KVM_RISCV_final.pdf
>> >> >>> >> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>> >> >>> >>
>> >> >>> >> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.=
2 (or higher).
>> >> >>> >>
>> >> >>> >> These patches can also be found in the riscv_aia_v12 branch at:
>> >> >>> >> https://github.com/avpatel/linux.git
>> >> >>> >>
>> >> >>> >> Changes since v11:
>> >> >>> >>  - Rebased on Linux-6.8-rc1
>> >> >>> >>  - Included kernel/irq related patches from "genirq, irqchip: =
Convert ARM
>> >> >>> >>    MSI handling to per device MSI domains" series by Thomas.
>> >> >>> >>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18=
, PATCH19,
>> >> >>> >>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>> >> >>> >>     https://lore.kernel.org/linux-arm-kernel/20221121135653.20=
8611233@linutronix.de/)
>> >> >>> >>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI m=
echanism.
>> >> >>> >>  - Updated IMSIC driver to support per-device MSI domains for =
PCI and
>> >> >>> >>    platform devices.
>> >> >>> >
>> >> >>> > Thanks for working on this, Anup! I'm still reviewing the patch=
es.
>> >> >>> >
>> >> >>> > I'm hitting a boot hang in text patching, with this series appl=
ied on
>> >> >>> > 6.8-rc2. IPI issues?
>> >> >>>
>> >> >>> Not text patching! One cpu spinning in smp_call_function_many_con=
d() and
>> >> >>> the others are in cpu_relax(). Smells like IPI...
>> >> >>
>> >> >> I tried bootefi from U-Boot multiple times but can't reproduce the
>> >> >> issue you are seeing.
>> >> >
>> >> > Thanks! I can reproduce without EFI, and simpler command-line:
>> >> >
>> >> > qemu-system-riscv64 \
>> >> >   -bios /path/to/fw_dynamic.bin \
>> >> >   -kernel /path/to/Image \
>> >> >   -append 'earlycon console=3Dtty0 console=3DttyS0' \
>> >> >   -machine virt,aia=3Daplic-imsic \
>> >> >   -no-reboot -nodefaults -nographic \
>> >> >   -smp 4 \
>> >> >   -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
>> >> >   -device virtio-rng-device,rng=3Drng0 \
>> >> >   -m 4G -chardev stdio,id=3Dchar0 -serial chardev:char0
>> >> >
>> >> > I can reproduce with your upstream riscv_aia_v12 plus the config in=
 the
>> >> > gist [1], and all latest QEMU/OpenSBI:
>> >> >
>> >> > QEMU: 11be70677c70 ("Merge tag 'pull-vfio-20240129' of https://gith=
ub.com/legoater/qemu into staging")
>> >> > OpenSBI: bb90a9ebf6d9 ("lib: sbi: Print number of debug triggers fo=
und")
>> >> > Linux: d9b9d6eb987f ("MAINTAINERS: Add entry for RISC-V AIA drivers=
")
>> >> >
>> >> > Removing ",aia=3Daplic-imsic" from the CLI above completes the boot=
 (i.e.
>> >> > panicking about missing root mount ;-))
>> >>
>> >> More context; The hang is during a late initcall, where an ftrace dir=
ect
>> >> (register_ftrace_direct()) modification is done.
>> >>
>> >> Stop machine is used to call into __ftrace_modify_call(). Then into t=
he
>> >> arch specific patch_text_nosync(), where flush_icache_range() hangs in
>> >> flush_icache_all(). From "on_each_cpu(ipi_remote_fence_i, NULL, 1);" =
to
>> >> on_each_cpu_cond_mask() "smp_call_function_many_cond(mask, func, info,
>> >> scf_flags, cond_func);" which never returns from "csd_lock_wait(csd)"
>> >> right before the end of the function.
>> >>
>> >> Any ideas? Disabling CONFIG_HID_BPF, that does the early ftrace code
>> >> patching fixes the boot hang, but it does seem related to IPI...
>> >>
>> > Looks like flush_icache_all() does not use the IPIs (on_each_cpu()
>> > and friends) correctly.
>> >
>> > On other hand, the flush_icache_mm() does the right thing by
>> > doing local flush on the current CPU and IPI based flush on other
>> > CPUs.
>> >
>> > Can you try the following patch ?
>> >
>> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>> > index 55a34f2020a8..a3dfbe4de832 100644
>> > --- a/arch/riscv/mm/cacheflush.c
>> > +++ b/arch/riscv/mm/cacheflush.c
>> > @@ -19,12 +19,18 @@ static void ipi_remote_fence_i(void *info)
>> >
>> >  void flush_icache_all(void)
>> >  {
>> > +    cpumask_t others;
>> > +
>> >      local_flush_icache_all();
>> >
>> > +    cpumask_andnot(&others, cpu_online_mask, cpumask_of(smp_processor=
_id()));
>> > +    if (cpumask_empty(&others))
>> > +        return;
>> > +
>> >      if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
>> > -        sbi_remote_fence_i(NULL);
>> > +        sbi_remote_fence_i(&others);
>> >      else
>> > -        on_each_cpu(ipi_remote_fence_i, NULL, 1);
>> > +        on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
>> >  }
>> >  EXPORT_SYMBOL(flush_icache_all);
>>
>> Unfortunately, I see the same hang. LMK if you'd like me to try anything
>> else.
>
> I was able to reproduce this at my end but I had to use your config.
>
> Digging further, it seems the issue is observed only when we use
> in-kernel IPIs for cache flushing (instead of SBI calls) along with
> some of the tracers (or debugging features) enabled. With the tracers
> (or debug features) disabled we don't see any issue. In fact, the
> upstream defconfig works perfectly fine with AIA drivers and
> in-kernel IPIs.

Same here. I only see the issue for *one* scenario. Other than that
scenario, AIA is working fine! We're doing ftrace text patching, and I
wonder if this is the issue. RISC-V (unfortunately) still rely on
stop_machine() text patching (which will change!).

Again, the hang is in stop_machine() context, where interrupts should
very much be disabled, right? So, triggering an IPI will be impossible.

Dumping mstatus in QEMU:
  | mstatus  0000000a000000a0
  | mstatus  0000000a000000a0
  | mstatus  0000000a000000a0
  | mstatus  0000000a000000a0

Indeed sstatus.SIE is 0.

Seems like the bug is that text patching is trying to issue an IPI:
  | [<ffffffff801145d4>] smp_call_function_many_cond+0x81e/0x8ba
  | [<ffffffff80114716>] on_each_cpu_cond_mask+0x3e/0xde
  | [<ffffffff80013968>] flush_icache_all+0x98/0xc4
  | [<ffffffff80009c26>] patch_text_nosync+0x7c/0x146
  | [<ffffffff80ef9116>] __ftrace_modify_call.constprop.0+0xca/0x120
  | [<ffffffff80ef918c>] ftrace_update_ftrace_func+0x20/0x40
  | [<ffffffff80efb8ac>] ftrace_modify_all_code+0x5a/0x1d8
  | [<ffffffff80efba50>] __ftrace_modify_code+0x26/0x42
  | [<ffffffff80131734>] multi_cpu_stop+0x14e/0x1d8
  | [<ffffffff8013107a>] cpu_stopper_thread+0x9e/0x182
  | [<ffffffff80077a04>] smpboot_thread_fn+0xf8/0x1d2
  | [<ffffffff800718fc>] kthread+0xe8/0x108
  | [<ffffffff80f1cde6>] ret_from_fork+0xe/0x20


Bj=C3=B6rn

