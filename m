Return-Path: <linux-kernel+bounces-150115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEAB8A9A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A30282D42
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB94D15FA91;
	Thu, 18 Apr 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GM503ecn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16B823A2;
	Thu, 18 Apr 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445102; cv=none; b=NQ+tO/tSlrNt7qS4qJ28KGT7E1Ugu3QCPGtTNiBew0/WVlqOtsHacPOGSZpXH4JrFssc7WSx2XGG+xr62kA8JYOswbAtfly/CaBI1xA88EcQkvVC+a5vIoS0UZpcvbg+iVMJXiuc7LJbZZ2wWtK4jj9buViIpqICOIyqmfZxVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445102; c=relaxed/simple;
	bh=g/clOTZF0kpYycmj/CTQC6MpCGn/0W/VGH9B4y7Nvwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmHG0bZgOoD+2hrgIneSLelq16z8Mn4Y6RSIFP+lpOtWp7h8wQfEI57ygwFdielsL1YGNPIyjDJQEeEca93CSI46jThflqC2Sy99S3JSaORiN3KGcXsP7JnbjLuoaDIwjTMZwGn4dTX9Ewa3bivtehwX0x4SSqF+zAUgNvJIwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GM503ecn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713445101; x=1744981101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/clOTZF0kpYycmj/CTQC6MpCGn/0W/VGH9B4y7Nvwo=;
  b=GM503ecnAXxkXm3pz2B0QuMfnDNvXG8fsEbVPOVyor0cFPsSzLptF1B1
   tN7f7vB8JM/wjwhVurLoD29HY3RuFtzRqQjVfSgV15UQpFTbqw0gwHqOn
   2IZlBFRgd50lg/ljwmJ4jptaTF4O/it0gZNzjVKrssOokSemoZ93gN/8U
   IU/+Xh4dhmOFp3iZ+3KHBJCeDRN1U33ymz3sS+qZwBG8GyzTosxSXBQiC
   VBY8EjQqnSm3zSoKwQ3Z8r+K/WgGOj4+xF4gaQbKYxRfBaBIkF0UYdC5l
   OZvHLnTfMT6quEG8oeVl+ocUIUMrUkFi2iHGSPMTRb/UMxflTjeIdcu74
   g==;
X-CSE-ConnectionGUID: Xcx2pWi4Tle/BYeos1za0g==
X-CSE-MsgGUID: QnsaPHzES4+/75OvoYaQXg==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="21604090"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 05:58:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 05:57:47 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 05:57:38 -0700
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
Subject: [PATCH net-next v4 07/12] net: ethernet: oa_tc6: enable open alliance tc6 data communication
Date: Thu, 18 Apr 2024 18:26:43 +0530
Message-ID: <20240418125648.372526-8-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
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
index f04c4c13e8d3..ef7069618319 100644
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
@@ -556,6 +560,21 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
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
@@ -613,7 +632,18 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
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


