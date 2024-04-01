Return-Path: <linux-kernel+bounces-127062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F0894653
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580E11C219A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E654744;
	Mon,  1 Apr 2024 20:58:14 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB92A1BF;
	Mon,  1 Apr 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005094; cv=none; b=MwN8UR5gneLVBtd9REzIOdleYvx79jVUyqEGauNqolp/Y0IOUISezp2jfPrh8HzVTDRnkSD73L+M3GwpwDf9qXpMq7pPzEz0BBGq+W5fZtxUep9aYAGgxd1ktxjK2jlIId9DJXlTGALNsLh+Nxyi+CrGLxMRV0hDdC4bGSf5ETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005094; c=relaxed/simple;
	bh=LieaZ8TiiIawpuwbXnBCQVmEXCOcH5fEz/QU2NT5Z78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqEHRVn2n+J3Es0T1kqb4waDPcPeoiZ+XhPwPC+ezr53KxEbFoN7kmfDB2O6Hjt42lUB7/CWJG5IqtDi8QBLFdR7wuCj4jj8Z9AEgEUt8ysccZyzkASJPBDfgPGJHqv1OfbE3OdVpMP/tep++Jxesi7XWHP9cg7MdWZl+vqx+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a21330d093so2148852a91.2;
        Mon, 01 Apr 2024 13:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712005091; x=1712609891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5QDdwM7InleUh0H7F++7pvBogTcgwv2j+vsh4RiSvM=;
        b=R7TZGuTtn+AbV2wfd5KjFxeiQ+718XO6PLRjiFEfu6vvTtyUbac8MNpryrbpzOyCP0
         R1Rp+zmmpGGa+JXYZRg4cMiT1VM22EiLwHIOLqGXEXKcpBdrjMyIwOF+Q5bTgeoM2St3
         tvEuhCGvJqy6q/++JAp5N8panzJpxQFSr5U8ZrmptX7e2N61XYslOdKMp64n1WT+p7SW
         aHGAi+lpEjxazxhPJOtfJRECFm/JrmNc/0FsssxzquM+sCzGg0jbK8xOw8BgILjGDM7m
         5rtqtfpfEJPKZRrWaogkxyBebDZDzDaMiikTVYV7IoJmCyKJKAXZkuYPwFppX5iENTfV
         Jvcg==
X-Forwarded-Encrypted: i=1; AJvYcCVz8fHq++Glw8dIQhYwQFOk39BLVeZmCNzFyfXXeIvTwu/ods72snOjs7CyWsxtj1XJed92F/R6DjG/AOgT5CaZcgIWgfu3LBX/AYzkTp6KujIsa90rLoTB3/HGKRL5qHHTUpvoPM0HvTMrZIwueg==
X-Gm-Message-State: AOJu0Yx6SKcZarXTOBb3YxUC3/hL/V+to+kp5Zov0y/o1vowzSmyS0ne
	cfqrBtiBsUUrLDDStOCLJknerKh0e5H0bPoep9j50o4U/he0cnBmlMwk2aauidyKW0lm/uD0nRX
	DmrGkiFitU7M8AMBzqaBJpCwgE94=
X-Google-Smtp-Source: AGHT+IH0jvmL61/d8US9zUpcXOwVgiw5KN5dIHpvSv0tNham4inWlarU6BHg0TBHteElV+71dLOg8HBJb02S5vmtPbU=
X-Received: by 2002:a17:90b:2c85:b0:2a2:2e83:7a2b with SMTP id
 sw5-20020a17090b2c8500b002a22e837a2bmr6149091pjb.20.1712005091525; Mon, 01
 Apr 2024 13:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191224.1046866-1-weilin.wang@intel.com> <20240329191224.1046866-3-weilin.wang@intel.com>
In-Reply-To: <20240329191224.1046866-3-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 1 Apr 2024 13:58:00 -0700
Message-ID: <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
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

On Fri, Mar 29, 2024 at 12:12=E2=80=AFPM <weilin.wang@intel.com> wrote:
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
> Another thread is required to synchronize between perf stat and perf reco=
rd
> when we pass data through pipe.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 190 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/data.c        |   6 +-
>  tools/perf/util/metricgroup.h |   8 ++
>  tools/perf/util/stat.h        |   2 +
>  4 files changed, 203 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6291e1e24535..7fbe47b0c44c 100644
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
> @@ -684,15 +691,155 @@ static enum counter_recovery stat_handle_error(str=
uct evsel *counter)
>
>         if (child_pid !=3D -1)
>                 kill(child_pid, SIGTERM);
> +       if (stat_config.tpebs_pid !=3D -1)
> +               kill(stat_config.tpebs_pid, SIGTERM);
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
> +
> +       if (!stat_config.system_wide && !stat_config.user_requested_cpu_l=
ist) {
> +               pr_err("Require -a or -C option to run sampling.\n");
> +               return -ECANCELED;
> +       }
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

