Return-Path: <linux-kernel+bounces-134850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E689B7D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF311B21E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513022F19;
	Mon,  8 Apr 2024 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c1GYjx4m"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882F1773A;
	Mon,  8 Apr 2024 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558741; cv=none; b=ZvMcUptYU0Dch1Bp7+06aD3N5ylHgkhOaWe38W5Snw0gKNSGfH48pqgYLqlAZHYQA8v5bddV/CwHqfI+KsCECVo87aU/+fMtOSSYlJaphOp5veul7BYn25MnFeRlwh9lPh02C/9F3EmN/uRXCenAHyLEY+BtUzTCb20w14984cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558741; c=relaxed/simple;
	bh=5cljssqgF8Xi6txX9Pg95qFbEB+MjKFhcNKVrAooKRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNXTajwjdq0ZVEvVi4yDQTLc0MSM8omI8yQu21UDXs7EdgLHgZgO6P9PoZCSaRf4k4oYe86Gw0voQQJmQ6Nk/rusUMLCFvejNrlp6Q0yg3D1byeRI9xJGIW/dBIpDGDUnSTkVTaRcRQpnW6mVFlnQyZNgPBiNIQhXRmHO+HRMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c1GYjx4m; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712558739; x=1744094739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5cljssqgF8Xi6txX9Pg95qFbEB+MjKFhcNKVrAooKRI=;
  b=c1GYjx4mnVe7wb7evp3nemNkwycw/cdKcuOvvyn54WWaC9iA66bRz2D9
   yEGItGHW9JD3uy95wFGt+pjuARLel0HReFSZp98vqu7INCm9A8eQ3B2ud
   nTfjKfRqsFY+4MLNsperZWFPCU2zWSkEvImSMiwuSCx78Ezw6Yj52f6oC
   Kjoeg/1GJGquZKFWxHG78yevZqkCU+2+Fp5IS+cPJYAxDkgs1AR3RDT2R
   5Ul+B7VFZjYwvzSRYWDjeZjwO4J2yUuhjFbygW48njWbimD5tMlzpQE+7
   d7Rr5NkLpgsMcwIHCYWvY4pWWnAIlOlqn8m22I0qXXcMulr8ox0AHj65h
   Q==;
X-CSE-ConnectionGUID: 2+TP0aPMR5me/Arb7xwZJg==
X-CSE-MsgGUID: zqJ+b19PT/udMiGnEEjroA==
X-IronPort-AV: E=Sophos;i="6.07,186,1708412400"; 
   d="scan'208";a="250762789"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2024 23:45:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 23:45:16 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 23:45:14 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<divya.koppera@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 1/2] net: phy: micrel: lan8814: Enable LTC at probe time
Date: Mon, 8 Apr 2024 08:44:31 +0200
Message-ID: <20240408064432.3881636-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408064432.3881636-1-horatiu.vultur@microchip.com>
References: <20240408064432.3881636-1-horatiu.vultur@microchip.com>
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
index ddb50a0e2bc82..8ed088e35da85 100644
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
@@ -3247,6 +3226,9 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
 			      PTP_OPERATING_MODE_STANDALONE_);
 
+	/* Enable ptp to run LTC clock for ptp and gpio 1PPS operation */
+	lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL, PTP_CMD_CTL_PTP_ENABLE_);
+
 	return 0;
 }
 
-- 
2.34.1


