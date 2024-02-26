Return-Path: <linux-kernel+bounces-80730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2F866BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A812842D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F0C1CD01;
	Mon, 26 Feb 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LL8DFSe9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D01C6A0;
	Mon, 26 Feb 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935103; cv=none; b=kabkXeYmMxJFZl7tTbRQBdmwLK2UD9RwxulL+KidOUItX6ecDc9edjis0NADuG1P+2KikkZc5TZzYhqsuMYIhuekD414byRs8uRQXBR72oHmLDk2YZG4aM5hbuW7bjWVt2/YgUcofXBOk+pXPZVF4S3QPUL8k8gdJjZDLNPz+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935103; c=relaxed/simple;
	bh=pTptsFE1zpmLHWHpk+S9pqbJwSujBiWsapZPRS7ajtY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYL9CfDUjI0gBmPudknInJ0zPJQOmYEcNW5RtfnrHQKA96bfmNqT6xBP/W7PWbJ1TVDOXk5RaWu0UhVBdtos4+OpAv2o5qQBTBueNTa2QrLfeB3dVxECBcm9nwtOamOlG1ppi7zbbKRTIPwfGbfSin2pq3viLnXCokuy0vdqlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LL8DFSe9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708935102; x=1740471102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTptsFE1zpmLHWHpk+S9pqbJwSujBiWsapZPRS7ajtY=;
  b=LL8DFSe92kOXW8hWUy+x9Gjm+X6esCxGPWgpaP+D22CBwHwfKXfxrj3K
   qDXlkdoJC0i0xD4A42xmPgmOc2i7/i6ohyzRp8kh63GWF54wTYX6BwKTB
   K7K0Rbt3/PXWDiPC3s8D6LuqAYB0k0D0xE6Ydbk2j99Y566HKy7rH/hno
   ku4jDtDQRuQDpv8MOIWUJgdPEHdKJ3zSeTRelM9zhDoReOULHfzXTocVQ
   2cP3LLzz1CC8AFXjHsWjAo6YMD63EswVnq41WvjABCyDzwH0MvsPznZry
   drvFn/bMOt6t9Lwc1JVGqvm+ycLIBeaPCVZ2lm6ZqvDQKd2Id9IKmRp8U
   w==;
X-CSE-ConnectionGUID: Af2UcUQzQhuuU426y0lnaA==
X-CSE-MsgGUID: RQu3fTTERR2u/T/lyEHtyw==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="scan'208";a="247559922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 01:11:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:11:29 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 01:11:26 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <richardcochran@gmail.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net 1/3] net: lan743x: disable WOL upon resume to restore full data path operation
Date: Mon, 26 Feb 2024 13:39:32 +0530
Message-ID: <20240226080934.46003-2-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In order for datapath to be restored to normal functionality after resume
we disable all wakeup events. Additionally we clear all W1C status bits by
writing 1's to them.

Fixes: 4d94282afd95 ("lan743x: Add power management support")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 24 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h | 24 +++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 45e209a7d083..5641b466d70d 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3550,7 +3550,7 @@ static void lan743x_pm_set_wol(struct lan743x_adapter *adapter)
 
 	/* clear wake settings */
 	pmtctl = lan743x_csr_read(adapter, PMT_CTL);
-	pmtctl |= PMT_CTL_WUPS_MASK_;
+	pmtctl |= PMT_CTL_WUPS_MASK_ | PMT_CTL_RES_CLR_WKP_MASK_;
 	pmtctl &= ~(PMT_CTL_GPIO_WAKEUP_EN_ | PMT_CTL_EEE_WAKEUP_EN_ |
 		PMT_CTL_WOL_EN_ | PMT_CTL_MAC_D3_RX_CLK_OVR_ |
 		PMT_CTL_RX_FCT_RFE_D3_CLK_OVR_ | PMT_CTL_ETH_PHY_WAKE_EN_);
@@ -3685,6 +3685,7 @@ static int lan743x_pm_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	int data;
 	int ret;
 
 	pci_set_power_state(pdev, PCI_D0);
@@ -3715,6 +3716,27 @@ static int lan743x_pm_resume(struct device *dev)
 	netif_info(adapter, drv, adapter->netdev,
 		   "Wakeup source : 0x%08X\n", ret);
 
