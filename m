Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872EF756B25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGQSBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGQSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC9E76;
        Mon, 17 Jul 2023 11:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D961B611CD;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FACC433C7;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616872;
        bh=3M0SpVkyWqfYcXcGZBOE8myfp0f75lb5pDV5D9CsGeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afXPWLmb4HPEM6fiia71/JKSX40Lvp7TBlcEji2LtAn9S9oRB+ZMODyrPR5gjN7B6
         wzJsYdjGlJX9aQsI9GuuEulcxHqfek81LzayTYxTqOfTxlrXmhrDXcstXa07HeDxim
         SezmFQVm65dlBNQST2StigcXNJiGCMCJXqKiZAaegLT/8uXmHwGT0JbARInUsIk083
         ZvSASeRPAjV+HraDMQm7aI37pjiL8tHN6OvlU1RKKgW6I0rnNKfSshRgAOMil5d7a+
         BeMlWLDhvc0krR7ouaabAIr3vSoLQFm8ZP4Sgmw44uNa4AVfEY1NCAOqlbarkDOqGG
         l+AY2Cg4whPWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D65F4CE0806; Mon, 17 Jul 2023 11:01:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, SeongJae Park <sj@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/7] Docs/RCU/rculist_nulls: Fix trivial coding style
Date:   Mon, 17 Jul 2023 11:01:06 -0700
Message-Id: <20230717180110.1097362-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
References: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

Lookup example of non-hlist_nulls management is missing a semicolon, and
having inconsistent indentation (one line is using single space
indentation while others are using two spaces indentation).  Fix the
trivial issues.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 0612a6387d8e..25b739885cfa 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -26,7 +26,7 @@ algorithms:
 ::
 
   begin:
-  rcu_read_lock()
+  rcu_read_lock();
   obj = lockless_lookup(key);
   if (obj) {
     if (!try_get_ref(obj)) { // might fail for free objects
@@ -70,8 +70,8 @@ And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
        pos && ({ prefetch(pos->next); 1; }) &&
        ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
        pos = rcu_dereference(pos->next))
-   if (obj->key == key)
-     return obj;
+    if (obj->key == key)
+      return obj;
   return NULL;
 
 Quoting Corey Minyard::
-- 
2.40.1

