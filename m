Return-Path: <linux-kernel+bounces-165655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D6B8B8F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB212832E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070CB12FF87;
	Wed,  1 May 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7eUQT/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB46817C9B;
	Wed,  1 May 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584930; cv=none; b=kG7iDTDQTCM6hmB1ZKwAurAqXTfd5cLsj0yU7dIQHimCCWEVUNGRRQSCWM80f7Unc0SOE4yq0Roa542K7pIndKcw4dmLmx9GyONpS54AMj7/XHHcx3lcUvJa8D3BJRmzBWQ1adGtjkNrqaZYcWvoEQgyNq+VKBJx4lvJKzsRT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584930; c=relaxed/simple;
	bh=i5Yel4re/gpYyg9W0x9D7AVuSGIzMUN9waF0CV8LGiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIsCORz6v+EIjbCjLZD+AvHLt2E7wOuvBEqRKtTeuXLxqogCBYWBmYDTbQJk29wWCUDIxV2ZXyj2hEORKRSPa/VmOLdy1UUs7ecvvXfQXWR6sGkOvKDywLJ2z/9T53vG0rBBdhdwICuvSQGpw2yr6c49tzFC5Sd3xQZA+6lHMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7eUQT/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F6C4AF18;
	Wed,  1 May 2024 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714584929;
	bh=i5Yel4re/gpYyg9W0x9D7AVuSGIzMUN9waF0CV8LGiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n7eUQT/8mER933KsE9ph6iqTihSCWywhDiBnKKtOM/MK9itKMnUHn1SiKy9b5d2e+
	 d/m3W3goFdpo7WY0O06tLDaUK1tDBUuZVupR5/uMWFW699UBcoDeztC4L6IbAYrWMw
	 OHmZ44uYNxK+s4Cv+wY8Ufe4ruAguL8j6uctiUJ98z6N1OywGYhimrx85YHHgvD5GW
	 CaVDf04rnNdFEH3W/TrrI6oJBy+5s/DV8P2GpOv7XLIXBIN/0CXL3Cp5UH3gqNxkMT
	 rpJ+C40Esk8W9E5qwKIuqSmPzWM+Rqji5d08uOxb9aRE0frNfdwGsOcIsQFR9X65Se
	 tsbmpDVKgkeFg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572af0b12b8so654488a12.2;
        Wed, 01 May 2024 10:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSlxFypLulBhcFQmzid5j4FtjnGcgRkxxPd/HyhvTfcDggHO5pJ9NRIL58W9zFWSH4rqTU27bO2dAqvDdtGG9DGYr4IevRf+BHAZx5ODQWPJzb2QzqblcjEBVRIa1SuQpxCJ+rHhBmsQ97owlpfWg45efUuyZ3bQX4nxmOjDMJavfGJofuXSycikI9q0B10MS5oXA8hIgPipqFu6S9zM8u4ua0hJHnFVn0xPPk3k4jPR06Ceql+QJAWRMcZCoVzaC+ll12iN8=
X-Gm-Message-State: AOJu0YyORGou7V6HbOUAe/v1QzpvmUsPGj0r4+v86srXS5fhc1iSE95O
	nWEKcAkg7ZOPGEKgvNUzXdnAOgQkmfnrk15qsVvv7V7E71WDOKVRezP+lnW1tQ5vazeJDL0fdax
	xt7Pn155pLPGl4YepFZUmiwoHFa0=
X-Google-Smtp-Source: AGHT+IEhp06z8PCIlVF1hpW4hJBFp2boXUQOEcPvL4fU9iRfZCC258FtGJKDPaIGuDs/Gks4hDv4XD1KMR1DM4Yf91w=
X-Received: by 2002:a05:6402:11c8:b0:572:315a:b2d3 with SMTP id
 j8-20020a05640211c800b00572315ab2d3mr1958514edw.15.1714584927605; Wed, 01 May
 2024 10:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 2 May 2024 01:35:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT8a4PBU3ekZFNTi6EuETT9hhKfhXrPgGGpn92rQMNSvg@mail.gmail.com>
