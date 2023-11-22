Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11C47F4C76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjKVQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjKVQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:33:37 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707F2101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:33:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso14353a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700670811; x=1701275611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V13X5cgXkOfNsIQgifu6v4picILliPQOlpnNGPt0bLg=;
        b=H55r8pqOSNG9DTrNgOZPAbq9dB+LZv/kEIGTLK+YIwWGE17OPIxxEWbwy8W7kD4JSb
         J0vHxwGYwJJASdukXQ3mKCx2AMPhnsDlncIeTo+oNNMNHdjVCSRy6/sYhZ4oSAgU1h/o
         xKPmJGz6q+eeL0WiPTvysopQLf9mFXWNa95fVFtSxj3qwabV3YGPlSovAlqrSerAvVXG
         S/zP63QaUluc8DrX+ZSkAVmhhnzzpL5VUivc6TG41dPdncorlRG2KddCA0EbM9/1TobB
         Vegl3UlDmjz5CUlJIlpbN1x5EuhfN+SwpclCHMKr9zL2KXp9NJZLKU6z8dO4/toc9cZW
         9WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700670811; x=1701275611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V13X5cgXkOfNsIQgifu6v4picILliPQOlpnNGPt0bLg=;
        b=AiiaZFG1xBo+OLd+vpnlgSoeqsUcugYMlIXq4e5jCK33vIqNg2SxOfdqv6J7fKNlAk
         VT1FVPWlsoCA2fckbW77yQ0pR3BD2erVe0TgnDlK0NDSQhmYgMRE/MnIWYd79cCRz1wV
         WhVVvTWDydnH/tLrX9ERwz6/uGZUZ/o5101QK6CgdPj1UAJzrtv5W1krJm2470taFsh3
         ZTKQKIXRyZ4ZIU1unIX0od74RcrmpHkWd1kD4UTmS2BxsN8zWtKcNaN15+SMtETAfe1w
         Jc4WZcAv/TxARrSJg65GIHC6zBc8Xg8hKb0WQv2Os/htp+i2xYNubs7zOC4J3Q+FoaeY
         mFQA==
X-Gm-Message-State: AOJu0YyIOpO9kCjDSYjIRuqQGU76g61IixtYzBt/T/4LhY5sBEkvXhkM
        rBTeR4WpIDN4oOemIpa8WymAOrWz11SYD28KZ6vXvg==
X-Google-Smtp-Source: AGHT+IGSQlE19HpyFXd8z0yOZys3g0WVhEmcceVhn3anh2Dzh4IhoPRCIKqLJpSnO8iFl7Jt5nksLcaIThFi7stlKDY=
X-Received: by 2002:a05:6402:27cd:b0:547:e5b:6e17 with SMTP id
 c13-20020a05640227cd00b005470e5b6e17mr216640ede.2.1700670810541; Wed, 22 Nov
 2023 08:33:30 -0800 (PST)
MIME-Version: 1.0
References: <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <930bfb9a-dcbe-4385-9ae3-26e2aa14c50e@marcan.st> <ZV38z3+p2S2ETtzG@kernel.org>
 <ZV4i_lrhbOVdEpwH@FVFF77S0Q05N> <CAP-5=fXxdt4-j7ea=3oXpqyfOQEmSRYBugzND0r+gZUd5sMi1w@mail.gmail.com>
 <ZV4rubQsiiAPoM1s@kernel.org>
