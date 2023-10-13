Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758147C81E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjJMJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjJMJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:23:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F391BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:23:30 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39D9M2mT011772;
        Fri, 13 Oct 2023 11:23:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        selector1; bh=AbkDp6EXTnfmNephmxy/BVtJpgYnyMp/bPTqYSfArpc=; b=Q1
        Q8pACZkI0j9n7AugKRjNqvqgw1MJhHiGS/n7swzvFK9yF/jBJa4XZdDNNByt3xW0
        tLjHT4DqSXV7IGwfzaetpgs8c9FMfdgqcouU0hcmzk0PNiO6ZGZjZw/6UoU3YGcA
        6HBXnH02vO5w1p+reRb4IatfpmIBvgE3sqKZsS6l0cUVlAZi8Hid6qwxIvTjlhQg
        pjsakaRoTXto1dpLm6ySf+c38GPDFHMwLm/0b/OSQyjwf3NHBm5WykHKYQQGwzMm
        TTBkx4YCGqSyxd1TGUO6Wm9Eeb1VkkMGpA6+k0cu/reYtLTYq/J0OgOFZEks5LXt
        D7j/i2uw+75h+0deBaNw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tnp24twyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 11:23:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2A72210004F;
        Fri, 13 Oct 2023 11:23:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 21D1D2132EA;
        Fri, 13 Oct 2023 11:23:18 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 11:23:17 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1]) by
 SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1%14]) with mapi id
 15.01.2507.027; Fri, 13 Oct 2023 11:23:17 +0200
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
Thread-Index: AQHZ9gLa0eDXIY4qt063d7Hb9IRsn7A8YsSAgAfLecSAAxABgIAANORE///qbICAACKwag==
Date:   Fri, 13 Oct 2023 09:23:17 +0000
Message-ID: <adb7df76eb8f4a7399b89f681383df84@foss.st.com>
References: <20231003140637.31346-1-etienne.carriere@foss.st.com>
 <20231003140637.31346-4-etienne.carriere@foss.st.com>
 <CAFA6WYOMHWFytm4cYy3kQf4E3qiytrnOTVY1gb2rzTDece490w@mail.gmail.com>
 <bbb5ca0809954bee94c5f2886427f886@foss.st.com>
 <CAFA6WYMKrB7xkOaef41LyVKHGAt8Dk0hbFUkiqubeZbJVY=9kw@mail.gmail.com>
 <5ba5ab8d2cc7477588dd0f6c7531cf16@foss.st.com>,<CAFA6WYPRgAnq_WZGbqvrn4de9Gk9fzTDs+NmcWyFn-QAC2+c8w@mail.gmail.com>
In-Reply-To: <CAFA6WYPRgAnq_WZGbqvrn4de9Gk9fzTDs+NmcWyFn-QAC2+c8w@mail.gmail.com>
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
> Sent: Friday, October 13, 2023 11:13 AM
>=20
> On Fri, 13 Oct 2023 at 14:09, Etienne CARRIERE - foss
> <etienne.carriere@foss.st.com> wrote:
> >
> > > From: Sumit Garg <sumit.garg@linaro.org>
> > > Sent: Friday, October 13, 2023 9:21 AM
> > >
> > > On Wed, 11 Oct 2023 at 12:41, Etienne CARRIERE - foss
> > > <etienne.carriere@foss.st.com> wrote:
> > > >
> > > > > From: Sumit Garg <sumit.garg@linaro.org>
> > > > > Sent: Friday, October 6, 2023 11:33 AM
> > > > >
> > > > > On Tue, 3 Oct 2023 at 19:36, Etienne Carriere
> > > > > <etienne.carriere@foss.st.com> wrote:
> > > > > >
> > > > > > Adds support in the OP-TEE driver to keep track of reserved sys=
tem
> > > > > > threads. The logic allows one OP-TEE thread to be reserved to T=
EE system
> > > > > > sessions.
> > > > > >
> > > > > > The optee_cq_*() functions are updated to handle this if enable=
d,
> > > > > > that is when TEE describes how many thread context it supports
> > > > > > and when at least 1 session has registered as a system session
> > > > > > (using tee_client_system_session()).
> > > > > >
> > > > > > For sake of simplicity, initialization of call queue management
> > > > > > is factorized into new helper function optee_cq_init().
> > > > > >
> > > > > > The SMC ABI part of the driver enables this tracking, but the
> > > > > > FF-A ABI part does not.
> > > > > >
> > > > > >
> > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > > > > ---
> > > > > > Changes since v9:
> > > > > > - Add a reference counter for TEE system thread provisioning. W=
e reserve
> > > > > >   a TEE thread context for system session only when there is at=
 least
> > > > > >   1 opened system session.
> > > > > > - Use 2 wait queue lists, normal_waiters and sys_waiter, as pro=
posed in
> > > > > >   patch v8. Using a single list can prevent a waiting system th=
read from
> > > > > >   being resumed if the executing system thread wakes a normal w=
aiter in
> > > > > >   the list.
> > > > >
> > > > > How would that be possible? The system thread wakeup
> > > > > (free_thread_threshold =3D 0) is given priority over normal threa=
d
> > > > > wakeup (free_thread_threshold =3D 1). I think a single queue list=
 would
