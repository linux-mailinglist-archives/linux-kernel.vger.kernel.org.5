Return-Path: <linux-kernel+bounces-77859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD0860B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8D22853E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676D9134B7;
	Fri, 23 Feb 2024 07:03:45 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B214ABC;
	Fri, 23 Feb 2024 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671824; cv=none; b=gTOo8gS36KakBaj5ca1ywQ2LpdkBd3eLJsXYFRWhdQHtbAnPGLO7F8cBSduZ9dBTKCsfMCSJlinik1M9liu+cwX892sPKcsp0lHbWmNw+jqdxT0BiGIgFQXGAaVFh4CGus+rRwKnJesClZeycwIghgLKsJfkkI8+HY6f4PDr038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671824; c=relaxed/simple;
	bh=DvidK+BwA4XC7j1b3ErnjAMJ41R3Y2kSDLAtltxl2n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u41mWyPoou/PG15kWtBjRHJlRQyNgDy1nLQ1AfJQyVAOFhMrHFl/0fStrFswQsT3T/vKAMRLtbO7uY7Uab5Bx5uIu+Yd9dZiGixnhax9mjNxmiOaoO9c8C0paafh+2xmO7nbXIr2WMpcwsR8h6kcsxuG/wVH2yot2d2mh5J+SG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d71cb97937so6404945ad.3;
        Thu, 22 Feb 2024 23:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708671822; x=1709276622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+RtyEjqjLSZcCJR7b/S+5MN0v+3X08UVKwBPdQrpbg=;
        b=LDI/dwmTIM5k9nJMpB6pNFv7NYvBl0ckFHvRyHNCY9pPWpOD2xekIx2bzjShgapraO
         izHamOAPYaWU2QLXUyC8KaPTq53VwgOEK8xQwcE8kscesxxTTS05c5fkylKzIKRE4TXG
         D2egDfaduzw2kkBQwDTbsZGUYkTHO9LR4oWDkCfxIRhSg3QbWxhv6BrV2SJIfqdF7EaH
         2pmI84dXboTMYghzs9fbeWC8OTHsVm1rQ/Y5DCcaIG+zxpxCxL+aIQji/wy4MZTsoBHM
         /gxVGtEhTBNbPDPVgQkaSSSvFzgh9VfxPFGpIukQPHhF8uJ7I/hSm6b38Xy/GQoe0zfz
         Cw5g==
X-Forwarded-Encrypted: i=1; AJvYcCVvogVXRmeatm47h93OCxZYhSpuAA345amq8fpdD2mE+Q2gz5elVTsbsmhy0IDqSM82tlRuo7Ip+1RNn3alOBJYeVySnM/5vtjThLdm7IWyIoRlEezccR3AdUrkv2q3UL6KHaCUTWf1kGJO8dYTBw==
X-Gm-Message-State: AOJu0YxGUgEeeJtFWsWajAvlyWb3UGS7l99VJ7VPFYvkvo/U3xGzPK9R
	5BPSlg2uMtjEUHO8v5DPKr/hlgXcEdE9XVuWE4HKFo5NRiqMTbt5g8N+h+VfVInOR9tJbSDBi25
	QkA86Qnajq22Th7oYTrK5X74PsX4=
X-Google-Smtp-Source: AGHT+IHvcYqh8Vgf+udRu/l9WdtX7y3TioaZt757n2bImqSl4oeV3YGutpPCj1n7CvDcLIOck4zfS6+LJ2apfh3Jh2s=
X-Received: by 2002:a17:90a:5206:b0:299:36dd:15d3 with SMTP id
 v6-20020a17090a520600b0029936dd15d3mr824087pjh.27.1708671821816; Thu, 22 Feb
 2024 23:03:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221072100.412939-1-weilin.wang@intel.com>
 <20240221072100.412939-3-weilin.wang@intel.com> <ZdY4a5yx-C9ziobq@x1> <CAP-5=fU5JVki4OCYvYyPoBLguwHSwXripiO3Gq+MddV9ZWfnTQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU5JVki4OCYvYyPoBLguwHSwXripiO3Gq+MddV9ZWfnTQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 22 Feb 2024 23:03:30 -0800
