Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B47666F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjG1IXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjG1IW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:22:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C2030E0;
        Fri, 28 Jul 2023 01:21:23 -0700 (PDT)
Date:   Fri, 28 Jul 2023 08:21:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690532482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vbdquQpgk4n9HAlhi8cxuSh9d1y+3JXXGaBXsoEW6M8=;
        b=Trr2qBEvMeNW9Z5IQJBYeFH15nBJOfRtkqFYsdxe2VAXvo1rjO34EbQjEen8wtL99T/S/4
        2R34RAoEu64Y3zvaSumjoXEnb42qaGsKCvWcUwfg8YuH3r2t8FVRChY2XB3bIfUwPe5wZC
        6dt2+ZsgfSuSV3lOJB46vQOX1iPBh0Sf2B0d006q3lai25ciG93GuLNgVYBLdCgJgBA3GI
        TieCzbWe/uuc23h9sNOJ4eNJIE7MgpZO4vbM71kr3x3owv0rHzGjQRNttGiPOXlQBWFpZe
        N/EbtLiWFaetLMuNNGwojQI5eM6t4hlEg+GM7V37XGUjakzFbXRvKeqmEmQeUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690532482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vbdquQpgk4n9HAlhi8cxuSh9d1y+3JXXGaBXsoEW6M8=;
        b=Y3iS/tHZFLUGSj6hh4K5M0cD6iIhULH3haEVQ5j/p9oN8agKAh2cOX/8arOHVXU+JMUM0P
        nvOG3hWE+f6nN3Bw==
From:   "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smpboot: Remove a stray comment about CPU hotplug
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727180533.3119660-2-sohil.mehta@intel.com>
References: <20230727180533.3119660-2-sohil.mehta@intel.com>
MIME-Version: 1.0
Message-ID: <169053248168.28540.18322875262543490504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     52defa4a5e719a57992aed52c8d3e214e75ac276
Gitweb:        https://git.kernel.org/tip/52defa4a5e719a57992aed52c8d3e214e75ac276
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Jul 2023 18:05:31 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 10:17:53 +02:00

x86/smpboot: Remove a stray comment about CPU hotplug

This old comment is irrelavant to the logic of disabling interrupts and
could be misleading. Remove it.

Now, hlt_play_dead() resembles the code that the comment was initially
added for, but, it doesn't make sense anymore because an offlined cpu
could also be put into other states such as mwait.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230727180533.3119660-2-sohil.mehta@intel.com

---
 arch/x86/kernel/smpboot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd..6a09a02 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1614,9 +1614,7 @@ void play_dead_common(void)
 	idle_task_exit();
 
 	cpuhp_ap_report_dead();
-	/*
-	 * With physical CPU hotplug, we should halt the cpu
-	 */
+
 	local_irq_disable();
 }
 
