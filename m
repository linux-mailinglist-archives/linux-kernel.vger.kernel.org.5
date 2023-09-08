Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECDA79910F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbjIHUgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242606AbjIHUgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A619A12B;
        Fri,  8 Sep 2023 13:36:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F32C433CA;
        Fri,  8 Sep 2023 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205395;
        bh=2O4AhK1gRpJtW3osmb4mUbcQUKqDQptCCmdY+N3unFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBPRxcpvefJOnN0MiTosiPzzSQ/E6C7aKG8cABnVJcL0onMiVbqj8F0MKP82um8tc
         nao4dnggpvn43WYZHTiQlmcrB3tXAC00kWGyv1bVyDv2YolPqW9BHpKpvVLGhA8q5a
         Iv/p2AooAAjFQG10ZjWhGvK7B3sqwNasgRqzr/id/bdkLUAMn69DMMAkWFRb32wqdM
         xUZ9sxNLxEJwAxeTeRhSVB94vOf8SDfG/Ih0tNNuyw8oc9lYJ2BBuII+zc7w/fi1FL
         70n/3tTq7ADZVjqQe0L8ccZ7RJ0Ni1mD+chFcOL3LIxPtIZkrBs9yl+0UeDSMFsFwj
         woYOwiNFueTAw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 09/10] rcu: Remove references to rcu_migrate_callbacks() from diagrams
Date:   Fri,  8 Sep 2023 22:36:02 +0200
Message-ID: <20230908203603.5865-10-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908203603.5865-1-frederic@kernel.org>
References: <20230908203603.5865-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is gone since:

	53b46303da84 (rcu: Remove rsp parameter from rcu_boot_init_percpu_data() and friends)

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
index 6e690a3be161..53e0dc2a2c79 100644
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
2.41.0

