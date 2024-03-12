Return-Path: <linux-kernel+bounces-99898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE61878EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294981C20B31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B36994F;
	Tue, 12 Mar 2024 06:47:58 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECE2CA5;
	Tue, 12 Mar 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710226077; cv=none; b=eg9JoUwVRyoW48fE1ka+mFEw81vXraqDWWxw44HCajLSZVe/jyTN8Q+JrJSrcOkrv4jvrpAmhJCUDB7gcwWHhpVuDKvlUnAVafZtB6mC/CQNaapeyc3IT7QsWpF41K3NOJtJsx/2TciJEuJBRLbpJYi4gqIwrLZhHboE8BwO4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710226077; c=relaxed/simple;
	bh=PlJZqEJ9PQ3q4PFFvBh1tIPhdakR8LTKPRG9E4U+P+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7YIoJLSx7IFB6z8B/qEHMc7BAKczm65EXvPpWigQkh9g8sSQ7o4LBDwGpUilnPgzuZ13h8cnVi6+ZAe/zz4fXKR+v60do1F+bdihoIoeBcOZJDV+FHW9XysNFgmYcsY4dwT2dpMIfIy58btN1v1uB9YNLFt4VrZzLjWuOlpmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4355312a12.3;
        Mon, 11 Mar 2024 23:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710226075; x=1710830875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iySuK8tBj9x5RPHeMMneDuiFjL0KBkHXO3jOJaV8CBo=;
        b=VIu4IHM1U2LPH0lduNNzUNpLaExDHcvJfZ2947uIO26zyxgJUA+8LDANQe6SHELgOC
         xSS+yKMGMDbsPTywRI67YFL2XSieJiKDb65+ReAz73gtspVq8FSxGdKCZ/GZuP+DD01v
         wC4WoYBAiX7oldXr644aI5sWQV/ykZb+7qiuG8+VBnEkySG/PH+RUGHtNYfIC2kz1qBu
         7MgKt3pbHKcLBRPtm48dp/wUplWAKGoCQBcEwqBbqKnE+muA9E0N7IjaX7j845w0yQXA
         d0B9QEpYKjsLUMvW967hRYKPCyWrOsh8uiith7nHi6nCZ++rukkoNubqBZFH1EJccGUR
         6Oyg==
X-Forwarded-Encrypted: i=1; AJvYcCXXmHmznjh9JNp/RO2scHPuBY0g+59oZDcagYSKZVl98i2j8ZWn+Q0SOD46yqdd9O/U4CpWuC/d7+AGO7Gx7ZaYIZ1/MWGiiD1CRfVCYckuf4VuaFnTHaqt2drDAEE9Hu1lU/qPm5/FcvPYlxV1cg==
X-Gm-Message-State: AOJu0YxULfRkMCMdvliYH9NOqb2wPOcVeFHnotf1qibVNBwNx2wikpjY
	vWAkUPRHomV8DH4dsJsG6TSIZ5oVHmkYkC+DTyJbCFTQSiT68ykC2fbOHBtW/O6QNVkJpTtv2KT
	3MTRKusg3epFNlfxwULCPjWrZp+o=
X-Google-Smtp-Source: AGHT+IHbvAEfPOf6/ksBQ1FeevInSTbeZwU8ZMSO93X5JFfLcM8mXZwqzMRlAolhsk2VJ/qYu1erxjSo6q6EMf8Sdtc=
X-Received: by 2002:a17:90a:17af:b0:299:7842:baf6 with SMTP id
 q44-20020a17090a17af00b002997842baf6mr6146711pja.47.1710226075408; Mon, 11
 Mar 2024 23:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302001139.604829-1-weilin.wang@intel.com> <20240302001139.604829-5-weilin.wang@intel.com>
In-Reply-To: <20240302001139.604829-5-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 23:47:44 -0700
Message-ID: <CAM9d7ciVnWkaLMwHcJwC58KYDTW9t4SQevEGnqKcNZmJ7XF57Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/6] perf stat: Create another thread for sample
 data processing
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
> Another thread is required to synchronize between perf stat and perf reco=
rd
> when we pass data through pipe.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c | 58 +++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3e5865572266..2372175d3408 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -777,7 +777,6 @@ static int process_sample_event(struct perf_tool *too=
l,
>         const char *evname;
>         struct tpebs_retire_lat *t;
>
> -       pr_debug("entering function %s\n ", __func__);
>         evname =3D evsel__name(evsel);
>
>         pr_debug("[%03d] ", sample->cpu);
> @@ -808,9 +807,9 @@ static int process_feature_event(struct perf_session =
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
> @@ -826,29 +825,15 @@ static int __cmd_script(struct child_process *cmd _=
_maybe_unused)
>                 .attr            =3D perf_event__process_attr,
>                 },
>         };
> -       struct tpebs_event *e;
> -
> -       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> -               struct tpebs_retire_lat *new =3D malloc(sizeof(struct tpe=
bs_retire_lat));
> -
> -               if (!new)
> -                       return -1;
> -               new->name =3D strdup(e->name);
> -               new->tpebs_name =3D strdup(e->tpebs_name);
> -               new->count =3D 0;
> -               new->sum =3D 0;
> -               list_add_tail(&new->nd, &stat_config.tpebs_results);
> -       }
>
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
> @@ -868,15 +853,37 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>         int err;
>         bool second_pass =3D false;
>         struct child_process cmd;
> +       pthread_t thread_script;
>
>         //Prepare perf record for sampling event retire_latency before fo=
rk and prepare workload
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
>
> +               struct tpebs_event *e;
>                 pr_debug("perf stat pid =3D %d\n", getpid());
>                 ret =3D prepare_perf_record(&cmd);
>                 if (ret)
>                         return ret;
> +
> +               list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +                       struct tpebs_retire_lat *new =3D malloc(sizeof(st=
ruct tpebs_retire_lat));
> +
> +                       if (!new)
> +                               return -1;

This would leave the record command.  I think you'd better
do this before prepare_perf_record().


> +                       new->name =3D strdup(e->name);
> +                       new->tpebs_name =3D strdup(e->tpebs_name);
> +                       new->count =3D 0;
> +                       new->sum =3D 0;
> +                       list_add_tail(&new->nd, &stat_config.tpebs_result=
s);
> +               }
> +
> +               if (pthread_create(&thread_script, NULL, __cmd_script, &c=
md)) {
> +                       kill(cmd.pid, SIGTERM);
> +                       close(cmd.out);
> +                       pr_err("Could not create thread to process sample=
 data.\n");
> +                       return -1;
> +               }
> +               sleep(2);

Why?

Thanks,
Namhyung


>         }
>
>         if (forks) {
> @@ -1087,12 +1094,15 @@ static int __run_perf_stat(int argc, const char *=
*argv, int run_idx)
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
>
> -               pr_debug("pid =3D %d\n", getpid());
> -               pr_debug("cmd.pid =3D %d\n", cmd.pid);
> +               pr_debug("Workload finished, finishing record\n");
> +               pr_debug("Perf stat pid =3D %d, Perf record pid =3D %d\n"=
, getpid(), cmd.pid);
>
> -               ret =3D __cmd_script(&cmd);
> +               kill(cmd.pid, SIGTERM);
> +               pthread_join(thread_script, NULL);
>                 close(cmd.out);
> -               pr_debug("%d\n", ret);
> +               ret =3D finish_command(&cmd);
> +               if (ret !=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> +                       return ret;
>         }
>
>         if (stat_config.walltime_run_table)
> --
> 2.43.0
>

