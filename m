Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F317C7E82
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJMHVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJMHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:21:50 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E1DB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:21:47 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-45271a44cc4so764848137.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697181706; x=1697786506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VHJX1BRvULgvn4WwpwoF7Hs3K4fbIXjFBdDGQODdOww=;
        b=e7I3gz7A9o73pEcNnc8Uvn+i9rhM6Q/zkk6JATNKQc6FXzxA8cuD1p2pUaNDa2AZzB
         Gy+qteHeVa4v/XDb+rYYv62SFpxaEhJcjn6OpHlJTgAL3AgPJ4JgGNgVl8xJQX3DSMqr
         qpy8VcBGGEqd2c5vu4dSPJkOAVLvNC4udLdSC8bWLOPVS91KluIQ4Y9CJjscyiAGI3us
         YWY5VugWhL8O3UgBhp6HHELuyX180dtu/pb1ApfUip25jjY7kH4qo98J+/LbHjE0/rCE
         IC8DLiG1WYCkWWyIVLX+NWE20Jh3BSRQ/Nwi8z9xHTNzfXt/jCmZwOwgeW2gbEb48TEH
         1Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697181706; x=1697786506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHJX1BRvULgvn4WwpwoF7Hs3K4fbIXjFBdDGQODdOww=;
        b=F/VymFtRoPLNaz2Nn02fHX0jJJruECW0eUFzTvcg7u+gPWmD1neoKGQx14uokjOlF2
         c79rfDccJPc/umjyn+W4hc+q1v1mmPCb8g0lwG3s70ojX52D041395xafJhoUQgLIzhY
         +sI9JnfsfGwMjHLOeMV2xEuGb7YbrM8edOJkrV9lgKMDnfp5yEpNPu/1hOFpLq/V2Nmw
         Ji80QazW4XVibvmf5dZJYbfrmqscSRee9PXnjJ5ejWbyATUbONeIvZnGnSXHGxmxxgYX
         aA0w+iYDQrCbcH92gf+meJjF19ST37cn66bNc5O4RGZC+ZNXOOG4fcrMZe3gNN16m9IJ
         esRQ==
X-Gm-Message-State: AOJu0Yy7WAjbEC1QYB3QHffMBAD6tZX3y6GFprwq0ZlkBpqe0UbY5vxR
        X+8w4DEikyVt4t9gau4gLfvfnYo0Ap5XnVP/Pr4Pjp8nXND/sQ8mQDA=
X-Google-Smtp-Source: AGHT+IGjgsoI5yZm8C57zgplRuOVfppUXRuBk3Gg7tfT+i0TOtYA11WUmQaaxVm5TWzLCXaYb5/cNQT19t/G2cKSXec=
X-Received: by 2002:a67:e08c:0:b0:457:c18c:e0b0 with SMTP id
 f12-20020a67e08c000000b00457c18ce0b0mr1414942vsl.11.1697181706247; Fri, 13
 Oct 2023 00:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231003140637.31346-1-etienne.carriere@foss.st.com>
 <20231003140637.31346-4-etienne.carriere@foss.st.com> <CAFA6WYOMHWFytm4cYy3kQf4E3qiytrnOTVY1gb2rzTDece490w@mail.gmail.com>
 <bbb5ca0809954bee94c5f2886427f886@foss.st.com>
