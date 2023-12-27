Return-Path: <linux-kernel+bounces-12074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4BC81EFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7185C1C2185A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036E4595D;
	Wed, 27 Dec 2023 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWO1M44Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE345947;
	Wed, 27 Dec 2023 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbdacafe012so3540802276.1;
        Wed, 27 Dec 2023 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703689792; x=1704294592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGTGbIzmVo6wjApUgMAJsks6j6e1/ihs+OGZr6ChxnU=;
        b=FWO1M44QqO+LH7tB/PXvtUurftTRscY+ZQCdg2EErUCc1a3GgXN4v2JgkgGY16+B0q
         NEOKyiMiEFKRK/VU6+aGAQs7cS1u8tDVFS89CPrHXvPQfxuVVYPrhzTO8YiI76MmfMiT
         BmjJtxVzt4YTSa697poiEQgDfOZ/zAlLFCOG0BEo8flcpAfMZbS+CUrqOmUivzW77lwj
         yUibByVyyR8lzZdTspq2Far9lajEjINSanGbOpyFIzw5rccxhtlC/KDmzMROqyTNBJZ/
         9IB/kAR0eVxqAle6wlEUlIJZ6yr8U90raVmf8n1gMEV1O9ZbM/Z9bh0vkmXOyywU87LW
         80fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703689792; x=1704294592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGTGbIzmVo6wjApUgMAJsks6j6e1/ihs+OGZr6ChxnU=;
        b=Wk7VHyZ76FLXV1AFAZQU70vKvDUeg3jeYTrYZi5e8o8p4nbDigOtAG4zdhemmfdGsO
         J+F2kbV265iM4pAX+pf+AdrIRk/ZiKdUU+oA310DCfaGzD2Di1QSKspIbu41oZJ2fC7+
         4hou7ZJ3hcIyVoS4wGsTnu5EGiQAfwr84pLkoPI/3FPJmy7j+fXuz5tRl7i9Omk51p2a
         HaNKd58msWZsLUoBIlZkZgWzI4PdJztnj0gfWi2vPATdVEsNsteS2lCTTYsLeLesF7qc
         INTA0PZfCX1d2AFFhsGTnEI64+lBmKXVv98Vgo6cI1ZSWQXxCAOOMUnYlJR+VhZpiZq8
         gZLQ==
X-Gm-Message-State: AOJu0Yw3v5Kphn9V+HSrm8RLWqM76DDT7GMx6aea4NWaUe6iL4WXOgNn
	rosEMr4UsWcwh4csKBk2fZ3SI60OfZrJ/lp4YiWTaFwsHMnFBg==
X-Google-Smtp-Source: AGHT+IGpXWEkLPhICxfrADQ+Q7PUiH7sPMpD/11YbCXuHney2wCefry49tYlTt2lHR/9+rJAhxLEMJZsApwNW5BRFIc=
X-Received: by 2002:a25:9387:0:b0:dbd:933:d904 with SMTP id
 a7-20020a259387000000b00dbd0933d904mr3644045ybm.107.1703689791986; Wed, 27
 Dec 2023 07:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127153901.6399-1-maimon.sagi@gmail.com> <87wmtfmjec.ffs@tglx>
In-Reply-To: <87wmtfmjec.ffs@tglx>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 27 Dec 2023 17:09:40 +0200
Message-ID: <CAMuE1bGmWW--zwnkRaHE_j19DogAkUgeYKM=8Cs9EX_Fv7FoYQ@mail.gmail.com>
Subject: Re: [PATCH v2] posix-timers: add multi_clock_gettime system call
To: Thomas Gleixner <tglx@linutronix.de>
Cc: richardcochran@gmail.com, reibax@gmail.com, davem@davemloft.net, 
	rrameshbabu@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maheshb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
