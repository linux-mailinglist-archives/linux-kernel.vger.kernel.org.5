Return-Path: <linux-kernel+bounces-108425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A9D880A57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89CD1B217CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659751428F;
	Wed, 20 Mar 2024 04:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z6VfUXrP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A014284;
	Wed, 20 Mar 2024 04:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710908637; cv=none; b=a1oNxnBNftqmXOAPbcjNfaDE9qHBwGF9XbMDqTnkB8vqqTgNrGHCsArOHHfhYQuRdmb/gndX8XUMtqYHVKcp1/t8CEA84RoYQy4Jvut1C0f+QaDJm9DjJU+ICD0ueoTlPakKDDTauXfH/IM9iwL+6ZL0dDT+QdMEJgPpFQV4AP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710908637; c=relaxed/simple;
	bh=LcOww6/eiIAjFAXdkIxWRaMvBiTiVEhE5UU/u2UYRBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/8BfoNKpUFgZBxzCmRdetzAMfjiPxozxQs/BixCcxEduA79kwIxug5DZcymsh/eNzCTl/W7bc9WRiLEzg1vkovlvri07HnbdQVnCsgR4Yac9LgoYfrKV0MrcSfjx5UdLdVRuRlEg0c5UftVD1AclVTdhbb7eEUbCq+rSS1EHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z6VfUXrP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710908636; x=1742444636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LcOww6/eiIAjFAXdkIxWRaMvBiTiVEhE5UU/u2UYRBg=;
  b=z6VfUXrPl1mw0znkoqD+oY3eLfi05fru1R7pz2ynLEYVruyqNtRmI/P0
   jvgxcIVInG6s1hdBLTwpnjrm2f/z2aFLWqTfugrmjMPxGnyPVLXDsUBYi
   XeNfMBRh4XLqVDhBgr7exYl5N7ArjSBtKxeY858z5Cy4sYRfdJH+y3p/K
   7tcYzJjLJvJqk4FtLB41l+sLp6lohozvVMayB68FgdXLxBsHBXNE61iWR
   HI6akuIerXU9tPa+bsKBUknfJAMAqkpLbRCVBoDpB+mGP3nkmoTgdbr7Q
   6HoQ9z2KxZYBw1PHZTn3d0PdvWh+B5C2IoV/lJoQNDCVPWGYx4Tzi2JNE
   g==;
X-CSE-ConnectionGUID: OBzKC0jNRNK2Qzt8Vawdqg==
X-CSE-MsgGUID: ExH+BKYhQ8SBl2LQfU/pPA==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="248652319"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 21:23:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 21:23:41 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 21:23:38 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V2 1/2] net: lan743x: disable WOL upon resume to restore full data path operation
Date: Wed, 20 Mar 2024 09:51:06 +0530
Message-ID: <20240320042107.903051-2-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
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
Change List:
------------
V1 -> V2:
  - Repost - No change
V0 -> V1:
  - Variable "data" change from "int" to "unsigned int"

 drivers/net/ethernet/microchip/lan743x_main.c | 24 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h | 24 +++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index bd8aa83b47e5..385e9dcd8cd9 100644
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
+	u32 data;
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


