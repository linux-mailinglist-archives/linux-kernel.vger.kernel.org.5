Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C3C7F3314
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjKUQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjKUQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:03:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FF4194
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:03:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13221a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700582603; x=1701187403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNQwcfbwd5MPP15HDWRuvMnBXafc9Od52XUUUFOJgh0=;
        b=PjSozKHpXoVTqGzzk/JTTw97W+ysi05ErCJl3Axic9yYFIt+tszfUbF9X6zh47pf86
         8p3pD3uLYDg/e3gUbDFYO4Fvz5fnfmoZ9s2gGowHQ6xcQssUGr3hZhlxaXT4b1xKuKT1
         aSU9PE7WVZ1sHsT9A+NXEKNHKAsSwbet2nkJUITxQsAImRrfZk/s0jKb74R3TV7mQmcH
         28pRXrk3G3uWt/kGrEDBFvJJnOhd9mUKWsDsRkFkVrFstIUKg0bR+riAbkX2qgnCMsfD
         DUI6rTd560AtJh4RiUSQDnHtIjE2PeSCpNH8yQgHIg8nKGCvEzUTXQzaMzgBr9g/HRt2
         l82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582603; x=1701187403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNQwcfbwd5MPP15HDWRuvMnBXafc9Od52XUUUFOJgh0=;
        b=E1gvNLglVVk0XmwTUaFdTzJonI7JPzvpiAuoyN/BF49G90crWBC13qzOeAV1n0Hrkw
         UCaIbLz6jm9iTefzDQ9Wo7duf/XNnUplLBy9jGxkrCmZgNK6DHjCZVd9P4NoplMFz+kU
         xUFV257f1iy5Z5+tjFusJW6Kb4vbdguJ7a09OrgLAKhC57dkCJru6hqZPhZKRc1Ui8tY
         XIp7mw10aQAAA/Dbaaja15LePIin+CnciHoWoUNCZ1ibdD+Q4ksLxd/qNfVRy3rIADTv
         ptUyW0g5apn/Iuyl+Susoqg22jq0LsabyugbbQ262RAvCe/OYymynP3ubbEK6gJADIiR
         UQMg==
X-Gm-Message-State: AOJu0YxBNg7It183wzaQKx2VYioAOwgfahriZcaImFNXleLNmj+wKM9a
        GadWIQzpySuEiOdT0HaX5agjbAlHVIndlJNywBDHhA==
X-Google-Smtp-Source: AGHT+IGRxcb1DcqNDtN3drDnBT//l5I9g8+kkBz4bUEvVZoz6tz2s2ESfEufGO7M78btFDFcrq3yWt45+h1rGRbPb/k=
X-Received: by 2002:a05:6402:ea1:b0:544:f741:62f4 with SMTP id
 h33-20020a0564020ea100b00544f74162f4mr466676eda.0.1700582603209; Tue, 21 Nov
 2023 08:03:23 -0800 (PST)
MIME-Version: 1.0
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org> <86o7fnyvrq.wl-maz@kernel.org>
 <CAP-5=fWeyorotfVz_y16ibakSwbNa0fapZoxSZ1nbkt1s=uGbw@mail.gmail.com> <ZVzTJhMsgjPw2OE4@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZVzTJhMsgjPw2OE4@FVFF77S0Q05N.cambridge.arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 21 Nov 2023 08:03:11 -0800
Message-ID: <CAP-5=fWb+Nbs24+XzqVp_5U+ehwiuojedHfDu8AxP3kFd7B4KA@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 7:56=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Nov 21, 2023 at 07:41:17AM -0800, Ian Rogers wrote:
> > Hi Marc,
>
> Hi Ian,
>
> > I'm unclear if you are running a newer perf tool on an older kernel or
> > not. In any case I'll assume the kernel and perf tool versions match.
> > In Linux 6.6 this patch was added to the ARM PMU:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/perf/arm_pmu.c?id=3D5c816728651ae425954542fed64d21d40cb75a9f
> >
> > My guess is that the apple_icestorm_pmu requires a similar patch.
>
> The apple_icestorm_pmu PMU driver uses the arm_pmu framework, so it's usi=
ng
> that code (since v6.6).
>
> > The perf tool is supposed to not use extended types when they aren't
> > supported:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmus.c?h=3Dperf-tools-next#n532
>
> How does that is_event_supported() check actually work? I suspect that's =
giving
> the wrong answer.

Maybe, the implementation is to check using perf_event_open:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/print-events.c?h=3Dperf-tools-next#n232

This is recycling logic from perf list where many legacy cache events
are elided due to a lack of support.

> Regardless, I think the tool is doing something semantically wrong, see b=
elow.
>
> > So I share your confusion as to why something broke.
> >
> > PERF_TYPE_HARDWARE is a legacy type where there are hardcoded type and
> > config values that correspond to an event. The PMU driver turns legacy
> > events into the real types. On BIG.little systems if the legacy events
> > are monitoring a task a different event is needed for each PMU (ie >1
> > event). In your example you are monitoring 'ls', a task, and so
> > different cycles events are necessary. In the high 32-bits (the
> > extended type) the PMU is identified.
>
> I think the interesting thing here is that the tool is mapping events wit=
h an
> explicit PMU into legacy PERF_TYPE_HARDWARE events, which is the opposite
> direction than intended. Regardless of whether PERF_TYPE_HARDWARE events =
can be
> targetted to a specific PMU, if the user has requested to use a specific =
PMU we
> should be using that PMU and related event namespace.
>
> Marc's command line was:
>
>         sudo taskset -c 0 ./perf stat -vvv \
>                 -e apple_icestorm_pmu/cycles/ \
>                 -e apple_firestorm_pmu/cycles/ \
>                 -e cycles \

-e cycles here is a direct request for the legacy cycles event. It
will match in the parser here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n301

which goes to:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.y?h=3Dperf-tools-next#n397

and as this is a hardware event there is wildcard expansion on each core PM=
U.

Thanks,
Ian

>         ls
>
> ... and so the apple_*_pmu events should target their respective PMUs, an=
d the
> plain 'cycles' event could legitimately be opened as a single
> PERF_TYPE_HARDWARE event, or split into two directed PERF_TYPE_HARDWARE e=
vents
> targetting the two PMUs.
>
> However, thwe tool opens three (undirected?) PERF_TYPE_HARDWARE events:
>
> Opening: apple_icestorm_pmu/cycles/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =3D 3
> Opening: apple_firestorm_pmu/cycles/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 =3D 4
> Opening: cycles
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
>
> Mark.
