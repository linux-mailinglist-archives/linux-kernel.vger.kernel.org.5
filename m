Return-Path: <linux-kernel+bounces-84169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE1486A34C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFE41F29D20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C259169;
	Tue, 27 Feb 2024 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bWN4bUbx"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226C58AD6;
	Tue, 27 Feb 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075110; cv=none; b=nZTTfR3NKMmlkp2EOyO0pwenb2BWkmHR5k3TfeH5pmGRbsn19TkCLJTi3FGMypL1cDVIXLlSMMfhrwjgUm8o0poEN0K42l+QcOSjQ776vSMhtJNcP2EqQiuG6LQDyZGOlkhDsWmRhmkWVOges4F6cozCLynLt8oqXxHbILdrKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075110; c=relaxed/simple;
	bh=K0vgAjnfcErbCu7m6JHbbTv9UfXX4hDel32dYe9/n8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR/PzLPI8JE0bYQ5ubJEEGiCcTfO20NuHfEJ/w1PhFFqQeA6pJKEyA6KsBHbou31TrNGUcO/i8mfNJqvROaUmN/PWO1FJsySE7llDI9g3s421/MHQEGHIrbUIFDc3mSSBonhvDJD4tYzL5dhtyDO6+7vYRQXWbyoK1hR35pKO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bWN4bUbx; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3ADAB2000A;
	Tue, 27 Feb 2024 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ne98OHwAyUwm2hh10Sfamw+t6hhfzU/DRAw12tQy0Q=;
	b=bWN4bUbxn8E58jmhBJvDFhMWOGIKUnWifyCGVySnO/qkNZvTcyidEFroJwgXPqWRmjlS5V
	B4kMYxGQgDGfrjlHRah7V9vj2VIao5yuXfawhi90Tfy3PuVsXSWdLjQDhi7Qj5h7qeM8Fl
	u+kKY1hRIjVLXaOvxHRW0VaOO8Mw3CKiPmuYRKZppX7mcf0cmUZmL3DvvpertxHmgLku8C
	o1WpHOA1LUS8H/kcKdP73A0K6N3hDLOQEXm1qYdRUh3pV+MSmfnzCr/pwHl5u2NZo5gCa3
	rRFMCce8S4mjAN96dRnoa3UOcN2vkYLAzh3QTQ4HhnAxrtxOgn+CcTFc08JGkg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] rtc: ds1511: rename pdata
Date: Wed, 28 Feb 2024 00:04:26 +0100
Message-ID: <20240227230431.1837717-11-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
References: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

pdata is not actually about patform_data, rename it to something local to
the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index c3b1376b731f..39efd432e8ea 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -59,7 +59,7 @@
 #define DS1511_WDS	0x01
 #define DS1511_RAM_MAX	0x100
 
-struct rtc_plat_data {
+struct ds1511_data {
 	struct rtc_device *rtc;
 	void __iomem *ioaddr;		/* virtual base address */
 	int irq;
@@ -180,10 +180,10 @@ static void ds1511_rtc_alarm_enable(unsigned int enabled)
 
 static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
+	struct ds1511_data *ds1511 = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pdata->lock, flags);
+	spin_lock_irqsave(&ds1511->lock, flags);
 	rtc_write(bin2bcd(alrm->time.tm_mday) & 0x3f, DS1511_AM4_DATE);
 	rtc_write(bin2bcd(alrm->time.tm_hour) & 0x3f, DS1511_AM3_HOUR);
 	rtc_write(bin2bcd(alrm->time.tm_min) & 0x7f, DS1511_AM2_MIN);
@@ -191,7 +191,7 @@ static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	ds1511_rtc_alarm_enable(alrm->enabled);
 
 	rtc_read(DS1511_CONTROL_A);	/* clear interrupts */
-	spin_unlock_irqrestore(&pdata->lock, flags);
+	spin_unlock_irqrestore(&ds1511->lock, flags);
 
 	return 0;
 }
@@ -210,29 +210,29 @@ static int ds1511_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static irqreturn_t ds1511_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct ds1511_data *ds1511 = platform_get_drvdata(pdev);
 	unsigned long events = 0;
 
