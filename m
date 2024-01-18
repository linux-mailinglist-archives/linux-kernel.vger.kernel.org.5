Return-Path: <linux-kernel+bounces-30508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC24C831FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BA5286D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2E2E825;
	Thu, 18 Jan 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4cKVDkm7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ZBfmmbF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9112E627;
	Thu, 18 Jan 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605842; cv=none; b=J1ed9oSSE+4ZI/4f62KYKvJ7FlmgrLaRluk1i33W3+bz5Mlp0G5y6C2tdBBPbwyXjxSeGpfDAKWP+tFZsqt+JHL1bmBhYGJ/uQivTeRYv9QycUEQXYB19FK4hiYA48dY8U/i0pwXPfU4n4lM/4st7NL1aLkBGiPEIWBKbqOn3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605842; c=relaxed/simple;
	bh=w0lm96EX1GWlkiRDkJnpiFGrGjx4p3varQv30XBBRxo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rQjPogRwmScVb1lBMSjC5ZClUpoCMCFRkNaBxw76lUsiBS4X8xOvWxYFw0/iEWneRwe1khUDWBq3HoGDg6hk2PD2UEMpRyTxW/kWZffBcOCLD+f7Cor5CYvMYJdN+N2rsXtL0kgc77JTojX4ZLMxt9mNeaxUccpo4Ma/c0G0H+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4cKVDkm7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ZBfmmbF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 19:23:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705605838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+GSrxSjx2jp9oVG18JQ4NxkjYNv6JcZvqq8fVZoPU4=;
	b=4cKVDkm7apslET2M4bnQESZ9P7XaIz6jCL9ii4amxbJXsdlN07ozJbt2XVzoh1szdkvVMK
	D61zvfs86hrOEtDxCaRQoMagqRA1qqCTnTtAJpIDVIlHoivcZaRPDXWE7/sucdI3+L7+CR
	GuUbuYABLbUvD8DhYl3DD+sbAQRk8Iow3cdrjAstWgCM5R3vWznYAwGhP5Xen5FdNYPxhN
	O40SVgxJZjerLfLDMtGMihfexMcI+pWB+eaAvPTnTvANwMPrW6sLdZ1Paq311T7Bn/M/XA
	BRyL63Z+YEJsCvIz39FLY+fBjmHOel09v6r9eAEsCilQgad63bBJBRhPrN0BrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705605838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+GSrxSjx2jp9oVG18JQ4NxkjYNv6JcZvqq8fVZoPU4=;
	b=5ZBfmmbFNTI7z9M3iKGfba9M69PzSJGY3n5+4XmxRBym+W3+gC6iDeBfF9wtVnJs7Sjm8c
	uHSkvty62/KxBrDw==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/cadence-ttc: Fix some
 kernel-doc warnings
Cc: Randy Dunlap <rdunlap@infradead.org>, Michal Simek <michal.simek@amd.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205230448.772-1-rdunlap@infradead.org>
References: <20231205230448.772-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170560583779.398.16956376117878926079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0515c73467fd550249ef83062e1d03d99c718b4f
Gitweb:        https://git.kernel.org/tip/0515c73467fd550249ef83062e1d03d99c718b4f
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 05 Dec 2023 15:04:48 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Dec 2023 15:37:11 +01:00

clocksource/drivers/cadence-ttc: Fix some kernel-doc warnings

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
Acked-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231205230448.772-1-rdunlap@infradead.org
---
 drivers/clocksource/timer-cadence-ttc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 32daaac..ca7a064 100644
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
@@ -134,7 +134,7 @@ static void ttc_set_interval(struct ttc_timer *timer,
  * @irq:	IRQ number of the Timer
  * @dev_id:	void pointer to the ttc_timer instance
  *
- * returns: Always IRQ_HANDLED - success
+ * Returns: Always IRQ_HANDLED - success
  **/
 static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
 {
@@ -151,8 +151,9 @@ static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
 
 /**
  * __ttc_clocksource_read - Reads the timer counter register
+ * @cs: &clocksource to read from
  *
- * returns: Current timer counter register value
+ * Returns: Current timer counter register value
  **/
 static u64 __ttc_clocksource_read(struct clocksource *cs)
 {
@@ -173,7 +174,7 @@ static u64 notrace ttc_sched_clock_read(void)
  * @cycles:	Timer interval ticks
  * @evt:	Address of clock event instance
  *
- * returns: Always 0 - success
+ * Returns: Always %0 - success
  **/
 static int ttc_set_next_event(unsigned long cycles,
 					struct clock_event_device *evt)
@@ -186,9 +187,12 @@ static int ttc_set_next_event(unsigned long cycles,
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
@@ -202,6 +206,12 @@ static int ttc_shutdown(struct clock_event_device *evt)
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

