Return-Path: <linux-kernel+bounces-29930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC8831553
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694792826D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C101D6B1;
	Thu, 18 Jan 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pU63cNW7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E59B67F;
	Thu, 18 Jan 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568473; cv=none; b=ognUplARBwj6K1Yb0C7yvpQNamBxGF/h3oNuL+ZbBG+/opHYQFuPtqMWi7JRwbvFYBc4bBIhYwXPkBGWJUll8hKP4CT+Rx3gxJrHzFV/n3YrzZxnu/2TPdTRMOdUHMbbWL2P5dqNXIqSBDRJI42CjAHK/whmSDOull5J/A12CFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568473; c=relaxed/simple;
	bh=Ld6RsfNIaz/8+TtpxEvIIJRnPwyhGqi02sHOhzjxcbc=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type; b=oKriUjOjVXO9Kdtlx7XXhmAKgr1GYXi0yjqjGZFQ0ySiBTRx8zrGD1HrNh9r7OYJtb4dEAT7trwW+DGakk/mC6g6hDMVzwQCviI7G9KyTc5sk6VaBEyWGQ31iTrCNegtVVySpVJXKtkN0Qlx8yMBm5l3xoeiVGvsLqBRfGMN7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pU63cNW7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705568472; x=1737104472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ld6RsfNIaz/8+TtpxEvIIJRnPwyhGqi02sHOhzjxcbc=;
  b=pU63cNW7AVd5uMukEGzS37dkBdyE7hbPG+kheJnBFCipCiFXBM1stGF1
   xVIbv5QfdgzzrCWODhjf8coNZDcgPa8mB1bDzPHWdEdGbHswK8dx3ou91
   YGpS6i4oAZ+bNTx+NUIlCU0pIJJZzXuoomA+7447G+Kz/wpU87PqdANA5
   IeaD6chQ0VcAoDGByVE/qQfjyerueESbnSd432g2yhB+v3YWMl/escxmz
   NjQVFNSEwcRP8khreey1kzgEw44MD9P3SoT+McXCsg9pRttEPLi1YztML
   P6tiGiAE/J7+C3VoKYj+q8Disj/MU1tedxbytsuza9eL0aIrDmceI+HBO
   w==;
X-CSE-ConnectionGUID: n0a0VLI/Teas7dS+uYillw==
X-CSE-MsgGUID: Hz6zI3csRWy2iPbctXht7g==
X-IronPort-AV: E=Sophos;i="6.05,201,1701154800"; 
   d="scan'208";a="245650038"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2024 02:01:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 02:00:50 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 02:00:47 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Divya.Koppera@microchip.com>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Divya Koppera <divya.koppera@microchip.com>
Subject: [PATCH net v2 1/2] net: micrel: Fix PTP frame parsing for lan8814
Date: Thu, 18 Jan 2024 09:59:15 +0100
Message-ID: <20240118085916.1204354-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
References: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The HW has the capability to check each frame if it is a PTP frame,
which domain it is, which ptp frame type it is, different ip address in
the frame. And if one of these checks fail then the frame is not
timestamp. Most of these checks were disabled except checking the field
minorVersionPTP inside the PTP header. Meaning that once a partner sends
a frame compliant to 8021AS which has minorVersionPTP set to 1, then the
frame was not timestamp because the HW expected by default a value of 0
in minorVersionPTP. This is exactly the same issue as on lan8841.
Fix this issue by removing this check so the userspace can decide on this.

Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/micrel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index bf4053431dcb3..43520ac0f4e00 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -120,6 +120,11 @@
  */
 #define LAN8814_1PPM_FORMAT			17179
 
+#define PTP_RX_VERSION				0x0248
+#define PTP_TX_VERSION				0x0288
+#define PTP_MAX_VERSION(x)			(((x) & GENMASK(7, 0)) << 8)
+#define PTP_MIN_VERSION(x)			((x) & GENMASK(7, 0))
+
 #define PTP_RX_MOD				0x024F
 #define PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_ BIT(3)
 #define PTP_RX_TIMESTAMP_EN			0x024D
@@ -3150,6 +3155,12 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_IP_ADDR_EN, 0);
 	lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_IP_ADDR_EN, 0);
 
+	/* Disable checking for minorVersionPTP field */
+	lanphy_write_page_reg(phydev, 5, PTP_RX_VERSION,
+			      PTP_MAX_VERSION(0xff) | PTP_MIN_VERSION(0x0));
+	lanphy_write_page_reg(phydev, 5, PTP_TX_VERSION,
+			      PTP_MAX_VERSION(0xff) | PTP_MIN_VERSION(0x0));
+
 	skb_queue_head_init(&ptp_priv->tx_queue);
 	skb_queue_head_init(&ptp_priv->rx_queue);
 	INIT_LIST_HEAD(&ptp_priv->rx_ts_list);
-- 
2.34.1


