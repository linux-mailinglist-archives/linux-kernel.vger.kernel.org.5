Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5988E7DCD75
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbjJaM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344350AbjJaM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:59:54 -0400
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B8BD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:59:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698757190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IDMC1GkRNk1k2ztG8ptBV6onAW6A2wHvK6RivRZoKp4=;
        b=TA/0QBUV5tjMBOvNwl6Xn4budzlArLfuW+A79pKt3KCUzJOtkHtRgHxu8TL7vXOaJKHz1T
        ZpKHEFCLgO1QPpwpXo7cMkcBIg0EP53i/qeh92aagpgaBFQY6PLevvlTAugkvzNPQU74Bb
        H1krPNOhnQtuF6yR90mC2kXuFHnXPuo=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3 0/3] Use update_current_exec_runtime simplify code
Date:   Tue, 31 Oct 2023 20:59:25 +0800
Message-Id: <20231031125928.235685-1-yajun.deng@linux.dev>
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

update_current_exec_runtime would update execution time for each task,
we can use update_current_exec_runtime simplify code.

The 1st and 2nd patch update update_current_exec_runtime() applies to all
callers.
The 3rd patch use update_current_exec_runtime simplify update_curr.

Yajun Deng (3):
  sched: Don't account execution time for task group
  sched: Don't trace stat runtime for task group
  sched/fair: Simplify update_curr()

 kernel/sched/deadline.c  |  4 +---
 kernel/sched/fair.c      | 13 +++----------
 kernel/sched/rt.c        |  5 ++---
 kernel/sched/sched.h     | 11 +++++++----
 kernel/sched/stop_task.c |  2 +-
 5 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.25.1