Message-ID: <CAM9d7ch3E=hNbX6=xUHZ+B_Dphy_sALzaCki1he3-O00DAoYXg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, weilin.wang@intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2024 at 12:34=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Feb 21, 2024 at 02:20:56AM -0500, weilin.wang@intel.com wrote:
> > > From: Weilin Wang <weilin.wang@intel.com>
> >
> > You wrote no description for this patch, please add one and show
> > examples of the feature being used, if possible.
> >
> > See below for more comments.
> >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > +static int __cmd_script(struct child_process *cmd __maybe_unused)
> > > +{
> > > +     int err =3D 0;
> > > +     struct perf_session *session;
> > > +     struct perf_data data =3D {
> > > +             .mode =3D PERF_DATA_MODE_READ,
> > > +             .path =3D PERF_DATA,
> > > +             .fd   =3D cmd->out,
> > > +     };
> > > +     struct perf_script script =3D {
> > > +             .tool =3D {
> > > +             .sample          =3D process_sample_event,
> > > +             .ordered_events  =3D true,
> > > +             .ordering_requires_timestamps =3D true,
> > > +             .feature         =3D process_feature_event,
> > > +             .attr            =3D perf_event__process_attr,
> > > +             },
> > > +     };
> > > +     struct tpebs_event *e;
> > > +
> > > +     list_for_each_entry(e, &stat_config.tpebs_events, nd) {
> > > +             struct tpebs_retire_lat *new =3D malloc(sizeof(struct t=
pebs_retire_lat));
> > > +
> > > +             if (!new)
> > > +                     return -1;
> > > +             new->name =3D strdup(e->name);
> > > +             new->tpebs_name =3D strdup(e->tpebs_name);
> > > +             new->count =3D 0;
> > > +             new->sum =3D 0;
> >
> > Without even having thought that much about this overall architecture,
> > that looks too heavy at first sight, the above is done in tools/perf/
> > as:
> >
> > void tpebs_retire_lat__delete(struct tpebs_retire_lat *retire_lat)
> > {
> >         if (retire_lat =3D=3D NULL)
> >                 return;
> >
> >         zfree(&retire_lat->tpebs_name);
> >         zfree(&retire_lat->tpebs_name);
> > }
> >
> > struct tpebs_retire_lat__new(tpebs_event *e)
> > {
> >         struct tpebs_retire_lat *retire_lat =3D zalloc(sizeof(*retire_l=
at));
> >
> >         if (retire_lat !=3D NULL) {
> >                 retire_lat->name =3D strdup(e->name);
> >                 retire_lat->tpebs_name =3D strdup(e->tpebs_name);
> >
> >                 if (retire_lat->name =3D=3D NULL || retire_lat->tpebs_n=
ame =3D=3D NULL) {
> >                         tpebs_retire_lat__delete(retire_lat);
> >                         retire_lat =3D NULL;
> >                 }
> >         }
> >
> >         return retire_lat;
> > }
> >
> > And then you call the constructor  in that loop, and the destructor at
> > some point when those data structures are not needed.
> >
> > We do it because perf has a TUI mode and we may end up calling tools
> > from them in a long running session, so we need to avoid leaks.
> >
> > Also can we somehow hide Intel specific terms in arch specific files
> > while leaving something generic, possibly implementable in other arches
> > in the core code? I mean hiding clearly intel specific stuff like the
> > "tpebs" term in tools/perf/arch/x86/.
>
> Thanks Arnaldo, TPEBS support is necessary to support TMA metrics 4.7
> on meteorlake. The timed values replace hard coded constants that
> assume worst case latencies. You can see the metrics here:
> https://github.com/intel/perfmon/blob/main/TMA_Metrics-full.csv
> in the MTL (meteorlake) column row 29 there is:
> MEM_INST_RETIRED.STLB_HIT_LOADS*min($PEBS, #Mem_STLB_Hit_Cost) / CLKS
> + Load_STLB_Miss
> where the $PEBS is supposed to be replaced with the latency from a
> sample of MEM_INST_RETIRED.STLB_HIT_LOADS. There are meteorlake
> machines shipping but currently there are no perf metrics.
>
> Weilin raised the TPEBS problem in the LPC 2023 talk, the issue being
> that sampling and counting don't really exist in the current perf tool
> code at the same time. BPF could be a workaround but permissions are
> an issue. Perhaps leader sampling but then what to do if two latencies
> are needed. Forking perf to do this is an expedient and ideally we'd
> not do it.

Even with BPF, I think it needs two instances of an event - one for
counting and the other for sampling, right?  I wonder if it can just
use a single event for sampling and show the sum of periods in
PERF_SAMPLE_READ.

I'm not sure if an event group can have sampling and non-sampling
events at the same time.  But it can be done without groups then.
Anyway what's the issue with two latencies?

Thanks,
Namhyung

>
> I'm against stuff going in the arch directory in general. If something
> is specific to a PMU, let's special case the logic for that PMU in the
> tool. The arch directory gets us into messes like:
> https://lore.kernel.org/lkml/CAP-5=3DfVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTf=
HbQsKXb_g@mail.gmail.com/
> Where a heterogenous/hybrid/big.little fix is in the x86 arch folder
> (overriding a weak symbol) but not in the arm or other ones leading to
> an arm bug.
>
> I think the idea of a count coming from an external or tool source is
> something of a more generic concept. I think what Weilin is doing here
> is setting the groundwork for doing that, a first implementation. I'd
> like the expr literals, like #smt_on, #num_cpus, etc. to be more like
> tool events such as duration_time. I think we can move in the
> direction that Weilin is adding here and then iterate to clean up
> these things, hopefully move them to events that then other tools
> could use, etc.
>
> Thanks,
> Ian
>
>
>
>
> > > +             list_add_tail(&new->nd, &stat_config.tpebs_results);
> > > +     }
> > > +
> > > +     kill(cmd->pid, SIGTERM);
> > > +     session =3D perf_session__new(&data, &script.tool);
> > > +     if (IS_ERR(session))
> > > +             return PTR_ERR(session);
> > > +     script.session =3D session;
> > > +     err =3D perf_session__process_events(session);
> > > +     perf_session__delete(session);
> > > +
> > > +     return err;
> > > +}
> > > +
> > >  static int __run_perf_stat(int argc, const char **argv, int run_idx)
> > >  {
> > >       int interval =3D stat_config.interval;
> > > @@ -709,12 +866,14 @@ static int __run_perf_stat(int argc, const char=
 **argv, int run_idx)
> > >       struct affinity saved_affinity, *affinity =3D NULL;
> > >       int err;
> > >       bool second_pass =3D false;
> > > +     struct child_process cmd;
> > >
> > >       //Prepare perf record for sampling event retire_latency before =
fork and prepare workload
> > >       if (stat_config.tpebs_event_size > 0) {
> > >               int ret;
> > >
> > > -             ret =3D __run_perf_record();
> > > +             pr_debug("perf stat pid =3D %d\n", getpid());
> > > +             ret =3D prepare_perf_record(&cmd);
> > >               if (ret)
> > >                       return ret;
> > >       }
> > > @@ -924,6 +1083,17 @@ static int __run_perf_stat(int argc, const char=
 **argv, int run_idx)
> > >
> > >       t1 =3D rdclock();
> > >
> > > +     if (stat_config.tpebs_event_size > 0) {
> > > +             int ret;
> > > +
> > > +             pr_debug("pid =3D %d\n", getpid());
> > > +             pr_debug("cmd.pid =3D %d\n", cmd.pid);
> > > +
> > > +             ret =3D __cmd_script(&cmd);
> > > +             close(cmd.out);
> > > +             pr_debug("%d\n", ret);
> > > +     }
> > > +
> > >       if (stat_config.walltime_run_table)
> > >               stat_config.walltime_run[run_idx] =3D t1 - t0;
> > >
> > > @@ -2714,6 +2884,7 @@ int cmd_stat(int argc, const char **argv)
> > >       }
> > >
> > >       INIT_LIST_HEAD(&stat_config.tpebs_events);
> > > +     INIT_LIST_HEAD(&stat_config.tpebs_results);
> > >
> > >       /*
> > >        * Metric parsing needs to be delayed as metrics may optimize e=
vents
> > > @@ -2921,5 +3092,7 @@ int cmd_stat(int argc, const char **argv)
> > >       metricgroup__rblist_exit(&stat_config.metric_events);
> > >       evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ac=
k, &stat_config.ctl_fd_close);
> > >
> > > +     tpebs_data__delete();
> > > +
> > >       return status;
> > >  }
> > > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > > index fc16299c915f..2298ca3b370b 100644
> > > --- a/tools/perf/util/data.c
> > > +++ b/tools/perf/util/data.c
> > > @@ -173,6 +173,10 @@ static bool check_pipe(struct perf_data *data)
> > >       int fd =3D perf_data__is_read(data) ?
> > >                STDIN_FILENO : STDOUT_FILENO;
> > >
> > > +     if (data->fd > 0) {
> > > +             fd =3D data->fd;
> > > +     }
> > > +
> > >       if (!data->path) {
> > >               if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
> > >                       is_pipe =3D true;
> > > diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> > > index effcc195d7e9..5554d46ad212 100644
> > > --- a/tools/perf/util/data.h
> > > +++ b/tools/perf/util/data.h
> > > @@ -28,6 +28,7 @@ struct perf_data_file {
> > >
> > >  struct perf_data {
> > >       const char              *path;
> > > +     int                      fd;
> > >       struct perf_data_file    file;
> > >       bool                     is_pipe;
> > >       bool                     is_dir;
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgr=
oup.c
> > > index 6c16e5a0b1fc..8518e2b3e5be 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -691,8 +691,17 @@ static int metricgroup__build_event_string(struc=
t strbuf *events,
> > >
> > >               if (p) {
> > >                       struct tpebs_event *new_event =3D malloc(sizeof=
(struct tpebs_event));
> > > -                     *p =3D '\0';
> > > +                     char *name;
> > > +
> > >                       new_event->tpebs_name =3D strdup(id);
> > > +                     *p =3D '\0';
> > > +                     name =3D malloc(strlen(id) + 2);
> > > +                     if (!name)
> > > +                             return -ENOMEM;
> > > +
> > > +                     strcpy(name, id);
> > > +                     strcat(name, ":p");
> > > +                     new_event->name =3D name;
> >
> > For such cases we use asprintf(), that allocates and formats the string
> > in one call, look for examples in other tools/perf/ files.
> >
> > >                       *tpebs_event_size +=3D 1;
> > >                       pr_debug("retire_latency required, tpebs_event_=
size=3D%lu, new_event=3D%s\n",
> > >                       *tpebs_event_size, new_event->name);
> > > diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgr=
oup.h
> > > index 7c24ed768ff3..1fa12cc3294e 100644
> > > --- a/tools/perf/util/metricgroup.h
> > > +++ b/tools/perf/util/metricgroup.h
> > > @@ -71,6 +71,13 @@ struct tpebs_event {
> > >       const char *name;
> > >       const char *tpebs_name;
> > >  };
> > > +struct tpebs_retire_lat {
> > > +     struct list_head nd;
> > > +     const char *name;
> > > +     const char *tpebs_name;
> > > +     size_t count;
> > > +     int sum;
> > > +};
> >
> > Here you declare the constructor and destructor I suggested above.
> >
> > >  struct metric_event *metricgroup__lookup(struct rblist *metric_event=
s,
> > >                                        struct evsel *evsel,
> > > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > > index 9d0186316b29..8e180f13aa2d 100644
> > > --- a/tools/perf/util/stat.h
> > > +++ b/tools/perf/util/stat.h
> > > @@ -111,6 +111,9 @@ struct perf_stat_config {
> > >       struct rblist            metric_events;
> > >       struct list_head         tpebs_events;
> > >       size_t                   tpebs_event_size;
> > > +     struct list_head         tpebs_results;
> > > +     pid_t                    tpebs_pid;
> > > +     int                      tpebs_pipe;
> > >       int                      ctl_fd;
> > >       int                      ctl_fd_ack;
> > >       bool                     ctl_fd_close;
> > > --
> > > 2.43.0
> > >

