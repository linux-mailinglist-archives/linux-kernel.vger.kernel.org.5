Return-Path: <linux-kernel+bounces-127498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0B894C83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64314B23B30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9073A1C5;
	Tue,  2 Apr 2024 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IAtvSeqI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3A2BD00;
	Tue,  2 Apr 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042288; cv=none; b=ay63G4QzhoF/NTY4R9E4ye8TOzdnU9rmkihHkOi5EdyZv1sovt/oZx0peFfq8BvRu1T2xbWrZpDMHzVVfx2BV+AUiSCwHRJ4hMnvuIXYmILIpx9FlzdJzZsbA9NZf9Yzpvfc29tkbh6/o8TI3aZJiqx3i/XJBFCCfgzcw6WiqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042288; c=relaxed/simple;
	bh=AIIUnIQYVsm7lRDeuM3Eiv+P07h/G4w5XeAzewovPAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVbOwr52kg9pV0B3P1COBCX0WJdq5yLpJX90mdVS4IyDSmS2OuPZhg+yg5VBxA7MkYniTS+8eIYcYczMBAqsDUOP2Te6Sdt6PcyzvAbI0UIy6fuDPaqLdlEGwjqb/nSNcBZYYpYLtDQZkYZUsh8jrpkJqAne5bYuP5VpzJ31Drw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IAtvSeqI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712042286; x=1743578286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AIIUnIQYVsm7lRDeuM3Eiv+P07h/G4w5XeAzewovPAM=;
  b=IAtvSeqIrAM7p+VEDzBHvQ8V+w1q3OJKxgvYsZc0xu8iO7m1rIV48UHs
   6v25Bk4x6aGEqosrcMvPwjMqDt1Eoi93WkTuiN+q4IQ+cOpOG1eZ3yF8q
   fXrTBj4BBwPFKYwTjy264ybc62wT9eGvnOIQ3YeACvNGwnR+SEtEZnDkI
   gg2jhpv2fVVAUUahengX2DoMdkUjpIFdvLNsR5ZZST1KXSunRqrIXd3g/
   iHH0Ts/pUR3o6KfblnRYm8a8xaF0/EZTIQmbmNREyyP3UKswPrc66baZb
   fCp6JogOQVbJy15NGcFonl0tDCw3CzlXZb0YxFQJnhuXOWMrv3WEIP2r3
   A==;
X-CSE-ConnectionGUID: YYBWl9GrQb6mGB1zAkjL6g==
X-CSE-MsgGUID: f6W66RxjRf+27EMubxg8/A==
X-IronPort-AV: E=Sophos;i="6.07,174,1708412400"; 
   d="scan'208";a="19119228"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 00:18:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 00:17:46 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 00:17:44 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Divya.Koppera@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net] net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timestamping
Date: Tue, 2 Apr 2024 09:16:34 +0200
Message-ID: <20240402071634.2483524-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are 2 issues with the blamed commit.
1. When the phy is initialized, it would enable the disabled of UDPv4
   checksums. The UDPv6 checksum is already enabled by default. So when
   1-step is configured then it would clear these flags.
2. After the 1-step is configured, then if 2-step is configured then the
   1-step would be still configured because it is not clearing the flag.
   So the sync frames will still have origin timestamps set.

Fix this by reading first the value of the register and then
just change bit 12 as this one determines if the timestamp needs to
be inserted in the frame, without changing any other bits.

Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 8b8634600c519..242f433d9184d 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2431,6 +2431,7 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
 	struct lan8814_ptp_rx_ts *rx_ts, *tmp;
 	int txcfg = 0, rxcfg = 0;
 	int pkt_ts_enable;
+	int tx_mod;
 
 	ptp_priv->hwts_tx_type = config->tx_type;
 	ptp_priv->rx_filter = config->rx_filter;
@@ -2477,9 +2478,14 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
 	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_RX_TIMESTAMP_EN, pkt_ts_enable);
 	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_TIMESTAMP_EN, pkt_ts_enable);
 
-	if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+	tx_mod = lanphy_read_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD);
+	if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC) {
 		lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
-				      PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
+				      tx_mod | PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
+	} else if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ON) {
+		lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
+				      tx_mod & ~PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
+	}
 
 	if (config->rx_filter != HWTSTAMP_FILTER_NONE)
 		lan8814_config_ts_intr(ptp_priv->phydev, true);
-- 
2.34.1


