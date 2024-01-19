Return-Path: <linux-kernel+bounces-31585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD28833063
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D1C1C21F27
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720158220;
	Fri, 19 Jan 2024 21:40:19 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758E1E496;
	Fri, 19 Jan 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700419; cv=none; b=aw+Q8Lv3XzcZWC6jrZ8y2hV0zf7EYCeJWx33ljIz1LaOk9NwA7nXk2y6KGqeg2NXQs8jlsRs2dReoniDWCtMh6OiWTspYC+4ovCxU9lVa7h19mkBHiBp7yntNWG3swjde4uCea9ZWoeKbAnhoiGHMGo2R8UbbAsfo0UgY1WlZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700419; c=relaxed/simple;
	bh=uNUSXNpYaItWC5iFLY7EK10PVTGsO6WjQHBzgLrcy6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Omer2KzIrFaZ30tCEIbo5CFkpjwGTOCdX9CljupXvErlCBfq0qi1ARy6FepfdX3KKVwbYW2RyUZSGlzOTbA4aUATy+Igl1Zhz8DM6cTmxwLxxeb0h2hDb7x8HAveBrzwdrCKbmNuSFSovxN9hl1QdXarGnCCUSZ4ihifBFTOdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28e79182570so1059029a91.2;
        Fri, 19 Jan 2024 13:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700416; x=1706305216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6ZGa/G/jGiLfPyVtD58HdqVfn/aBlCaD/X9Ih8+Bro=;
        b=UKIpRF8F4EBs05CJBkrviiQRF4iSexlWo0ieDlyvl0otoYR7jveF8oCAVWXyclLMeE
         Ubq+/OCGl3yY1gzL4h4aDUQ/Ujg6nXpXErKEEqmB7GEmpO2Q0r9JTg4qSsn4+K5ZeFKv
         lB5y0/2XmvbZYiBJt2pcQHUoPjp6XTv6f+oHanUwjsvu0ZEekqlJuSltrqZ+MCLoF1ZY
         az5uhvuWTDNV5CgSaSclNsWqvxUQPOsg+hAQq4vWx1vXzo70fV+OvwIfVrCw6EoSzqSl
         K75Ta2fuYlqmIfhKUrgdbXfw9WcRcyVKc6mBocuAwN0bVn44RbRXuXPHpOjRuQjpUJ7j
         qEcw==
X-Gm-Message-State: AOJu0Yy164r7ZxT73O7PW2YpV/rszBywbhIPd4F87anSr5taCXN7SeRM
	kQYfMhQBrkrtpCu+j0WkShbL8RkdH/6XTBsHP6u8GyH2hu4SUdXKOwwlh4N9tHU+U2v5Thhjz68
	0CB9yRPmSQxWwPpNi6J/toFtmk+6MW1As9hg=
X-Google-Smtp-Source: AGHT+IFnNknOk8vDAZuMhIdXFM9por47a3RoaavW703Gn/4qldh/yX0Q5SXKueWrMtAg7jMNIJjlrMQQgIyo4kyISuA=
X-Received: by 2002:a17:90a:4984:b0:28e:89d2:87ba with SMTP id
 d4-20020a17090a498400b0028e89d287bamr359817pjh.12.1705700416553; Fri, 19 Jan
 2024 13:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111081914.3123-1-adrian.hunter@intel.com> <20240111081914.3123-2-adrian.hunter@intel.com>