In-Reply-To: <bbb5ca0809954bee94c5f2886427f886@foss.st.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 13 Oct 2023 12:51:35 +0530
Message-ID: <CAFA6WYMKrB7xkOaef41LyVKHGAt8Dk0hbFUkiqubeZbJVY=9kw@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] tee: optee: support tracking system threads
To:     Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 12:41, Etienne CARRIERE - foss
<etienne.carriere@foss.st.com> wrote:
>
> > From: Sumit Garg <sumit.garg@linaro.org>
> > Sent: Friday, October 6, 2023 11:33 AM
> >
> > On Tue, 3 Oct 2023 at 19:36, Etienne Carriere
> > <etienne.carriere@foss.st.com> wrote:
> > >
> > > Adds support in the OP-TEE driver to keep track of reserved system
> > > threads. The logic allows one OP-TEE thread to be reserved to TEE system
> > > sessions.
> > >
> > > The optee_cq_*() functions are updated to handle this if enabled,
> > > that is when TEE describes how many thread context it supports
> > > and when at least 1 session has registered as a system session
> > > (using tee_client_system_session()).
> > >
> > > For sake of simplicity, initialization of call queue management
> > > is factorized into new helper function optee_cq_init().
> > >
> > > The SMC ABI part of the driver enables this tracking, but the
> > > FF-A ABI part does not.
> > >
> > >
> > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > ---
> > > Changes since v9:
> > > - Add a reference counter for TEE system thread provisioning. We reserve
> > >   a TEE thread context for system session only when there is at least
> > >   1 opened system session.
> > > - Use 2 wait queue lists, normal_waiters and sys_waiter, as proposed in
> > >   patch v8. Using a single list can prevent a waiting system thread from
> > >   being resumed if the executing system thread wakes a normal waiter in
> > >   the list.
> >
> > How would that be possible? The system thread wakeup
> > (free_thread_threshold = 0) is given priority over normal thread
> > wakeup (free_thread_threshold = 1). I think a single queue list would
> > be sufficient as demonstrated in v9.
> >
>
> Hello Sumit,
>
> I think a system session can be trapped waiting when using a single queue list.
> To have a chance to reach the TEE, a waiting thread must wait that a TEE thread comes out of the TEE and calls complete() on the waitqueue to wake next waiter.
>
> To illustrate, consider a 10 TEE threads configuration on TEE side (::total_thread_count=10 at init),
> and several TEE clients in Linux OS, including 2 system sessions, from 2 consumer drivers (::sys_thread_req_count=2).
>
> Imagine the 9 normal threads and the 1 system thread are in use. (::free_thread_count=0),
> Now comes the other system session: it goes to the waitqueue list.
> Now comes a normal session invocation: it goes to the waitqueue list, 1st position.
>
> Now, TEE system thread returns to Linux:
> It increments the counter, ::free_thread_count=1, and calls complete() for the waitequeue.
> The 1st element in the waitqueue list is the last entered normal session invocation.
> However, that waiter won't switch local boolean 'need_wait'  to false because ::free_thread_count=1 and ::sys_thread_req_count!=0.
> So no attempt to reach TEE and wake another waiter on return.
> At that point there is a system session in the waitqueue list that could enter TEE (::free_thread_count=1) but is waiting someone returns from the TEE.

I suppose the following loop tries to wake-up every waiter to give
them a chance to enter OP-TEE. So with that system session would
always be prefered over normal session, right?

static void optee_cq_complete_one(struct optee_call_queue *cq)
{
        struct optee_call_waiter *w;

        list_for_each_entry(w, &cq->waiters, list_node) {
                if (!completion_done(&w->c)) {
                        complete(&w->c);
                        break;
                }
        }
}

-Sumit

