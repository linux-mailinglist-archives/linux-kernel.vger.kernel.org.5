Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145257BAEB8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjJEWQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJEWQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:16:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC9FD9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:16:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405459d9a96so37255e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696544208; x=1697149008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bay8cunWQ05UAT3X4nRQGJsULFuIk9d15GtcH157QY=;
        b=T364UsNnb7nVogvMpdNXn/bH76TAXh5Y8/IWxIy7NMo+VuS4zz8GAy8WzqbDO0GhUl
         XTlahc36FQeAM1/tOQSZCgPEbe5EOSqNKXoiVzq27f4Vz31oEjJ/kIPTyMlTVKYwT7hD
         FOHT1vxEu3HRlcHQVMyUEKolli1tgD4Yawvdb2qhQ3EbwCuh/F/SmrBT9CS6XujYBLQ5
         p+zpSEGdp0Fs0W4s2/s7AoNGoOu0po4fAzhuOehWCSx7TQsAipl/m4C4EIxUTLBqwKpU
         cdYMj0fMKYCxK9GmJlFEGrGqL3T+kZVVyPpzsC7i+ba4dcIEePgoP2IH7rz4sskmlXgk
         4p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544208; x=1697149008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bay8cunWQ05UAT3X4nRQGJsULFuIk9d15GtcH157QY=;
        b=P2n7hQzwg3s0KZRmXlEAMlGYwhgrVAylTNviwASg+/tDxanSYSP44+UJHFwbCcWiDJ
         sSHmsKKXQpYq9gyqDxse4YsaFZ22oB/aitO/DQceU2b/pcuL8sD08QGjGZt+/v3jb4YB
         YjGVpnJo+XyVGJLSYuOH2Did9mxORLISR393gq5ljmP2XGLZhFsJqawyD49378oM3VHf
         m3/uZox2kUZpBXCSxjN02YYT/wS7y4XWh74jMXAIRBmabyjCFIlDUjLv0tTIMi1VqpbC
         1KdqLwaEymd0xApls9H5JlxdyNVS/rWrSs/t/Yc31gzbYlYshVYosTkuOfTlNt7Utay/
         657A==
X-Gm-Message-State: AOJu0YzqtDYGpAxAfJew7Y/qCy1/UeJtZihiwGkLSxq+N9Z1UZGPGxOg
        NjUVq2L6VBhyfpnP1ijz2h7Wvxb90zqYawpdz8s7jg==
X-Google-Smtp-Source: AGHT+IHWi11t7vguwOrZMBTZWkQmHmfbxGoF4jE9spm56iseKmLMzmy4X7cgsF8O8H115MZbCjeA3dhxC0ryCXXsYKU=
X-Received: by 2002:a05:600c:1884:b0:3f6:f4b:d4a6 with SMTP id
 x4-20020a05600c188400b003f60f4bd4a6mr110415wmp.7.1696544208096; Thu, 05 Oct
 2023 15:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com> <8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com>
In-Reply-To: <8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Oct 2023 15:16:36 -0700
Message-ID: <CAP-5=fWk12jKjVmV+aJ_U5A=ao7L1ha-wOHaM+ytO9oF0nP9zA@mail.gmail.com>
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

On Wed, Sep 27, 2023 at 6:47=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-09-26 4:59 p.m., Ian Rogers wrote:
> > Broadwell-de has a consumer core and server uncore. The uncore_arb PMU
> > isn't present and the broadwellx style cbox PMU should be used
> > instead. Fix the tma_info_system_dram_bw_use metric to use the server
> > metric rather than client.
> >
> > The associated converter script fix is in:
> > https://github.com/intel/perfmon/pull/111
> >
> > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell varian=
t events/metrics")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
>
> Thanks Ian. The whole patch series looks good to me.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Would be good to pick this up in perf-tools-next.

Thanks,
Ian

> Thanks,
> Kan
>
> >  tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.j=
son b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > index 8fc62b8f667d..d0ef46c9bb61 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > @@ -652,7 +652,7 @@
> >      },
> >      {
> >          "BriefDescription": "Average external Memory Bandwidth Use for=
 reads and writes [GB / sec]",
> > -        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb=
@event\\=3D0x84\\,umask\\=3D0x1@) / 1e6 / duration_time / 1e3",
> > +        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) =
/ 1e9 / duration_time",
> >          "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
> >          "MetricName": "tma_info_system_dram_bw_use",
> >          "PublicDescription": "Average external Memory Bandwidth Use fo=
r reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwi=
dth, tma_sq_full"
