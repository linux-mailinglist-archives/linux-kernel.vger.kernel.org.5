Return-Path: <linux-kernel+bounces-105943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5768D87E6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9581F22878
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D42E645;
	Mon, 18 Mar 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCO/JBH6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mn/DtPI5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC372D04A;
	Mon, 18 Mar 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756459; cv=none; b=qbnTPRD9poNPUOO24cfFlstWjh6vDE0emC+EAVxXI+bTm+6BmclfP/SPoRD4SZGUAa/keuN+92Zpj4d6PPGeTZgmcDGnls97ZK2yrCiKT8DfjsGbtv5p2IWuHpjrof0Cbh6Y2mgrcHHgpPMw0Stut1BzgVziRQl+P4x6VbExb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756459; c=relaxed/simple;
	bh=p8QchDkrseZzJJKNMEN4cYwHNDsUuXZfZ9qjfKA2EqU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HrwUr9JbMFwZOWYLIH28PooA/tCLw+ai5f3XdgHDJUOmVX1Z/JvzEq9cIhP25JXHFrVJ1qpjedmGHdRut7nGdkpwQNOw1Hy2Zg/bXShuBCa1Cg7HLd2lWxtrHrBa85wTyRgsFlWDfo9Z9dprArcKMi2BadSHX+Le9eAYO32jpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCO/JBH6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mn/DtPI5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBFTPzFR96Qo6dMOR36BoPNNbUGe+gKYrBYChFwd974=;
	b=CCO/JBH6Md2VnXBJWjeBI0WjomMu3Psn+8YmSdnx3QpWrncAqx20/ftSpOMXEa5Xxr/Dz0
	fa5xJC3w5+MgwRFKuS1nsCp50aizvaaTfL9zPgS+AhZ+NZasDTWDIGE1wGLqgVyBILog8/
	MrmxaAVLwlUbj5aF2EwpIuY1hyqIco9c/FhgmHnOHvXCtH3SeDnx62F4OHSTk4kv7b1u9y
	bBshhBdajvrI5v08ID5f/OFj3+rcoZEqYJ/V4QVQre6XKxKnnt4zP1Yo4iA/Eh0uJjRenH
	GvjbDoxMS4krgyXOdOqvcWIsvuzplsb/l/e/FHtFRTaS4/8XVPLhfxpBihauyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBFTPzFR96Qo6dMOR36BoPNNbUGe+gKYrBYChFwd974=;
	b=mn/DtPI5IQ1el4P7z9HXxtuMClh82vqwHtXCdjouK66vWA0JIgftup6nhdZ89wm3XvF3TL
	X3nDkkJi7t4H/4DA==
From: "tip-bot2 for Martin Blumenstingl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Simplify
 prescaler register access
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225151336.2728533-4-martin.blumenstingl@googlemail.com>
References: <20240225151336.2728533-4-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645458.12214.3233394183212196975.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     755350bcfb4ac8cbbb62bd7ee6be8271d4b2a88a
Gitweb:        https://git.kernel.org/tip/755350bcfb4ac8cbbb62bd7ee6be8271d4b2a88a
Author:        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
AuthorDate:    Sun, 25 Feb 2024 16:13:36 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 26 Feb 2024 10:07:25 +01:00

clocksource/drivers/arm_global_timer: Simplify prescaler register access

Use GENMASK() to define the prescaler mask and make the whole driver use
the mask (together with helpers such as FIELD_{GET,PREP,FIT}) instead of
needing an additional shift and max value constant.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240225151336.2728533-4-martin.blumenstingl@googlemail.com
---
 drivers/clocksource/arm_global_timer.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 4726a15..ab1c8c2 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -9,6 +9,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/bitfield.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -31,10 +32,7 @@
 #define GT_CONTROL_COMP_ENABLE		BIT(1)	/* banked */
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
-#define GT_CONTROL_PRESCALER_SHIFT      8
-#define GT_CONTROL_PRESCALER_MAX        0xFF
-#define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
-					 GT_CONTROL_PRESCALER_SHIFT)
+#define GT_CONTROL_PRESCALER_MASK	GENMASK(15, 8)
 
 #define GT_INT_STATUS	0x0c
 #define GT_INT_STATUS_EVENT_FLAG	BIT(0)
@@ -248,7 +246,7 @@ static void gt_write_presc(u32 psv)
 
 	reg = readl(gt_base + GT_CONTROL);
 	reg &= ~GT_CONTROL_PRESCALER_MASK;
-	reg |= psv << GT_CONTROL_PRESCALER_SHIFT;
+	reg |= FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv);
 	writel(reg, gt_base + GT_CONTROL);
 }
 
@@ -257,8 +255,7 @@ static u32 gt_read_presc(void)
 	u32 reg;
 
 	reg = readl(gt_base + GT_CONTROL);
-	reg &= GT_CONTROL_PRESCALER_MASK;
-	return reg >> GT_CONTROL_PRESCALER_SHIFT;
+	return FIELD_GET(GT_CONTROL_PRESCALER_MASK, reg);
 }
 
 static void __init gt_delay_timer_init(void)
@@ -273,9 +270,9 @@ static int __init gt_clocksource_init(void)
 	writel(0, gt_base + GT_COUNTER0);
 	writel(0, gt_base + GT_COUNTER1);
 	/* set prescaler and enable timer on all the cores */
-	writel(((CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) <<
-		GT_CONTROL_PRESCALER_SHIFT)
-	       | GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
+	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK,
+			  CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) |
+	       GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	sched_clock_register(gt_sched_clock_read, 64, gt_target_rate);
@@ -301,7 +298,7 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
 		psv--;
 
 		/* prescaler within legal range? */
-		if (psv > GT_CONTROL_PRESCALER_MAX)
+		if (!FIELD_FIT(GT_CONTROL_PRESCALER_MASK, psv))
 			return NOTIFY_BAD;
 
 		/*

