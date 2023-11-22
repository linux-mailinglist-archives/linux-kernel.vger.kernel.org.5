Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23477F4C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjKVQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjKVQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:30:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825418E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:30:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so72185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700670611; x=1701275411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHnjIARUfq2ouDs+GLSHptQ/hCsfvDTFHRORL+DZfEo=;
        b=IbIjChhoCA6kv4/8v3Jv4lWkFMDbAi/5RJdzKMEPYzQKVucSK1Vl8n8eWsWHQxK1TF
         MXLb3/LtvxqEkwz9NfLzADGFzo//v4Vp586xVIFuMYZYKJcdB7OLZfdKaMCgmMIaFSgy
         L7mPeetQ50tfZLKqOxX1fHwxaooHjSU+8BAENorMdM0fMZOEdyYwhVf/1rAR4dGrnZTC
         Z9Mz5gEO9MWU3QT3oAuq5PsGzuIhR3K0CDcGIjDqItzSmGvgLkQiSy1shIZtoC1dpz9/
         vFlyiGJl6Sj9X0PUUW+yqpHcAwtwEQIbavhkqdigkzrSDfEw2HeMiw4sYtvIDMLmdwvO
         Iqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700670611; x=1701275411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHnjIARUfq2ouDs+GLSHptQ/hCsfvDTFHRORL+DZfEo=;
        b=v3aA9slJZBlHst6XSSBksuQuoGZquRWPlAstPr7RfYc88Tv6hfgzf3YmIiyCUreyG5
         YpyDO0tnCcorUtQWupGGoAhpSqZ5vzRd8tKiWj07W/I3GAbAqHxQ6uoWTp/cKACWUc0o
         3aCN10xEHkcKaJSovrlknetvOr4qC89etGQ8hpPSCwO5C/w1X+P7DkvLUPh9yn00dYAF
         5gABvwF5Wykl/yfMDe9CHRKT88OOgnDtxjilugAgPAm6YAyvGm6glQbRmbBCY9b4T+0M
         ydlDR3Dz5XDlgFSHleeUVabUnHRBrHERCDgoyRE1fvK5X836719AArOd97Yx8Shgqhgj
         fQJA==
X-Gm-Message-State: AOJu0YzO9T25a515xvpuwnuTn6OHaEZgwBA26kbiY4qBobYKywBokrsm
        VDPXQfNj5UbQb4fzgHLZaXZmGS57ny/Z8LbrrxZSCg==
X-Google-Smtp-Source: AGHT+IHmG06Kd+O6NSBN7xo5Ql5xEARTKXaxoDtpIO95yA2j+CBQd8y4oNPVlDnG64aGznRJYIugsc3BG+Jc48eUQiE=
X-Received: by 2002:a05:600c:2047:b0:405:320a:44f9 with SMTP id
 p7-20020a05600c204700b00405320a44f9mr117837wmg.5.1700670610669; Wed, 22 Nov
 2023 08:30:10 -0800 (PST)
MIME-Version: 1.0
References: <86pm03z0kw.wl-maz@kernel.org> <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <ZV38ParIEYWOjt6T@FVFF77S0Q05N> <CAP-5=fUxBv4kbXyLrD5G-=wyRh6tKEJMy5qX0_86wQXxT79dJw@mail.gmail.com>
 <ZV4nj-_q4hHaf8Wl@FVFF77S0Q05N>
