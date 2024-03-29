Return-Path: <linux-kernel+bounces-124209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFB98913E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709421C21EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291223C482;
	Fri, 29 Mar 2024 06:47:43 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954D3BB20;
	Fri, 29 Mar 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694862; cv=none; b=kCgRRfEYkeO5Jcz4bQFmG6coSJ+T3dvsOruQx2C61Nb1HWhBk6KKnOueuAGwJPInPpr//qj/QkOadIzwSj5qbPwOQSP3g77HW+qgGbBlYgXhGlqfOhmEeo9nyWUKOgMWDW9xpONe0FANc7U8o4MejdAM2yNNGWLvkR3yCB2pA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694862; c=relaxed/simple;
	bh=izFK5XYkRZKa9ZCzV4opit9b3Ca7NJrbNYZctJIiawE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/V5qsvmBHO714hayP3bpRRQO+jJ/WKd0Oe0ioIryxMpHILRkwFQ8nUap1fSd9rUIpy4s+QoZ8DHtK9vXbT+0gmOT0NML/BkZB1kPxwUNMTy/gCd66ViP3Po9vySnxzWfUK4N24t1HjHYwPqWaMOutshTowBooHPmR8TBVW8hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6fb9a494aso1506054b3a.0;
        Thu, 28 Mar 2024 23:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711694860; x=1712299660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKxkF5DycsiIenidpZ8HuGYDWfU4JArm5xr/R0Y9MYk=;
        b=nYeXxpeOq1Z3V52j3IuiKwntoEUicTrr+gE2eNuXzrKxf1y57z5kIQlep2jMJtcpwz
         bQd9JtcH80EoAGI4Y+hjAZcVook27uKudE0Pr18u5tvUemyNdG4FkHTvtouafnj2OFtr
         XRJR2KCZG7Vco4rNfdrT3LLrvkjKpsQ6P/MJGvgJ1mUHWcJTKClrbdGa6l/6uASxlnoS
         quo3x749yQ79NXe/TYvNq74DxwOOX9jmkAs7cAOwR9CktX0h9YSvFAYtTMR5xUFCyNDD
         TorPSuaepzZvTiIzsoB8vJDorW/Buuk3lxQ5MXBPTtvL+RgNcwg7bsuk6yMVcyULKalI
         UU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxUITKU8BcwPM8kjxcyaebYEqqAUpPRwlFUxXj0hkAflT3PtuR/QiEnrI7hQHFd5ClgWBTKyGgLQOubMkgNGEV20ndxHwgpEvgzn7qrIFBskVA4AWd1qpmL9u/XbJSjMPc7yX7oC4onpIHT76eRQ==
X-Gm-Message-State: AOJu0YyQdl56a8wSBCwrveRzXlX4YTPLUNUs/EmdMHWlUVQg+6WpZ51C
	8EAfJOq9Yk6G58wxc2L73+5ijr5oXytShrSdPZt4pbeFEVLrSIf4Ox1GHFE7SnZTO9KIeeZikq0
	N50BLxdymt0K25FAY0AvGSdLk4C4=
X-Google-Smtp-Source: AGHT+IHZaGRnnY0XKbgAeEwQcJ3AaCj8XeaBjDyAWKQdjLyiVehZyULIBtH5qDjBaRWskxVexGjTyrZ5YMlRRGK2jYM=
X-Received: by 2002:a05:6a20:958b:b0:1a1:776d:15c with SMTP id
 iu11-20020a056a20958b00b001a1776d015cmr1470917pzb.21.1711694860427; Thu, 28
 Mar 2024 23:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326202859.960577-1-weilin.wang@intel.com> <20240326202859.960577-5-weilin.wang@intel.com>
In-Reply-To: <20240326202859.960577-5-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 28 Mar 2024 23:47:29 -0700
Message-ID: <CAM9d7chrawiERtqDbmT4RJ81oYmQijSAMbCGOrVZ_sdpgD5AGg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 4/6] perf stat: Create another thread for sample
 data processing
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

On Tue, Mar 26, 2024 at 1:29=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Another thread is required to synchronize between perf stat and perf reco=
rd
> when we pass data through pipe.

It seems better if you can squash this commit to the patch 2/6.

Thanks,
Namhyung

