Return-Path: <linux-kernel+bounces-150110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C068A9A89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF44E1F21CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59B13247D;
	Thu, 18 Apr 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ps+jACff"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EF16078D;
	Thu, 18 Apr 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445062; cv=none; b=jhhFmLyL541RlukDsEC+hDBgTx0ZcUFlJjR+Ne3nGRT/XxdvfKEFS9wD7bTjrL+VqO2mnIn68BNa2B7JPTmC3djR/1R3XGUoicWvKVbrR3UZAYvIlg/IRFlLnH1UIJ4F+QC1FuWDzbV6h4KIwiUgLGpzGv2piSnPTn0atuS6m9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445062; c=relaxed/simple;
	bh=CEwgfS9fMPtSKgy5H4AI/vG3K7fhtg+kYKJ1YnEtVsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5TXJzv0QmB6q4K8opsnL9Mc+rF9gA4bKb4rm4F2eQms837glz9DSX7Yvlxjy2N68tiGompkb7i2k961ixsX2nM/F1nt6JfOpPX5vwR3/lz8ppaljH2nSEpXZDlpiGge3gVQRiCG1NF4MyBczbM5UdT12f/FDw6xWphsFmQRULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ps+jACff; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713445061; x=1744981061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEwgfS9fMPtSKgy5H4AI/vG3K7fhtg+kYKJ1YnEtVsg=;
  b=ps+jACff9Ior38PcTs6v5tlIxswml2sQBzGkvVx580rZX/MS86vvZ5u8
   WP9iiAX/cDDgZLBNJ3bELIzqgSmNwA5pvN3EtK0mxdia++QCjGIzLPK2p
   1Hh70UGaBUqNmmMQ4aNMtjAOvD73qjvZ+n495yjzxEa+2fkGZo4kEwDVN
   wstmf+rlpUJRlSezy6E3TPgQGQAaVI1ZPs932Ew4nRd3234YdFg0AUQed
   KHTZB5D7tO0tZR0TzDq9VBroGKXeHamLWVKkATjBZglrTKlW9MN93focL
   6Je6xL4JQhJioTKnTMzFWTd2OzR5pfxOzKHKlNZKgr5/isv9HLCSGRnD8
   A==;
X-CSE-ConnectionGUID: wIEpAzdhSGCIIYIJVV9X/Q==
X-CSE-MsgGUID: 6a6cyb+/SoeYTnfNr1hPDg==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="23619637"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 05:57:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 05:57:21 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 05:57:13 -0700
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
Subject: [PATCH net-next v4 04/12] net: ethernet: oa_tc6: implement software reset
Date: Thu, 18 Apr 2024 18:26:40 +0530
Message-ID: <20240418125648.372526-5-Parthiban.Veerasooran@microchip.com>
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

Reset complete bit is set when the MAC-PHY reset completes and ready for
configuration. Additionally reset complete bit in the STS0 register has
to be written by one upon reset complete to clear the interrupt.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index f563329912e2..4b0f63c02c35 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -6,8 +6,18 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/iopoll.h>
 #include <linux/oa_tc6.h>
 
+/* OPEN Alliance TC6 registers */
+/* Reset Control and Status Register */
+#define OA_TC6_REG_RESET			0x0003
+#define RESET_SWRESET				BIT(0)	/* Software Reset */
+
+/* Status Register #0 */
+#define OA_TC6_REG_STATUS0			0x0008
+#define STATUS0_RESETC				BIT(6)	/* Reset Complete */
+
 /* Control command header */
 #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
 #define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
@@ -24,6 +34,8 @@
 						(OA_TC6_CTRL_MAX_REGISTERS *\
 						OA_TC6_CTRL_REG_VALUE_SIZE) +\
 						OA_TC6_CTRL_IGNORED_SIZE)
+#define STATUS0_RESETC_POLL_DELAY		1000
+#define STATUS0_RESETC_POLL_TIMEOUT		1000000
 
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
@@ -279,6 +291,39 @@ int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_write_register);
 
+static int oa_tc6_read_status0(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
+	if (ret)
+		return 0;
+
+	return regval;
+}
+
+static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
+{
+	u32 regval = RESET_SWRESET;
+	int ret;
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_RESET, regval);
+	if (ret)
+		return ret;
+
+	/* Poll for soft reset complete for every 1ms until 1s timeout */
+	ret = readx_poll_timeout(oa_tc6_read_status0, tc6, regval,
+				 regval & STATUS0_RESETC,
+				 STATUS0_RESETC_POLL_DELAY,
+				 STATUS0_RESETC_POLL_TIMEOUT);
+	if (ret)
+		return -ENODEV;
+
+	/* Clear the reset complete status */
+	return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -289,6 +334,7 @@ EXPORT_SYMBOL_GPL(oa_tc6_write_register);
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 {
 	struct oa_tc6 *tc6;
+	int ret;
 
 	tc6 = devm_kzalloc(&spi->dev, sizeof(*tc6), GFP_KERNEL);
 	if (!tc6)
@@ -311,6 +357,13 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 	if (!tc6->spi_ctrl_rx_buf)
 		return NULL;
 
+	ret = oa_tc6_sw_reset_macphy(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev,
+			"MAC-PHY software reset failed: %d\n", ret);
+		return NULL;
+	}
+
 	return tc6;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
-- 
2.34.1


