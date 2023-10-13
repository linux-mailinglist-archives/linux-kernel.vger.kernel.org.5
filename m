Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29207C8222
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjJMJg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJMJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:36:25 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB4B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:36:23 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4526b9404b0so2003942137.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697189782; x=1697794582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lWrKfgO6GCFnvp3qj4VKtZbTF6bfPvNcj2aZlqJdVVA=;
        b=O+5OYzRQvL0Cg6V4sZ0m75Lod0Ax1XpeLkxLjt4Tb8BNPIY7+EepckrlgxPZjFj0Y9
         kHkaMmQHRX7U0pIU9/Phw67wPN3d2XGjpYcZc+reNDMDX/IzYsf9WclbmPgYFkbSM8uZ
         TCk6zfJg3YEOZG+DctvuOens265EzBzYRwUyhEnDRElm8yhVnI61xjDJrz3suoUliSV6
         2Et8Khsqn8W9Y4bBofGCQupqoMm9H+SIkKGqdQjl4ceYoIgSXbceQGqN+Es6+mTQpwzZ
         AsEI5fbp5kre2mGVKbrVe/WiaCAL19K/BVFvI2OIkdR9rw9BdDzJwxiXAhzXtNzj4MNF
         /6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697189782; x=1697794582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWrKfgO6GCFnvp3qj4VKtZbTF6bfPvNcj2aZlqJdVVA=;
        b=bdcKUVEXOuLLoYT6jlZ4ZblXQEBRGf/aMXA0ilnnMTMfM+yH7/h+JwYe3xEipwyi1V
         /Un7HtAC6Ns5HWa2OCmhMomNfSvwfXonEfSYJBU2HLhTrWIT0MCWCIh4dUIvf2WLP4Q6
         Ox5oJWVPsFQL/6Homq3QE4Yfpr5kUDyKnY32xyBZIluSjwzeemDB+izN+2PWx+3mODfx
         rOK3+PAhnbpHwhE0opvvVZtoqZVDG/NbqPPjfRhbRHvj6SLMvlClTGnZUNu3AyYQi76R
         TxyVAztSamkithlbZE067Ajd63sRP9sTdjX4HufzHmpisxQeA5NyJTKOf6ZrCcAEitCH
         LObQ==
X-Gm-Message-State: AOJu0Yytzth2ouBcs1Jsg/hSxdcvoTXle049u5MPTZU4mYGHwfvZ6K3D
        RCw1xYSE3+KDmIlbaFbJzszsUVtWemTmOvoEXQoWRQ==
X-Google-Smtp-Source: AGHT+IGO3xoq0G0aZv4QCw0awU1EPNO6UdplmLrsZh2YJ1uKs6XdForXf/qHw1H8HlGofAtQ6V4n+bM62xQy5EJADTc=
X-Received: by 2002:a05:6102:3a13:b0:452:5a50:e0ff with SMTP id
 b19-20020a0561023a1300b004525a50e0ffmr15707753vsu.17.1697189782255; Fri, 13
 Oct 2023 02:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231003140637.31346-1-etienne.carriere@foss.st.com>
 <20231003140637.31346-4-etienne.carriere@foss.st.com> <CAFA6WYOMHWFytm4cYy3kQf4E3qiytrnOTVY1gb2rzTDece490w@mail.gmail.com>
 <bbb5ca0809954bee94c5f2886427f886@foss.st.com> <CAFA6WYMKrB7xkOaef41LyVKHGAt8Dk0hbFUkiqubeZbJVY=9kw@mail.gmail.com>
 <5ba5ab8d2cc7477588dd0f6c7531cf16@foss.st.com> <CAFA6WYPRgAnq_WZGbqvrn4de9Gk9fzTDs+NmcWyFn-QAC2+c8w@mail.gmail.com>
 <adb7df76eb8f4a7399b89f681383df84@foss.st.com>
