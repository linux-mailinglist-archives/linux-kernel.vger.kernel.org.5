Return-Path: <linux-kernel+bounces-108428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC8880A68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E4B1F22B03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E2012B97;
	Wed, 20 Mar 2024 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KXq+jk2h"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF61427A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710909607; cv=none; b=PPlby4mrM1QKPQE6NImCoZpnYZXdZK3f4+bZk4R5jYhKEiQIDgniboA7cQH9OdvMeMRHe7jt7aSYubeKQb8HbmArjl32xHYIIHKuoItrHG9+rDMhg5ZrLfPbEOckyeIrX1L7O/bceEhFU/Hba6ITX7atKQYUJRGENhTr3f9rA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710909607; c=relaxed/simple;
	bh=wIMtGfVll/5PVHjMPpijDZTY31O36QHFM7YWE0N+6s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNkwWH8xuSu9IaGA7+4WPbUr5rkUWzdIUJbg+4SsQOAxC5/pe1KcNJq/eRNQDKwjfJclXB3yqDKt6l6+cIYXmgL6dS+NgAFcFw1VqDAb9Nm7dC0I1hajT0D2sbCPDIxbNfRdSGpvUK46cHF3vFSfvVTnyS5siLInD8EtIHLKHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KXq+jk2h; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so5182342276.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710909603; x=1711514403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOcEqvOqLiRgD+vxwVroLkV65fGdVjagF231/Ug6vZ0=;
        b=KXq+jk2hxfFAyyOH7s3bexJYVW7JiR0TcjDrb9dF889eb6G95zir8mIKTklutXSvtw
         KBKheD8PJJT4TmqpvvKXlc40kV1xdvlNWoxs0Z4Xpp1VsLfcZ4tZk38XroilPywh0RwM
         vC/fMTFrzCYsJxe72KEAmyKCRfeNvQpGDdYS7y0h3juV0SWqMB1lq+Zm6W+oCklUPd/o
         VD37okA3SALVa9D+kX2WwGmi05P8M7xXmEGdSC3rmgDng0PyH4dsXg4JUG7G/Seaf1BJ
         iQRcR1KYv9TqYbmzp5dwulEVxZzR0Hr0PSRLYmeHuF8wCUcO9F35/TT+TojxIuyHGx7e
         YU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710909603; x=1711514403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOcEqvOqLiRgD+vxwVroLkV65fGdVjagF231/Ug6vZ0=;
        b=TyG7OigAg9Jfb79AlWk9Z1LMpoqEncpYUJkGFlK8BEspr9OT5Qdskno4AP5iAOt+zW
         i2PpPpYG/rp3TvTA5U4Ygizt6tuIgguWxjxIDuG23VxpBJPPOCU2PyQgQnn0FMFxE/ea
         QthCViCSQCOJLVH+5STE6TwWJrGFHqUB39eSOV2lA5BTbNJ7GqhE4ARx4pTu+MqOP35q
         XahGtD3cobA8Uk6Zn/u1KIVdqw5yfpJRBmVchMI4vAC6B2BHlyJlgFAsQEyt1XTFtcFh
         n7rqMY8GXMizb2fnr7R40mo3ouKea6k3emxzmZuoy0RhaRjkOcySoCxddBsgl/098vYM
         e7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVlv6ovlyzN6QBRNVcLOgQOrnt81X8NW5XSTySpZq0wIc87M7UFFDtZG09hcOpZmVtzztqTnhtO/NH2Ne+LEuRIlYlqc6oD10OMGqcJ
X-Gm-Message-State: AOJu0YxD0btf+w+J31EeuN6F/qxMsklOTjWMAa0oGD+Iv2t7ncAVdWKy
	NqzgG82/+NwNYU5WhzSNW+Co2WlaZHb9hMamqiNGp3kOmvNk1mTzhpASY00a4tuo4hQESf24rGc
	N7WcVl4xvtac38yK74adYL3qXzm03RXlf8RY64A==
X-Google-Smtp-Source: AGHT+IFi8oiVX5pjKC9ntqVOdhWO3c/z5P7ohNgAfHf1bUqmybc/0rIf4kuJ8sH9/5U2MG51vTiOLcXZ5b5tjWWx5eA=
X-Received: by 2002:a25:ad46:0:b0:dc2:2f4f:757 with SMTP id
 l6-20020a25ad46000000b00dc22f4f0757mr14257691ybe.7.1710909603558; Tue, 19 Mar
 2024 21:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com> <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
