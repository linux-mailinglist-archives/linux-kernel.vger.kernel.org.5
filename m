Return-Path: <linux-kernel+bounces-108796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03083881014
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D168283393
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8C38384;
	Wed, 20 Mar 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="UD3/huH2"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B322D05C;
	Wed, 20 Mar 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931226; cv=none; b=CHspoaCntpQ14HsODLA02zbbKghRsd3V3QNk8xYA880Q9aQJvQ5Z+aJR5MkFQKVfVMJKIu5oACICfjpqTwxZxUP3ZlBxKVxwR+JlIacbGxJYDtM0Gr5i6ZcSHDjlH6qX2k//dSOaQSbgirBMe0km47kGfayIOkMBByVBC50RCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931226; c=relaxed/simple;
	bh=Y32T7gZW4IggfhZ5kFlo81B/FTCzi9qFSwHVweW2rNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CszHR/ZXtudI196gxQD/iR3nIUhTnM1QFKR4oNsl36Hub0hFfkdM96SB+TL4neheuTnzhwhDM2FLS+/boxXBEteY4ivB+T3G73akYBX6z/FUBnk8At5QjVeEFo7EjdsE4TJmivZrEEJkQsV7TrASEMGRpn5rQum2VBJ397k8E5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=UD3/huH2; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iMhNhe+tcxLmuyKOOZrdE9LpgvkjJPJ2ncK9B+m2l1Q=; b=UD3/huH2xJxpLYmHVUVdrpRcfg
	hM/Tcu5hF3lVsE2Tgl7+6R8mn9eOmqWtGGlCg9Z7s1Jyh72IJEDUIrcXhqk4B6a5hlTzQrqN5EboQ
	7L8lL8vNP2PKWjQs1WX57MuIpRtF2eWPZnCrqqZMiGxf1Qxs8GULRB6JtK0XaMzcQXttibccLW8k2
	FKOazelzUm9QVJDXqOSBb3X3U2dQ8lsaMPFGEx5yHmAEYUKcMAXO2QMbkYcduxeg9acsVJjIleYQv
	1iiH/HxvMEjAy0cHmsKL3tWtlLXZbIB0uyyXb5uPLDd7pDgCeLLNtpA++7qIn03yHA/U/3F/JvScg
	2uczQZCw==;
Received: from [89.212.21.243] (port=57750 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1rmsnx-005Tm8-10;
	Wed, 20 Mar 2024 11:04:17 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: haibo.chen@nxp.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] iio: adc: imx93: Make calibration properties configurable
Date: Wed, 20 Mar 2024 11:04:05 +0100
Message-Id: <20240320100407.1639082-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320100407.1639082-1-andrej.picej@norik.com>
References: <20240320100407.1639082-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Make calibration properties:
 - AVGEN: allow averaging of calibration time,
 - NRSMPL: select the number of averaging samples during calibration and
 - TSAMP: specifies the sample time of calibration conversions

configurable with device tree properties:
 - nxp,calib-avg-en,
 - nxp,calib-nr-samples and
 - nxp,calib-t-samples.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 drivers/iio/adc/imx93_adc.c | 66 ++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 4ccf4819f1f1..ad24105761ab 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/property.h>
 
 #define IMX93_ADC_DRIVER_NAME	"imx93-adc"
 
@@ -43,6 +44,9 @@
 #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
 #define IMX93_ADC_MCR_NSTART_MASK		BIT(24)
 #define IMX93_ADC_MCR_CALSTART_MASK		BIT(14)
+#define IMX93_ADC_MCR_AVGEN_MASK		BIT(13)
+#define IMX93_ADC_MCR_NRSMPL_MASK		GENMASK(12, 11)
+#define IMX93_ADC_MCR_TSAMP_MASK		GENMASK(10, 9)
 #define IMX93_ADC_MCR_ADCLKSE_MASK		BIT(8)
 #define IMX93_ADC_MCR_PWDN_MASK			BIT(0)
 #define IMX93_ADC_MSR_CALFAIL_MASK		BIT(30)
@@ -145,7 +149,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
 
 static int imx93_adc_calibration(struct imx93_adc *adc)
 {
-	u32 mcr, msr;
+	u32 mcr, msr, value;
 	int ret;
 
 	/* make sure ADC in power down mode */
@@ -156,12 +160,64 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
 	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
 	writel(mcr, adc->regs + IMX93_ADC_MCR);
 
-	imx93_adc_power_up(adc);
-
 	/*
-	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
-	 * can add the setting of these bit if need in future.
+	 * Set calibration settings:
+	 * - AVGEN: allow averaging of calibration time,
+	 * - NRSMPL: select the number of averaging samples during calibration,
+	 * - TSAMP: specifies the sample time of calibration conversions.
 	 */
+	if (!device_property_read_u32(adc->dev, "nxp,calib-avg-en", &value)) {
+		mcr &= ~IMX93_ADC_MCR_AVGEN_MASK;
+		mcr |= FIELD_PREP(IMX93_ADC_MCR_AVGEN_MASK, value);
+	}
+
+	if (!device_property_read_u32(adc->dev, "nxp,calib-nr-samples", &value)) {
+		switch (value) {
+		case 16:
+			value = 0x0;
+			break;
+		case 32:
+			value = 0x1;
+			break;
+		case 128:
+			value = 0x2;
+			break;
+		case 512:
+			value = 0x3;
+			break;
+		default:
+			dev_warn(adc->dev, "NRSMPL: wrong value, using default: 512\n");
+			value = 0x3;
+		}
+		mcr &= ~IMX93_ADC_MCR_NRSMPL_MASK;
+		mcr |= FIELD_PREP(IMX93_ADC_MCR_NRSMPL_MASK, value);
+	}
+
+	if (!device_property_read_u32(adc->dev, "nxp,calib-t-samples", &value)) {
+		switch (value) {
+		case 8:
+			value = 0x1;
+			break;
+		case 16:
+			value = 0x2;
+			break;
+		case 22:
+			value = 0x0;
+			break;
+		case 32:
+			value = 0x3;
+			break;
+		default:
+			dev_warn(adc->dev, "TSAMP: wrong value, using default: 22\n");
+			value = 0x0;
+		}
+		mcr &= ~IMX93_ADC_MCR_TSAMP_MASK;
+		mcr |= FIELD_PREP(IMX93_ADC_MCR_TSAMP_MASK, value);
+	}
+
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	imx93_adc_power_up(adc);
 
 	/* run calibration */
 	mcr = readl(adc->regs + IMX93_ADC_MCR);
-- 
2.25.1