In-Reply-To: <ZV4rubQsiiAPoM1s@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Nov 2023 08:33:18 -0800
Message-ID: <CAP-5=fV8W6dK95u9uuchtrZLES0joNEmFKvdBq2JGEEUeecKUQ@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 8:26=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 22, 2023 at 08:04:26AM -0800, Ian Rogers escreveu:
> > On Wed, Nov 22, 2023 at 7:49=E2=80=AFAM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > >
> > > On Wed, Nov 22, 2023 at 10:06:23AM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > Em Wed, Nov 22, 2023 at 12:23:27PM +0900, Hector Martin escreveu:
> > > > > On 2023/11/22 1:38, Ian Rogers wrote:
> > > > > > On Tue, Nov 21, 2023 at 8:15=E2=80=AFAM Mark Rutland <mark.rutl=
and@arm.com> wrote:
> > > > > >> On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
> > > > > >>> On Tue, Nov 21, 2023 at 8:03=E2=80=AFAM Mark Rutland <mark.ru=
tland@arm.com> wrote:
> > > > > >>>> On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> > > > > >>>>> On Tue, Nov 21, 2023 at 7:40=E2=80=AFAM Mark Rutland <mark.=
rutland@arm.com> wrote:
> > > > > >>>>>> On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wro=
te:
> > > > > >>>>>>> On Tue, 21 Nov 2023 13:40:31 +0000,
> > > > > >>>>>>> Marc Zyngier <maz@kernel.org> wrote:
> > > > > >>>>>>>>
> > > > > >>>>>>>> [Adding key people on Cc]
> > > > > >>>>>>>>
> > > > > >>>>>>>> On Tue, 21 Nov 2023 12:08:48 +0000,
> > > > > >>>>>>>> Hector Martin <marcan@marcan.st> wrote:
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost ev=
erything), and
> > > > > >>>>>>>>> according to maz also on Juno (so, probably all big.LIT=
TLE) since v6.5.
> > > > > >>>>>>>>
> > > > > >>>>>>>> I can confirm that at least on 6.7-rc2, perf is pretty b=
usted on any
> > > > > >>>>>>>> asymmetric ARM platform. It isn't clear what criteria is=
 used to pick
> > > > > >>>>>>>> the PMU, but nothing works anymore.
> > > > > >>>>>>>>
> > > > > >>>>>>>> The saving grace in my case is that Debian still ships a=
 6.1 perftool
> > > > > >>>>>>>> package, but that's obviously not going to last.
> > > > > >>>>>>>>
> > > > > >>>>>>>> I'm happy to test potential fixes.
> > > > > >>>>>>>
> > > > > >>>>>>> At Mark's request, I've dumped a couple of perf (as of -r=
c2) runs with
> > > > > >>>>>>> -vvv.  And it is quite entertaining (this is taskset to a=
n 'icestorm'
> > > > > >>>>>>> CPU):
> > > > > >>>>>>
> > > > > >>>>>> IIUC the tool is doing the wrong thing here and overriding=
 explicit
> > > > > >>>>>> ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rat=
her than events using
> > > > > >>>>>> that ${pmu}'s type and event namespace.
> > > > > >>>>>>
> > > > > >>>>>> Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE=
 events to be
> > > > > >>>>>> targetted to a specific PMU, it's semantically wrong to re=
write events like
> > > > > >>>>>> this since ${pmu}/${event}/ is not necessarily equivalent =
to a similarly-named
> > > > > >>>>>> PERF_COUNT_HW_${EVENT}.
> > > > > >>>>>
> > > > > >>>>> If you name a PMU and an event then the event should only b=
e opened on
> > > > > >>>>> that PMU, 100% agree. There's a bunch of output, but when t=
he legacy
> > > > > >>>>> cycles event is opened it appears to be because it was expl=
icitly
> > > > > >>>>> requested.
> > > > > >>>>
> > > > > >>>> I think you've missed that the named PMU events are being er=
reously transformed
> > > > > >>>> into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g=
.
> > > > > >>>>
> > > > > >>>>   Opening: apple_firestorm_pmu/cycles/
> > > > > >>>>   ----------------------------------------------------------=
--
> > > > > >>>>   perf_event_attr:
> > > > > >>>>     type                             0 (PERF_TYPE_HARDWARE)
> > > > > >>>>     size                             136
> > > > > >>>>     config                           0 (PERF_COUNT_HW_CPU_CY=
CLES)
> > > > > >>>>     sample_type                      IDENTIFIER
> > > > > >>>>     read_format                      TOTAL_TIME_ENABLED|TOTA=
L_TIME_RUNNING
> > > > > >>>>     disabled                         1
> > > > > >>>>     inherit                          1
> > > > > >>>>     enable_on_exec                   1
> > > > > >>>>     exclude_guest                    1
> > > > > >>>>   ----------------------------------------------------------=
--
> > > > > >>>>   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  fla=
gs 0x8 =3D 4
> > > > > >>>>
> > > > > >>>> ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_=
CPU_CYCLES.
> > > > > >>>>
> > > > > >>>> Marc said that he bisected the issue down to commit:
> > > > > >>>>
> > > > > >>>>   5ea8f2ccffb23983 ("perf parse-events: Support hardware eve=
nts as terms")
> > > > > >>>>
> > > > > >>>> ... so it looks like something is going wrong when the event=
s are being parsed,
> > > > > >>>> e.g. losing the HW PMU information?
> > > > > >>>
> > > > > >>> Ok, I think I'm getting confused by other things. This looks =
like the issue.
> > > > > >>>
> > > > > >>> I think it may be working as intended, but not how you intend=
ed :-) If
> > > > > >>> a core PMU is listed and then a legacy event, the legacy even=
t should
> > > >
> > > > The point is that "cycles" when prefixed with "pmu/" shouldn't be
> > > > considered "cycles" as HW/0, in that setting it is "cycles" for tha=
t
> > > > PMU.
> > >
> > > Exactly.
> > >
> > > > (but we only have "cpu_cycles" for at least the a53 and a72 PMUs I
> > > > have access in a Libre Computer rockchip 3399-pc hybrid board, if w=
e use
> > > > it, then we get what we want/had before, see below):
> > >
> > > Both Cortex-A53 and Cortex-A72 have the common PMUv3 events, so they =
have
> > > "cpu_cycles" and "bus_cycles".
> > >
> > > The Apple PMUs that Hector and Marc anre using don't follow the PMUv3
> > > architecture, and just have a "cycles" event.
> > >
> > > [...]
> > >
> > > > So what we need here seems to be to translate the generic term "cyc=
les"
> > > > to "cpu_cycles" when a PMU is explicitely passed in the event name =
and
> > > > it doesn't have "cycles" and then just retry.
> > >
> > > I'm not sure we need to map that.
> > >
> > > My thinking is:
> > >
> > > * If the user asks for "cycles" without a PMU name, that should use t=
he
> > >   PERF_TYPE_HARDWARE cycles event. The ARM PMUs handle that correctly=
 when the