Message-ID: <CAJF2gTT8a4PBU3ekZFNTi6EuETT9hhKfhXrPgGGpn92rQMNSvg@mail.gmail.com>
Subject: Re: [PATCH v3] kprobe/ftrace: bail out if ftrace was killed
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 12:30=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> If an error happens in ftrace, ftrace_kill() will prevent disarming
> kprobes. Eventually, the ftrace_ops associated with the kprobes will be
> freed, yet the kprobes will still be active, and when triggered, they
> will use the freed memory, likely resulting in a page fault and panic.
>
> This behavior can be reproduced quite easily, by creating a kprobe and
> then triggering a ftrace_kill(). For simplicity, we can simulate an
> ftrace error with a kernel module like [1]:
>
> [1]: https://github.com/brenns10/kernel_stuff/tree/master/ftrace_killer
>
>   sudo perf probe --add commit_creds
>   sudo perf trace -e probe:commit_creds
>   # In another terminal
>   make
>   sudo insmod ftrace_killer.ko  # calls ftrace_kill(), simulating bug
>   # Back to perf terminal
>   # ctrl-c
>   sudo perf probe --del commit_creds
>
> After a short period, a page fault and panic would occur as the kprobe
> continues to execute and uses the freed ftrace_ops. While ftrace_kill()
> is supposed to be used only in extreme circumstances, it is invoked in
> FTRACE_WARN_ON() and so there are many places where an unexpected bug
> could be triggered, yet the system may continue operating, possibly
> without the administrator noticing. If ftrace_kill() does not panic the
> system, then we should do everything we can to continue operating,
> rather than leave a ticking time bomb.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> Changes in v3:
>   Don't expose ftrace_is_dead(). Create a "kprobe_ftrace_disabled"
>   variable and check it directly in the kprobe handlers.
> Link to v1/v2 discussion:
>   https://lore.kernel.org/all/20240426225834.993353-1-stephen.s.brennan@o=
racle.com/
>
>  arch/csky/kernel/probes/ftrace.c     | 3 +++
>  arch/loongarch/kernel/ftrace_dyn.c   | 3 +++
>  arch/parisc/kernel/ftrace.c          | 3 +++
>  arch/powerpc/kernel/kprobes-ftrace.c | 3 +++
>  arch/riscv/kernel/probes/ftrace.c    | 3 +++
>  arch/s390/kernel/ftrace.c            | 3 +++
>  arch/x86/kernel/kprobes/ftrace.c     | 3 +++
>  include/linux/kprobes.h              | 7 +++++++
>  kernel/kprobes.c                     | 6 ++++++
>  kernel/trace/ftrace.c                | 1 +
>  10 files changed, 35 insertions(+)
>
> diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/f=
trace.c
> index 834cffcfbce3..7ba4b98076de 100644
> --- a/arch/csky/kernel/probes/ftrace.c
> +++ b/arch/csky/kernel/probes/ftrace.c
> @@ -12,6 +12,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned l=
ong parent_ip,
>         struct kprobe_ctlblk *kcb;
>         struct pt_regs *regs;
>
> +       if (unlikely(kprobe_ftrace_disabled))
> +               return;
> +
For csky part.
Acked-by: Guo Ren <guoren@kernel.org>

>         bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
>         if (bit < 0)
>                 return;
> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/f=
trace_dyn.c
> index 73858c9029cc..bff058317062 100644
> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -287,6 +287,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned=
 long parent_ip,
>         struct kprobe *p;
>         struct kprobe_ctlblk *kcb;
>
> +       if (unlikely(kprobe_ftrace_disabled))
> +               return;
> +
>         bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
>         if (bit < 0)
>                 return;
> diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
> index 621a4b386ae4..c91f9c2e61ed 100644
> --- a/arch/parisc/kernel/ftrace.c
> +++ b/arch/parisc/kernel/ftrace.c
> @@ -206,6 +206,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned=
 long parent_ip,
