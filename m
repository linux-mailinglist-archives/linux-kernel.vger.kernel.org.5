Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25517BA454
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbjJEQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjJEQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D21900F;
        Thu,  5 Oct 2023 01:43:36 -0700 (PDT)
Date:   Thu, 05 Oct 2023 08:43:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696495412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Why89xGUoWOIAZvg8yO7eUDaamP8MAGHF/fgD1DVeE=;
        b=L69SFh45gNYbqrg6ArjOm4fybA7XahxtSmu6oMuRCe6B2tkO9XMUCFa2rFlnp0j5ckxUPC
        3I20TJHDevlgCDwVrpjpzqS8tbJCk+hdD8oFFJi/ZvltNSTx+HEy3RjLWAALU3bOZKZLdy
        SX7mtj3pNAq9Bb/+Pcv1bC55fb0Qn26hcDjJGSxvY8a2uAkIPxVnam6ZL2tlw1kI6rRMod
        ZUPVjyqa9Lfwp0NsIqm+fga3wv6HfVJqBUaJkMsmdrsQD/LElQNugEv07Mcz2dr3lceyxO
        3I5J5+TrW5QRXsMfcTqzY6+gISS5QJBV6kW2HvPWJ2XW2dCiSmOB1s2+To+8HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696495412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Why89xGUoWOIAZvg8yO7eUDaamP8MAGHF/fgD1DVeE=;
        b=+AtvaRgOOgfcn8FbE9kutqLaQcDCzJYPCn1vX9sUv0cMiGLLHlMCgaOv6/jRQ7xvtJ182E
        w0vvq62tvww88PDA==
From:   "tip-bot2 for pangzizhen001@208suo.com" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/seqlock: Fix typo in comment
Cc:     Zizhen Pang <pangzizhen001@208suo.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <70293ecd5bb7a1cd370fd4d95c35f936@208suo.com>
References: <70293ecd5bb7a1cd370fd4d95c35f936@208suo.com>
MIME-Version: 1.0
Message-ID: <169649541111.3135.17358619656028452700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0cff993e08a7578e2c1df93a95fc5059f447e7ae
Gitweb:        https://git.kernel.org/tip/0cff993e08a7578e2c1df93a95fc5059f447e7ae
Author:        pangzizhen001@208suo.com <pangzizhen001@208suo.com>
AuthorDate:    Thu, 20 Jul 2023 23:45:39 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 10:39:44 +02:00

locking/seqlock: Fix typo in comment

s/the the
 /the

[ mingo: Cleaned up the changelog. ]

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/70293ecd5bb7a1cd370fd4d95c35f936@208suo.com
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 987a59d..ea7a582 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -864,7 +864,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().
  * This way, no redundant lockdep_assert_held() checks are added.
  */
