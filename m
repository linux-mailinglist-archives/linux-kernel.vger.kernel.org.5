Return-Path: <linux-kernel+bounces-1542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E1814FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1BE1C2402C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D593EA92;
	Fri, 15 Dec 2023 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="DdE1mvda"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93B358A8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2030fbc2417so673682fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1702666370; x=1703271170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1j/kr7DabT2GwNTO7aTxaDhKyH0NDXQOeQEkDTIM9Y=;
        b=DdE1mvda2pqg7wK/Q/Ms74b4G8sLbrCjIXo6yeUf9QaVs9Qz6g0lSgRjQkpAHzcvp6
         3uYUeuSXBavsf5ulPmxG2bOLqTQb45rd7NfCQCf9slp4Qx11/qcPCkRJhDKI8NdIhDhD
         8Qzq69TGCVd+p1saOx/70E5rvq9dHG8AfxiL0cWZ03z7h/uilPgSyL2hybSBE94TU3uc
         xoSCSok1OFKdk3Y+pFbajNBRpM7QMxvYkrPYdpjmbEd/rs2xY2+fyiRVjHu+jYsE+I4E
         mlo3ghWHofEIszZ7GDIAkpoW9r3jR49XWI+2rB1uZrtgeRaTIT1IaIz2DKY+q6dVgft0
         7+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702666370; x=1703271170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1j/kr7DabT2GwNTO7aTxaDhKyH0NDXQOeQEkDTIM9Y=;
        b=Udzqfo5u8Ra2lKf3BLGjfKGn2GjuW0a4rFF5BHeFATL2ZNwuPLhHIY+1Yqw3KwMJuU
         MCLPbU/6iknhzhj95QZqYA6iphpbG5cTp7xskY0DU5c6qGJmo70+Hbpc8txrFNwjDRsk
         UQ5Bv2cSvjITR2+QEj95uOzXyTqp7yqn7n1iLcCl7vqDiWulo3X0Ry+4JtePyRdz09pB
         z46YnvGu9PqEzF1LKeq6zLLCTqZJpksjPOJpkld1w68mP5W8fXE1BgxF72FfDDtqIBx/
         UoQVUVu9ox7ZyCqxwGZIVWyMNSGodZMjz5lGRk0GAd6wK1t1QNba6mC+ahv6Kl8L3YG4
         fHDw==
X-Gm-Message-State: AOJu0Yy14ZHL7y6b1hDBzxXCmTdtAa5XzifpXoynCdd8H6uNDyYfitHR
	eC3mwCcSvDrgxqtH5+JoVD672k904PwYoHjAUFLxHA==
X-Google-Smtp-Source: AGHT+IFrVOGR9/l5kx+EYplmIUESVcg+goSGivI87+3cwlVZj/gGp4/fJnSxd3clBZcCgUxChDtTD0Nuon9B9bOs+z0=
X-Received: by 2002:a05:6871:7b8c:b0:1fb:75c:3ff2 with SMTP id
 pg12-20020a0568717b8c00b001fb075c3ff2mr17479561oac.82.1702666370622; Fri, 15
 Dec 2023 10:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214024727.3503870-1-vineeth@bitbyteword.org>
 <20231214024727.3503870-9-vineeth@bitbyteword.org> <87zfybml5w.ffs@tglx>
In-Reply-To: <87zfybml5w.ffs@tglx>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 15 Dec 2023 13:52:38 -0500
Message-ID: <CAO7JXPiFyLybt3F3bQca1iQqssYTwGn=ZyhXmutH84jUa_QVUg@mail.gmail.com>
Subject: Re: [RFC PATCH 8/8] irq: boost/unboost in irq/nmi entry/exit and softirq
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Suleiman Souhlal <suleiman@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

[...snip..]
> > +#ifdef CONFIG_PARAVIRT_SCHED
> > +     if (pv_sched_enabled() && !in_hardirq() && !local_softirq_pending() &&
> > +                     !need_resched() && !task_is_realtime(current))
> > +             pv_sched_unboost_vcpu();
> > +#endif
>
> Symmetry is overrated. Just pick a spot and slap your hackery in.
>
> Aside of that this whole #ifdeffery is tasteless at best.
>
> >       instrumentation_end();
>
> > +#ifdef CONFIG_PARAVIRT_SCHED
> > +     if (pv_sched_enabled())
> > +             pv_sched_boost_vcpu_lazy();
> > +#endif
>
> But what's worse is that this is just another approach of sprinkling
> random hints all over the place and see what sticks.
>
Understood. WIll have a full re-write of guest side logic for v2.

> Abusing KVM as the man in the middle to communicate between guest and
> host scheduler is creative, but ill defined.
>
> From the host scheduler POV the vCPU is just a user space thread and
> making the guest special is just the wrong approach.
>
> The kernel has no proper general interface to convey information from a
> user space task to the scheduler.
>
> So instead of adding some ad-hoc KVM hackery the right thing is to solve
> this problem from ground up in a generic way and KVM can just utilize
> that instead of having the special snow-flake hackery which is just a
> maintainability nightmare.
>
We had a constructive and productive discussion on the cover letter
thread and reaching a consensus on the kvm side of the design. Will
work towards that and post iterative revisions.

Thanks,
Vineeth

