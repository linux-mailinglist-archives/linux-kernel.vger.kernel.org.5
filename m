Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAFE75B547
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGTRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGTRMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:12:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434EB1715
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:12:34 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40540a8a3bbso12001cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689873153; x=1690477953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgKroFQPLE09VW7HU3YORU1IlmMjxO1ihJQVJHL39LQ=;
        b=PmpgAEC9wBqpCZYdZxsWDBfnVbgW1YecjRUFlxot9ncNaQCJT9kX69lXdR5KpoXsZL
         Nm4/8R0WUIKhT2lSBo799JzJ/V1RQt18Dmu0oZYm4gUrhPCxa1SNl9+n9/xi4lsUKoI/
         FVzTb/wdwTTikh/OksLuaR1yisCLVHHjNJUKmShZz8ZmEee6CT2Bc+QlARjMgkDqqkTp
         RUSgn9b8/mSnCbwsOeoFhVf490OdtPWU/Nd3UBYKKeLalFAdRonXC3nKG/DYQYtUgcA5
         DSJ+H6nJgkfIGHRW/l+A6ot32nnJB3cAd4mGcgoHJmIf86iwrYBLEReHYzYh1E1u5wOm
         tGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873153; x=1690477953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgKroFQPLE09VW7HU3YORU1IlmMjxO1ihJQVJHL39LQ=;
        b=Lnh8zxg3qyS+Gq2f8qXvWHuTOP/yBB9jE6GlOV22X3jF7wu/T6Z4P6Z56De2wMXvbo
         yLDIq2O8bmQv/uGQN74jlt23lTmYza5b9qQZuKYGH9zYfyh29x4iYVrKgG1yw9FnSX0h
         nT/dR3ShRtVccs0TnCwhNa/gLn6xd5d+kc2TWX0ipqAPWezp6xdxfKJEuymdv9fwwvbV
         aZeb7pQPTcANEtfruMA2u3eR3nl7rCe/y3QICsKBqAKOsQmbaPWpl1UCdg4yqEH9ccuv
         oS+WCCLjjPvXMPnwP1aA+oZWK+XT3xvVoFhzS5gWvQGZcsMCvIguQTeW/QxZs/7OhTMI
         KlHA==
X-Gm-Message-State: ABy/qLaNMmx46Hn5NafMkLip4J6YNFCIu983KF9hixAL/+fRPb26Z4Wh
        +doIuzfzLUMBxmqMkgNoGLlQ0PZihGb/fEblDjqYcTgG7fauQeKujg4/RQ==
X-Google-Smtp-Source: APBJJlEMHAQAkn3EOSoeN59vhib89c/M3lOEfHFqzpjCi8fuoQp1QCtrjNPaI3mqm7wzrdESJWupioX6p/5j0+OVcq0=
X-Received: by 2002:ac8:7f83:0:b0:403:b1d0:2f0a with SMTP id
 z3-20020ac87f83000000b00403b1d02f0amr320764qtj.28.1689873153170; Thu, 20 Jul
 2023 10:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-2-james.clark@arm.com>
 <e111d9ac-c4f6-c541-313b-7a3a6acfb5d2@arm.com> <597f53e0-5a5b-75a1-4054-253630a941f2@arm.com>
In-Reply-To: <597f53e0-5a5b-75a1-4054-253630a941f2@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Jul 2023 10:12:21 -0700
Message-ID: <CAP-5=fVpjJLBNCd4LJ7krX1tpqUT-S_DCRebXR1ioTCGFsF6Pw@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 7:12=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 11/07/2023 13:01, Anshuman Khandual wrote:
> >
> >
> > On 7/10/23 17:51, James Clark wrote:
> >> This capability gives us the ability to open PERF_TYPE_HARDWARE and
> >> PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
> >> implementation is contained in the Perf core and tool code so no chang=
e
> >> to the Arm PMU driver is needed.
> >>
> >> The following basic use case now results in Perf opening the event on
> >> all PMUs rather than picking only one in an unpredictable way:
> >>
> >>   $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2
> >>
> >>    Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':
> >>
> >>          963279620      armv8_cortex_a57/cycles/                (99.19=
%)
> >>          752745657      armv8_cortex_a53/cycles/                (94.80=
%)
> >>
> >> Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW=
_CACHE")
> >> Suggested-by: Ian Rogers <irogers@google.com>
> >> Signed-off-by: James Clark <james.clark@arm.com>

Hi ARM Linux and ARM Linux PMU people,

Could this patch be picked up for Linux 6.5? I don't see it in the
tree and it seems a shame to have to wait for it. The other patches do
cleanup and so waiting for 6.6 seems okay.

Thanks,
Ian

> >> ---
> >>  drivers/perf/arm_pmu.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> >> index 277e29fbd504..d8844a9461a2 100644
> >> --- a/drivers/perf/arm_pmu.c
> >> +++ b/drivers/perf/arm_pmu.c
> >> @@ -875,8 +875,13 @@ struct arm_pmu *armpmu_alloc(void)
> >>               * configuration (e.g. big.LITTLE). This is not an uncore=
 PMU,
> >>               * and we have taken ctx sharing into account (e.g. with =
our
> >>               * pmu::filter callback and pmu::event_init group validat=
ion).
> >> +             *
> >> +             * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open the =
legacy
> >
> > s/legacy/generic ? These hardware events are still around.
>
> True, I thought I saw it mentioned that way somewhere, but I can
> probably just remove it altogether. PERF_TYPE_HARDWARE and
> PERF_TYPE_HW_CACHE is enough.
>
>
> >
> >> +             * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
> >> +             * specific PMU.
> >>               */
> >> -            .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS,
> >> +            .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS |
> >> +                              PERF_PMU_CAP_EXTENDED_HW_TYPE,
> >>      };
> >>
> >>      pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =3D
