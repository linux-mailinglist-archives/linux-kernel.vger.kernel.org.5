Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75FA756B63
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGQSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGQSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7FEE55;
        Mon, 17 Jul 2023 11:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7EAF611E2;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14647C433C9;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=+0fBEhqmyuNH4//E14nuyQmDTxK/vKbTt5dtpbaWLmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7C0h94+4Ry+wzdtHCk9hU2/NzV7+li6S/BI8OTa+o6I5A3O8KFUPp/YyHj8mb09s
         F+dAhHtSU/d9DFJbBWkqdlN0Jy3p/4uX8kD5zfNnqm5PZ3ZylyqP9GwiCbUhdhZSz1
         736DZOggXFfFwi+bpCSGfqtPMKH7pbJq5yZ4uIAjlKYm1fRaROSh+qve9ju2bds6YK
         0AvuLuQ6NvgYXm7P/bmcFBrFUJQye4UeVla7EFm7qbjTPEC3XXyPv/b8MHHotMtZiE
         uLCa2aQ21aqJ+2G6CbIkBnkAujmuOpljmGTuhopWJnks91WYmnaoe2yfDu61e/oV05
         r+/Zyy4XxuO3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B4CC9CE0836; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/13] rcuscale: Print out full set of module parameters
Date:   Mon, 17 Jul 2023 11:11:29 -0700
Message-Id: <20230717181138.1098063-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
References: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 7c5bab5a4f19..18f1b0e13604 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -525,8 +525,8 @@ static void
 rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
-		 "--- %s: nreaders=%d nwriters=%d verbose=%d shutdown=%d\n",
-		 scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
+		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown=%d\n",
+		 scale_type, tag, gp_async, gp_async_max, gp_exp, holdoff, minruntime, nrealreaders, nrealwriters, writer_holdoff, writer_holdoff_jiffies, verbose, shutdown);
 }
 
 /*
-- 
2.40.1

