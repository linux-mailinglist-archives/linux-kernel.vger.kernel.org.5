Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBF7CFC58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjJSOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbjJSOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:22:19 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B4126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:22:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9cb74cf53fso652977276.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697725335; x=1698330135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m95/xJBAOCVz4DOb4gKoXYzVytqaMuBbCRuWfAdJ+Io=;
        b=l2r48rH2cqFXEZsSrK3V7TXm+AiBr+rNL4yiLXnx0PfmuhJIvmBWLUtRpVFhztV11z
         C4rkgTmSWeGGRf8EIOMDORURu6IsN13GuEzTWvO2j1awByyZtUGNJ8TP4ABTmGNuw2J8
         iBBinmC7UlaTRNidnN3A9WTdFV9OUUi1vh5nc0VCSqqQFLr/555pKmzl9fMEo/C58kHT
         6MSQOHq58OOAXhaqlO5SQDT0Zk5hhrD930RN+tS7s8EZFEBvr/mEKyQaQ6WsA8xAupLj
         OYZ6yrHTHprzvoqEkYMIOaiVaQnPZkeB+p4a5GymTFUMneWBt8g+5nCdb7yoohfPfkGg
         13Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725335; x=1698330135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m95/xJBAOCVz4DOb4gKoXYzVytqaMuBbCRuWfAdJ+Io=;
        b=pG0EYX5ZqF0lfBcrjsQB3poF82V3dVlGL3wAew2UIDimgOiN0nvkPgP9vxrNLWnh1y
         RO+/eyXqCy7ct5kWKPNnpAOfwU5RetpUlKMlsl4tyFs5yn/Lk/ABrfeilbCsduFHVxOC
         B4ybolWRIEywOPcdh29BUO1msWO/mYm51gjwcxbQT8EhZU5hXEu+JWcnjdaXfCCX3i02
         ro2aSDM/vPuCQQ2xUJAyv/PAWgFJgC7H2Ax+hpxfKUiNvft+leWg7sc9YSj1TbhBD2MO
         wPjBsLroQDjPROWyhgUo7pDTyqzw+w+M9lKhwutupCRYl7GmlCzYHNqlmjXoS3nci9+K
         Xvkw==
X-Gm-Message-State: AOJu0YxZ32qsqg3WFYqn5HL3IKvj3ym9XEH5cycNN6MwK1n5MA2F+3bC
        Ev+zouyF9gCbNi7ork9SiLQXd8NN+A8O6f23hxibHA==
X-Google-Smtp-Source: AGHT+IEtGiqfA/A8qKmW8yXPviftmC99Jcq+1boeFalwt5MchpMrqQJ1b9UWVT+JZORtJ7iWsDwJGp5bB6Hs6e2WWv4=
X-Received: by 2002:a25:b85:0:b0:d9a:c88e:e78a with SMTP id
 127-20020a250b85000000b00d9ac88ee78amr2630575ybl.35.1697725335115; Thu, 19
 Oct 2023 07:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231016090428.1369071-1-etienne.carriere@foss.st.com>
 <20231016090428.1369071-4-etienne.carriere@foss.st.com> <CAFA6WYNi=gAkBeMGsfLUksFJih84M9TrZdoBzTddBAvrSViUbA@mail.gmail.com>
In-Reply-To: <CAFA6WYNi=gAkBeMGsfLUksFJih84M9TrZdoBzTddBAvrSViUbA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 19 Oct 2023 16:22:03 +0200
Message-ID: <CAHUa44HEaFjgBuKzOPS_OVjOhP=UDpvE9dDY2=6EFO8ZgiTQCQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] tee: optee: support tracking system threads
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 1:37=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Mon, 16 Oct 2023 at 14:34, Etienne Carriere
> <etienne.carriere@foss.st.com> wrote:
> >
> > Adds support in the OP-TEE driver to keep track of reserved system
> > threads. The logic allows one OP-TEE thread to be reserved to TEE syste=
m
> > sessions.
> >
> > The optee_cq_*() functions are updated to handle this if enabled,
> > that is when TEE describes how many thread context it supports
> > and when at least 1 session has registered as a system session
> > (using tee_client_system_session()).
> >
> > For sake of simplicity, initialization of call queue management
> > is factorized into new helper function optee_cq_init().
> >
> > The SMC ABI part of the driver enables this tracking, but the
> > FF-A ABI part does not.
> >
> > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> > Changes since v10:
> > - Use a single list instead of 2 and wake system session first from
> >   that list in optee_cq_complete_one().
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> Jens,
>
> If you are fine with this patch-set then we can queue this up for the
> next release?

It's a bit late for the next release, but I can put it in next and add
it to our OP-TEE testing branch. I would feel more comfortable taking
this after having it in our CI loop for a while.

