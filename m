Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E4D7824E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjHUHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjHUHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:51:44 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9432B5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:51:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bb07d274feso2442543a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692604300; x=1693209100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ni8iwqCks6qDJPIX4ZaFnY719I4GCifR+lAWrQJsg0=;
        b=QjG86+x3Zo9FwK15gZdXZ31tVxv05C00x2hAGz2I6Iv3dyDkg/W3TCGde1kOc/rpbm
         ORSPhi6KbFNcZScSer6tYKPqp7L/g1BEqBjguVb20uOsAq3lpuy9BbqN1X+PQ+ovuUgZ
         6OBIOYvj2kNfVucgrezlFFBkReHwVTj8tyAr9Hu15a1zdHOx2i3lHSokB+HsV/6+7rX1
         fs0FgoM46dAWGf5mwspeplKxLNltRbAd+8l3VfF1SF4a+odd4xwjcAURb/HxV7y82bdp
         JJXsFcW6rpOgJm/uM31XsgTy15Y6MvOjbrbZMDgOiUObh/SbXhothj3CzXyuE0GccQj1
         oUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692604300; x=1693209100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ni8iwqCks6qDJPIX4ZaFnY719I4GCifR+lAWrQJsg0=;
        b=bi8k5Ms6rHsJLc2GpcfTgCQ2nsP0XLUTWvvDsdREqQe56BsEkhnrR3kPI5GmrpZah1
         +iGr/m52X97kMqTSkCmjUbFp2u8XgcmRpaMzBqAgq17QqiXopcEVfzXmgHdOaayveR4m
         27rvM48nXIfGhupCeDXUYUL/+aXXbhfIYcdThtB8SVEH6kdGxl3L3xgPBKY4+H7a8EhT
         DCvI8pn213/tGN++INwylKcIxWivBAddVd0OR/PISCEd5w+AuXDIVhdxpcaqVV58W1sQ
         5S3Pjr/tdWfVaeUIZYwlWVk+UJIiuJLfSHIrllDsGw5Bd1lxAd+4+eWZSGUkQ2ktKw0u
         E7lw==
X-Gm-Message-State: AOJu0YyXgNBWiZAN0194m2I88I6fiR0c29a2kfZzRBht/p7U0V2ehLN0
        MlK0wFkMUvW48yooswOh3E98uRz3FsZVjDTYE+I=
X-Google-Smtp-Source: AGHT+IGAiCB/6vgQ/fKvRpJTJ4vGqdk0fz9Aaxjq3Z0faSz2bF+HZN8BvUkcnSLNY6Hx7dLOALUmFfcZQvOwPlDnLJk=
X-Received: by 2002:a05:6870:968e:b0:1b0:293e:f8f3 with SMTP id
 o14-20020a056870968e00b001b0293ef8f3mr9381669oaq.53.1692604300102; Mon, 21
 Aug 2023 00:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230227220735.3kaytmtt53uoegq7@airbuntu> <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
 <20230228133111.6i5tlhvthnfljvmf@airbuntu> <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
 <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com>
 <CAKfTPtDfSHnd7=ZG2S-x46kxw0Cc0RSXq+_B8Oe46fa3Fa75BA@mail.gmail.com>
 <CAB8ipk9uPMxwEUHkLWbKXQEO1UkwBPWbZb=NF7AE5JHnG8V6Dw@mail.gmail.com> <20230630144038.v2rv7qtrxi4ujhdg@airbuntu>
In-Reply-To: <20230630144038.v2rv7qtrxi4ujhdg@airbuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 21 Aug 2023 15:51:29 +0800
Message-ID: <CAB8ipk9cL_xbKVWV+OtgPAxdb3ms8yzt1HCfOGQkjEUaLVgiRQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent

I have some questions to ask=EF=BC=8Cand hope you can help.