+	/* Clear the wol configuration and status bits when system
+	 * events occurs.
+	 * The status bits are "Write One to Clear (W1C)"
+	 */
+	data = MAC_WUCSR_EEE_TX_WAKE_ | MAC_WUCSR_EEE_RX_WAKE_ |
+	       MAC_WUCSR_RFE_WAKE_FR_ | MAC_WUCSR_PFDA_FR_ | MAC_WUCSR_WUFR_ |
+	       MAC_WUCSR_MPR_ | MAC_WUCSR_BCAST_FR_;
+	lan743x_csr_write(adapter, MAC_WUCSR, data);
+
+	data = MAC_WUCSR2_NS_RCD_ | MAC_WUCSR2_ARP_RCD_ |
+	       MAC_WUCSR2_IPV6_TCPSYN_RCD_ | MAC_WUCSR2_IPV4_TCPSYN_RCD_;
+	lan743x_csr_write(adapter, MAC_WUCSR2, data);
+
+	data = MAC_WK_SRC_ETH_PHY_WK_ | MAC_WK_SRC_IPV6_TCPSYN_RCD_WK_ |
+	       MAC_WK_SRC_IPV4_TCPSYN_RCD_WK_ | MAC_WK_SRC_EEE_TX_WK_ |
+	       MAC_WK_SRC_EEE_RX_WK_ | MAC_WK_SRC_RFE_FR_WK_ |
+	       MAC_WK_SRC_PFDA_FR_WK_ | MAC_WK_SRC_MP_FR_WK_ |
+	       MAC_WK_SRC_BCAST_FR_WK_ | MAC_WK_SRC_WU_FR_WK_ |
+	       MAC_WK_SRC_WK_FR_SAVED_;
+	lan743x_csr_write(adapter, MAC_WK_SRC, data);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index be79cb0ae5af..77fc3abc1428 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -60,6 +60,7 @@
 #define PMT_CTL_RX_FCT_RFE_D3_CLK_OVR_		BIT(18)
 #define PMT_CTL_GPIO_WAKEUP_EN_			BIT(15)
 #define PMT_CTL_EEE_WAKEUP_EN_			BIT(13)
+#define PMT_CTL_RES_CLR_WKP_MASK_		GENMASK(9, 8)
 #define PMT_CTL_READY_				BIT(7)
 #define PMT_CTL_ETH_PHY_RST_			BIT(4)
 #define PMT_CTL_WOL_EN_				BIT(3)
@@ -226,12 +227,31 @@
 #define MAC_WUCSR				(0x140)
 #define MAC_MP_SO_EN_				BIT(21)
 #define MAC_WUCSR_RFE_WAKE_EN_			BIT(14)
+#define MAC_WUCSR_EEE_TX_WAKE_			BIT(13)
+#define MAC_WUCSR_EEE_RX_WAKE_			BIT(11)
+#define MAC_WUCSR_RFE_WAKE_FR_			BIT(9)
+#define MAC_WUCSR_PFDA_FR_			BIT(7)
+#define MAC_WUCSR_WUFR_				BIT(6)
+#define MAC_WUCSR_MPR_				BIT(5)
+#define MAC_WUCSR_BCAST_FR_			BIT(4)
 #define MAC_WUCSR_PFDA_EN_			BIT(3)
 #define MAC_WUCSR_WAKE_EN_			BIT(2)
 #define MAC_WUCSR_MPEN_				BIT(1)
 #define MAC_WUCSR_BCST_EN_			BIT(0)
 
 #define MAC_WK_SRC				(0x144)
+#define MAC_WK_SRC_ETH_PHY_WK_			BIT(17)
+#define MAC_WK_SRC_IPV6_TCPSYN_RCD_WK_		BIT(16)
+#define MAC_WK_SRC_IPV4_TCPSYN_RCD_WK_		BIT(15)
+#define MAC_WK_SRC_EEE_TX_WK_			BIT(14)
+#define MAC_WK_SRC_EEE_RX_WK_			BIT(13)
+#define MAC_WK_SRC_RFE_FR_WK_			BIT(12)
+#define MAC_WK_SRC_PFDA_FR_WK_			BIT(11)
+#define MAC_WK_SRC_MP_FR_WK_			BIT(10)
+#define MAC_WK_SRC_BCAST_FR_WK_			BIT(9)
+#define MAC_WK_SRC_WU_FR_WK_			BIT(8)
+#define MAC_WK_SRC_WK_FR_SAVED_			BIT(7)
+
 #define MAC_MP_SO_HI				(0x148)
 #define MAC_MP_SO_LO				(0x14C)
 
@@ -294,6 +314,10 @@
 #define RFE_INDX(index)			(0x580 + (index << 2))
 
 #define MAC_WUCSR2			(0x600)
+#define MAC_WUCSR2_NS_RCD_		BIT(7)
+#define MAC_WUCSR2_ARP_RCD_		BIT(6)
+#define MAC_WUCSR2_IPV6_TCPSYN_RCD_	BIT(5)
+#define MAC_WUCSR2_IPV4_TCPSYN_RCD_	BIT(4)
 
 #define SGMII_ACC			(0x720)
 #define SGMII_ACC_SGMII_BZY_		BIT(31)
-- 
2.34.1


