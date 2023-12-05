Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1DA805DAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbjLESRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjLESRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:17:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC690
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:17:17 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b83c4c5aefso3360110b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701800237; x=1702405037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDi8w67oLrCVnWUnDYFdDwzLTH62p8zVTFKrJGR7vTA=;
        b=T5zedPartWcsSubHoFT0v9EkdqfSoBTx4JJjvCaW6LJyr1VJGToiDW5yiki1CiuIqk
         rp+3A3RN+mULd1/avj0jZ/h9a31Ekl2Jnd1SRladgxSe6eMJHqc757INfvoj4WcYK47H
         fIcoSBSrNlTpVInIYRwpQ+NJQwTXyHltRdJ60EScLgGPYQ+gL8DKAYZUl9qanLJ1gR86
         eHywPwoOCGh3ncpyH7/SBS7xSkVSqRjfrWQoyxnKGq8OJhZr6K/W4uWysims260yfa+h
         tocvC57EMWZoIYxaPqGXq5eQQkKU3HvaDcZ9+S6BLjiwBHj1NzFHXAmKOILZ4jwz9kmk
         CvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800237; x=1702405037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDi8w67oLrCVnWUnDYFdDwzLTH62p8zVTFKrJGR7vTA=;
        b=hjo3++6KvwPgBK0c1FZ8nT+hE455ZWmWGQ0vSHkjsN7400UUCdTmA01IQ+o+wtVtDk
         z0erb5SvNP+Y3+uC3hebFpdg7f98C2m4CjKFkmPz04rWWvTGwLWYzCmQ2PyUAtrSx2TV
         gp4Psk7j3HrHgxfHENr6njIJLtOeMJ1h8udQgq3O8VPYIT/C4u0Z/pKZcsUm/2qzRu53
         enjU/F1trxpjKiLl8R23+zlHn2kUopo3dd71oXETZmFxWE1VjpBgO4plnVja97Ok2UKt
         S85qMMqg4pDSesZgRMUqzmZFspUKVoQ9hz3peUwZPilYl3L//rpfpcrrB6npb44csJoq
         3Vsw==
X-Gm-Message-State: AOJu0YzUO/GQ0JLV06t2xjwyOB1V0/frMKsJmrO39R/jwDIt0LhmpF4t
        FwZKkGOQs1FJo0ot4llUhggb9m99OCWCVB6HWHQ3Bw==
X-Google-Smtp-Source: AGHT+IFVPtycg0dL10C+0thiptzxicQhELMBG95r/Ap4aYVMCRYNBG6hTGKCzlb6QEEknzdZvnI7OFwLD7ptlaTRwLc=
X-Received: by 2002:a05:6870:9d9b:b0:1fa:1355:da45 with SMTP id
 pv27-20020a0568709d9b00b001fa1355da45mr7508586oab.11.1701800236823; Tue, 05
 Dec 2023 10:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-2-khuey@kylehuey.com>
 <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com>
 <ZW8Gi2QI5ceAJfab@krava> <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
In-Reply-To: <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 Dec 2023 19:16:38 +0100
Message-ID: <CANpmjNPfoLX=HPy0MhbGqMmGT4jE0Ky29cx5QP_8tJ2u=1ju_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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

On Tue, 5 Dec 2023 at 19:07, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> Add Marco Elver to CC.
>
> On Tue, Dec 5, 2023 at 3:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Mon, Dec 04, 2023 at 02:18:49PM -0800, Andrii Nakryiko wrote:
> > > On Mon, Dec 4, 2023 at 12:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> w=
rote:
> > > >
> > > > Returning zero from a bpf program attached to a perf event already
> > > > suppresses any data output. This allows it to suppress I/O availabi=
lity
> > > > signals too.
> > >
> > > make sense, just one question below
> > >
> > > >
> > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > > > ---
> > > >  kernel/events/core.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index b704d83a28b2..34d7b19d45eb 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct pe=
rf_event *event,
> > > >         rcu_read_unlock();
> > > >  out:
> > > >         __this_cpu_dec(bpf_prog_active);
> > > > -       if (!ret)
> > > > +       if (!ret) {
> > > > +               event->pending_kill =3D 0;
> > > >                 return;
> > > > +       }
> > >
> > > What's the distinction between event->pending_kill and
> > > event->pending_wakeup? Should we do something about pending_wakeup?
> > > Asking out of complete ignorance of all these perf specifics.
> > >
> >
> > I think zeroing pending_kill is enough.. when it's set the perf code
> > sets pending_wakeup to call perf_event_wakeup in irq code that wakes
> > up event's ring buffer readers and sends sigio if pending_kill is set
>
> Right, IIUC pending_wakeup is set by the ring buffer code when
> a task is waiting for events and it gets enough events (watermark).
> So I think it's good for ring buffer to manage the pending_wakeup.
>
> And pending_kill is set when a task wants a signal delivery even
> without getting enough events.  Clearing pending_kill looks ok
> to suppress normal signals but I'm not sure if it's ok for SIGTRAP.
>
> If we want to handle returning 0 from bpf as if the event didn't
> happen, I think SIGTRAP and event_limit logic should be done
> after the overflow handler depending on pending_kill or something.

I'm not sure which kernel version this is for, but in recent kernels,
the SIGTRAP logic was changed to no longer "abuse" event_limit, and
uses its own "pending_sigtrap" + "pending_work" (on reschedule
transitions).

Thanks,
-- Marco
