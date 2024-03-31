Return-Path: <linux-kernel+bounces-125951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F9892E92
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9CFB216F8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8F929AF;
	Sun, 31 Mar 2024 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd965e4V"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E515A5;
	Sun, 31 Mar 2024 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711858239; cv=none; b=tQQxYpsD7xImotlHOJfaLvUIQk0KPGVDER2tHTQJeTMvIR/0TKKEd01k3AiXsw0/MUQRPBTMcasGX86qX4nKm1SuDmEQ6lgkZ39j5nkveNnJmM34enHqwGupGerpLUwnl5kYlTG7x4zeaM8VTWKI2HOuqQbXhXfZJOu9c4NMEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711858239; c=relaxed/simple;
	bh=Rn3SGo+MzWeci+fPkgg+XuENnlbN+Hxkz6FOligAojo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5dLAFe3t0h9n9XXPR2loE/ls9RJevNPfZVgPqnCqh81WpRJO/qaYYPbpbgQt1mZzdTF4e8By3iH63FUZxWSA0Tm/pzlqMXBuuR1OakZvmCmQgJmvdz9h3ltIkJPFyltyJeLzYk5YoRKWdMQDz9Mm4in7oQzJkZNzCAyFtXMKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd965e4V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dee27acf7aso22186645ad.2;
        Sat, 30 Mar 2024 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711858237; x=1712463037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMDlz8LdZFn51uc3jze27982Eaa/1YXdXB2RdKvFjtc=;
        b=Wd965e4V6f4gfxkPXDs6F9Gjs927jervmc5BItuUgEhsxRjK2Ri2rbHul6Vdx606tH
         crfohi2HXk7N2thHvslsyXfjkJWKP8Mksu4Hfr2PmAXQ0YdfEXORUvsaNs9Ntmq7dZjJ
         KKLq3QR+DLff1mAXVQoOXlPc0LlCXTbPqcPULRSEG7ib2OqR4AePaBJDtdnWYsjEygN7
         ZDN8XwlEQOznpxzjiCstHG4JYzW6z1W7cDznCFvvo7gquR8yXm05F9Uea6JzUPupM5Z2
         jpRHtXfbsYAZwI8jq0LpRSorgK2InhEXxpb+LkXbUVuBK6UOjDvAg4SQnNxRdEVSiKlk
         FhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711858237; x=1712463037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMDlz8LdZFn51uc3jze27982Eaa/1YXdXB2RdKvFjtc=;
        b=odm23Rtpt9018nsVo5Xqy8I8jXWoi10IIiTGmGBx6jefDjO0yDpqrYYUsR02zecpjy
         SNScMbdnC+Xg/FcC2hoYanKH25XZQ2KgSnXHUTzq+ZRpGd469t1Wv5obTdoBfMaY3PfK
         MuxgSY7+6DRo+82+xIGiVjQKOy7ixvOeY2YAiAsPdqluwuMYMk/6al0TbK5bnVfYw+NQ
         aAh1eISssQKuC5rkuWQ/ujzWvEclDOMbcBP/l/0yxF1TzSBfdMVnlMXQNV2Ux2sxrjBI
         ZfRWAebn8cbyFYkcrL928x1Mow1rVoM12NMW14BSTdPSzuPgCtvIFuSL/2byIes7tU3w
         Z2ww==
X-Forwarded-Encrypted: i=1; AJvYcCUmUyr8GnhoGIMWOeoPAILeqfOG7iexR28PEsf1h04CitZkyQpFSpUmVHcggwjtjvAvq4r4jrjIbubgxrTymMCR9fslRp/6ZdpNLXUB/wq908UIhshqPcR5ktM54dyFwNIv
X-Gm-Message-State: AOJu0YyoGffXKTyoZtAa3zMCK30PS2MZsQwJgieRyOYKAweEJt+lcwTa
	XpFx4OINRPb7wXjWRqPCybaprKXdWBQ6Cd3XouKemtPu6D3LARyL7A3Y2lXC4tjklf4SUIr6gRV
	eLNeD3pt5Rwqb+Wh5RmVv2UrS+wQ=
X-Google-Smtp-Source: AGHT+IE4mw4XCJLp1/xxZgIEMlmfUVKYkQ+GDx5DCGCV3/EQ3v9nhf0ol+aHMcD7E7D8QesbIlbsn8lUHmHamvu4JNw=
X-Received: by 2002:a17:902:6f02:b0:1dd:d0b0:ca86 with SMTP id
 w2-20020a1709026f0200b001ddd0b0ca86mr6628208plk.59.1711858236761; Sat, 30 Mar
 2024 21:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329163722.2776730-1-andrii@kernel.org> <ZgfyVjoI+khgGQjy@gmail.com>
In-Reply-To: <ZgfyVjoI+khgGQjy@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 30 Mar 2024 21:10:23 -0700
Message-ID: <CAEf4BzZhHw7NKyoLK9LbiOiW_H1VPfzy0EF5mXKL0SMkxq+H8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf/x86/amd: support capturing LBR from software events
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@linutronix.de, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org, 
	kernel-team@meta.com, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 4:07=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > [0] added ability to capture LBR (Last Branch Records) on Intel CPUs
> > from inside BPF program at pretty much any arbitrary point.
>
> Upstream commit ID:
>
>    c22ac2a3d4bd ("perf: Enable branch record for software events")

will include this in commit message

