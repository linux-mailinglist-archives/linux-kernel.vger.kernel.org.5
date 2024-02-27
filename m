Return-Path: <linux-kernel+bounces-84162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361CE86A340
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5451F296F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D08B57860;
	Tue, 27 Feb 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hNuuAFs9"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570E5646D;
	Tue, 27 Feb 2024 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075092; cv=none; b=PaDbsaGCcJsgB7Q3u1jmiTk+ZQC3SDwh1gEx9EMaMCdSW+L5WOhxX3EJ9U39o8NeUoIG+lrQ5av/o+aCHMOTJkCA80SKbB8SelGfQpifb1CFIaUQ/krvqaUU1Y9pMySMx4IeuciTMI4Qa8i1awUkDU0k9xEZ4Inu5HDLi/he8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075092; c=relaxed/simple;
	bh=OnaJ0bhlsJb9TTJ9KBQYFAZJtWS0+hnIyvEiq6oHctQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjcDiiHBLfHS7/rwmbtPU8JI6H1Y8YxOQ/z+0uixY/+JMsmA0xFL3rD77OEOm3o5tbv9Z3CHKs/Ric+j816Nc6KNiEn20zAh7OOyAiFXf+AoNXztbHmkUDrd62G3peF6xHTlv7PyqZ7udFKtWxVYXRbIps5rn95QyJlwyWNbX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hNuuAFs9; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 082C7E0003;
	Tue, 27 Feb 2024 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVr8YT/Fo2A2GRND8aVlOgxS5f57ar95qX8+fgS4eJ0=;
	b=hNuuAFs9jSGGWtluSIKTiEluNX2eQiHq2pQfhbkMqsoWtfOvYyWovHLqgXLzdd7GeRCzMy
	XmNBivgp0qBLLMjW4hAuZ01sXbNMjxOTlH+VZzz/CNc5GHLPYteEEITKo3TDH0RTK5+Qih
	yI/PaAw6g+VUKih/Yc5tuPBODIaKU+juGTMX7BSCH8GXsLUBOHeNDT6bZ+lfR5MfgPhzFj
	BYiKQXKchBRgj8gDZX3e7IZbzunkYWavPiMS9JIKA/vcpy+3AB/TzpwIJPMKpUuUL2iGAI
	ziHyha6wnmLH0C3j19gEAttlSQyXYbBPTz64suYQp10a9gSw5KxMJ/WeXpRnHQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] rtc: ds1511: drop useless enum
Date: Wed, 28 Feb 2024 00:04:19 +0100
Message-ID: <20240227230431.1837717-4-alexandre.belloni@bootlin.com>
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

Use regular defines for register offsets instead of the enum that doesn't
bring any benefit.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 120 ++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 71 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index fe8dbad51c88..8e57c1395cf3 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -22,26 +22,24 @@
 #include <linux/io.h>
 #include <linux/module.h>
 
-enum ds1511reg {
-	DS1511_SEC = 0x0,
-	DS1511_MIN = 0x1,
-	DS1511_HOUR = 0x2,
-	DS1511_DOW = 0x3,
-	DS1511_DOM = 0x4,
-	DS1511_MONTH = 0x5,
-	DS1511_YEAR = 0x6,
-	DS1511_CENTURY = 0x7,
-	DS1511_AM1_SEC = 0x8,
-	DS1511_AM2_MIN = 0x9,
-	DS1511_AM3_HOUR = 0xa,
-	DS1511_AM4_DATE = 0xb,
-	DS1511_WD_MSEC = 0xc,
-	DS1511_WD_SEC = 0xd,
-	DS1511_CONTROL_A = 0xe,
-	DS1511_CONTROL_B = 0xf,
-	DS1511_RAMADDR_LSB = 0x10,
-	DS1511_RAMDATA = 0x13
-};
+#define DS1511_SEC		0x0
+#define DS1511_MIN		0x1
+#define DS1511_HOUR		0x2
+#define DS1511_DOW		0x3
+#define DS1511_DOM		0x4
+#define DS1511_MONTH		0x5
+#define DS1511_YEAR		0x6
+#define DS1511_CENTURY		0x7
+#define DS1511_AM1_SEC		0x8
+#define DS1511_AM2_MIN		0x9
+#define DS1511_AM3_HOUR		0xa
+#define DS1511_AM4_DATE		0xb
+#define DS1511_WD_MSEC		0xc
+#define DS1511_WD_SEC		0xd
+#define DS1511_CONTROL_A	0xe
+#define DS1511_CONTROL_B	0xf
+#define DS1511_RAMADDR_LSB	0x10
+#define DS1511_RAMDATA		0x13
 
 #define DS1511_BLF1	0x80
 #define DS1511_BLF2	0x40
