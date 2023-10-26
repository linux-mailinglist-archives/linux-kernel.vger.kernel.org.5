Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099947D7B71
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 06:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjJZEUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 00:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZEUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 00:20:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D8182
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:20:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a085efa7so1861e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698294011; x=1698898811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75q8gySjt19wzXTrkLK8R2Urnb9hTgP0iyJ1UPsf7lo=;
        b=KN+PvH5xswnK3vD2FZFjXhrx7YZbEj74ejf97Lmz7KbgtOJliA8qgZvd3bjt4n4EOs
         oLvM97cZbjeT7JCeU1BiLXv8LGTUlKpBRZw+9+I38eAjpalXGGEhXnbiVsF74PA4wMRU
         smBUBgzSNP2lgK8UJdE1bEpvY+BbITJ7/VpYt1521hy5prNU722m81g35/hZ9paxQYKy
         u0FkhFT9TangOPfBWjxguhVlOSBFXueby0spvTREhZq+75hoi9gpkHF73eiuNbYev1Vh
         tmHkYTag22t9vxwAcrNzqJgw3lbWgQ08PQnItQpKf56GGxMfgrpKt58+bC/FhisVrDBH
         K01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698294011; x=1698898811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75q8gySjt19wzXTrkLK8R2Urnb9hTgP0iyJ1UPsf7lo=;
        b=CuafO4ITidy0bY4PLFtDLbVPQ6sKgRFVBPmonUM1uSHvxG7W+E8mWVsKgyuobaTEm3
         Z73tpdW6WWwSpBwFOkkjsRjx89UMf6kuyFI+zrfPFUSRc8asdjMRvqCJIWa80m0nBNHr
         GeSu9fmlhO20nEJufwP6VOJ2U2RO6nmZn5c6Z7VTF3m09isAdsvp18zB9UzeX3U6vWjh
         mNvFCannfnPYOzP24L0z8JwDe+Olli4sX/Os4lBywrcs64eTbtofOce/HEoKSvJDzmTc
         uJEAsgIiHhYHnvI6CsgVIIBm7XuCSCI3BmWae5plh/fXRhG4fDCHcz4tYP2oCEh5Fulg
         1qzw==
X-Gm-Message-State: AOJu0YxeLBfP7yNi8UvPbh+yAqml8CZFEpF/KWxkpV5lT0DaTFJMgGMD
        mrAFjpMLHJResJL1nFWmpKZGXXJezWEf7tzuHoANKQ==
X-Google-Smtp-Source: AGHT+IGgoikw81XSACvxOqAeHp09PG2LRCqkhPQl/Hk2uGjvKXzxSN+ovf3ie5WAlPrU8XnhCR/szEzNlNdypm2gcc4=
X-Received: by 2002:a05:6512:2101:b0:507:9a33:37a3 with SMTP id
 q1-20020a056512210100b005079a3337a3mr123916lfr.7.1698294011132; Wed, 25 Oct
 2023 21:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com> <8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com>
 <CAP-5=fWk12jKjVmV+aJ_U5A=ao7L1ha-wOHaM+ytO9oF0nP9zA@mail.gmail.com> <CAP-5=fURbve928P5CGi-dQ7Y8mZhxRmi9wucFc_gP+aDGMftYw@mail.gmail.com>
In-Reply-To: <CAP-5=fURbve928P5CGi-dQ7Y8mZhxRmi9wucFc_gP+aDGMftYw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Oct 2023 21:19:58 -0700
Message-ID: <CAP-5=fU5W=97NFvL1yUKw+rrbBrcd8c-S_y3=86SYv+pszNjmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 2:56=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Oct 5, 2023 at 3:16=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Wed, Sep 27, 2023 at 6:47=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> > >
> > >
> > >
> > > On 2023-09-26 4:59 p.m., Ian Rogers wrote:
> > > > Broadwell-de has a consumer core and server uncore. The uncore_arb =
PMU
> > > > isn't present and the broadwellx style cbox PMU should be used
> > > > instead. Fix the tma_info_system_dram_bw_use metric to use the serv=
er
> > > > metric rather than client.
> > > >
> > > > The associated converter script fix is in:
> > > > https://github.com/intel/perfmon/pull/111
> > > >
> > > > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell va=
riant events/metrics")
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > >
> > > Thanks Ian. The whole patch series looks good to me.
> > >
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >
> > Would be good to pick this up in perf-tools-next.
> >
> > Thanks,
> > Ian
>
> Ping.

Thanks Namhyung for picking this up. There were two other patches in
the v2 patch set that Kan reviewed:
https://lore.kernel.org/all/8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.inte=
l.com/
that I don't see in perf-tools-next.

Ian

> Thanks,
> Ian
>
> > > Thanks,
> > > Kan
> > >
> > > >  tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 =
+-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metri=
cs.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > > index 8fc62b8f667d..d0ef46c9bb61 100644
> > > > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > > @@ -652,7 +652,7 @@
> > > >      },
> > > >      {
> > > >          "BriefDescription": "Average external Memory Bandwidth Use=
 for reads and writes [GB / sec]",
> > > > -        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ +=
 arb@event\\=3D0x84\\,umask\\=3D0x1@) / 1e6 / duration_time / 1e3",
> > > > +        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.=
WR) / 1e9 / duration_time",
> > > >          "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
> > > >          "MetricName": "tma_info_system_dram_bw_use",
> > > >          "PublicDescription": "Average external Memory Bandwidth Us=
e for reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_ba=
ndwidth, tma_sq_full"