For this problem, In our platform, We found that the vruntime of some
tasks will become abnormal over time, resulting in tasks with abnormal
vruntime not being scheduled.
The following are some tasks in runqueue:
[status: curr] pid: 25501 prio: 116 vrun: 16426426403395799812
[status: skip] pid: 25496 prio: 116 vrun: 16426426403395800756
exec_start: 326203047009312 sum_ex: 29110005599
[status: pend] pid: 25497 prio: 116 vrun: 16426426403395800705
exec_start: 326203047002235 sum_ex: 29110508751
[status: pend] pid: 25321 prio: 130 vrun: 16668783152248554223
exec_start: 0 sum_ex: 16198728
[status: pend] pid: 25798 prio: 112 vrun: 17467381818375696015
exec_start: 0 sum_ex: 9574265
[status: pend] pid: 22282 prio: 120 vrun: 18010356387391134435
exec_start: 0 sum_ex: 53192
[status: pend] pid: 24259 prio: 120 vrun: 359915144918430571
exec_start: 0 sum_ex: 20508197
[status: pend] pid: 25988 prio: 120 vrun: 558552749871164416
exec_start: 0 sum_ex: 2099153
[status: pend] pid: 21857 prio: 124 vrun: 596088822758688878
exec_start: 0 sum_ex: 246057024
[status: pend] pid: 26614 prio: 130 vrun: 688210016831095807
exec_start: 0 sum_ex: 968307
[status: pend] pid: 14229 prio: 120 vrun: 816756964596474655
exec_start: 0 sum_ex: 793001
[status: pend] pid: 23866 prio: 120 vrun: 1313723379399791578
exec_start: 0 sum_ex: 1507038
...
[status: pend] pid: 25970 prio: 120 vrun: 6830180148220001175
exec_start: 0 sum_ex: 2531884
[status: pend] pid: 25965 prio: 120 vrun: 6830180150700833203
exec_start: 0 sum_ex: 8031809

And According to your suggestion, we test the patch:
https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T/#u
The above exception is gone.

But when  we tested using patch:
https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T/#u
and
https://lore.kernel.org/all/20230317160810.107988-1-vincent.guittot@linaro.=
org/
Unfortunately, our issue occurred again.

So we  have to use a workaround solution to our problem, that is to
change the sleeping time's judgement to 60s.
+
+ sleep_time -=3D se->exec_start;
+ if (sleep_time > ((1ULL << 63) / scale_load_down(NICE_0_LOAD)))
+ return true;

to

+ sleep_time -=3D se->exec_start;
+if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+ return true;

At this time, the issue also did not occur again.

But this modification doesn't actually solve the real problem. And then
Qais suggested us to try this patch:
https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/T/=
#u

And  we tested the patch(android phone, monkey test with 60 apk, 7days).
 It did not reproduce the previous problem.

We would really appreciate it if you could take a look at the patch
and help see what goes wrong.

Thanks!
BR

---
xuewen

On Fri, Jun 30, 2023 at 10:40=E2=80=AFPM Qais Yousef <qyousef@layalina.io> =
wrote:
>
> Hi Xuewen
>
> On 03/01/23 16:20, Xuewen Yan wrote:
> > On Wed, Mar 1, 2023 at 4:09=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 1 Mar 2023 at 08:30, Xuewen Yan <xuewen.yan94@gmail.com> wrot=
e:
> > > >
> > > > Hi Vincent
> > > >
> > > > I noticed the following patch:
> > > > https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon=
.de/
> > > > And I notice the V2 had merged to mainline:
> > > > https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.=
de/T/#u
> > > >
> > > > The patch fixed the inversing of the vruntime comparison, and I see
> > > > that in my case, there also are some vruntime is inverted.
> > > > Do you think which patch will work for our scenario? I would be ver=
y
> > > > grateful if you could give us some advice.
> > > > I would try this patch in our tree.
> > >
> > > By default use the one that is merged; The difference is mainly a
> > > matter of time range. Also be aware that the case of newly migrated
> > > task is not fully covered by both patches.
> >
> > Okay, Thank you very much!
> >
> > >
> > > This patch fixes a problem with long sleeping entity in the presence
> > > of low weight and always running entities. This doesn't seem to be
> > > aligned with the description of your use case
> >
> > Thanks for the clarification! We would try it first to see whether it
> > could resolve our problem.
>
> Did you get a chance to see if that patch help? It'd be good to backport =
it to
> LTS if it does.
>
>
> Thanks
>
> --
> Qais Yousef
