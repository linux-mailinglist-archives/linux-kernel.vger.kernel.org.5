Return-Path: <linux-kernel+bounces-69745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3E858DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43851F21EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814921D52A;
	Sat, 17 Feb 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ySj3BOqz"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013B1CD23;
	Sat, 17 Feb 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708158047; cv=none; b=RhdXvrxkoLsUjTKcSXCkpEJ5dePAEtHFKqQ3hAaSvDrsx9yT0Ppsede5v3QseuqUUB+spYKjzdHA1qNyQE7pQEaUpVzwdo3z6FNqPHQKpf8JJMOT6MWTCs7iOcB1LpCQfXGHXnva+GuZue2fiYBoKwQfOu5AeN0Cy6NRuoHK9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708158047; c=relaxed/simple;
	bh=w91rU8ULQEAl2yC2K+2JFdu1mPXgT91a33YAroU1V7Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4O3I93V/zcngLpkgy/8dRglG3vAfd3Vn73rWZYTCTW8xvzWEkrs1xdseJ3ChfX4KiYeoCDnRzLRWR3TnxsbkUwqAsFQp6cfo3q/bychXeIwbGAHOhZ/HmF0I4e7l3JXSIa5ALwM4qXo60//qgvE2DPJyC5vWyHX1Z9XtIDIRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ySj3BOqz; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t7Kt1H92S1Uo0WtagmmqZO9iJoXliNnTy7y2hbdMW6c=; b=ySj3BOqzDv6V6LUOJA80aQGK2K
	h82bVen1rFf66iJOzOxPHpmbmGTF4GmNe684LXyhkDxtv80O6Fjn13SgI8j5LDKHCvSPUGFf6u+dU
	Hx0Ws2fUnwAvHSsSBShkYQFU85PO12uPDvuI+Vgb0BVWltQUZ5OZ7AM9v7IwfAIMq1oIg2/hzEqKb
	rWi4TD+FBenkuVrh3RzAKAF5YPSIu57te1CmEEQ286YBjYDwkpLQjvlXzvw+OPc70ADrQYJ1rDwEw
	hOdJKltecWjCbkuu0Vu0klh8KBlahvGC1q/2Wj5CKrh4AEV0mlaPD1dnm9UJBdzVvJf2doV5wUMW/
	7/pVuYNw==;
Received: from p2003010777002c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFw0-009WA5-DZ; Sat, 17 Feb 2024 09:20:32 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFvz-00Dabj-2w;
	Sat, 17 Feb 2024 09:20:31 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	bcousson@baylibre.com,
	tony@atomide.com,
	andreas@kemnade.info,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v4 2/5] twl-core: add power off implementation for twl603x
Date: Sat, 17 Feb 2024 09:20:04 +0100
Message-Id: <20240217082007.3238948-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217082007.3238948-1-andreas@kemnade.info>
References: <20240217082007.3238948-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the system-power-controller property is there, enable power off.
Implementation is based on a Linux v3.0 vendor kernel.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/twl-core.c  | 28 ++++++++++++++++++++++++++++
 include/linux/mfd/twl.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 6e384a79e3418..c130ffef182f1 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -124,6 +124,11 @@
 #define TWL6030_BASEADD_RSV		0x0000
 #define TWL6030_BASEADD_ZERO		0x0000
 
+/* Some fields in TWL6030_PHOENIX_DEV_ON */
+#define TWL6030_APP_DEVOFF		BIT(0)
+#define TWL6030_CON_DEVOFF		BIT(1)
+#define TWL6030_MOD_DEVOFF		BIT(2)
+
 /* Few power values */
 #define R_CFG_BOOT			0x05
 
@@ -687,6 +692,20 @@ static void twl_remove(struct i2c_client *client)
 	twl_priv->ready = false;
 }
 
+static void twl6030_power_off(void)
+{
+	int err;
+	u8 val;
+
+	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val, TWL6030_PHOENIX_DEV_ON);
+	if (err)
+		return;
+
+	val |= TWL6030_APP_DEVOFF | TWL6030_CON_DEVOFF | TWL6030_MOD_DEVOFF;
+	twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val, TWL6030_PHOENIX_DEV_ON);
+}
+
+
 static struct of_dev_auxdata twl_auxdata_lookup[] = {
 	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
 	{ /* sentinel */ },
@@ -852,6 +871,15 @@ twl_probe(struct i2c_client *client)
 			goto free;
 	}
 
+	if (twl_class_is_6030()) {
+		if (of_device_is_system_power_controller(node)) {
+			if (!pm_power_off)
+				pm_power_off = twl6030_power_off;
+			else
+				dev_warn(&client->dev, "Poweroff callback already assigned\n");
+		}
+	}
+
 	status = of_platform_populate(node, NULL, twl_auxdata_lookup,
 				      &client->dev);
 
diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index c062d91a67d92..85dc406173dba 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -461,6 +461,7 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 
 #define TWL4030_PM_MASTER_GLOBAL_TST		0xb6
 
+#define TWL6030_PHOENIX_DEV_ON                  0x06
 /*----------------------------------------------------------------------*/
 
 /* Power bus message definitions */
-- 
2.39.2


