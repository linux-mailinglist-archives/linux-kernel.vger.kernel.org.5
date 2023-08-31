Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCC78E45E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjHaBbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbjHaBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:31:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C0CD7;
        Wed, 30 Aug 2023 18:31:32 -0700 (PDT)
Date:   Thu, 31 Aug 2023 01:31:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693445490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKMSMLKeV9hy8IkjR78R8Wi4MQuuxYWIByzwTcTrtts=;
        b=ttcUopT/QqwWBOaSYDtW9arpToBJOIl3CQ0Tcapfv3IA4yj64nKSIeFa9X1wAlsn0gCfts
        g/zbdUYwbC6kTr0gOzyjjuDgQvomITse80MxIRlIq0410hRnTToPqwFEocTcBeL2yJhNue
        b3EFB+MF6J4KCfJrlJgeJe7Gf8cZZ2mi92MgSZ2mjAj8KsgUfoEpynvL6JheohLpyKkeKH
        4YajbhPmp5dZ8lP4lD5r+JmkQRJq380K7rlomYDfAkW9h1llMfMZqCYpYomdRfNSG6ibvt
        ZVba3uZ+EX/5p3MWf52HTznhTDXDjybs2fAHVpHUHIWx5uRk+6rK0gyihmSO0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693445490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKMSMLKeV9hy8IkjR78R8Wi4MQuuxYWIByzwTcTrtts=;
        b=wWk9weZAAhEezacsaePJ+RI1q0E+/pG6ExCxYR+/iNt3iFKh8Rrlk+S6EbA+2sSsovIuwo
        s5PVTFSZf83TYJAg==
From:   "tip-bot2 for Mans Rullgard" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sun5i: Remove pointless struct
Cc:     Mans Rullgard <mans@mansr.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230630201800.16501-3-mans@mansr.com>
References: <20230630201800.16501-3-mans@mansr.com>
MIME-Version: 1.0
Message-ID: <169344548973.27769.3145707060087008875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0b38dd178df435d9895ad015dde34cd4139374e9
Gitweb:        https://git.kernel.org/tip/0b38dd178df435d9895ad015dde34cd4139374e9
Author:        Mans Rullgard <mans@mansr.com>
AuthorDate:    Fri, 30 Jun 2023 21:01:27 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Aug 2023 12:15:13 +02:00

clocksource/drivers/sun5i: Remove pointless struct

Remove the pointless struct added in the previous patch to make
the diff smaller.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230630201800.16501-3-mans@mansr.com
---
 drivers/clocksource/timer-sun5i.c | 49 +++++++++++++-----------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index e0ca97c..3ca427e 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -35,22 +35,17 @@
 
 #define TIMER_SYNC_TICKS	3
 
