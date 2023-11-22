Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ABE7F4A40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjKVP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKVP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:29:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6254FD8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:29:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso12668a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700666987; x=1701271787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9dOCm5SU1mMLPQ9rPgmLvh5++djlzqvOD55yee9GwI=;
        b=MbfJINdgmTKwLVdJ2ZqODosPoPHV8zL7RI8w+zbtqmj95wfWUMuLy+EU+ud7SoUr/h
         chX2Z+cH14xVNJyZqGvDD6WzIlKY7k8LSqoJcEBpkJSutQsGM79hjj2XnVMeAvc1vzpQ
         oqlNswcJahYOADe/ZMKI4yeUpUDTW/235DCVmsHXxXGWScgckgD7QGyW/xXQRCu9LRqV
         gdETCMok9TuXp2hrecrwPHcCE4x5yD1ABtvjFDz9i5ayNL19Y7O0TgPh1Pw+QHbHLrpT
         pNvpRKnyyhJPFnFNvZfe9pbH78q+/jv58PyTNK9Yu45b/mzhZ2u8IAW5LpagIAgf4mXw
         b/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666987; x=1701271787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9dOCm5SU1mMLPQ9rPgmLvh5++djlzqvOD55yee9GwI=;
        b=gkHKMRoy0DjDaYBR1wwAlrKOWctf3ASPUFngjrqQon56e9xex3fXMLHb+KhRUhmxyk
         C5KSJYiFEBuicTMuQUb1vBviTUX1WeVTQ3PHlzi0z2yICEQ2B//RTxS0x4jz66KB0uLt
         /N6LEqL0Ql16Wt7zOZT+2f0K793qAdqbUT89IrijdezNjZBAP11ocNbhjBNEvxlDyFJX
         2xK5RmOCm7yWAEXHCOl8zZ96PgtybhiVsvBiEy0lIXlRrXpetnfpLmOKwg3EXNppZ8dn
         yHVQelPE/zzFKJqapXUZOzsEbxweR1hIzCtJz6b334Rtit9R7/TGLCY+6Fn87Q4tNaXh
         UJNw==
X-Gm-Message-State: AOJu0Yy9q2KLh1t00M0ry+7Udsrrw2SRsrQgC+nIHH9aBAD9fgcJQv6E
        uhQNf3hFrT7kmpWpWghZ+6BWRmiQhCyDmxXkiBNwmw==
X-Google-Smtp-Source: AGHT+IHyMYA+l6DYjgWNxneqMcAUH0qwfXEpRcCi+2+/1JhcDH7zq+nyT+k/bmP7CKy3YDsDb3kui/RgozpfAT31ZFg=
X-Received: by 2002:a05:6402:5516:b0:54a:94af:8743 with SMTP id
 fi22-20020a056402551600b0054a94af8743mr23159edb.5.1700666986545; Wed, 22 Nov
 2023 07:29:46 -0800 (PST)
MIME-Version: 1.0
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org> <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <ZV38ParIEYWOjt6T@FVFF77S0Q05N>
In-Reply-To: <ZV38ParIEYWOjt6T@FVFF77S0Q05N>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Nov 2023 07:29:34 -0800
Message-ID: <CAP-5=fUxBv4kbXyLrD5G-=wyRh6tKEJMy5qX0_86wQXxT79dJw@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 5:04=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Nov 21, 2023 at 08:38:45AM -0800, Ian Rogers wrote:
> > On Tue, Nov 21, 2023 at 8:15=E2=80=AFAM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > >
> > > On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
> > > > On Tue, Nov 21, 2023 at 8:03=E2=80=AFAM Mark Rutland <mark.rutland@=
arm.com> wrote:
> > > > >
> > > > > On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> > > > > > On Tue, Nov 21, 2023 at 7:40=E2=80=AFAM Mark Rutland <mark.rutl=
and@arm.com> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
> > > > > > > > On Tue, 21 Nov 2023 13:40:31 +0000,
> > > > > > > > Marc Zyngier <maz@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > [Adding key people on Cc]
> > > > > > > > >
> > > > > > > > > On Tue, 21 Nov 2023 12:08:48 +0000,
> > > > > > > > > Hector Martin <marcan@marcan.st> wrote:
> > > > > > > > > >
> > > > > > > > > > Perf broke on all Apple ARM64 systems (tested almost ev=
erything), and
> > > > > > > > > > according to maz also on Juno (so, probably all big.LIT=
TLE) since v6.5.
> > > > > > > > >
> > > > > > > > > I can confirm that at least on 6.7-rc2, perf is pretty bu=
sted on any
> > > > > > > > > asymmetric ARM platform. It isn't clear what criteria is =
used to pick
> > > > > > > > > the PMU, but nothing works anymore.
> > > > > > > > >
> > > > > > > > > The saving grace in my case is that Debian still ships a =
6.1 perftool
> > > > > > > > > package, but that's obviously not going to last.
> > > > > > > > >
> > > > > > > > > I'm happy to test potential fixes.
> > > > > > > >
> > > > > > > > At Mark's request, I've dumped a couple of perf (as of -rc2=
) runs with
> > > > > > > > -vvv.  And it is quite entertaining (this is taskset to an =
'icestorm'
> > > > > > > > CPU):
> > > > > > >
> > > > > > > IIUC the tool is doing the wrong thing here and overriding ex=
plicit
> > > > > > > ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather=
 than events using
