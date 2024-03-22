Return-Path: <linux-kernel+bounces-111026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0953F88671A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C53EB21BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E3A10A17;
	Fri, 22 Mar 2024 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CdYCw9ST"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A41170D;
	Fri, 22 Mar 2024 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090151; cv=none; b=eRpQtqd6g0+EOjwtBhveQpjzCjTXoJ7W5fJFtU3A4V8+hIz9cts3PQLGAL9cNAUNDX74t0P2qaOlJk4SifDH8UDRpd/btsXSl5fpqoEcLg5zyV8/ifHe/WAHstLMt4nh2uFA3wdR9o1dGhc/skKQ0FzBoFmXhtUuTxmjpMOTXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090151; c=relaxed/simple;
	bh=USL1xcuNN0CqkFKJyTznKkqpa3nTARskndZPzGjynP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZJ2UCkh3/isNOOVVeVWuTY40hvUKk1sZvtYsizK+Ow2Qn9VZGJwR2yEatYYUSRe/40zdSCeQvexMqD/MVnB+qFDjEux3NNIDp+kQYTvi8AhUakURsGbWZ6M+f0pAQUvqvmKQAHj9QeL0S11TjjRJSRLINHU4D6GbGRML4YvGls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CdYCw9ST; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711090150; x=1742626150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=USL1xcuNN0CqkFKJyTznKkqpa3nTARskndZPzGjynP8=;
  b=CdYCw9STBLUWBWYsEFfM8ME8F+pRyRQ0NewosswRxyvTevWer+hJRKLw
   DlnfudsGIOh0bilHfTHhw6i8kjuQ6LrxZ5UnCxDrczr6BmAEHCGjp3i38
   QFra8gqrR18g+VA2rA9oVtt+yd7kt2N1YnpOptEGjPKT4gGT1D2t62LLx
   YTkPPXeWDuJdGIQ+6omfc/5YPLpbGB0u3nWoHnJH/IVGmIRdzOR5lig7Y
   nS8yAYct4svGIX8gxN0i7MHcBBIxyTkf1Jl4rn4Uq+LTbBuraP8XdZg2n
   uGYAdZ2XIISDPC0RvDJrBrEgtwwRV3auDPj7e2YG68D36MmWvpzjvb3Ru
   Q==;
X-CSE-ConnectionGUID: UAlAVOoNRT618011ioRO6A==
X-CSE-MsgGUID: pdvODhrORvuDfgE/Tynp1g==
X-IronPort-AV: E=Sophos;i="6.07,145,1708412400"; 
   d="scan'208";a="18011764"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2024 23:49:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 23:48:55 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 23:48:52 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V1] net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips
Date: Fri, 22 Mar 2024 12:16:50 +0530
Message-ID: <20240322064650.275174-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

PCI11x1x Rev B0 devices might drop packets when receiving back to back frames
at 2.5G link speed. Change the B0 Rev device's Receive filtering Engine FIFO
threshold parameter from its hardware default of 4 to 3 dwords to prevent the
problem. Rev C0 and later hardware already defaults to 3 dwords.

Fixes: bb4f6bffe33c ("net: lan743x: Add PCI11010 / PCI11414 device IDs")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
------------
V0 -> V1:
  - misc_ctl change from int to unsigned int
  - Use FIELD_PREP macro instead of logical shift operator
  - Change 0x3 to macro RFE_RD_FIFO_TH_3_DWORDS

 drivers/net/ethernet/microchip/lan743x_main.c | 20 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index bd8aa83b47e5..dca26a0734ec 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -25,6 +25,8 @@
 #define PCS_POWER_STATE_DOWN	0x6
 #define PCS_POWER_STATE_UP	0x4
 
+#define RFE_RD_FIFO_TH_3_DWORDS	0x3
+
 static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
 	u32 chip_rev;
@@ -3272,6 +3274,23 @@ static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 	lan743x_pci_cleanup(adapter);
 }
 
+static int pci11x1x_set_rfe_rd_fifo_threshold(struct lan743x_adapter *adapter)
+{
+	u16 rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
+
+	if (rev == ID_REV_CHIP_REV_PCI11X1X_B0_) {
+		u32 misc_ctl;
+
+		misc_ctl = lan743x_csr_read(adapter, MISC_CTL_0);
+		misc_ctl &= ~MISC_CTL_0_RFE_READ_FIFO_MASK_;
+		misc_ctl |= FIELD_PREP(MISC_CTL_0_RFE_READ_FIFO_MASK_,
+				       RFE_RD_FIFO_TH_3_DWORDS);
+		lan743x_csr_write(adapter, MISC_CTL_0, misc_ctl);
+	}
+
+	return 0;
+}
+
 static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 				 struct pci_dev *pdev)
 {
@@ -3287,6 +3306,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		pci11x1x_strap_get_status(adapter);
 		spin_lock_init(&adapter->eth_syslock_spinlock);
 		mutex_init(&adapter->sgmii_rw_lock);
+		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index be79cb0ae5af..645bc048e52e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -26,6 +26,7 @@
 #define ID_REV_CHIP_REV_MASK_		(0x0000FFFF)
 #define ID_REV_CHIP_REV_A0_		(0x00000000)
 #define ID_REV_CHIP_REV_B0_		(0x00000010)
+#define ID_REV_CHIP_REV_PCI11X1X_B0_	(0x000000B0)
 
 #define FPGA_REV			(0x04)
 #define FPGA_REV_GET_MINOR_(fpga_rev)	(((fpga_rev) >> 8) & 0x000000FF)
@@ -311,6 +312,9 @@
 #define SGMII_CTL_LINK_STATUS_SOURCE_	BIT(8)
 #define SGMII_CTL_SGMII_POWER_DN_	BIT(1)
 
+#define MISC_CTL_0			(0x920)
+#define MISC_CTL_0_RFE_READ_FIFO_MASK_	GENMASK(6, 4)
+
 /* Vendor Specific SGMII MMD details */
 #define SR_VSMMD_PCS_ID1		0x0004
 #define SR_VSMMD_PCS_ID2		0x0005
-- 
2.34.1


