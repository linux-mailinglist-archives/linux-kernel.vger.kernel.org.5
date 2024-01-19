Return-Path: <linux-kernel+bounces-31055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A5832828
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87C4B23B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B84D10C;
	Fri, 19 Jan 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B3bdiBTh"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73D3C6BF;
	Fri, 19 Jan 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661356; cv=none; b=CiUSHCFnR3QufiR+rQNgLk6Ypn8IqPOOntfVA9rAYQxpwRe4HRMlUSatm6/dZGLnGZ49OPEDHpwQXD7FK80D8hReLTNnNj7ej2fjXifjSFj/X/a7gHCBJbY+bu7t9YBTePxbAQLEVLzW0EYqMBpmAGtwTQCpIw7EkhIVrqWuQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661356; c=relaxed/simple;
	bh=OD42keRteXfeJNfHf9czpfOXSgZwqxy+OazuqeDsJr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ls6uRG0B6op2I82VjtpEgCyq3oASML54pLmfkbxog0a8Uf+xJE269r5iT8iDFetw3yj06rIbZT1MXEXE8XdeNHwJhCgYkJ8g2ML+Jor+VtKi930fGnLkQrRpeLJ9rPtjwruBUKx8OIanMF5xgYA7JFkjN8Y6hGwi6g23XLiT934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B3bdiBTh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705661354; x=1737197354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OD42keRteXfeJNfHf9czpfOXSgZwqxy+OazuqeDsJr4=;
  b=B3bdiBTh0eySTvkfkxQckBi803STaY7SjFInuN1cubqgtVCgTQrRmB9L
   5BRDc9/NLROosaYT5XYF4tGBl+C3kEsf2pxKqdQHlXeP17Nkf1igyGOKu
   dDuycyAg3CIsYIYNgz4oNY9RfYSP63nXTOk/gtA+Esozvqh9GuME06BdA
   XXBeWQ1vCssMqJy2Jfs6ctJna/khznmrz0x+Wj9qJ7baqUe8JWqnbEe6p
   0OfiShblLyV+xcM0KeRmSC7mxMjt1fdxdAiP1lB8OUXIKqffDRqFyXg3i
   iW1ds3D+/KzWhntvbSE54wb1ERLHzSp5Mjhf10Ig/1AdQqj/0HKK52Zal
   g==;
X-CSE-ConnectionGUID: AU1uLqN+QT6f+gaW+zlRCg==
X-CSE-MsgGUID: x3hB8vsiT3S8hYAHRb4D/w==
X-IronPort-AV: E=Sophos;i="6.05,204,1701154800"; 
   d="scan'208";a="14992138"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2024 03:49:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 03:48:42 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 03:48:39 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Divya.Koppera@microchip.com>, <maxime.chevallier@bootlin.com>,
	<UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Divya Koppera <divya.koppera@microchip.com>
Subject: [PATCH net v3] net: micrel: Fix PTP frame parsing for lan8814
Date: Fri, 19 Jan 2024 11:47:50 +0100
Message-ID: <20240119104750.878119-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
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
v2->v3:
- drop second patch as that patch should not target net but net-next

v1->v2:
- replace hardcoded values with macros for PTP version
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