Hi Thomas
Thanks for your notes.
> On Mon, Nov 27 2023 at 17:39, Sagi Maimon wrote:
> >  Some user space applications need to read some clocks.
> >  Each read requires moving from user space to kernel space.
> >  This asymmetry causes the measured offset to have a significant
> >  error.
>
> I can't figure out what you want to tell me here. Where is an asymmetry?
>
You are right the comment is not clear enough.
Some user space applications need to read some clocks.
Each read requires moving from user space to kernel space.
The syscall overhead causes unpredictable delay between N clocks reads
Removing this delay causes better synchronization between N clocks.
> >  Introduce a new system call multi_clock_gettime, which can be used to =
measure
> >  the offset between multiple clocks, from variety of types: PHC, virtua=
l PHC
> >  and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> >  The offset includes the total time that the driver needs to read the c=
lock
> >  timestamp.
>
> What for? You still fail to explain the problem this is trying to solve.
>
Explanation above
> > --- a/include/linux/posix-timers.h
> > +++ b/include/linux/posix-timers.h
> > @@ -260,4 +260,28 @@ void set_process_cpu_timer(struct task_struct *tas=
k, unsigned int clock_idx,
> >  int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new=
);
> >
> >  void posixtimer_rearm(struct kernel_siginfo *info);
> > +
> > +#define MULTI_PTP_MAX_CLOCKS 12 /* Max number of clocks */
> > +#define MULTI_PTP_MAX_SAMPLES 10 /* Max allowed offset measurement sam=
ples. */
> > +
> > +struct __ptp_multi_clock_get {
> > +     unsigned int n_clocks; /* Desired number of clocks. */
> > +     unsigned int n_samples; /* Desired number of measurements per clo=
ck. */
> > +     const clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock=
 IDs */
> > +     /*
> > +      * Array of list of n_clocks clocks time samples n_samples times.
> > +      */
> > +     struct  __kernel_timespec ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX=
_CLOCKS];
> > +};
> > +
> > +struct __ptp_multi_clock_get32 {
> > +     unsigned int n_clocks; /* Desired number of clocks. */
> > +     unsigned int n_samples; /* Desired number of measurements per clo=
ck. */
> > +     const clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock=
 IDs */
> > +     /*
> > +      * Array of list of n_clocks clocks time samples n_samples times.
> > +      */
> > +     struct  old_timespec32
> >  ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX_CLOCKS];
>
> Seriously now. We are not adding new syscalls which take compat
> timespecs. Any user space application which wants to use a new syscall
> which takes a timespec needs to use the Y2038 safe variant.
>
you are right - will be fixed on patch V3
> Aside of that you define a data structure for a syscall in a kernel only
> header. How is user space supposed to know the struct?
>
you are right - will be fixed on patch V3
> >
> > +SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __us=
er *, ptp_multi_clk_get)
> > +{
> > +     const struct k_clock *kc;
> > +     struct timespec64 kernel_tp;
> > +     struct __ptp_multi_clock_get multi_clk_get;
> > +     int error;
> > +     unsigned int i, j;
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variab=
le-declarations
>
you are right - will be fixed on patch V3
> > +
> > +     if (copy_from_user(&multi_clk_get, ptp_multi_clk_get, sizeof(mult=
i_clk_get)))
> > +             return -EFAULT;
> > +
> > +     if (multi_clk_get.n_samples > MULTI_PTP_MAX_SAMPLES)
> > +             return -EINVAL;
> > +     if (multi_clk_get.n_clocks > MULTI_PTP_MAX_CLOCKS)
> > +             return -EINVAL;
> > +
> > +     for (j =3D 0; j < multi_clk_get.n_samples; j++) {
> > +             for (i =3D 0; i < multi_clk_get.n_clocks; i++) {
> > +                     kc =3D clockid_to_kclock(multi_clk_get.clkid_arr[=
i]);
> > +                     if (!kc)
> > +                             return -EINVAL;
> > +                     error =3D kc->clock_get_timespec(multi_clk_get.cl=
kid_arr[i], &kernel_tp);
> > +                     if (!error && put_timespec64(&kernel_tp, (struct =
__kernel_timespec __user *)
> > +                                                  &ptp_multi_clk_get->=
ts[j][i]))
> > +                             error =3D -EFAULT;
>
> So this reads a clock from a specific clock id and stores the timestamp
> in that user space array.
>
> And how is this solving any of the claims you make in the changelog:
>
>     >  Introduce a new system call multi_clock_gettime, which can be used=
 to measure
>     >  the offset between multiple clocks, from variety of types: PHC, vi=
rtual PHC
>     >  and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
>     >  The offset includes the total time that the driver needs to read t=
he clock
>     >  timestamp.
>
> That whole thing is not really different from N consecutive syscalls as
> it does not provide and guarantee vs. the gaps between the readouts.
>
> The common case might be closer to what you try to measure, as it avoids
> the syscall overhead (which is marginal) but other than that it's
> subject to be interrupted and preempted. So the worst case gaps between
> the indiviual clock reads is unspecified.
>
> IOW, this is nothing else than wishful thinking and does not solve any re=
al
> world problem at all.
>
preemption or interruption delays will still occur, but at least we
are removing the syscall overhead.
Plus the preemption issue can be reduced by using 99 RT priority while
calling this system call.
We have conducted an experiment that proved that the system call
overhead is not marginal at all.
A process with NICE 0 priority reading PHC twice and measuring the
time delay between two reads 1000 times.
The first is done by two consecutive calls to clock_gettime system
call and the other with
one call to multi_clock_gettime system call.
In the system with multi_clock_gettime system call, the delay of 990
calls was under 100 ns.
In the system with clock_gettime system call the delay of 580 calls
were under 100 ns
72 between 100-500ns 322 between 500-1000ns and some over 1000-5000ns.
> Thanks,
>
>         tglx

