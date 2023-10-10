Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695CE7BF958
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjJJLLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjJJLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:11:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402E8D8;
        Tue, 10 Oct 2023 04:11:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA21C433C8;
        Tue, 10 Oct 2023 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696936268;
        bh=kMT6jsRDW5u1mR0slm226cMQVQUPEUfKxZwIN7nWu/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNWw///zb6m3i8LiU9IxCovbVxgx2Janpc3MBuSLTcBmgINbbOWyYXNF4jLz8GN36
         aaQ3TeIM+/feLx9MIOFmHK9c4Pvi/H591MQZ8e32kIliqegyGtm/0z4QtrTBTL5vMI
         vNp3xmegu1KCJOgyINVfT28WThykKiWf8bzrbfth3P7e58rHL+P+x641MMG89Ir42j
         q5xAqZRsN4cje1m0Rwg+3jpmVxXsgvBtzkyFavCT5+ZY0+biSIoh4ljqhVjda2kBQk
         HIcaCasYvHvAs/1ay5V7ldyNlxJ2rzTxEvOgl6HBAD9bNfqDr59jRXjtC4pGeSFWzs
         4QftQvyxiNq2Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 3/3] rcu: Remove references to rcu_migrate_callbacks() from diagrams
Date:   Tue, 10 Oct 2023 13:10:53 +0200
Message-Id: <20231010111053.986507-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010111053.986507-1-frederic@kernel.org>
References: <20231010111053.986507-1-frederic@kernel.org>
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

This function is gone since:

	53b46303da84 (rcu: Remove rsp parameter from rcu_boot_init_percpu_data() and friends)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../Design/Memory-Ordering/TreeRCU-callback-registry.svg | 9 ---------
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg  | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
index 7ac6f9269806..63eff867175a 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
@@ -564,15 +564,6 @@
        font-size="192"
        id="text202-7-9-6"
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcutree_migrate_callbacks()</text>
-    <text
-       xml:space="preserve"
-       x="8335.4873"
-       y="5357.1006"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       id="text202-7-9-6-0"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_migrate_callbacks()</text>
     <text
        xml:space="preserve"
        x="8768.4678"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 069f6f8371c2..e4a66f8e92c5 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -1446,15 +1446,6 @@
        font-size="192"
        id="text202-7-9-6"
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcutree_migrate_callbacks()</text>
-    <text
-       xml:space="preserve"
-       x="8335.4873"
-       y="5357.1006"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       id="text202-7-9-6-0"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_migrate_callbacks()</text>
     <text
        xml:space="preserve"
        x="8768.4678"
-- 
2.34.1

