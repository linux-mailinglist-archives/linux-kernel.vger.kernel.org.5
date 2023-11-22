Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3905A7F4BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjKVQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjKVQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:04:45 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736EC11F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:04:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50aba9b8955so3781e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700669078; x=1701273878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj+30jdiOOCg1UaHjY820RtiMj34MynXeJNrGTwqL0A=;
        b=P21Hg/aFfOzi3tbMDwSB/VF1XmLZAS0FbVaqEPdRcpJpYFW2O9J0q4nJksegh2EIqW
         OsvFYtLzxyl3ZKBmRPNh2+3SldOPz83puVZxCNeF+Punuf9FXSY3YMVLSa4DrZDRCDpI
         uh7RWHQKP+WZxGKZmP/cUogBp5KcOMK6se0DL1zdxE4JguuQSRZwqgg8/VwOz6TQw96I
         fDIY3ZXpvtzIfZ0G6OOcT/zepiTe47aWbFUoAMslk1JnIWyYFWos69gzMudc7nHGQcKe
         DOf2meaUHCiJykJX9jknvz3KRurM+xZWQ313JK9euGZrBUQQlfxkPkJRUlqwpO1ytrGa
         tn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669078; x=1701273878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj+30jdiOOCg1UaHjY820RtiMj34MynXeJNrGTwqL0A=;
        b=XVNCSMbgewzjN5SOl3Glr1Bcr6zfGJvctwwCwzoYU9kCDGuUsp70SLKLofC43H/Cdf
         B95tLQZFsnGhEGKn4Z7tY+VN9yHQwSuiYGCiGgPfGgi+OOZWnavpRGB3tnh7D7Upd0LB
         VBZ3ZmTCzn2250Rr7xwr5N6LOzjVS3Dn5AsH7MkbbUv/o0RASALlCDVJS68VJDJZ54xq
         BkNvyubVJCSPp4bIDY8wWoHE5mIzsQCrFa1/tQEe4QvPciNBNo0ujobheUgwHEKDYfb6
         gZx0misjbiPoNNH8HFpk0SnfWz58GUP++h6/xcjQjCGbsxWaoUcynbGOrvDvj7PdKZ+N
         zcqg==
X-Gm-Message-State: AOJu0YzDRiGg5mJaCdKGjovzPlUL2YlbTj5XRM5eMhD4nANCoSgabFUU
        X973w248X2QLYqDUYsKG6jAdzyu/z5Ehasmc1P9Oyw==
X-Google-Smtp-Source: AGHT+IHIYUVek53rAYMk/EECqSGezlgDvPNPBPmgTsRwifeiw896LVsKTisgifmKhCgNz4bvZjesbvW46vtyHZKxGRk=
X-Received: by 2002:a05:6512:b91:b0:509:9035:a2bb with SMTP id
 b17-20020a0565120b9100b005099035a2bbmr146919lfv.2.1700669078382; Wed, 22 Nov
 2023 08:04:38 -0800 (PST)
MIME-Version: 1.0
References: <86pm03z0kw.wl-maz@kernel.org> <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <930bfb9a-dcbe-4385-9ae3-26e2aa14c50e@marcan.st> <ZV38z3+p2S2ETtzG@kernel.org>
 <ZV4i_lrhbOVdEpwH@FVFF77S0Q05N>
In-Reply-To: <ZV4i_lrhbOVdEpwH@FVFF77S0Q05N>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Nov 2023 08:04:26 -0800
Message-ID: <CAP-5=fXxdt4-j7ea=3oXpqyfOQEmSRYBugzND0r+gZUd5sMi1w@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 7:49=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, Nov 22, 2023 at 10:06:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 22, 2023 at 12:23:27PM +0900, Hector Martin escreveu:
> > > On 2023/11/22 1:38, Ian Rogers wrote:
> > > > On Tue, Nov 21, 2023 at 8:15=E2=80=AFAM Mark Rutland <mark.rutland@=
arm.com> wrote:
> > > >> On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
> > > >>> On Tue, Nov 21, 2023 at 8:03=E2=80=AFAM Mark Rutland <mark.rutlan=
d@arm.com> wrote:
> > > >>>> On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> > > >>>>> On Tue, Nov 21, 2023 at 7:40=E2=80=AFAM Mark Rutland <mark.rutl=
and@arm.com> wrote:
> > > >>>>>> On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
> > > >>>>>>> On Tue, 21 Nov 2023 13:40:31 +0000,
> > > >>>>>>> Marc Zyngier <maz@kernel.org> wrote:
> > > >>>>>>>>
> > > >>>>>>>> [Adding key people on Cc]
> > > >>>>>>>>
> > > >>>>>>>> On Tue, 21 Nov 2023 12:08:48 +0000,
> > > >>>>>>>> Hector Martin <marcan@marcan.st> wrote:
> > > >>>>>>>>>
> > > >>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost everyt=
hing), and
> > > >>>>>>>>> according to maz also on Juno (so, probably all big.LITTLE)=
 since v6.5.
