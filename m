Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6674B7D7738
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjJYV4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjJYV4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:56:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808BD9D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:56:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso1201e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698270997; x=1698875797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6Wm2hf7VPlcOAa3DFo3dVIOp8FjeRPkG/lab590sqk=;
        b=Z33ra6RdU1y/uiTnpvjheeEvB4rV0s0ziD//NCsYjxNoX/+EOTaGFV2SvewrZn01p/
         L8EyCSsz7pUiHHuvx8Fipr5ALqhZzFS6uMeLGxtUnf/5tABwHhsScWDPK0q4z0fPQ7lL
         Vj6bHxtyZCU1FVRRGucfP2ripjvZMIa8ClbGHuYeDppatjHs3RzgbkiQnRQLSHCxLTqw
         NRnQUzPKuCOwEQ386zwI7bjNtg57Nm3TiVLcHuunhSu13Y8f3g46r2VZyIumMqc1dEax
         42KqrmjgFvz0Ew0wO+ZXGoBcf/b2nQYkyw//tWegSxMZQB73Ulq3y3CzzOGue62AjwK1
         6JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698270997; x=1698875797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6Wm2hf7VPlcOAa3DFo3dVIOp8FjeRPkG/lab590sqk=;
        b=r6+SjYrhYK46SyyDukJU8yz/ru6+QWIvzUW+Q/hy+YeaTi1wpQ5jme+iYqx+rOaEKm
         SemCmFBbN5jBx5Eadmqm2SyaY+trbrPunWz0XZ4N344iBjyNoWVXelVrzQvx3dyFSyZt
         lLRjUFbuhjfv99j5UwwqLNEEZyGlsYPM0CYkzJz7taGmTiSJQkPeFcRb09cUT06AEiuj
         +oPcXWfU3p8whoPO3d7O88JdtQn/AVpr3fMQEiJCx7ak30vaDjZORCCEr6DxtfJG6dGZ
         UNH0Ovh5strp7uSIQ2sU6AuaWjeVEtNxmW/pKN8//TVSOLJ30T3JAXoofSCaq1XzDFgI
         HRfA==
X-Gm-Message-State: AOJu0YyFvXNCiSyxNyHQXX6OAmeXaA6gin+JF243poSCiCUU6v3RsA9x
        tYzA4NeECXvwp2gJPv39bHdxIj6i+sr/5n458fGInw==
X-Google-Smtp-Source: AGHT+IExoPoplQRtg8C3JaBDX8w1qcS2KCbhHdRcfnxtxvjRtEZc4ZpdWhkCkVIRh9sRJXZUoLFHcKzxcpAsiutj91k=
X-Received: by 2002:ac2:58ef:0:b0:501:a2b9:6046 with SMTP id
 v15-20020ac258ef000000b00501a2b96046mr107431lfo.7.1698270996475; Wed, 25 Oct
 2023 14:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com> <8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com>
 <CAP-5=fWk12jKjVmV+aJ_U5A=ao7L1ha-wOHaM+ytO9oF0nP9zA@mail.gmail.com>
In-Reply-To: <CAP-5=fWk12jKjVmV+aJ_U5A=ao7L1ha-wOHaM+ytO9oF0nP9zA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Oct 2023 14:56:24 -0700
Message-ID: <CAP-5=fURbve928P5CGi-dQ7Y8mZhxRmi9wucFc_gP+aDGMftYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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

On Thu, Oct 5, 2023 at 3:16=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Sep 27, 2023 at 6:47=E2=80=AFAM Liang, Kan <kan.liang@linux.intel=
.com> wrote:
> >
> >
> >
> > On 2023-09-26 4:59 p.m., Ian Rogers wrote:
> > > Broadwell-de has a consumer core and server uncore. The uncore_arb PM=
U
> > > isn't present and the broadwellx style cbox PMU should be used
> > > instead. Fix the tma_info_system_dram_bw_use metric to use the server
> > > metric rather than client.
> > >
> > > The associated converter script fix is in:
> > > https://github.com/intel/perfmon/pull/111
> > >
> > > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell vari=
ant events/metrics")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> >
> > Thanks Ian. The whole patch series looks good to me.
> >
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Would be good to pick this up in perf-tools-next.
>
> Thanks,
> Ian

Ping.

Thanks,
Ian

> > Thanks,
> > Kan
> >
> > >  tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics=
.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > index 8fc62b8f667d..d0ef46c9bb61 100644
> > > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > > @@ -652,7 +652,7 @@
> > >      },
> > >      {
> > >          "BriefDescription": "Average external Memory Bandwidth Use f=
or reads and writes [GB / sec]",
> > > -        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + a=
rb@event\\=3D0x84\\,umask\\=3D0x1@) / 1e6 / duration_time / 1e3",
> > > +        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR=
) / 1e9 / duration_time",
> > >          "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
> > >          "MetricName": "tma_info_system_dram_bw_use",
> > >          "PublicDescription": "Average external Memory Bandwidth Use =
for reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_band=
width, tma_sq_full"
