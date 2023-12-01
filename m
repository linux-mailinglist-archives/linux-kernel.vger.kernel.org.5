Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A440800190
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376625AbjLAC12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLAC10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:27:26 -0500
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E96198
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:27:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701397650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1MS+oPnsh/afyTfSaIuacZ3o3KGFvTZ7JLRsMQWeKuU=;
        b=ZXc7sKhoOMbFTxeGjRr/sgDyfxJKZ48Z9IuHekN/Px60vvgjnWutH/jAp3L7vpozJpyIzS
        DWfLJ3h7xGrhLDGrmFsfymqhseaDdsksuSa5DZPM1R/1Cj7yItLjxxlSrnw83tYdOrIzbb
        VaZzC1rCmqJ+/AOqGTxByo+nAzRWTzU=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 0/2] sched: Return NULL when entity isn't a task
Date:   Fri,  1 Dec 2023 10:27:02 +0800
Message-Id: <20231201022704.3526377-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the entity isn't a task, return the task struct is meaningless.
Return NULL when entity isn't a task that makes the code more concise.

Yajun Deng (2):
  sched/fair: Return NULL when entity isn't a task in task_of()
  sched/rt: Return NULL when rt entity isn't a task in rt_task_of()

 kernel/sched/fair.c  | 50 +++++++++++++++++------------------
 kernel/sched/rt.c    | 62 ++++++++++++--------------------------------
 kernel/sched/sched.h |  4 ++-
 3 files changed, 44 insertions(+), 72 deletions(-)

-- 
2.25.1