In-Reply-To: <ZV4nj-_q4hHaf8Wl@FVFF77S0Q05N>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Nov 2023 08:29:58 -0800
Message-ID: <CAP-5=fWtHYr9J2izkNmTpfKvdEdt0ViELJ1Gsih6H9XBTE83UA@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 8:08=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, Nov 22, 2023 at 07:29:34AM -0800, Ian Rogers wrote:
> > On Wed, Nov 22, 2023 at 5:04=E2=80=AFAM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > > On Tue, Nov 21, 2023 at 08:38:45AM -0800, Ian Rogers wrote:
> > > > On Tue, Nov 21, 2023 at 8:15=E2=80=AFAM Mark Rutland <mark.rutland@=
arm.com> wrote:
> > > > > On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
> > > > > > On Tue, Nov 21, 2023 at 8:03=E2=80=AFAM Mark Rutland <mark.rutl=
and@arm.com> wrote:
> > > > > > > On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> > > > > > > > On Tue, Nov 21, 2023 at 7:40=E2=80=AFAM Mark Rutland <mark.=
rutland@arm.com> wrote:
> > > > > > > > > On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wr=
ote:
> > > > > > > > > > On Tue, 21 Nov 2023 13:40:31 +0000,
> > > > > > > > > > Marc Zyngier <maz@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > [Adding key people on Cc]
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 21 Nov 2023 12:08:48 +0000,
> > > > > > > > > > > Hector Martin <marcan@marcan.st> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Perf broke on all Apple ARM64 systems (tested almos=
t everything), and
> > > > > > > > > > > > according to maz also on Juno (so, probably all big=
.LITTLE) since v6.5.
> > > > > > > > > > >
> > > > > > > > > > > I can confirm that at least on 6.7-rc2, perf is prett=
y busted on any
> > > > > > > > > > > asymmetric ARM platform. It isn't clear what criteria=
 is used to pick
> > > > > > > > > > > the PMU, but nothing works anymore.
> > > > > > > > > > >
> > > > > > > > > > > The saving grace in my case is that Debian still ship=
s a 6.1 perftool
> > > > > > > > > > > package, but that's obviously not going to last.
> > > > > > > > > > >
> > > > > > > > > > > I'm happy to test potential fixes.
> > > > > > > > > >
> > > > > > > > > > At Mark's request, I've dumped a couple of perf (as of =
-rc2) runs with
> > > > > > > > > > -vvv.  And it is quite entertaining (this is taskset to=
 an 'icestorm'
> > > > > > > > > > CPU):
> > > > > > > > >
> > > > > > > > > IIUC the tool is doing the wrong thing here and overridin=
g explicit
> > > > > > > > > ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events ra=
ther than events using
> > > > > > > > > that ${pmu}'s type and event namespace.
> > > > > > > > >
> > > > > > > > > Regardless of the *new* ABI that allows PERF_TYPE_HARDWAR=
E events to be
> > > > > > > > > targetted to a specific PMU, it's semantically wrong to r=
ewrite events like
> > > > > > > > > this since ${pmu}/${event}/ is not necessarily equivalent=
 to a similarly-named
> > > > > > > > > PERF_COUNT_HW_${EVENT}.
> > > > > > > >
> > > > > > > > If you name a PMU and an event then the event should only b=
e opened on
> > > > > > > > that PMU, 100% agree. There's a bunch of output, but when t=
he legacy
> > > > > > > > cycles event is opened it appears to be because it was expl=
icitly
> > > > > > > > requested.
> > > > > > >
> > > > > > > I think you've missed that the named PMU events are being err=
eously transformed
> > > > > > > into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
> > > > > > >
> > > > > > >   Opening: apple_firestorm_pmu/cycles/
> > > > > > >   -----------------------------------------------------------=
-
> > > > > > >   perf_event_attr:
> > > > > > >     type                             0 (PERF_TYPE_HARDWARE)
> > > > > > >     size                             136
> > > > > > >     config                           0 (PERF_COUNT_HW_CPU_CYC=
LES)
> > > > > > >     sample_type                      IDENTIFIER
> > > > > > >     read_format                      TOTAL_TIME_ENABLED|TOTAL=
_TIME_RUNNING
> > > > > > >     disabled                         1
> > > > > > >     inherit                          1
> > > > > > >     enable_on_exec                   1
> > > > > > >     exclude_guest                    1
> > > > > > >   -----------------------------------------------------------=
-
> > > > > > >   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flag=
s 0x8 =3D 4
> > > > > > >
> > > > > > > ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_C=
PU_CYCLES.
> > > > > > >
> > > > > > > Marc said that he bisected the issue down to commit:
> > > > > > >
> > > > > > >   5ea8f2ccffb23983 ("perf parse-events: Support hardware even=
ts as terms")
> > > > > > >
> > > > > > > ... so it looks like something is going wrong when the events=
 are being parsed,
> > > > > > > e.g. losing the HW PMU information?
> > > > > >
> > > > > > Ok, I think I'm getting confused by other things. This looks li=
ke the issue.
> > > > > >
> > > > > > I think it may be working as intended, but not how you intended=
 :-) If
