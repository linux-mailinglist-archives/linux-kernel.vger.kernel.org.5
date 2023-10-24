Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBE7D57B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbjJXQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjJXQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:13:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E979D171A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:12:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so13244a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698163966; x=1698768766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTa//f3CF6frOiaIViZbYmNtaYUVdbJcfKPBPGR/E6o=;
        b=wU/pUNZowpJoYV2JJL1DpeVBnaPBuv7UvxbPvk6BRo1qz1Rr9H3Ljsv6+TMuOO5PvM
         NiTi/gR0FqwDu3qlGz7Cyd6FGYz6KP4Qo9gHWih6owfGIybZEoFH388F5ZwJM/x09k2d
         hOIZduSb8YG6G7YyKI92mvt/79Fxa9ZoO3P9wLQTHSHHGq2poroP9aoS6nR8yY4fQY3H
         ySs9Z4NybZtLe/oGcBWT78bl9131vNrLpMZHK2dtmJXDBe7OOXod0AgUYL/54F8JPw4Y
         ViUmH12pf6IYO0ooQYc3UrMZYO2KH3rVgPF6IdL5oJTjPTMZxvROphFbqcyUHpF+HXH0
         AKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163966; x=1698768766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTa//f3CF6frOiaIViZbYmNtaYUVdbJcfKPBPGR/E6o=;
        b=lcjx8+3U7Auq/8zJkhYx2kQJRZ4x95G0Dx/Gqj4WmQoRRJu+a88Ne8JEl/kH8jnkbj
         DRbGlJ6ov6EnbCyh0ko9Dz6OAnDqzAiqbc7khv5RHcDX6vGkuoZKyQWR1Z+IAr5XHX1C
         7hq9AUEH7DUX4dnZr+1zwTcWRoPjRp2baaQnx9lZ/iw//1niC2ta9as9wgxQbpO27nRB
         rjlPeaUL8WglFlDIhK6r5xQ+79NmK1FTdR6GYbofLekDYMass/EnkAKxlMLudYvHQBbG
         qPsPH801JRmQ3iULt4efiJiYv89nYCjsBI8r8ozk/aNNF71WADYfBcLg4KN/D+QCnqaX
         eoWQ==
X-Gm-Message-State: AOJu0YwQbcXOVAJvyAY9/fqwVaU4igWLn+A/mwYntCgWqfPiRFkKUqa9
        16MtWCYtB1uGQg2c2MLvjfq1Wk569vt1eT5BE2TMXg==
X-Google-Smtp-Source: AGHT+IH4lKfrFeJgOMb4mTFEvhZTUWm5ejImQaZrlWnRs+8cmQM7UkjZN12WgMceOxLfpDMFiPWgyIDdE3glHiBrSC8=
X-Received: by 2002:a05:6402:32c:b0:540:9f24:6006 with SMTP id
 q12-20020a056402032c00b005409f246006mr117406edw.6.1698163965905; Tue, 24 Oct
 2023 09:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-4-irogers@google.com>
 <CAM9d7cg=v9rnPz4cy2yeNZNSCoZ3VReC895gHPTO-emn6XdLXg@mail.gmail.com>
In-Reply-To: <CAM9d7cg=v9rnPz4cy2yeNZNSCoZ3VReC895gHPTO-emn6XdLXg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Oct 2023 09:12:33 -0700
Message-ID: <CAP-5=fWBRyw=DZ-neHBMuC=nAjo-MrcUPFo6H-XzwrTPEvZ+yg@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] perf hist: Add missing puts to hist__account_cycles
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 4:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Wed, Oct 11, 2023 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Caught using reference count checking on perf top with
> > "--call-graph=3Dlbr". After this no memory leaks were detected.
> >
> > Fixes: 57849998e2cd ("perf report: Add processing for cycle histograms"=
)
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/hist.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 3dc8a4968beb..ac8c0ef48a7f 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -2676,8 +2676,6 @@ void hist__account_cycles(struct branch_stack *bs=
, struct addr_location *al,
> >
> >         /* If we have branch cycles always annotate them. */
> >         if (bs && bs->nr && entries[0].flags.cycles) {
> > -               int i;
> > -
>
> Seems not necessary.
>
> >                 bi =3D sample__resolve_bstack(sample, al);
>
> It looks like this increases the refcount for each bi entry and
> it didn't put the refcounts.

Right, this is why the loop doing the puts is added.

>
> >                 if (bi) {
> >                         struct addr_map_symbol *prev =3D NULL;
> > @@ -2692,7 +2690,7 @@ void hist__account_cycles(struct branch_stack *bs=
, struct addr_location *al,
> >                          * Note that perf stores branches reversed from
> >                          * program order!
> >                          */
> > -                       for (i =3D bs->nr - 1; i >=3D 0; i--) {
> > +                       for (int i =3D bs->nr - 1; i >=3D 0; i--) {
> >                                 addr_map_symbol__account_cycles(&bi[i].=
from,
> >                                         nonany_branch_mode ? NULL : pre=
v,
> >                                         bi[i].flags.cycles);
> > @@ -2701,6 +2699,12 @@ void hist__account_cycles(struct branch_stack *b=
s, struct addr_location *al,
> >                                 if (total_cycles)
> >                                         *total_cycles +=3D bi[i].flags.=
cycles;
> >                         }
> > +                       for (unsigned int i =3D 0; i < bs->nr; i++) {
>
> Can we just reuse the int i above?

I wanted to move to unsigned for consistency with the rest of the
branch_stack code, nr is a u64, but when iterating down the sign
matters - so this fixes up where possible.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                               map__put(bi[i].to.ms.map);
> > +                               maps__put(bi[i].to.ms.maps);
> > +                               map__put(bi[i].from.ms.map);
> > +                               maps__put(bi[i].from.ms.maps);
> > +                       }
> >                         free(bi);
> >                 }
> >         }
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
