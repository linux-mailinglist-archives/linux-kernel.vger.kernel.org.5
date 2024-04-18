Return-Path: <linux-kernel+bounces-149385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCB8A9074
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB561F21D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECB641766;
	Thu, 18 Apr 2024 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XSO2IjxH"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91738F94;
	Thu, 18 Apr 2024 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402872; cv=none; b=ovwOpnL5vzyXvcB88AB0z3dJY5f7X7Cmk9bDTELVZs3aCHAnCvQgaP3BQJJYVg1LC0Fmu7NapsENmpaEWZWCylbjeV6O2DwEVR4VJEQWkDYSFBXp7+AeLKRlt6ocdFEQ5YFf3xjXTlmHGAPeZ8C4v76MBogkC7tj9rHVJUITmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402872; c=relaxed/simple;
	bh=A14ss8CesZC45Dih/zId0HnbGtzjV8ccnEuHqSAv6Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVE29yX6+T+g5LXlz3mnbg6F4T0OKV5BaJ6JGsVD39bYY2ZIAqxnQbS2jFhZGbGZMQqTjntyOhicZPMIkPYzcimkrqxN1c3b5n/osAeH5GoKYEoevvTknh44PP0XsaNrd3UEqDYgst6TEX7KyUs/5sU0g5fENWuPEuuq3LwsCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XSO2IjxH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HIddBE012429;
	Wed, 17 Apr 2024 18:14:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=p0tn/3UmsAX177D0qhLIyi1mxGZdd5rXhhFtqC+oCd4=; b=XSO
	2IjxHjErqiWdYRlbf2OtxEIe8k4IjzF4N77tvUg8gWLkRKaugoKYjtmyp6eyyfEz
	ASJ7+2ze/QABtaxOfjRCkldOXJoVQStrlijAK08pR4aLu9yaF1/8NvlEo0XW+CmE
	a7yrw67QApJ7dfoG/oCuaWQ9b510CMOpZ1OfIyL7NVQjuok/3XD5alc2HAp/1iBQ
	2rrwUuPQOAkPFaj4388vpSnIU3JsMzLLgPimKIYsn2NQpHEhBI3ioAhqem36kfFA
	8DK9/shegUi+cxOOcBVL8/pdXmmyrqQqHtS8g5lHhXUNfz4sfrdUWeMAGDuNfGyW
	VodaW/g4AMd34m9ku8A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xjkw694vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 18:14:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 18:14:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 18:14:21 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id CDF113F7070;
	Wed, 17 Apr 2024 18:14:20 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Piyush Malgujar <pmalgujar@marvell.com>,
        "Witold
 Sadowski" <wsadowski@marvell.com>
Subject: [PATCH v3 4/5] spi: cadence: Allow to read basic xSPI configuration from ACPI
Date: Wed, 17 Apr 2024 18:13:51 -0700
Message-ID: <20240418011353.1764672-5-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418011353.1764672-1-wsadowski@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pGE8lOr8-0OFPxAKRm8Zd77zKQ8zKaf_
X-Proofpoint-ORIG-GUID: pGE8lOr8-0OFPxAKRm8Zd77zKQ8zKaf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02

From: Piyush Malgujar <pmalgujar@marvell.com>

These changes enables to read the configs from ACPI tables as required
for successful probing in ACPI uefi environment.
In case of ACPI disabled/dts based environment, it will continue to
read configs from dts as before

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 97 +++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 5d36f9177f3c..e4ebfad8a1cb 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,6 +2,7 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -14,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
@@ -700,6 +702,67 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 					   (dir != SPI_MEM_NO_DATA));
 }
 
+#ifdef CONFIG_ACPI
+static bool cdns_xspi_supports_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	struct spi_device *spi = mem->spi;
+	const union acpi_object *obj;
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&spi->dev);
+
+	if (!acpi_dev_get_property(adev, "spi-tx-bus-width", ACPI_TYPE_INTEGER,
+				   &obj)) {
+		switch (obj->integer.value) {
+		case 1:
+			break;
+		case 2:
+			spi->mode |= SPI_TX_DUAL;
+			break;
+		case 4:
+			spi->mode |= SPI_TX_QUAD;
+			break;
+		case 8:
+			spi->mode |= SPI_TX_OCTAL;
+			break;
+		default:
+			dev_warn(&spi->dev,
+				 "spi-tx-bus-width %lld not supported\n",
+				 obj->integer.value);
+			break;
+		}
+	}
+
+	if (!acpi_dev_get_property(adev, "spi-rx-bus-width", ACPI_TYPE_INTEGER,
+				   &obj)) {
+		switch (obj->integer.value) {
+		case 1:
+			break;
+		case 2:
+			spi->mode |= SPI_RX_DUAL;
+			break;
+		case 4:
+			spi->mode |= SPI_RX_QUAD;
+			break;
+		case 8:
+			spi->mode |= SPI_RX_OCTAL;
+			break;
+		default:
+			dev_warn(&spi->dev,
+				 "spi-rx-bus-width %lld not supported\n",
+				 obj->integer.value);
+			break;
+		}
+	}
+
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	return true;
+}
+#endif
+
 static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
 				    const struct spi_mem_op *op)
 {
@@ -723,6 +786,9 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 }
 
 static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
+#ifdef CONFIG_ACPI
+	.supports_op = cdns_xspi_supports_op,
+#endif
 	.exec_op = cdns_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
@@ -774,21 +840,20 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 
 static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
 {
-	struct device_node *node_prop = pdev->dev.of_node;
-	struct device_node *node_child;
+	struct fwnode_handle *fwnode_child;
 	unsigned int cs;
 
-	for_each_child_of_node(node_prop, node_child) {
-		if (!of_device_is_available(node_child))
+	device_for_each_child_node(&pdev->dev, fwnode_child) {
+		if (!fwnode_device_is_available(fwnode_child))
 			continue;
 
-		if (of_property_read_u32(node_child, "reg", &cs)) {
+		if (fwnode_property_read_u32(fwnode_child, "reg", &cs)) {
 			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
-			of_node_put(node_child);
+			fwnode_handle_put(fwnode_child);
 			return -ENXIO;
 		} else if (cs >= CDNS_XSPI_MAX_BANKS) {
 			dev_err(&pdev->dev, "reg (cs) parameter value too large\n");
-			of_node_put(node_child);
+			fwnode_handle_put(fwnode_child);
 			return -ENXIO;
 		}
 	}
@@ -924,6 +989,21 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cdns_xspi_acpi_match[] = {
+	{
+		.id = "cdns,xspi-nor",
+		.driver_data = (kernel_ulong_t) &cdns_driver_data,
+	},
+	{
+		.id = "mrvl,xspi-nor",
+		.driver_data = (kernel_ulong_t) &mrvl_driver_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, cdns_xspi_acpi_match);
+#endif
+
 static const struct of_device_id cdns_xspi_of_match[] = {
 	{
 		.compatible = "cdns,xspi-nor",
@@ -942,6 +1022,9 @@ static struct platform_driver cdns_xspi_platform_driver = {
 	.driver = {
 		.name = CDNS_XSPI_NAME,
 		.of_match_table = cdns_xspi_of_match,
+#ifdef CONFIG_ACPI
+		.acpi_match_table = cdns_xspi_acpi_match,
+#endif
 	},
 };
 
-- 
2.43.0


