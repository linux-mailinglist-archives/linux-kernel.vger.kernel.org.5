Return-Path: <linux-kernel+bounces-125360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4589248E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0CB1F279E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9DB13C8F4;
	Fri, 29 Mar 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gZW9OegW"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9313B7AC;
	Fri, 29 Mar 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741755; cv=none; b=OOTSOx4az0bC8kFFYiv9dWCrf5lEE7T4b3CNwfF5AjO8uqbU1+T6Ey5DLrpDSjWRZaDK1LtQdSpzzG4Z8h3ou9/2dp79DfjsqNPqAc5Ew2ny1aWIh1pJ7psXcM8NpT4b0DGjtVbYV81SOPJ6gxQWEYPyUyuysv9ECc1EIOyORMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741755; c=relaxed/simple;
	bh=1cEjig1GJt5yrW2/AZBvoJSGTO8Opdw4rdIQOqEsoRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DARIhlLnfjqxrLKbQ+aQMXtWLmhZqY2leGZtBl2nr94A1SW6hNmrTqJWFTk/nmaD1xXQpfH3wbVaDIPDKucKrOMGeUPA1dgUzPDT2Vcxq9T/B4tpzropsOqkKuUsO49lzM0NF8RmIe+pl2bsUL/d7omN7PjYJmDF3V7hoNbatns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gZW9OegW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TCGUx1027498;
	Fri, 29 Mar 2024 12:49:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=dhYmB03bw+WmHVytL0gPyN8XFol0C1gLpAhy8ykuUjY=; b=gZW
	9OegWrhpm6o3pvMgvafWqIuOya/KSuf99IqoyD8vcCvNWariEo19Im9ke3T4IXFb
	h2+hggwpcuDW1AkHqwH+uIpr1aFwLlr2n/O6qi0DP7gXiqJrLmunUjzzW7JFQmht
	t+KAOIqFzwwNgp5hA1uPCOQ7VKkgjSWO1RvliW3Ek4gt65hnYZ4JXfMDZZuv3N8r
	JnSemB1sq6NQ7wMeog+9v1cAktCSIHfqn2blyDavNUyfQRznZkFn3m9e11X8yeBu
	MHeCxHXyVy2QACd1czK/geD5aMg4zM/zoapRufCFGN2cmiW376A6L4pryYw7oyaw
	BmPylgUjJMohCeWvteA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x5wgphd40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 12:49:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 29 Mar 2024 12:49:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 29 Mar 2024 12:49:08 -0700
Received: from localhost.localdomain (unknown [10.110.150.170])
	by maili.marvell.com (Postfix) with ESMTP id BA81F3F707A;
	Fri, 29 Mar 2024 12:49:07 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Piyush Malgujar <pmalgujar@marvell.com>,
        "Witold
 Sadowski" <wsadowski@marvell.com>
Subject: [PATCH 4/5] driver: spi: cadence: Add ACPI support
Date: Fri, 29 Mar 2024 12:48:48 -0700
Message-ID: <20240329194849.25554-5-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240329194849.25554-1-wsadowski@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CzJ6PpnvbTlkYBqy0ssT-tWNxl2wwUgB
X-Proofpoint-ORIG-GUID: CzJ6PpnvbTlkYBqy0ssT-tWNxl2wwUgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02

From: Piyush Malgujar <pmalgujar@marvell.com>

These changes enables to read the configs from ACPI tables as
required for successful probing in ACPI uefi environment.
In case of ACPI disabled/dts based environment, it will continue to
read configs from dts as before.

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 97 ++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index cce14473e88e..01e81d40f04c 100644
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
@@ -686,6 +688,67 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
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
@@ -709,6 +772,9 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 }
 
 static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
+#ifdef CONFIG_ACPI
+	.supports_op = cdns_xspi_supports_op,
+#endif
 	.exec_op = cdns_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
@@ -760,21 +826,20 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 
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
@@ -816,7 +881,6 @@ static bool cdns_xspi_get_hw_overlay(struct platform_device *pdev)
 	err = device_property_match_string(&pdev->dev,
 					   "compatible", "mrvl,xspi-nor");
 
-
 	return (err >= 0);
 }
 
@@ -841,6 +905,7 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
 	host->mem_ops = &cadence_xspi_mem_ops;
 	host->dev.of_node = pdev->dev.of_node;
+	host->dev.fwnode = pdev->dev.fwnode;
 	host->bus_num = -1;
 
 	if (hw_overlay)
@@ -863,19 +928,21 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (ret)
 		return -ENODEV;
 
-	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cdns_xspi->iobase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->iobase)) {
 		dev_err(dev, "Failed to remap controller base address\n");
 		return PTR_ERR(cdns_xspi->iobase);
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->sdmabase))
 		return PTR_ERR(cdns_xspi->sdmabase);
 	cdns_xspi->sdmasize = resource_size(res);
 
-	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	cdns_xspi->auxbase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->auxbase)) {
 		dev_err(dev, "Failed to remap AUX address\n");
 		return PTR_ERR(cdns_xspi->auxbase);
@@ -917,6 +984,13 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct acpi_device_id cdns_xspi_acpi_match[] = {
+	{"cdns,xspi-nor", 0},
+	{"mrvl,xspi-nor", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, cdns_xspi_acpi_match);
+#ifdef CONFIG_OF
 static const struct of_device_id cdns_xspi_of_match[] = {
 	{
 		.compatible = "cdns,xspi-nor",
@@ -933,6 +1007,7 @@ static struct platform_driver cdns_xspi_platform_driver = {
 	.driver = {
 		.name = CDNS_XSPI_NAME,
 		.of_match_table = cdns_xspi_of_match,
+		.acpi_match_table = cdns_xspi_acpi_match,
 	},
 };
 
-- 
2.17.1


