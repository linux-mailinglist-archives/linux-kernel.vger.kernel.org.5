Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7CF7D7AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjJZCKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZCKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:10:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8B132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:10:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso903e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698286229; x=1698891029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8xnB021IIgi2DE8OjJspixmNJOGAtkmSylGk0xZH1Y=;
        b=Y6U3d6Ps3/3WtF3BkRaA9kcIEczXHlLm2VUGTzgkil2CvPAfDnhiyji2k05ZtTonro
         UWwxPx0ElItBqwMnthyfWbkvSXZ4cnfDMVY/mGS6XMid7TwSd1E+cMOyOPvx1M/i4i9V
         0B2XRIm9dmip1TKI7KCHvKmCPcBzVGhpAzeei1sG1NiWJvw8MQ4YxXo3CoAG1W7C3Oeb
         3GSGpWDFcYlaXHFtJrR6hlrJ1uitLMf7lVXP/gtxcNVPhzTSTjlA8OxKNzTHi4dLXCJP
         1pdNjpqhMmZSpv8O09oorEmgWKAwfxGVntvSE3jMBrPAwL9Q+Q1tubC8wVdaz6xxmmB0
         C46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698286229; x=1698891029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8xnB021IIgi2DE8OjJspixmNJOGAtkmSylGk0xZH1Y=;
        b=GsccV3Ifoxu0Jd1JEJiNLmZggqqDzCoQ7QZkttv1rqYLFrP0ztJOCZ6+4SoLtzsY/M
         afBKsIC1kLIQDcCVtRVL0N62VvXol9OCVvozZ9SheY5DR0dSlRzL/7F83swlbRb3HEkS
         YXvY7KqShKfV/A1VcjbINoUzsae+OwYuHgLv2BrcFPAhQz4rC5r1fL4zy99PQHhDFCgn
         oe7tfH2fd29xUAY4gRHn4F5rQfbdzgKEk/typ8C4az1srBFVw5OnTK24LVUl9QB//tln
         TU6MfVm82E4xZGrXTEBO6wxiPHkfOYhlKLwesiBGmSNVYWCqF31T9zJESsFAGxtH1Jc0
         AY+g==
X-Gm-Message-State: AOJu0Yzm1J2F9NWlAdQKU9PMoUDMxxz9zy0Pwlnl2S1gXp3eACvs9lxw
        7RWhmvaKW2r/23OrIpH/JyrOVed5ZaS4dcewsVZDQg==
X-Google-Smtp-Source: AGHT+IE2siHFxMx5g9fBRmd9Gklo+520lUH2ckp15sPrJWFiXyskVUQHce+DDkRcRIFwY/aVM/hPy9/dr/KCsPkZDAU=
X-Received: by 2002:a05:6512:36c2:b0:501:ba53:a4f7 with SMTP id
 e2-20020a05651236c200b00501ba53a4f7mr152004lfs.0.1698286228971; Wed, 25 Oct
 2023 19:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231025201626.3000228-1-kan.liang@linux.intel.com> <20231025201626.3000228-7-kan.liang@linux.intel.com>
In-Reply-To: <20231025201626.3000228-7-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Oct 2023 19:10:17 -0700
Message-ID: <CAP-5=fUsE=ZJNmMT0h7z6jkDA45k5wJq58HhbXAuGXo=vKOWYg@mail.gmail.com>
Subject: Re: [PATCH V5 7/8] perf header: Support num and width of branch counters
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        eranian@google.com, alexey.v.bayduraev@linux.intel.com,
        tinghao.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 1:16=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> To support the branch counters feature, the information of the maximum
> number of supported counters and the width of the counters is exposed
> in the sysfs caps folder. The perf tool can use the information to parse
> the logged counters in each branch.
>
> Store the information in the perf_env for later usage.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
> No changes since V4
>
>  tools/perf/util/env.h    |  5 +++++
>  tools/perf/util/header.c | 18 +++++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 4566c51f2fd9..48d7f8759a2a 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -46,6 +46,9 @@ struct hybrid_node {
>  struct pmu_caps {
>         int             nr_caps;
>         unsigned int    max_branches;
> +       unsigned int    br_cntr_nr;
> +       unsigned int    br_cntr_width;
> +
>         char            **caps;
>         char            *pmu_name;
>  };
> @@ -62,6 +65,8 @@ struct perf_env {
>         unsigned long long      total_mem;
>         unsigned int            msr_pmu_type;
>         unsigned int            max_branches;
> +       unsigned int            br_cntr_nr;
> +       unsigned int            br_cntr_width;
>         int                     kernel_is_64_bit;
>
>         int                     nr_cmdline;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index d812e1e371a7..9664062ba835 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3256,7 +3256,9 @@ static int process_compressed(struct feat_fd *ff,
>  }
>
>  static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
> -                             char ***caps, unsigned int *max_branches)
> +                             char ***caps, unsigned int *max_branches,
> +                             unsigned int *br_cntr_nr,
> +                             unsigned int *br_cntr_width)
>  {
>         char *name, *value, *ptr;
>         u32 nr_pmu_caps, i;
> @@ -3291,6 +3293,12 @@ static int __process_pmu_caps(struct feat_fd *ff, =
int *nr_caps,
>                 if (!strcmp(name, "branches"))
>                         *max_branches =3D atoi(value);
>
> +               if (!strcmp(name, "branch_counter_nr"))
> +                       *br_cntr_nr =3D atoi(value);
> +
> +               if (!strcmp(name, "branch_counter_width"))
> +                       *br_cntr_width =3D atoi(value);
> +
>                 free(value);
>                 free(name);
>         }
> @@ -3315,7 +3323,9 @@ static int process_cpu_pmu_caps(struct feat_fd *ff,
>  {
>         int ret =3D __process_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
>                                      &ff->ph->env.cpu_pmu_caps,
> -                                    &ff->ph->env.max_branches);
> +                                    &ff->ph->env.max_branches,
> +                                    &ff->ph->env.br_cntr_nr,
> +                                    &ff->ph->env.br_cntr_width);
>
>         if (!ret && !ff->ph->env.cpu_pmu_caps)
>                 pr_debug("cpu pmu capabilities not available\n");
> @@ -3344,7 +3354,9 @@ static int process_pmu_caps(struct feat_fd *ff, voi=
d *data __maybe_unused)
>         for (i =3D 0; i < nr_pmu; i++) {
>                 ret =3D __process_pmu_caps(ff, &pmu_caps[i].nr_caps,
>                                          &pmu_caps[i].caps,
> -                                        &pmu_caps[i].max_branches);
> +                                        &pmu_caps[i].max_branches,
> +                                        &pmu_caps[i].br_cntr_nr,
> +                                        &pmu_caps[i].br_cntr_width);
>                 if (ret)
>                         goto err;
>
> --
> 2.35.1
>