-/* Pointless struct to minimise diff */
-struct _sun5i_timer {
+struct sun5i_timer {
 	void __iomem		*base;
 	struct clk		*clk;
 	struct notifier_block	clk_rate_cb;
 	u32			ticks_per_jiffy;
-};
-
-struct sun5i_timer {
-	struct _sun5i_timer	timer;
 	struct clocksource	clksrc;
 	struct clock_event_device	clkevt;
 };
 
 #define nb_to_sun5i_timer(x) \
-	container_of(x, struct sun5i_timer, timer.clk_rate_cb)
+	container_of(x, struct sun5i_timer, clk_rate_cb)
 #define clksrc_to_sun5i_timer(x) \
 	container_of(x, struct sun5i_timer, clksrc)
 #define clkevt_to_sun5i_timer(x) \
@@ -64,28 +59,28 @@ struct sun5i_timer {
  */
 static void sun5i_clkevt_sync(struct sun5i_timer *ce)
 {
-	u32 old = readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1));
+	u32 old = readl(ce->base + TIMER_CNTVAL_LO_REG(1));
 
-	while ((old - readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_TICKS)
+	while ((old - readl(ce->base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_TICKS)
 		cpu_relax();
 }
 
 static void sun5i_clkevt_time_stop(struct sun5i_timer *ce, u8 timer)
 {
-	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
-	writel(val & ~TIMER_CTL_ENABLE, ce->timer.base + TIMER_CTL_REG(timer));
+	u32 val = readl(ce->base + TIMER_CTL_REG(timer));
+	writel(val & ~TIMER_CTL_ENABLE, ce->base + TIMER_CTL_REG(timer));
 
 	sun5i_clkevt_sync(ce);
 }
 
 static void sun5i_clkevt_time_setup(struct sun5i_timer *ce, u8 timer, u32 delay)
 {
-	writel(delay, ce->timer.base + TIMER_INTVAL_LO_REG(timer));
+	writel(delay, ce->base + TIMER_INTVAL_LO_REG(timer));
 }
 
 static void sun5i_clkevt_time_start(struct sun5i_timer *ce, u8 timer, bool periodic)
 {
-	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
+	u32 val = readl(ce->base + TIMER_CTL_REG(timer));
 
 	if (periodic)
 		val &= ~TIMER_CTL_ONESHOT;
@@ -93,7 +88,7 @@ static void sun5i_clkevt_time_start(struct sun5i_timer *ce, u8 timer, bool perio
 		val |= TIMER_CTL_ONESHOT;
 
 	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
-	       ce->timer.base + TIMER_CTL_REG(timer));
+	       ce->base + TIMER_CTL_REG(timer));
 }
 
 static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
@@ -118,7 +113,7 @@ static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
 	struct sun5i_timer *ce = clkevt_to_sun5i_timer(clkevt);
 
 	sun5i_clkevt_time_stop(ce, 0);
-	sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
+	sun5i_clkevt_time_setup(ce, 0, ce->ticks_per_jiffy);
 	sun5i_clkevt_time_start(ce, 0, true);
 	return 0;
 }
@@ -139,7 +134,7 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 {
 	struct sun5i_timer *ce = dev_id;
 
-	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
+	writel(0x1, ce->base + TIMER_IRQ_ST_REG);
 	ce->clkevt.event_handler(&ce->clkevt);
 
 	return IRQ_HANDLED;
@@ -149,7 +144,7 @@ static u64 sun5i_clksrc_read(struct clocksource *clksrc)
 {
 	struct sun5i_timer *cs = clksrc_to_sun5i_timer(clksrc);
 
-	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
+	return ~readl(cs->base + TIMER_CNTVAL_LO_REG(1));
 }
 
 static int sun5i_rate_cb(struct notifier_block *nb,
@@ -166,7 +161,7 @@ static int sun5i_rate_cb(struct notifier_block *nb,
 	case POST_RATE_CHANGE:
 		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
 		clockevents_update_freq(&cs->clkevt, ndata->new_rate);
-		cs->timer.ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
+		cs->ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
 		break;
 
 	default:
@@ -180,7 +175,7 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 					  struct sun5i_timer *cs,
 					  unsigned long rate)
 {
-	void __iomem *base = cs->timer.base;
+	void __iomem *base = cs->base;
 	int ret;
 
 	writel(~0, base + TIMER_INTVAL_LO_REG(1));
@@ -206,7 +201,7 @@ static int __init sun5i_setup_clockevent(struct device_node *node,
 					 struct sun5i_timer *ce,
 					 unsigned long rate, int irq)
 {
-	void __iomem *base = ce->timer.base;
+	void __iomem *base = ce->base;
 	int ret;
 	u32 val;
 
@@ -282,13 +277,13 @@ static int __init sun5i_timer_init(struct device_node *node)
 		goto err_disable_clk;
 	}
 
-	st->timer.base = timer_base;
-	st->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
-	st->timer.clk = clk;
-	st->timer.clk_rate_cb.notifier_call = sun5i_rate_cb;
-	st->timer.clk_rate_cb.next = NULL;
+	st->base = timer_base;
+	st->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
+	st->clk = clk;
+	st->clk_rate_cb.notifier_call = sun5i_rate_cb;
+	st->clk_rate_cb.next = NULL;
 
-	ret = clk_notifier_register(clk, &st->timer.clk_rate_cb);
+	ret = clk_notifier_register(clk, &st->clk_rate_cb);
 	if (ret) {
 		pr_err("Unable to register clock notifier.\n");
 		goto err_disable_clk;
@@ -305,7 +300,7 @@ static int __init sun5i_timer_init(struct device_node *node)
 	return sun5i_setup_clockevent(node, st, rate, irq);
 
 err_remove_notifier:
-	clk_notifier_unregister(clk, &st->timer.clk_rate_cb);
+	clk_notifier_unregister(clk, &st->clk_rate_cb);
 err_disable_clk:
 	clk_disable_unprepare(clk);
 err_free:
