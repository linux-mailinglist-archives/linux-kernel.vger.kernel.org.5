Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AEC784A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjHVTZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHVTZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:25:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B7A91
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:25:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so27985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692732308; x=1693337108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErIBBOoqEateyOTdlI+A5EQHZ2AEvTwV+fuBtgO532U=;
        b=TYPqFSyGO7KylBCnz3s/QNyqCJEIbH+R4BwWhz4iGq9QekdgrMcxXBuBfNFqd2Mxe0
         pCkDfBcm/ieQ/wJnV6sQ/Z511lbAypZ59Yr9Mcwhz8VKsQxwb0i67buyY57vViXjul8j
         Po16Jdgnz3jEACDyShzTzH2mvXYQ3MssQG71r5CvvXX+/ZvXVsdOQqGP+nOhC40/rlH8
         74Acr1hytlEmtd/OcLC49Yd0W9PDpxCAdR9t8i24OPRU9TnU1F4sX2oqEr7+bzFeOzms
         bgy2uYnoyAbSf38SYZMhirHQDRIn+w4ZwQGhvt/FG8czqZPvcO7RTPap6UCyTT/7FQCm
         lHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732308; x=1693337108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErIBBOoqEateyOTdlI+A5EQHZ2AEvTwV+fuBtgO532U=;
        b=YOduoplm4ouXL0i0Nh4cMZCpFQq4Iegrq3aHPMu2erCKZDZC/kgGC+Nu/pQRz2Pw/C
         SMteoJh/tsEqEVDvaAaeij0CpCtE9la7fEATrJEJpiLfVW8Zj9mIRog7h3vNSvE4any/
         ULrd2BO65nbsqlB6AzelaT8cFCVLyM1RMl5tji+GzLonzl2go8NRzQecF1vzCcbN92kx
         VNP1mMsuu2LRkMqy5v8TcU7PNsRkKN6E9G1wG9v36cxyScUU3k/bmfm49pIMX3NX61OZ
         3WoRmLWrRNp6oLM85zZ9Eub17DUIzWjkJBBjGyfPrM6vMxscttH5zLDCyL3YkfffSAX7
         Eo6Q==
X-Gm-Message-State: AOJu0YzKAcKXpyoM6nWvxlK9Wc3Sn+jP5ruImN/OS8htghaa704582XK
        rGDNC69mg3hKWLGQgo9KjM3hWNfwT1/H2icpx+zm
X-Google-Smtp-Source: AGHT+IG8qFrV28Nh0l3GB7I+Idyy5kMtUg84SqOGrRjWidAW9X4gZDcv35LDjFCPLEMIaEVO73One8aEsxSXphCh4I8=
X-Received: by 2002:a05:600c:2e87:b0:3f1:73b8:b5fe with SMTP id
 p7-20020a05600c2e8700b003f173b8b5femr134630wmn.3.1692732307663; Tue, 22 Aug
 2023 12:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com> <20230819060915.3001568-3-jstultz@google.com>
 <034a302d-773d-5bdb-a32b-bd283d6c7710@redhat.com>
In-Reply-To: <034a302d-773d-5bdb-a32b-bd283d6c7710@redhat.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 22 Aug 2023 12:24:56 -0700
Message-ID: <CANDhNCrN6o=_uKN4xK2uFfsKBQuhq7Rz82jgBss4LSWgK-OpqQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/19] locking/mutex: Removes wakeups from under mutex::wait_lock
To:     Waiman Long <longman@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:11=E2=80=AFPM Waiman Long <longman@redhat.com> w=
rote:
> On 8/19/23 02:08, John Stultz wrote:
> > @@ -676,6 +677,10 @@ __mutex_lock_common(struct mutex *lock, unsigned i=
nt state, unsigned int subclas
> >               }
> >
> >               raw_spin_unlock(&lock->wait_lock);
> > +             /* Make sure we do wakeups before calling schedule */
> > +             wake_up_q(&wake_q);
> > +             wake_q_init(&wake_q);
> > +
>
> The wake_q may have task to wake up only in the case of ww_mutex which
> is a minority in the kernel. IOW, wake_up_q() which is a function call
> will do nothing in most cases. From an optimization point of view, it is
> better to do a "!wake_q_empty(&wake_q)" check before calling wake_up_q().

Thanks for the suggestion!  Updated for the next version!

> > @@ -946,9 +953,11 @@ static noinline void __sched __mutex_unlock_slowpa=
th(struct mutex *lock, unsigne
> >       if (owner & MUTEX_FLAG_HANDOFF)
> >               __mutex_handoff(lock, next);
> >
> > +     preempt_disable();
> >       raw_spin_unlock(&lock->wait_lock);
> >
> >       wake_up_q(&wake_q);
> > +     preempt_enable();
> >   }
>
> I think it looks better to put the preempt_disable() right before
> raw_spin_lock() for proper nesting.

Agreed.

Thanks so much for the review and feedback! I really appreciate it!
-john
