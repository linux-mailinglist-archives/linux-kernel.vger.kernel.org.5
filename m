Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27778991F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjHZUrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHZUrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:47:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E3BBA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:47:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso1649680f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693082821; x=1693687621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NotW1EgnzcwPayq6Am6NDtSJeT6+7B5SBcz0+B3ZyG0=;
        b=YXIUc5crv7bvXyLsviqto5A+ywO8/3KnJN0x+SOjpOd31aSgv99rirY2N2GyCzepwA
         YpoxLjf+Sf7nhjWRruzp7XVvRo2niL1J4kdaUTM01owDKxwkESR81QwO8JSJZ9H5uhkA
         oE3V3eSGOPERC87evkOKoRiLjFIHwBwu/ISzgITkv83aD+tvPZsBh2DhIusW+v5lyHkk
         a1r2aOM7QwvTEaRWxeZl5G0icUCkTOzgMhznlfVf69Gqk2YfZrpVpnU8BIQm7+lEE97C
         e6NclAHWOtaDQemWmEZdf9sNblTy89WuE5f0v50pvugLSy6IWBIACLa9Z4LrvucWe8s2
         25RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693082821; x=1693687621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NotW1EgnzcwPayq6Am6NDtSJeT6+7B5SBcz0+B3ZyG0=;
        b=cuO4P+zpAVa/neSw9XkaiYBT7uJ9qjnqYejTinr++BE3eqVCHAQZrqE7bFjRq6+qKh
         NR+CfIy0CXD15a/t3+bPLQcCUVZmdLAz+u4hdOAWasxardCrVl0934llYq0azRWJ2DFe
         j1tZPgxX+cDzRWSS5zpE9qEXe+93Aa4W3a6wp90dZjtwaRpYEqaor89S1zx8zwd6wpva
         L9Sjkbj4xba4Hr/j259njE7UAv0+SdYKp08wFGn/OvjoYBuwHG3a9Dgg/LjzUUb6ZTM+
         W6u0Dk+Kmd/IjfpMAmfgVG+UTJTnvu8edAT08jqdWGBl8/Cc3JfH3ivyg8JqzE1wVrjM
         Ixng==
X-Gm-Message-State: AOJu0Yww6GogY/MU77+8RKAgyRJc9x0Jz/YhVuQALhTNfpm/TlIdpQSi
        x6OWfdrnG78ELKXoBPneRYf+LQ==
X-Google-Smtp-Source: AGHT+IEHsww1iUEJjBDyFX4Vag7XrdzCCboV9cVROjZ1zntWXJeNlSZl3vpb/mpfLDYQofnK0UFyig==
X-Received: by 2002:a05:6000:1246:b0:319:7295:311 with SMTP id j6-20020a056000124600b0031972950311mr17049668wrx.10.1693082820927;
        Sat, 26 Aug 2023 13:47:00 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b003197869bcd7sm5870020wrw.13.2023.08.26.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:47:00 -0700 (PDT)
Date:   Sat, 26 Aug 2023 21:46:59 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
Message-ID: <20230826204659.4b43aie2a2nijrvu@airbuntu>
References: <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
 <20230228133111.6i5tlhvthnfljvmf@airbuntu>
 <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
 <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com>
 <CAKfTPtDfSHnd7=ZG2S-x46kxw0Cc0RSXq+_B8Oe46fa3Fa75BA@mail.gmail.com>
 <CAB8ipk9uPMxwEUHkLWbKXQEO1UkwBPWbZb=NF7AE5JHnG8V6Dw@mail.gmail.com>
 <20230630144038.v2rv7qtrxi4ujhdg@airbuntu>
 <CAB8ipk9cL_xbKVWV+OtgPAxdb3ms8yzt1HCfOGQkjEUaLVgiRQ@mail.gmail.com>
 <CAKfTPtA3UUqJ6qLnFXno5u9GRpEM2eSVK1ZJCSzeWoeYam3k+g@mail.gmail.com>
 <CAB8ipk9khfTnQE82cf+D=WNTs8G0S+8ekUNeFUNEhdfydXxFuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9khfTnQE82cf+D=WNTs8G0S+8ekUNeFUNEhdfydXxFuw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/23 10:03, Xuewen Yan wrote:
