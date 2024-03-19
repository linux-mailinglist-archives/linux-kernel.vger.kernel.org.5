Return-Path: <linux-kernel+bounces-107052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9C87F6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B53D1F225A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6897CF26;
	Tue, 19 Mar 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j2Q3ISZN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284E53378;
	Tue, 19 Mar 2024 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827627; cv=none; b=vCuK3hAg7AE5Y7jKS4ZOGT8ZJCd6AQK7VchWnBXQ4shzTP29FGRwjgP8UuxeIQp3o5Av5rSXKxJcD3jLskltJN1RzxxWYNY4aiOte0Rdjqkop7HuItsd8D7UBCqZDHc9BzrX1ab4s1fxv57UO2Cm5WA1yRMv1nHzXukOiXyD+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827627; c=relaxed/simple;
	bh=C1KTS43iNb7xCJMeLZHV/iIX5f8wXoKRqUfcQWPIpVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtqUKkL3emuYKJBLtcoG84nUXjmGK1FouJbZ49k/1bfxmyTdWhRBfSmbx4IQWMKk5DU2Vjb3S2FCXPUOhG60jTeNR7Iw0Kp8rGNRO6aBP+5ITlwQO8qqAMRSsF+xjVFtUPP8D7nyfG01xNAQYhgg/v/W3pe01W3HS6ClqONVvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j2Q3ISZN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710827625; x=1742363625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C1KTS43iNb7xCJMeLZHV/iIX5f8wXoKRqUfcQWPIpVg=;
  b=j2Q3ISZN6LpZxcIfejtGpep1Kx5/XtD2AEu5PpJB296KS8+04SwIVhaX
   PDS88IxUnslPrgm50d0rEsuCFfVwYrTJwvDHna3F0p7ZI6BtIx0ib08P8
   UEmSezsWI0kRANsx7lptr3OEzFH4a1B3n48nsgL4hOkljVmrSQwk0Ie/E
   2R3Q83F+Cjmmc29Re3/OSQP1IR6hunHWWbFWPvpsrjckMjZJADKkBvMg5
   e8Jp+XbxfTrWaagfskjANY/YFzNGrxQsGT1rDx17mCIzL1AYz8DjjVW5z
   P2W9lm4b8b5nFGLK8ibIXjA6qBfS3i9Y26FwOS/mgkkgUSZxaJo9e5TGC
   Q==;
X-CSE-ConnectionGUID: VmcjLmElSdeXl3on+0k91w==
X-CSE-MsgGUID: XBVubKrHSiG17DUa7pipdQ==
X-IronPort-AV: E=Sophos;i="6.07,136,1708412400"; 
   d="scan'208";a="19565327"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2024 22:53:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 22:53:31 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 22:53:28 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V1 2/2] net: lan743x: support WOL in MAC even when PHY does not
Date: Tue, 19 Mar 2024 11:21:09 +0530
Message-ID: <20240319055110.764002-3-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319055110.764002-1-Raju.Lakkaraju@microchip.com>
References: <20240319055110.764002-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Allow WOL support if MAC supports it, even if the PHY does not support it

Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
------------
  - Change the "phy does not support WOL" print from netif_info() to
    netif_dbg()

 drivers/net/ethernet/microchip/lan743x_ethtool.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 8a6ae171e375..7509a19269c3 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1163,6 +1163,17 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 				   struct ethtool_wolinfo *wol)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	int ret;
+
+	if (netdev->phydev) {
+		ret = phy_ethtool_set_wol(netdev->phydev, wol);
+		if (ret != -EOPNOTSUPP && ret != 0)
+			return ret;
+
+		if (ret == -EOPNOTSUPP)
+			netif_dbg(adapter, drv, adapter->netdev,
+				  "phy does not support WOL\n");
+	}
 
 	adapter->wolopts = 0;
 	if (wol->wolopts & WAKE_UCAST)
@@ -1187,8 +1198,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 
 	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
 
-	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
-			: -ENETDOWN;
+	return 0;
 }
 #endif /* CONFIG_PM */
 
-- 
2.34.1


