Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D717C8087
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjJMIjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjJMIju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:39:50 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB88D7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:39:46 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39D3HWrk011790;
        Fri, 13 Oct 2023 10:39:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        selector1; bh=lLWRGcpoJxZEbWl/zj6SKPdWLPfuI6zV+AwBoP9E910=; b=cw
        48LmIB1kTpSg72/AB7UgyOeZ1CHF2qsdM9TsmYrCDJr9HLJP6YpdRxcVlTXGjKVP
        yYPIH3etu2vI+Lpw37fL22KHKM3KQvhJcb32X6TRMIodlcxilWp2+D40dj5qR7p4
        2svMEnm8zTkhxKQsJtKt+Wd8JJ0bhyCJDQM/viyguz8aFV/MbkxmwWMs1+cU7sFc
        4+NsodpS5YvnGl/WGMelMOokLjlV1clJ8UDVEpiXS0dZruqJU/JPoeLhGKXU0uNh
        msXI/3nS4Vor6dOhT7FnwgE62OzdM1THV7ky7KC9rAsUjAmauuuSjo58IV42Ucdg
        FLcT6gZqudDzRiT3ZiWA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tnp24tpkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 10:39:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95773100056;
        Fri, 13 Oct 2023 10:39:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46923215BEF;
        Fri, 13 Oct 2023 10:39:34 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:39:34 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1]) by
 SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1%14]) with mapi id
 15.01.2507.027; Fri, 13 Oct 2023 10:39:34 +0200
From:   Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jens Wiklander" <jens.wiklander@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH v10 3/4] tee: optee: support tracking system threads
Thread-Topic: [PATCH v10 3/4] tee: optee: support tracking system threads
Thread-Index: AQHZ9gLa0eDXIY4qt063d7Hb9IRsn7A8YsSAgAfLecSAAxABgIAANORE
Date:   Fri, 13 Oct 2023 08:39:33 +0000
Message-ID: <5ba5ab8d2cc7477588dd0f6c7531cf16@foss.st.com>
References: <20231003140637.31346-1-etienne.carriere@foss.st.com>
 <20231003140637.31346-4-etienne.carriere@foss.st.com>
 <CAFA6WYOMHWFytm4cYy3kQf4E3qiytrnOTVY1gb2rzTDece490w@mail.gmail.com>
 <bbb5ca0809954bee94c5f2886427f886@foss.st.com>,<CAFA6WYMKrB7xkOaef41LyVKHGAt8Dk0hbFUkiqubeZbJVY=9kw@mail.gmail.com>
In-Reply-To: <CAFA6WYMKrB7xkOaef41LyVKHGAt8Dk0hbFUkiqubeZbJVY=9kw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.20.20]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sumit Garg <sumit.garg@linaro.org>
> Sent: Friday, October 13, 2023 9:21 AM
>=20
> On Wed, 11 Oct 2023 at 12:41, Etienne CARRIERE - foss
> <etienne.carriere@foss.st.com> wrote:
> >
> > > From: Sumit Garg <sumit.garg@linaro.org>
> > > Sent: Friday, October 6, 2023 11:33 AM
> > >
> > > On Tue, 3 Oct 2023 at 19:36, Etienne Carriere
> > > <etienne.carriere@foss.st.com> wrote:
> > > >
> > > > Adds support in the OP-TEE driver to keep track of reserved system
> > > > threads. The logic allows one OP-TEE thread to be reserved to TEE s=
ystem
> > > > sessions.
> > > >
> > > > The optee_cq_*() functions are updated to handle this if enabled,
> > > > that is when TEE describes how many thread context it supports
> > > > and when at least 1 session has registered as a system session
> > > > (using tee_client_system_session()).
> > > >
> > > > For sake of simplicity, initialization of call queue management
> > > > is factorized into new helper function optee_cq_init().
> > > >
> > > > The SMC ABI part of the driver enables this tracking, but the
> > > > FF-A ABI part does not.
> > > >
> > > >
> > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > > ---
> > > > Changes since v9:
> > > > - Add a reference counter for TEE system thread provisioning. We re=
serve
> > > >   a TEE thread context for system session only when there is at lea=
st
> > > >   1 opened system session.
> > > > - Use 2 wait queue lists, normal_waiters and sys_waiter, as propose=
d in
> > > >   patch v8. Using a single list can prevent a waiting system thread=
 from
