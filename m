Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0F7B2C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjI2GfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjI2GfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:35:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988881A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:35:05 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77428510fe7so12963885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695969304; x=1696574104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DfmXp2T2GKuyyceQ+OhxXHG99X5ZXI8F9X8Rh+6G4E=;
        b=BsRbBc8p/fCut5uRlcEHFhTkwa76P0nI968Z0jQk69RrcsBl+Ne5J6yEOqqUQpN02g
         mAmgSiUv75objR7Ne+gRLP4fS0HCc3SV9YVrA3R+iaPLJ510QTzUGlXl0AD1L+j2/qsw
         GnwHVoXU+kZgXaejhaKgNyg0EAZNF3fnOx020SwOGWRFiqpyufbWD/iZ5JJ9CocWWgUh
         i44zK4dfsggk60Lg0zOuOFHn35p28bzDNoHFgSpOj7xpfF3aWkT8OyQT5u6INiTpMwJb
         XMfehxtRTWmzFM029GcDwhSPwHK6G1v7XpMgfxK5oAcg+C/arXpdDc0guUpYxMBV3kX8
         TCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695969304; x=1696574104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DfmXp2T2GKuyyceQ+OhxXHG99X5ZXI8F9X8Rh+6G4E=;
        b=ViF/TsqGl/N9c3Xaf153WjbVHDzv7EzSAnQqkpUO/kXAYpV1AtNlZFmLL+9NvWGPGU
         WwJfw/AQ9B702Oi0Bdy8aH6iBN/wW/TwOpqVqZjebgxuzdvC7m3Xv0ngdKbNPXARHZUn
         MNBo0XMWu5izPPs4hN2iUxiJNnbgUtQxHV71Zcx9gy6Wk/zhwDVQdlnaIirS2q0HGsqu
         AUJtsvqvZzz5SKmYDaMJ5uBAH3WpxEdEDHOV0T6BMat0TBeEXR64fDtTt0Sv5lCNg4Fw
         IgzTyKFsE22tNSsVGKly+Z1Nvuns1ZPIbZs6O2+1CuC/Oo9/Ay5uVtot7XQ1EamsJtLe
         SpgQ==
X-Gm-Message-State: AOJu0Yxvepx+rJLJd0NtjCvhXE25kHEhWXIzoSdkHEhwnkG10gsuOid8
        f2VrAx0Ju23FYMdBWZJfYgDVpXsHgjE8M4a3uWRoxw==
X-Google-Smtp-Source: AGHT+IH4zDENmAMWoN1CplV5Qya5xoVVaDg6Z7DhDFS6UI4vcZXJX1n0s1bPIh/K+XQB1aSFeWgLRgb0e6T7UOQrxUs=
X-Received: by 2002:a05:620a:4611:b0:762:3567:a64c with SMTP id
 br17-20020a05620a461100b007623567a64cmr3338763qkb.11.1695969304568; Thu, 28
 Sep 2023 23:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230929023737.1610865-1-maheshb@google.com> <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
