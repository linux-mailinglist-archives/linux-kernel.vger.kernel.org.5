Return-Path: <linux-kernel+bounces-93537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E17873124
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE4B25F28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19445DF24;
	Wed,  6 Mar 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qq50eQOr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4995D750;
	Wed,  6 Mar 2024 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715085; cv=none; b=ezcBb4FwjzQHfkypKGq13TG4Zww+z5VyF1Af5Pp6OJQjMuQ1kvu0jctFVgEM1s7/OTqT5bq2we2Oj5KMCz8RE55G2hDm3L0RlSC1U3VeHBRhFYU58EDZXzZoZ+LZREFWLXkPRz+9oZRQ+DkeGzB93+CY6c7pnu9Pjixd54mFkMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715085; c=relaxed/simple;
	bh=Z5IbOGz8ERh6b3UPw1IPPaGjlmXO5pE5liV0ILfL2IM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKw9+RkmNI96iW2tDG0yc4ROT3R0v8QwKFzAxf2PNXdRGbxK4l5YBIOQ9rue2iIOgFIKn6DeBtSZ1Tv53V3Gu/qPCWx73JDZuRV8SS5IXtqrSaxzZ6Tc9fRrL+oW2QFi7Gv/fbfKMpdjxgdRdYOmN/CkvQCGNqBOb1RCq2/YhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qq50eQOr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709715083; x=1741251083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5IbOGz8ERh6b3UPw1IPPaGjlmXO5pE5liV0ILfL2IM=;
  b=Qq50eQOrva4/goep4y0HR/INYWYeUVo6QVtMf9C4ZPAi7ug7HV+9bGzs
   1NqpZpJO7ApDs0FilTf742hfPOsKN5NXXOG05la6I7PXv09mkiqkbharx
   aw7nMJcDugxWJbZrUrpWilOsGwmaVeKVXfrgIZz3AwVcGa6NI/0FArdmI
   9ihsXHV4djUvKnUzSMVLvOl6aEFKs6cVlGWyLwn6n0botGlnPmKOmojhH
   2sW0cC6GAc8bkJn7E00fPgIhtGXzlSMk4Rf1IeEB/Jw1M7Sae9rUqb3dH
   Y/EA5hfwD6bbwCbO7fFWyayRYG9aa6ugzMf98LBggHa3ga4Ai/4zlnZMF
   A==;
X-CSE-ConnectionGUID: D37j0VVORIyxmw0YyEEuxg==
X-CSE-MsgGUID: 4idh1lMLSzWK9wPx70hqtA==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="scan'208";a="18916098"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 01:51:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 01:51:21 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 01:51:12 -0700
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
Subject: [PATCH net-next v3 05/12] net: ethernet: oa_tc6: implement error interrupts unmasking
Date: Wed, 6 Mar 2024 14:20:10 +0530
Message-ID: <20240306085017.21731-6-Parthiban.Veerasooran@microchip.com>
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

This will unmask the following error interrupts from the MAC-PHY.
  tx protocol error
  rx buffer overflow error
  loss of frame error
  header error
The MAC-PHY will signal an error by setting the EXST bit in the receive
data footer which will then allow the host to read the STATUS0 register
find the source of the error.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index e9ddc4ff7d0d..f8593b793291 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -18,6 +18,13 @@
 #define OA_TC6_REG_STATUS0			0x0008
 #define STATUS0_RESETC				BIT(6)	/* Reset Complete */
 
+/* Interrupt Mask Register #0 */
+#define OA_TC6_REG_INT_MASK0			0x000C
+#define INT_MASK0_HEADER_ERR_MASK		BIT(5)
+#define INT_MASK0_LOSS_OF_FRAME_ERR_MASK	BIT(4)
+#define INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK	BIT(3)
+#define INT_MASK0_TX_PROTOCOL_ERR_MASK		BIT(0)
+
 /* Control command header */
 #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
 #define OA_TC6_CTRL_HEADER_WRITE		BIT(29)
@@ -324,6 +331,23 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
 }
 
+static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
+	if (ret)
+		return ret;
+
+	regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
+		    INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
+		    INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
+		    INT_MASK0_HEADER_ERR_MASK);
+
+	return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -364,6 +388,13 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 		return NULL;
 	}
 
+	ret = oa_tc6_unmask_macphy_error_interrupts(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev,
+			"MAC-PHY error interrupts unmask failed: %d\n", ret);
+		return NULL;
+	}
+
 	return tc6;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
-- 
2.34.1