> > > >   being resumed if the executing system thread wakes a normal waite=
r in
> > > >   the list.
> > >
> > > How would that be possible? The system thread wakeup
> > > (free_thread_threshold =3D 0) is given priority over normal thread
> > > wakeup (free_thread_threshold =3D 1). I think a single queue list wou=
ld
> > > be sufficient as demonstrated in v9.
> > >
> >
> > Hello Sumit,
> >
> > I think a system session can be trapped waiting when using a single que=
ue list.
> > To have a chance to reach the TEE, a waiting thread must wait that a TE=
E thread comes out of the TEE and calls complete() on the waitqueue to wake=
 next waiter.
> >
> > To illustrate, consider a 10 TEE threads configuration on TEE side (::t=
otal_thread_count=3D10 at init),
> > and several TEE clients in Linux OS, including 2 system sessions, from =
2 consumer drivers (::sys_thread_req_count=3D2).
> >
> > Imagine the 9 normal threads and the 1 system thread are in use. (::fre=
e_thread_count=3D0),
> > Now comes the other system session: it goes to the waitqueue list.
> > Now comes a normal session invocation: it goes to the waitqueue list, 1=
st position.
> >
> > Now, TEE system thread returns to Linux:
> > It increments the counter, ::free_thread_count=3D1, and calls complete(=
) for the waitequeue.
> > The 1st element in the waitqueue list is the last entered normal sessio=
n invocation.
> > However, that waiter won't switch local boolean 'need_wait'  to false b=
ecause ::free_thread_count=3D1 and ::sys_thread_req_count!=3D0.
> > So no attempt to reach TEE and wake another waiter on return.
> > At that point there is a system session in the waitqueue list that coul=
d enter TEE (::free_thread_count=3D1) but is waiting someone returns from t=
he TEE.
>=20
> I suppose the following loop tries to wake-up every waiter to give
> them a chance to enter OP-TEE. So with that system session would
> always be prefered over normal session, right?

No, the below loop will wake only the 1st waiter it finds in the list that =
is
current waiting (completion_done() returns false). So if it finds a normal
session, it will only wake this one which, in turn, will not try to reach t=
he
TEE from the while(need_wiat) loop in optee_cq_wait_init(), because there i=
s
not enough free threads. Because it does not reach the TEE, it will not
it wake another waiter.

>=20
> static void optee_cq_complete_one(struct optee_call_queue *cq)
> {
>         struct optee_call_waiter *w;
>=20
>         list_for_each_entry(w, &cq->waiters, list_node) {
>                 if (!completion_done(&w->c)) {
>                         complete(&w->c);
>                         break;
>                 }
>         }
> }
>=20
> -Sumit
>=20

Note I've found a error in this patch v10, see below.

BR,
Etienne