In-Reply-To: <adb7df76eb8f4a7399b89f681383df84@foss.st.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 13 Oct 2023 15:06:10 +0530
Message-ID: <CAFA6WYMK2nM+uhtNPJH2bdtXpi=5SZdsxv5P5NSzOp1k4Ty+zg@mail.gmail.com>
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

On Fri, 13 Oct 2023 at 14:53, Etienne CARRIERE - foss
<etienne.carriere@foss.st.com> wrote:
>
> > From: Sumit Garg <sumit.garg@linaro.org>
> > Sent: Friday, October 13, 2023 11:13 AM
> >
> > On Fri, 13 Oct 2023 at 14:09, Etienne CARRIERE - foss
> > <etienne.carriere@foss.st.com> wrote:
> > >
> > > > From: Sumit Garg <sumit.garg@linaro.org>
> > > > Sent: Friday, October 13, 2023 9:21 AM
> > > >
> > > > On Wed, 11 Oct 2023 at 12:41, Etienne CARRIERE - foss
> > > > <etienne.carriere@foss.st.com> wrote:
> > > > >
> > > > > > From: Sumit Garg <sumit.garg@linaro.org>
> > > > > > Sent: Friday, October 6, 2023 11:33 AM
> > > > > >
> > > > > > On Tue, 3 Oct 2023 at 19:36, Etienne Carriere
> > > > > > <etienne.carriere@foss.st.com> wrote:
> > > > > > >
> > > > > > > Adds support in the OP-TEE driver to keep track of reserved system
> > > > > > > threads. The logic allows one OP-TEE thread to be reserved to TEE system
> > > > > > > sessions.
> > > > > > >
> > > > > > > The optee_cq_*() functions are updated to handle this if enabled,
> > > > > > > that is when TEE describes how many thread context it supports
> > > > > > > and when at least 1 session has registered as a system session
> > > > > > > (using tee_client_system_session()).
> > > > > > >
> > > > > > > For sake of simplicity, initialization of call queue management
> > > > > > > is factorized into new helper function optee_cq_init().
> > > > > > >
> > > > > > > The SMC ABI part of the driver enables this tracking, but the
> > > > > > > FF-A ABI part does not.
> > > > > > >
> > > > > > >
> > > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > > > > > ---
> > > > > > > Changes since v9:
> > > > > > > - Add a reference counter for TEE system thread provisioning. We reserve
> > > > > > >   a TEE thread context for system session only when there is at least
> > > > > > >   1 opened system session.
> > > > > > > - Use 2 wait queue lists, normal_waiters and sys_waiter, as proposed in
> > > > > > >   patch v8. Using a single list can prevent a waiting system thread from
> > > > > > >   being resumed if the executing system thread wakes a normal waiter in
> > > > > > >   the list.
> > > > > >
> > > > > > How would that be possible? The system thread wakeup
> > > > > > (free_thread_threshold = 0) is given priority over normal thread
> > > > > > wakeup (free_thread_threshold = 1). I think a single queue list would
> > > > > > be sufficient as demonstrated in v9.
> > > > > >
> > > > >
> > > > > Hello Sumit,
> > > > >
> > > > > I think a system session can be trapped waiting when using a single queue list.
> > > > > To have a chance to reach the TEE, a waiting thread must wait that a TEE thread comes out of the TEE and calls complete() on the waitqueue to wake next waiter.
> > > > >
> > > > > To illustrate, consider a 10 TEE threads configuration on TEE side (::total_thread_count=10 at init),
> > > > > and several TEE clients in Linux OS, including 2 system sessions, from 2 consumer drivers (::sys_thread_req_count=2).
> > > > >
> > > > > Imagine the 9 normal threads and the 1 system thread are in use. (::free_thread_count=0),
> > > > > Now comes the other system session: it goes to the waitqueue list.
> > > > > Now comes a normal session invocation: it goes to the waitqueue list, 1st position.
> > > > >
> > > > > Now, TEE system thread returns to Linux:
> > > > > It increments the counter, ::free_thread_count=1, and calls complete() for the waitequeue.
> > > > > The 1st element in the waitqueue list is the last entered normal session invocation.
> > > > > However, that waiter won't switch local boolean 'need_wait'  to false because ::free_thread_count=1 and ::sys_thread_req_count!=0.
> > > > > So no attempt to reach TEE and wake another waiter on return.
> > > > > At that point there is a system session in the waitqueue list that could enter TEE (::free_thread_count=1) but is waiting someone returns from the TEE.
> > > >
> > > > I suppose the following loop tries to wake-up every waiter to give
> > > > them a chance to enter OP-TEE. So with that system session would
> > > > always be prefered over normal session, right?
> > >
> > > No, the below loop will wake only the 1st waiter it finds in the list that is
> > > current waiting (completion_done() returns false). So if it finds a normal
> > > session, it will only wake this one which, in turn, will not try to reach the
> > > TEE from the while(need_wiat) loop in optee_cq_wait_init(), because there is
> > > not enough free threads. Because it does not reach the TEE, it will not
> > > it wake another waiter.
> > >
> >
> > Okay I see your point, so how about the following change on top of v9.
> > I still think having 2 queues is an overkill here.
> >
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index df5fb5410b72..47f57054d9b7 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -60,6 +60,7 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
> >          */
> >         init_completion(&w->c);
> >         list_add_tail(&w->list_node, &cq->waiters);
> > +       w->sys_thread = sys_thread;
> >
> > ...
> >
> > @@ -83,6 +84,14 @@ static void optee_cq_complete_one(struct
> > optee_call_queue *cq)
> >  {
> >         struct optee_call_waiter *w;
> >
> > +       /* Try to wakeup system session capable threads first */
> > +       list_for_each_entry(w, &cq->waiters, list_node) {
> > +               if (!completion_done(&w->c) && w->sys_thread) {
> > +                       complete(&w->c);
> > +                       return;
> > +               }
> > +       }
> > +
>
> Indeed, looking for system sessions first in the list would address the issue.
> I would test sys_thread firs: if (w->sys_thread && !completion_done(&w->c))

Ack.

>
> That said, is it better to have 2 lists or to have 1 list possibly scanned twice?

I would prefer to reuse the existing queue.

-Sumit

> I'm fine with both ways.
>
> etienne
>
>
> >         list_for_each_entry(w, &cq->waiters, list_node) {
> >                 if (!completion_done(&w->c)) {
> >                         complete(&w->c);
> > diff --git a/drivers/tee/optee/optee_private.h
> > b/drivers/tee/optee/optee_private.h
> > index 6bb5cae09688..a7817ce9f90f 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -43,6 +43,7 @@ typedef void (optee_invoke_fn)(unsigned long,
> > unsigned long, unsigned long,
> >  struct optee_call_waiter {
> >         struct list_head list_node;
> >         struct completion c;
> > +       bool sys_thread;
> >  };
> >
> >  struct optee_call_queue {
> >
> > -Sumit
> >
> > > >
> > > > static void optee_cq_complete_one(struct optee_call_queue *cq)
> > > > {
> > > >         struct optee_call_waiter *w;
> > > >
> > > >         list_for_each_entry(w, &cq->waiters, list_node) {
> > > >                 if (!completion_done(&w->c)) {
> > > >                         complete(&w->c);
> > > >                         break;
> > > >                 }
> > > >         }
> > > > }
> > > >
> > > > -Sumit
> > > >
> > >
> > > Note I've found a error in this patch v10, see below.
> > >
> > > BR,
> > > Etienne
> > >
> > >
> > > > >
> > > > > With 2 lists, we first treat system sessions to overcome that.
> > > > > Am I missing something?
> > > > >
> > > > > Best regards,
> > > > > Etienne
> > > > >
> > > > > > -Sumit
> > > > > >
> (snip)
