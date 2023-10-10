Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4937BFA90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjJJMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjJJMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBBFFE;
        Tue, 10 Oct 2023 05:00:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50140C433CB;
        Tue, 10 Oct 2023 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939199;
        bh=FNbwODmxQo3GGwEsJGLAfDuk3+x/AsZx/VjeIBG8CLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sK6DBDEVVhoqBkJgXSl3qNZo8EM8D6CcrGeHQ2X9GCDvOcEs4adIYpAKzQfKBjt+r
         dvVxr90w/XTErnjE8nxOIYby/Niy5k9z2Fanlc7ZH0yjJ1l4Z3wV+mYcAenu8Qjl7E
         TVovnSyrtaplpTAIWhVCRx9BwiiRu97x973I2lbgsVUsl99XNH73hrpMRYYrEkgGZY
         WgBVeP58vtD6Xy3DRlNBWNKS8UnAcGdwAU4JkB//mVWxbxKufsN/rQlRBoLj09xpd9
         VKsGKRHBRfBDLOXI/x6zY1/4MLSiC4bSpPrlihFzU1LNG+1uWgAX/Jpi07pck7dEqT
         UfAdLRI0aFRIA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 09/23] locktorture: Alphabetize torture_param() entries
Date:   Tue, 10 Oct 2023 13:59:07 +0200
Message-Id: <20231010115921.988766-10-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

There are getting to be too many module parameters for a random list to be
comfortable, so this commit alphabetizes the list.  Strictly code motion.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/locking/locktorture.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 441866259278..57ee16cf879d 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -33,21 +33,21 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
-torture_param(int, nwriters_stress, -1, "Number of write-locking stress-test threads");
-torture_param(int, nreaders_stress, -1, "Number of read-locking stress-test threads");
 torture_param(int, long_hold, 100, "Do occasional long hold of lock (ms), 0=disable");
+torture_param(int, nested_locks, 0, "Number of nested locks (max = 8)");
+torture_param(int, nreaders_stress, -1, "Number of read-locking stress-test threads");
+torture_param(int, nwriters_stress, -1, "Number of write-locking stress-test threads");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (s), 0=disable");
+torture_param(int, rt_boost, 2,
+		   "Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
+torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
 torture_param(int, shuffle_interval, 3, "Number of jiffies between shuffles, 0=disable");
 torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
-torture_param(int, rt_boost, 2,
-		   "Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
-torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
 torture_param(int, writer_fifo, 0, "Run writers at sched_set_fifo() priority");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
-torture_param(int, nested_locks, 0, "Number of nested locks (max = 8)");
 /* Going much higher trips "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" errors */
 #define MAX_NESTED_LOCKS 8
 
-- 
2.34.1