> >
> > With 2 lists, we first treat system sessions to overcome that.
> > Am I missing something?
> >
> > Best regards,
> > Etienne
> >
> > > -Sumit
> > >
> > > > - Updated my e-mail address.
> > > > - Rephrased a bit the commit message.
> > > >
> > > > Changes since patch v8
> > > > - Patch v9 (reference below) attempted to simplify the implementati=
on
> > > >   https://lore.kernel.org/lkml/20230517143311.585080-1-sumit.garg@l=
inaro.org/#t
> > > >
> > > > Changes since v7:
> > > > - Changes the logic to reserve at most 1 call entry for system sess=
ions
> > > >   as per patches v6 and v7 discussion threads (the 2 below bullets)
> > > >   and updates commit message accordingly.
> > > > - Field optee_call_queue::res_sys_thread_count is replaced with 2 f=
ields:
> > > >   sys_thread_req_count and boolean sys_thread_in_use.
> > > > - Field optee_call_waiter::sys_thread is replaced with 2 fields:
> > > >   sys_thread_req and sys_thread_used.
> > > > - Adds inline description comments for struct optee_call_queue and
> > > >   struct optee_call_waiter.
> > > >
> > > > Changes since v6:
> > > > - Moved out changes related to adding boolean system thread attribu=
te
> > > >   into optee driver call queue and SMC/FF-A ABIs API functions. The=
se
> > > >   changes were squashed into patch 1/4 of this patch v7 series.
> > > > - Comment about adding a specific commit for call queue refactoring
> > > >   was not addressed such a patch would only introduce function
> > > >   optee_cq_init()  with very little content in (mutex & list init).
> > > > - Added Co-developed-by tag for Jens contribution as he's not respo=
nsible
> > > >   for the changes I made in this patch v7.
> > > >
> > > > No change since v5
> > > >
> > > > Changes since v4:
> > > > - New change that supersedes implementation proposed in PATCH v4
> > > >   (tee: system invocation"). Thanks to Jens implementation we don't=
 need
> > > >   the new OP-TEE services that my previous patch versions introduce=
d to
> > > >   monitor system threads entry. Now, Linux optee SMC ABI driver get=
s TEE
> > > >   provisioned thread contexts count once and monitors thread entrie=
s in
> > > >   OP-TEE on that basis and the system thread capability of the rela=
ted
> > > >   tee session. By the way, I dropped the WARN_ONCE() call I suggest=
ed
> > > >   on tee thread exhaustion as it does not provides useful informati=
on.
> > > > ---
> > > >  drivers/tee/optee/call.c          | 128 ++++++++++++++++++++++++++=
++--
> > > >  drivers/tee/optee/ffa_abi.c       |   3 +-
> > > >  drivers/tee/optee/optee_private.h |  24 +++++-
> > > >  drivers/tee/optee/smc_abi.c       |  16 +++-
> > > >  4 files changed, 159 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > > index 152ae9bb1785..38543538d77b 100644
> > > > --- a/drivers/tee/optee/call.c
> > > > +++ b/drivers/tee/optee/call.c
> > > > @@ -39,9 +39,31 @@ struct optee_shm_arg_entry {
> > > >         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
> > > >  };
> > > >
> > > > +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> > > > +{
> > > > +       mutex_init(&cq->mutex);
> > > > +       INIT_LIST_HEAD(&cq->sys_waiters);
> > > > +       INIT_LIST_HEAD(&cq->normal_waiters);
> > > > +
> > > > +       /*
> > > > +        * If cq->total_thread_count is 0 then we're not trying to =
keep
> > > > +        * track of how many free threads we have, instead we're re=
lying on
> > > > +        * the secure world to tell us when we're out of thread and=
 have to
> > > > +        * wait for another thread to become available.
> > > > +        */
> > > > +       cq->total_thread_count =3D thread_count;
> > > > +       cq->free_thread_count =3D thread_count;
> > > > +}
> > > > +
> > > >  void optee_cq_wait_init(struct optee_call_queue *cq,
> > > >                         struct optee_call_waiter *w, bool sys_threa=
d)
> > > >  {
> > > > +       unsigned int free_thread_threshold;
> > > > +       bool need_wait =3D false;
> > > > +
> > > > +       memset(w, 0, sizeof(*w));
> > > > +       w->sys_thread =3D sys_thread;
> > > > +
> > > >         /*
> > > >          * We're preparing to make a call to secure world. In case =
we can't
> > > >          * allocate a thread in secure world we'll end up waiting i=
n
> > > > @@ -53,15 +75,47 @@ void optee_cq_wait_init(struct optee_call_queue=
 *cq,
> > > >         mutex_lock(&cq->mutex);
> > > >
> > > >         /*
> > > > -        * We add ourselves to the queue, but we don't wait. This
> > > > -        * guarantees that we don't lose a completion if secure wor=
ld
> > > > -        * returns busy and another thread just exited and try to c=
omplete
> > > > -        * someone.
> > > > +        * We add ourselves to a queue, but we don't wait. This gua=
rantees
> > > > +        * that we don't lose a completion if secure world returns =
busy and
> > > > +        * another thread just exited and try to complete someone.
> > > >          */
> > > >         init_completion(&w->c);
> > > > -       list_add_tail(&w->list_node, &cq->waiters);
> > > > +
> > > > +       if (sys_thread)
> > > > +               list_add_tail(&w->list_node, &cq->sys_waiters);
> > > > +       else
> > > > +               list_add_tail(&w->list_node, &cq->normal_waiters);
> > > > +
> > > > +       if (cq->total_thread_count) {
> > > > +               if (sys_thread || !cq->sys_thread_req_count)
> > > > +                       free_thread_threshold =3D 0;
> > > > +               else
> > > > +                       free_thread_threshold =3D 1;
> > > > +
> > > > +               if (cq->free_thread_count > free_thread_threshold)
> > > > +                       cq->free_thread_count--;
> > > > +               else
> > > > +                       need_wait =3D true;
> > > > +       }
> > > >
> > > >         mutex_unlock(&cq->mutex);
> > > > +
> > > > +       while (need_wait) {
> > > > +               optee_cq_wait_for_completion(cq, w);
> > > > +               mutex_lock(&cq->mutex);
> > > > +
> > > > +               if (sys_thread || !cq->sys_thread_req_count)
> > > > +                       free_thread_threshold =3D 0;
> > > > +               else
> > > > +                       free_thread_threshold =3D 1;
> > > > +
> > > > +               if (cq->free_thread_count > free_thread_threshold) =
{
> > > > +                       cq->free_thread_count--;
> > > > +                       need_wait =3D false;
> > > > +               }
> > > > +
> > > > +               mutex_unlock(&cq->mutex);
> > > > +       }
> > > >  }
> > > >
> > > >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > > > @@ -74,7 +128,11 @@ void optee_cq_wait_for_completion(struct optee_=
call_queue *cq,
> > > >         /* Move to end of list to get out of the way for other wait=
ers */
> > > >         list_del(&w->list_node);
> > > >         reinit_completion(&w->c);
> > > > -       list_add_tail(&w->list_node, &cq->waiters);
> > > > +
> > > > +       if (w->sys_thread)
> > > > +               list_add_tail(&w->list_node, &cq->sys_waiters);
> > > > +       else
> > > > +               list_add_tail(&w->list_node, &cq->normal_waiters);
> > > >
> > > >         mutex_unlock(&cq->mutex);
> > > >  }
> > > > @@ -83,7 +141,15 @@ static void optee_cq_complete_one(struct optee_=
call_queue *cq)
> > > >  {
> > > >         struct optee_call_waiter *w;
> > > >
> > > > -       list_for_each_entry(w, &cq->waiters, list_node) {
> > > > +       /* Wake waiting system session first */
> > > > +       list_for_each_entry(w, &cq->sys_waiters, list_node) {
> > > > +               if (!completion_done(&w->c)) {
> > > > +                       complete(&w->c);
> > > > +                       break;

I see a bug here. The loop should return straight (s/break/return/)
without attempting to wake a normal waiter.

> > > > +               }
> > > > +       }
> > > > +
> > > > +       list_for_each_entry(w, &cq->normal_waiters, list_node) {
> > > >                 if (!completion_done(&w->c)) {
> > > >                         complete(&w->c);
> > > >                         break;
> > > > @@ -104,6 +170,8 @@ void optee_cq_wait_final(struct optee_call_queu=
e *cq,
> > > >         /* Get out of the list */
> > > >         list_del(&w->list_node);
> > > >
> > > > +       cq->free_thread_count++;
> > > > +
> > > >         /* Wake up one eventual waiting task */
> > > >         optee_cq_complete_one(cq);
> > > >
> > > > @@ -119,6 +187,28 @@ void optee_cq_wait_final(struct optee_call_que=
ue *cq,
> > > >         mutex_unlock(&cq->mutex);
> > > >  }
> > > >
> > > > +/* Count registered system sessions to reserved a system thread or=
 not */
> > > > +static bool optee_cq_incr_sys_thread_count(struct optee_call_queue=
 *cq)
> > > > +{
> > > > +       if (cq->total_thread_count <=3D 1)
> > > > +               return false;
> > > > +
> > > > +       mutex_lock(&cq->mutex);
> > > > +       cq->sys_thread_req_count++;
> > > > +       mutex_unlock(&cq->mutex);
> > > > +
> > > > +       return true;
> > > > +}
> > > > +
> > > > +static void optee_cq_decr_sys_thread_count(struct optee_call_queue=
 *cq)
> > > > +{
> > > > +       mutex_lock(&cq->mutex);
> > > > +       cq->sys_thread_req_count--;
> > > > +       /* If there's someone waiting, let it resume */
> > > > +       optee_cq_complete_one(cq);
> > > > +       mutex_unlock(&cq->mutex);
> > > > +}
> > > > +
> > > >  /* Requires the filpstate mutex to be held */
> > > >  static struct optee_session *find_session(struct optee_context_dat=
a *ctxdata,
> > > >                                           u32 session_id)
> > > > @@ -361,6 +451,27 @@ int optee_open_session(struct tee_context *ctx=
,
> > > >         return rc;
> > > >  }
> > > >
> > > > +int optee_system_session(struct tee_context *ctx, u32 session)
> > > > +{
> > > > +       struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> > > > +       struct optee_context_data *ctxdata =3D ctx->data;
> > > > +       struct optee_session *sess;
> > > > +       int rc =3D -EINVAL;
> > > > +
> > > > +       mutex_lock(&ctxdata->mutex);
> > > > +
> > > > +       sess =3D find_session(ctxdata, session);
> > > > +       if (sess && (sess->use_sys_thread ||
> > > > +                    optee_cq_incr_sys_thread_count(&optee->call_qu=
eue))) {
> > > > +               sess->use_sys_thread =3D true;
> > > > +               rc =3D 0;
> > > > +       }
> > > > +
> > > > +       mutex_unlock(&ctxdata->mutex);
> > > > +
> > > > +       return rc;
> > > > +}
> > > > +
> > > >  int optee_close_session_helper(struct tee_context *ctx, u32 sessio=
n,
> > > >                                bool system_thread)
> > > >  {
> > > > @@ -380,6 +491,9 @@ int optee_close_session_helper(struct tee_conte=
xt *ctx, u32 session,
> > > >
> > > >         optee_free_msg_arg(ctx, entry, offs);
> > > >
> > > > +       if (system_thread)
> > > > +               optee_cq_decr_sys_thread_count(&optee->call_queue);
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_ab=
i.c
> > > > index 5fde9d4100e3..0c9055691343 100644
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -852,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >         if (rc)
> > > >                 goto err_unreg_supp_teedev;
> > > >         mutex_init(&optee->ffa.mutex);
> > > > -       mutex_init(&optee->call_queue.mutex);
> > > > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > > > +       optee_cq_init(&optee->call_queue, 0);
> > > >         optee_supp_init(&optee->supp);
> > > >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > >         ffa_dev_set_drvdata(ffa_dev, optee);
> > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/=
optee_private.h
> > > > index b68273051454..69f6397c3646 100644
> > > > --- a/drivers/tee/optee/optee_private.h
> > > > +++ b/drivers/tee/optee/optee_private.h
> > > > @@ -40,15 +40,35 @@ typedef void (optee_invoke_fn)(unsigned long, u=
nsigned long, unsigned long,
> > > >                                 unsigned long, unsigned long,
> > > >                                 struct arm_smccc_res *);
> > > >
> > > > +/*
> > > > + * struct optee_call_waiter - TEE entry may need to wait for a fre=
e TEE thread
> > > > + * @list_node          Reference in waiters list
> > > > + * @c                  Waiting completion reference
> > > > + * @sys_thread_req     True if waiter belongs to a system thread
> > > > + */
> > > >  struct optee_call_waiter {
> > > >         struct list_head list_node;
> > > >         struct completion c;
> > > > +       bool sys_thread;
> > > >  };
> > > >
> > > > +/*
> > > > + * struct optee_call_queue - OP-TEE call queue management
> > > > + * @mutex                      Serializes access to this struct
> > > > + * @sys_waiters                        List of system threads wait=
ing to enter OP-TEE
> > > > + * @normal_waiters             List of normal threads waiting to e=
nter OP-TEE
> > > > + * @total_thread_count         Overall number of thread context in=
 OP-TEE or 0
> > > > + * @free_thread_count          Number of threads context free in O=
P-TEE
> > > > + * @sys_thread_req_count       Number of registered system thread =
sessions
> > > > + */
> > > >  struct optee_call_queue {
> > > >         /* Serializes access to this struct */
> > > >         struct mutex mutex;
> > > > -       struct list_head waiters;
> > > > +       struct list_head sys_waiters;
> > > > +       struct list_head normal_waiters;
> > > > +       int total_thread_count;
> > > > +       int free_thread_count;
> > > > +       int sys_thread_req_count;
> > > >  };
> > > >
> > > >  struct optee_notif {
> > > > @@ -254,6 +274,7 @@ int optee_supp_send(struct tee_context *ctx, u3=
2 ret, u32 num_params,
> > > >  int optee_open_session(struct tee_context *ctx,
> > > >                        struct tee_ioctl_open_session_arg *arg,
> > > >                        struct tee_param *param);
> > > > +int optee_system_session(struct tee_context *ctx, u32 session);
> > > >  int optee_close_session_helper(struct tee_context *ctx, u32 sessio=
n,
> > > >                                bool system_thread);
> > > >  int optee_close_session(struct tee_context *ctx, u32 session);
> > > > @@ -303,6 +324,7 @@ static inline void optee_to_msg_param_value(str=
uct optee_msg_param *mp,
> > > >         mp->u.value.c =3D p->u.value.c;
> > > >  }
> > > >
> > > > +void optee_cq_init(struct optee_call_queue *cq, int thread_count);
> > > >  void optee_cq_wait_init(struct optee_call_queue *cq,
> > > >                         struct optee_call_waiter *w, bool sys_threa=
d);
> > > >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_ab=
i.c
> > > > index 1033d7da03ea..5595028d6dae 100644
> > > > --- a/drivers/tee/optee/smc_abi.c
> > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > @@ -1211,6 +1211,7 @@ static const struct tee_driver_ops optee_clnt=
_ops =3D {
> > > >         .release =3D optee_release,
> > > >         .open_session =3D optee_open_session,
> > > >         .close_session =3D optee_close_session,
> > > > +       .system_session =3D optee_system_session,
> > > >         .invoke_func =3D optee_invoke_func,
> > > >         .cancel_req =3D optee_cancel_req,
> > > >         .shm_register =3D optee_shm_register,
> > > > @@ -1358,6 +1359,16 @@ static bool optee_msg_exchange_capabilities(=
optee_invoke_fn *invoke_fn,
> > > >         return true;
> > > >  }
> > > >
> > > > +static unsigned int optee_msg_get_thread_count(optee_invoke_fn *in=
voke_fn)
> > > > +{
> > > > +       struct arm_smccc_res res;
> > > > +
> > > > +       invoke_fn(OPTEE_SMC_GET_THREAD_COUNT, 0, 0, 0, 0, 0, 0, 0, =
&res);
> > > > +       if (res.a0)
> > > > +               return 0;
> > > > +       return res.a1;
> > > > +}
> > > > +
> > > >  static struct tee_shm_pool *
> > > >  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memre=
maped_shm)
> > > >  {
> > > > @@ -1610,6 +1621,7 @@ static int optee_probe(struct platform_device=
 *pdev)
> > > >         struct optee *optee =3D NULL;
> > > >         void *memremaped_shm =3D NULL;
> > > >         unsigned int rpc_param_count;
> > > > +       unsigned int thread_count;
> > > >         struct tee_device *teedev;
> > > >         struct tee_context *ctx;
> > > >         u32 max_notif_value;
> > > > @@ -1637,6 +1649,7 @@ static int optee_probe(struct platform_device=
 *pdev)
> > > >                 return -EINVAL;
> > > >         }
> > > >
> > > > +       thread_count =3D optee_msg_get_thread_count(invoke_fn);
> > > >         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
> > > >                                              &max_notif_value,
> > > >                                              &rpc_param_count)) {
> > > > @@ -1726,8 +1739,7 @@ static int optee_probe(struct platform_device=
 *pdev)
> > > >         if (rc)
> > > >                 goto err_unreg_supp_teedev;
> > > >
> > > > -       mutex_init(&optee->call_queue.mutex);
> > > > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > > > +       optee_cq_init(&optee->call_queue, thread_count);
> > > >         optee_supp_init(&optee->supp);
> > > >         optee->smc.memremaped_shm =3D memremaped_shm;
> > > >         optee->pool =3D pool;
> > > > --
> > > > 2.25.1
> > > >
> > >
>=20