In-Reply-To: <20240111081914.3123-2-adrian.hunter@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jan 2024 13:40:05 -0800
Message-ID: <CAM9d7cjOVuMdBjLBV0cKXAOMmp_6xQYBG7h2ecE=djEKZm8aNQ@mail.gmail.com>
Subject: Re: [PATCH V4 01/11] perf/core: Add aux_pause, aux_resume, aux_start_paused
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 12:19=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
com> wrote:
>
> Hardware traces, such as instruction traces, can produce a vast amount of
> trace data, so being able to reduce tracing to more specific circumstance=
s
> can be useful.
>
> The ability to pause or resume tracing when another event happens, can do
> that.
>
> Add ability for an event to "pause" or "resume" AUX area tracing.
>
> Add aux_pause bit to perf_event_attr to indicate that, if the event
> happens, the associated AUX area tracing should be paused. Ditto
> aux_resume. Do not allow aux_pause and aux_resume to be set together.
>
> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
> event that it should start in a "paused" state.
>
> Add aux_paused to struct perf_event for AUX area events to keep track of
> the "paused" state. aux_paused is initialized to aux_start_paused.
>
> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
> callbacks. Call as needed, during __perf_event_output(). Add
> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
> handler. Pause/resume in NMI context will miss out if it coincides with
> another pause/resume.
>
> To use aux_pause or aux_resume, an event must be in a group with the AUX
> area event as the group leader.
>
> Example (requires Intel PT and tools patches also):
>
>  $ perf record --kcore -e intel_pt/aux-action=3Dstart-paused/k,syscalls:s=
ys_enter_newuname/aux-action=3Dresume/,syscalls:sys_exit_newuname/aux-actio=
n=3Dpause/ uname
>  Linux
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.043 MB perf.data ]
>  $ perf script --call-trace
>  uname   30805 [000] 24001.058782799: name: 0x7ffc9c1865b0
>  uname   30805 [000] 24001.058784424:  psb offs: 0
>  uname   30805 [000] 24001.058784424:  cbr: 39 freq: 3904 MHz (139%)
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        debug_sm=
p_processor_id
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        __x64_sy=
s_newuname
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            down=
_read
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                =
__cond_resched
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                =
preempt_count_add
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                =
    in_lock_functions
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                =
preempt_count_sub
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            up_r=
ead
>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                =
preempt_count_add
>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                =
    in_lock_functions
>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                =
preempt_count_sub
>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            _cop=
y_to_user
>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])        syscall_=
exit_to_user_mode
>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            sysc=
all_exit_work
>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                =
perf_syscall_exit
>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                =
    debug_smp_processor_id
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
    perf_trace_buf_alloc
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
        perf_swevent_get_recursion_context
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
            debug_smp_processor_id
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
        debug_smp_processor_id
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
    perf_tp_event
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
        perf_trace_buf_update
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
            tracing_gen_ctx_irq_test
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
        perf_swevent_event
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
            __perf_event_account_interrupt
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
                __this_cpu_preempt_check
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
            perf_event_output_forward
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
                perf_event_aux_pause
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
                    ring_buffer_get
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
                        __rcu_read_lock
>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                =
                        __rcu_read_unlock
>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                =
                    pt_event_stop
>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                =
                        debug_smp_processor_id
>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                =
                        debug_smp_processor_id
>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                =
                        native_write_msr
>  uname   30805 [000] 24001.058785463: ([kernel.kallsyms])                =
                        native_write_msr
>  uname   30805 [000] 24001.058785639: 0x0

Looks great!  I think this is very similar to what Kees asked in

  https://lore.kernel.org/linux-perf-users/202401091452.B73E21B6C@keescook/

I have a couple of basic questions:
 * Can we do that for regular events too?
 * What's the difference between start/stop and pause/resume?
   (IOW can we do that just using start/stop callbacks?)

Actually I was thinking about dropping samples using a BPF filter
outside the target scope (e.g. a syscall) but it'd be nice if we can
have builtin support for that.

