Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57687AA22E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjIUVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjIUVMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:12:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C598A43;
        Thu, 21 Sep 2023 10:56:48 -0700 (PDT)
Date:   Thu, 21 Sep 2023 09:37:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695289077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HzdSdZhUrL6rdNHmEvP4H0XRfV2OX94la0uV5QgxBTI=;
        b=qbQWes141URM2SQ7fEOKVVsiVCjf/+ETlbDsysOngVDxQFX2aWzszL4SLfq9S78R7PFK4M
        GeKpuWCaERa1ZsKOcJONxVllW6YnjoKl4pmMK7RlmcpTv/2Wm7E/+rlb/83MEbKVeEmpxd
        dzCBNf/2lNouBKssOfwSYO9c4ty/qMq1UQcgwyAFtfwqaeskLPYCy5MyV91YLu6ChUXCeU
        cOMyQgsWH8SMjj6dxCK6ncBmvItIJ6ZnSmUJH6sunFhvttLk/RJpPhZ187StuyyF8Z0/ON
        RmrtHSHpAptQCr9aWEGWf+xmI5DkBYPycUUQ6Ywe0B2MTuUuybGNU74TluhuQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695289077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HzdSdZhUrL6rdNHmEvP4H0XRfV2OX94la0uV5QgxBTI=;
        b=e1cjpVKKh4WgnWP9TWo24vKys4/CCI5Zfxbt+0AjmIbUn6nz0kzaAQAHn0yqCDFxpueAtw
        hq9OnawM2vOH7cAg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Standardize the <linux/sched/type.h>
 header guard #endif
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169528907660.27769.5320233008967960983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0f9a1a4d234c064d8dff69cf3f3755554dd479ec
Gitweb:        https://git.kernel.org/tip/0f9a1a4d234c064d8dff69cf3f3755554dd479ec
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 21 Sep 2023 11:27:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 11:27:37 +02:00

sched/headers: Standardize the <linux/sched/type.h> header guard #endif

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/types.h b/include/linux/sched/types.h
index 3c3e049..969aaf5 100644
--- a/include/linux/sched/types.h
+++ b/include/linux/sched/types.h
@@ -20,4 +20,4 @@ struct task_cputime {
 	unsigned long long		sum_exec_runtime;
 };
 
-#endif
+#endif /* _LINUX_SCHED_TYPES_H */