In-Reply-To: <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 19 Mar 2024 21:39:52 -0700
Message-ID: <CAKC1njQYZHbQJ71mapeG1DEw=A+aGx77xsuQGecsNFpoJ=tzGQ@mail.gmail.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org, 
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

Thanks for your response.

On Tue, Mar 19, 2024 at 7:21=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Deepak,
>
> On 2024-03-19 6:55 PM, Deepak Gupta wrote:
> > On Tue, Mar 19, 2024 at 2:59=E2=80=AFPM Samuel Holland via lists.riscv.=
org
> > <samuel.holland=3Dsifive.com@lists.riscv.org> wrote:
> >>
> >> Some envcfg bits need to be controlled on a per-thread basis, such as
> >> the pointer masking mode. However, the envcfg CSR value cannot simply =
be
> >> stored in struct thread_struct, because some hardware may implement a
> >> different subset of envcfg CSR bits is across CPUs. As a result, we ne=
ed
> >> to combine the per-CPU and per-thread bits whenever we switch threads.
> >>
> >
> > Why not do something like this
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
> > index b3400517b0a9..01ba87954da2 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -202,6 +202,8 @@
> >  #define ENVCFG_CBIE_FLUSH              _AC(0x1, UL)
> >  #define ENVCFG_CBIE_INV                        _AC(0x3, UL)
> >  #define ENVCFG_FIOM                    _AC(0x1, UL)
> > +/* by default all threads should be able to zero cache */
> > +#define ENVCFG_BASE                    ENVCFG_CBZE
>
> Linux does not assume Sstrict, so without Zicboz being present in DT/ACPI=
, we
> have no idea what the CBZE bit does--there's no guarantee it has the stan=
dard
> meaning--so it's not safe to set the bit unconditionally. If that policy
> changes, we could definitely simplify the code.
>

Yeah, it makes sense.

> >  /* Smstateen bits */
> >  #define SMSTATEEN0_AIA_IMSIC_SHIFT     58
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 4f21d970a129..2420123444c4 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -152,6 +152,7 @@ void start_thread(struct pt_regs *regs, unsigned lo=
ng pc,
> >         else
> >                 regs->status |=3D SR_UXL_64;
> >  #endif
> > +       current->thread_info.envcfg =3D ENVCFG_BASE;
> >  }
> >
> > And instead of context switching in `_switch_to`,
> > In `entry.S` pick up `envcfg` from `thread_info` and write it into CSR.
>
> The immediate reason is that writing envcfg in ret_from_exception() adds =
cycles
> to every IRQ and system call exit, even though most of them will not chan=
ge the
> envcfg value. This is especially the case when returning from an IRQ/exce=
ption
> back to S-mode, since envcfg has zero effect there.
>
> The CSRs that are read/written in entry.S are generally those where the v=
alue
> can be updated by hardware, as part of taking an exception. But envcfg ne=
ver
> changes on its own. The kernel knows exactly when its value will change, =
and
> those places are:
>
>  1) Task switch, i.e. switch_to()
>  2) execve(), i.e. start_thread() or flush_thread()
>  3) A system call that specifically affects a feature controlled by envcf=
g

Yeah I was optimizing for a single place to write instead of
sprinkling at multiple places.
But I see your argument. That's fine.

>
> So that's where this series writes it. There are a couple of minor tradeo=
ffs
> about when exactly to do the write:
>
> - We could drop the sync_envcfg() calls outside of switch_to() by reading=
 the
>   current CSR value when scheduling out a thread, but again that adds ove=
rhead
>   to the fast path to remove a tiny bit of code in the prctl() handlers.
> - We don't need to write envcfg when switching to a kernel thread, only w=
hen
>   switching to a user thread, because kernel threads never leave S-mode, =
so
>   envcfg doesn't affect them. But checking the thread type takes many mor=
e
>   instructions than just writing the CSR.
>
> Overall, the optimal implementation will approximate the rule of only wri=
ting
> envcfg when its value changes.
>
> > This construction avoids
> > - declaring per cpu riscv_cpu_envcfg
>
> This is really a separate concern than when we write envcfg. The per-CPU
> variable is only necessary to support hardware where a subset of harts su=
pport
> Zicboz. Since the riscv_cpu_has_extension_[un]likely() helpers were added
> specifically for Zicboz, I assume this is an important use case, and drop=
ping
> support for this hardware would be a regression. After all, hwprobe() all=
ows
> userspace to see that Zicboz is implemented at a per-CPU level. Maybe And=
rew can
> weigh in on that.

