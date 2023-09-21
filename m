Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460F37AA23B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjIUVOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjIUVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:13:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F898A47;
        Thu, 21 Sep 2023 10:56:48 -0700 (PDT)
Date:   Thu, 21 Sep 2023 09:37:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695289076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ohayujW0N2DSkocg5TGyWYnk4n1dvuW85t/hn7PIhc4=;
        b=4qt3bAcwaQGtRF0jw4eGPyvul6mxWLSwTdOSMnhzVY+8ebKGQdmdtZAyM2+E6s6wwNrEPy
        GDyHAkPoGz/lD9pMdp3x4lyo8hbxbih6AjMHqBgvue/Su4MAlxxhCmnYQ/fbLut9W9zDjf
        r6ssbsoAWtC6JXdotPOjHLhjgEqbH7UsYmjq0F37zjn8VvmCXfNnUVFyuu2JhsAU+WMMsC
        kn2frCNME05jt1TEEbikP+O5+undHQn9VgEDQ6X7GhMnjQL6GEY44KN/Ul5LtpxJepWWxx
        OkEVoaXtZlSCVHYKUjiqtT0knnDoGzHexI1dqyG9mjeBlCAPUQ6+QwNVf/Ns/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695289076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ohayujW0N2DSkocg5TGyWYnk4n1dvuW85t/hn7PIhc4=;
        b=pWStOUfdAwNW2KKMT7mNmLJ0s0XBWcM1iaYqePk4SnYh5F7Ng0L/NEbEM+vfBVH5XDLmD1
        yi8nIQM8S9a9kkBw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Standardize the <linux/sched/smt.h>
 header guard #endif
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169528907596.27769.4921292372528142067.tip-bot2@tip-bot2>
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

Commit-ID:     1632d47fae2f2d229dd432854c4443ebb0bb27a4
Gitweb:        https://git.kernel.org/tip/1632d47fae2f2d229dd432854c4443ebb0bb27a4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 21 Sep 2023 11:28:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 11:28:48 +02:00

sched/headers: Standardize the <linux/sched/smt.h> header guard #endif

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/smt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
index 59d3736..fb1e295 100644
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -17,4 +17,4 @@ static inline bool sched_smt_active(void) { return false; }
 
 void arch_smt_update(void);
 
-#endif
+#endif /* _LINUX_SCHED_SMT_H */
