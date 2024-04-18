Return-Path: <linux-kernel+bounces-149786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CCF8A95DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47581C20FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FFB15AD95;
	Thu, 18 Apr 2024 09:20:37 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BF7B3FD;
	Thu, 18 Apr 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432037; cv=none; b=mp7CQwgTV4TS5J9C/S6FBhIqwA11NtHa8L5Y8USyG+2lOJNA0uxrx2Mxia2+/1n2NruNbXEogZqDIiwchJPs+34CpEwMi+zw6GRNogMA+XiT6OusUD0xaZygTox8Pr8ZXe+Qek8Nb0MvWieHvJZSGqIfkEuIUiSnokH0kTw1gc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432037; c=relaxed/simple;
	bh=wv3BWdUjEsHxFz36HH4yDDYcOKARUT+h/vA74KGBDCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7Fo5sjxJgDeM+IF4qaxl4x3GNAMwTWNE8ttS1xGdST9gUbsoG7v+kvnFFzHWnK6AzLWc93LbRbjWA8lvJvbVSxPO77Z8TBLGQfALuHT+xB3L8RtOFUSmK0JftIQrwM1e4Tvx3pQp/PYD649RazRoZg9Fs1F7cEgXAH7tlNBr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de469a634fbso376026276.2;
        Thu, 18 Apr 2024 02:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432034; x=1714036834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=med4sx583FmrjJ8xsZWP62GvasCPoxmlq0Xh1ieUCdI=;
        b=cul5pj330sxW3Il5Yv5nD6xvIa9rUm3LFox1414Uj/TGoKiOLj6dDt1Mxas77mJ2cD
         NpiqzWmi1ReOe7svftJcWvgCz0pCFFLQVnuzg+NiMVf+Le0MU2DBIFpT7oZS5Zsllyd2
         bMxEtJeHTE5znvGPzF1xu5Ik1aC99ubF7WExTmMDmBn/JJn6lceCVmwOT0lJN78Owj6w
         YiV9l7ZMpDXL50PRsGQL3Swe1LpODNNNQ6w0X2t6t7jhjGlQjeDkfp7jRyPq6q5sgGr8
         R/HRl3b1xZz6bbPMWl9QJ8LQFirqeQbO0B07mSfNGvP2EPnWKpqmencUkcOskZh101Ve
         84SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb3QAp7THVp2D9akzTiC7UK9K3QYlq9YNSUUh5/aFLMzIXEJE3grXnDEn838YBAkn3i5HpbM0WlxBx8+Q4xw3KgFY+6QNX1sQ7pWuOt4ThiGBErJ3Oai0gyNVKncIr7TVbENw7dQ6yom6Zmsg60z0R/AKamW1IeNlokv335CfbC8htovpcXdAwkq1XR+LYGmCMFGIprgwFKgYLtHatCtstLVQ6fw==
X-Gm-Message-State: AOJu0Yysamic/cE8X7lUJpqom5vmw33ly9Y9WO3uvUJFW1Z3CtJq6CS1
	iAllnuR4Lfsv7Pa6CfIYBEYN8WRBNA5F1H+3QXfGjo+AytrocqPKt18Ogn7HK18=
X-Google-Smtp-Source: AGHT+IEtNJbW3xXJupl8UwbjfXgk1tyCbpQcNBaET7xOd9RFzIWDvo27GbaTurz8ThbM/gdvRSgGaA==
X-Received: by 2002:a25:ef42:0:b0:dd0:702:577a with SMTP id w2-20020a25ef42000000b00dd00702577amr2111040ybm.35.1713432033462;
        Thu, 18 Apr 2024 02:20:33 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id s13-20020a056902120d00b00dc73705ec59sm283880ybu.0.2024.04.18.02.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:20:33 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-617ddc988f5so6235897b3.2;
        Thu, 18 Apr 2024 02:20:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN2U+aPyFwnTG6cSbwo+M9JCTkbBcs6X9QYOwvJnPPl6EHUZbufPSuvtCEpbFhRHJfOyERSY1uC0zwvK+1J3+EdVyus3hW3SlpA3f4llZrn7kkyTw/REfmSX1o2TEuBRRQT6ZKt3z7EXUT9f2TCLUYIqbLC/ecKAEIa4SomPhuaeuDUZmnVNP84rlNSwEnYaZax3S+0juVtCIpktjgvRsDarAehg==
