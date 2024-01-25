Return-Path: <linux-kernel+bounces-38387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C58B83BEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17CE28ABDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5551CD27;
	Thu, 25 Jan 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Oyo6mKg5"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF201CA8B;
	Thu, 25 Jan 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178364; cv=none; b=X8EEK87jY8011MCvgAQNxyFMYohVZVVTs4Dq6rZoB877bPz4Vz2P882Lq0b4Bu0/CFC/iPb9VzzdmlotTVpylSgve0wEkGGIoXocrgew/lKKTJPuhP6g2CgoAFh+B3UK67d93/vwVNdcXcPkeR2NXpEXxnQtLArCgWUHH9cKIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178364; c=relaxed/simple;
	bh=FhrQu4P7Pyl6ih2qG7uPBbK2EyAGBDkiGEBxb6FF2Rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0WiQ8oq1svikWRv9sINw6R0qRQ6gLK/Ps1u2lxGknzIAMscO3qy0H6vqN9N0RxrAoRuy30DYNliY7Sjbzn3A6igj7Qzv4t7QljIcfe/uOlkKmzyLKt5nYsMDZNOwuIizkTk5RMugmIbZuHHtGB7LwsO39uefjvRjN/2oCSuQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Oyo6mKg5; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5wLPj008959;
	Thu, 25 Jan 2024 04:25:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=d9674b95+6fyGE2L2nKtZskhha/Bhx67EejM1M1FwsU=; b=
	Oyo6mKg5fP9KoxpCnvB0XPEbBHfJ//GsZ95qpgHLW24nsa47R+gVLKAs00Y6ZhUl
	GKj5K67TVHLA6qE6k9yL+d80kF+Yz+XGA7g0S3bLXbUYoRi4K9HMB9AFQXuLNB+7
	wEni8m9tjEY3Jg63gD4Odv9hlmZ2YYLMY2onlaqWN2m078LQJYjfVOrc/UOqZu/j
	TOHyNnp+fvPcMaIzU4Kc6foeCdeYPw008d8ZRHQIqzr3+087olzzqC+mXJNgF9q5
	0l4PHwdAQ5muXxy7Nh9nggNqUv6SSlCQWWr5mYem9DKwIzaxwprX+Ig4kmxTG5Cd
	OqTgSjSVnwrNJRvba5k4UA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9t2gj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 04:25:57 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:25:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 10:25:55 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 77EC9820249;
	Thu, 25 Jan 2024 10:25:55 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 4/6] mfd: cs42l43: Add time postfixes on defines
Date: Thu, 25 Jan 2024 10:25:53 +0000
Message-ID: <20240125102555.2621736-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0nwn1clTtiwiEjDtc-rDNaR7d7MQtMje
X-Proofpoint-ORIG-GUID: 0nwn1clTtiwiEjDtc-rDNaR7d7MQtMje
X-Proofpoint-Spam-Reason: safe

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 drivers/mfd/cs42l43.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 65a331481d975..aea0f8f485785 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -27,30 +27,30 @@
 
 #include "cs42l43.h"
 
-#define CS42L43_RESET_DELAY			20
+#define CS42L43_RESET_DELAY_MS			20
 
-#define CS42L43_SDW_ATTACH_TIMEOUT		500
-#define CS42L43_SDW_DETACH_TIMEOUT		100
+#define CS42L43_SDW_ATTACH_TIMEOUT_MS		500
+#define CS42L43_SDW_DETACH_TIMEOUT_MS		100
 
 #define CS42L43_MCU_BOOT_STAGE1			1
 #define CS42L43_MCU_BOOT_STAGE2			2
 #define CS42L43_MCU_BOOT_STAGE3			3
 #define CS42L43_MCU_BOOT_STAGE4			4
-#define CS42L43_MCU_POLL			5000
-#define CS42L43_MCU_CMD_TIMEOUT			20000
+#define CS42L43_MCU_POLL_US			5000
+#define CS42L43_MCU_CMD_TIMEOUT_US		20000
 #define CS42L43_MCU_UPDATE_FORMAT		3
 #define CS42L43_MCU_UPDATE_OFFSET		0x100000
-#define CS42L43_MCU_UPDATE_TIMEOUT		500000
+#define CS42L43_MCU_UPDATE_TIMEOUT_US		500000
 #define CS42L43_MCU_UPDATE_RETRIES		5
 
 #define CS42L43_MCU_SUPPORTED_REV		0x2105
 #define CS42L43_MCU_SHADOW_REGS_REQUIRED_REV	0x2200
 #define CS42L43_MCU_SUPPORTED_BIOS_REV		0x0001
 
-#define CS42L43_VDDP_DELAY			50
-#define CS42L43_VDDD_DELAY			1000
+#define CS42L43_VDDP_DELAY_US			50
+#define CS42L43_VDDD_DELAY_US			1000
 