> > > > > > a core PMU is listed and then a legacy event, the legacy event =
should
> > > > > > be opened on the core PMU as a legacy event with the extended t=
ype
> > > > > > set. This is to allow things like legacy cache events to be ope=
ned on
> > > > > > a specified PMU. Legacy event names match with a higher priorit=
y than
> > > > > > those in sysfs or json as they are hard coded.
> > > > >
> > > > > That has never been the case previously, so this is user-visible =
breakage, and
> > > > > it prevents users from being able to do the right thing, so I thi=
nk that's a
> > > > > broken design.
> > > >
> > > > So the problem was caused by ARM and Intel doing two different thin=
gs.
> > > > Intel did at least contribute to the perf tool in support for their
> > > > BIG.little/hybrid, so that's why the semantics match their approach=
.
> > >
> > > I appreciate that, and I agree that from the Arm side we haven't been=
 as
> > > engaged with userspace on this front (please understand I'm the messe=
nger here,
> > > this is something I've repeatedly asked for within Arm).
> > >
> > > Regardless, I don't think that changes the substance of the bug, whic=
h is that
> > > we're converting named-pmu events into entirely different PERF_TYPE_H=
ARDWARE
> > > events.
> > >
> > > I agree that expanding plain legacy event names to a set of PMU-taget=
ted legacy
> > > events makes sense (and even for Arm, that's the right thing to do, I=
MO). If
> > > I ask for 'cycles' and that gets expanded to multiple legacy cycles e=
vents that
> > > target specific CPU PMUs, that's good.
> > >
> > > The thing that doesn't make sense here is converting named-pmu events=
 into
> > > egacy events. If I ask for 'apple_firestorm_pmu/cycles/', that should=
 be the
> > > 'cycles' event in the apple_firestorm_pmu's event namespace, and *sho=
uldn't* be
> > > converted to a (potentially semantically different) PERF_TYPE_HARDWAR=
E event,
> > > even if that's targetted towards the apple_firestorm_pmu. I think tha=
t should
> > > be true for *any* PMU, whether thats an arm/x86/whatever CPU PMU or a=
 system
> > > PMU.
> >
> > This is saying that legacy events are lower than system events. We
> > don't do this historically and as it requires extra PMU set up. On an
> > Intel Tigerlake:
> >
> > ```
> > $ ls /sys/devices/cpu/events
> > branch-instructions  cache-misses      instructions  ref-cycles
> > topdown-be-bound
> > branch-misses        cache-references  mem-loads     slots
> > topdown-fe-bound
> > bus-cycles           cpu-cycles        mem-stores    topdown-bad-spec
> > topdown-retiring
> > ```
> > here (at least) branch-misses, bus-cycles, cache-references,
> > cpu-cycles and instructions overlap with legacy event names
> > ```
> > $ perf --version
> > perf version 6.5.6
> > $ perf stat -vv -e branch-misses,bus-cycles,cache-references,cp
> > u-cycles,instructions true
>
> Here you *aren't using a named PMU. As I said before, using the
> PERF_TYPE_HARDWARE events in this case is entriely fine, it's just the
> ${pmu}/${eventname}/ case that I'm saying should use the PMU's namespace,
> which was historically the case, and is what users are depending upon.
>
> i.e.
>
>         perf stat -e cycles ./workload
>
> ... can/should use PERF_TYPE_HARDWARE events, as it used to
>
> However:
>
>         perf srtat -e ${pmu}/cycles/ ./workload
>
> ... should use the PMU's namespaced events, as it used to
>
> > Using CPUID GenuineIntel-6-8D-1
> > intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branc=
h
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >  type                             0 (PERF_TYPE_HARDWARE)
> >  size                             136
> >  config                           0x5 (PERF_COUNT_HW_BRANCH_MISSES)
> > ...
> > ------------------------------------------------------------
> > perf_event_attr:
> >  type                             0 (PERF_TYPE_HARDWARE)
> >  size                             136
> >  config                           0x6 (PERF_COUNT_HW_BUS_CYCLES)
> > ...
> > ------------------------------------------------------------
> > perf_event_attr:
> >  type                             0 (PERF_TYPE_HARDWARE)
> >  size                             136
> >  config                           0x2 (PERF_COUNT_HW_CACHE_REFERENCES)
> > ...
> > ------------------------------------------------------------
> > perf_event_attr:
> >  type                             0 (PERF_TYPE_HARDWARE)
> >  size                             136
> >  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > ...
> > ------------------------------------------------------------
> > perf_event_attr:
> >  type                             0 (PERF_TYPE_HARDWARE)
> >  size                             136
> >  config                           0x1 (PERF_COUNT_HW_INSTRUCTIONS)
> > ...
> > branch-misses: -1: 6571 826226 826226
> > bus-cycles: -1: 31411 826226 826226
> > cache-references: -1: 19507 826226 826226
> > cpu-cycles: -1: 1127215 826226 826226
> > instructions: -1: 1301583 826226 826226
> > branch-misses: 6571 826226 826226
> > bus-cycles: 31411 826226 826226
> > cache-references: 19507 826226 826226
> > cpu-cycles: 1127215 826226 826226
> > instructions: 1301583 826226 826226
> >
> > Performance counter stats for 'true':
> > ...
> > ```
> > ie perf 6.5 and all events even though sysfs has events we're opening
> > them with PERF_TYPE_HARDWARE.
>
> As above, this is a different case.
>
> >
> > > > > > Presumably the expectation was that by advertising a cycles eve=
nt, presumably
> > > > > > in sysfs, then this is what would be matched.
> > >
> > > Yes. That's how this has always worked prior to the changes Marc refe=
renced.
> > > Note that this can *also* be expaned to events from json databases, b=
ut was
> > > *never* previously silently converted to a PERF_TYPE_HARDWARE event.
> > >
> > > Please note that the events in sysfs are *namespaced* to the PMU (spe=
cifically,
> > > when using that PMU's dynamic type); they are not necessarily the sam=
e as
> > > legacy events (though they may have similar or matching
> > > names in some cases), they may be semantically distinct from the lega=
cy events
> > > even if the names match, and it is incorrect to conflate the two.
> >
> > This was a behavior added by Intel so that say cpu_atom/legacy-event/
> > would only open as a hardware event on that PMU. The point of the
> > blamed change is to make that behavior consistent for all core PMUs.
>
> Ok, so Intel has an intel-specific behaviour change, which was ok for the=
m.
>
> That was made generic, but cause d a functional regression on arm (and po=
ssibly
> other architectures if anyone else cares about the namespaced events).
>
> Why can't this be rteturned to being x86 specific?
>
> > > > > I expect that if I ask for ${pmu}/${event}/, that PMU is used, an=
d the event
> > > > > *in that PMU's namespace* is used. Overriding that breaks long-es=
tablished
> > > > > practice and provides users with no recourse to get the behavioru=
 they expect
> > > > > (and previosuly had).
> > > >
> > > > On ARM but not Intel.
> > >
> > > As above, I don't think the CPU architecture matters here for the cas=
e that I'm
> > > saying is broken. I think that regardless of CPU architecture (or for=
 any
> > > non-CPU PMU) it is semantically incorrect to convert a named-pmu even=
t to a
> > > legacy event.
> >
> > So perf's behavior has always been that legacy event priority is
> > greater-than sysfs and json. The distinction here is that a core PMU
> > is explicitly listed and it doesn't seem unreasonable to use core PMU
> > names with legacy events, the behavior Intel added.
>
> That may be ok for Intel, but given it *is* causing functional probelsm f=
or
> others, why must it remain generic?
>
> > > > > I do think that (regardless of whther this was the sematnic you i=
ntended)
> > > > > silently overriding events with legacy events is a bug, and one w=
e should fix.
> > > > > As I mentioned in another reply, just because the events have the=
 same name
> > > > > does not mean that they are semantically the same, so we're liabl=
e to give
> > > > > people the wrong numbers anyhow.
> > > > >
> > > > > Can we fix this?
> > > >
> > > > So I'd like to fix this, some things from various conversations:
> > > >
> > > > 1) we lack testing. Our testing relies on the sysfs of the machine
> > > > being run on, which is better than nothing. I think ideally we'd ha=
ve
> > > > a collection of zipped up sysfs directories and then we could have =
a
> > > > test that asserts on ARM you get the behavior you want.
> > >
> > > I agree we lack testing, and I'd be happy to help here going forwards=
, though I
> > > don't think this is a prerequisite for fixing this issue.
> > >
> > > > 2) for RISC-V they want to make the legacy event matching something=
 in
