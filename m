Return-Path: <linux-kernel+bounces-80732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 360FF866BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8517BB22691
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99CC1CFBE;
	Mon, 26 Feb 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0CeLspdw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99EB1CA9C;
	Mon, 26 Feb 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935105; cv=none; b=t+6Q2CwCgEtFBDekf+h24HiU2BwtK6mfHgMM0CY55SxtY7rAV5tY6eSUvz4nWuq+lQK7YmODrmczPt3QZyKLDs1s4ESPHlSgZ4K+GPHSYUQ4eM4ZsvTCZgTOWnthY5PnOFBBXqsJmQFL/2AdgrViRYLb2Tf1oLL49EpqurJtn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935105; c=relaxed/simple;
	bh=l1szuv+hM027uh7ebfrh0DP41MYlcjkvn+YrDlbSB00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/wU2WnRVsQR2WThI0ERKeL7RUQhIe2RdARamXeKgLJaEplv6Jd6uJTF6aM2Qmft+mJ06c39hah1FUHBNDQ2Ki7goK28VFCjikD7INmVMf3eMuTzT/E30SiBL3lofbPU/gchllF+J+oFMcMfcwN+si7oS6rRsCu0UQCFBMOYios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0CeLspdw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708935104; x=1740471104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1szuv+hM027uh7ebfrh0DP41MYlcjkvn+YrDlbSB00=;
  b=0CeLspdwYAdXaULECrC9NCV/eE09mIKtZ3ta/LP8CBudH/66p6nnuZ0L
   R2dc8w5KdoyUF2du7n1vNUKHdKGdOHulDcx9xWvg5bOiE5ICPYsrrkiPG
   HClIe8nIOg4xKcAoDbJpaytt/UTv4YdchScH5PeSRsxfQc7oZelhnaB9A
   cyG4NiFH8k3IJLz2lKrPFi9Cyr9CxfLO5TWATmGbqaddUQF4Rp1/S7ZIt
   C3Xct6zFcKPsF8dwzWHOl2PzFdZ4J0mxUdPEOOPq0o0hBvD1sYOLA189P
   FrI1S/hTdXCE+FB2LEIseg1FPB+W0PsuqknHy6dLo6Sf0FjCkDiXIZdtD
   g==;
X-CSE-ConnectionGUID: 4ynsao6ZS2GCwmDsGpJRvQ==
X-CSE-MsgGUID: Y91qGN6RS+mCUHsn5fFwMQ==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="scan'208";a="247559931"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 01:11:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:11:32 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 01:11:29 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <richardcochran@gmail.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net 2/3] net: lan743x: support WOL in MAC even when PHY does not
Date: Mon, 26 Feb 2024 13:39:33 +0530
Message-ID: <20240226080934.46003-3-Raju.Lakkaraju@microchip.com>
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

Allow WOL support if MAC supports it, even if the PHY does not support it

Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference
with bare card")

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_ethtool.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index a2b3f4433ca8..4899582b3d1d 100644
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
+			netif_info(adapter, drv, adapter->netdev,
+				   "phy does not support WOL\n");
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