>
> With 2 lists, we first treat system sessions to overcome that.
> Am I missing something?
>
> Best regards,
> Etienne
>
> > -Sumit
> >
> > > - Updated my e-mail address.
> > > - Rephrased a bit the commit message.
> > >
> > > Changes since patch v8
> > > - Patch v9 (reference below) attempted to simplify the implementation
> > >   https://lore.kernel.org/lkml/20230517143311.585080-1-sumit.garg@linaro.org/#t
> > >
> > > Changes since v7:
> > > - Changes the logic to reserve at most 1 call entry for system sessions
> > >   as per patches v6 and v7 discussion threads (the 2 below bullets)
> > >   and updates commit message accordingly.
> > > - Field optee_call_queue::res_sys_thread_count is replaced with 2 fields:
> > >   sys_thread_req_count and boolean sys_thread_in_use.
> > > - Field optee_call_waiter::sys_thread is replaced with 2 fields:
> > >   sys_thread_req and sys_thread_used.
> > > - Adds inline description comments for struct optee_call_queue and
> > >   struct optee_call_waiter.
> > >
> > > Changes since v6:
> > > - Moved out changes related to adding boolean system thread attribute
> > >   into optee driver call queue and SMC/FF-A ABIs API functions. These
> > >   changes were squashed into patch 1/4 of this patch v7 series.
> > > - Comment about adding a specific commit for call queue refactoring
> > >   was not addressed such a patch would only introduce function
> > >   optee_cq_init()  with very little content in (mutex & list init).
> > > - Added Co-developed-by tag for Jens contribution as he's not responsible
> > >   for the changes I made in this patch v7.
> > >
> > > No change since v5
> > >
> > > Changes since v4:
> > > - New change that supersedes implementation proposed in PATCH v4
> > >   (tee: system invocation"). Thanks to Jens implementation we don't need
> > >   the new OP-TEE services that my previous patch versions introduced to
> > >   monitor system threads entry. Now, Linux optee SMC ABI driver gets TEE
> > >   provisioned thread contexts count once and monitors thread entries in
> > >   OP-TEE on that basis and the system thread capability of the related
> > >   tee session. By the way, I dropped the WARN_ONCE() call I suggested
> > >   on tee thread exhaustion as it does not provides useful information.
> > > ---
> > >  drivers/tee/optee/call.c          | 128 ++++++++++++++++++++++++++++--
> > >  drivers/tee/optee/ffa_abi.c       |   3 +-
> > >  drivers/tee/optee/optee_private.h |  24 +++++-
> > >  drivers/tee/optee/smc_abi.c       |  16 +++-
> > >  4 files changed, 159 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > index 152ae9bb1785..38543538d77b 100644
> > > --- a/drivers/tee/optee/call.c
> > > +++ b/drivers/tee/optee/call.c
> > > @@ -39,9 +39,31 @@ struct optee_shm_arg_entry {
> > >         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
> > >  };
> > >
> > > +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> > > +{
> > > +       mutex_init(&cq->mutex);
> > > +       INIT_LIST_HEAD(&cq->sys_waiters);
> > > +       INIT_LIST_HEAD(&cq->normal_waiters);
> > > +
> > > +       /*
> > > +        * If cq->total_thread_count is 0 then we're not trying to keep
> > > +        * track of how many free threads we have, instead we're relying on
> > > +        * the secure world to tell us when we're out of thread and have to
> > > +        * wait for another thread to become available.
> > > +        */
> > > +       cq->total_thread_count = thread_count;
> > > +       cq->free_thread_count = thread_count;
> > > +}
> > > +
> > >  void optee_cq_wait_init(struct optee_call_queue *cq,
> > >                         struct optee_call_waiter *w, bool sys_thread)
> > >  {
> > > +       unsigned int free_thread_threshold;
> > > +       bool need_wait = false;
> > > +
> > > +       memset(w, 0, sizeof(*w));
> > > +       w->sys_thread = sys_thread;
> > > +
> > >         /*
> > >          * We're preparing to make a call to secure world. In case we can't
> > >          * allocate a thread in secure world we'll end up waiting in
> > > @@ -53,15 +75,47 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
> > >         mutex_lock(&cq->mutex);
> > >
> > >         /*
> > > -        * We add ourselves to the queue, but we don't wait. This
> > > -        * guarantees that we don't lose a completion if secure world
> > > -        * returns busy and another thread just exited and try to complete
> > > -        * someone.
> > > +        * We add ourselves to a queue, but we don't wait. This guarantees
> > > +        * that we don't lose a completion if secure world returns busy and
> > > +        * another thread just exited and try to complete someone.
> > >          */
> > >         init_completion(&w->c);
> > > -       list_add_tail(&w->list_node, &cq->waiters);
> > > +
> > > +       if (sys_thread)
> > > +               list_add_tail(&w->list_node, &cq->sys_waiters);
> > > +       else
> > > +               list_add_tail(&w->list_node, &cq->normal_waiters);
> > > +
> > > +       if (cq->total_thread_count) {
> > > +               if (sys_thread || !cq->sys_thread_req_count)
> > > +                       free_thread_threshold = 0;
> > > +               else
> > > +                       free_thread_threshold = 1;
> > > +
> > > +               if (cq->free_thread_count > free_thread_threshold)
> > > +                       cq->free_thread_count--;
> > > +               else
> > > +                       need_wait = true;
> > > +       }
> > >
> > >         mutex_unlock(&cq->mutex);
> > > +
> > > +       while (need_wait) {
> > > +               optee_cq_wait_for_completion(cq, w);
> > > +               mutex_lock(&cq->mutex);
> > > +
> > > +               if (sys_thread || !cq->sys_thread_req_count)
> > > +                       free_thread_threshold = 0;
> > > +               else
> > > +                       free_thread_threshold = 1;
> > > +
> > > +               if (cq->free_thread_count > free_thread_threshold) {
> > > +                       cq->free_thread_count--;
> > > +                       need_wait = false;
> > > +               }
> > > +
> > > +               mutex_unlock(&cq->mutex);
> > > +       }
> > >  }
> > >
> > >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > > @@ -74,7 +128,11 @@ void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > >         /* Move to end of list to get out of the way for other waiters */
> > >         list_del(&w->list_node);
> > >         reinit_completion(&w->c);
> > > -       list_add_tail(&w->list_node, &cq->waiters);
> > > +
> > > +       if (w->sys_thread)
> > > +               list_add_tail(&w->list_node, &cq->sys_waiters);
> > > +       else
> > > +               list_add_tail(&w->list_node, &cq->normal_waiters);
> > >
> > >         mutex_unlock(&cq->mutex);
> > >  }
> > > @@ -83,7 +141,15 @@ static void optee_cq_complete_one(struct optee_call_queue *cq)
> > >  {
> > >         struct optee_call_waiter *w;
> > >
> > > -       list_for_each_entry(w, &cq->waiters, list_node) {
> > > +       /* Wake waiting system session first */
> > > +       list_for_each_entry(w, &cq->sys_waiters, list_node) {
> > > +               if (!completion_done(&w->c)) {
> > > +                       complete(&w->c);
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       list_for_each_entry(w, &cq->normal_waiters, list_node) {
> > >                 if (!completion_done(&w->c)) {
> > >                         complete(&w->c);
> > >                         break;
> > > @@ -104,6 +170,8 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
> > >         /* Get out of the list */
> > >         list_del(&w->list_node);
> > >
> > > +       cq->free_thread_count++;
> > > +
> > >         /* Wake up one eventual waiting task */
> > >         optee_cq_complete_one(cq);
> > >
> > > @@ -119,6 +187,28 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
> > >         mutex_unlock(&cq->mutex);
> > >  }
> > >
> > > +/* Count registered system sessions to reserved a system thread or not */
> > > +static bool optee_cq_incr_sys_thread_count(struct optee_call_queue *cq)
> > > +{
> > > +       if (cq->total_thread_count <= 1)
> > > +               return false;
> > > +
> > > +       mutex_lock(&cq->mutex);
> > > +       cq->sys_thread_req_count++;
> > > +       mutex_unlock(&cq->mutex);
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +static void optee_cq_decr_sys_thread_count(struct optee_call_queue *cq)
> > > +{
> > > +       mutex_lock(&cq->mutex);
> > > +       cq->sys_thread_req_count--;
> > > +       /* If there's someone waiting, let it resume */
> > > +       optee_cq_complete_one(cq);
> > > +       mutex_unlock(&cq->mutex);
> > > +}
> > > +
> > >  /* Requires the filpstate mutex to be held */
> > >  static struct optee_session *find_session(struct optee_context_data *ctxdata,
> > >                                           u32 session_id)
> > > @@ -361,6 +451,27 @@ int optee_open_session(struct tee_context *ctx,
> > >         return rc;
> > >  }
> > >
> > > +int optee_system_session(struct tee_context *ctx, u32 session)
> > > +{
> > > +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> > > +       struct optee_context_data *ctxdata = ctx->data;
> > > +       struct optee_session *sess;
> > > +       int rc = -EINVAL;
> > > +
> > > +       mutex_lock(&ctxdata->mutex);
> > > +
> > > +       sess = find_session(ctxdata, session);
> > > +       if (sess && (sess->use_sys_thread ||
> > > +                    optee_cq_incr_sys_thread_count(&optee->call_queue))) {
> > > +               sess->use_sys_thread = true;
> > > +               rc = 0;
> > > +       }
> > > +
> > > +       mutex_unlock(&ctxdata->mutex);
> > > +
> > > +       return rc;
> > > +}
> > > +
> > >  int optee_close_session_helper(struct tee_context *ctx, u32 session,
> > >                                bool system_thread)
> > >  {
> > > @@ -380,6 +491,9 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session,
> > >
> > >         optee_free_msg_arg(ctx, entry, offs);
> > >
> > > +       if (system_thread)
> > > +               optee_cq_decr_sys_thread_count(&optee->call_queue);
> > > +
> > >         return 0;
> > >  }
> > >
> > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > > index 5fde9d4100e3..0c9055691343 100644
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -852,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > >         if (rc)
> > >                 goto err_unreg_supp_teedev;
> > >         mutex_init(&optee->ffa.mutex);
> > > -       mutex_init(&optee->call_queue.mutex);
> > > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > > +       optee_cq_init(&optee->call_queue, 0);
> > >         optee_supp_init(&optee->supp);
> > >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > >         ffa_dev_set_drvdata(ffa_dev, optee);
> > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > > index b68273051454..69f6397c3646 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -40,15 +40,35 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
> > >                                 unsigned long, unsigned long,
> > >                                 struct arm_smccc_res *);
> > >
> > > +/*
> > > + * struct optee_call_waiter - TEE entry may need to wait for a free TEE thread
> > > + * @list_node          Reference in waiters list
> > > + * @c                  Waiting completion reference
> > > + * @sys_thread_req     True if waiter belongs to a system thread
> > > + */
> > >  struct optee_call_waiter {
> > >         struct list_head list_node;
> > >         struct completion c;
> > > +       bool sys_thread;
> > >  };
> > >
> > > +/*
> > > + * struct optee_call_queue - OP-TEE call queue management
> > > + * @mutex                      Serializes access to this struct
> > > + * @sys_waiters                        List of system threads waiting to enter OP-TEE
> > > + * @normal_waiters             List of normal threads waiting to enter OP-TEE
> > > + * @total_thread_count         Overall number of thread context in OP-TEE or 0
> > > + * @free_thread_count          Number of threads context free in OP-TEE
> > > + * @sys_thread_req_count       Number of registered system thread sessions
> > > + */
> > >  struct optee_call_queue {
> > >         /* Serializes access to this struct */
> > >         struct mutex mutex;
> > > -       struct list_head waiters;
> > > +       struct list_head sys_waiters;
> > > +       struct list_head normal_waiters;
> > > +       int total_thread_count;
> > > +       int free_thread_count;
> > > +       int sys_thread_req_count;
> > >  };
> > >
> > >  struct optee_notif {
> > > @@ -254,6 +274,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
> > >  int optee_open_session(struct tee_context *ctx,
> > >                        struct tee_ioctl_open_session_arg *arg,
> > >                        struct tee_param *param);
> > > +int optee_system_session(struct tee_context *ctx, u32 session);
> > >  int optee_close_session_helper(struct tee_context *ctx, u32 session,
> > >                                bool system_thread);
> > >  int optee_close_session(struct tee_context *ctx, u32 session);
> > > @@ -303,6 +324,7 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
> > >         mp->u.value.c = p->u.value.c;
> > >  }
> > >
> > > +void optee_cq_init(struct optee_call_queue *cq, int thread_count);
> > >  void optee_cq_wait_init(struct optee_call_queue *cq,
> > >                         struct optee_call_waiter *w, bool sys_thread);
> > >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > index 1033d7da03ea..5595028d6dae 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -1211,6 +1211,7 @@ static const struct tee_driver_ops optee_clnt_ops = {
> > >         .release = optee_release,
> > >         .open_session = optee_open_session,
> > >         .close_session = optee_close_session,
> > > +       .system_session = optee_system_session,
> > >         .invoke_func = optee_invoke_func,
> > >         .cancel_req = optee_cancel_req,
> > >         .shm_register = optee_shm_register,
> > > @@ -1358,6 +1359,16 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> > >         return true;
> > >  }
> > >
> > > +static unsigned int optee_msg_get_thread_count(optee_invoke_fn *invoke_fn)
> > > +{
> > > +       struct arm_smccc_res res;
> > > +
> > > +       invoke_fn(OPTEE_SMC_GET_THREAD_COUNT, 0, 0, 0, 0, 0, 0, 0, &res);
> > > +       if (res.a0)
> > > +               return 0;
> > > +       return res.a1;
> > > +}
> > > +
> > >  static struct tee_shm_pool *
> > >  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> > >  {
> > > @@ -1610,6 +1621,7 @@ static int optee_probe(struct platform_device *pdev)
> > >         struct optee *optee = NULL;
> > >         void *memremaped_shm = NULL;
> > >         unsigned int rpc_param_count;
> > > +       unsigned int thread_count;
> > >         struct tee_device *teedev;
> > >         struct tee_context *ctx;
> > >         u32 max_notif_value;
> > > @@ -1637,6 +1649,7 @@ static int optee_probe(struct platform_device *pdev)
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       thread_count = optee_msg_get_thread_count(invoke_fn);
> > >         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
> > >                                              &max_notif_value,
> > >                                              &rpc_param_count)) {
> > > @@ -1726,8 +1739,7 @@ static int optee_probe(struct platform_device *pdev)
> > >         if (rc)
> > >                 goto err_unreg_supp_teedev;
> > >
> > > -       mutex_init(&optee->call_queue.mutex);
> > > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > > +       optee_cq_init(&optee->call_queue, thread_count);
> > >         optee_supp_init(&optee->supp);
> > >         optee->smc.memremaped_shm = memremaped_shm;
> > >         optee->pool = pool;
> > > --
> > > 2.25.1
> > >
> >