-#define CS42L43_AUTOSUSPEND_TIME		250
+#define CS42L43_AUTOSUSPEND_TIME_MS		250
 
 struct cs42l43_patch_header {
 	__le16 version;
@@ -538,10 +538,10 @@ static int cs42l43_soft_reset(struct cs42l43 *cs42l43)
 	regcache_cache_only(cs42l43->regmap, true);
 	regmap_multi_reg_write_bypassed(cs42l43->regmap, reset, ARRAY_SIZE(reset));
 
-	msleep(CS42L43_RESET_DELAY);
+	msleep(CS42L43_RESET_DELAY_MS);
 
 	if (cs42l43->sdw) {
-		unsigned long timeout = msecs_to_jiffies(CS42L43_SDW_DETACH_TIMEOUT);
+		unsigned long timeout = msecs_to_jiffies(CS42L43_SDW_DETACH_TIMEOUT_MS);
 		unsigned long time;
 
 		time = wait_for_completion_timeout(&cs42l43->device_detach, timeout);
@@ -561,7 +561,7 @@ static int cs42l43_soft_reset(struct cs42l43 *cs42l43)
 static int cs42l43_wait_for_attach(struct cs42l43 *cs42l43)
 {
 	if (!cs42l43->attached) {
-		unsigned long timeout = msecs_to_jiffies(CS42L43_SDW_ATTACH_TIMEOUT);
+		unsigned long timeout = msecs_to_jiffies(CS42L43_SDW_ATTACH_TIMEOUT_MS);
 		unsigned long time;
 
 		time = wait_for_completion_timeout(&cs42l43->device_attach, timeout);
@@ -603,7 +603,7 @@ static int cs42l43_mcu_stage_2_3(struct cs42l43 *cs42l43, bool shadow)
 
 	ret = regmap_read_poll_timeout(cs42l43->regmap, CS42L43_BOOT_STATUS,
 				       val, (val == CS42L43_MCU_BOOT_STAGE3),
-				       CS42L43_MCU_POLL, CS42L43_MCU_CMD_TIMEOUT);
+				       CS42L43_MCU_POLL_US, CS42L43_MCU_CMD_TIMEOUT_US);
 	if (ret) {
 		dev_err(cs42l43->dev, "Failed to move to stage 3: %d, 0x%x\n", ret, val);
 		return ret;
@@ -652,7 +652,7 @@ static int cs42l43_mcu_disable(struct cs42l43 *cs42l43)
 
 	ret = regmap_read_poll_timeout(cs42l43->regmap, CS42L43_SOFT_INT_SHADOW, val,
 				       (val & CS42L43_CONTROL_APPLIED_INT_MASK),
-				       CS42L43_MCU_POLL, CS42L43_MCU_CMD_TIMEOUT);
+				       CS42L43_MCU_POLL_US, CS42L43_MCU_CMD_TIMEOUT_US);
 	if (ret) {
 		dev_err(cs42l43->dev, "Failed to disable firmware: %d, 0x%x\n", ret, val);
 		return ret;
@@ -696,7 +696,7 @@ static void cs42l43_mcu_load_firmware(const struct firmware *firmware, void *con
 
 	ret = regmap_read_poll_timeout(cs42l43->regmap, CS42L43_SOFT_INT_SHADOW, val,
 				       (val & CS42L43_PATCH_APPLIED_INT_MASK),
-				       CS42L43_MCU_POLL, CS42L43_MCU_UPDATE_TIMEOUT);
+				       CS42L43_MCU_POLL_US, CS42L43_MCU_UPDATE_TIMEOUT_US);
 	if (ret) {
 		dev_err(cs42l43->dev, "Failed to update firmware: %d, 0x%x\n", ret, val);
 		cs42l43->firmware_error = ret;
@@ -957,7 +957,7 @@ static int cs42l43_power_up(struct cs42l43 *cs42l43)
 	}
 
 	/* vdd-p must be on for 50uS before any other supply */
-	usleep_range(CS42L43_VDDP_DELAY, 2 * CS42L43_VDDP_DELAY);
+	usleep_range(CS42L43_VDDP_DELAY_US, 2 * CS42L43_VDDP_DELAY_US);
 
 	gpiod_set_value_cansleep(cs42l43->reset, 1);
 
@@ -973,7 +973,7 @@ static int cs42l43_power_up(struct cs42l43 *cs42l43)
 		goto err_core_supplies;
 	}
 
-	usleep_range(CS42L43_VDDD_DELAY, 2 * CS42L43_VDDD_DELAY);
+	usleep_range(CS42L43_VDDD_DELAY_US, 2 * CS42L43_VDDD_DELAY_US);
 
 	return 0;
 
@@ -1057,7 +1057,7 @@ int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 	if (ret)
 		return ret;
 
-	pm_runtime_set_autosuspend_delay(cs42l43->dev, CS42L43_AUTOSUSPEND_TIME);
+	pm_runtime_set_autosuspend_delay(cs42l43->dev, CS42L43_AUTOSUSPEND_TIME_MS);
 	pm_runtime_use_autosuspend(cs42l43->dev);
 	pm_runtime_set_active(cs42l43->dev);
 	/*
-- 
2.30.2


