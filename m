Return-Path: <linux-kernel+bounces-127844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16258951A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5114F2896AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB576048;
	Tue,  2 Apr 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YYTQahLB"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E35A104;
	Tue,  2 Apr 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056641; cv=none; b=WDnNtL6T3co7i9O4jFvlsUZtvAWZ/lu5zy/JKjBG2wnTRDSvK+QwBQTznrKyIhYtCuJueiHa4eQwzlFEDKcGBBL/SZYwcSUE+FQVppJRAhaMOVn4Dewwx+qpkBXtWD70exicFruPi9LIqOUPEvRK0rffJbebDyOvwln8qKKkQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056641; c=relaxed/simple;
	bh=VdzlGO2dazYEGxZXvq8YoZL7jFRa9MHPBGcA2CCVUDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUgbS3xkdTsi+RBL07z2G80apHa+WxGZwrob9yTyzSewI4cU+pFX730FAV38uknCTMBraX+HbOU0iiNcD9M1GrHTqYZzvlw9IVrKDu6zaC8sQGYcXmeedHGGyNLMDZCpOD1TX4oEKiUWAfbPjBOdFgqYNKNdP/20nI1omUVqUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=YYTQahLB; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8d-003kpH-2l;
	Tue, 02 Apr 2024 13:17:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vex+9P2NxDOJXQQ0gKcOir6ALkPn8rxaOxG2WX61EBQ=; b=YYTQahLBZq5SfTqfuLaiNu6YY/
	ZMp3clmi+vUmO7K0/ijIMfDu/BRT5HTefwocmoxCCCHiI1IUqKXYDWRQyNZopihN5MPnSJ12I97Bd
	I6JY2zBrYZ07RDrn+Rj0u2x06RRgWvdiBCUv9y03b270miP6mY/i+oTxYGWD2rYpkcGOFlFIFElf3
	3WMjfBoj2eSJhGPx10aXBOYxxnwuLGu2GRM+bBCi9WauVvs8bYundD80k3SPx9D4L1fls5ezdqsuD
	mGrHHW+MbBUqfmBGEkoxsWSc1FXBlzSfYf6ihtl0vZP9ytKaKHeGuzQ/1PRBbn4syrHzkCTLDIlGd
	G8XHzpjg==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8c-000IAQ-0Z;
	Tue, 02 Apr 2024 13:17:10 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8c-0024WH-05;
	Tue, 02 Apr 2024 13:17:10 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 2/2] mfd: rohm-bd71828: Add power off functionality
Date: Tue,  2 Apr 2024 13:17:00 +0200
Message-Id: <20240402111700.494004-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402111700.494004-1-andreas@kemnade.info>
References: <20240402111700.494004-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the chip can power off the system, add the corresponding
functionality.
Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/rohm-bd71828.c       | 36 +++++++++++++++++++++++++++++++-
 include/linux/mfd/rohm-bd71828.h |  3 +++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 594718f7e8e1..4a1fa8a0d76a 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -464,6 +464,27 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
 				  OUT32K_MODE_CMOS);
 }
 
+static struct i2c_client *bd71828_dev;
+static void bd71828_power_off(void)
+{
+	while (true) {
+		s32 val;
+
+		/* We are not allowed to sleep, so do not use regmap involving mutexes here. */
+		val = i2c_smbus_read_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1);
+		if (val >= 0)
+			i2c_smbus_write_byte_data(bd71828_dev,
+						  BD71828_REG_PS_CTRL_1,
+						  BD71828_MASK_STATE_HBNT | (u8)val);
+		mdelay(500);
+	}
+}
+
+static void bd71828_remove_poweroff(void *data)
+{
+	pm_power_off = NULL;
+}
+
 static int bd71828_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *irq_data;
@@ -542,7 +563,20 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
 	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
 				   NULL, 0, regmap_irq_get_domain(irq_data));
 	if (ret)
-		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
+		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
+
+	if (of_device_is_system_power_controller(i2c->dev.of_node) &&
+	    chip_type == ROHM_CHIP_TYPE_BD71828) {
+		if (!pm_power_off) {
+			bd71828_dev = i2c;
+			pm_power_off = bd71828_power_off;
+			ret = devm_add_action_or_reset(&i2c->dev,
+						       bd71828_remove_poweroff,
+						       NULL);
+		} else {
+			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
+		}
+	}
 
 	return ret;
 }
diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
index 3b5f3a7db4bd..9776fde1262d 100644
--- a/include/linux/mfd/rohm-bd71828.h
+++ b/include/linux/mfd/rohm-bd71828.h
@@ -4,6 +4,7 @@
 #ifndef __LINUX_MFD_BD71828_H__
 #define __LINUX_MFD_BD71828_H__
 
+#include <linux/bits.h>
 #include <linux/mfd/rohm-generic.h>
 #include <linux/mfd/rohm-shared.h>
 
@@ -41,6 +42,8 @@ enum {
 #define BD71828_REG_PS_CTRL_2		0x05
 #define BD71828_REG_PS_CTRL_3		0x06
 
+#define BD71828_MASK_STATE_HBNT		BIT(1)
+
 //#define BD71828_REG_SWRESET		0x06
 #define BD71828_MASK_RUN_LVL_CTRL	0x30
 
-- 
2.39.2


