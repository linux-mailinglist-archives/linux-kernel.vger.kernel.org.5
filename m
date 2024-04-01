Return-Path: <linux-kernel+bounces-127067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7049A894662
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F0528251E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55854780;
	Mon,  1 Apr 2024 21:04:17 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC354F89;
	Mon,  1 Apr 2024 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005456; cv=none; b=u0+1IltY1oK9OuxpyFR/giPTGS9B2cADsYZfFAfLjbyMEAMHM4daC6RzGVzjsNCDproibnKPBX/l2pGB8ch7dsji+F9CM9IgB00QDkbTfrbDSwNtaLUY8kOYKW7Pqm36+hz7fTuOS1nnmX/2JxAsbAesbTENziUiqYAKFs6XnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005456; c=relaxed/simple;
	bh=mKaiBDbPIY/oxidc8kV78phTL4KQk4kcZp81aSB7MXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guhaVBoC9PPS+o3nu1gNaL23nb0XyfCTLfKcJ2oRTGjKXFyqK9PqzpmguDUk96CFkjMmELEo4BQGm7QVIATNqEkgMBQcXXSimrxecWoAIRIoJyiteca62HkRVWoh1GfQBYG5O0UfVVRCXeeOlGn54yM1nzqm5sbywPQpdy/1i38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so3074448a12.1;
        Mon, 01 Apr 2024 14:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712005454; x=1712610254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20AbiFgjVqsRiV1DdyI6/VA4cQHK72VqTY/MDCU1L8w=;
        b=bvIM6BCKU4K7od+6VIS9sSJntBEDDI80hUqSXEyXTj/ei8s6rwDagXAFu1WVqy/mLc
         bu4Ufwb9yHAbAM3R9AI69/F3kqmtl9/OZL5iRLs+trhmZrXoP/jEdWZw7rsjjdQuU1v2
         bRnWg51ldASw9GLiBJ5ZwGkIWpLj10cVWIw6lHqbDqd/ULvfYwb3ynP4jXQdCt1clerk
         du3SF8jTQgIS4Qu6Lsc2LIlogVdKx1ejIGvp0ye5Ylt8L/4nAAOdfjioDjMEOvEL6Ydi
         +wiWoT/cRmlBwmDh5nqdQvvgIERoibFDsq10jfVgNNmPyZlWyMWw06VR9QDBCgRFrwU6
         WXoA==
X-Forwarded-Encrypted: i=1; AJvYcCXhxsI5xUc6jhJBgDIcMpPoS3VOwgqZXFb2+1AysydUUxuco6Sb1ENmD1XEOkN3KTLdPUMWBtpHAayFwv31EOkYSGKqiliNZAbg5xv3RSJViJ6puMAGmodjCTwosElHAWDHuRaGh55t40sk6PbueQ==
X-Gm-Message-State: AOJu0YxP3LZhD2WXH/3bA2XBwHXOrDF7kh027dMVFBlsWOQvKmIFqPBP
	IUa/ru6rQHlGP3Kh6a/MFP+HZn5tqZj7BNTUINYWYN8RfwbxFh7C1X70sv5WWE5j7RX7fjXd2gV
	aUjdsr5BHAgtVdB+jNCvxpVTYZhs=
X-Google-Smtp-Source: AGHT+IGZk+DpZtMHn6BHVFYdXf62S3u6rEViR98zWENE4V8k3P5gazp3N/xTeO9vM98IkMeC3Ov3+38sG4kIJDu1D1o=
X-Received: by 2002:a17:903:2c9:b0:1e2:875:f215 with SMTP id
 s9-20020a17090302c900b001e20875f215mr13484272plk.30.1712005454598; Mon, 01
 Apr 2024 14:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191224.1046866-1-weilin.wang@intel.com> <20240329191224.1046866-5-weilin.wang@intel.com>
