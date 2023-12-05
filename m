Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC4B8062AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346536AbjLEXEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjLEXEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:04:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C856B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nGFCpAiXZSazz4S8hvXcJ0KUtE2WqKR2kqCHDpBm/gg=; b=RgBO7w7z3ITS/htE6ZMd7kGcd8
        5IGoriF9dmsvxjbTVfKAX0bLjmDZpDL8CCIh3XWB48x0pLUhBuWui3yNu3LkM3wcwCUBEhdCsWhOe
        1LrImW2oxlrztawTOsvXfPRNQvX6d7LCZx0GlLJ95mBPVsy2z9bE9cFCgahI/u9OqYqLgiwCDrhuB
        DamETEe6tfg41lAYDNYvJG7pX+/KUYFE8p8+eqRjrW9u+waBAYZszpQSlshYov4nqJQGNjFHocF9h
        eCxHl9GUjcD4xG5jKsk6latkeP1ItlEuYIoJ30W4r+XAF+zOzU8xGwi9HQ7IRM1xjQAGDZODm2lHN
        dtmoBvGA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAeTA-008ZyG-37;
        Tue, 05 Dec 2023 23:04:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michal Simek <michal.simek@amd.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clocksource: cadence-ttc: fix some kernel-doc warnings
Date:   Tue,  5 Dec 2023 15:04:48 -0800
Message-ID: <20231205230448.772-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some function kernel-doc warnings to placate scripts/kernel-doc.

timer-cadence-ttc.c:79: warning: Function parameter or member 'clk_rate_change_nb' not described in 'ttc_timer'
timer-cadence-ttc.c:158: warning: Function parameter or member 'cs' not described in '__ttc_clocksource_read'
timer-cadence-ttc.c:194: warning: expecting prototype for ttc_set_{shutdown|oneshot|periodic}(). Prototype was for ttc_shutdown() instead
timer-cadence-ttc.c:196: warning: No description found for return value of 'ttc_shutdown'
timer-cadence-ttc.c:212: warning: No description found for return value of 'ttc_set_periodic'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/clocksource/timer-cadence-ttc.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff -- a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -69,7 +69,7 @@
  * @base_addr:	Base address of timer
  * @freq:	Timer input clock frequency
  * @clk:	Associated clock source
- * @clk_rate_change_nb	Notifier block for clock rate changes
+ * @clk_rate_change_nb:	Notifier block for clock rate changes
  */
 struct ttc_timer {
 	void __iomem *base_addr;
@@ -134,7 +134,7 @@ static void ttc_set_interval(struct ttc_
  * @irq:	IRQ number of the Timer
  * @dev_id:	void pointer to the ttc_timer instance
  *
- * returns: Always IRQ_HANDLED - success
+ * Returns: Always IRQ_HANDLED - success
  **/
 static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
 {
@@ -151,8 +151,9 @@ static irqreturn_t ttc_clock_event_inter
 
 /**
  * __ttc_clocksource_read - Reads the timer counter register
+ * @cs: &clocksource to read from
  *
- * returns: Current timer counter register value
+ * Returns: Current timer counter register value
  **/
 static u64 __ttc_clocksource_read(struct clocksource *cs)
 {
@@ -173,7 +174,7 @@ static u64 notrace ttc_sched_clock_read(
  * @cycles:	Timer interval ticks
  * @evt:	Address of clock event instance
  *
- * returns: Always 0 - success
+ * Returns: Always %0 - success
  **/
 static int ttc_set_next_event(unsigned long cycles,
 					struct clock_event_device *evt)
@@ -186,9 +187,12 @@ static int ttc_set_next_event(unsigned l
 }
 
 /**
- * ttc_set_{shutdown|oneshot|periodic} - Sets the state of timer
- *
+ * ttc_shutdown - Sets the state of timer
  * @evt:	Address of clock event instance
+ *
+ * Used for shutdown or oneshot.
+ *
+ * Returns: Always %0 - success
  **/
 static int ttc_shutdown(struct clock_event_device *evt)
 {
@@ -202,6 +206,12 @@ static int ttc_shutdown(struct clock_eve
 	return 0;
 }
 
+/**
+ * ttc_set_periodic - Sets the state of timer
+ * @evt:	Address of clock event instance
+ *
+ * Returns: Always %0 - success
+ */
 static int ttc_set_periodic(struct clock_event_device *evt)
 {
 	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
