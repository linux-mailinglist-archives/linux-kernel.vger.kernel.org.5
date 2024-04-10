Return-Path: <linux-kernel+bounces-137881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C563C89E8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2792873DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4D7C14F;
	Wed, 10 Apr 2024 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzYeFgVJ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F175BA50
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723255; cv=none; b=uKpwdUFidemS5UzCnpOgDPE1Rd8Bio2wAHHtJ9BRa2GN36aWz/6wsIkZZ49aYBtXtwQyAY/QTmoA5mAQ+3V5mvdbDOnmcxQ2mMFgiE8o3VPYigvNrX3Q4TQ88bHRVeSjJDhaGfSV7GOr8SOgQndBBOp6cssJ9ia3kB8OhSP1MWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723255; c=relaxed/simple;
	bh=PbThbDXv809IaEOM4OIswNTUbAnRn1pVRio7xqGAmek=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GuObLwNJnBA2oHnGD3ohov5uLDNHINMkJ20LPUpLW+JNX54KHLJA5ijWEmdobDpMWSl9cGD6KzT3ldluBpYyGelU8Fn8IBNXxMsojR0tvVuZZVhqg0hFWtUT7PU9iAsK8zIuuoeVTpPAtrL/KKxSPj7FKy0bYct4OU72PBHaLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzYeFgVJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so4836714a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712723253; x=1713328053; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrFBZdgD567Qbh4QE70HtghoHwa5Y0PZMSOGViHVEPk=;
        b=fzYeFgVJpx48OQaF0qFui96gqAeluzwHg4I7nF+Rdj8CT38xGAvOY7xZ5CpukB+FEf
         3Aj6IWM8NvbK1aXfuOVKg0HgO5AEaTYli5o0/aIks3ruUz9ianv8Qs2mXsZUapDnyXqX
         tOj9t8M1VWp9KuLq9JH2Hc4JwIOtOXlyxO1z7WlWJ4mRNDIoLgAxLDFKjj514i0y5978
         UeusOsq6p8IKV6wLhuqcYa82HP31f+unGvtyQ1HZElTq6AVCh/o4nPHVeKWfFg6hz7H9
         dMOguNWDjRR9dRZYiwLlvS2fD2wUEyoTkyuzwSSMRsllRieKHl69IIvTJvPw3t+tKsg1
         qdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723253; x=1713328053;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CrFBZdgD567Qbh4QE70HtghoHwa5Y0PZMSOGViHVEPk=;
        b=SrAJ2Bj9yPqiHQ/2GtmuTvT64/f3vOPraKEwb/mskWpS655nZR5bbCsLyRcj1dkJTW
         c7KuyaFo17b1zbm1NbuyCGLuI+7R4s+VHQDJQfaOUnGlG3TXwyfVpjy11fK4zaZvfVDo
         vOWseHJLsH+ZTUBs167NyMn9nN4rFSco4I8zBtCOZkAOaXdQ5inQj/MPyycpy0Ww3E6L
         pV8264Fi+cKM+FqIRQV88UCNB/MDYMJb8r8HHdC4kFl3AE8nOfeMMSTI24zEhmTLsUxJ
         g+6ajHOYZhSgwMFVkaroBeZ8vmHWrWRjuEEOzsm72kX98lXw01qFGyrE/RA4xeyWLUqw
         gvkw==
X-Forwarded-Encrypted: i=1; AJvYcCVqpGlfTob7+SnrYzX6zQnM6IJsndYTstoBHit6KoROsJgbV3yzrPrYvZaj0dzUJFmHQUafrJkaBiOw0hk0vWBKmto+vzJhD5pOCvKm
X-Gm-Message-State: AOJu0YzjrGZHZAtlNxxx4J5vf4PonL1hkKS2k2OnDPbDWngzQ7Iu/X6/
	fb/NvQFsCcT0y0hazEp58YvuCIFymhhBMTroRL3cMiRJriEAvont
X-Google-Smtp-Source: AGHT+IHqb6yoXBo/bPp88FBJ9ZQeVT5ORPmof29dpcy0rUhDIHRe3pyyMuvFre2RjAppxmlbApLcoQ==
X-Received: by 2002:a05:6a21:3993:b0:1a9:3e65:3488 with SMTP id ad19-20020a056a21399300b001a93e653488mr2250211pzc.25.1712723253306;
        Tue, 09 Apr 2024 21:27:33 -0700 (PDT)
