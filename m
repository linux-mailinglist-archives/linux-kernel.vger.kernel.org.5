Return-Path: <linux-kernel+bounces-99896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA73878EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503A3282250
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE46994D;
	Tue, 12 Mar 2024 06:42:35 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AB2CA5;
	Tue, 12 Mar 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710225755; cv=none; b=rgZVVUd68p5JsAtLjeKm6iw5XjBaY1NdnY0MP60aDP+7bNUeByFLWrJW4Kc0VGXVRezmxxRNRvqaedzushkmsu3VAFk/5NeU/W8VZSGlCNvYXgQZ5ZSfG+Dyvk6KHw0LsR2B1H2s2J/SZkUxoHvfi4mOa38GO0C5HbSexAhj+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710225755; c=relaxed/simple;
	bh=eoAvukz6RS6ZtpG98LS9t8+xdMi4WfhaRf5okKy+uE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+LkDwtv+imFC3mUex9NY3NYsqsnK9y6Xl2/1qtqzPWdQuPJo0743/qojeAj665bVv942raGwnKvHtOJcX8uFN5eryWfP5hWVP+PU0ztcGAuWTgtKT6XEJ7EMWHUAuwIe82wfaZ6vBUfMYmTd7fbHhcR5CvaybAQL4rgqQRgRDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29bd4dfbf56so1643866a91.3;
        Mon, 11 Mar 2024 23:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710225753; x=1710830553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIEkWn//dMuVIa9BTNR1dksCTmGOO0zz69/ek9CrfqU=;
        b=DTSKRDkPE+mMW95W2AZkrVafTqjlaQRFudW3HwxXA9l1V7hVx2xVfoDH69QxA4sreg
         5myj5Bp9u/apa3chA5nSdWhPI1cKm/cUcR6ge5Ta7seYhKsBnHMPaOPCFivw6JTPCZPm
         iaScuj7JLudXaT/mkbhHDgir5J5tUKy4IwIuc4G4BgGMTnTkNDc9MbIFFyE2hwR19JkI
         KGm/vLF+schcBpg+8fXXaCb0D3sK8jr5OfIkCI6SRDYpG1JRpaobJ8e/rrMwdMFCSxko
         KO2GJiaBnHvAFy5tdoEyd+ixgRSciO1vR9aPpmNOK67MzGlWFPR+e4hE7ue1TsdRgo8T
         6hnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtytnxg/MKgUlprYwq/8eaCG7FnWYNYO3Lk1zChBM5TQEiBF7R27LjyhV1faI8WmHUB9ygGPyuVezsIQl7yLijvv8jkL90i6BFU2zn6CxDd0eZp9Uj1SxZtDxvC9GsxMWBRihGFSF6jYSctEpVBQ==
X-Gm-Message-State: AOJu0YyoH2dXDgouDn8KOz7Me+C7mS9tBcvrhjy8uAFkYdK93i5G8Skf
	pKUVdKZ1H/XQkwqPHWqVHCSX/s4dKfq8bgtepXgM7GoTI3YqkYtHj6NoOMg1pv9Jua77NlpXqy3
	qv8u+HfoQ3tKolfFY0Z6vNfYwbOQ=
X-Google-Smtp-Source: AGHT+IHyG3lOHt+KcpSwkz65hRX/O9wVgkNap2m7bb8y/vt+WyUXzEW3Ie5Wd6qUwK9vGpKKsSJQYKzTMpsFIvULcz0=
X-Received: by 2002:a17:90a:2ec7:b0:29b:e9c1:3656 with SMTP id
 h7-20020a17090a2ec700b0029be9c13656mr4292306pjs.43.1710225752834; Mon, 11 Mar
 2024 23:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302001139.604829-1-weilin.wang@intel.com> <20240302001139.604829-4-weilin.wang@intel.com>
In-Reply-To: <20240302001139.604829-4-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 23:42:21 -0700
Message-ID: <CAM9d7cixE8r0Kbrnx_gSzPvfXt60zC7Qkerwf1UkJkCq0yHC+A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/6] perf stat: Add retire latency values into the
 expr_parse_ctx to prepare for final metric calculation
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:11=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Retire latency values of events are used in metric formulas. This update =
adds
> code to process data from perf record for required retire latency values.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     |  1 +
>  tools/perf/util/metricgroup.h |  1 +
>  tools/perf/util/stat-shadow.c | 18 ++++++++++++++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3890a579349e..3e5865572266 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -792,6 +792,7 @@ static int process_sample_event(struct perf_tool *too=
l,
>                 if (!strcmp(evname, t->name)) {
>                         t->count +=3D 1;
>                         t->sum +=3D sample->retire_lat;
> +                       t->val =3D t->count > 0 ? t->sum/t->count : 0;

You already increase the count, then it cannot be 0, right?


>                         break;
>                 }
>         }
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 1fa12cc3294e..08af0f447550 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -77,6 +77,7 @@ struct tpebs_retire_lat {
>         const char *tpebs_name;
>         size_t count;
>         int sum;
> +       double val;
>  };
>
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 3466aa952442..c63ba52004fc 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -355,6 +355,19 @@ static void print_nsecs(struct perf_stat_config *con=
fig,
>                 print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0=
);
>  }
>
> +static int prepare_retire_lat(struct expr_parse_ctx *pctx,
> +                            struct list_head *retire_lats)
> +{
> +       int ret =3D 0;
> +       struct tpebs_retire_lat *t;

A newline please.

Thanks,
Namhyung


> +       list_for_each_entry(t, retire_lats, nd) {
> +               ret =3D expr__add_id_val(pctx, strdup(t->tpebs_name), t->=
val);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +       return ret;
> +}
> +
>  static int prepare_metric(const struct metric_expr *mexp,
>                           const struct evsel *evsel,
>                           struct expr_parse_ctx *pctx,
> @@ -486,6 +499,11 @@ static void generic_metric(struct perf_stat_config *=
config,
>                 pctx->sctx.user_requested_cpu_list =3D strdup(config->use=
r_requested_cpu_list);
>         pctx->sctx.runtime =3D runtime;
>         pctx->sctx.system_wide =3D config->system_wide;
> +       i =3D prepare_retire_lat(pctx, &config->tpebs_results);
> +       if (i < 0) {
> +               expr__ctx_free(pctx);
> +               return;
> +       }
>         i =3D prepare_metric(mexp, evsel, pctx, aggr_idx);
>         if (i < 0) {
>                 expr__ctx_free(pctx);
> --
> 2.43.0
>

