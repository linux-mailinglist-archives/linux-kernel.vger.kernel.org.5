Return-Path: <linux-kernel+bounces-99894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEBC878EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4461C2085F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90408446AB;
	Tue, 12 Mar 2024 06:40:25 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8343AAF;
	Tue, 12 Mar 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710225624; cv=none; b=BRzzzg8fvs3f1KxTlv3dvyHgBLP++HJSq3qWj/BXKZfOaQa7wRMK92LysXz+MBS9QEaexRH3UmH1uHW1gKzpsnURGpm5gsYhbCTXPiELf3++D4nmBMNahYmVwPcLtKtISB8CIZLEZMMuoGNoEIj4J8O9SjzL7wFXIYk+wcLe+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710225624; c=relaxed/simple;
	bh=tenB6xSk70QSx/vjj8bnnqnMOqvauftzNl1q/oOyNEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beCHORzB2+I3U+vH1oJhA1dT1oyoJcRik0yrNFnJc1rp28IkXFF0BHkXjCc3G1Ib0uIzlnOdZBu94NpOucW9tIpyeca0SR9btvs4W2B3T3FusamcRpe5pRBtbGg7jYP02oMBa1CK+Qnsa+tKrXdp+FpX+XUwRmfgXcUzyoipDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6082eab17so4714973b3a.1;
        Mon, 11 Mar 2024 23:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710225622; x=1710830422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3Fd6N+sp6G9YZ6b5OQNrXrgNifGe6J2VP43OGs23qw=;
        b=vFyqEcbf8OjLgXdtwjenAWKikkhC2+O2OTFtwZ2sonnaauIrsfi4A+xZ7QMIS7oiuR
         b2SUI1Z9+Pa4qPZ5gk+iec8mzsBuFOyp4r8uX5unN/O4WSd/5MX6Ze4kYXuihc48wK3n
         mro6c6Oru8GJplfKHuq+buJ2usn+riNJHphArevqI8szfuwqHRr6mJhxZS8V2qxVpWiZ
         AfTHNLm0K2Ok56Aha5OlNfoe86n7Y/OsZnkkC675jgj+IFtdOB9RRrEHxN/1ZQr2VmmE
         rwm/1TlWqKl1areslS6c5tg31d7DuI/+O9YwlYoIb3Qe91Qfj6kVjmz8EevuyQcTQ6/l
         7Z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY81JYjtIFGMfsktTLHZ+Nj+VSoU7uB48g0epBOYOBA3hcbXDUQdHu1Hjx/VsI/codEr9LA+cyKQ6hoSjgUW/z2EaX9+K2B95XCQHfHjpLLbwioEAYDvgM9o+70Ea7qiOtCjw71qRFppNh5XMSdg==
X-Gm-Message-State: AOJu0Ywv0HlQ0QIy1OtUwZ/a6i4KB3qSnjI1RNDwTsAEX7CsGaeiGUtW
	ElQ0Vq16EZ6dlpHQTdGS3BLk+NHwUL3NHH3d32A+BHXMLfws/0X3HQY0LULmExoMFu4wIzSNhU4
	yM0m0zPw35J75xBd4jPNq7tvV3yo=
X-Google-Smtp-Source: AGHT+IELypRCtp0Ytd1Uie9r1mCXMkhNj21UceQl8iaUuvaj9miXHPh976I2EVbUOF+9+lkhQYjsIZoMZ+Vn9oE99U8=
X-Received: by 2002:a05:6a20:948e:b0:1a3:1136:e71e with SMTP id
 hs14-20020a056a20948e00b001a31136e71emr2106795pzb.36.1710225622229; Mon, 11
 Mar 2024 23:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302001139.604829-1-weilin.wang@intel.com> <20240302001139.604829-3-weilin.wang@intel.com>
In-Reply-To: <20240302001139.604829-3-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 23:40:10 -0700
Message-ID: <CAM9d7cjWEmZqb7BpDpybJG-WXO-fMNa9UQP=pP8=uXGuBu+z6g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
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
> When retire_latency value is used in a metric formula, perf stat would fo=
rk a
> perf record process with "-e" and "-W" options. Perf record will collect
> required retire_latency values in parallel while perf stat is collecting
> counting values.
>
> At the point of time that perf stat stops counting, it would send sigterm=
 signal
> to perf record process and receiving sampling data back from perf record =
from a
> pipe. Perf stat will then process the received data to get retire latency=
 data
