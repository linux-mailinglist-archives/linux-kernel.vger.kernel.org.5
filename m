Return-Path: <linux-kernel+bounces-124205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393938913DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6B1C23E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9B3B796;
	Fri, 29 Mar 2024 06:43:37 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8DB38394;
	Fri, 29 Mar 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694616; cv=none; b=UJ5QUw1fKsiXjJVBFpIZ0TNWoYGUAel+sNW3PElRVAMEwLbeMH6oBkRo/N/Q8fozzLqkM7JCEN++sc38KZkisN8e6sytiWON7Jw9yn9ld2GAADwOnMe8cstPoc5hDLvnjbS9bCxnQEeEU+dJoYydIp4G0ud1EwmOCsBUEPbbxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694616; c=relaxed/simple;
	bh=nTe2ae6ryb7DMVdUv6s28IYex7zFMHWWM7DT8kpyr5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpERPrChgX76uU9XEdFpn17oSZMBIbOJkQTfyr6m5DI8aEoRI2C0B8u9E14liGKG+p397Fw+0GwaaF87BqLXk/uw2e2fQlybOOlrAzwHxm52uqlzpFzDO+e7LvPmRgoPdYHGRa6KOQbFaN5yPifF1c9TnQKRqZ3ynAOhNY1EghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso1949634b3a.0;
        Thu, 28 Mar 2024 23:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711694614; x=1712299414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0iqtjLTn3RtrA+1pAaR6jp/a2hnomPjHFJffryilm8=;
        b=L4zyxgTRmcrO5KyQmmPbhjZdXoeDfVe03PBny4WNaKb8gRdvS+8sv9iaHFexvrVCot
         97sNZKEsn8OFlOMiIGapLuIGWvqe+tau8mJmXQsbTu1RKFQObZP/Fwe+3ObMcZdT7NY8
         oivSxWtef3NHyqFS+J+qzqvJoEoeCvOF8YSYsuOX3uSs5KjbdBj2fS4vyOGItdnRr5un
         wUVpnfXfAT//jxgDozAGFRLPgYzAh5H6tAJMz1hh3Ro5eKW23mO7Dr4RaV3XkFXODaCz
         cFVBMM4oeF/3Q8kvfNcFPeAKT9W+mIIukB3rEP6OkFUO+Lkuim6sAXMzYjk3x7OAPfEA
         kJrw==
X-Forwarded-Encrypted: i=1; AJvYcCVIOYTS8HIvqF7KJM3TFuIxWa77C9B2mMLwz6EBAFM2N0E4/7pe0urkkCsICIoFbAiyKXXor0xste/EFFCF43WKRLrtogUQ3KnTeK3LQQlYucFocbBtKeFRWLH9n33WA0emF2yEV6Xan+5xpDZFZg==
X-Gm-Message-State: AOJu0YxgiswRpYd7moAyxfZE3yAqCri0I48oS6lSYkm7dvWC+Vx9/b4W
	5wmxw++m71aWQR0ljSk/Ol28aNT2Of4OMXiF1VTzzJOMBOR3JnZ4kqyUHkAmYuN+Y8v3ZBPKfqY
	4E4HDyLlTsBhCFRN2tl5S51BHekA=
X-Google-Smtp-Source: AGHT+IF4I7IO3pD0s7VxjxLAp6lM/NN2SlFgntjpDZ1QPPemBTANT5Jwx4Axli2JsWrKlYXZUIt8BJ+QZi86znLCeRU=
X-Received: by 2002:a05:6a20:be18:b0:1a3:5fb7:42ab with SMTP id
 ge24-20020a056a20be1800b001a35fb742abmr1146154pzb.59.1711694614501; Thu, 28
 Mar 2024 23:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326202859.960577-1-weilin.wang@intel.com> <20240326202859.960577-3-weilin.wang@intel.com>