-	spin_lock(&pdata->lock);
+	spin_lock(&ds1511->lock);
 	/*
 	 * read and clear interrupt
 	 */
 	if (rtc_read(DS1511_CONTROL_A) & DS1511_IRQF) {
 		events = RTC_IRQF | RTC_AF;
-		rtc_update_irq(pdata->rtc, 1, events);
+		rtc_update_irq(ds1511->rtc, 1, events);
 	}
-	spin_unlock(&pdata->lock);
+	spin_unlock(&ds1511->lock);
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int ds1511_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
+	struct ds1511_data *ds1511 = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pdata->lock, flags);
+	spin_lock_irqsave(&ds1511->lock, flags);
 	ds1511_rtc_alarm_enable(enabled);
-	spin_unlock_irqrestore(&pdata->lock, flags);
+	spin_unlock_irqrestore(&ds1511->lock, flags);
 
 	return 0;
 }
@@ -271,7 +271,7 @@ static int ds1511_nvram_write(void *priv, unsigned int pos, void *buf,
 
 static int ds1511_rtc_probe(struct platform_device *pdev)
 {
-	struct rtc_plat_data *pdata;
+	struct ds1511_data *ds1511;
 	int ret = 0;
 	struct nvmem_config ds1511_nvmem_cfg = {
 		.name = "ds1511_nvram",
@@ -283,15 +283,15 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 		.priv = &pdev->dev,
 	};
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
+	ds1511 = devm_kzalloc(&pdev->dev, sizeof(*ds1511), GFP_KERNEL);
+	if (!ds1511)
 		return -ENOMEM;
 
 	ds1511_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ds1511_base))
 		return PTR_ERR(ds1511_base);
-	pdata->ioaddr = ds1511_base;
-	pdata->irq = platform_get_irq(pdev, 0);
+	ds1511->ioaddr = ds1511_base;
+	ds1511->irq = platform_get_irq(pdev, 0);
 
 	/*
 	 * turn on the clock and the crystal, etc.
@@ -314,37 +314,37 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	if (rtc_read(DS1511_CONTROL_A) & DS1511_BLF1)
 		dev_warn(&pdev->dev, "voltage-low detected.\n");
 
-	spin_lock_init(&pdata->lock);
-	platform_set_drvdata(pdev, pdata);
+	spin_lock_init(&ds1511->lock);
+	platform_set_drvdata(pdev, ds1511);
 
-	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(pdata->rtc))
-		return PTR_ERR(pdata->rtc);
+	ds1511->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(ds1511->rtc))
+		return PTR_ERR(ds1511->rtc);
 
-	pdata->rtc->ops = &ds1511_rtc_ops;
+	ds1511->rtc->ops = &ds1511_rtc_ops;
 
 	/*
 	 * if the platform has an interrupt in mind for this device,
 	 * then by all means, set it
 	 */
-	if (pdata->irq > 0) {
+	if (ds1511->irq > 0) {
 		rtc_read(DS1511_CONTROL_A);
-		if (devm_request_irq(&pdev->dev, pdata->irq, ds1511_interrupt,
+		if (devm_request_irq(&pdev->dev, ds1511->irq, ds1511_interrupt,
 			IRQF_SHARED, pdev->name, pdev) < 0) {
 
 			dev_warn(&pdev->dev, "interrupt not available.\n");
-			pdata->irq = 0;
+			ds1511->irq = 0;
 		}
 	}
 
-	if (pdata->irq == 0)
-		clear_bit(RTC_FEATURE_ALARM, pdata->rtc->features);
+	if (ds1511->irq == 0)
+		clear_bit(RTC_FEATURE_ALARM, ds1511->rtc->features);
 
-	ret = devm_rtc_register_device(pdata->rtc);
+	ret = devm_rtc_register_device(ds1511->rtc);
 	if (ret)
 		return ret;
 
-	devm_rtc_nvmem_register(pdata->rtc, &ds1511_nvmem_cfg);
+	devm_rtc_nvmem_register(ds1511->rtc, &ds1511_nvmem_cfg);
 
 	return 0;
 }
-- 
2.43.0