X-Received: by 2002:a05:690c:84:b0:61a:d00a:5aed with SMTP id
 be4-20020a05690c008400b0061ad00a5aedmr1891798ywb.12.1713432032825; Thu, 18
 Apr 2024 02:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3d2a2f4e553489392d871108797c3be08f88300b.1685692810.git.geert+renesas@glider.be>
 <20240326013119.10591-1-zong.li@sifive.com>
In-Reply-To: <20240326013119.10591-1-zong.li@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 11:20:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxfXLmf0xAUKcVaF81fHbUs732J_zx7Xds0XuNUD5BVw@mail.gmail.com>
Message-ID: <CAMuHMdVxfXLmf0xAUKcVaF81fHbUs732J_zx7Xds0XuNUD5BVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
To: Zong Li <zong.li@sifive.com>
Cc: arnd@arndb.de, hca@linux.ibm.com, iommu@lists.linux.dev, joro@8bytes.org, 
	jstultz@google.com, kai.heng.feng@canonical.com, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux@armlinux.org.uk, 
	magnus.damm@gmail.com, mturquette@baylibre.com, npiggin@gmail.com, 
	peterz@infradead.org, rafael.j.wysocki@intel.com, robin.murphy@arm.com, 
	s.nawrocki@samsung.com, sboyd@kernel.org, tero.kristo@linux.intel.com, 
	tglx@linutronix.de, tomasz.figa@gmail.com, tony@atomide.com, 
	ulf.hansson@linaro.org, vincent.guittot@linaro.org, will@kernel.org, 
	wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com, 
	zhengdejin5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zong,

On Tue, Mar 26, 2024 at 2:31=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
> On Fri, Jun 02, 2023 at 10:50:37AM +0200, Geert Uytterhoeven wrote:
> > read_poll_timeout_atomic() uses ktime_get() to implement the timeout
> > feature, just like its non-atomic counterpart.  However, there are
> > several issues with this, due to its use in atomic contexts:
> >
> >   1. When called in the s2ram path (as typically done by clock or PM
> >      domain drivers), timekeeping may be suspended, triggering the
> >      WARN_ON(timekeeping_suspended) in ktime_get():
> >
> >       WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 ktime_g=
et+0x28/0x78
> >
> >      Calling ktime_get_mono_fast_ns() instead of ktime_get() would get
> >      rid of that warning.  However, that would break timeout handling,
> >      as (at least on systems with an ARM architectured timer), the time
> >      returned by ktime_get_mono_fast_ns() does not advance while
> >      timekeeping is suspended.
> >      Interestingly, (on the same ARM systems) the time returned by
> >      ktime_get() does advance while timekeeping is suspended, despite
> >      the warning.
> >
> >   2. Depending on the actual clock source, and especially before a
> >      high-resolution clocksource (e.g. the ARM architectured timer)
> >      becomes available, time may not advance in atomic contexts, thus
> >      breaking timeout handling.
> >
> > Fix this by abandoning the idea that one can rely on timekeeping to
> > implement timeout handling in all atomic contexts, and switch from a
> > global time-based to a locally-estimated timeout handling.  In most
> > (all?) cases the timeout condition is exceptional and an error
> > condition, hence any additional delays due to underestimating wall cloc=
k
> > time are irrelevant.
> >
>
> Hi Geert,
> I tested this patch on the FPGA, and I noticed the timeout duration
> was much longer than expected. I tested it by removing the op operation
> and break condition for avoiding the influence of other factors.
> The code would look like as follows:
>
> for (;;) {
>         if (__timeout_us && __left_ns < 0)
>                 break;
>         if (__delay_us) {
>                 udelay(__delay_us);
>                 if (__timeout_us)
>                         __left_ns -=3D __delay_ns;;
>         cpu_relex();
>         if (__timeout_us)
>                 __left_ns--;
>         }
> }
>
> Despite setting the timeout to 1 second, it actually takes 25 seconds
> to reach the specified timeout value. I displayed the value of
> __left_ns when a timeout occurred. As follows: __delay_us is 1, when
> __left_ns counts down to -1, the system has run for 25 seconds.
>
> [   26.016213] __timeout_us: 1000000 __left_ns: -1
> [   50.818585] __timeout_us: 1000000  __left_ns: -1
> [   75.620467] __timeout_us: 1000000  __left_ns: -1
> [  100.422664] __timeout_us: 1000000  __left_ns: -1
> [  125.224775] __timeout_us: 1000000  __left_ns: -1
> ...
>
> I attempted to blend the two versions (e.g., ktime version and the
> current version) for discarding the value of __left_ns. The resulting
> output is as follows: __delay_us is 1, when it exceeds 1 second
> according to ktime, __left_ns only counts around 40 ms.
>
> [    6.734482] __timeout_us: 1000000  __left_ns: 961699000
> [    7.738485] __timeout_us: 1000000  __left_ns: 961228000
> [    8.812797] __timeout_us: 1000000  __left_ns: 961755000
> [    9.814021] __timeout_us: 1000000  __left_ns: 961542000
> [   10.815373] __timeout_us: 1000000 __left_ns: 962464000
> [   11.816184] __timeout_us: 1000000 __left_ns: 961536000
> [   12.817137] __timeout_us: 1000000 __left_ns: 961121000
> ...
>
> Per your suggestion, I attempted to increase delay_us to 10 us,
> it really helps to eliminate the underestimation. The actual
> timeout became 3 secs on the FPGA.
>
> I moved on my host x86 machine, the timeout has been reduced to
> 2 seconds even if the delay_us is 1. And the timeout can be
> precise 1 seconds when delay_us is 10. I'm not sure if the clock
> frequency or RTC frequency might also determine the underestimation
> of wall clock time? Is there a suggested value of delay_us for a
> driver that runs on various platforms?
> What is your perspective for those situation?

