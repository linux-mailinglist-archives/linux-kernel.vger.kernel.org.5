Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82F2756B60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGQSLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGQSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB323AF;
        Mon, 17 Jul 2023 11:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F32611D5;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFFFC433CA;
        Mon, 17 Jul 2023 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=EQjNoHdHschIUdiIu2na4lA90ImcxAEv7wrp3pUJoEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laK/2XTo0opyRe2Eqgtq6c6ArDkndisgPzymG7df7z04eSMTbHVKa58r1K4bFirPa
         +3KJreo9dK1gM0pABVlnDnANLbo9s9lgwXyB7wyNnS/WZpsxZhEZUBCGSzSoLGbT8A
         AsXQd0oSiek5kaVb+1mGnhsgXg179RMlNAB4w1si1/nEEke+nGDKCn2muEvIGsgxg4
         HEQXYHaWXLze2V4JXzugWDyo/ZBqJDQKUFm+uguU0qiGJ6vCGuVd5osTupah0gvt9u
         IIBGIiBtj4mnyIuDzQ5RxoNzJC1QqCmjgO0lvYi8nPVBOHZywXky6BVJS8JA1RL1Ce
         RqOkrm/1TQBSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AFFEACE04CD; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/13] rcuscale: Fix gp_async_max typo: s/reader/writer/
Date:   Mon, 17 Jul 2023 11:11:27 -0700
Message-Id: <20230717181138.1098063-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
References: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 4277037e0996..15edd8c82933 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -84,7 +84,7 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 #endif
 
 torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
-torture_param(int, gp_async_max, 1000, "Max # outstanding waits per reader");
+torture_param(int, gp_async_max, 1000, "Max # outstanding waits per writer");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
-- 
2.40.1

