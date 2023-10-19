Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9D7CF791
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbjJSLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjJSLzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:55:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2351DCF;
        Thu, 19 Oct 2023 04:55:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71318C433CB;
        Thu, 19 Oct 2023 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716504;
        bh=Go3oKLV2iwygVow1ZLQqYglzITzKKMjGLPjpDzrAZBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7R5PODf/z3kMx+FQKdwekIaM7FboamFP9pEXVbZCvWTXyybu9mERIPU6/5DMbG8W
         fMKR4cLZdApb+fX+yUow94ODrD4l2zF2ODLNBuMPb9/gAhITmlAsOx70OscuK9Bc4h
         lshWDkbl9OHMaEhfPcBIGv/HL9EI1IIyL67DGWwYHg+Uit4LKw+KrHPUBaBpUI12nz
         As0SZCvtgiuLs1wc3hWGSSmqqpetOaEonNkxwELDE//KqRLs3eUkw9gqZItwJyVvMu
         n9Y9Ov0DV8RxnCaruLDy/lUIwPkD0cS4AkC9IU0rsjBMgZRhyMewm/OqqlNBGlBai5
         HR9B958lYlZXQ==
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
Subject: [PATCH 2/3] refscale: Print out additional module parameters
Date:   Thu, 19 Oct 2023 13:54:51 +0200
Message-Id: <20231019115452.1215974-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019115452.1215974-1-frederic@kernel.org>
References: <20231019115452.1215974-1-frederic@kernel.org>
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

The refscale.verbose_batched and refscale.lookup_instances module
parameters are omitted from the ref_scale_print_module_parms()
beginning-of-test output.  This commit therefore adds them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/refscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 750a63e99539..2c2648a3ad30 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1025,8 +1025,8 @@ static void
 ref_scale_print_module_parms(struct ref_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
-		 verbose, shutdown, holdoff, loops, nreaders, nruns, readdelay);
+		 "--- %s:  verbose=%d verbose_batched=%d shutdown=%d holdoff=%d lookup_instances=%ld loops=%ld nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
+		 verbose, verbose_batched, shutdown, holdoff, lookup_instances, loops, nreaders, nruns, readdelay);
 }
 
 static void
-- 
2.34.1