> > > > > be sufficient as demonstrated in v9.
> > > > >
> > > >
> > > > Hello Sumit,
> > > >
> > > > I think a system session can be trapped waiting when using a single=
 queue list.
> > > > To have a chance to reach the TEE, a waiting thread must wait that =
a TEE thread comes out of the TEE and calls complete() on the waitqueue to =
wake next waiter.
> > > >
> > > > To illustrate, consider a 10 TEE threads configuration on TEE side =
(::total_thread_count=3D10 at init),
> > > > and several TEE clients in Linux OS, including 2 system sessions, f=
rom 2 consumer drivers (::sys_thread_req_count=3D2).
> > > >
> > > > Imagine the 9 normal threads and the 1 system thread are in use. (:=
:free_thread_count=3D0),
> > > > Now comes the other system session: it goes to the waitqueue list.
> > > > Now comes a normal session invocation: it goes to the waitqueue lis=
t, 1st position.
> > > >
> > > > Now, TEE system thread returns to Linux:
> > > > It increments the counter, ::free_thread_count=3D1, and calls compl=
ete() for the waitequeue.
> > > > The 1st element in the waitqueue list is the last entered normal se=
ssion invocation.
> > > > However, that waiter won't switch local boolean 'need_wait'  to fal=
se because ::free_thread_count=3D1 and ::sys_thread_req_count!=3D0.
> > > > So no attempt to reach TEE and wake another waiter on return.
> > > > At that point there is a system session in the waitqueue list that =
could enter TEE (::free_thread_count=3D1) but is waiting someone returns fr=
om the TEE.
> > >
> > > I suppose the following loop tries to wake-up every waiter to give
> > > them a chance to enter OP-TEE. So with that system session would
> > > always be prefered over normal session, right?
> >
> > No, the below loop will wake only the 1st waiter it finds in the list t=
hat is
> > current waiting (completion_done() returns false). So if it finds a nor=
mal
> > session, it will only wake this one which, in turn, will not try to rea=
ch the
> > TEE from the while(need_wiat) loop in optee_cq_wait_init(), because the=
re is
> > not enough free threads. Because it does not reach the TEE, it will not
> > it wake another waiter.
> >
>=20
> Okay I see your point, so how about the following change on top of v9.
> I still think having 2 queues is an overkill here.
>=20
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index df5fb5410b72..47f57054d9b7 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -60,6 +60,7 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
>          */
>         init_completion(&w->c);
>         list_add_tail(&w->list_node, &cq->waiters);
> +       w->sys_thread =3D sys_thread;
>=20
> ...
>=20
> @@ -83,6 +84,14 @@ static void optee_cq_complete_one(struct
> optee_call_queue *cq)
>  {
>         struct optee_call_waiter *w;
>=20
> +       /* Try to wakeup system session capable threads first */
> +       list_for_each_entry(w, &cq->waiters, list_node) {
> +               if (!completion_done(&w->c) && w->sys_thread) {
> +                       complete(&w->c);
> +                       return;
> +               }
> +       }
> +

Indeed, looking for system sessions first in the list would address the iss=
ue.
I would test sys_thread firs: if (w->sys_thread && !completion_done(&w->c))

That said, is it better to have 2 lists or to have 1 list possibly scanned =
twice?
I'm fine with both ways.

etienne


>         list_for_each_entry(w, &cq->waiters, list_node) {
>                 if (!completion_done(&w->c)) {
>                         complete(&w->c);
> diff --git a/drivers/tee/optee/optee_private.h
> b/drivers/tee/optee/optee_private.h
> index 6bb5cae09688..a7817ce9f90f 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -43,6 +43,7 @@ typedef void (optee_invoke_fn)(unsigned long,
> unsigned long, unsigned long,
>  struct optee_call_waiter {
>         struct list_head list_node;
>         struct completion c;
> +       bool sys_thread;
>  };
>=20
>  struct optee_call_queue {
>=20
> -Sumit
>=20
> > >
> > > static void optee_cq_complete_one(struct optee_call_queue *cq)
> > > {
> > >         struct optee_call_waiter *w;
> > >
> > >         list_for_each_entry(w, &cq->waiters, list_node) {
> > >                 if (!completion_done(&w->c)) {
> > >                         complete(&w->c);
> > >                         break;
> > >                 }
> > >         }
> > > }
> > >
> > > -Sumit
> > >
> >
> > Note I've found a error in this patch v10, see below.
> >
> > BR,
> > Etienne
> >
> >
> > > >
> > > > With 2 lists, we first treat system sessions to overcome that.
> > > > Am I missing something?
> > > >
> > > > Best regards,
> > > > Etienne
> > > >
> > > > > -Sumit
> > > > >
(snip)=
