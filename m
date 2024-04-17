Return-Path: <linux-kernel+bounces-147901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB50D8A7B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F781C215DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB03BBF7;
	Wed, 17 Apr 2024 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVaL4Xn6"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88F08BFC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713325775; cv=none; b=mwAc/QFjAw9v+WNh6QwnmRStPJiZTMLc9XIyh15HUvFoP12SwzqFWo/hHP28FWLqN/7hb0RuHQ81kaAZ2U/9u2EmQoo02WhMay2hUmx4CyY6h7G4blr1vW2ry4eVybF1z1x7t+vbix7yBvjngseRn2S00SH8A6XBbsB4jqj0OxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713325775; c=relaxed/simple;
	bh=2f3KgQ6HSPeWp8Dic8AieWtnuWDA1AAlDkV/vxItVPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Somhz5VolIoDuTC6xQftEmyLukYDSZsjRTEaWATDl57qVKrGbbtM2q+ItS0dEsJtwylAPidCp+mAxZHZAPRwXN5hrP0AM+lNiNtrcTnqnpV7tKI5hVG2ImihT6KGoZFyD+XoLdafGQRvgoUbTpIzSZWvBLHpc9yEMGrR49e5EXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVaL4Xn6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-434b5abbb0dso149331cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713325773; x=1713930573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bxpmdQK2lwVyxL8e1b8aoJ9nIIIANWvbSN9Lr6HQTc=;
        b=gVaL4Xn6yLpLbXwwwVCcf/AMbu5v7V24TpqdEOLPr9eQ5vPgzTRsVzE4fJ1Hyjxpgs
         aDOq/zCKv1Ov1y25q8HR+bi+50Z7bDk62viJcZEwe1vxZL2SFaF3qna9hCgc+vHdfYgY
         WrAnwsTr947xwzTF/c69gET48LA9oRCviYCVuaJUaNEKSFwEF34iL5dsKUhGHmRl3AmN
         OnJ8NqFJ20m4lBz2F/w1yoSUXhnN/HuecNAKfnpJg03a65/afZW7I6KrnlZrxU4KLp4F
         FeVT6KHgLH8QXmNpDGuS5oUMgl+5KmhTJdYhvIVgtdwz4HUYkAvMD5NupJCc6yLX+sqk
         kSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713325773; x=1713930573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bxpmdQK2lwVyxL8e1b8aoJ9nIIIANWvbSN9Lr6HQTc=;
        b=U3APPu2/fG0D6pjVFTso9q+9m8THwtZwrKlfKiB5y7MtGPDlgCAsxUj+XBtPMk1Ao9
         PLZDk/3ut3sfDUJsdLIzcSCnXtZjcq1JuYSU1wtzYxbh1Bw5duCHj6WQ+vxdGOH7s6HA
         2DT2g33bVvnMGQ+UwtVDCtSFPybM2k+v6sfWQ0C/rZD7SIjLfC1rlWKlctnqWXv3EDtG
         gFkoUAESqV91jCq4H7EU7qmLyYglRGfcYW+yjGzQeNlc4HVlgXTQLUGgufO/UhBrI7Is
         2Pji+ZT42D9aFSrAs8edslRk6d6c+YDhdrBib5b0WrQK12/wfPUMQt4mQkK+bPtvZm7n
         eyFw==
X-Forwarded-Encrypted: i=1; AJvYcCX3LCAUPKn2RBr7WNT8QiMWHlxhO3UtYJcj6f82Cmk6nYgnIah6z//YnExo0ZibDp70Kisnrb0u90CeCG4MHkV4AkBwLPwFMcF3l6xw
X-Gm-Message-State: AOJu0YwA9qAGvN9eDJb2s4vrEpxbBAJD9bkqKCcpPLDDa++sAAMOR1St
	wK6YT5apP3WYz+3wH6hc1CM0aQsX+sUEEATIquiFQz5wJdaXvJZ2lqF1D2ITwDqjaxb8kIwQEvD
	Pq1AmujQtqneyt2KgqQBHY7KbMlgIJ8B+sbuS