> > > > > > > that ${pmu}'s type and event namespace.
> > > > > > >
> > > > > > > Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE ev=
ents to be
> > > > > > > targetted to a specific PMU, it's semantically wrong to rewri=
te events like
> > > > > > > this since ${pmu}/${event}/ is not necessarily equivalent to =
a similarly-named
> > > > > > > PERF_COUNT_HW_${EVENT}.
> > > > > >
> > > > > > If you name a PMU and an event then the event should only be op=
ened on
> > > > > > that PMU, 100% agree. There's a bunch of output, but when the l=
egacy
> > > > > > cycles event is opened it appears to be because it was explicit=
ly
> > > > > > requested.
> > > > >
> > > > > I think you've missed that the named PMU events are being erreous=
ly transformed
> > > > > into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
> > > > >
> > > > >   Opening: apple_firestorm_pmu/cycles/
> > > > >   ------------------------------------------------------------
> > > > >   perf_event_attr:
> > > > >     type                             0 (PERF_TYPE_HARDWARE)
> > > > >     size                             136
> > > > >     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > > > >     sample_type                      IDENTIFIER
> > > > >     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIM=
E_RUNNING
> > > > >     disabled                         1
> > > > >     inherit                          1
> > > > >     enable_on_exec                   1
> > > > >     exclude_guest                    1
> > > > >   ------------------------------------------------------------
> > > > >   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x=
8 =3D 4
> > > > >
> > > > > ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_C=
YCLES.
> > > > >
> > > > > Marc said that he bisected the issue down to commit:
> > > > >
> > > > >   5ea8f2ccffb23983 ("perf parse-events: Support hardware events a=
s terms")
> > > > >
> > > > > ... so it looks like something is going wrong when the events are=
 being parsed,
> > > > > e.g. losing the HW PMU information?
> > > >
> > > > Ok, I think I'm getting confused by other things. This looks like t=
he issue.
> > > >
> > > > I think it may be working as intended, but not how you intended :-)=
 If