> and calculate metric result.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     | 179 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/data.c        |   4 +
>  tools/perf/util/data.h        |   1 +
>  tools/perf/util/metricgroup.h |   7 ++
>  tools/perf/util/stat.h        |   3 +
>  5 files changed, 191 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 5a3093541cff..3890a579349e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -94,8 +94,13 @@
>  #include <perf/evlist.h>
>  #include <internal/threadmap.h>
>
> +#include "util/sample.h"
> +#include <sys/param.h>
> +#include <subcmd/run-command.h>
> +
>  #define DEFAULT_SEPARATOR      " "
>  #define FREEZE_ON_SMI_PATH     "devices/cpu/freeze_on_smi"
> +#define PERF_DATA              "-"
>
>  static void print_counters(struct timespec *ts, int argc, const char **a=
rgv);
>
> @@ -162,7 +167,8 @@ static struct perf_stat_config stat_config =3D {
>         .ctl_fd                 =3D -1,
>         .ctl_fd_ack             =3D -1,
>         .iostat_run             =3D false,
> -       .tpebs_event_size =3D 0,
> +       .tpebs_event_size       =3D 0,
> +       .tpebs_pid              =3D -1,
>  };
>
>  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> @@ -687,12 +693,163 @@ static enum counter_recovery stat_handle_error(str=
uct evsel *counter)
>         return COUNTER_FATAL;
>  }
>
> -static int __run_perf_record(void)
> +static int __run_perf_record(const char **record_argv)
>  {
> +       int i =3D 0;
> +       struct tpebs_event *e;
>         pr_debug("Prepare perf record for retire_latency\n");
> +
> +
> +       record_argv[i++] =3D "perf";
> +       record_argv[i++] =3D "record";
> +       record_argv[i++] =3D "-W";
> +
> +       if (stat_config.user_requested_cpu_list) {
> +               record_argv[i++] =3D "-C";
> +               record_argv[i++] =3D stat_config.user_requested_cpu_list;
> +       }
> +
> +       if (stat_config.system_wide)
> +               record_argv[i++] =3D "-a";
> +
> +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +               record_argv[i++] =3D "-e";
> +               record_argv[i++] =3D e->name;
> +       }
> +
> +       record_argv[i++] =3D "-o";
> +       record_argv[i++] =3D PERF_DATA;
> +
>         return 0;
>  }
>
> +static void prepare_run_command(struct child_process *cmd,
> +                              const char **argv)
> +{
> +       memset(cmd, 0, sizeof(*cmd));
> +       cmd->argv =3D argv;
> +       cmd->out =3D -1;
> +}

A new line please.

> +static int prepare_perf_record(struct child_process *cmd)
> +{
> +       const char **record_argv;
> +
> +       record_argv =3D calloc(10 + 2 * stat_config.tpebs_event_size, siz=
eof(char *));
> +       if (!record_argv)
> +               return -1;
> +       __run_perf_record(record_argv);
> +
> +       prepare_run_command(cmd, record_argv);
> +       return start_command(cmd);
> +}
> +
> +struct perf_script {
> +       struct perf_tool        tool;
> +       struct perf_session     *session;
> +       struct evswitch         evswitch;
> +       struct perf_cpu_map     *cpus;
> +       struct perf_thread_map *threads;
> +       int                     name_width;
> +};

Do we really need all these?