>         struct kprobe *p;
>         int bit;
>
> +       if (unlikely(kprobe_ftrace_disabled))
> +               return;
> +
>         bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
>         if (bit < 0)
>                 return;
> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/k=
probes-ftrace.c
> index 072ebe7f290b..f8208c027148 100644
> --- a/arch/powerpc/kernel/kprobes-ftrace.c
> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> @@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned =
long parent_nip,
>         struct pt_regs *regs;
>         int bit;
>
> +       if (unlikely(kprobe_ftrace_disabled))
> +               return;
> +
>         bit =3D ftrace_test_recursion_trylock(nip, parent_nip);
>         if (bit < 0)
>                 return;
> diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes=
/ftrace.c
> index 7142ec42e889..a69dfa610aa8 100644
> --- a/arch/riscv/kernel/probes/ftrace.c
> +++ b/arch/riscv/kernel/probes/ftrace.c
> @@ -11,6 +11,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned l=
ong parent_ip,
>         struct kprobe_ctlblk *kcb;
>         int bit;
>
> +       if (unlikely(kprobe_ftrace_disabled))
> +               return;
> +
>         bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
>         if (bit < 0)
>                 return;
> diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> index c46381ea04ec..7f6f8c438c26 100644
> --- a/arch/s390/kernel/ftrace.c
> +++ b/arch/s390/kernel/ftrace.c
> @@ -296,6 +296,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned=
 long parent_ip,
>         struct kprobe *p;
>         int bit;
>
> +       if (unlikely(kprobe_ftrace_disabled))
> +               return;
> +
>         bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
>         if (bit < 0)
>                 return;
> diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/f=
trace.c
> index dd2ec14adb77..15af7e98e161 100644
> --- a/arch/x86/kernel/kprobes/ftrace.c
> +++ b/arch/x86/kernel/kprobes/ftrace.c
> @@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned l=
ong parent_ip,
>         struct kprobe_ctlblk *kcb;
>         int bit;
>
> +       if (unlikely(kprobe_ftrace_disabled))
> +               return;
> +
>         bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
>         if (bit < 0)
>                 return;
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 0ff44d6633e3..5fcbc254d186 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -378,11 +378,15 @@ static inline void wait_for_kprobe_optimizer(void) =
{ }
>  extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent=
_ip,
>                                   struct ftrace_ops *ops, struct ftrace_r=
egs *fregs);
>  extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
> +/* Set when ftrace has been killed: kprobes on ftrace must be disabled f=
or safety */
> +extern bool kprobe_ftrace_disabled __read_mostly;
> +extern void kprobe_ftrace_kill(void);
>  #else
>  static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
>  {
>         return -EINVAL;
>  }
> +static inline void kprobe_ftrace_kill(void) {}
>  #endif /* CONFIG_KPROBES_ON_FTRACE */
>
>  /* Get the kprobe at this addr (if any) - called with preemption disable=
d */
> @@ -495,6 +499,9 @@ static inline void kprobe_flush_task(struct task_stru=
ct *tk)
>  static inline void kprobe_free_init_mem(void)
>  {
>  }
> +static inline void kprobe_ftrace_kill(void)
> +{
> +}
>  static inline int disable_kprobe(struct kprobe *kp)
>  {
>         return -EOPNOTSUPP;
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 65adc815fc6e..166ebf81dc45 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1068,6 +1068,7 @@ static struct ftrace_ops kprobe_ipmodify_ops __read=
_mostly =3D {
>
>  static int kprobe_ipmodify_enabled;
>  static int kprobe_ftrace_enabled;
> +bool kprobe_ftrace_disabled;
>
>  static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>                                int *cnt)
> @@ -1136,6 +1137,11 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
>                 ipmodify ? &kprobe_ipmodify_ops : &kprobe_ftrace_ops,
>                 ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enab=
led);
>  }
> +
> +void kprobe_ftrace_kill()
> +{
> +       kprobe_ftrace_disabled =3D true;
> +}
>  #else  /* !CONFIG_KPROBES_ON_FTRACE */
>  static inline int arm_kprobe_ftrace(struct kprobe *p)
>  {
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index da1710499698..96db99c347b3 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7895,6 +7895,7 @@ void ftrace_kill(void)
>         ftrace_disabled =3D 1;
>         ftrace_enabled =3D 0;
>         ftrace_trace_function =3D ftrace_stub;
> +       kprobe_ftrace_kill();
>  }
>
>  /**
> --
> 2.39.3
>


--=20
Best Regards
 Guo Ren