@@ -61,26 +59,6 @@ enum ds1511reg {
 #define DS1511_WDS	0x01
 #define DS1511_RAM_MAX	0x100
 
-#define RTC_CMD		DS1511_CONTROL_B
-#define RTC_CMD1	DS1511_CONTROL_A
-
-#define RTC_ALARM_SEC	DS1511_AM1_SEC
-#define RTC_ALARM_MIN	DS1511_AM2_MIN
-#define RTC_ALARM_HOUR	DS1511_AM3_HOUR
-#define RTC_ALARM_DATE	DS1511_AM4_DATE
-
-#define RTC_SEC		DS1511_SEC
-#define RTC_MIN		DS1511_MIN
-#define RTC_HOUR	DS1511_HOUR
-#define RTC_DOW		DS1511_DOW
-#define RTC_DOM		DS1511_DOM
-#define RTC_MON		DS1511_MONTH
-#define RTC_YEAR	DS1511_YEAR
-#define RTC_CENTURY	DS1511_CENTURY
-
-#define RTC_TIE	DS1511_TIE
-#define RTC_TE	DS1511_TE
-
 struct rtc_plat_data {
 	struct rtc_device *rtc;
 	void __iomem *ioaddr;		/* virtual base address */
@@ -105,7 +83,7 @@ rtc_write(uint8_t val, uint32_t reg)
 }
 
 static noinline uint8_t
-rtc_read(enum ds1511reg reg)
+rtc_read(uint32_t reg)
 {
 	return readb(ds1511_base + (reg * reg_spacing));
 }
@@ -113,13 +91,13 @@ rtc_read(enum ds1511reg reg)
 static inline void
 rtc_disable_update(void)
 {
-	rtc_write((rtc_read(RTC_CMD) & ~RTC_TE), RTC_CMD);
+	rtc_write((rtc_read(DS1511_CONTROL_B) & ~DS1511_TE), DS1511_CONTROL_B);
 }
 
 static void
 rtc_enable_update(void)
 {
-	rtc_write((rtc_read(RTC_CMD) | RTC_TE), RTC_CMD);
+	rtc_write((rtc_read(DS1511_CONTROL_B) | DS1511_TE), DS1511_CONTROL_B);
 }
 
 static int ds1511_rtc_set_time(struct device *dev, struct rtc_time *rtc_tm)
@@ -149,14 +127,14 @@ static int ds1511_rtc_set_time(struct device *dev, struct rtc_time *rtc_tm)
 
 	spin_lock_irqsave(&ds1511_lock, flags);
 	rtc_disable_update();
-	rtc_write(cen, RTC_CENTURY);
-	rtc_write(yrs, RTC_YEAR);
-	rtc_write((rtc_read(RTC_MON) & 0xe0) | mon, RTC_MON);
-	rtc_write(day, RTC_DOM);
-	rtc_write(hrs, RTC_HOUR);
-	rtc_write(min, RTC_MIN);
-	rtc_write(sec, RTC_SEC);
-	rtc_write(dow, RTC_DOW);
+	rtc_write(cen, DS1511_CENTURY);
+	rtc_write(yrs, DS1511_YEAR);
+	rtc_write((rtc_read(DS1511_MONTH) & 0xe0) | mon, DS1511_MONTH);
+	rtc_write(day, DS1511_DOM);
+	rtc_write(hrs, DS1511_HOUR);
+	rtc_write(min, DS1511_MIN);
+	rtc_write(sec, DS1511_SEC);
+	rtc_write(dow, DS1511_DOW);
 	rtc_enable_update();
 	spin_unlock_irqrestore(&ds1511_lock, flags);
 
@@ -171,14 +149,14 @@ static int ds1511_rtc_read_time(struct device *dev, struct rtc_time *rtc_tm)
 	spin_lock_irqsave(&ds1511_lock, flags);
 	rtc_disable_update();
 
-	rtc_tm->tm_sec = rtc_read(RTC_SEC) & 0x7f;
-	rtc_tm->tm_min = rtc_read(RTC_MIN) & 0x7f;
-	rtc_tm->tm_hour = rtc_read(RTC_HOUR) & 0x3f;
-	rtc_tm->tm_mday = rtc_read(RTC_DOM) & 0x3f;
-	rtc_tm->tm_wday = rtc_read(RTC_DOW) & 0x7;
-	rtc_tm->tm_mon = rtc_read(RTC_MON) & 0x1f;
-	rtc_tm->tm_year = rtc_read(RTC_YEAR) & 0x7f;
-	century = rtc_read(RTC_CENTURY);
+	rtc_tm->tm_sec = rtc_read(DS1511_SEC) & 0x7f;
+	rtc_tm->tm_min = rtc_read(DS1511_MIN) & 0x7f;
+	rtc_tm->tm_hour = rtc_read(DS1511_HOUR) & 0x3f;
+	rtc_tm->tm_mday = rtc_read(DS1511_DOM) & 0x3f;
+	rtc_tm->tm_wday = rtc_read(DS1511_DOW) & 0x7;
+	rtc_tm->tm_mon = rtc_read(DS1511_MONTH) & 0x1f;
+	rtc_tm->tm_year = rtc_read(DS1511_YEAR) & 0x7f;
+	century = rtc_read(DS1511_CENTURY);
 
 	rtc_enable_update();
 	spin_unlock_irqrestore(&ds1511_lock, flags);
@@ -220,18 +198,18 @@ ds1511_rtc_update_alarm(struct rtc_plat_data *pdata)
 	spin_lock_irqsave(&pdata->lock, flags);
 	rtc_write(pdata->alrm_mday < 0 || (pdata->irqen & RTC_UF) ?
 	       0x80 : bin2bcd(pdata->alrm_mday) & 0x3f,
-	       RTC_ALARM_DATE);
+	       DS1511_AM4_DATE);
 	rtc_write(pdata->alrm_hour < 0 || (pdata->irqen & RTC_UF) ?
 	       0x80 : bin2bcd(pdata->alrm_hour) & 0x3f,
-	       RTC_ALARM_HOUR);
+	       DS1511_AM3_HOUR);
 	rtc_write(pdata->alrm_min < 0 || (pdata->irqen & RTC_UF) ?
 	       0x80 : bin2bcd(pdata->alrm_min) & 0x7f,
-	       RTC_ALARM_MIN);
+	       DS1511_AM2_MIN);
 	rtc_write(pdata->alrm_sec < 0 || (pdata->irqen & RTC_UF) ?
 	       0x80 : bin2bcd(pdata->alrm_sec) & 0x7f,
-	       RTC_ALARM_SEC);
-	rtc_write(rtc_read(RTC_CMD) | (pdata->irqen ? RTC_TIE : 0), RTC_CMD);
-	rtc_read(RTC_CMD1);	/* clear interrupts */
+	       DS1511_AM1_SEC);
+	rtc_write(rtc_read(DS1511_CONTROL_B) | (pdata->irqen ? DS1511_TIE : 0), DS1511_CONTROL_B);
+	rtc_read(DS1511_CONTROL_A);	/* clear interrupts */
 	spin_unlock_irqrestore(&pdata->lock, flags);
 }
 
