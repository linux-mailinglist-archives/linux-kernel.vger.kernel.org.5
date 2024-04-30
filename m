Return-Path: <linux-kernel+bounces-164173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFCE8B7A28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252671F26B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA811BF6CE;
	Tue, 30 Apr 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l45UlqAo"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862D1802D9;
	Tue, 30 Apr 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487603; cv=none; b=VXd07novNTYHM96yACLaHFaKWOxRnrD7ToEh+YF0P8/i9sn6LSLYa/Zz90JAUq+0ZrFVngnsxMySYQinUqDnUe6HEHGyWlrIJXMnisSq/5BDwWbnzgVh5p2Z6TcMzpiRRYnKxehNDEKagrUaQT+ZsN6UZtWskMqhCun65uw/UCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487603; c=relaxed/simple;
	bh=3zemZ+ENMGoPGIEwTuWopoyGRq1SxyxEFPSLySd79K4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SbB5mAkosfnMwrMghvTZnkL84Uf4sZPiVaRlNpTcmbjSQygd3W8Og22XF0KMf61JkWy11mBh3dqKCJ387UUnovKGgnTBtARDpcj+HwPIGDlZVUdVHJsrP6Yh5awGH7qh8iEDZX6C/9s3lslYZHdN6aMkbiPU2Dt/Lau8UPO/+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l45UlqAo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so35123755ad.1;
        Tue, 30 Apr 2024 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714487601; x=1715092401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9+uw12LzVsx3wU8adlXBHs43wHbzfmBsLnbaFarO2I=;
        b=l45UlqAoIwoLUaQ6CY4K214s22tn0YR3Rpv73kqX+g1//lCVJ0X53Aqnsq13fabxN2
         gWADgXGPOMQt8RwLkN7kQFRosn6LQoiCsoFP0jhAd/8afb4IRoDa1wkOiin7GzVB0UVO
         mEWcXnzNZjtnUWId3Z4BJRxp6HjwtCWyX10sbiUwAWcH3H1u/Nh6dYMTGYQvrxjASKOW
         Fc3H9ng9y5IiMvgJLsRqke3Mgf5SHYA5hxrGwwcdvyPCckJw0X8u93IoZGqNgXLP7K5H
         pDEpudPwmhEPEU7JGBCP76hbnP4miQqA+MQ+FCtNdTnGro8Fq20CenqHxrwhZ3GrDYxE
         MCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487601; x=1715092401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9+uw12LzVsx3wU8adlXBHs43wHbzfmBsLnbaFarO2I=;
        b=Tm1xkBDm6+D8w22asHTwsV4j7n4sso8xsDpPsGZVKGc4knJ73ZrCA92gBfFPsMgbrn
         sey5KUpIyvRKtE0egdTZM8LIHvXEpP/7mBqdFHxlNw7fLR38TqpxmUWUMzwJDhw7IVCc
         GrjLmimAk0J0gxyCxwSvh6SwNTx5MtKlm4N1iTWIueD/WGGBmkl6cHUzNWwC7u0RvLn9
         COCRnoMkp6yq870OWdlG7JvJASknjm8EBY8ACYBrrItlx49UPinp9tetkOZMEf5coOYA
         SLK/W3k+Pkt3vvmjNMwUV1bUC8cKYQeu0aRl/IUVEN2DZ+Bqvv+LgWgtqS0dGyZI+afh
         Ty7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVP/svCUJuk8smxV/Ghtb/Y424MT9dz85/7OFQiGCTLrAdUBZ0HmznhQMByCpYvQbO3tmgdZ1HGCUzodlvAW4PnLNO2I7nrmu7BdPC9UFsYs7DfrWPzSikxTE4yi32Lq797ojcxc8JaXLRIBM=
X-Gm-Message-State: AOJu0Yz1j5Afzm1KDpgUcAW1y+gXbpkoGXaB0id2lw3gFyvcyVIxbAH1
	/I7GV3R7EA04Gq3a0qoMWl69PyJJu+ni+U5kouLLJ8/tM1y6zsI7
X-Google-Smtp-Source: AGHT+IH4UdZbzfvSJo3QJfZt+JphuB4AEFpA9cZMcuqalJRWHwyT3Ed+65xfdEtezZjfDmHJFi8NrA==
X-Received: by 2002:a17:902:e806:b0:1e2:81c1:b35e with SMTP id u6-20020a170902e80600b001e281c1b35emr17906114plg.54.1714487600758;
        Tue, 30 Apr 2024 07:33:20 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001e47972a2casm1682431plx.96.2024.04.30.07.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:33:20 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Eddie James <eajames@linux.vnet.ibm.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/1] watchdog: aspeed: Revise handling of bootstatus
Date: Tue, 30 Apr 2024 22:31:14 +0800
Message-Id: <20240430143114.1323686-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430143114.1323686-1-peteryin.openbmc@gmail.com>
References: <20240430143114.1323686-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set. However, this bit can be clear when
watchdog register 0x0c bit1(Reset System after timeout) is enabled.
Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
in ast2600 SCU74 or ast2400/ast2500 SCU3C.