> +
> +static void tpebs_data__delete(void)
> +{
> +       struct tpebs_retire_lat *r, *rtmp;
> +       struct tpebs_event *e, *etmp;
> +       list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results, nd)=
 {
> +               list_del_init(&r->nd);
> +               free(r);
> +       }
> +       list_for_each_entry_safe(e, etmp, &stat_config.tpebs_events, nd) =
{
> +               list_del_init(&e->nd);
> +               free(e);
> +       }
> +}
> +
> +static int process_sample_event(struct perf_tool *tool,
> +                               union perf_event *event __maybe_unused,
> +                               struct perf_sample *sample,
> +                               struct evsel *evsel,
> +                               struct machine *machine __maybe_unused)
> +{
> +       struct perf_script *script =3D container_of(tool, struct perf_scr=
ipt, tool);
> +       int ret =3D 0;
> +       const char *evname;
> +       struct tpebs_retire_lat *t;
> +
> +       pr_debug("entering function %s\n ", __func__);
> +       evname =3D evsel__name(evsel);
> +
> +       pr_debug("[%03d] ", sample->cpu);
> +       pr_debug("%*s: ", script->name_width, evname ?: "[unknown]");
> +       pr_debug("%16" PRIu16, sample->retire_lat);
> +       pr_debug("\n");

These debug messages can go away.

> +
> +       // Need to handle per core results?
> +       // We are assuming average retire latency value will be used. Sav=
e the number of
> +       // samples and the sum of retire latency value for each event.
> +       list_for_each_entry(t, &stat_config.tpebs_results, nd) {
> +               if (!strcmp(evname, t->name)) {
> +                       t->count +=3D 1;
> +                       t->sum +=3D sample->retire_lat;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int process_feature_event(struct perf_session *session,
> +                                union perf_event *event)
> +{
> +       if (event->feat.feat_id < HEADER_LAST_FEATURE)
> +               return perf_event__process_feature(session, event);

Just curious.  Why is this necessary?


> +       return 0;
> +}
> +
> +static int __cmd_script(struct child_process *cmd __maybe_unused)

__cmd_script() is probably not a good name.  Maybe just
process_tpebs_samples()?  Also 'cmd' is actually used.

> +{
> +       int err =3D 0;
> +       struct perf_session *session;
> +       struct perf_data data =3D {
> +               .mode =3D PERF_DATA_MODE_READ,
> +               .path =3D PERF_DATA,
> +               .fd   =3D cmd->out,
> +       };
> +       struct perf_script script =3D {
> +               .tool =3D {
> +               .sample          =3D process_sample_event,
> +               .ordered_events  =3D true,
> +               .ordering_requires_timestamps =3D true,

I don't think you need an ordered events queue for this.


> +               .feature         =3D process_feature_event,
> +               .attr            =3D perf_event__process_attr,
> +               },
> +       };
> +       struct tpebs_event *e;
> +
> +       list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +               struct tpebs_retire_lat *new =3D malloc(sizeof(struct tpe=
bs_retire_lat));
> +
> +               if (!new)
> +                       return -1;
> +               new->name =3D strdup(e->name);
> +               new->tpebs_name =3D strdup(e->tpebs_name);
> +               new->count =3D 0;
> +               new->sum =3D 0;

I think you can simply use zalloc() instead.


> +               list_add_tail(&new->nd, &stat_config.tpebs_results);
> +       }
> +
> +       kill(cmd->pid, SIGTERM);
> +       session =3D perf_session__new(&data, &script.tool);
> +       if (IS_ERR(session))
> +               return PTR_ERR(session);
> +       script.session =3D session;
> +       err =3D perf_session__process_events(session);
> +       perf_session__delete(session);
> +
> +       return err;
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>         int interval =3D stat_config.interval;
> @@ -709,12 +866,14 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>         struct affinity saved_affinity, *affinity =3D NULL;
>         int err;
>         bool second_pass =3D false;
> +       struct child_process cmd;
>
>         //Prepare perf record for sampling event retire_latency before fo=
rk and prepare workload
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
>
> -               ret =3D __run_perf_record();
> +               pr_debug("perf stat pid =3D %d\n", getpid());
> +               ret =3D prepare_perf_record(&cmd);
>                 if (ret)
>                         return ret;
>         }
> @@ -924,6 +1083,17 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>
>         t1 =3D rdclock();
>
> +       if (stat_config.tpebs_event_size > 0) {
> +               int ret;
> +
> +               pr_debug("pid =3D %d\n", getpid());
> +               pr_debug("cmd.pid =3D %d\n", cmd.pid);
> +
> +               ret =3D __cmd_script(&cmd);
> +               close(cmd.out);
> +               pr_debug("%d\n", ret);

Please remove all the unnecessary debug messages.

And you don't need to wait for the target process to finish
in order to process samples.  Actually it'd increase the
chance that the pipe is full during the execution.


> +       }
> +
>         if (stat_config.walltime_run_table)
>                 stat_config.walltime_run[run_idx] =3D t1 - t0;
>
> @@ -2761,6 +2931,7 @@ int cmd_stat(int argc, const char **argv)
>         }
>
>         INIT_LIST_HEAD(&stat_config.tpebs_events);
> +       INIT_LIST_HEAD(&stat_config.tpebs_results);
>
>         /*
>          * Metric parsing needs to be delayed as metrics may optimize eve=
nts
> @@ -2972,5 +3143,7 @@ int cmd_stat(int argc, const char **argv)
>         metricgroup__rblist_exit(&stat_config.metric_events);
>         evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack,=
 &stat_config.ctl_fd_close);
>
> +       tpebs_data__delete();
> +
>         return status;
>  }
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 08c4bfbd817f..2e2a20fc5c30 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -185,6 +185,10 @@ static bool check_pipe(struct perf_data *data)
>         int fd =3D perf_data__is_read(data) ?
>                  STDIN_FILENO : STDOUT_FILENO;
>
> +       if (data->fd > 0) {
> +               fd =3D data->fd;
> +       }

I'm not sure if it's needed.  The data->path is set and it'll be
checked in the below.


> +
>         if (!data->path) {
>                 if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
>                         is_pipe =3D true;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 110f3ebde30f..720638116ca0 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -28,6 +28,7 @@ struct perf_data_file {
>
>  struct perf_data {
>         const char              *path;
> +       int                      fd;

Can we remove this?


>         struct perf_data_file    file;
>         bool                     is_pipe;
>         bool                     is_dir;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 7c24ed768ff3..1fa12cc3294e 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -71,6 +71,13 @@ struct tpebs_event {
>         const char *name;
>         const char *tpebs_name;
>  };

A new line please.

> +struct tpebs_retire_lat {
> +       struct list_head nd;
> +       const char *name;
> +       const char *tpebs_name;

What are the 'name' and 'tpebs_name'?


> +       size_t count;
> +       int sum;
> +};
>
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>                                          struct evsel *evsel,
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b987960df3c5..2387c6289f93 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -111,6 +111,9 @@ struct perf_stat_config {
>         struct rblist            metric_events;
>         struct list_head         tpebs_events;
>         size_t                   tpebs_event_size;
> +       struct list_head         tpebs_results;
> +       pid_t                    tpebs_pid;
> +       int                      tpebs_pipe;

Did you use these?


>         int                      ctl_fd;
>         int                      ctl_fd_ack;
>         bool                     ctl_fd_close;
> --
> 2.43.0
>