@@ -281,9 +259,9 @@ ds1511_interrupt(int irq, void *dev_id)
 	/*
 	 * read and clear interrupt
 	 */
-	if (rtc_read(RTC_CMD1) & DS1511_IRQF) {
+	if (rtc_read(DS1511_CONTROL_A) & DS1511_IRQF) {
 		events = RTC_IRQF;
-		if (rtc_read(RTC_ALARM_SEC) & 0x80)
+		if (rtc_read(DS1511_AM1_SEC) & 0x80)
 			events |= RTC_UF;
 		else
 			events |= RTC_AF;
@@ -366,8 +344,8 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	/*
 	 * turn on the clock and the crystal, etc.
 	 */
-	rtc_write(DS1511_BME, RTC_CMD);
-	rtc_write(0, RTC_CMD1);
+	rtc_write(DS1511_BME, DS1511_CONTROL_B);
+	rtc_write(0, DS1511_CONTROL_A);
 	/*
 	 * clear the wdog counter
 	 */
@@ -381,7 +359,7 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	/*
 	 * check for a dying bat-tree
 	 */
-	if (rtc_read(RTC_CMD1) & DS1511_BLF1)
+	if (rtc_read(DS1511_CONTROL_A) & DS1511_BLF1)
 		dev_warn(&pdev->dev, "voltage-low detected.\n");
 
 	spin_lock_init(&pdata->lock);
@@ -404,7 +382,7 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	 * then by all means, set it
 	 */
 	if (pdata->irq > 0) {
-		rtc_read(RTC_CMD1);
+		rtc_read(DS1511_CONTROL_A);
 		if (devm_request_irq(&pdev->dev, pdata->irq, ds1511_interrupt,
 			IRQF_SHARED, pdev->name, pdev) < 0) {
 
-- 
2.43.0


