Return-Path: <linux-kernel+bounces-132646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085198997B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02851F22F4A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFBC146D6B;
	Fri,  5 Apr 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zQ3UPNL9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6EB13D265;
	Fri,  5 Apr 2024 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305468; cv=none; b=pru6Ti4CoBTJLq7UxTNpc2+7CZHWSfHv2sYIwxtVhmQ610hZtLfjJUfAp5qMTr1mvJQvpp5qijNQLj3sXb7TY0LRXivyq79VVSNeez/ie4BdzLQujJCAJyOtS4VxG6x1xftqG/L8AwaPwg8QnH01p5TL1DWs+XJus6lqn2ejP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305468; c=relaxed/simple;
	bh=DzJt3JO6N4/Hug8KwwkC2DWR+jugi7s05NsH/Kwqkjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTHTitevmjifTa5XWVoSr8Y/6uXbtHyhfuG5Sswx/7blMb9LZnVVRB9vmmTllejrwHB0+k54B71DcRskBFyKVufZZcTlLLWAd8ePaUlDH9CbBWgDLo5dzyLBD7Tdo4JtBa0sMYUZFqeIoBklw0hO3i+ad4zrEWTbUaMAPafI55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zQ3UPNL9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712305466; x=1743841466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DzJt3JO6N4/Hug8KwwkC2DWR+jugi7s05NsH/Kwqkjs=;
  b=zQ3UPNL90Trnbdx8XZ+HCvFP83U26yEJguSsb36t8wBd8bQbKzWBVaqg
   gbp3X49mB0vNEiONypqip7jmAq20hHQbMbsmxAEYL/iJCn5LT4mBpPqR1
   KkxXOJQkbImu6x/qTP8+tEPvmHjnSIBvVeGDeBYmnlEnCkvUY9IpoGKEQ
   3ljpxJssLDR3zPtyrdhteheREewXPK3tNgJALL5W63yYWn0N/+DN6oX4q
   ZbdTh0lelm14RAJA9TxV/5ag+qVOdXw0xEALPJmicFhjns9QL44OqZlQI
   JYhC7sHib+kQuoP4x439Myl+VI/Xrbf56Z1+/UzrQiNBqurRDKEEj6Pwh
   w==;
X-CSE-ConnectionGUID: YjdtRCXQQq6Hp7xbmZIMzw==
X-CSE-MsgGUID: opf844VCTsyN4dCdsM2HAg==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="20152815"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 01:24:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 01:24:08 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 01:24:05 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 1/2] net: phy: micrel: lan8814: Enable LTC at probe time
Date: Fri, 5 Apr 2024 10:22:56 +0200
Message-ID: <20240405082257.1552821-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405082257.1552821-1-horatiu.vultur@microchip.com>
References: <20240405082257.1552821-1-horatiu.vultur@microchip.com>
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

Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 8b8634600c519..75dcd8bae78d8 100644
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
@@ -2486,20 +2479,6 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
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
@@ -3230,6 +3209,9 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
 			      PTP_OPERATING_MODE_STANDALONE_);
 
+	/* Enable ptp to run LTC clock for ptp and gpio 1PPS operation */
+	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_ENABLE_);
+
 	return 0;
 }
 
-- 
2.34.1