Fixes: 49d4d277ca54 ("aspeed: watchdog: Set bootstatus during probe")
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 90 +++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..556493763793 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -11,10 +11,12 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -22,10 +24,38 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+/* AST SCU Register for System Reset Event Log Register Set
+ * ast2600 is scu074 ast2400/2500 is scu03c
+ */
+#define AST_SCU_SYS_RESET_POWERON_MASK	BIT(0)
+#define AST_SCU_SYS_RESET_EXTERN_FLAG	BIT(1)
+
+#define AST2400_SYSTEM_RESET_STATUS	0x3C
+#define   AST2400_WATCHDOG_RESET_MASK	BIT(1)
+#define   AST2400_RESET_FLAG_CLEAR	GENMASK(2, 0)
+
+#define   AST2500_WATCHDOG_RESET_MASK	GENMASK(4, 2)
+#define   AST2500_RESET_FLAG_CLEAR	(AST2500_WATCHDOG_RESET_MASK | \
+					 AST_SCU_SYS_RESET_POWERON_MASK | \
+					 AST_SCU_SYS_RESET_EXTERN_FLAG)
+
+#define AST2600_SYSTEM_RESET_STATUS	0x74
+#define   AST2600_WATCHDOG_RESET_MASK   GENMASK(31, 16)
+#define   AST2600_RESET_FLAG_CLEAR	(AST2600_WATCHDOG_RESET_MASK | \
+					 AST_SCU_SYS_RESET_POWERON_MASK | \
+					 AST_SCU_SYS_RESET_EXTERN_FLAG)
+
 struct aspeed_wdt_config {
 	u32 ext_pulse_width_mask;
 	u32 irq_shift;
 	u32 irq_mask;
+	struct {
+		const char *compatible;
+		u32 reset_status_reg;
+		u32 watchdog_reset_mask;
+		u32 extern_reset_mask;
+		u32 reset_flag_clear;
+	} scu;
 };
 
 struct aspeed_wdt {
@@ -39,18 +69,39 @@ static const struct aspeed_wdt_config ast2400_config = {
 	.ext_pulse_width_mask = 0xff,
 	.irq_shift = 0,
 	.irq_mask = 0,
+	.scu = {
+		.compatible = "aspeed,ast2400-scu",
+		.reset_status_reg = AST2400_SYSTEM_RESET_STATUS,
+		.watchdog_reset_mask = AST2400_WATCHDOG_RESET_MASK,
+		.extern_reset_mask = 0,
+		.reset_flag_clear = AST2400_RESET_FLAG_CLEAR,
+	}
 };
 
 static const struct aspeed_wdt_config ast2500_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 12,
 	.irq_mask = GENMASK(31, 12),
+	.scu = {
+		.compatible = "aspeed,ast2500-scu",
+		.reset_status_reg = AST2400_SYSTEM_RESET_STATUS,
+		.watchdog_reset_mask = AST2500_WATCHDOG_RESET_MASK,
+		.extern_reset_mask = AST_SCU_SYS_RESET_EXTERN_FLAG,
+		.reset_flag_clear = AST2500_RESET_FLAG_CLEAR,
+	}
 };
 
 static const struct aspeed_wdt_config ast2600_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 0,
 	.irq_mask = GENMASK(31, 10),
+	.scu = {
+		.compatible = "aspeed,ast2600-scu",
+		.reset_status_reg = AST2600_SYSTEM_RESET_STATUS,
+		.watchdog_reset_mask = AST2600_WATCHDOG_RESET_MASK,
+		.extern_reset_mask = AST_SCU_SYS_RESET_EXTERN_FLAG,
+		.reset_flag_clear = AST2600_RESET_FLAG_CLEAR,
+	}
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
@@ -310,6 +361,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
 	struct device_node *np;
+	struct regmap *scu;
 	const char *reset_type;
 	u32 duration;
 	u32 status;
@@ -458,14 +510,36 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
-	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
-
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
-	}
+	/*
+	 * Power on reset is set when triggered by AC or SRSRST.
+	 * Thereforce, we clear flag to ensure
+	 * next boot cause is a real watchdog case.
+	 * We use the external reset flag to determine
+	 * if it is an external reset or card reset.
+	 * However, The ast2400 watchdog flag is cleared by an external reset,
+	 * so it only supports WDIOF_CARDRESET.
+	 */
+	scu = syscon_regmap_lookup_by_compatible(wdt->cfg->scu.compatible);
+	if (IS_ERR(scu))
+		return PTR_ERR(scu);
+
+	ret = regmap_read(scu, wdt->cfg->scu.reset_status_reg, &status);
+	if (ret)
+		return ret;
+
+	if (!(status & AST_SCU_SYS_RESET_POWERON_MASK) &&
+	      status & wdt->cfg->scu.watchdog_reset_mask)
+		wdt->wdd.bootstatus = (status & wdt->cfg->scu.extern_reset_mask)
+					 ? WDIOF_EXTERN1 : WDIOF_CARDRESET;
+
+	status = wdt->cfg->scu.reset_flag_clear;
+	ret = regmap_write(scu, wdt->cfg->scu.reset_status_reg, status);
+	if (ret)
+		return ret;
+
+	if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
+	    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
+		wdt->wdd.groups = bswitch_groups;
 
 	dev_set_drvdata(dev, wdt);
 
-- 
2.25.1