X-Google-Smtp-Source: AGHT+IHuNJ8z5JTBH+m9cwerVxFHFAq31vSDuEvn+yGPUsVZb08jaCrxfaV8BELCaBuHZrfVnz4ZOEUQlAkXuHoAnNA=
X-Received: by 2002:a05:622a:1b8d:b0:436:be6b:7156 with SMTP id
 bp13-20020a05622a1b8d00b00436be6b7156mr97668qtb.11.1713325772550; Tue, 16 Apr
 2024 20:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210756.309828-1-weilin.wang@intel.com> <20240412210756.309828-2-weilin.wang@intel.com>
In-Reply-To: <20240412210756.309828-2-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 20:49:21 -0700
Message-ID: <CAP-5=fWNREXxROJhKC2T+Oaw+PBjM=VYdpm_eiaCgc1DLnbm3A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 01/16] perf stat: Add new field in stat_config to
 enable hardware aware grouping.
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Hardware counter and event information could be used to help creating eve=
nt
> groups that better utilize hardware counters and improve multiplexing.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     | 5 +++++
>  tools/perf/util/metricgroup.c | 5 +++++
>  tools/perf/util/metricgroup.h | 1 +
>  tools/perf/util/stat.h        | 1 +
>  4 files changed, 12 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6bba1a89d030..c4a5f0984295 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2106,6 +2106,7 @@ static int add_default_attributes(void)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> +                                               stat_config.hardware_awar=
e_grouping,
>                                                 &stat_config.metric_event=
s);
>         }
>
> @@ -2139,6 +2140,7 @@ static int add_default_attributes(void)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> +                                               stat_config.hardware_awar=
e_grouping,
>                                                 &stat_config.metric_event=
s);
>         }
>
> @@ -2173,6 +2175,7 @@ static int add_default_attributes(void)
>                                                 /*metric_no_threshold=3D*=
/true,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> +                                               stat_config.hardware_awar=
e_grouping,
>                                                 &stat_config.metric_event=
s) < 0)
>                         return -1;
>         }
> @@ -2214,6 +2217,7 @@ static int add_default_attributes(void)
>                                                         /*metric_no_thres=
hold=3D*/true,
>                                                         stat_config.user_=
requested_cpu_list,
>                                                         stat_config.syste=
m_wide,
> +                                                       stat_config.hardw=
are_aware_grouping,
>                                                         &stat_config.metr=
ic_events) < 0)
>                                 return -1;
>
> @@ -2748,6 +2752,7 @@ int cmd_stat(int argc, const char **argv)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> +                                               stat_config.hardware_awar=
e_grouping,
>                                                 &stat_config.metric_event=
s);
>
>                 zfree(&metrics);
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 79ef6095ab28..11613450725a 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1690,12 +1690,17 @@ int metricgroup__parse_groups(struct evlist *perf=
_evlist,
>                               bool metric_no_threshold,
>                               const char *user_requested_cpu_list,
>                               bool system_wide,
> +                             bool hardware_aware_grouping,
>                               struct rblist *metric_events)
>  {
>         const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
>
>         if (!table)
>                 return -EINVAL;
> +       if (hardware_aware_grouping) {
> +               pr_debug("Use hardware aware grouping instead of traditio=
nal metric grouping method\n");
> +       }

nit: single line if statements shouldn't have curlies:
https://www.kernel.org/doc/html/v6.8/process/coding-style.html#placing-brac=
es-and-spaces

Thanks,
Ian

> +
>
>         return parse_groups(perf_evlist, pmu, str, metric_no_group, metri=
c_no_merge,
>                             metric_no_threshold, user_requested_cpu_list,=
 system_wide,
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index d5325c6ec8e1..779f6ede1b51 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -77,6 +77,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlis=
t,
>                               bool metric_no_threshold,
>                               const char *user_requested_cpu_list,
>                               bool system_wide,
> +                             bool hardware_aware_grouping,
>                               struct rblist *metric_events);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>                                    const struct pmu_metrics_table *table,
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index d6e5c8787ba2..fd7a187551bd 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -87,6 +87,7 @@ struct perf_stat_config {
>         bool                     metric_no_group;
>         bool                     metric_no_merge;
>         bool                     metric_no_threshold;
> +       bool                     hardware_aware_grouping;
>         bool                     stop_read_counter;
>         bool                     iostat_run;
>         char                     *user_requested_cpu_list;
> --
> 2.42.0
>

