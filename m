Return-Path: <linux-kernel+bounces-107053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952F87F6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53D6282876
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35F7D3EC;
	Tue, 19 Mar 2024 05:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Te6P2tL3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3257C6CE;
	Tue, 19 Mar 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827629; cv=none; b=q0mFVcFusxFBuTCOugQidZewdmcYncyFfTM+gXhKkxC8ykksVcGmSjYuUhOaPYTwBuU+wOLqH6cDQT6tRNqX+00ooMZucFrhmTX1AQ8xinYXxL4y8sAqMNbFAAUccLt6ywT/8P+5qzayyJKG/ZvworII3G+nRkDe2ugzYXWypM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827629; c=relaxed/simple;
	bh=PsieqNlg0izoRjsoe59ZVNJpX8rC5zYulh4OIjSqqjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocoI1/7a8V0fu0f8OpN0mB/R+YWKTP8pV9f5jJGYwfev1iH/mJdfA14b6fzjohvgon6qQ3gRKxVnpKOmWOmkEl6CZybNvgm4ry4hCluQQB10dIqQjoQoovBPUWzJHcxRi9Hfaxh6nzUQWxNvqPAzfo5XbkWoq3jF+BChM44Zf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Te6P2tL3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710827627; x=1742363627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PsieqNlg0izoRjsoe59ZVNJpX8rC5zYulh4OIjSqqjA=;
  b=Te6P2tL3f9mJP5kZI/uN5cG/3Q9pVTYhlnxM1ICiBF4MC0GnUX/MTV0B
   6cS9Mm54fTcnng/QuRJEBf1r0HJgL6sl32JPEg93EVXn+Mlus/2N3/Cyu
   gNgR/1AxCAuyAQR2eG3vczUKgvPu91HfXJ/8ExnEZp+yVc7WFGnJKACyq
   kprb/4TPTKQrpNXA4lgzOplABDHn9FpoX6GgJz+6CljsYViuieb6cb0wJ
   K0VbSUbfXxv4UXHUMqo109O+oI9K1Q5VVAJRWRSV3QysHvGzpUOcqRKVL
   a2A5aQdJq4m16tZgvfFzRut0/LKawNHQW0Q53k1C0phOvFR1CEqzDKz/8
   g==;
X-CSE-ConnectionGUID: VmcjLmElSdeXl3on+0k91w==
X-CSE-MsgGUID: 9Q9gbBK7RZu/13jyP3vR4g==
X-IronPort-AV: E=Sophos;i="6.07,136,1708412400"; 
   d="scan'208";a="19565333"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2024 22:53:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 22:53:35 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 22:53:32 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V1 3/3] net: lan743x: Address problems with wake option flags configuration sequences
Date: Tue, 19 Mar 2024 11:21:10 +0530
Message-ID: <20240319055110.764002-4-Raju.Lakkaraju@microchip.com>
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

WOL secure-on and magic packet configuration table:
--------------------------------------------------------------------------------
| Ethtool Ops     | Send magic packet | Send magic packet | Send magic packet  |
|                 |                   | with password     | with wrong password|
--------------------------------------------------------------------------------
|WAKE_MAGIC (g)   |      wake         |     wake          |        wake        |
--------------------------------------------------------------------------------
|WAKE_SECURE_MAGIC|    no wake        |     wake          |       no wake      |
|     (s)         |                   |                   |                    |
--------------------------------------------------------------------------------
| WAKE_MAGIC &    |                   |                   |                    |
|WAKE_SECURE_MAGIC|      wake         |     wake          |        wake        |
|     (gs)        |                   |                   |                    |
--------------------------------------------------------------------------------

Fixes: 6b3768ac8e2b3 ("net: lan743x: Add support to Secure-ON WOL")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
------------
V0 -> V1:
  - Fix the wake option flags configuration sequences

 drivers/net/ethernet/microchip/lan743x_ethtool.c | 3 +--
 drivers/net/ethernet/microchip/lan743x_main.c    | 8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 4899582b3d1d..442c52aa0b0e 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1188,8 +1188,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 		adapter->wolopts |= WAKE_PHY;
 	if (wol->wolopts & WAKE_ARP)
 		adapter->wolopts |= WAKE_ARP;
-	if (wol->wolopts & WAKE_MAGICSECURE &&
-	    wol->wolopts & WAKE_MAGIC) {
+	if (wol->wolopts & WAKE_MAGICSECURE) {
 		memcpy(adapter->sopass, wol->sopass, sizeof(wol->sopass));
 		adapter->wolopts |= WAKE_MAGICSECURE;
 	} else {
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 5641b466d70d..43e8e35fe9d0 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3639,9 +3639,15 @@ static void lan743x_pm_set_wol(struct lan743x_adapter *adapter)
 		lan743x_csr_write(adapter, MAC_MP_SO_LO, sopass);
 		sopass = *(u16 *)&adapter->sopass[4];
 		lan743x_csr_write(adapter, MAC_MP_SO_HI, sopass);
-		wucsr |= MAC_MP_SO_EN_;
+		wucsr |= MAC_MP_SO_EN_ | MAC_WUCSR_MPEN_;
+		macrx |= MAC_RX_RXEN_;
+		pmtctl |= PMT_CTL_WOL_EN_ | PMT_CTL_MAC_D3_RX_CLK_OVR_;
 	}
 
+	if (adapter->wolopts & WAKE_MAGICSECURE &&
+	    adapter->wolopts & WAKE_MAGIC)
+		wucsr &= ~MAC_MP_SO_EN_;
+
 	lan743x_csr_write(adapter, MAC_WUCSR, wucsr);
 	lan743x_csr_write(adapter, PMT_CTL, pmtctl);
 	lan743x_csr_write(adapter, MAC_RX, macrx);
-- 
2.34.1


