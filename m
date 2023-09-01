Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B978F87B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbjIAGSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjIAGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3F79E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693549084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NCoHUy21Y+HIbtl00/+o/mR3wL3CsEO4zSXXLcm78Tg=;
        b=K6B6go7iP60j/DYjfhwcbqNZzNLq2r8emLx2q6iPVw6BS2t7w/KlhxsHvLkbhvWselKEnQ
        2CryUJo1FHRB515m9AjMswf0s4qi9UjVOPwWrXoaVqUzSsI9PCJmk2unLw2xPjj/x1bcKw
        8FggipewrcqsHRI549BR5p2twzNT85g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-bctjHxq7M86az4W8xpcJxA-1; Fri, 01 Sep 2023 02:18:03 -0400
X-MC-Unique: bctjHxq7M86az4W8xpcJxA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4136ec108ecso17287801cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693549082; x=1694153882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCoHUy21Y+HIbtl00/+o/mR3wL3CsEO4zSXXLcm78Tg=;
        b=PBxXNsMfF6VcgxqjKIg9YNd5PCq2j+9ABEOj8S/lwYwbi07QqrP7NYXdK2c1cs3eu7
         rvtoI4xqndU0zacvyhkIG7kS60LHhsTwEFwvvJ6tXj3UPVy7O7G/KihztYg02QAKocmS
         9kqXOeHBUgwkHShyp8EKbTNNLXSSETsSeHG6YpmnogxsDZ3YO9++C1qjQit9XEQuVmey
         u1ZEmjGB1wRTLb+LHJ6WPzRAri08TkH6A4b6sm+qDlzvNCbYalCLML8jSFSTbdPItx9L
         KNPxDxciAEOS39vlgiagTzvyvZd3yTMh9uSbMQEfhNX3wp3rlv7g8jkSKyAQBczHGZw7
         W8Tw==
X-Gm-Message-State: AOJu0YxG5c0h1Oh80xmeawP3u/SN0zbhnBz6e8Hx2sdBs8d91ioVptRu
        r/O9IVB/OK71JA/Lu2ZMUbDb/6tWO5QR42olIclew7+rIhy0OTEcuKDAAem4vzmQUK+GtdlPwRL
        bZkJcYA8UzMvVRgYpgNTVly5mORD6VRmr0j9d3uOOVLuH1xQm
X-Received: by 2002:ac8:7d56:0:b0:412:1e4c:e858 with SMTP id h22-20020ac87d56000000b004121e4ce858mr1914049qtb.36.1693549082435;
        Thu, 31 Aug 2023 23:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF8Qj0L34On7VCvINdaprG6njP7EEdfXIQ5lwObVY15Tfc/HZL0XMnvJG3rnOKeETsZkTiyUuElX2TEmOia18=
X-Received: by 2002:ac8:7d56:0:b0:412:1e4c:e858 with SMTP id
 h22-20020ac87d56000000b004121e4ce858mr1914039qtb.36.1693549082189; Thu, 31
 Aug 2023 23:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230831063129.335425-1-leobras@redhat.com> <CAJF2gTSo5opLeRrOevU_g5C9iJZO1O4=+F7vsrwbBrY_KqaYQA@mail.gmail.com>
In-Reply-To: <CAJF2gTSo5opLeRrOevU_g5C9iJZO1O4=+F7vsrwbBrY_KqaYQA@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Fri, 1 Sep 2023 03:17:50 -0300
Message-ID: <CAJ6HWG6y=mRPJrGbx0YYYepz4zVORL3cb_=3J+CcfHUQ5rUr+g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Change function signatures to use call_single_data_t
To:     Guo Ren <guoren@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 3:58=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Aug 31, 2023 at 2:31=E2=80=AFPM Leonardo Bras <leobras@redhat.com=
> wrote:
> >
> > call_single_data_t is a size-aligned typedef of struct __call_single_da=
ta.
> >
> > This alignment is desirable in order to have smp_call_function*() avoid
> > bouncing an extra cacheline in case of an unaligned csd, given this
> > would hurt performance.
> >
> > Since the removal of struct request->csd in commit 660e802c76c8
> > ("blk-mq: use percpu csd to remote complete instead of per-rq csd") the=
re
> > are no current users of smp_call_function*() with unaligned csd.
> >
> > Change every 'struct __call_single_data' function parameter to
> > 'call_single_data_t', so we have warnings if any new code tries to
> > introduce an smp_call_function*() call with unaligned csd.
> I agree to prevent __call_single_data usage.
>
> Reviewed-by: Guo Ren <guoren@kernel.org>

