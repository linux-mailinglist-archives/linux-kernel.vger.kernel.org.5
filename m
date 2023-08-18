Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2AA780773
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358752AbjHRIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358805AbjHRIrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB883A94
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96EEB64228
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:47:40 +0000 (UTC)
Received: from [192.168.42.3] (194-45-78-10.static.kviknet.net [194.45.78.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 21695C433C8;
        Fri, 18 Aug 2023 08:47:37 +0000 (UTC)
Subject: [PATCH] softirq: Adjust comment for CONFIG_PREEMPT_RT in #else
From:   Jesper Dangaard Brouer <hawk@kernel.org>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org
Date:   Fri, 18 Aug 2023 10:47:35 +0200
Message-ID: <169234845563.1636130.4897344550692792117.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #ifdef CONFIG_PREEMPT_RT #else statement had a comment
that made me think the code below #else statement was RT code.
After reading the code closer I realized it was not RT code.
Adjust comment to !RT to helper future readers of the code.

Fixes: 8b1c04acad08 ("softirq: Make softirq control and processing RT aware")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 kernel/softirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 807b34ccd797..b9a8384821b9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -292,7 +292,7 @@ void do_softirq_post_smp_call_flush(unsigned int was_pending)
 		invoke_softirq();
 }
 
-#else /* CONFIG_PREEMPT_RT */
+#else /* !CONFIG_PREEMPT_RT */
 
 /*
  * This one is for softirq.c-internal use, where hardirqs are disabled