>
> > [...] This is extremely useful capability that allows to figure out
> > otherwise hard-to-debug problems, because LBR is now available based
> > on some application-defined conditions, not just hardware-supported
> > events.
> >
> > retsnoop ([1]) is one such tool that takes a huge advantage of this
> > functionality and has proved to be an extremely useful tool in
> > practice.
> >
> > Now, AMD Zen4 CPUs got support for similar LBR functionality, but
> > necessary wiring inside the kernel is not yet setup. This patch seeks t=
o
> > rectify this and follows a similar approach to the original patch [0]
> > for Intel CPUs.
> >
> > Given LBR can be set up to capture any indirect jumps, it's critical to
> > minimize indirect jumps on the way to requesting LBR from BPF program,
> > so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
> > conditions vs always-inlined __amd_pmu_lbr_disable() called directly
> > from BPF subsystem (through perf_snapshot_branch_stack static call).
> >
> > This was tested on AMD Bergamo CPU and worked well when utilized from
> > the aforementioned retsnoop tool.
> >
> >   [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubravi=
ng@fb.com/
> >   [1] https://github.com/anakryiko/retsnoop
> >
> > Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
> >  arch/x86/events/amd/lbr.c    |  7 +------
> >  arch/x86/events/perf_event.h | 11 +++++++++++
> >  3 files changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> > index aec16e581f5b..88f6d0701342 100644
> > --- a/arch/x86/events/amd/core.c
> > +++ b/arch/x86/events/amd/core.c
> > @@ -618,7 +618,7 @@ static void amd_pmu_cpu_dead(int cpu)
> >       }
> >  }
> >
> > -static inline void amd_pmu_set_global_ctl(u64 ctl)
> > +static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
>
> What is this inlining change about? My first guess was that it's to
> generate better code, but my guess was wrong: it's to avoid branches.
> To not force people to guess, please put it into a separate patch & add
> an explanation.

ok, will do

>
> >  {
> >       wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
> >  }
> > @@ -878,6 +878,29 @@ static int amd_pmu_handle_irq(struct pt_regs *regs=
)
> >       return amd_pmu_adjust_nmi_window(handled);
> >  }
> >
> > +static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *=
entries, unsigned int cnt)
> > +{
> > +     struct cpu_hw_events *cpuc;
> > +     unsigned long flags;
> > +
> > +     /* must not have branches... */
> > +     local_irq_save(flags);
> > +     amd_pmu_core_disable_all();
> > +     __amd_pmu_lbr_disable();
> > +     /*            ... until here */
>
> Oh ... so it's not about performance or code layout, but to avoid new
> branches to contaminate the snapshot, right? Even stronger reason to
> put that change into a separate patch.
>

yep

> > +
> > +     cpuc =3D this_cpu_ptr(&cpu_hw_events);
> > +
> > +     amd_pmu_lbr_read();
> > +     cnt =3D min_t(unsigned int, cnt, x86_pmu.lbr_nr);
>
> Why is min_t() used here? AFAICT all types here are 'unsigned int'.

you are right, seems like it's all unsigned int, so I will drop min_t.
Not sure why the original Intel implementation used min_t().

>
> > +     memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entr=
y) * cnt);
>
> The function could use a description comment explaining the arguments,
> and that the caller must make sure there's enough space in the
> 'entries' array.
>

There is a comment next to perf_snapshot_branch_stack static call
definition in include/linux/perf_event.h. I'll include a comment that
amd_pmu_v2_snapshot_branch_stack() is an AMD-specific "implementation"
of that static call, so user can refer to it for documentation (which
would be kept in one place this way, instead of copy/pasting it
between Intel and AMD implementations).

> > +
> > +     amd_pmu_v2_enable_all(0);
> > +     local_irq_restore(flags);
> > +
> > +     return cnt;
> > +}
> > +
> >  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
> >  {
> >       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> > @@ -1414,6 +1437,10 @@ static int __init amd_core_pmu_init(void)
> >               static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_rese=
t);
> >               static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
> >               static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
> > +
> > +             /* only support branch_stack snapshot on perfmon v2 */
> > +             if (x86_pmu.handle_irq =3D=3D amd_pmu_v2_handle_irq)
> > +                     static_call_update(perf_snapshot_branch_stack, am=
d_pmu_v2_snapshot_branch_stack);
>
> >       } else if (!amd_brs_init()) {
> >               /*
> >                * BRS requires special event constraints and flushing on=
 ctxsw.
>
> Please use consistent capitalization in all new comments you add:
>
>         /* Properly capitalized comment */
>

ack

>
> > diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> > index 4a1e600314d5..0e4de028590d 100644
> > --- a/arch/x86/events/amd/lbr.c
> > +++ b/arch/x86/events/amd/lbr.c
> > @@ -412,16 +412,11 @@ void amd_pmu_lbr_enable_all(void)
> >  void amd_pmu_lbr_disable_all(void)
> >  {
> >       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> > -     u64 dbg_ctl, dbg_extn_cfg;
> >
> >       if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
> >               return;
> >
> > -     rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> > -     rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> > -
> > -     wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN=
);
> > -     wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_O=
N_PMI);
> > +     __amd_pmu_lbr_disable();
> >  }
> >
> >  __init int amd_pmu_lbr_init(void)
> > diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.=
h
> > index fb56518356ec..4dddf0a7e81e 100644
> > --- a/arch/x86/events/perf_event.h
> > +++ b/arch/x86/events/perf_event.h
> > @@ -1329,6 +1329,17 @@ void amd_pmu_lbr_enable_all(void);
> >  void amd_pmu_lbr_disable_all(void);
> >  int amd_pmu_lbr_hw_config(struct perf_event *event);
> >
> > +static __always_inline void __amd_pmu_lbr_disable(void)
> > +{
> > +     u64 dbg_ctl, dbg_extn_cfg;
> > +
> > +     rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> > +     rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> > +
> > +     wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN=
);
> > +     wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_O=
N_PMI);
> > +}
> > +
>
> This factoring out of __amd_pmu_lbr_disable() should be in a separate
> preparatory patch too.
>

ok

> Thanks,
>
>         Ingo