Cheers,
Jens

>
> -Sumit
>
> >
> > Changes since v9:
> > - Add a reference counter for TEE system thread provisioning. We reserv=
e
> >   a TEE thread context for system session only when there is at least
> >   1 opened system session.
> > - Use 2 wait queue lists, normal_waiters and sys_waiter, as proposed in
> >   patch v8. Using a single list can prevent a waiting system thread fro=
m
> >   being resumed if the executing system thread wakes a normal waiter in
> >   the list.
> > - Updated my e-mail address.
> > - Rephrased a bit the commit message.
> >
> > Changes since patch v8
> > - Patch v9 (reference below) attempted to simplify the implementation
> >   https://lore.kernel.org/lkml/20230517143311.585080-1-sumit.garg@linar=
o.org/#t
> >
> > Changes since v7:
> > - Changes the logic to reserve at most 1 call entry for system sessions
> >   as per patches v6 and v7 discussion threads (the 2 below bullets)
> >   and updates commit message accordingly.
> > - Field optee_call_queue::res_sys_thread_count is replaced with 2 field=
s:
> >   sys_thread_req_count and boolean sys_thread_in_use.
> > - Field optee_call_waiter::sys_thread is replaced with 2 fields:
> >   sys_thread_req and sys_thread_used.
> > - Adds inline description comments for struct optee_call_queue and
> >   struct optee_call_waiter.
> >
> > Changes since v6:
> > - Moved out changes related to adding boolean system thread attribute
> >   into optee driver call queue and SMC/FF-A ABIs API functions. These
> >   changes were squashed into patch 1/4 of this patch v7 series.
> > - Comment about adding a specific commit for call queue refactoring
> >   was not addressed such a patch would only introduce function
> >   optee_cq_init()  with very little content in (mutex & list init).
> > - Added Co-developed-by tag for Jens contribution as he's not responsib=
le
> >   for the changes I made in this patch v7.
> >
> > No change since v5
> >
> > Changes since v4:
> > - New change that supersedes implementation proposed in PATCH v4
> >   (tee: system invocation"). Thanks to Jens implementation we don't nee=
d
> >   the new OP-TEE services that my previous patch versions introduced to
> >   monitor system threads entry. Now, Linux optee SMC ABI driver gets TE=
E
> >   provisioned thread contexts count once and monitors thread entries in
> >   OP-TEE on that basis and the system thread capability of the related
> >   tee session. By the way, I dropped the WARN_ONCE() call I suggested
> >   on tee thread exhaustion as it does not provides useful information.
> > ---
> >  drivers/tee/optee/call.c          | 106 ++++++++++++++++++++++++++++++
> >  drivers/tee/optee/ffa_abi.c       |   3 +-
> >  drivers/tee/optee/optee_private.h |  20 ++++++
> >  drivers/tee/optee/smc_abi.c       |  16 ++++-
> >  4 files changed, 141 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 152ae9bb1785..b04c49c69619 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -39,9 +39,29 @@ struct optee_shm_arg_entry {
> >         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
> >  };
> >
> > +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> > +{
> > +       mutex_init(&cq->mutex);
> > +       INIT_LIST_HEAD(&cq->waiters);
> > +
> > +       /*
> > +        * If cq->total_thread_count is 0 then we're not trying to keep
> > +        * track of how many free threads we have, instead we're relyin=
g on
> > +        * the secure world to tell us when we're out of thread and hav=
e to
> > +        * wait for another thread to become available.
> > +        */
> > +       cq->total_thread_count =3D thread_count;
> > +       cq->free_thread_count =3D thread_count;
> > +}
> > +
> >  void optee_cq_wait_init(struct optee_call_queue *cq,
> >                         struct optee_call_waiter *w, bool sys_thread)
> >  {
> > +       unsigned int free_thread_threshold;
> > +       bool need_wait =3D false;
> > +
> > +       memset(w, 0, sizeof(*w));
> > +
> >         /*
> >          * We're preparing to make a call to secure world. In case we c=
an't
> >          * allocate a thread in secure world we'll end up waiting in
> > @@ -60,8 +80,38 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
> >          */
> >         init_completion(&w->c);
> >         list_add_tail(&w->list_node, &cq->waiters);
> > +       w->sys_thread =3D sys_thread;
> > +
> > +       if (cq->total_thread_count) {
> > +               if (sys_thread || !cq->sys_thread_req_count)
> > +                       free_thread_threshold =3D 0;
> > +               else
> > +                       free_thread_threshold =3D 1;
> > +
> > +               if (cq->free_thread_count > free_thread_threshold)
> > +                       cq->free_thread_count--;
> > +               else
> > +                       need_wait =3D true;
> > +       }
> >
> >         mutex_unlock(&cq->mutex);
> > +
> > +       while (need_wait) {
> > +               optee_cq_wait_for_completion(cq, w);
> > +               mutex_lock(&cq->mutex);
> > +
> > +               if (sys_thread || !cq->sys_thread_req_count)
> > +                       free_thread_threshold =3D 0;
> > +               else
> > +                       free_thread_threshold =3D 1;
> > +
> > +               if (cq->free_thread_count > free_thread_threshold) {
> > +                       cq->free_thread_count--;
> > +                       need_wait =3D false;
> > +               }
> > +
> > +               mutex_unlock(&cq->mutex);
> > +       }
> >  }
> >
> >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > @@ -83,6 +133,14 @@ static void optee_cq_complete_one(struct optee_call=
_queue *cq)
> >  {
> >         struct optee_call_waiter *w;
> >
> > +       /* Wake a waiting system session if any, prior to a normal sess=
ion */
> > +       list_for_each_entry(w, &cq->waiters, list_node) {
> > +               if (w->sys_thread && !completion_done(&w->c)) {
> > +                       complete(&w->c);
> > +                       return;
> > +               }
> > +       }
> > +
> >         list_for_each_entry(w, &cq->waiters, list_node) {
> >                 if (!completion_done(&w->c)) {
> >                         complete(&w->c);
> > @@ -104,6 +162,8 @@ void optee_cq_wait_final(struct optee_call_queue *c=
q,
> >         /* Get out of the list */
> >         list_del(&w->list_node);
> >
> > +       cq->free_thread_count++;
> > +
> >         /* Wake up one eventual waiting task */
> >         optee_cq_complete_one(cq);
> >
> > @@ -119,6 +179,28 @@ void optee_cq_wait_final(struct optee_call_queue *=
cq,
> >         mutex_unlock(&cq->mutex);
> >  }
> >
> > +/* Count registered system sessions to reserved a system thread or not=
 */
> > +static bool optee_cq_incr_sys_thread_count(struct optee_call_queue *cq=
)
> > +{
> > +       if (cq->total_thread_count <=3D 1)
> > +               return false;
> > +
> > +       mutex_lock(&cq->mutex);
> > +       cq->sys_thread_req_count++;
> > +       mutex_unlock(&cq->mutex);
> > +
> > +       return true;
> > +}
> > +
> > +static void optee_cq_decr_sys_thread_count(struct optee_call_queue *cq=
)
> > +{
> > +       mutex_lock(&cq->mutex);
> > +       cq->sys_thread_req_count--;
> > +       /* If there's someone waiting, let it resume */
> > +       optee_cq_complete_one(cq);
> > +       mutex_unlock(&cq->mutex);
> > +}
> > +
> >  /* Requires the filpstate mutex to be held */
> >  static struct optee_session *find_session(struct optee_context_data *c=
txdata,
> >                                           u32 session_id)
> > @@ -361,6 +443,27 @@ int optee_open_session(struct tee_context *ctx,
> >         return rc;
> >  }
> >
> > +int optee_system_session(struct tee_context *ctx, u32 session)
> > +{
> > +       struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> > +       struct optee_context_data *ctxdata =3D ctx->data;
> > +       struct optee_session *sess;
> > +       int rc =3D -EINVAL;
> > +
> > +       mutex_lock(&ctxdata->mutex);
> > +
> > +       sess =3D find_session(ctxdata, session);
> > +       if (sess && (sess->use_sys_thread ||
> > +                    optee_cq_incr_sys_thread_count(&optee->call_queue)=
)) {
> > +               sess->use_sys_thread =3D true;
> > +               rc =3D 0;
> > +       }
> > +
> > +       mutex_unlock(&ctxdata->mutex);
> > +
> > +       return rc;
> > +}
> > +
> >  int optee_close_session_helper(struct tee_context *ctx, u32 session,
> >                                bool system_thread)
> >  {
> > @@ -380,6 +483,9 @@ int optee_close_session_helper(struct tee_context *=
ctx, u32 session,
> >
> >         optee_free_msg_arg(ctx, entry, offs);
> >
> > +       if (system_thread)
> > +               optee_cq_decr_sys_thread_count(&optee->call_queue);
> > +
> >         return 0;
> >  }
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 5fde9d4100e3..0c9055691343 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -852,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
> >         if (rc)
> >                 goto err_unreg_supp_teedev;
> >         mutex_init(&optee->ffa.mutex);
> > -       mutex_init(&optee->call_queue.mutex);
> > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > +       optee_cq_init(&optee->call_queue, 0);
> >         optee_supp_init(&optee->supp);
> >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> >         ffa_dev_set_drvdata(ffa_dev, optee);
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index b659a6f521df..8e944e611b66 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -40,15 +40,33 @@ typedef void (optee_invoke_fn)(unsigned long, unsig=
ned long, unsigned long,
> >                                 unsigned long, unsigned long,
> >                                 struct arm_smccc_res *);
> >
> > +/*
> > + * struct optee_call_waiter - TEE entry may need to wait for a free TE=
E thread
> > + * @list_node          Reference in waiters list
> > + * @c                  Waiting completion reference
> > + * @sys_thread_req     True if waiter belongs to a system thread
> > + */
> >  struct optee_call_waiter {
> >         struct list_head list_node;
> >         struct completion c;
> > +       bool sys_thread;
> >  };
> >
> > +/*
> > + * struct optee_call_queue - OP-TEE call queue management
> > + * @mutex                      Serializes access to this struct
> > + * @waiters                    List of threads waiting to enter OP-TEE
> > + * @total_thread_count         Overall number of thread context in OP-=
TEE or 0
> > + * @free_thread_count          Number of threads context free in OP-TE=
E
> > + * @sys_thread_req_count       Number of registered system thread sess=
ions
> > + */
> >  struct optee_call_queue {
> >         /* Serializes access to this struct */
> >         struct mutex mutex;
> >         struct list_head waiters;
> > +       int total_thread_count;
> > +       int free_thread_count;
> > +       int sys_thread_req_count;
> >  };
> >
> >  struct optee_notif {
> > @@ -252,6 +270,7 @@ int optee_supp_send(struct tee_context *ctx, u32 re=
t, u32 num_params,
> >  int optee_open_session(struct tee_context *ctx,
> >                        struct tee_ioctl_open_session_arg *arg,
> >                        struct tee_param *param);
> > +int optee_system_session(struct tee_context *ctx, u32 session);
> >  int optee_close_session_helper(struct tee_context *ctx, u32 session,
> >                                bool system_thread);
> >  int optee_close_session(struct tee_context *ctx, u32 session);
> > @@ -301,6 +320,7 @@ static inline void optee_to_msg_param_value(struct =
optee_msg_param *mp,
> >         mp->u.value.c =3D p->u.value.c;
> >  }
> >
> > +void optee_cq_init(struct optee_call_queue *cq, int thread_count);
> >  void optee_cq_wait_init(struct optee_call_queue *cq,
> >                         struct optee_call_waiter *w, bool sys_thread);
> >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index 1033d7da03ea..5595028d6dae 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1211,6 +1211,7 @@ static const struct tee_driver_ops optee_clnt_ops=
 =3D {
> >         .release =3D optee_release,
> >         .open_session =3D optee_open_session,
> >         .close_session =3D optee_close_session,
> > +       .system_session =3D optee_system_session,
> >         .invoke_func =3D optee_invoke_func,
> >         .cancel_req =3D optee_cancel_req,
> >         .shm_register =3D optee_shm_register,
> > @@ -1358,6 +1359,16 @@ static bool optee_msg_exchange_capabilities(opte=
e_invoke_fn *invoke_fn,
> >         return true;
> >  }
> >
> > +static unsigned int optee_msg_get_thread_count(optee_invoke_fn *invoke=
_fn)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       invoke_fn(OPTEE_SMC_GET_THREAD_COUNT, 0, 0, 0, 0, 0, 0, 0, &res=
);
> > +       if (res.a0)
> > +               return 0;
> > +       return res.a1;
> > +}
> > +
> >  static struct tee_shm_pool *
> >  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremape=
d_shm)
> >  {
> > @@ -1610,6 +1621,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >         struct optee *optee =3D NULL;
> >         void *memremaped_shm =3D NULL;
> >         unsigned int rpc_param_count;
> > +       unsigned int thread_count;
> >         struct tee_device *teedev;
> >         struct tee_context *ctx;
> >         u32 max_notif_value;
> > @@ -1637,6 +1649,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >                 return -EINVAL;
> >         }
> >
> > +       thread_count =3D optee_msg_get_thread_count(invoke_fn);
> >         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
> >                                              &max_notif_value,
> >                                              &rpc_param_count)) {
> > @@ -1726,8 +1739,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> >         if (rc)
> >                 goto err_unreg_supp_teedev;
> >
> > -       mutex_init(&optee->call_queue.mutex);
> > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > +       optee_cq_init(&optee->call_queue, thread_count);
> >         optee_supp_init(&optee->supp);
> >         optee->smc.memremaped_shm =3D memremaped_shm;
> >         optee->pool =3D pool;
> > --
> > 2.25.1
> >