Thanks for reviewing!


>
> /*
>  * structure shares (partial) layout with struct irq_work
>  */
> struct __call_single_data {
>         struct __call_single_node node;
>         smp_call_func_t func;
>         void *info;
> };
>
> #define CSD_INIT(_func, _info) \
>         (struct __call_single_data){ .func =3D (_func), .info =3D (_info)=
, }
>
> /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
> typedef struct __call_single_data call_single_data_t
>         __aligned(sizeof(struct __call_single_data));
>
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  include/linux/smp.h        |  2 +-
> >  include/trace/events/csd.h |  8 ++++----
> >  kernel/smp.c               | 26 +++++++++++++-------------
> >  kernel/up.c                |  2 +-
> >  4 files changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > index 91ea4a67f8ca..e87520dc2959 100644
> > --- a/include/linux/smp.h
> > +++ b/include/linux/smp.h
> > @@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func=
_t func, void *info,
> >  void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t =
func,
> >                            void *info, bool wait, const struct cpumask =
*mask);
> >
> > -int smp_call_function_single_async(int cpu, struct __call_single_data =
*csd);
> > +int smp_call_function_single_async(int cpu, call_single_data_t *csd);
> >
> >  /*
> >   * Cpus stopping functions in panic. All have default weak definitions=
.
> > diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
> > index 67e9d01f80c2..58cc83b99c34 100644
> > --- a/include/trace/events/csd.h
> > +++ b/include/trace/events/csd.h
> > @@ -12,7 +12,7 @@ TRACE_EVENT(csd_queue_cpu,
> >         TP_PROTO(const unsigned int cpu,
> >                 unsigned long callsite,
> >                 smp_call_func_t func,
> > -               struct __call_single_data *csd),
> > +               call_single_data_t *csd),
> >
> >         TP_ARGS(cpu, callsite, func, csd),
> >
> > @@ -39,7 +39,7 @@ TRACE_EVENT(csd_queue_cpu,
> >   */
> >  DECLARE_EVENT_CLASS(csd_function,
> >
> > -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> > +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >
> >         TP_ARGS(func, csd),
> >
> > @@ -57,12 +57,12 @@ DECLARE_EVENT_CLASS(csd_function,
> >  );
> >
> >  DEFINE_EVENT(csd_function, csd_function_entry,
> > -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> > +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >         TP_ARGS(func, csd)
> >  );
> >
> >  DEFINE_EVENT(csd_function, csd_function_exit,
> > -       TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
> > +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >         TP_ARGS(func, csd)
> >  );
> >
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 8455a53465af..8c714583786b 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -127,7 +127,7 @@ send_call_function_ipi_mask(struct cpumask *mask)
> >  }
> >
> >  static __always_inline void
> > -csd_do_func(smp_call_func_t func, void *info, struct __call_single_dat=
a *csd)
> > +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
> >  {
> >         trace_csd_function_entry(func, csd);
> >         func(info);
> > @@ -174,7 +174,7 @@ module_param(csd_lock_timeout, ulong, 0444);
> >  static atomic_t csd_bug_count =3D ATOMIC_INIT(0);
> >
> >  /* Record current CSD work for current CPU, NULL to erase. */
> > -static void __csd_lock_record(struct __call_single_data *csd)
> > +static void __csd_lock_record(call_single_data_t *csd)
> >  {
> >         if (!csd) {
> >                 smp_mb(); /* NULL cur_csd after unlock. */
> > @@ -189,13 +189,13 @@ static void __csd_lock_record(struct __call_singl=
e_data *csd)
> >                   /* Or before unlock, as the case may be. */
> >  }
> >
> > -static __always_inline void csd_lock_record(struct __call_single_data =
*csd)
> > +static __always_inline void csd_lock_record(call_single_data_t *csd)
> >  {
> >         if (static_branch_unlikely(&csdlock_debug_enabled))
> >                 __csd_lock_record(csd);
> >  }
> >
> > -static int csd_lock_wait_getcpu(struct __call_single_data *csd)
> > +static int csd_lock_wait_getcpu(call_single_data_t *csd)
> >  {
> >         unsigned int csd_type;
> >
> > @@ -210,7 +210,7 @@ static int csd_lock_wait_getcpu(struct __call_singl=
e_data *csd)
> >   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> >   * so waiting on other types gets much less information.
> >   */
> > -static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 =
ts0, u64 *ts1, int *bug_id)
> > +static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u6=
4 *ts1, int *bug_id)
> >  {
> >         int cpu =3D -1;
> >         int cpux;
> > @@ -276,7 +276,7 @@ static bool csd_lock_wait_toolong(struct __call_sin=
gle_data *csd, u64 ts0, u64 *
> >   * previous function call. For multi-cpu calls its even more interesti=
ng
> >   * as we'll have to ensure no other cpu is observing our csd.
> >   */
> > -static void __csd_lock_wait(struct __call_single_data *csd)
> > +static void __csd_lock_wait(call_single_data_t *csd)
> >  {
> >         int bug_id =3D 0;
> >         u64 ts0, ts1;
> > @@ -290,7 +290,7 @@ static void __csd_lock_wait(struct __call_single_da=
ta *csd)
> >         smp_acquire__after_ctrl_dep();
> >  }
> >
> > -static __always_inline void csd_lock_wait(struct __call_single_data *c=
sd)
> > +static __always_inline void csd_lock_wait(call_single_data_t *csd)
> >  {
> >         if (static_branch_unlikely(&csdlock_debug_enabled)) {
> >                 __csd_lock_wait(csd);
> > @@ -300,17 +300,17 @@ static __always_inline void csd_lock_wait(struct =
__call_single_data *csd)
> >         smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK=
));
> >  }
> >  #else
> > -static void csd_lock_record(struct __call_single_data *csd)
> > +static void csd_lock_record(call_single_data_t *csd)
> >  {
> >  }
> >
> > -static __always_inline void csd_lock_wait(struct __call_single_data *c=
sd)
> > +static __always_inline void csd_lock_wait(call_single_data_t *csd)
> >  {
> >         smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK=
));
> >  }
> >  #endif
> >
> > -static __always_inline void csd_lock(struct __call_single_data *csd)
> > +static __always_inline void csd_lock(call_single_data_t *csd)
> >  {
> >         csd_lock_wait(csd);
> >         csd->node.u_flags |=3D CSD_FLAG_LOCK;
> > @@ -323,7 +323,7 @@ static __always_inline void csd_lock(struct __call_=
single_data *csd)
> >         smp_wmb();
> >  }
> >
> > -static __always_inline void csd_unlock(struct __call_single_data *csd)
> > +static __always_inline void csd_unlock(call_single_data_t *csd)
> >  {
> >         WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
> >
> > @@ -376,7 +376,7 @@ void __smp_call_single_queue(int cpu, struct llist_=
node *node)
> >   * for execution on the given CPU. data must already have
> >   * ->func, ->info, and ->flags set.
> >   */
> > -static int generic_exec_single(int cpu, struct __call_single_data *csd=
)
> > +static int generic_exec_single(int cpu, call_single_data_t *csd)
> >  {
> >         if (cpu =3D=3D smp_processor_id()) {
> >                 smp_call_func_t func =3D csd->func;
> > @@ -667,7 +667,7 @@ EXPORT_SYMBOL(smp_call_function_single);
> >   *
> >   * Return: %0 on success or negative errno value on error
> >   */
> > -int smp_call_function_single_async(int cpu, struct __call_single_data =
*csd)
> > +int smp_call_function_single_async(int cpu, call_single_data_t *csd)
> >  {
> >         int err =3D 0;
> >
> > diff --git a/kernel/up.c b/kernel/up.c
> > index a38b8b095251..df50828cc2f0 100644
> > --- a/kernel/up.c
> > +++ b/kernel/up.c
> > @@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (v=
oid *info), void *info,
> >  }
> >  EXPORT_SYMBOL(smp_call_function_single);
> >
> > -int smp_call_function_single_async(int cpu, struct __call_single_data =
*csd)
> > +int smp_call_function_single_async(int cpu, call_single_data_t *csd)
> >  {
> >         unsigned long flags;
> >
> > --
> > 2.42.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>

