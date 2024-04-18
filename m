Return-Path: <linux-kernel+bounces-150112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6138A9A91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4BB1C21243
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685031635DC;
	Thu, 18 Apr 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xp8fOrky"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED0161306;
	Thu, 18 Apr 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445065; cv=none; b=WZqaWxY83VJNF8P41UQtg/Hhr2BkFxZ/tP2AIk/MYdAqKW+lxTCubg7X2G1WLbK8+cpSeyDSxUyVKdAHZBTSUUabf0WN06zFavqFpcsgl8PwdHBMPgInVrKk5qMrB74QFFIRoFlROgnvSbVINCtgGbxkghMiE5isEDcACEvIMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445065; c=relaxed/simple;
	bh=yQvbkSLcdIeNInVreHxrqpZEvnx+P5m7ZO6OmY1CBug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXbDMyq+eOMp3W4Y3UXdRiBhT99rLlBdIna9MKEkZlqAr+YAVL2+z2X+a+uSJTXfJwiN3atFRzTB3dT9m0vNAcunHHTdftL49FNYVr9CX4OcF0QZhuaIUzLqIYRLOBa+tgbfn/Ecs8JiyHCZEpLnYXD78A2MtAjneSaExFhf3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xp8fOrky; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713445063; x=1744981063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQvbkSLcdIeNInVreHxrqpZEvnx+P5m7ZO6OmY1CBug=;
  b=Xp8fOrkyVPThsxbVBQPsAnFXRzshTT6o03kqNJWzUYN1BX6VTlXvRVqN
   7gVtK/jw+TtEPuiG2kbDGUx7321En/7JvX2M2y0MibgeYtUfHwS/aIyMH
   IpcQEVtnn1G0RhFod64TISlKUQVN0NY7l/8es03GgqbmPBiEg6IETNDW2
   HVafzf0tocyBGuZGZGhazS+5pmjyRhuYuDIE8tO0U7ERGEkRPUfOC+Ua2
   +YuyZnNcg7kVojdqVqJnflEgViXePLE/YxbN1O7Py3jfkS0lNCDV5ZrZB
   5R7geNZdZpA51XTNAZwQ8U+sANqH9J7Z8ypXnAzpgqMe3U/erv6vh9nu4
   A==;
X-CSE-ConnectionGUID: wIEpAzdhSGCIIYIJVV9X/Q==
X-CSE-MsgGUID: xgwQeF8WQESD6EOchLi1OA==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="23619643"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 05:57:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 05:57:29 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 05:57:21 -0700
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
Subject: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error interrupts unmasking
Date: Thu, 18 Apr 2024 18:26:41 +0530
Message-ID: <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
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

This will unmask the following error interrupts from the MAC-PHY.
  tx protocol error
  rx buffer overflow error
  loss of framing error
  header error
The MAC-PHY will signal an error by setting the EXST bit in the receive
data footer which will then allow the host to read the STATUS0 register
to find the source of the error.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 4b0f63c02c35..850765574d30 100644
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
 #define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
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


