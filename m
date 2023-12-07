Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F88808816
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379319AbjLGMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:39:13 -0500
X-Greylist: delayed 1166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 04:39:13 PST
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16C710C4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:39:13 -0800 (PST)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SmCt15rxBzB0KB1;
        Thu,  7 Dec 2023 20:16:09 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 7 Dec
 2023 20:19:24 +0800
Date:   Thu, 7 Dec 2023 20:19:23 +0800
From:   WangJinchao <wangjinchao@xfusion.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] sched/headers: Remove duplicated struct rq declare
Message-ID: <202312072018+0800-wangjinchao@xfusion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`struct rq` has been declared at the top of the file,
so remove the second declaration.

Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
---
 kernel/sched/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..349c90554bd8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -931,7 +931,6 @@ struct uclamp_rq {
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
-struct rq;
 struct balance_callback {
 	struct balance_callback *next;
 	void (*func)(struct rq *rq);
-- 
2.40.0

