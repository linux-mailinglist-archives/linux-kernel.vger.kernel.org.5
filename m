Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8547D806756
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376785AbjLFGeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjLFGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:34:19 -0500
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B11B2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:34:24 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701844461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z+0l8mPsxCbaNspPdfHc0kRxENqvlPASHVuR+idjaYg=;
        b=RTKmWoeHMIk6yFrnjQq47mI/+cQyHVlQIbF3SYOiLIx80M1OT/woOCkKluhDwxwqgIhfdw
        N/q3R5umJRjL3g8wnFyK9Lq0kSGK96opxbRk8jS9QmcRlr88sXW4+aV540+W72d4b79V/N
        IoVUUxPlcxeMZFRJpAuh06yL0wSVbLI=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2 0/2] sched: Return NULL when entity isn't a task
Date:   Wed,  6 Dec 2023 14:33:58 +0800
Message-Id: <20231206063400.3206346-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the entity isn't a task, return the task struct is meaningless.
Return NULL when entity isn't a task that makes the code more concise.

v1 -> v2: 
fix 'struct rt_rq' no member named 'highest_prio'.

Yajun Deng (2):
  sched/fair: Return NULL when entity isn't a task in task_of()
  sched/rt: Return NULL when rt entity isn't a task in rt_task_of()

 kernel/sched/fair.c  | 50 ++++++++++++++++++------------------
 kernel/sched/rt.c    | 60 +++++++++++++-------------------------------
 kernel/sched/sched.h |  4 ++-
 3 files changed, 44 insertions(+), 70 deletions(-)

-- 
2.25.1

