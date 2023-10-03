Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7272C7B7423
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJCWgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjJCWgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:36:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ABDAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:36:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50348c54439so1037e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696372591; x=1696977391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG7kDtdkJVrJR5n87G+tHxj9vqVqM2ibNV7n3CHBcaM=;
        b=1Lx9A2j4pHQYDICxtXgVq5dUcE3TV44XTOQLdSgauFrBc8ngQOnAAXneU0i61/akv4
         qjaThIbGJZxT/PHcclWs3toMOAW5yi1DPXNAgK4uDnCgLKQ+jKMwOu1yfIKShOTAodtM
         GbHhRjtimkt/CBlcST9V9pj9bOetTNHiFN00RIKbLyyQpRBVUDLGHCP4VM9C2M1rc6Wv
         kbFP2BQFn+oiQG+WwVfoOfBxPccw1dfpG726AujbZmWpVRyAStaXfbN50akZSsN9MoQa
         LkuS1CQ3v2aq0KRPtva0psATj2wbuCuIYk1nvVpu+rynygSIr3T9aq3SlYCSAK6Fz5Sv
         XeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696372591; x=1696977391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG7kDtdkJVrJR5n87G+tHxj9vqVqM2ibNV7n3CHBcaM=;
        b=jDyLlUycriHYXDXb9lz2Or1OWxaRaKeWRjOfHP+fD1X1ugCr7dNOSs1NdtL2rtdKjE
         eFGFoHBs1EfcMyOa7Bvm+yDvBJJ81xphh8WxcfZx/r+NqMptlJRFH2f3q2mIcIjsfmb6
         m8YjrP4+lhgeOgxQ94zlDqHuL4lOd1Os86L9czikz1g62LiPP01lrxadKVnHqvLiZv6B
         VVfdOleMbe4mIh/wIN2n+hCz9UdvACJ0E+XhTSORklSI3uhZ/gRtQcn05WGmdxgXoOSe
         vNqsey1edPif0LhTgK3evlBM99oo2q4HqeltBUlXBpMwu+gwdFSIatLAVB+i0CJoPbS0
         vczw==
X-Gm-Message-State: AOJu0Yz1BsL+JmwwGFVqxhInW5Q8LDNRlQTYGskhx7Ep5p1KEL9GE5QG
        2WXtswoOi9N5BshVZLrLr6/xLRCxiD8NodYQkf9vAw==
X-Google-Smtp-Source: AGHT+IFxJAgpmYBIrObePPnqrkL5nsL/Q9T1EPNqbCSH2+9ataU9BP/aaTfJKcSQjylmnubwEGV3gueH2rN/mrZWSog=
X-Received: by 2002:ac2:4e6f:0:b0:505:715f:d36b with SMTP id
 y15-20020ac24e6f000000b00505715fd36bmr7786lfs.5.1696372590536; Tue, 03 Oct
 2023 15:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
 <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
 <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com> <CAM9d7cgKWi0fafwTxSrKLrVZxcwnhwMGz=oNkAsNdOjDwF6pEA@mail.gmail.com>
In-Reply-To: <CAM9d7cgKWi0fafwTxSrKLrVZxcwnhwMGz=oNkAsNdOjDwF6pEA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 Oct 2023 15:36:19 -0700
Message-ID: <CAP-5=fWXXi7Y=6Q0k8oLOZmYon+vvg-k4dNUSex_ijcL8ti9sQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
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

On Tue, Oct 3, 2023 at 1:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Wed, Sep 20, 2023 at 10:05=E2=80=AFPM Mingwei Zhang <mizhang@google.co=
m> wrote:
> >
> > On Mon, Sep 18, 2023 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Sat, Sep 16, 2023 at 5:46=E2=80=AFPM Mingwei Zhang <mizhang@google=
.com> wrote:
> > > > Thank you very much for the change. I have one quick question about
> > > > the PMU unthrottling logic. When I am looking into the function
> > > > perf_adjust_freq_unthr_context(), I see the loop with PMU stop and
> > > > start in each iteration. Is there a good way to avoid this PMU rese=
t
> > > > operation while quickly figuring out the event in frequency mode?
> > >
> > > Agreed. I think before the pmu_disable could be avoided for this cond=
ition:
> > > ```
> > > if (event->hw.interrupts !=3D MAX_INTERRUPTS &&
> > >     (!event->attr.freq || !event->attr.sample_freq))
> > >         continue;
> > > ```
> > > Fixing up the event stop/start looks harder.
> > >
> >
> > Right, I think putting the check early before pmu_disable() is already
> > a great optimization. The only concern I initially had was whether
> > event->hw.interrupts can be accessed before we disable the pmu. But
> > after checking this field in other locations, I don't see any problem
> > at all.
>
> The event->hw.interrupts would be increased in the NMI handler
> so there is a race between the check and the NMI.  That's why
> I think it checks that after disabling the PMU.
>
> But I think we can skip non-sampling events for sure.  Then it
> would be better to set attr.sample_period =3D 0 rather than attr.freq.
>
>     if (!is_sampling_event(event))
>         continue;
>
>     perf_pmu_disable(event->pmu);
>     ...
>
> Thanks,
> Namhyung

With the PMU disabled, isn't there still a risk of an interrupt still
being in flight? In other words the disable doesn't prevent a race and
we'll catch this on the next timer call to
perf_adjust_freq_unthr_context. I think we can also improve the code
by just disabling a PMU once, we can take advantage of the
perf_event_pmu_context and disable that PMU, iterate its events and
then re-enable the PMU - i.e. no need for an enable and disable per
event. I'll put a patch together.

Thanks,
Ian
