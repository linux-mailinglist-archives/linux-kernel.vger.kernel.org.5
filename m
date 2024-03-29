Return-Path: <linux-kernel+bounces-124188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA91C8913A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0786287003
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A893EA8A;
	Fri, 29 Mar 2024 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="Kam7qLGr"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286D2EB10;
	Fri, 29 Mar 2024 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693114; cv=none; b=eD9JPsxKmp2SBQ25QiMJCmy587wwHiLffkjfLvVVWZEfbx5v3lXj5lfzHn5N2b6h4Ws7PdOtEVAedNDzftNXhPjwBlSLYQLkqbM1QCdWUtbWFsmcB/mmZval19XiKBNdnh30uDWsYH8cXavcMlRcT0733wFQEp4OSOmsyGvKwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693114; c=relaxed/simple;
	bh=9P/L6fxn/w4t7hiR+TWitilOuCTkQCtiYAExJA/lG2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X2ii0JbZ4qzMSXOxe4Su3ViH5y39pkEWvRrMyYRrAgqqVKBDXjQtuRQe3Bg/TL3bdCPbHfWaiwELo+SrJ1wZ0Nu5QQaZ1GHitUJBIwrQC2U8H12zFVdoUCc3AQV+2VX6ipvg0Rewf/4f3Al3it6zdo0/ax1cmBdNcrt3m04Wd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=Kam7qLGr; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 34CC2100002;
	Fri, 29 Mar 2024 09:18:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711693092; bh=rqEcWZ3+sGyg3O09VGLq6x5c0eRiRIjQxWTmaBzhEz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Kam7qLGruZ0sMACNNPPBjqhXHlv7Lh3mKTV1xGFp43qbkQ+X+kf4LLRxU6BsYqSDZ
	 kvxNjiZk/ndMf8LChMYWu3RD+sYkoTGNczUaOd+V++H97SIHGtegtR2b1/ofAFjq3T
	 T4RKNU6255fCaQQIGhunmKzwsS1nOqliwQ7Ox9BFze5/7mDbxzheP/da1rIQCtDcrI
	 aVe9FUmWhWDgDF+EGc+VJsjCwtY/xSzI/MFkX+pr//jSwdKLIqjEqVrkZ/m1kqRuQi
	 Yt0EPdvtCCaF735GMIhI+TtV0tlGKp4cu7ENzxjFyNC04mkvlaMUYyVDk1fjHnF+2V
	 +MWGbeRNvVxYQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 29 Mar 2024 09:16:58 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 29 Mar
 2024 09:16:38 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Divya Koppera <Divya.Koppera@microchip.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] net: phy: micrel: Fix potential null pointer dereference
Date: Fri, 29 Mar 2024 09:16:31 +0300
Message-ID: <20240329061631.33199-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184480 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/29 03:32:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/29 02:35:00 #24501233
X-KSMG-AntiVirus-Status: Clean, skipped

In lan8814_get_sig_rx() and lan8814_get_sig_tx() ptp_parse_header() may
return NULL as ptp_header due to abnormal packet type or corrupted packet.
Fix this bug by adding ptp_header check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/phy/micrel.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 8b8634600c51..0f8a8ad7ea0b 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2537,7 +2537,7 @@ static void lan8814_txtstamp(struct mii_timestamper *mii_ts,
 	}
 }
 
-static void lan8814_get_sig_rx(struct sk_buff *skb, u16 *sig)
+static bool lan8814_get_sig_rx(struct sk_buff *skb, u16 *sig)
 {
 	struct ptp_header *ptp_header;
 	u32 type;
@@ -2547,7 +2547,11 @@ static void lan8814_get_sig_rx(struct sk_buff *skb, u16 *sig)
 	ptp_header = ptp_parse_header(skb, type);
 	skb_pull_inline(skb, ETH_HLEN);
 
+	if (!ptp_header)
+		return false;
+
 	*sig = (__force u16)(ntohs(ptp_header->sequence_id));
+	return true;
 }
 
 static bool lan8814_match_rx_skb(struct kszphy_ptp_priv *ptp_priv,
@@ -2559,7 +2563,8 @@ static bool lan8814_match_rx_skb(struct kszphy_ptp_priv *ptp_priv,
 	bool ret = false;
 	u16 skb_sig;
 
-	lan8814_get_sig_rx(skb, &skb_sig);
+	if (!lan8814_get_sig_rx(skb, &skb_sig))
+		return ret;
 
 	/* Iterate over all RX timestamps and match it with the received skbs */
 	spin_lock_irqsave(&ptp_priv->rx_ts_lock, flags);
@@ -2834,7 +2839,7 @@ static int lan8814_ptpci_adjfine(struct ptp_clock_info *ptpci, long scaled_ppm)
 	return 0;
 }
 
-static void lan8814_get_sig_tx(struct sk_buff *skb, u16 *sig)
+static bool lan8814_get_sig_tx(struct sk_buff *skb, u16 *sig)
 {
 	struct ptp_header *ptp_header;
 	u32 type;
@@ -2842,7 +2847,11 @@ static void lan8814_get_sig_tx(struct sk_buff *skb, u16 *sig)
 	type = ptp_classify_raw(skb);
 	ptp_header = ptp_parse_header(skb, type);
 
+	if (!ptp_header)
+		return false;
+
 	*sig = (__force u16)(ntohs(ptp_header->sequence_id));
+	return true;
 }
 
 static void lan8814_match_tx_skb(struct kszphy_ptp_priv *ptp_priv,
@@ -2856,7 +2865,8 @@ static void lan8814_match_tx_skb(struct kszphy_ptp_priv *ptp_priv,
 
 	spin_lock_irqsave(&ptp_priv->tx_queue.lock, flags);
 	skb_queue_walk_safe(&ptp_priv->tx_queue, skb, skb_tmp) {
-		lan8814_get_sig_tx(skb, &skb_sig);
+		if (!lan8814_get_sig_tx(skb, &skb_sig))
+			continue;
 
 		if (memcmp(&skb_sig, &seq_id, sizeof(seq_id)))
 			continue;
@@ -2910,7 +2920,8 @@ static bool lan8814_match_skb(struct kszphy_ptp_priv *ptp_priv,
 
 	spin_lock_irqsave(&ptp_priv->rx_queue.lock, flags);
 	skb_queue_walk_safe(&ptp_priv->rx_queue, skb, skb_tmp) {
-		lan8814_get_sig_rx(skb, &skb_sig);
+		if (!lan8814_get_sig_rx(skb, &skb_sig))
+			continue;
 
 		if (memcmp(&skb_sig, &rx_ts->seq_id, sizeof(rx_ts->seq_id)))
 			continue;
-- 
2.30.2


