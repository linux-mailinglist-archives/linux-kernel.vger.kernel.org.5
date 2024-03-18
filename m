Return-Path: <linux-kernel+bounces-105951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B687E6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E1B1C2174E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A73381D4;
	Mon, 18 Mar 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCSxkDH5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHHUIEed"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE4364A4;
	Mon, 18 Mar 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756463; cv=none; b=l/sUvKl7A0/iEE5cY0yh25gnSE71qyVq4f+18+fIBGbbRjR8dFQ7tfOrknTzVyprP3+Dg2IKCk75iHfOqqpG0/cCzRkbyZxwpJZgjOuKc7m3PEG5HU1WU4Uo0tjoP1am1ScyT67GEhYmGG5F2h1RWgF8lv5i4uVOQmvYMA300U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756463; c=relaxed/simple;
	bh=b+pgNnj70RpvE//UvPIq4xs6f6RU1izGDX54Y9K2buM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jF9fUQkspmrBdEdI7aB/5gDM9ZfffdDON9Qut09+/WWYZ6CtuftukF6Mr/TSJE5hezG6woDVTbe6ticpUP0nUI0lAFau8OKggqmO9GBgvLphrtiO8a3NQW1A+0dTkcrrqH1f2DpsuMyvG9pFIhd53QY+N+mR58LgVtakiHIKiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCSxkDH5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHHUIEed; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJr6TJnTslm05NC6oF29JNHe1WqoWDcIEXWhNQadceI=;
	b=rCSxkDH5jghQ/NfKHyl5l3Htin86q8PBu9VAxXjEPMBm1JAy+KvKyYdO73GXKleeMN5HUy
	8ev6vKxkTSNAtv/VHwuuAJDEdgI039scA2uJBQQpHkvMM9qHj5eUIrRmkdAlbZUmVZTRVt
	vNGkp1okCVxhqcAS8cASl4GLb348u+KpDktc52RZAgNj5yAjzWpT7iznTF86vhKf+FHGU9
	Jb43aERHqZ3qY2VWGFA8IjldJG3Goog8ogwFJKN1Z5cNnNTUlGUb+p1YPwToZJInvoJuHC
	BR4NOOv9bI6mrWUTQRI3YSPYQwhJ/RoDmdWJLClD7BB+Uk3rIumOGtF81FMIbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJr6TJnTslm05NC6oF29JNHe1WqoWDcIEXWhNQadceI=;
	b=cHHUIEed/9W1tPUn/L1TAHJ6/H2QeAsBG7/9XMX9UEPXnWpnssoFQQmiCls4dDA8piyjnG
	4it3kwe0k3JKKABw==
From: "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-sysctr: Add i.MX95 support
Cc: Peng Fan <peng.fan@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240205-imx-sysctr-v4-3-ca5a6e1552e7@nxp.com>
References: <20240205-imx-sysctr-v4-3-ca5a6e1552e7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645932.12214.15517113823166229117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b67686e971b06eee1be363b89863bd1217f65190
Gitweb:        https://git.kernel.org/tip/b67686e971b06eee1be363b89863bd1217f65190
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Mon, 05 Feb 2024 11:17:59 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 18 Feb 2024 10:45:36 +01:00

clocksource/drivers/imx-sysctr: Add i.MX95 support

To i.MX95 System counter module, we use Read register space to get
the counter, not the Control register space to get the counter, because
System Manager firmware not allow Linux to read Control register space,
so add a new TIMER_OF_DECLARE entry for i.MX95.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240205-imx-sysctr-v4-3-ca5a6e1552e7@nxp.com
---
 drivers/clocksource/timer-imx-sysctr.c | 53 +++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index c075ea8..4452581 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -9,12 +9,15 @@
 #include "timer-of.h"
 
 #define CMP_OFFSET	0x10000
+#define RD_OFFSET	0x20000
 
 #define CNTCV_LO	0x8
 #define CNTCV_HI	0xc
 #define CMPCV_LO	(CMP_OFFSET + 0x20)
 #define CMPCV_HI	(CMP_OFFSET + 0x24)
 #define CMPCR		(CMP_OFFSET + 0x2c)
+#define CNTCV_LO_IMX95	(RD_OFFSET + 0x8)
+#define CNTCV_HI_IMX95	(RD_OFFSET + 0xc)
 
 #define SYS_CTR_EN		0x1
 #define SYS_CTR_IRQ_MASK	0x2
@@ -23,6 +26,8 @@
 
 struct sysctr_private {
 	u32 cmpcr;
+	u32 lo_off;
+	u32 hi_off;
 };
 
 static void sysctr_timer_enable(struct clock_event_device *evt, bool enable)
@@ -47,13 +52,14 @@ static void sysctr_irq_acknowledge(struct clock_event_device *evt)
 static inline u64 sysctr_read_counter(struct clock_event_device *evt)
 {
 	struct timer_of *to = to_timer_of(evt);
+	struct sysctr_private *priv = to->private_data;
 	void __iomem *base = timer_of_base(to);
 	u32 cnt_hi, tmp_hi, cnt_lo;
 
 	do {
-		cnt_hi = readl_relaxed(base + CNTCV_HI);
-		cnt_lo = readl_relaxed(base + CNTCV_LO);
-		tmp_hi = readl_relaxed(base + CNTCV_HI);
+		cnt_hi = readl_relaxed(base + priv->hi_off);
+		cnt_lo = readl_relaxed(base + priv->lo_off);
+		tmp_hi = readl_relaxed(base + priv->hi_off);
 	} while (tmp_hi != cnt_hi);
 
 	return  ((u64) cnt_hi << 32) | cnt_lo;
@@ -127,7 +133,7 @@ static struct timer_of to_sysctr = {
 	},
 };
 
-static int __init sysctr_timer_init(struct device_node *np)
+static int __init __sysctr_timer_init(struct device_node *np)
 {
 	struct sysctr_private *priv;
 	void __iomem *base;
@@ -154,9 +160,48 @@ static int __init sysctr_timer_init(struct device_node *np)
 	base = timer_of_base(&to_sysctr);
 	priv->cmpcr = readl(base + CMPCR) & ~SYS_CTR_EN;
 
+	return 0;
+}
+
+static int __init sysctr_timer_init(struct device_node *np)
+{
+	struct sysctr_private *priv;
+	int ret;
+
+	ret = __sysctr_timer_init(np);
+	if (ret)
+		return ret;
+
+	priv = to_sysctr.private_data;
+	priv->lo_off = CNTCV_LO;
+	priv->hi_off = CNTCV_HI;
+
 	clockevents_config_and_register(&to_sysctr.clkevt,
 					timer_of_rate(&to_sysctr),
 					0xff, 0x7fffffff);
+
 	return 0;
 }
+
+static int __init sysctr_timer_imx95_init(struct device_node *np)
+{
+	struct sysctr_private *priv;
+	int ret;
+
+	ret = __sysctr_timer_init(np);
+	if (ret)
+		return ret;
+
+	priv = to_sysctr.private_data;
+	priv->lo_off = CNTCV_LO_IMX95;
+	priv->hi_off = CNTCV_HI_IMX95;
+
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
+
+	return 0;
+}
+
 TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
+TIMER_OF_DECLARE(sysctr_timer_imx95, "nxp,imx95-sysctr-timer", sysctr_timer_imx95_init);