> > > > user land to simplify the PMU driver.
> > >
> > > Ok; I see how this might be related, but it doesn't sound like a prer=
equisite
> > > for fixing this issue -- there are plenty of people in this thread wh=
o can
> > > test.
> > >
> > > > 3) I'd like to get rid of the PMU json interface. My idea is to
> > > > convert json events/metrics into sysfs style files, zip these up an=
d
> > > > then link them into the perf binary. On Intel the json is 70% of th=
e
> > > > binary (7MB out of 10MB) and we may get this down to 3MB with this
> > > > approach. The json lookup would need to incorporate the cpuid match=
ing
> > > > that currently exists. When we look up an event I'd like the approa=
ch
> > > > to be like unionfs with a specified but configurable order. Users
> > > > could provide directories of their own events/metrics for various
> > > > PMUs, and then this approach could be used to help with (1).
> > >
> > > I can see how that might interact with whatever changes we make to fi=
x this
> > > issue, but this seems like a future aspiration, and not a prerequisit=
e for
> > > fixing the existing functional regression.
> > >
> > > > Those proposals are not something to add as a -rc fix, so what I th=
ink
> > > > you're asking for here is a "if ARM" fix somewhere in the event
> > > > parsing. That's of course possible but it will cause problems if yo=
u
> > > > did say:
> > > >
> > > > perf stat -e arm_pmu/LLC-load-misses/ ...
> > >
> > > As above, I do not think this is an arm-specific issue, we're just th=
e canary
> > > in the coalmine.
> >
> > Disagree, see comments above. A behavior change here would impact Intel=
.
>
> Ok, so have Intel keep the Intel behaviour?
>
> > > Please note that:
> > >
> > >         perf stat -e arm_pmu/LLC-load-misses/ ...
> > >
> > > ... would never have worked previously. No arm_pmu instances have a
> > > "LLC-load-misses" event in their event namespaces, and we don't have =
any
> > > userspace file mapping that event.
> >
> > This event was for the purpose of giving an example, perf list will
> > show you events that work. The point is that a legacy event may not be
> > available on both BIG.little PMU types so being able to designate the
> > PMU there is helpful.
>
> Sure, but (as per my reply to Arnaldo), it's possible to add an unambiguo=
us way
> to specify that, e.g a 'hw:' prefix like:
>
>         some_arm_pmu/hw:LLC-load-misses/
>
> ... which wouldn't clash and cause hte regression that users are seing.
>
> > > That said, If I really wanted that legacy event, I'd have asked for i=
t bare,
> > > e.g.
> > >
> > >         perf stat -e LLC-load-misses
> > >
> > > ... and we're in agreement that it's sensible to expand this to multi=
ple
> > > PERF_TYPE_HARDWARE events targeting the individual CPU PMUs.
> > >
> > > So I see no need to do anything to have magic for 'arm_pmu/LLC-load-m=
isses/'.
> > >
> > > > as I doubt the PMU driver is advertising this legacy event in sysfs
> > > > and the "if ARM" logic would presumably be trying to disable legacy
> > > > events in the term list for the ARM PMU.
> > > >
> > > > Given all of this, is anything actually broken and needing a fix fo=
r 6.7?
> > >
> > > There is absolutely a bug that needs to be fixed here (and needs to b=
e
> > > backported to stable so that it gets picked up by distributions).
> >
> > I'm not seeing this. The behavior is consistent with Intel, this has
> > gone 2 releases without being spotted,
>
> This has gone two releases because people has just updated their tools. T=
he
> prior behaviour for Arm has been there for most of a decade.
>
> > it was triggered by a PMU event
> > name aliasing a legacy event name and the behavior has always been
> > legacy event names have higher priority than sysfs and json events.
>
> That has been the case for plain events without a PMU name. That was neve=
r the
> case for events with a PMU name, or there would not have been any differe=
nce in
> behaviour.
>
> > Whilst I'm seeing a lot of complaining, I've not seen a proposal of
> > what behavior you want.
>
> As per my initial reply the bevaiour we want is that:
>
>   pmu/eventname/
>
> ... opens 'eventname' in that PMU's event namespace, rather than converti=
ng the
> event into a PERF_TYPE_HARDWARE event. That was the prior behaviour, whic=
h
> people have been using for most of a decade.
>
> I understand that there was some Intel-specific behaviour, and that may n=
eed to
> be kept for Intel. Making that behaviour generic broke other existing use=
rs.
>
> If we need a mechanism to target a legacy event to a specific PMU, we can=
 add
