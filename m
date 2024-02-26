Return-Path: <linux-kernel+bounces-80731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC25A866BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E27281ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C91CD1B;
	Mon, 26 Feb 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qBZnUCsK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C491C6B9;
	Mon, 26 Feb 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935104; cv=none; b=uvRxYOY5CxbyAXiMottH2EzQAq6IY2cG1UIT1m5Nfx0HZiqgpbzxerBUpEPvDG7bt/4EVTfrHUsVnEX28UP24n/5sA5UwFXOc1kYdcLptVtKVlQsfCfhNO50gRib593S9MbuLFdQ2wU+jKE8WMWL9GVgZhgT01SK0FIF7eoywO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935104; c=relaxed/simple;
	bh=lyIH/iR0IvIHyZ54d9mVMoKqHxpDbkSiGX45uKepstw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmhO+9o1R/K08SNmSY9rPu6P+3/zkUhvATocd0Kxb2+GGp+JDIu+AefP+m6xPD+DHD5zEynNRyRAAvRg550mcfbOZECyk12jgyX543VzhJNTksj0PwrlO92SkahmtWAXA52cJBlQ0aCPX1LkHrGrnIr2HFJBnsjsWvfklfsY+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qBZnUCsK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708935103; x=1740471103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lyIH/iR0IvIHyZ54d9mVMoKqHxpDbkSiGX45uKepstw=;
  b=qBZnUCsKO+XJpqvKDngomdZSfMhBWqP7cdqEwNmBvGJAim9/yE+UDENv
   1h5+PaFw6gor03n/qv4n27tKnlvmIZY8QtC3kuO8K4y8fw22qYNSTFyNe
   GEIdLDxzknNwEanIcHUWX117q5ld2Wg4TlSKLDitxMXAVzJHg5u6LsXN5
   oGECXIPt6Xbq0BCsvLO1XPE3F5j5XJvajzN1q6URyB/HxPmU8CnWvB5gV
   sChuEzhBNv6kMbQRgTvFVPecDxWZA6lnJEJGUVH6anii707YFVDPGge5X
   zxl6HFBTYGfu530HG8bA8jhsdAmTcrveZgXqiCGZvxiT7rzIf9QSUS77U
   A==;
X-CSE-ConnectionGUID: Af2UcUQzQhuuU426y0lnaA==
X-CSE-MsgGUID: 22CCoZfJTlWOgv32FyoUxg==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="scan'208";a="247559925"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 01:11:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:11:35 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 01:11:32 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <richardcochran@gmail.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net 3/3] net: lan743x: Address problems with wake option flags configuration sequences
Date: Mon, 26 Feb 2024 13:39:34 +0530
Message-ID: <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
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

Wake options handling has been reworked as follows:
a. We only enable secure on magic packet when both secure and magic wol
   options are requested together.
b. If secure-on magic packet had been previously enabled, and a subsequent
   command does not include it, we add it. This was done to workaround a
   problem with the 'pm-suspend' application which is unaware of secure-on
   magic packet being enabled and can unintentionally disable it prior to
   putting the system into suspend.

Fixes: 6b3768ac8e2b3 ("net: lan743x: Add support to Secure-ON WOL")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_ethtool.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 4899582b3d1d..cda4df2ac1cd 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1165,6 +1165,16 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 	int ret;
 
+	if (wol->wolopts && wol->wolopts != adapter->wolopts &&
+	    adapter->wolopts & WAKE_MAGICSECURE) {
+		wol->wolopts |= WAKE_MAGICSECURE;
+		netif_warn(adapter, drv, adapter->netdev,
+			   "Ensure secure-on magic packet remains enabled if not explicitly disabled\n");
+	}
+
+	if ((wol->wolopts & WAKE_MAGICSECURE) && !(wol->wolopts & WAKE_MAGIC))
+		return -EINVAL;
+
 	if (netdev->phydev) {
 		ret = phy_ethtool_set_wol(netdev->phydev, wol);
 		if (ret != -EOPNOTSUPP && ret != 0)
-- 
2.34.1


