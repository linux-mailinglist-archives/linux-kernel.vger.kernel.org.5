Return-Path: <linux-kernel+bounces-93547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3332873145
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0102B1C2193A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A4604D9;
	Wed,  6 Mar 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2m13hXqM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8D5D916;
	Wed,  6 Mar 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715130; cv=none; b=o3vtXUSp6k3hRflptJI5nReR2AzhLTCAepsTlz3HvKC8yPPG0a6Sst/MDd6HieXywZHotZmvScuna7faegfRGu2gKPT7FtAZzEJJ0XTA/YH2a4119oCIEhFAxUzxnHgixQqu14u5cnG/YmBK0zCky/jKc0x3Ej3ViFwrJGrgYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715130; c=relaxed/simple;
	bh=2lVnVJK6HBHPqpttMtwMrns/KDHFiYf0DzP3RNU3Ing=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKBGY62kGx1GpQd+UMqIW4p4INPq2mbSvzIcckrPmE6z/LVw7muUJ9FENpiMUHnMJif+ZevRxEuyclup1Pnsq/mSZh4g+bTJILDpPdKOgPsjKYQDT4ohNuAQjAXxroWWNlCv7sqFYE1ecC52PYZ2W+PL4b862zKxwlXOGb0TXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2m13hXqM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709715128; x=1741251128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2lVnVJK6HBHPqpttMtwMrns/KDHFiYf0DzP3RNU3Ing=;
  b=2m13hXqMkhA8jzq413WHtak/rPBGtOinRaFOOe2XTAPhtGE9hikWRu4y
   R7NnBXOY5i8DGGAxpzHudEYwHe1ZhHStKe1aZ5N3lzW4oLFW/ehkkeH9X
   /Nn6N8MCxENWph7o8oU9VFlp6snces9h1k3IcDvTqroIrPVDAoszp990/
   7HH14JuQ+Y2049cqQH+2R5AEtnFqPYBqWjOLCsbm6EOoE8nqU19KxMWUN
   z79R/F1iJLZgWQAEjA/jvty1StNAahz04/J0Z4JcZxLq6Az/ReqKsN7Rn
   AOF6ooihmR1h3YRBTOKPuP5FFPkIm2nspsUeYUy8S1XVu+konmDVhnjN9
   Q==;
X-CSE-ConnectionGUID: 0HmRPmBBRSa4bJdT2SRWig==
X-CSE-MsgGUID: 3X55F/GoQimwUqVLKxKz5w==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="scan'208";a="17813743"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 01:52:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 01:51:41 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 01:51:31 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v3 07/12] net: ethernet: oa_tc6: enable open alliance tc6 data communication
Date: Wed, 6 Mar 2024 14:20:12 +0530
Message-ID: <20240306085017.21731-8-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enabling Configuration Synchronization bit (SYNC) in the Configuration
Register #0 enables data communication in the MAC-PHY. The state of this
bit is reflected in the data footer SYNC bit.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 82b4de13438f..371687670409 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -20,6 +20,10 @@
 #define OA_TC6_REG_RESET			0x0003
 #define RESET_SWRESET				BIT(0)	/* Software Reset */
 
+/* Configuration Register #0 */
+#define OA_TC6_REG_CONFIG0			0x0004
+#define CONFIG0_SYNC				BIT(15)
+
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
 #define STATUS0_RESETC				BIT(6)	/* Reset Complete */
@@ -486,6 +490,21 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
 }
 
+static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
+{
+	u32 value;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &value);
+	if (ret)
+		return ret;
+
+	/* Enable configuration synchronization for data transfer */
+	value |= CONFIG0_SYNC;
+
+	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, value);
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -543,7 +562,18 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 		return NULL;
 	}
 
+	ret = oa_tc6_enable_data_transfer(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev, "Failed to enable data transfer: %d\n",
+			ret);
+		goto phy_exit;
+	}
+
 	return tc6;
+
+phy_exit:
+	oa_tc6_phy_exit(tc6);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
 
-- 
2.34.1