Received: from localhost ([1.146.50.27])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902ed5500b001e2bbc0a672sm9781581plb.188.2024.04.09.21.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 21:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Apr 2024 14:26:07 +1000
Message-Id: <D0G5OX8W9NH9.1HE33RVAROAJK@gmail.com>
Subject: Re: Nohz_full on boot CPU is broken (was: Re: [PATCH v2 1/1] wq:
 Avoid using isolated cpus' timers on queue_delayed_work)
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Oleg Nesterov" <oleg@redhat.com>, "Frederic Weisbecker"
 <frederic@kernel.org>
Cc: "Tejun Heo" <tj@kernel.org>, "Leonardo Bras" <leobras@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>, "Junyao Zhao"
 <junzhao@redhat.com>, "Chris von Recklinghausen" <crecklin@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com> <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com> <20240405140449.GB22839@redhat.com>
 <ZhByg-xQv6_PC3Pd@localhost.localdomain>
 <20240407130914.GA10796@redhat.com>
 <ZhUu0uQxPgcXmQes@localhost.localdomain>
 <20240409130727.GC29396@redhat.com>
In-Reply-To: <20240409130727.GC29396@redhat.com>

On Tue Apr 9, 2024 at 11:07 PM AEST, Oleg Nesterov wrote:
> On 04/09, Frederic Weisbecker wrote:
> >
> > Le Sun, Apr 07, 2024 at 03:09:14PM +0200, Oleg Nesterov a =C3=A9crit :
> > > Well, the changelog says
> > >
> > >     nohz_full has been trialed at a large supercomputer site and foun=
d to
> > >     significantly reduce jitter. In order to deploy it in production,=
 they
> > >     need CPU0 to be nohz_full
> > >
> > > so I guess this feature has users.

It was the Summit/Sierra supercomputers which I suppose are still using
it. IIRC it was an existing job scheduler system they had which ran
housekeeping work on the highest numbered core in a socket and allocated
jobs from lowest number. We certainly asked if they could change that,
but apparently that was difficult. I'm surprised nobody ran into it on
x86 though. Maybe the system had more jitter (SMT4 doesn't help), so
maybe it wasn't needed to use isolcpus=3D in other cases.

The other thing is powerpc can boot on arbitrary CPU number. So if boot
CPU must be in the mask then it could randomly break your boot
config if boot CPU must be in HK mask.

> > >
> > > But after the commit aae17ebb53cd3da ("workqueue: Avoid using isolate=
d cpus'
> > > timers on queue_delayed_work") the kernel will crash at boot time if =
the boot
> > > CPU is nohz_full.
> >
> > Right but there are many possible calls to housekeeping on boot before =
the
> > first housekeeper becomes online.
>
> Well, it seems that other callers are more or less fine in this respect..=
.
> At least the kernel boots fine with that commit reverted.
>
> But a) I didn't try to really check, and b) this doesn't matter.
>
> I agree, and that is why I never blamed this change in queue_delayed_work=
().
>
> OK, you seem to agree with the patch below, I'll write the changelog/comm=
ent
> and send it "officially".
>
> Or did I misunderstand you?

Thanks for this. Taking a while to page this back in, the intention is
for housekeeping to be done by boot CPU until house keeper is awake, so
returning smp_processor_id() seems like the right thing to do here for
ephemeral jobs like timers and work, provided that CPU / mask is not
stored somewhere long term by the caller.

For things that set an affinity like kthread, sched, maybe managed
irqs, and such.

There are not many callers of housekeeping_any_cpu() so that's easy
enough to verify. But similar like housekeeping_cpumask() and others
could be an issue or at least a foot-gun, I'm not sure how well I
convinced myself of those.

Could you test like this?

  WARN_ON_ONCE(system_state =3D=3D SYSTEM_RUNNING ||
               type !=3D HK_TYPE_TIMER);

With a comment to say other ephemeral mask types could be exempted if
needed.

It would also be nice to warn for cases that would be bugs if the boot
CPU was not in the HK mask. Could that be done by having a
housekeepers_online() call after smp_init() (maybe at the start of
sched_init_smp()) that could verify there is at least one online, and
set a flag that could be used to create warnings.

Thanks,
Nick

>
> Oleg.
>
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..e912555c6fc8 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -46,7 +46,11 @@ int housekeeping_any_cpu(enum hk_type type)
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
> =20
> -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu =3D cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask)=
;
> +			if (cpu < nr_cpu_ids)
> +				return cpu;
> +
> +			WARN_ON_ONCE(system_state =3D=3D SYSTEM_RUNNING);
>  		}
>  	}
>  	return smp_processor_id();


