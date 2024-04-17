Return-Path: <linux-kernel+bounces-148431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F138A8275
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764481C216B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1A513FD9D;
	Wed, 17 Apr 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="uk0i1AWM";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="dCd3D8pg"
Received: from c180-41.smtp-out.ap-south-1.amazonses.com (c180-41.smtp-out.ap-south-1.amazonses.com [76.223.180.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30913D26C;
	Wed, 17 Apr 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354602; cv=none; b=QSj/P4kBYv6DxCNDOZUbiIiULo3Fs5uEe7k5+tLc1RohyB+mshnH2VZhXpFguU6fRl62xWTPb3AqfBMnIF8kKnD2yHS0XUmOSFyzI3barLDaH1LTvCtUIfQcrkTTFZVxca3NJHlZZ0Po35FYNYSUqZis9zKkb+3G64pnr4es5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354602; c=relaxed/simple;
	bh=iFYczu1Wr+uRIXgLgGIxVu11RyoBjz1N8NcMbmiHQVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldtapCORheQyEgIjz4fy4eBpJ4W9aygXdbqKBq+7mHAT0mHpwZ+HWiP6vuH/tTwJU3NCKH6JlwfGFIQ6jWgDrqvb0JvzHquRR5HhJ/iaTEtSK0x8WX7yTcrBmFyWUJjis9s4nLk2CBuCO/LemXNZ0w4sEh8aCN22oLkaMzHxAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=uk0i1AWM; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=dCd3D8pg; arc=none smtp.client-ip=76.223.180.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713354598;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iFYczu1Wr+uRIXgLgGIxVu11RyoBjz1N8NcMbmiHQVA=;
	b=uk0i1AWMjyg1vgaUDPpmip2SXOZMBZ2+ld50Tvm7IaQVNBG0zRQhcYOal2S6jSv0
	5P4lL9gF0I/lZAA/IsFWiUhiY/dhFGVRaXLVfIB+XS4xlnYB/LZ+YbuEwQXAiO6qdGj
	C5B3laUCxvA1H5554jdDEy4Lf20WnTjfJAMZArehoG54RLEljVYxCTGpfeesUgfbP2S
	o372cdDBeSGVzjqUmxQU98IU/lhIuXIejjLGgVqrDN3YIr+bimgsIDrdrkFwGBVXGaq
	wPT/ySUiPS1WPIradVmngPoDOnaXI1xoqCqHIaHMRdZJjyClZQoHUheJhz0qs39Kfj/
	j8pDTvXUHg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713354598;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=iFYczu1Wr+uRIXgLgGIxVu11RyoBjz1N8NcMbmiHQVA=;
	b=dCd3D8pg0FplHYNU++ikip+MWgS/QDoeFccivJ+v2SPx44I8ZbSfurC0HeLrSdXA
	t1C560U695Rxl2DmB0QVuBOspAF7hEMUzlOJDInLvnCiQ1gMJNUTLAS7dygUokrO7p+
	DvWdQdufV0g2W9ZWtNoBE+xezDmbrd82brwRS4Zg=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org, 
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, 
	kristo@kernel.org, eblanc@baylibre.com, 
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v7 07/10] misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
Date: Wed, 17 Apr 2024 11:49:58 +0000
Message-ID: <0109018eebe4668d-ad6750f9-b036-4be6-9b45-f0cc2109144b-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417114934.186248-1-bhargav.r@ltts.com>
References: <20240417114934.186248-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.41

Add support for TPS65224 PFSM in the TPS6594 PFSM driver as they share
significant functionality.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/tps6594-pfsm.c | 48 +++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 88dcac814..9bcca1856 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * PFSM (Pre-configurable Finite State Machine) driver for TI TPS6594/TPS6593/LP8764 PMICs
+ * PFSM (Pre-configurable Finite State Machine) driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
  *
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
@@ -39,10 +39,12 @@
  *
  * @miscdev: misc device infos
  * @regmap:  regmap for accessing the device registers
+ * @chip_id: chip identifier of the device
  */
 struct tps6594_pfsm {
 	struct miscdevice miscdev;
 	struct regmap *regmap;
+	unsigned long chip_id;
 };
 
 static ssize_t tps6594_pfsm_read(struct file *f, char __user *buf,
@@ -133,21 +135,29 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
 	struct pmic_state_opt state_opt;
 	void __user *argp = (void __user *)arg;
+	unsigned int regmap_reg, mask;
 	int ret = -ENOIOCTLCMD;
 
 	switch (cmd) {
 	case PMIC_GOTO_STANDBY:
-		/* Disable LP mode */
-		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
-					TPS6594_BIT_LP_STANDBY_SEL);
-		if (ret)
-			return ret;
+		/* Disable LP mode on TPS6594 Family PMIC */
+		if (pfsm->chip_id != TPS65224) {
+			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
+						TPS6594_BIT_LP_STANDBY_SEL);
+
+			if (ret)
+				return ret;
+		}
 
 		/* Force trigger */
 		ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
 					TPS6594_BIT_TRIGGER_I2C(0), TPS6594_BIT_TRIGGER_I2C(0));
 		break;
 	case PMIC_GOTO_LP_STANDBY:
+		/* TPS65224 does not support LP STANDBY */
+		if (pfsm->chip_id == TPS65224)
+			return ret;
+
 		/* Enable LP mode */
 		ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
 				      TPS6594_BIT_LP_STANDBY_SEL);
@@ -169,6 +179,10 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 				      TPS6594_BIT_NSLEEP1B | TPS6594_BIT_NSLEEP2B);
 		break;
 	case PMIC_SET_MCU_ONLY_STATE:
+		/* TPS65224 does not support MCU_ONLY_STATE */
+		if (pfsm->chip_id == TPS65224)
+			return ret;
+
 		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
 			return -EFAULT;
 
@@ -192,14 +206,20 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 			return -EFAULT;
 
 		/* Configure wake-up destination */
+		if (pfsm->chip_id == TPS65224) {
+			regmap_reg = TPS65224_REG_STARTUP_CTRL;
+			mask = TPS65224_MASK_STARTUP_DEST;
+		} else {
+			regmap_reg = TPS6594_REG_RTC_CTRL_2;
+			mask = TPS6594_MASK_STARTUP_DEST;
+		}
+
 		if (state_opt.mcu_only_startup_dest)
-			ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
-						TPS6594_MASK_STARTUP_DEST,
-						TPS6594_STARTUP_DEST_MCU_ONLY);
+			ret = regmap_write_bits(pfsm->regmap, regmap_reg,
+						mask, TPS6594_STARTUP_DEST_MCU_ONLY);
 		else
-			ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
-						TPS6594_MASK_STARTUP_DEST,
-						TPS6594_STARTUP_DEST_ACTIVE);
+			ret = regmap_write_bits(pfsm->regmap, regmap_reg,
+						mask, TPS6594_STARTUP_DEST_ACTIVE);
 		if (ret)
 			return ret;
 
@@ -211,7 +231,8 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 
 		/* Modify NSLEEP1-2 bits */
 		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
-					TPS6594_BIT_NSLEEP2B);
+					pfsm->chip_id == TPS65224 ?
+					TPS6594_BIT_NSLEEP1B : TPS6594_BIT_NSLEEP2B);
 		break;
 	}
 
@@ -262,6 +283,7 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 					    tps->chip_id, tps->reg);
 	pfsm->miscdev.fops = &tps6594_pfsm_fops;
 	pfsm->miscdev.parent = dev->parent;
+	pfsm->chip_id = tps->chip_id;
 
 	for (i = 0 ; i < pdev->num_resources ; i++) {
 		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
-- 
2.25.1