RTC frequency does not impact the timeout, as the macro no longer
relies on timekeeping.
CPU clock frequency does impact the timeout, especially when op()
executes lots of instructions.  The code assumes op() takes 1 ns,
which is a conservative value to prevent overestimation of wall clock
time.  This assumes that such an overestimation (i.e. timing out too
early) is much worse than an underestimation (i.e. timing out too late).
If op() takes much more time than 1 ns, or even more time than delay_us,
the effective timeout will be much larger than expected.

I can only suggest to use a reasonable value for delay_us, i.e. a value
that is (sufficiently) larger than the expected execution time of op().

I hope this helps.

> > --- a/include/linux/iopoll.h
> > +++ b/include/linux/iopoll.h
> > @@ -74,6 +74,10 @@
> >   * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
> >   * case, the last read value at @args is stored in @val.
> >   *
> > + * This macro does not rely on timekeeping.  Hence it is safe to call =
even when
> > + * timekeeping is suspended, at the expense of an underestimation of w=
all clock
> > + * time, which is rather minimal with a non-zero delay_us.
> > + *
> >   * When available, you'll probably want to use one of the specialized
> >   * macros defined below rather than this macro directly.
> >   */
> > @@ -81,22 +85,30 @@
> >                                       delay_before_read, args...) \
> >  ({ \
> >       u64 __timeout_us =3D (timeout_us); \
> > +     s64 __left_ns =3D __timeout_us * NSEC_PER_USEC; \
> >       unsigned long __delay_us =3D (delay_us); \
> > -     ktime_t __timeout =3D ktime_add_us(ktime_get(), __timeout_us); \
> > -     if (delay_before_read && __delay_us) \
> > +     u64 __delay_ns =3D __delay_us * NSEC_PER_USEC; \
> > +     if (delay_before_read && __delay_us) { \
> >               udelay(__delay_us); \
> > +             if (__timeout_us) \
> > +                     __left_ns -=3D __delay_ns; \
> > +     } \
> >       for (;;) { \
> >               (val) =3D op(args); \
> >               if (cond) \
> >                       break; \
> > -             if (__timeout_us && \
> > -                 ktime_compare(ktime_get(), __timeout) > 0) { \
> > +             if (__timeout_us && __left_ns < 0) { \
> >                       (val) =3D op(args); \
> >                       break; \
> >               } \
> > -             if (__delay_us) \
> > +             if (__delay_us) { \
> >                       udelay(__delay_us); \
> > +                     if (__timeout_us) \
> > +                             __left_ns -=3D __delay_ns; \
> > +             } \
> >               cpu_relax(); \
> > +             if (__timeout_us) \
> > +                     __left_ns--; \
> >       } \
> >       (cond) ? 0 : -ETIMEDOUT; \
> >  })

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