I am not sure of the practicality of this heterogeneity for Zicboz and
for that matter any of the upcoming
features that'll be enabled via senvcfg (control flow integrity,
pointer masking, etc).

As an example if cache zeroing instructions are used by app binary, I
expect it to be used in following
manner

 - Explicitly inserting cbo.zero by application developer
 - Some compiler flag which ensures that structures larger than cache
line gets zeroed by cbo.zero

In either of the cases, the developer is not expecting to target it to
a specific hart on SoC and instead expect it to work.
There might be libraries (installed via sudo apt get) with cache zero
support in them which may run in different address spaces.
Should the library be aware of the CPU on which it's running. Now
whoever is running these binaries should be aware which CPUs
they get assigned to in order to avoid faults?

That seems excessive, doesn't it?

>
> If we decide to enable Zicboz only when all harts support it, or we decid=
e it's
> safe to attempt to set the envcfg.CBZE bit on harts that do not declare s=
upport
> for Zicboz, then we could drop the percpu variable.
>
> > - syncing up
> > - collection of *envcfg bits.
> >
> >
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >> ---
> >>
> >>  arch/riscv/include/asm/cpufeature.h |  2 ++
> >>  arch/riscv/include/asm/processor.h  |  1 +
> >>  arch/riscv/include/asm/switch_to.h  | 12 ++++++++++++
> >>  arch/riscv/kernel/cpufeature.c      |  4 +++-
> >>  4 files changed, 18 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/=
asm/cpufeature.h
> >> index 0bd11862b760..b1ad8d0b4599 100644
> >> --- a/arch/riscv/include/asm/cpufeature.h
> >> +++ b/arch/riscv/include/asm/cpufeature.h
> >> @@ -33,6 +33,8 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> >>  /* Per-cpu ISA extensions. */
> >>  extern struct riscv_isainfo hart_isa[NR_CPUS];
> >>
> >> +DECLARE_PER_CPU(unsigned long, riscv_cpu_envcfg);
> >> +
> >>  void riscv_user_isa_enable(void);
> >>
> >>  #ifdef CONFIG_RISCV_MISALIGNED
> >> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/a=
sm/processor.h
> >> index a8509cc31ab2..06b87402a4d8 100644
> >> --- a/arch/riscv/include/asm/processor.h
> >> +++ b/arch/riscv/include/asm/processor.h
> >> @@ -118,6 +118,7 @@ struct thread_struct {
> >>         unsigned long s[12];    /* s[0]: frame pointer */
> >>         struct __riscv_d_ext_state fstate;
> >>         unsigned long bad_cause;
> >> +       unsigned long envcfg;
> >>         u32 riscv_v_flags;
> >>         u32 vstate_ctrl;
> >>         struct __riscv_v_ext_state vstate;
> >> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/a=
sm/switch_to.h
> >> index 7efdb0584d47..256a354a5c4a 100644
> >> --- a/arch/riscv/include/asm/switch_to.h
> >> +++ b/arch/riscv/include/asm/switch_to.h
> >> @@ -69,6 +69,17 @@ static __always_inline bool has_fpu(void) { return =
false; }
> >>  #define __switch_to_fpu(__prev, __next) do { } while (0)
> >>  #endif
> >>
> >> +static inline void sync_envcfg(struct task_struct *task)
> >> +{
> >> +       csr_write(CSR_ENVCFG, this_cpu_read(riscv_cpu_envcfg) | task->=
thread.envcfg);
> >> +}
> >> +
> >> +static inline void __switch_to_envcfg(struct task_struct *next)
> >> +{
> >> +       if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV=
_ISA_EXT_XLINUXENVCFG))
> >
> > I've seen `riscv_cpu_has_extension_unlikely` generating branchy code
> > even if ALTERNATIVES was turned on.
> > Can you check disasm on your end as well.  IMHO, `entry.S` is a better
> > place to pick up *envcfg.
>
> The branchiness is sort of expected, since that function is implemented b=
y
> switching on/off a branch instruction, so the alternate code is necessari=
ly a
> separate basic block. It's a tradeoff so we don't have to write assembly =
code
> for every bit of code that depends on an extension. However, the cost sho=
uld be
> somewhat lowered since the branch is unconditional and so entirely predic=
table.
>
> If the branch turns out to be problematic for performance, then we could =
use
> ALTERNATIVE directly in sync_envcfg() to NOP out the CSR write.

Yeah I lean towards using alternatives directly.

>
> >> +               sync_envcfg(next);
> >> +}

>

