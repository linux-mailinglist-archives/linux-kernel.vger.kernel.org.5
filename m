Return-Path: <linux-kernel+bounces-131077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BA88982C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F8D28C36B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CD6BB50;
	Thu,  4 Apr 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jr50Dm37"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EE5D734;
	Thu,  4 Apr 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217887; cv=none; b=Lpgxv7msAo84AddjggaXRGouSeNhFt0Ve0VFqz1G3iy3STo4WDR0WEsHJYDyg/Z1vXcsZTSCFYKIO2e9NGrRyq8tEGxp8Nc73jy4T08UnNMmuffrCm0AQw4Zvs/kMVCkbb9SCkML3vrxln4W85mtYpgUXtDFaPmftC34F20F/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217887; c=relaxed/simple;
	bh=gdTOoPuOriYmEIVSVbX3YDpxiCB3rTIMktnWhNxu07g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=My/57qbz4YriCzx0gD72ZHy3BAx/4UMjEocTWSyj12zmnl/U+m2vE5V7RnGl8wrtQqU+gpqbAbjWYdvBls+GS+nJ79sBwV6T37ju+PVKVs9lOzwLXonPmKgrseR9tG3wOGx59vV/QK9ka3E6LML18gEOIyZ2VNisw92hALtuavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jr50Dm37; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712217886; x=1743753886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gdTOoPuOriYmEIVSVbX3YDpxiCB3rTIMktnWhNxu07g=;
  b=Jr50Dm37h72c+KpUTSqoVrfeHHNRRsvpnbi+OutOm+oiV82OjH/DJ7P4
   lgaTvXWJ2g2A7kHiigMIrp7q9aZEme23Z4sNwt710FRje1tatQeOPkbzl
   CrWAUP2tbezsTEy4iALZGY4o6wF//4zHbzpAO7CsOuwvfAgBdhHnS78rg
   uh2mXiHIXFfAA9i1rfubrHXX2ISVHGFLeJ8eW01NJ//8OVD0SQ+Bf5y2X
   9Ws0G8sXgX8VE1hQ6r/DqKX1Z5/wFsfhcIeSx5qSqnvAcesmii7JB+czV
   9pT0WYfDfGjh5vV/iuME2blTxvmMgZ9384Cu9l6+M0Z6QEeu7tFlU/L7A
   g==;
X-CSE-ConnectionGUID: dlpw0rggR4WYgOJDui2PAg==
X-CSE-MsgGUID: zIrWsFM/SRGghGD8UNThoQ==
X-IronPort-AV: E=Sophos;i="6.07,178,1708412400"; 
   d="scan'208";a="186710221"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 01:04:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 01:04:34 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 01:04:32 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 1/2] net: phy: micrel: lan8814: Enable LTC at probe time
Date: Thu, 4 Apr 2024 10:01:14 +0200
Message-ID: <20240404080115.450929-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404080115.450929-1-horatiu.vultur@microchip.com>
References: <20240404080115.450929-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The LTC for lan8814 was enabled only if timestamping was enabled,
otherwise it would be stopped. Meaning that LTC will not increase by
itself. This might break other features that don't required timestamping
like generating 1PPS. Therefore enable the LTC at probe time.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 242f433d9184d..51ca1b2b5d99a 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -305,12 +305,7 @@ struct lan8814_shared_priv {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
 
-	/* Reference counter to how many ports in the package are enabling the
-	 * timestamping
-	 */
-	u8 ref;
-
-	/* Lock for ptp_clock and ref */
+	/* Lock for ptp_clock */
 	struct mutex shared_lock;
 };
 
@@ -2426,8 +2421,6 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
 {
 	struct kszphy_ptp_priv *ptp_priv =
 			  container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
-	struct phy_device *phydev = ptp_priv->phydev;
-	struct lan8814_shared_priv *shared = phydev->shared->priv;
 	struct lan8814_ptp_rx_ts *rx_ts, *tmp;
 	int txcfg = 0, rxcfg = 0;
 	int pkt_ts_enable;
@@ -2492,20 +2485,6 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
 	else
 		lan8814_config_ts_intr(ptp_priv->phydev, false);
 
-	mutex_lock(&shared->shared_lock);
-	if (config->rx_filter != HWTSTAMP_FILTER_NONE)
-		shared->ref++;
-	else
-		shared->ref--;
-
-	if (shared->ref)
-		lanphy_write_page_reg(ptp_priv->phydev, 4, PTP_CMD_CTL,
-				      PTP_CMD_CTL_PTP_ENABLE_);
-	else
-		lanphy_write_page_reg(ptp_priv->phydev, 4, PTP_CMD_CTL,
-				      PTP_CMD_CTL_PTP_DISABLE_);
-	mutex_unlock(&shared->shared_lock);
-
 	/* In case of multiple starts and stops, these needs to be cleared */
 	list_for_each_entry_safe(rx_ts, tmp, &ptp_priv->rx_ts_list, list) {
 		list_del(&rx_ts->list);
@@ -3236,6 +3215,9 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
 			      PTP_OPERATING_MODE_STANDALONE_);
 
+	/* Enable ptp to run LTC clock for ptp and gpio 1PPS operation */
+	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_ENABLE_);
+
 	return 0;
 }
 
-- 
2.34.1