Thanks,
Namhyung

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
>
> Changes in V4:
>         Rename aux_output_cfg -> aux_action
>         Reorder aux_action bits from:
>                 aux_pause, aux_resume, aux_start_paused
>         to:
>                 aux_start_paused, aux_pause, aux_resume
>         Fix aux_action bits __u64 -> __u32
>
>
>  include/linux/perf_event.h      | 15 +++++++
>  include/uapi/linux/perf_event.h | 11 ++++-
>  kernel/events/core.c            | 72 +++++++++++++++++++++++++++++++--
>  kernel/events/internal.h        |  1 +
>  4 files changed, 95 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 5547ba68e6e4..342879168269 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -291,6 +291,7 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_NO_EXCLUDE                        0x0040
>  #define PERF_PMU_CAP_AUX_OUTPUT                        0x0080
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE          0x0100
> +#define PERF_PMU_CAP_AUX_PAUSE                 0x0200
>
>  struct perf_output_handle;
>
> @@ -363,6 +364,8 @@ struct pmu {
>  #define PERF_EF_START  0x01            /* start the counter when adding =
   */
>  #define PERF_EF_RELOAD 0x02            /* reload the counter when starti=
ng */
>  #define PERF_EF_UPDATE 0x04            /* update the counter when stoppi=
ng */
> +#define PERF_EF_PAUSE  0x08            /* AUX area event, pause tracing =
*/
> +#define PERF_EF_RESUME 0x10            /* AUX area event, resume tracing=
 */
>
>         /*
>          * Adds/Removes a counter to/from the PMU, can be done inside a
> @@ -402,6 +405,15 @@ struct pmu {
>          *
>          * ->start() with PERF_EF_RELOAD will reprogram the counter
>          *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
> +        *
> +        * ->stop() with PERF_EF_PAUSE will stop as simply as possible. W=
ill not
> +        * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
> +        * PERF_EF_RESUME.
> +        *
> +        * ->start() with PERF_EF_RESUME will start as simply as possible=
 but
> +        * only if the counter is not otherwise stopped. Will not overlap
> +        * another ->start() with PERF_EF_RESUME nor ->stop() with
> +        * PERF_EF_PAUSE.
>          */
>         void (*start)                   (struct perf_event *event, int fl=
ags);
>         void (*stop)                    (struct perf_event *event, int fl=
ags);
> @@ -798,6 +810,9 @@ struct perf_event {
>         /* for aux_output events */
>         struct perf_event               *aux_event;
>
> +       /* for AUX area events */
> +       unsigned int                    aux_paused;
> +
>         void (*destroy)(struct perf_event *);
>         struct rcu_head                 rcu_head;
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_ev=
ent.h
> index 39c6a250dd1b..5f6b3b494184 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -507,7 +507,16 @@ struct perf_event_attr {
>         __u16   sample_max_stack;
>         __u16   __reserved_2;
>         __u32   aux_sample_size;
> -       __u32   __reserved_3;
> +
> +       union {
> +               __u32   aux_action;
> +               struct {
> +                       __u32   aux_start_paused :  1, /* start AUX area =
tracing paused */
> +                               aux_pause        :  1, /* on overflow, pa=
use AUX area tracing */
> +                               aux_resume       :  1, /* on overflow, re=
sume AUX area tracing */
> +                               __reserved_3     : 29;
> +               };
> +       };
>
>         /*
>          * User provided data if sigtrap=3D1, passed back to user via
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9efd0d7775e7..dc9ec2443ac9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2097,7 +2097,8 @@ static void perf_put_aux_event(struct perf_event *e=
vent)
>
>  static bool perf_need_aux_event(struct perf_event *event)
>  {
> -       return !!event->attr.aux_output || !!event->attr.aux_sample_size;
> +       return event->attr.aux_output || event->attr.aux_sample_size ||
> +              event->attr.aux_pause || event->attr.aux_resume;
>  }
>
>  static int perf_get_aux_event(struct perf_event *event,
> @@ -2122,6 +2123,10 @@ static int perf_get_aux_event(struct perf_event *e=
vent,
>             !perf_aux_output_match(event, group_leader))
>                 return 0;
>
> +       if ((event->attr.aux_pause || event->attr.aux_resume) &&
> +           !(group_leader->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
> +               return 0;
> +
>         if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_a=
ux)
>                 return 0;
>
> @@ -7846,6 +7851,47 @@ void perf_prepare_header(struct perf_event_header =
*header,
>         WARN_ON_ONCE(header->size & 7);
>  }
>
> +static void __perf_event_aux_pause(struct perf_event *event, bool pause)
> +{
> +       if (pause) {
> +               if (!READ_ONCE(event->aux_paused)) {
> +                       WRITE_ONCE(event->aux_paused, 1);
> +                       event->pmu->stop(event, PERF_EF_PAUSE);
> +               }
> +       } else {
> +               if (READ_ONCE(event->aux_paused)) {
> +                       WRITE_ONCE(event->aux_paused, 0);
> +                       event->pmu->start(event, PERF_EF_RESUME);
> +               }
> +       }
> +}
> +
> +static void perf_event_aux_pause(struct perf_event *event, bool pause)
> +{
> +       struct perf_buffer *rb;
> +       unsigned long flags;
> +
> +       if (WARN_ON_ONCE(!event))
> +               return;
> +
> +       rb =3D ring_buffer_get(event);
> +       if (!rb)
> +               return;
> +
> +       local_irq_save(flags);
> +       /* Guard against NMI, NMI loses here */
> +       if (READ_ONCE(rb->aux_in_pause_resume))
> +               goto out_restore;
> +       WRITE_ONCE(rb->aux_in_pause_resume, 1);
> +       barrier();
> +       __perf_event_aux_pause(event, pause);
> +       barrier();
> +       WRITE_ONCE(rb->aux_in_pause_resume, 0);
> +out_restore:
> +       local_irq_restore(flags);
> +       ring_buffer_put(rb);
> +}
> +
>  static __always_inline int
>  __perf_event_output(struct perf_event *event,
>                     struct perf_sample_data *data,
> @@ -7859,6 +7905,9 @@ __perf_event_output(struct perf_event *event,
>         struct perf_event_header header;
>         int err;
>
> +       if (event->attr.aux_pause)
> +               perf_event_aux_pause(event->aux_event, true);
> +
>         /* protect the callchain buffers */
>         rcu_read_lock();
>
> @@ -7875,6 +7924,10 @@ __perf_event_output(struct perf_event *event,
>
>  exit:
>         rcu_read_unlock();
> +
> +       if (event->attr.aux_resume)
> +               perf_event_aux_pause(event->aux_event, false);
> +
>         return err;
>  }
>
> @@ -12014,10 +12067,23 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>         }
>
>         if (event->attr.aux_output &&
> -           !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
> +           (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
> +            event->attr.aux_pause || event->attr.aux_resume)) {
> +               err =3D -EOPNOTSUPP;
> +               goto err_pmu;
> +       }
> +
> +       if (event->attr.aux_pause && event->attr.aux_resume) {
> +               err =3D -EINVAL;
> +               goto err_pmu;
> +       }
> +
> +       if (event->attr.aux_start_paused &&
> +           !(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
>                 err =3D -EOPNOTSUPP;
>                 goto err_pmu;
>         }
> +       event->aux_paused =3D event->attr.aux_start_paused;
>
>         if (cgroup_fd !=3D -1) {
>                 err =3D perf_cgroup_connect(cgroup_fd, event, attr, group=
_leader);
> @@ -12814,7 +12880,7 @@ perf_event_create_kernel_counter(struct perf_even=
t_attr *attr, int cpu,
>          * Grouping is not supported for kernel events, neither is 'AUX',
>          * make sure the caller's intentions are adjusted.
>          */
> -       if (attr->aux_output)
> +       if (attr->aux_output || attr->aux_action)
>                 return ERR_PTR(-EINVAL);
>
>         event =3D perf_event_alloc(attr, cpu, task, NULL, NULL,
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index 5150d5f84c03..3320f78117dc 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -51,6 +51,7 @@ struct perf_buffer {
>         void                            (*free_aux)(void *);
>         refcount_t                      aux_refcount;
>         int                             aux_in_sampling;
> +       int                             aux_in_pause_resume;
>         void                            **aux_pages;
>         void                            *aux_priv;
>
> --
> 2.34.1
>