In-Reply-To: <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Thu, 28 Sep 2023 23:34:37 -0700
Message-ID: <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
To:     John Stultz <jstultz@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:15=E2=80=AFPM John Stultz <jstultz@google.com> w=
rote:
>
> On Thu, Sep 28, 2023 at 7:37=E2=80=AFPM Mahesh Bandewar <maheshb@google.c=
om> wrote:
> >
> > add a method to retrieve raw cycles in the same fashion as there are
> > ktime_get_* methods available for supported time-bases. The method
> > continues using the 'struct timespec64' since the UAPI uses 'struct
> > ptp_clock_time'.
> >
> > The caller can perform operation equivalent of timespec64_to_ns() to
> > retrieve raw-cycles value. The precision loss because of this conversio=
n
> > should be none for 64 bit cycle counters and nominal at 96 bit counters
> > (considering UAPI of s64 + u32 of 'struct ptp_clock_time).
> >
> > Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> > CC: John Stultz <jstultz@google.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Stephen Boyd <sboyd@kernel.org>
> > CC: Richard Cochran <richardcochran@gmail.com>
> > CC: netdev@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/timekeeping.h |  1 +
> >  kernel/time/timekeeping.c   | 24 ++++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> > index fe1e467ba046..5537700ad113 100644
> > --- a/include/linux/timekeeping.h
> > +++ b/include/linux/timekeeping.h
> > @@ -43,6 +43,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
> >  extern void ktime_get_real_ts64(struct timespec64 *tv);
> >  extern void ktime_get_coarse_ts64(struct timespec64 *ts);
> >  extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
> > +extern void ktime_get_cycles64(struct timespec64 *ts);
> >
> >  void getboottime64(struct timespec64 *ts);
> >
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 266d02809dbb..35d603d21bd5 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -989,6 +989,30 @@ void ktime_get_ts64(struct timespec64 *ts)
> >  }
> >  EXPORT_SYMBOL_GPL(ktime_get_ts64);
> >
> > +/**
> > + * ktime_get_cycles64 - get the raw clock cycles in timespec64 format
> > + * @ts:                pointer to timespec variable
> > + *
> > + * This function converts the raw clock cycles into timespce64 format
> > + * in the varibale pointed to by @ts
> > + */
> > +void ktime_get_cycles64(struct timespec64 *ts)
> > +{
> > +       struct timekeeper *tk =3D &tk_core.timekeeper;
> > +       unsigned int seq;
> > +       u64 now;
> > +
> > +       WARN_ON_ONCE(timekeeping_suspended);
> > +
> > +       do {
> > +               seq =3D read_seqcount_begin(&tk_core.seq);
> > +               now =3D tk_clock_read(&tk->tkr_mono);
> > +       } while (read_seqcount_retry(&tk_core.seq, seq));
> > +
> > +       *ts =3D ns_to_timespec64(now);
> > +}
>
> Hey Mahesh,
>   Thanks for sending this out.  Unfortunately, I'm a bit confused by
> this. It might be helpful to further explain what this would be used
> for in more detail?
>
Thanks for looking at this John. I think my cover-letter wasn't sent
to all reviewers and that's my mistake.

> Some aspects that are particularly unclear:
> 1) You seem to be trying to stuff cycle values into a timespec64,
> which is not very intuitive (and a type error of sorts). It's not
> clear /why/ that type is useful.
>
The primary idea is to build a PTP API similar to gettimex64() that
gives us a sandwich timestamp of a given timebase instead of just
sys-time. Since sys-time is disciplined (adjustment / steps), it's not
really suitable for all possible use cases. For the same reasons
CLOCK_MONOTONIC is also not suitable in a subset of use cases while
some do want to use it. So this API gives user a choice to select the
timebase. The ioctl() interface uses 'struct ptp_clock_time' (similar
to timespec64) hence the interface.

> 2) Depending on your clocksource, this would have very strange
> wrapping behavior, so I'm not sure it is generally safe to use.
>
The uapi does provide other alternatives like sys, mono, mono-raw
along with raw-cycles and users can choose.

> 3) Nit: The interface is called ktime_get_cycles64 (timespec64
> returning interfaces usually are postfixed with ts64).
>
Ah, thanks for the explanation. I can change to comply with the
convention. Does ktime_get_cycles_ts64() make more sense?

> I guess could you clarify why you need this instead of using
> CLOCK_MONOTONIC_RAW which tries to abstract raw cycles in a way that
> is safe and avoids wrapping across various clocksources?
>
My impression was that CLOCK_MONOTONIC_RAW (as the same suggests) does
provide you the raw / undisciplined cycles. However, code like below
does show that monotonic-raw is subjected to certain changes.
"""
int do_adjtimex(struct __kernel_timex *txc)
{
      [...]
        /*
         * The timekeeper keeps its own mult values for the currently
         * active clocksource. These value will be adjusted via NTP
         * to counteract clock drifting.
         */
        tk->tkr_mono.mult =3D clock->mult;
        tk->tkr_raw.mult =3D clock->mult;
        tk->ntp_err_mult =3D 0;
        tk->skip_second_overflow =3D 0;
}
"""
and that was the reason why I have added raw-cycles as another option.
Of course the user can always choose mono-raw if it satisfies their
use-case.

> thanks
> -john