> > > > a core PMU is listed and then a legacy event, the legacy event shou=
ld
> > > > be opened on the core PMU as a legacy event with the extended type
> > > > set. This is to allow things like legacy cache events to be opened =
on
> > > > a specified PMU. Legacy event names match with a higher priority th=
an
> > > > those in sysfs or json as they are hard coded.
> > >
> > > That has never been the case previously, so this is user-visible brea=
kage, and
> > > it prevents users from being able to do the right thing, so I think t=
hat's a
> > > broken design.
> >
> > So the problem was caused by ARM and Intel doing two different things.
> > Intel did at least contribute to the perf tool in support for their
> > BIG.little/hybrid, so that's why the semantics match their approach.
>
> I appreciate that, and I agree that from the Arm side we haven't been as
> engaged with userspace on this front (please understand I'm the messenger=
 here,
> this is something I've repeatedly asked for within Arm).
>
> Regardless, I don't think that changes the substance of the bug, which is=
 that
> we're converting named-pmu events into entirely different PERF_TYPE_HARDW=
ARE
> events.
>
> I agree that expanding plain legacy event names to a set of PMU-tagetted =
legacy
> events makes sense (and even for Arm, that's the right thing to do, IMO).=
 If
> I ask for 'cycles' and that gets expanded to multiple legacy cycles event=
s that
> target specific CPU PMUs, that's good.
>
> The thing that doesn't make sense here is converting named-pmu events int=
o
> egacy events. If I ask for 'apple_firestorm_pmu/cycles/', that should be =
the
> 'cycles' event in the apple_firestorm_pmu's event namespace, and *shouldn=
't* be
> converted to a (potentially semantically different) PERF_TYPE_HARDWARE ev=
ent,
> even if that's targetted towards the apple_firestorm_pmu. I think that sh=
ould
> be true for *any* PMU, whether thats an arm/x86/whatever CPU PMU or a sys=
tem
> PMU.

This is saying that legacy events are lower than system events. We
don't do this historically and as it requires extra PMU set up. On an
Intel Tigerlake:

```
$ ls /sys/devices/cpu/events
branch-instructions  cache-misses      instructions  ref-cycles
topdown-be-bound
branch-misses        cache-references  mem-loads     slots
topdown-fe-bound
bus-cycles           cpu-cycles        mem-stores    topdown-bad-spec
topdown-retiring
```
here (at least) branch-misses, bus-cycles, cache-references,
cpu-cycles and instructions overlap with legacy event names
```
$ perf --version
perf version 6.5.6
$ perf stat -vv -e branch-misses,bus-cycles,cache-references,cp
u-cycles,instructions true
Using CPUID GenuineIntel-6-8D-1
intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0x5 (PERF_COUNT_HW_BRANCH_MISSES)
...
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0x6 (PERF_COUNT_HW_BUS_CYCLES)
...
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0x2 (PERF_COUNT_HW_CACHE_REFERENCES)
...
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0 (PERF_COUNT_HW_CPU_CYCLES)
...
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0x1 (PERF_COUNT_HW_INSTRUCTIONS)
...
branch-misses: -1: 6571 826226 826226
bus-cycles: -1: 31411 826226 826226
cache-references: -1: 19507 826226 826226
cpu-cycles: -1: 1127215 826226 826226
instructions: -1: 1301583 826226 826226
branch-misses: 6571 826226 826226
bus-cycles: 31411 826226 826226
cache-references: 19507 826226 826226
cpu-cycles: 1127215 826226 826226
instructions: 1301583 826226 826226

Performance counter stats for 'true':
...
```
ie perf 6.5 and all events even though sysfs has events we're opening
them with PERF_TYPE_HARDWARE.

> > > > Presumably the expectation was that by advertising a cycles event, =
presumably
> > > > in sysfs, then this is what would be matched.
>
> Yes. That's how this has always worked prior to the changes Marc referenc=
ed.
> Note that this can *also* be expaned to events from json databases, but w=
as
> *never* previously silently converted to a PERF_TYPE_HARDWARE event.
>
> Please note that the events in sysfs are *namespaced* to the PMU (specifi=
cally,
> when using that PMU's dynamic type); they are not necessarily the same as
> legacy events (though they may have similar or matching
> names in some cases), they may be semantically distinct from the legacy e=
vents
> even if the names match, and it is incorrect to conflate the two.

This was a behavior added by Intel so that say cpu_atom/legacy-event/
would only open as a hardware event on that PMU. The point of the
blamed change is to make that behavior consistent for all core PMUs.

> > > I expect that if I ask for ${pmu}/${event}/, that PMU is used, and th=
e event
> > > *in that PMU's namespace* is used. Overriding that breaks long-establ=
ished
> > > practice and provides users with no recourse to get the behavioru the=
y expect
> > > (and previosuly had).
> >
> > On ARM but not Intel.
>
> As above, I don't think the CPU architecture matters here for the case th=
at I'm
> saying is broken. I think that regardless of CPU architecture (or for any
> non-CPU PMU) it is semantically incorrect to convert a named-pmu event to=
 a
> legacy event.

So perf's behavior has always been that legacy event priority is
greater-than sysfs and json. The distinction here is that a core PMU
is explicitly listed and it doesn't seem unreasonable to use core PMU
names with legacy events, the behavior Intel added.

> > > I do think that (regardless of whther this was the sematnic you inten=
ded)
> > > silently overriding events with legacy events is a bug, and one we sh=
ould fix.
> > > As I mentioned in another reply, just because the events have the sam=
e name
> > > does not mean that they are semantically the same, so we're liable to=
 give
> > > people the wrong numbers anyhow.
> > >
> > > Can we fix this?
> >
> > So I'd like to fix this, some things from various conversations:
> >
> > 1) we lack testing. Our testing relies on the sysfs of the machine
> > being run on, which is better than nothing. I think ideally we'd have
> > a collection of zipped up sysfs directories and then we could have a
> > test that asserts on ARM you get the behavior you want.
>
> I agree we lack testing, and I'd be happy to help here going forwards, th=
ough I
> don't think this is a prerequisite for fixing this issue.
>
> > 2) for RISC-V they want to make the legacy event matching something in
> > user land to simplify the PMU driver.
>
> Ok; I see how this might be related, but it doesn't sound like a prerequi=
site
> for fixing this issue -- there are plenty of people in this thread who ca=
n
> test.
>
> > 3) I'd like to get rid of the PMU json interface. My idea is to
> > convert json events/metrics into sysfs style files, zip these up and
> > then link them into the perf binary. On Intel the json is 70% of the
> > binary (7MB out of 10MB) and we may get this down to 3MB with this
> > approach. The json lookup would need to incorporate the cpuid matching
> > that currently exists. When we look up an event I'd like the approach
> > to be like unionfs with a specified but configurable order. Users
> > could provide directories of their own events/metrics for various
> > PMUs, and then this approach could be used to help with (1).
>
> I can see how that might interact with whatever changes we make to fix th=
is
> issue, but this seems like a future aspiration, and not a prerequisite fo=
r
> fixing the existing functional regression.
>
> > Those proposals are not something to add as a -rc fix, so what I think
> > you're asking for here is a "if ARM" fix somewhere in the event
> > parsing. That's of course possible but it will cause problems if you
> > did say:
> >
> > perf stat -e arm_pmu/LLC-load-misses/ ...
>
> As above, I do not think this is an arm-specific issue, we're just the ca=
nary
> in the coalmine.

