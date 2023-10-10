Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5D7BEFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379265AbjJJAvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379258AbjJJAvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:51:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0EFAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:51:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b2c5664cb4so195296666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 17:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696899075; x=1697503875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55gaZnD/4pQGBcN72gUyG/yKfxNgh2xfAKCxk2KMWDU=;
        b=BtKWXKFGtjNv7cfYs0dsDIJ1Hlw/k3s3bWF1BDrxyeFB1L2vhgX7iTguFbngwmf1G7
         uMhQGeisHlbUEjkL0UHrfaq5KMBINcQMs36whj6I5cMDHgBNYX4ZJ+DSgdxPdsLffDXk
         1p/WMfZTU0u3kaJSoVQWv05Gtx4VtGDiC/C34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696899075; x=1697503875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55gaZnD/4pQGBcN72gUyG/yKfxNgh2xfAKCxk2KMWDU=;
        b=rdp5HzWsuefFQMz2jwcKzXA09DqN2JpQAJqQrGLaQz8801iakvX7dCU43wyn2AdHoF
         175Q3WyJE1W3SYQ+5+Arlc7mEhVWapuedUf50K+c0/TFtlhxT6lQhdmtP/4F9Ef1m6a+
         JFFkQwzDbE0xsWHh14WDOZnvZEQkGLsJ/C9CHpdgbqLpb3MZas6tB4YbJvnLdvDkgYUl
         3wkNRjjjc3eLLn4kYVZk6EFl3obiDEjDcoDyZTUBgTSYaqBWccgwLGvQ3Ed2OoDfXj1E
         mXZWc1z/FDZ/A89cpkebcbcxMWSWNBeq/S2cT8LShPL4SgiuT0oDx7HEnmcDaWcv5b7F
         /Vuw==
X-Gm-Message-State: AOJu0Yx/kcE6hvsFyT1PaIv1AfMybg0lpgXz2LDHwU2+QWM4ZSnzEO9k
        hfriK/u4LrWalb8MNvQuindzqGHvU+0J/kAM5fHEvg==
X-Google-Smtp-Source: AGHT+IG+Av6cJcBeqoqezcSAP3jXBGx1EFz3zpdji0z5DlPz8aC81gppZRaPONcKwWOymdqBDNXT5vGTzMX7VvBjUbk=
X-Received: by 2002:a17:906:24e:b0:9a5:9f3c:961f with SMTP id
 14-20020a170906024e00b009a59f3c961fmr13406395ejl.3.1696899075094; Mon, 09 Oct
 2023 17:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net> <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net> <20231005120557.GA743@noisy.programming.kicks-ass.net>
 <20231007220400.GA5581@noisy.programming.kicks-ass.net>
In-Reply-To: <20231007220400.GA5581@noisy.programming.kicks-ass.net>
From:   Youssef Esmat <youssefesmat@chromium.org>
Date:   Mon, 9 Oct 2023 19:51:03 -0500
Message-ID: <CA+q576Mov1jpdfZhPBoy_hiVh3xSWuJjXdP3nS4zfpqfOXtq7Q@mail.gmail.com>
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 5:04=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Oct 05, 2023 at 02:05:57PM +0200, Peter Zijlstra wrote:
>
> > t=3D10 V=3D4                                                t=3D10 V=3D=
4
> >  A       |----<                                          A       |----<
> >  B      |<                                              >B      |<
> > >C   |----------------<                                  C   |---------=
-------<
> >    |---*-----|---------|---------|---------|----           |---*-----|-=
--------|---------|---------|----
> >
>
> >
> > t=3D52 V=3D18                                               t=3D36 V=3D=
13
> >  A                   |----<                              A             =
      |----<
> > >B                  |<                                   B             =
       |<
> >  C                     |----------------<               >C   |---------=
-------<
> >    |---------|-------*-|---------|---------|----           |---------|-=
-*------|---------|---------|----
> >
>
> >
> > BAaaBCccccccccBBBAaaBBBAaaBB                            BBAaaBBBAaaBBBA=
aaBCccccccccB
> >
> >
> >
> > As I wrote before; EVDF has worse lag bounds, but this is not
> > insurmountable. The biggest problem that I can see is that of wakeup
> > preemption. Currently we allow to preempt when 'current' has reached V
> > (RUN_TO_PARITY in pick_eevdf()).
> >
> > With these rules, when EEVDF schedules C (our large slice task) at t=3D=
10
> > above, it is only a little behind C and can be reaily preempted after
> > about 2 time units.
> >
> > However, EVDF will delay scheduling C until much later, see how A and B
> > walk far ahead of V until t=3D36. Only when will we pick C. But this me=
ans
> > that we're firmly stuck with C for at least 11 time units. A newly
> > placed task will be around V and will have no chance to preempt.
>
> Playing around with it a little:
>
> EEVDF                                   EVDF
>
> slice 30000000                          slice 30000000
> # Min Latencies: 00014                  # Min Latencies: 00048
> # Avg Latencies: 00692                  # Avg Latencies: 188239
> # Max Latencies: 94633                  # Max Latencies: 961241
>
> slice 3000000                           slice 3000000
> # Min Latencies: 00054                  # Min Latencies: 00055
> # Avg Latencies: 00522                  # Avg Latencies: 00673
> # Max Latencies: 41475                  # Max Latencies: 13297
>
> slice 300000                            slice 300000
> # Min Latencies: 00018                  # Min Latencies: 00024
> # Avg Latencies: 00344                  # Avg Latencies: 00056
> # Max Latencies: 20061                  # Max Latencies: 00860
>

Thanks for sharing. Which workload was used to generate these numbers?

I think looking at the sched latency numbers alone does not show the
complete picture. I ran the same input latency test again and tried to
capture some of these numbers for the chrome processes.

EEVDF 1.5ms slice:

Input latency test result: 226ms
perf sched latency:
switches: 1,084,694
avg:   1.139 ms
max: 408.397 ms

EEVDF 6.0ms slice:

Input latency test result: 178ms
perf sched latency:
switches: 892,306
avg:   1.145 ms
max: 354.344 ms

EVDF 6.0ms slice:

Input latency test result: 112ms
perf sched latency:
switches: 134,200
avg:   2.610 ms
max: 374.888 ms

EVDF 6.0ms slice
(no run_to_parity, no place_lag, no place_deadline_initial):

Input latency test result: 110ms
perf sched latency:
switches: 531,656
avg:   0.830 ms
max: 520.463 ms

For our scenario, it is very expensive to interrupt UI threads. It
will increase the input latency significantly. Lowering the scheduling
latency at the cost of switching out important threads can be very
detrimental in this workload. UI and input threads run with a nice
value of -8.

This also seems to match Daniel's message earlier in this thread where
using 12ms base slice improved their benchmarks.

That said, this might not be beneficial for all workloads, and we are
still trying our other workloads out.

>
> So while it improves the short slices, it completely blows up the large
> slices -- utterly slaughters the large slices in fact.
>
> And all the many variants of BIAS_ELIGIBLE that I've tried so far only
> manage to murder the high end while simultaneously not actually helping
> the low end -- so that's a complete write off.
>
>
> By far the sanest option so far is PLACE_SLEEPER -- and that is very
> much not a nice option either :-(