In-Reply-To: <20240329191224.1046866-5-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 1 Apr 2024 14:04:03 -0700
Message-ID: <CAM9d7ciqiAOV_1A0N3he_Jiw3ur-ZN6djWpzgR2C+AF2m9an5A@mail.gmail.com>
Subject: Re: [RFC PATCH v6 4/5] perf stat: Add retire latency print functions
 to print out at the very end of print out
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:12=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add print out functions so that users could read retire latency values.
>
> Example output:
> In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES samp=
le.
> Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p retire_latency value, c=
ount
> and sum are all 0.
>
>  Performance counter stats for 'system wide':
>
>        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tm=
a_dtlb_store
>          3,195,608      cpu_core/topdown-retiring/
>         40,156,649      cpu_core/topdown-mem-bound/
>          3,550,925      cpu_core/topdown-bad-spec/
>        117,571,818      cpu_core/topdown-fe-bound/
>         57,118,087      cpu_core/topdown-be-bound/
>             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
>              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
>         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
>         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
>            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
>               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0

The output is not aligned and I think it's hard to read.
I think it should print the result like this:

    <sum>  <event-name>  # <val>  average retired latency

Thanks,
Namhyung


>
>        1.003105924 seconds time elapsed
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 65 ++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index bfc1d705f437..6c043d9c9f81 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -21,6 +21,7 @@
>  #include "iostat.h"
>  #include "pmu.h"
>  #include "pmus.h"
> +#include "metricgroup.h"
>
>  #define CNTR_NOT_SUPPORTED     "<not supported>"
>  #define CNTR_NOT_COUNTED       "<not counted>"
> @@ -34,6 +35,7 @@
>  #define COMM_LEN     16
>  #define PID_LEN       7
>  #define CPUS_LEN      4
> +#define RETIRE_LEN    8
>
>  static int aggr_header_lens[] =3D {
>         [AGGR_CORE]     =3D 18,
> @@ -426,6 +428,67 @@ static void print_metric_std(struct perf_stat_config=
 *config,
>         fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
>  }
>
> +static void print_retire_lat_std(struct perf_stat_config *config,
> +                                struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       bool newline =3D os->newline;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +
> +       list_for_each_entry(t, retire_lats, event.nd) {
> +               if (newline)
> +                       do_new_line_std(config, os);
> +               fprintf(out, "%'*.2f %-*s", COUNTS_LEN, t->val, EVNAME_LE=
N, t->event.name);
> +               fprintf(out, "%*ld %*d\n", RETIRE_LEN, t->count,
> +                        RETIRE_LEN, t->sum);
> +       }
> +}
> +
> +static void print_retire_lat_csv(struct perf_stat_config *config,
> +                                struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +       const char *sep =3D config->csv_sep;
> +
> +       list_for_each_entry(t, retire_lats, event.nd) {
> +               fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep, t->=
event.name, sep,
> +                       t->count, sep, t->sum);
> +       }
> +}
> +
> +static void print_retire_lat_json(struct perf_stat_config *config,
> +                                 struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +
> +       fprintf(out, "{");
> +       list_for_each_entry(t, retire_lats, event.nd) {
> +               fprintf(out, "\"retire_latency-value\" : \"%f\", ", t->va=
l);
> +               fprintf(out, "\"event-name\" : \"%s\"", t->event.name);
> +               fprintf(out, "\"sample-counts\" : \"%ld\"", t->count);
> +               fprintf(out, "\"retire_latency-sum\" : \"%d\"", t->sum);
> +       }
> +       fprintf(out, "}");
> +}
> +
> +static void print_retire_lat(struct perf_stat_config *config,
> +                            struct outstate *os)
> +{
> +       if (!&config->tpebs_results)
> +               return;
> +       if (config->json_output)
> +               print_retire_lat_json(config, os);
> +       else if (config->csv_output)
> +               print_retire_lat_csv(config, os);
> +       else
> +               print_retire_lat_std(config, os);
> +}
> +
>  static void new_line_csv(struct perf_stat_config *config, void *ctx)
>  {
>         struct outstate *os =3D ctx;
> @@ -1609,6 +1672,8 @@ void evlist__print_counters(struct evlist *evlist, =
struct perf_stat_config *conf
>                 break;
>         }
>
> +       print_retire_lat(config, &os);
> +
>         print_footer(config);
>
>         fflush(config->output);
> --
> 2.43.0
>