> > >   event is directed to them.
> > >
> > > * If the user asks for "${pmu}/cycles/", that should only use the "cy=
cles"
> > >   event in that PMU's namespace, not PERF_TYPE_HARDWARE.
> > >
> > > * If we need a way so say "use the PERF_TYPE_HARDWARE cycles event on=
 ${pmu}",
> > >   then we should have a new syntax for that (e.g. as we have for raw =
events),
> > >   e.g. it would be possible to have "pmu/hw:cycles/" or something lik=
e that.
> > >
> > > That way there's no ambiguity.
> >
> > This would break cpu_core/LLC-load-misses/ on Intel hybrid as the
> > LLC-load-misses event is legacy and not advertised in either sysfs or
> > in json.
>
> Indeed:
>
> [root@quaco ~]# ls /sys/devices/cpu/events/
> branch-instructions  bus-cycles    cache-references  instructions  mem-st=
ores  topdown-fetch-bubbles     topdown-recovery-bubbles.scale  topdown-slo=
ts-retired  topdown-total-slots.scale
> branch-misses        cache-misses  cpu-cycles        mem-loads     ref-cy=
cles  topdown-recovery-bubbles  topdown-slots-issued            topdown-tot=
al-slots
> [root@quaco ~]# strace -e perf_event_open perf stat -e cpu/LLC-load-misse=
s/ echo
> perf_event_open({type=3DPERF_TYPE_HW_CACHE, size=3D0x88 /* PERF_ATTR_SIZE=
_??? */, config=3DPERF_COUNT_HW_CACHE_RESULT_MISS<<16|PERF_COUNT_HW_CACHE_O=
P_READ<<8|PERF_COUNT_HW_CACHE_LL, sample_period=3D0, sample_type=3DPERF_SAM=
PLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TO=
TAL_TIME_RUNNING, disabled=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=
=3D0 /* arbitrary skid */, exclude_guest=3D1, ...}, 41467, -1, -1, PERF_FLA=
G_FD_CLOEXEC) =3D 3
>
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D41467, si=
_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>
>  Performance counter stats for 'echo':
>
>              1,015      cpu/LLC-load-misses/
>
>        0.005167119 seconds time elapsed
>
>        0.000821000 seconds user
>        0.004105000 seconds sys
>
>
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D41466, si_ui=
d=3D0} ---
> +++ exited with 0 +++
> [root@quaco ~]#
>
> Is it difficult to before doing the current expansion to
> PERF_TYPE_HARDWARE/PERF_HW_CPU_CYCLES just check if there is an event
> with the name specified in the PMU specified, if there is, use that.

Agreed and I've sent an early cut of this. The issue is that then we
end up changing the encoding on Intel. I also don't see why ARM
doesn't just fix their PMU.

Thanks,
Ian

> - Arnaldo