> an unambiguous way of descirbing that (e.g. the 'hw:' prefix I've suggest=
ed a
> few times).
>
>
> > Isn't it a PMU bug if the legacy event specifying the PMU doesn't get o=
pened
> > by the core PMU?
>
> No?
>
> Prior to that mechanism being added to the kernel, there was no way to do=
 that.
>
> When the mechanism was added to x86 specifically, it wasn't a generic fea=
ture.
>
> > Fixing the PMU driver appears to be the right fix and means there is
> > consistency on core events across architectures.
>
> I think that's orthogonal.
>
> Adding support to the PMU drivers (which has already been done, per the c=
ommit
> you quoted before) is good so that userspace can do the right thing for:
>
>         perf stat -e some_generic_event ./workload
>
> ... but that should not be necessary to retain the existing behaviour for=
:
>
>         perf stat -e pmu/some_similarly_named_event/ ./workload
>
> Thanks,
> Mark.

Given the PMU mapping exists, what is the difficulty in the case of
this PMU? I could explain what I see on ARMv8 devices and the broken
PMU landscape from the last 10 years but that hardly feels
constructive here. I'm not understanding the difficulty of
translating:

struct perf_event_attr {
...
 .type =3D PERF_TYPE_HARDARE,
 .config =3D <pmu's type> << 32 | PERF_COUNT_HW_CPU_CYCLES,
...
}