> > > >>>>>>>>
> > > >>>>>>>> I can confirm that at least on 6.7-rc2, perf is pretty buste=
d on any
> > > >>>>>>>> asymmetric ARM platform. It isn't clear what criteria is use=
d to pick
> > > >>>>>>>> the PMU, but nothing works anymore.
> > > >>>>>>>>
> > > >>>>>>>> The saving grace in my case is that Debian still ships a 6.1=
 perftool
> > > >>>>>>>> package, but that's obviously not going to last.
> > > >>>>>>>>
> > > >>>>>>>> I'm happy to test potential fixes.
> > > >>>>>>>
> > > >>>>>>> At Mark's request, I've dumped a couple of perf (as of -rc2) =
runs with
> > > >>>>>>> -vvv.  And it is quite entertaining (this is taskset to an 'i=
cestorm'
> > > >>>>>>> CPU):
> > > >>>>>>
> > > >>>>>> IIUC the tool is doing the wrong thing here and overriding exp=
licit
> > > >>>>>> ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather =
than events using
> > > >>>>>> that ${pmu}'s type and event namespace.
> > > >>>>>>
> > > >>>>>> Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE eve=
nts to be
> > > >>>>>> targetted to a specific PMU, it's semantically wrong to rewrit=
e events like
> > > >>>>>> this since ${pmu}/${event}/ is not necessarily equivalent to a=
 similarly-named
> > > >>>>>> PERF_COUNT_HW_${EVENT}.
> > > >>>>>
> > > >>>>> If you name a PMU and an event then the event should only be op=
ened on
> > > >>>>> that PMU, 100% agree. There's a bunch of output, but when the l=
egacy
> > > >>>>> cycles event is opened it appears to be because it was explicit=
ly
> > > >>>>> requested.
> > > >>>>
> > > >>>> I think you've missed that the named PMU events are being erreou=
sly transformed
> > > >>>> into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
> > > >>>>
> > > >>>>   Opening: apple_firestorm_pmu/cycles/
> > > >>>>   ------------------------------------------------------------
> > > >>>>   perf_event_attr:
> > > >>>>     type                             0 (PERF_TYPE_HARDWARE)
> > > >>>>     size                             136
> > > >>>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES=
)
> > > >>>>     sample_type                      IDENTIFIER
> > > >>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TI=
ME_RUNNING
> > > >>>>     disabled                         1
> > > >>>>     inherit                          1
> > > >>>>     enable_on_exec                   1
> > > >>>>     exclude_guest                    1
> > > >>>>   ------------------------------------------------------------
> > > >>>>   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0=
x8 =3D 4
> > > >>>>
> > > >>>> ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_=
CYCLES.
> > > >>>>
> > > >>>> Marc said that he bisected the issue down to commit:
> > > >>>>
> > > >>>>   5ea8f2ccffb23983 ("perf parse-events: Support hardware events =
as terms")
> > > >>>>
> > > >>>> ... so it looks like something is going wrong when the events ar=
e being parsed,
> > > >>>> e.g. losing the HW PMU information?
> > > >>>
> > > >>> Ok, I think I'm getting confused by other things. This looks like=
 the issue.
> > > >>>
> > > >>> I think it may be working as intended, but not how you intended :=
-) If
> > > >>> a core PMU is listed and then a legacy event, the legacy event sh=
ould
> >
> > The point is that "cycles" when prefixed with "pmu/" shouldn't be
> > considered "cycles" as HW/0, in that setting it is "cycles" for that
> > PMU.
>
> Exactly.
>
> > (but we only have "cpu_cycles" for at least the a53 and a72 PMUs I
> > have access in a Libre Computer rockchip 3399-pc hybrid board, if we us=
e
> > it, then we get what we want/had before, see below):
>
> Both Cortex-A53 and Cortex-A72 have the common PMUv3 events, so they have
> "cpu_cycles" and "bus_cycles".
>
> The Apple PMUs that Hector and Marc anre using don't follow the PMUv3
> architecture, and just have a "cycles" event.
>
> [...]
>
> > So what we need here seems to be to translate the generic term "cycles"
> > to "cpu_cycles" when a PMU is explicitely passed in the event name and
> > it doesn't have "cycles" and then just retry.
>
> I'm not sure we need to map that.
>
> My thinking is:
>
> * If the user asks for "cycles" without a PMU name, that should use the
>   PERF_TYPE_HARDWARE cycles event. The ARM PMUs handle that correctly whe=
n the
>   event is directed to them.
>
> * If the user asks for "${pmu}/cycles/", that should only use the "cycles=
"
>   event in that PMU's namespace, not PERF_TYPE_HARDWARE.
>
> * If we need a way so say "use the PERF_TYPE_HARDWARE cycles event on ${p=
mu}",
>   then we should have a new syntax for that (e.g. as we have for raw even=
ts),
>   e.g. it would be possible to have "pmu/hw:cycles/" or something like th=
at.
>
> That way there's no ambiguity.

This would break cpu_core/LLC-load-misses/ on Intel hybrid as the
LLC-load-misses event is legacy and not advertised in either sysfs or
in json.

Thanks,
Ian

> Mark.
