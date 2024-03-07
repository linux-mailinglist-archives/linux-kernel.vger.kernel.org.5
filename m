Return-Path: <linux-kernel+bounces-95176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF0874A46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810E81C21DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18C82D8F;
	Thu,  7 Mar 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mA6RNssZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA891C2A3;
	Thu,  7 Mar 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802034; cv=none; b=i/o+oAilu9nGYMSpKASCyURGKtW7p69k9ZdTt0CR41FB/xaFiWElgSI8FJpWOYpCWTeoYxx0SFHuxCNN6IZaz+yxlXdZRfatzwrwgkldVGQPvbvsOAYG+Za6wpaSqoVTf9o/4glgvbNxQ917Pabg7G0FWGYBOs+ktWjM4cKnF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802034; c=relaxed/simple;
	bh=D+XnBoUlNb13Suw1Ih1OgTg0q9gGXzYmZySZbHByTx0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kFFBhFpObAg3VcRUFV0R8hjEo+DPJTdd9Mc92qTgE95SvKaLcY9EZmYJlVHTW04znPmk8W9rb3vbsT4SfatN+CIyEhUo5NarLeDT+2HBbv5SFeu7SPA9sF3TTpaQrzUV2zEjuAsyBKJEOnfnHS6EkYcK8BtseUA/hDTHcIZB128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mA6RNssZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709802033; x=1741338033;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+XnBoUlNb13Suw1Ih1OgTg0q9gGXzYmZySZbHByTx0=;
  b=mA6RNssZ4WJ4j2tb0jwdiLPYifUrWUyxeJzJ2ORf9eQZ4tfsVtf9QhoW
   yKNVuK655QxhME9CHXYE1eh7q6FOwRYoGk1exjpSk7fGGUImCGLVcv8gp
   3reA1Hlyc1Zp4e0eVaszwbTZJlfx3b2t9I4XqShM+QuPKdLWqmBqGFwnQ
   abFPuPb5Z0nLYo1Ej5/CgfxccFNfhKPLz5aqafCAK/Ax1L2jcP2Xf4jh8
   pvKuE8Hp6sK7XCN2gjN8DxCtECc2mpWZkdiezimm3Y8z7+Kf0tbtudbCX
   ZJvAjFnKKyRLDGLz4Whi3hvNGy4NHtnVr5/c0N+FjPYVBGcr6SvdKr7fB
   w==;
X-CSE-ConnectionGUID: horeqPc5Q2+8sq6TPMg6+Q==
X-CSE-MsgGUID: MAW95ikoRainf7EPVGLaSw==
X-IronPort-AV: E=Sophos;i="6.06,211,1705388400"; 
   d="scan'208";a="248099943"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 02:00:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 02:00:21 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 02:00:18 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net] net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips
Date: Thu, 7 Mar 2024 14:28:23 +0530
Message-ID: <20240307085823.403831-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The RFE (Receive Filtering Engine) read fifo threshold hardware default should
be overwritten to 3 for PCI1x1x Rev B0 devices to prevent lockup during some
stress tests using frames that include VLAN tags.
Rev C0 and later hardware already defaults to 3.

Fixes: bb4f6bffe33c ("net: lan743x: Add PCI11010 / PCI11414 device IDs")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 17 +++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 45e209a7d083..aec2d100ab87 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3272,6 +3272,22 @@ static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 	lan743x_pci_cleanup(adapter);
 }
 
+static int pci11x1x_set_rfe_rd_fifo_threshold(struct lan743x_adapter *adapter)
+{
+	u16 rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
+
+	if (rev == ID_REV_CHIP_REV_PCI11X1X_B0_) {
+		int misc_ctl;
+
+		misc_ctl = lan743x_csr_read(adapter, MISC_CTL_0);
+		misc_ctl &= ~MISC_CTL_0_RFE_READ_FIFO_MASK_;
+		misc_ctl |= (0x3 << MISC_CTL_0_RFE_READ_FIFO_SHIFT_);
+		lan743x_csr_write(adapter, MISC_CTL_0, misc_ctl);
+	}
+
+	return 0;
+}
+
 static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 				 struct pci_dev *pdev)
 {
@@ -3287,6 +3303,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		pci11x1x_strap_get_status(adapter);
 		spin_lock_init(&adapter->eth_syslock_spinlock);
 		mutex_init(&adapter->sgmii_rw_lock);
+		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index be79cb0ae5af..be0fe52e2ae1 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -26,6 +26,7 @@
 #define ID_REV_CHIP_REV_MASK_		(0x0000FFFF)
 #define ID_REV_CHIP_REV_A0_		(0x00000000)
 #define ID_REV_CHIP_REV_B0_		(0x00000010)
+#define ID_REV_CHIP_REV_PCI11X1X_B0_	(0x000000B0)
 
 #define FPGA_REV			(0x04)
 #define FPGA_REV_GET_MINOR_(fpga_rev)	(((fpga_rev) >> 8) & 0x000000FF)
@@ -311,6 +312,10 @@
 #define SGMII_CTL_LINK_STATUS_SOURCE_	BIT(8)
 #define SGMII_CTL_SGMII_POWER_DN_	BIT(1)
 
+#define MISC_CTL_0			(0x920)
+#define MISC_CTL_0_RFE_READ_FIFO_MASK_	GENMASK(6, 4)
+#define MISC_CTL_0_RFE_READ_FIFO_SHIFT_	(4)
+
 /* Vendor Specific SGMII MMD details */
 #define SR_VSMMD_PCS_ID1		0x0004
 #define SR_VSMMD_PCS_ID2		0x0005
-- 
2.34.1


