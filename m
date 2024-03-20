Return-Path: <linux-kernel+bounces-108426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4C880A59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDF31F22738
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EFE17578;
	Wed, 20 Mar 2024 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1l4KoSOl"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6A1125B4;
	Wed, 20 Mar 2024 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710908639; cv=none; b=Thg5JzDN4Z0LNmG2tUD40oKck9ueqk/RUGrfgw5CKTwEZ5KHko1dXGUQlgivqU79yum7oAop2v32P1thf8x5+PjM0KrhoXzSck/EehKY4GjNzk7opN4c97IAovmbsoLNiI12ekUla43P/g0PikmPoDd/JWFgZEmXo9S2BmrzFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710908639; c=relaxed/simple;
	bh=a9vk03hNsTjcx8GvEOxNTYnV0dld9yAXOB3booaeIag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsHeZnVFkld/TpfzPyOnWw9MQUnPYhZS65HCWgIA8Ddgk7baOunabvsjIQwyOe5mMcfmLIcoAKfugintj47qWjC3oE40nzUAO97xGgOnbtw68k86jdu8U8SXWI/fmPbX1C0iKZkKhvLUsLuwreSjztBSJbUAROjBxQ9hRGD1Mgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1l4KoSOl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710908638; x=1742444638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a9vk03hNsTjcx8GvEOxNTYnV0dld9yAXOB3booaeIag=;
  b=1l4KoSOl4SVbEEO5FTngXq/96BZmhxtLbJ0baJcgopm9YoEYdRVDPdL+
   VIDpiNIMcxZtYVtCuhmm9GHiR/nYMaq6E5vnDNtVkyxANNHBJkTMj0iB9
   eXBKbkbpO2vuZcXoSEAf5ZioqQxvoNXyWVp5kXSmPpTPkDzmX9F2cbHhi
   pl176/IrL0MbKFKA2Mex+BGMGt6MvK3SK4OJpolbewKCwDoOzCtAUrkn1
   FWtBv5asrgEtf3Q6bysMRgAsvRiC5XjmEkh4quSwmvyZ0YSZdq7Nd7CJ3
   vWFqCX/C+U6R8vHCmaDD3duFjl41EcuLsQLWrrVqwLlsz0iMOEO4LT2dV
   Q==;
X-CSE-ConnectionGUID: OBzKC0jNRNK2Qzt8Vawdqg==
X-CSE-MsgGUID: YFt001kqS6ykjhBIcO/FVg==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="248652320"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 21:23:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 21:23:46 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 21:23:43 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when PHY does not
Date: Wed, 20 Mar 2024 09:51:07 +0530
Message-ID: <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
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

Allow WOL support if MAC supports it, even if the PHY does not support it

Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
------------
V1 -> V2:
  - Repost - No change
V0 -> V1:
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