Disagree, see comments above. A behavior change here would impact Intel.

> Please note that:
>
>         perf stat -e arm_pmu/LLC-load-misses/ ...
>
> ... would never have worked previously. No arm_pmu instances have a
> "LLC-load-misses" event in their event namespaces, and we don't have any
> userspace file mapping that event.

This event was for the purpose of giving an example, perf list will
show you events that work. The point is that a legacy event may not be
available on both BIG.little PMU types so being able to designate the
PMU there is helpful.

> That said, If I really wanted that legacy event, I'd have asked for it ba=
re,
> e.g.
>
>         perf stat -e LLC-load-misses
>
> ... and we're in agreement that it's sensible to expand this to multiple
> PERF_TYPE_HARDWARE events targeting the individual CPU PMUs.
>
> So I see no need to do anything to have magic for 'arm_pmu/LLC-load-misse=
s/'.
>
> > as I doubt the PMU driver is advertising this legacy event in sysfs
> > and the "if ARM" logic would presumably be trying to disable legacy
> > events in the term list for the ARM PMU.
> >
> > Given all of this, is anything actually broken and needing a fix for 6.=
7?
>
> There is absolutely a bug that needs to be fixed here (and needs to be
> backported to stable so that it gets picked up by distributions).

I'm not seeing this. The behavior is consistent with Intel, this has
gone 2 releases without being spotted, it was triggered by a PMU event
name aliasing a legacy event name and the behavior has always been
legacy event names have higher priority than sysfs and json events.

Whilst I'm seeing a lot of complaining, I've not seen a proposal of
what behavior you want. Isn't it a PMU bug if the legacy event
specifying the PMU doesn't get opened by the core PMU? Fixing the PMU
driver appears to be the right fix and means there is consistency on
core events across architectures.

Thanks,
Ian

> Thanks,
> Mark.