In-Reply-To: <20240326202859.960577-3-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 28 Mar 2024 23:43:22 -0700
Message-ID: <CAM9d7cjXE_XgZAGnr9byL17KbgKrum+kyozR5yTVkKvcUd8wow@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
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

I'm afraid this requirement is too Intel specific.  Maybe we need to move
the code to somewhere under the arch directory.

>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 165 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/data.c        |   3 +
>  tools/perf/util/data.h        |   5 ++
>  tools/perf/util/metricgroup.h |   8 ++
>  tools/perf/util/stat.h        |   2 +
>  5 files changed, 181 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6291e1e24535..fb08cef42d95 100644
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
> @@ -163,6 +168,8 @@ static struct perf_stat_config stat_config =3D {
>         .ctl_fd_ack             =3D -1,
>         .iostat_run             =3D false,
>         .tpebs_events           =3D LIST_HEAD_INIT(stat_config.tpebs_even=
ts),
> +       .tpebs_results          =3D LIST_HEAD_INIT(stat_config.tpebs_resu=
lts),
> +       .tpebs_pid              =3D -1,
>  };
>
>  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> @@ -687,12 +694,155 @@ static enum counter_recovery stat_handle_error(str=
uct evsel *counter)
>         return COUNTER_FATAL;
>  }
>
> -static int __run_perf_record(void)
> +static int __run_perf_record(const char **record_argv)
>  {
> +       int i =3D 0;
> +       struct tpebs_event *e;
> +
>         pr_debug("Prepare perf record for retire_latency\n");
> +
> +       record_argv[i++] =3D "perf";
> +       record_argv[i++] =3D "record";
> +       record_argv[i++] =3D "-W";
> +       record_argv[i++] =3D "--synth=3Dno";
> +
> +       if (stat_config.user_requested_cpu_list) {
> +               record_argv[i++] =3D "-C";
> +               record_argv[i++] =3D stat_config.user_requested_cpu_list;
> +       }
> +
> +       if (stat_config.system_wide)
> +               record_argv[i++] =3D "-a";

What do you want to do if neither of -a nor -C is used?
Maybe you can disable perf record in background.

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
> +
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
> +};
> +
> +static void tpebs_data__delete(void)
> +{
> +       struct tpebs_retire_lat *r, *rtmp;
> +       struct tpebs_event *e, *etmp;

A blank line please.

> +       list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results, eve=
nt.nd) {
> +               list_del_init(&r->event.nd);
> +               free(r);
> +       }
> +       list_for_each_entry_safe(e, etmp, &stat_config.tpebs_events, nd) =
{
> +               list_del_init(&e->nd);
> +               free(e);
> +       }
> +}
> +
> +static int process_sample_event(struct perf_tool *tool __maybe_unused,
> +                               union perf_event *event __maybe_unused,
> +                               struct perf_sample *sample,
> +                               struct evsel *evsel,
> +                               struct machine *machine __maybe_unused)
> +{
> +       int ret =3D 0;
> +       const char *evname;
> +       struct tpebs_retire_lat *t;
> +
> +       evname =3D evsel__name(evsel);
> +
> +       /*
> +        * Need to handle per core results? We are assuming average retir=
e
> +        * latency value will be used. Save the number of samples and the=
 sum of
> +        * retire latency value for each event.
> +        */
> +       list_for_each_entry(t, &stat_config.tpebs_results, event.nd) {
> +               if (!strcmp(evname, t->event.name)) {
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
> +       return 0;
> +}
> +
> +static int __cmd_script(struct child_process *cmd __maybe_unused)
> +{
> +       int err =3D 0;
> +       struct perf_session *session;
> +       struct perf_data data =3D {
> +               .mode =3D PERF_DATA_MODE_READ,
> +               .path =3D PERF_DATA,
> +               .fd   =3D cmd->out,

I don't like this part as it added the fd field unnecessarily.
I think we need a new session API that can pass a fd directly.


> +       };
> +       struct perf_script script =3D {
> +               .tool =3D {
> +               .sample          =3D process_sample_event,
> +               .ordering_requires_timestamps =3D true,

Is this really needed?  I don't think it needs ordering.


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
> +               new->event.name =3D strdup(e->name);
> +               new->event.tpebs_name =3D strdup(e->tpebs_name);
> +               new->count =3D 0;
> +               new->sum =3D 0;
> +               list_add_tail(&new->event.nd, &stat_config.tpebs_results)=
;
> +       }
> +
> +       kill(cmd->pid, SIGTERM);

Is this the only place to stop the perf record?
What if perf stat exits before calling this function?


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
> @@ -709,13 +859,15 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>         struct affinity saved_affinity, *affinity =3D NULL;
>         int err;
>         bool second_pass =3D false;
> +       struct child_process cmd;
>
>         /* Prepare perf record for sampling event retire_latency before f=
ork and
>          * prepare workload */
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
>
> -               ret =3D __run_perf_record();
> +               pr_debug("perf stat pid =3D %d\n", getpid());
> +               ret =3D prepare_perf_record(&cmd);
>                 if (ret)
>                         return ret;
>         }
> @@ -925,6 +1077,13 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>
>         t1 =3D rdclock();
>
> +       if (stat_config.tpebs_event_size > 0) {
> +               int ret;
> +
> +               ret =3D __cmd_script(&cmd);
> +               close(cmd.out);
> +       }
> +
>         if (stat_config.walltime_run_table)
>                 stat_config.walltime_run[run_idx] =3D t1 - t0;
>
> @@ -2972,5 +3131,7 @@ int cmd_stat(int argc, const char **argv)
>         metricgroup__rblist_exit(&stat_config.metric_events);
>         evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack,=
 &stat_config.ctl_fd_close);
>
> +       tpebs_data__delete();
> +
>         return status;
>  }
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 08c4bfbd817f..f6cc0ccdec5e 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -185,6 +185,9 @@ static bool check_pipe(struct perf_data *data)
>         int fd =3D perf_data__is_read(data) ?
>                  STDIN_FILENO : STDOUT_FILENO;
>
> +       if (data->fd > 0)
> +               fd =3D data->fd;
> +
>         if (!data->path) {
>                 if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
>                         is_pipe =3D true;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 110f3ebde30f..f5e7479f1892 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -28,6 +28,11 @@ struct perf_data_file {
>
>  struct perf_data {
>         const char              *path;
> +       /*
> +        * When fd is given, use PIPE instead of file, use given fd inste=
ad of
> +        * STDIN_FILENO or STDOUT_FILENO
> +        */
> +       int                      fd;

Maybe users can set data.file.fd directly instead of this.


>         struct perf_data_file    file;
>         bool                     is_pipe;
>         bool                     is_dir;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 7c24ed768ff3..e5bafb45d4d9 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -68,10 +68,18 @@ struct metric_expr {
>
>  struct tpebs_event {
>         struct list_head nd;
> +       /* Event name */
>         const char *name;
> +       /* Event name with TPEBS modifier */

What is the TPEBS modifier?

Thanks,
Namhyung


>         const char *tpebs_name;
>  };
>
> +struct tpebs_retire_lat {
> +       struct tpebs_event event;
> +       size_t count;
> +       int sum;
> +};
> +
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>                                          struct evsel *evsel,
>                                          bool create);
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b987960df3c5..0726bdc06681 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -111,6 +111,8 @@ struct perf_stat_config {
>         struct rblist            metric_events;
>         struct list_head         tpebs_events;
>         size_t                   tpebs_event_size;
> +       struct list_head         tpebs_results;
> +       pid_t                    tpebs_pid;
>         int                      ctl_fd;
>         int                      ctl_fd_ack;
>         bool                     ctl_fd_close;
> --
> 2.43.0
>

