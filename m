Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0464C7B0786
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjI0PBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjI0PBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:01:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD9F4;
        Wed, 27 Sep 2023 08:01:33 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:01:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695826890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmgklms1sORVG0m4r7Iw/uVIkEo/q5qKTO88tbyXacw=;
        b=MBqkKIZE8BznqJ17Vs8uXLDxq39LBwlNsT24VjzKkunXaS7UUkJZ8ILV5TVvEK0j+tX8iP
        Cw1XjcuY4GbBixpNAEFj2bQ3SelBqMPUCGaKYw9KeR5zeJObxAywHuTVcdCVPzxOnOAdi1
        10VFXP1C6RU0ztSTgK9md/zBUKhclv/mp22zRSIdloc/sZnSw9hU2OcU1kE2LXRFRnqdsL
        GbA28Z8MrElztVIktnyvAy9NI0DUHap2aT37xlrO/APaLGcPAfxlO1sEoA1SRKMw816XwN
        U4fxJFmSZLPix1CDsZkP6gCnRonTx4LlZr3JRPcyeFzWupGeN+jxXh4tecG+4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695826890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmgklms1sORVG0m4r7Iw/uVIkEo/q5qKTO88tbyXacw=;
        b=2MG4+dJqbOyKxOr9vZ5IbFkF3fyQ4MU4wCTcp4UowC2WWZrgKQgH/99LXZXEcmy3TTMj5m
        fFqC6C4v0EEpLxDg==
From:   "tip-bot2 for Xueshi Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/nohz: Remove unused
 tick_nohz_idle_stop_tick_protected()
Cc:     Xueshi Hu <xueshi.hu@smartx.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912104406.312185-5-frederic@kernel.org>
References: <20230912104406.312185-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <169582688984.27769.10942448414199361460.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c02a427f7b64ed5b840a0720a6cee5a17a1e7e07
Gitweb:        https://git.kernel.org/tip/c02a427f7b64ed5b840a0720a6cee5a17a1e7e07
Author:        Xueshi Hu <xueshi.hu@smartx.com>
AuthorDate:    Tue, 12 Sep 2023 12:44:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Sep 2023 16:58:11 +02:00

tick/nohz: Remove unused tick_nohz_idle_stop_tick_protected()

All the caller has been removed since commit 336f560a8917 ("x86/xen: don't
let xen_pv_play_dead() return")

Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230912104406.312185-5-frederic@kernel.org

---
 include/linux/tick.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9459fef..716d17f 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -140,14 +140,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
-
-static inline void tick_nohz_idle_stop_tick_protected(void)
-{
-	local_irq_disable();
-	tick_nohz_idle_stop_tick();
-	local_irq_enable();
-}
-
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -170,8 +162,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
-
-static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
