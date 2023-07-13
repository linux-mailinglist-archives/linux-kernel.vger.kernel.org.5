Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72075298A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjGMRH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjGMRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:07:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF5C2D57
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:06:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-314172bb818so967502f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689267958; x=1691859958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyYOdDl3xwqmWSMjOherr+Wl4DKR7ur8sLJjiZ8B/A8=;
        b=ISi2RxOz/XjuM66n48IOkikI7XXE3OyE7hhKTNn3HNphrdUsa/GUYf7O0uVCwt2y09
         cScuT25FQi38FZxchBN8b+rO7TgnmRjMctjxhIaN16lH+0IQDPrQJYuElO9MaBlRyI/C
         LM1uyL4ArgrKIXBlMbWqwKSOs1NbxSR2jZPB6EsD+0FTfPYMqIhd9mUY+edk0P1w2mCV
         Tmk1k8M0leGUgjnLgmtseCHLOeKuQIzj5scCqI+wYZNHKisNmRefRs1yR+5HqppiSv55
         xIoPd8d3lYDqkd2X/HwHnhbtzDVXZu6T+YX/J8EXugnOAcBLI6b2ApHR96P+NDIJivLy
         sUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267958; x=1691859958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyYOdDl3xwqmWSMjOherr+Wl4DKR7ur8sLJjiZ8B/A8=;
        b=IzhFlnt/HQ37yZJqVycYKEX6eGFwAC1o4fwBHpMjhijyQl4oZJhakgUDLxPT/jvSZF
         x1gOHUr+XdTG5iKQHRGAIcSIMUaNF0SzZbUeIKO1p+UZW6hgmgNSJTy0Pa7LHiBB7C5x
         ZucgZzRq2Ib1pd00tY1eWtg4Gyl3iSLAZpu3BUSzeTwi/RjyVMTgkCMeSlT4K2P4KP2f
         4jN6W87+BLfJ9fCdjCim3rxw7fqvvQ/OCOaNmp+RTYyJbApQbVPjASPdgOsV21VcHRoC
         7OdprigB5V+nloIvAqUzm7BV+zp2hVEDhZpUjVsVLQkllqDAokt/DfI70Z8D5Lz+pMG9
         lFjg==
X-Gm-Message-State: ABy/qLZ1swbPBHP+5jPW3jbqpbTVOFEkYsht6OsNRqWJ1yoQlodwai4T
        JSg/lfsdTce2k7Vp2uZj2qAGfWU/71d5h3qQJSF8kg==
X-Google-Smtp-Source: APBJJlFyLvmhQCX5nI+rcMbwxp+/tcnDtwevbdff0qrkn1BHI5o5JXj5DeDKLsClwiabVGsQxskCQa+dsFm1gWGhye4=
X-Received: by 2002:adf:e483:0:b0:314:db7:d132 with SMTP id
 i3-20020adfe483000000b003140db7d132mr2106439wrm.61.1689267957936; Thu, 13 Jul
 2023 10:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com> <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop> <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop> <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com> <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
In-Reply-To: <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Thu, 13 Jul 2023 10:05:46 -0700
Message-ID: <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Let me answer some of the questions raised here.

* Performance aspect
EROFS is one of the popular filesystem of choice in Android for read
only partitions
as it provides 30%+ storage space savings with compression.
In addition to microbenchmarks, boot times and cold app launch
benchmarks are very
important to the Android ecosystem as they directly translate to
responsiveness from user point of view. We saw some
performance penalty in cold app launch benchmarks in a few scenarios.
Analysis showed that the significant variance was coming from the
scheduling cost while decompression cost was more or less the same.
Please see the [1] which shows scheduling costs for kthread vs kworker.

> Just out of curiosity, exactly how much is it costing to trigger the
workqueue?
I think the cost to trigger is not much, it's the actual scheduling latency for
the thread is the one which we want to cut down. And if we are already in
thread context then there is no point in incurring any extra cost if
we can detect
it reliably. That is what erofs check is trying to do.

>One additional question...  What is your plan for kernels built with
CONFIG_PREEMPT_COUNT=n?
If there is no reliable way to detect if we can block or not then in that
case erofs has no option but to schedule the kworker.

* Regarding BLK_MQ_F_BLOCKING
As mentioned by Gao in the thread this is a property of blk-mq device
underneath,
so erofs cannot control it has it has to work with different types of
block devices.

* Regarding rcu_is_watching()

>I am assuming you mean you would grab the mutex accidentally when in an RCU
reader, and might_sleep() presumably in the mutex internal code will scream?

Thank you Paul for explaining in detail why it is important. I can get
the V2 going.
From the looking at the code at kernel/sched/core.c which only looks
at rcu_preempt_depth(),
I am thinking it may still get triggered IIUC.

> The following is untested, and is probably quite buggy, but it should
provide you with a starting point.
..

Yes, that can fix the problem at hand as the erofs check also looks
for rcu_preempt_depth().
A similar approach was discarded as rcu_preempt_depth() was though to
be low level
and we used rcu_read_lock_any_held() which is the superset until we
figured out inconsistency
when ! CONFIG_DEBUG_LOCK_ALLOC.

Paul, Joel,
Shall we fix the rcu_read_lock_*held() regardless of how erofs
improves the check?

Thanks,
Sandeep.

[1] https://lore.kernel.org/linux-erofs/20230208093322.75816-1-hsiangkao@linux.alibaba.com/
