Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7356C7C852B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjJML7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjJML7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13657E1;
        Fri, 13 Oct 2023 04:59:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D3EC433C9;
        Fri, 13 Oct 2023 11:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198356;
        bh=bwVDWmfgW6KPhnAu5RS+ChX+7Qv0AeJsa5cg4h7G8/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fW8I0GQfeVeMKSCJ2eo4nXP9LY628stEuP5ZiLSvnFUYwa0FrRvHtHuC49O8rQ3WM
         5Dh852JhFOCBusJDIqyR4iChhbP45j1iA3hcfUIlBdmRboAk/kpo211ybu4M3cfjnF
         ryGUWIylqDHxxKLjPBEc01+e4J9vOnG7AMSDLxPj7XEMTdE7sKwtrCN9ttvDfpVPa9
         vajb7cGPCEisvuOGPobI0V/rhl/9jwvaq6IdNPEMVJ+CgHs+if6icB/LekJhPjD4CN
         W0MkrgwqI9ePgi4EtZNhMm+6HbPqkILkyTYGTMVTcTI+PwUq48NTdTdyHt052pXM9z
         kwJfdgouswtvA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 03/18] rcu/tree: Remove superfluous return from void call_rcu* functions
Date:   Fri, 13 Oct 2023 13:58:47 +0200
Message-Id: <20231013115902.1059735-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The return keyword is not needed here.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..7c79480bfaa0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2713,7 +2713,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
  */
 void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
 {
-	return __call_rcu_common(head, func, false);
+	__call_rcu_common(head, func, false);
 }
 EXPORT_SYMBOL_GPL(call_rcu_hurry);
 #endif
@@ -2764,7 +2764,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	return __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
+	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-- 
2.34.1

