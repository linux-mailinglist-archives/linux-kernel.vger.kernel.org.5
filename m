Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52F57A2712
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjIOTTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjIOTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:19:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3998;
        Fri, 15 Sep 2023 12:18:55 -0700 (PDT)
Date:   Fri, 15 Sep 2023 19:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694805534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dOfLNwr5j5+nJMGu7UeiBp6F7Fcv0BHbYEyKt/sJX2Y=;
        b=4pzu5s7WM3EW2Hzz2c0RJ+K/QMODb813YMXMIhDokiN3L6Bnw67hdqUNE55kj4tVytUcfU
        EfrcATWUDXWmlHNohsxVSmXSiPWnH/piV3h+gS632cJhPdNBenp3kHf9Y6PGbCvpESfDxa
        Mlnj8MXMNh/o1TIxDFRBVqgyGS4p/4THQfd1T9n7wFLbw/pmqPioffQJWT6EExUBypAMFB
        Fhzy+U1TYbbUk7sOJAaOYcgFvHP0oOZlmFMtieXjHa1qPyaZF6Fv6LM+YIXnMl/v6XteL1
        8ToOrOJ6wa9s2ZtSZINSXKJOkeyScaQS83DTQjZtVeEv/L6EcgqQsJ7TmXrCRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694805534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dOfLNwr5j5+nJMGu7UeiBp6F7Fcv0BHbYEyKt/sJX2Y=;
        b=s4yU4NEXgNalQ5C3mJDaN7wvET4+j30XT17+opQiwAGCBbKPjxJr4fZWuBIY6ClsjKizrU
        XG61V/KgSFFmCLDA==
From:   "tip-bot2 for Olaf Hering" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Remove unused cpuhp_state
 CPUHP_AP_X86_VDSO_VMA_ONLINE
Cc:     Olaf Hering <olaf@aepfle.de>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230904121350.18055-1-olaf@aepfle.de>
References: <20230904121350.18055-1-olaf@aepfle.de>
MIME-Version: 1.0
Message-ID: <169480553346.27769.4159995992587319133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     32e4fa37fa667fdf53499b9de92737dc75199d8e
Gitweb:        https://git.kernel.org/tip/32e4fa37fa667fdf53499b9de92737dc75199d8e
Author:        Olaf Hering <olaf@aepfle.de>
AuthorDate:    Mon, 04 Sep 2023 14:13:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Sep 2023 21:13:13 +02:00

cpu/hotplug: Remove unused cpuhp_state CPUHP_AP_X86_VDSO_VMA_ONLINE

Commit b2e2ba578e01 ("x86/vdso: Initialize the CPU/node NR segment
descriptor earlier") removed the single user of this constant.

Remove it to reduce the size of cpuhp_hp_states[].

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230904121350.18055-1-olaf@aepfle.de

---
 include/linux/cpuhotplug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 06dda85..cd8bd6e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -205,7 +205,6 @@ enum cpuhp_state {
 	CPUHP_AP_KVM_ONLINE,
 	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
-	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
 	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