> Hi Vincent
> 
> Thanks for your patience to reply!
> 
> On Tue, Aug 22, 2023 at 11:55 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Mon, 21 Aug 2023 at 09:51, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> > >
> > > Hi Vincent
> > >
> > > I have some questions to ask，and hope you can help.
> > >
> > > For this problem, In our platform, We found that the vruntime of some
> > > tasks will become abnormal over time, resulting in tasks with abnormal
> > > vruntime not being scheduled.
> > > The following are some tasks in runqueue:
> > > [status: curr] pid: 25501 prio: 116 vrun: 16426426403395799812
> > > [status: skip] pid: 25496 prio: 116 vrun: 16426426403395800756
> > > exec_start: 326203047009312 sum_ex: 29110005599
> > > [status: pend] pid: 25497 prio: 116 vrun: 16426426403395800705
> > > exec_start: 326203047002235 sum_ex: 29110508751
> > > [status: pend] pid: 25321 prio: 130 vrun: 16668783152248554223
> > > exec_start: 0 sum_ex: 16198728
> > > [status: pend] pid: 25798 prio: 112 vrun: 17467381818375696015
> > > exec_start: 0 sum_ex: 9574265
> > > [status: pend] pid: 22282 prio: 120 vrun: 18010356387391134435
> > > exec_start: 0 sum_ex: 53192
> > > [status: pend] pid: 24259 prio: 120 vrun: 359915144918430571
> > > exec_start: 0 sum_ex: 20508197
> > > [status: pend] pid: 25988 prio: 120 vrun: 558552749871164416
> > > exec_start: 0 sum_ex: 2099153
> > > [status: pend] pid: 21857 prio: 124 vrun: 596088822758688878
> > > exec_start: 0 sum_ex: 246057024
> > > [status: pend] pid: 26614 prio: 130 vrun: 688210016831095807
> > > exec_start: 0 sum_ex: 968307
> > > [status: pend] pid: 14229 prio: 120 vrun: 816756964596474655
> > > exec_start: 0 sum_ex: 793001
> > > [status: pend] pid: 23866 prio: 120 vrun: 1313723379399791578
> > > exec_start: 0 sum_ex: 1507038
> > > ...
> > > [status: pend] pid: 25970 prio: 120 vrun: 6830180148220001175
> > > exec_start: 0 sum_ex: 2531884
> > > [status: pend] pid: 25965 prio: 120 vrun: 6830180150700833203
> > > exec_start: 0 sum_ex: 8031809
> > >
> > > And According to your suggestion, we test the patch:
> > > https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T/#u
> > > The above exception is gone.
> > >
> > > But when  we tested using patch:
> > > https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T/#u
> > > and
> > > https://lore.kernel.org/all/20230317160810.107988-1-vincent.guittot@linaro.org/
> > > Unfortunately, our issue occurred again.
> > >
> > > So we  have to use a workaround solution to our problem, that is to
> > > change the sleeping time's judgement to 60s.
> > > +
> > > + sleep_time -= se->exec_start;
> > > + if (sleep_time > ((1ULL << 63) / scale_load_down(NICE_0_LOAD)))
> > > + return true;
> > >
> > > to
> > >
> > > + sleep_time -= se->exec_start;
> > > +if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> > > + return true;
> > >
> > > At this time, the issue also did not occur again.
> > >
> > > But this modification doesn't actually solve the real problem. And then
> >
> > yes, it resetx the task's vruntime once the delta go above 60sec but
> > your problem is still there
> >
> > > Qais suggested us to try this patch:
> > > https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/T/#u
> >
> > we have the below in v6.0 to fix the problem of stalled clock update
> > instead of the above
> > commit e2f3e35f1f5a ("sched/fair: Decay task PELT values during wakeup
> > migration")
> >
> > Which kernel version are you using ?
> 
> We test in kernel5.4, and kernel5.15 also seems to have this problem.
> 
> And I will later test the  commit e2f3e35f1f5a ("sched/fair: Decay
> task PELT values during wakeup migration").

I think it might be worth to cherry-pick the first two patches of that series
to 5.10 and 5.15 (5.4 is a bit too old for me at least to work with).

Although they've been rare enough, but the util swing problem does pop up every
once in a while. And if it helps with this vruntime it might be a simple thing
to do to cherry pick these two patches after all. I think they'll apply without
a problem - I'll look at this.


Cheers

--
Qais Yousef
