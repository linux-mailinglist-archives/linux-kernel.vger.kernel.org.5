Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C87F4E84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjKVRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKVRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:37:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45EE19D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:37:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf669b711fso23381135ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700674659; x=1701279459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T3wo0WtVvuibJG615xhjFRqzcICg2zwMa6Rl+5kbgno=;
        b=sqNuq6nME7XivzvBD4CVDKaY1NlDuctRKM3iafVpMNPEu8RYoc8wJyDf66gOTCUQli
         2OzFPgeJeLBhCP4lZR6JWsWqgQ+dS4WkY2lA4PFdq6GKh3My0sZBNvCaF2lESdnA4vct
         QiLFVnBtPr0EBDuNyO15kTNollwRSO2qQDdDkZNq7HHmWGKPW7eIP/rRJijfvHyPeI/O
         2Zbda+SJB5ToXYsd/KthMjX0GbHCbwp+fGX/2OsH0Sl1kE3fYSVACkSOys/UyzzfiEye
         5X9s/zhQ3jekz1w7Opq7NHivaeFKuQkSrzaAbD9+C8eyMpupKajR2ot5uhS4VOWRpI/d
         s/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674659; x=1701279459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3wo0WtVvuibJG615xhjFRqzcICg2zwMa6Rl+5kbgno=;
        b=iPoAzu7guJGldEkZwGqSQLdMgFAMs8MVlC1DVDiw5GuGjBjVx2RYnIDUz5KVogcRJA
         PGtkW1irXZAolAD/t9oOLCY4HT33sOcMvJ4uT6chtqRggrXBbq6SdtWS0K2KUPEQgWm+
         +Cj5eF1w1jCVob/YtwZnk680IB9UjvlBlf2GyndXI9lVTWdaNvtDXNXNC1ztNjhRcTJZ
         W+rVi5nkxXN/yVLPQDn4e70xW7MIkWAtmb5KBr0iQVsGKQHeS6jxdfRajEr3hikAdcna
         lkXIQG0myGCrZvFq0aqsuaACengUQPwX5yziwWFkXX4u58jOeT7o9f3DJvwIm+Z48QM9
         pTiQ==
X-Gm-Message-State: AOJu0Yzy5Rp1CWaalF9ueBx7TWwUuKi5ug2kJ0hEQOtOs2cGpCZuRSIC
        8lkZFA6NC8Nsq27jgJYdzUXn0vf3NrrW/lQTGUtMsw==
X-Google-Smtp-Source: AGHT+IE13bq+QqMHFadrkXA+oAPu/cmfkR5+fYRH3H43c5t8E09ECy48d2Qio24OEVsuE+BOZIOouRHhW/ZsHiott7s=
X-Received: by 2002:a17:90b:4a49:b0:27d:3a3e:3a45 with SMTP id
 lb9-20020a17090b4a4900b0027d3a3e3a45mr3351362pjb.44.1700674659171; Wed, 22
 Nov 2023 09:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
 <0bc60a26-af18-4108-8b8d-238a1df1775b@arm.com> <CAKfTPtAosL8f0M1nL2U78iuwm9ZFGuQS5jX4soex8nsGjMX_RQ@mail.gmail.com>
In-Reply-To: <CAKfTPtAosL8f0M1nL2U78iuwm9ZFGuQS5jX4soex8nsGjMX_RQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Nov 2023 18:37:27 +0100
Message-ID: <CAKfTPtCnj9Gnczt7aJOELRW+_Rgs3Qp9KFM9Kn17YQ3nFbNdhQ@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     lukasz.luba@arm.com, juri.lelli@redhat.com, mingo@redhat.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, bsegall@google.com,
        rostedt@goodmis.org, bristot@redhat.com, mgorman@suse.de,
        vschneid@redhat.com, rafael@kernel.org, qyousef@layalina.io,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same but with plain text instead of html ...

 On Wed, 22 Nov 2023 at 17:40, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> Hi Vincent,
>
> On 22/11/2023 14:01, Vincent Guittot wrote:
> > It has been reported that thread's util_est can significantly decrease as
> > a result of sharing the CPU with other threads. The use case can be easily
> > reproduced with a periodic task TA that runs 1ms and sleeps 100us.
> > When the task is alone on the CPU, its max utilization and its util_est is
> > around 888. If another similar task starts to run on the same CPU, TA will
> > have to share the CPU runtime and its maximum utilization will decrease
> > around half the CPU capacity (512) then TA's util_est will follow this new
> > maximum trend which is only the result of sharing the CPU with others
> > tasks. Such situation can be detected with runnable_avg wich is close or
> > equal to util_avg when TA is alone but increases above util_avg when TA
> > shares the CPU with other threads and wait on the runqueue.
>
> Thanks for bringing this case up. I'm a bit nervous skipping util_est
> updates this way. While it is true that this avoids dropping util_est
> when the task is still busy doing stuff, it also avoids dropping
> util_est when the task really is becoming less busy. If a task has a
> legitimate reason to drop its utilization, it looks weird to me that its
> util_est dropping can be stopped by a new task joining this rq which
> pushes up runnable_avg.

 We prefer an util_est that overestimate rather than under estimate
because in 1st case you will not provide enough performance to the
task which will remain under provisioned whereas in the other case you
will create some idle time which will enable to reduce contention and
as a result reduce the util_est so the overestimate will be transient
whereas the underestimate will be remain

> Also, something about rt-app. Is there an easy way to ask an rt-app
> thread to achieve a certain amount of throughput (like loops per
> second)? I think 'runs 1ms and sleeps 100us' may not entirely simulate a
> task that really wants to preserve a util_est of 888. If its utilization


 We can do this in rt-app with timer instead of sleep but in this case
there is no sleep and as a result no update of util_est. In the case
raised in [1] by lukasz and according to the shared charts, there are
some sleep phases even when the task must share the cpu. This can
typically happen when you have a pipe of threads:  A task prepares
some data, wakes up next step and waits for the result. Then the 1st
task is woken up when it's done and to prepare the next data and so on
... In this case, the task will slow down because of time sharing and
there is still sleep phase

>
>
> really is that high, its sleep time will become less and less when
> sharing the rq with another task, or even has no idle time and become
> 1024 which will trigger overutilization and migration.
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > This patch implements what I mentioned in [1]. I have been able to
> > reproduce such pattern with rt-app.
> >
> > [1] https://lore.kernel.org/lkml/CAKfTPtDd-HhF-YiNTtL9i5k0PfJbF819Yxu4YquzfXgwi7voyw@mail.gmail.com/#t
> >
