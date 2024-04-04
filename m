Return-Path: <linux-kernel+bounces-132013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26405898EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C53290038
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CF133413;
	Thu,  4 Apr 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLX5xfo9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE02112D1FA;
	Thu,  4 Apr 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258010; cv=none; b=gJt/KXMFHRRkhL05Fh2m/MUSGrrOSfnrnOId0t/CkSKi3TNnL5K+s63QXFuMbCkZneLpnPDO8do2IJnUQb5UbsIIFkI+syiJ2wVvR422Sl6W2zH4dMCTAVouih5c0Cpf7RnX1DBiwbFwMGaprW5Y62jiNLDEMRHXrSy+/mWVFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258010; c=relaxed/simple;
	bh=ASOgen0Mpri82vcRR7Jkdi+CxzjQPTB2Og1Pn2zqEpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaYLHY3qXRvKdfVWPx9d6xDOaRP2BmgyAq8OjxEdPfB1xdp0pphZQ8Vv7rr03K3EnLcZyw2osbObal3SdbOIo54hjgZj9rhPlWOH+xqUd8iOvm+UvrGevtwhHfN1aPK0XU2fEwgRtkg7c5laqfsMU82NxNRNYI6iLuzcciP3EQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLX5xfo9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258009; x=1743794009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ASOgen0Mpri82vcRR7Jkdi+CxzjQPTB2Og1Pn2zqEpo=;
  b=CLX5xfo9aa+g8trmuRvWlyMfAd6u6clB8CDHazmnKFz+0zzzMyd8tN/H
   LDTXElO/qEQpJ8K3H1f3xiOjzP/KxNYlr3QTtUR8fAmaxjwKCZJkOyNv2
   SB52qvNgxUHyaDTsjiH43PQ5kD2qqk1P9frexThHXcLUBo+kvPq3MJYui
   q9IrT9M5US0FGFKBkzESKLhoBn80Dc2o83TDhwXlBOlTpfcmM+sOKz76U
   0dIHx1oKctCFv5nS+Hfh0PaAIlpb9VGJjuvlTNAh0h3EfNkogS2c66ABa
   F3VyPeJDDMs9NNJGyVmyw2oUaU3eUxRnrcyc6C6nW96TNQCP1yY2WFtTC
   g==;
X-CSE-ConnectionGUID: l9kr0PF5RxmNIOIpaLL7zg==
X-CSE-MsgGUID: +2PlK/hVSxit3h6717i3Yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18709368"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18709368"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937087025"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937087025"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 12:13:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7BAD23E5; Thu,  4 Apr 2024 22:13:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Subject: [PATCH v2 1/2] hwmon: (pwm-fan) Convert to use of_property_read_u32_array()
Date: Thu,  4 Apr 2024 22:11:38 +0300
Message-ID: <20240404191323.3547465-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240404191323.3547465-1-andriy.shevchenko@linux.intel.com>
References: <20240404191323.3547465-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory change to fulfill further conversion
the driver to be OF-independent. The independent code has
no analogue API that can read the value by index in the device
property array.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/pwm-fan.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index b67bc9e833c0..bf902610cd07 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -25,7 +25,6 @@ struct pwm_fan_tach {
 	int irq;
 	atomic_t pulses;
 	unsigned int rpm;
-	u8 pulses_per_revolution;
 };
 
 enum pwm_fan_enable_mode {
@@ -48,6 +47,7 @@ struct pwm_fan_ctx {
 
 	int tach_count;
 	struct pwm_fan_tach *tachs;
+	u32 *pulses_per_revolution;
 	ktime_t sample_start;
 	struct timer_list rpm_timer;
 
@@ -85,7 +85,7 @@ static void sample_timer(struct timer_list *t)
 			pulses = atomic_read(&tach->pulses);
 			atomic_sub(pulses, &tach->pulses);
 			tach->rpm = (unsigned int)(pulses * 1000 * 60) /
-				(tach->pulses_per_revolution * delta);
+				(ctx->pulses_per_revolution[i] * delta);
 		}
 
 		ctx->sample_start = ktime_get();
@@ -562,6 +562,20 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		if (!fan_channel_config)
 			return -ENOMEM;
 		ctx->fan_channel.config = fan_channel_config;
+
+		ctx->pulses_per_revolution = devm_kmalloc_array(dev,
+								ctx->tach_count,
+								sizeof(*ctx->pulses_per_revolution),
+								GFP_KERNEL);
+		if (!ctx->pulses_per_revolution)
+			return -ENOMEM;
+
+		/* Setup default pulses per revolution */
+		for (i = 0; i < ctx->tach_count; i++)
+			ctx->pulses_per_revolution[i] = 2;
+
+		of_property_read_u32_array(dev->of_node, "pulses-per-revolution",
+					   ctx->pulses_per_revolution, ctx->tach_count);
 	}
 
 	channels = devm_kcalloc(dev, channel_count + 1,
@@ -573,7 +587,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ctx->tach_count; i++) {
 		struct pwm_fan_tach *tach = &ctx->tachs[i];
-		u32 ppr = 2;
 
 		tach->irq = platform_get_irq(pdev, i);
 		if (tach->irq == -EPROBE_DEFER)
@@ -589,12 +602,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			}
 		}
 
-		of_property_read_u32_index(dev->of_node,
-					   "pulses-per-revolution",
-					   i,
-					   &ppr);
-		tach->pulses_per_revolution = ppr;
-		if (!tach->pulses_per_revolution) {
+		if (!ctx->pulses_per_revolution[i]) {
 			dev_err(dev, "pulses-per-revolution can't be zero.\n");
 			return -EINVAL;
 		}
@@ -602,7 +610,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		fan_channel_config[i] = HWMON_F_INPUT;
 
 		dev_dbg(dev, "tach%d: irq=%d, pulses_per_revolution=%d\n",
-			i, tach->irq, tach->pulses_per_revolution);
+			i, tach->irq, ctx->pulses_per_revolution[i]);
 	}
 
 	if (ctx->tach_count > 0) {
-- 
2.43.0.rc1.1.gbec44491f096