Still I think it's weird it has 'perf record' in perf stat (despite the
'perf stat record').  If it's only Intel thing and we don't have a plan
to do the same on other arches, we can move it to the arch
directory and keep the perf stat code simple.


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
> +       int ret;
> +
> +       record_argv =3D calloc(10 + 2 * stat_config.tpebs_event_size, siz=
eof(char *));
> +       if (!record_argv)
> +               return -1;
> +
> +       ret =3D __run_perf_record(record_argv);
> +       if (ret)
> +               return ret;
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
> +
> +       list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results, eve=
nt.nd) {
> +               list_del_init(&r->event.nd);
> +               free(r);
> +       }
> +       list_for_each_entry_safe(e, etmp, &stat_config.tpebs_events, nd) =
{
> +               list_del_init(&e->nd);
> +               free(e);

Shouldn't it free the names?


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
> +static void *__cmd_script(void *arg __maybe_unused)

The arg is used.

Also I don't like the name 'script' as it has nothing to do with
scripting.  Maybe 'sample_reader', 'tpebs_reader' or
'reader_thread'?


> +{
> +       struct child_process *cmd =3D arg;
> +       struct perf_session *session;
> +       struct perf_data data =3D {
> +               .mode =3D PERF_DATA_MODE_READ,
> +               .path =3D PERF_DATA,
> +               .file.fd =3D cmd->out,
> +       };
> +       struct perf_script script =3D {
> +               .tool =3D {
> +               .sample          =3D process_sample_event,
> +               .feature         =3D process_feature_event,
> +               .attr            =3D perf_event__process_attr,

Broken indentation.  And if you just use the tool, you can
pass it directly.


> +               },
> +       };
> +
> +       session =3D perf_session__new(&data, &script.tool);
> +       if (IS_ERR(session))
> +               return NULL;
> +       script.session =3D session;
> +       perf_session__process_events(session);
> +       perf_session__delete(session);
> +
> +       return NULL;
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>         int interval =3D stat_config.interval;
> @@ -709,15 +856,38 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>         struct affinity saved_affinity, *affinity =3D NULL;
>         int err;
>         bool second_pass =3D false;
> +       struct child_process cmd;
> +       pthread_t thread_script;
>
>         /* Prepare perf record for sampling event retire_latency before f=
ork and
>          * prepare workload */
>         if (stat_config.tpebs_event_size > 0) {
>                 int ret;
> +               struct tpebs_event *e;
>
> -               ret =3D __run_perf_record();
> +               pr_debug("perf stat pid =3D %d\n", getpid());
> +               list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> +                       struct tpebs_retire_lat *new =3D malloc(sizeof(st=
ruct tpebs_retire_lat));
> +
> +                       if (!new)
> +                               return -1;
> +                       new->event.name =3D strdup(e->name);
> +                       new->event.tpebs_name =3D strdup(e->tpebs_name);

These can fail too.


> +                       new->count =3D 0;
> +                       new->sum =3D 0;
> +                       list_add_tail(&new->event.nd, &stat_config.tpebs_=
results);
> +               }
> +               ret =3D prepare_perf_record(&cmd);
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

This won't guarantee anything.  If you want to make sure the
'thread_script' to run before the 'perf record' process, you can
use a pipe to signal that like in evlist__prepare_workload() and
evlist__start_workload().


>         }
>
>         if (forks) {
> @@ -925,6 +1095,17 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
>
>         t1 =3D rdclock();
>
> +       if (stat_config.tpebs_event_size > 0) {
> +               int ret;
> +
> +               kill(cmd.pid, SIGTERM);
> +               pthread_join(thread_script, NULL);
> +               close(cmd.out);
> +               ret =3D finish_command(&cmd);
> +               if (ret !=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> +                       return ret;
> +       }
> +
>         if (stat_config.walltime_run_table)
>                 stat_config.walltime_run[run_idx] =3D t1 - t0;
>
> @@ -1032,6 +1213,9 @@ static void sig_atexit(void)
>         if (child_pid !=3D -1)
>                 kill(child_pid, SIGTERM);
>
> +       if (stat_config.tpebs_pid !=3D -1)
> +               kill(stat_config.tpebs_pid, SIGTERM);
> +
>         sigprocmask(SIG_SETMASK, &oset, NULL);
>
>         if (signr =3D=3D -1)
> @@ -2972,5 +3156,7 @@ int cmd_stat(int argc, const char **argv)
>         metricgroup__rblist_exit(&stat_config.metric_events);
>         evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack,=
 &stat_config.ctl_fd_close);
>
> +       tpebs_data__delete();
> +
>         return status;
>  }
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 08c4bfbd817f..98e3014c0aef 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -204,7 +204,11 @@ static bool check_pipe(struct perf_data *data)
>                                 data->file.fd =3D fd;
>                                 data->use_stdio =3D false;
>                         }
> -               } else {
> +               /*
> +                * When is_pipe and data->file.fd is given, use given fd
> +                * instead of STDIN_FILENO or STDOUT_FILENO
> +                */
> +               } else if (data->file.fd <=3D 0) {
>                         data->file.fd =3D fd;
>                 }
>         }

I think this can be in a separate commit.


> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 7c24ed768ff3..ae788edef30f 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -68,10 +68,18 @@ struct metric_expr {
>
>  struct tpebs_event {
>         struct list_head nd;
> +       /* Event name */
>         const char *name;
> +       /* Event name with the TPEBS modifier R */
>         const char *tpebs_name;
>  };
>
> +struct tpebs_retire_lat {
> +       struct tpebs_event event;
> +       size_t count;
> +       int sum;
> +};

Actually I don't know why you need this separate structure.
Can we just use tpebs_event?

Thanks,
Namhyung


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