>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 51 +++++++++++++++++++++--------------
>  tools/perf/util/stat-shadow.c |  4 +--
>  2 files changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index fc887d9aaa66..14488cb0cfc8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -802,9 +802,9 @@ static int process_feature_event(struct perf_session =
*session,
>         return 0;
>  }
>
> -static int __cmd_script(struct child_process *cmd __maybe_unused)
> +static void *__cmd_script(void *arg __maybe_unused)
>  {
> -       int err =3D 0;
> +       struct child_process *cmd =3D arg;
>         struct perf_session *session;
>         struct perf_data data =3D {
>                 .mode =3D PERF_DATA_MODE_READ,
> @@ -819,29 +819,15 @@ static int __cmd_script(struct child_process *cmd _=
_maybe_unused)
>                 .attr            =3D perf_event__process_attr,
>                 },
>         };
> -       struct tpebs_event *e;
> -
> -       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> -               struct tpebs_retire_lat *new =3D malloc(sizeof(struct tpe=
bs_retire_lat));
>
> -               if (!new)
> -                       return -1;
> -               new->event.name =3D strdup(e->name);
> -               new->event.tpebs_name =3D strdup(e->tpebs_name);
> -               new->count =3D 0;
> -               new->sum =3D 0;
> -               list_add_tail(&new->event.nd, &stat_config.tpebs_results)=
;
> -       }
> -
> -       kill(cmd->pid, SIGTERM);
>         session =3D perf_session__new(&data, &script.tool);
>         if (IS_ERR(session))
> -               return PTR_ERR(session);
> +               return NULL;
>         script.session =3D session;
> -       err =3D perf_session__process_events(session);
> +       perf_session__process_events(session);
>         perf_session__delete(session);
>
> -       return err;
> +       return NULL;
>  }
>
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
> @@ -861,16 +847,37 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>         int err;
>         bool second_pass =3D false;
>         struct child_process cmd;
> +       pthread_t thread_script;
>
>         /* Prepare perf record for sampling event retire_latency before f=
ork and
>          * prepare workload */
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
> +               struct tpebs_event *e;
>
>                 pr_debug("perf stat pid =3D %d\n", getpid());
> +               list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +                       struct tpebs_retire_lat *new =3D malloc(sizeof(st=
ruct tpebs_retire_lat));
> +
> +                       if (!new)
> +                               return -1;
> +                       new->event.name =3D strdup(e->name);
> +                       new->event.tpebs_name =3D strdup(e->tpebs_name);
> +                       new->count =3D 0;
> +                       new->sum =3D 0;
> +                       list_add_tail(&new->event.nd, &stat_config.tpebs_=
results);
> +               }
>                 ret =3D prepare_perf_record(&cmd);
>                 if (ret)
>                         return ret;
> +               if (pthread_create(&thread_script, NULL, __cmd_script, &c=
md)) {
> +                       kill(cmd.pid, SIGTERM);
> +                       close(cmd.out);
> +                       pr_err("Could not create thread to process sample=
 data.\n");
> +                       return -1;
> +               }
> +               /* Wait for perf record initialization a little bit.*/
> +               sleep(2);
>         }
>
>         if (forks) {
> @@ -1081,8 +1088,12 @@ static int __run_perf_stat(int argc, const char **=
argv, int run_idx)
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
>
> -               ret =3D __cmd_script(&cmd);
> +               kill(cmd.pid, SIGTERM);
> +               pthread_join(thread_script, NULL);
>                 close(cmd.out);
> +               ret =3D finish_command(&cmd);
> +               if (ret !=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> +                       return ret;
>         }
>
>         if (stat_config.walltime_run_table)
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 8fc3415de106..bc77e9e02892 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -361,8 +361,8 @@ static int prepare_retire_lat(struct expr_parse_ctx *=
pctx,
>         int ret =3D 0;
>         struct tpebs_retire_lat *t;
>
> -       list_for_each_entry(t, retire_lats, nd) {
> -               ret =3D expr__add_id_val(pctx, strdup(t->tpebs_name), t->=
val);
> +       list_for_each_entry(t, retire_lats, event.nd) {
> +               ret =3D expr__add_id_val(pctx, strdup(t->event.tpebs_name=
), t->val);
>                 if (ret < 0)
>                         return ret;
>         }
> --
> 2.43.0
>