to the event called "cycles" that the PMU is advertising? Given the
mapping already has to exist for every core PMU driver.

I can look at doing an event parser change like:

```
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index aa2f5c6fc7fc..9a18fda525d2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -986,7 +986,8 @@ static int config_term_pmu(struct perf_event_attr *attr=
,
                                                          err_str,
/*help=3D*/NULL);
                       return -EINVAL;
               }
-               if (perf_pmu__supports_legacy_cache(pmu)) {
+               if (perf_pmu__supports_legacy_cache(pmu) &&
+                   !perf_pmu__have_event(pmu, term->val.str)) {
                       attr->type =3D PERF_TYPE_HW_CACHE;
                       return
parse_events__decode_legacy_cache(term->config, pmu->type,
                                                                &attr->conf=
ig);
@@ -1004,10 +1005,15 @@ static int config_term_pmu(struct perf_event_attr *=
attr,
                                                          err_str,
/*help=3D*/NULL);
                       return -EINVAL;
               }
-               attr->type =3D PERF_TYPE_HARDWARE;
-               attr->config =3D term->val.num;
-               if (perf_pmus__supports_extended_type())
-                       attr->config |=3D (__u64)pmu->type << PERF_PMU_TYPE=
_SHIFT;
+               if (perf_pmu__have_event(pmu, term->val.str)) {
+                       /* If the PMU has a sysfs or json event prefer
it over legacy. ARM requires this. */
+                       term->term_type =3D PARSE_EVENTS__TERM_TYPE_USER;
+               } else {
+                       attr->type =3D PERF_TYPE_HARDWARE;
+                       attr->config =3D term->val.num;
+                       if (perf_pmus__supports_extended_type())
+                               attr->config |=3D (__u64)pmu->type <<
PERF_PMU_TYPE_SHIFT;
+               }
               return 0;
       }
       if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
```
(note: this is incomplete as term->val.str isn't populated for
PARSE_EVENTS__TERM_TYPE_HARDWARE)

but this is a behavioral change on Intel and shouldn't therefore come
in as an rc fix.

Thanks,
Ian
