Return-Path: <linux-kernel+bounces-117970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88888B1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9901F6446F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD87F7E8;
	Mon, 25 Mar 2024 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7QcUdBj"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D07F477;
	Mon, 25 Mar 2024 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399509; cv=none; b=Y359ynkc4HbUTCRiwchbldsAMhO5RiWlJM/z+LeUYNdxyNHWgYjAS8yMYObo/V0sPkRDOx3IWG2bSrESuG4BkurtJpFYETvjJypc1Ui1NKbgXTo0xyfo44iN9WOCd2z+1T5lKAv6tXFLDxaxb8hNdGTGZLXc46LNIj7Z9OJhlYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399509; c=relaxed/simple;
	bh=CzhSfwM+D0WsxonCK8YnLO+vv0g995LbiCsceBJorV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ll/sfjDEabpm+ZVrjjj2rdE2CpDc3koy8eEsOG0cGjeGcIsgYwAgam4zOYFU03EksJ4olUp/c/SNRqNWfPRaYF/X2CFc/eOZTxgkwJ8wS0q73i5dCN6bg/2XBblvJYJZuJnM8vqAmh+onH+tQVjcaw8JLZ/NGDTERiNw17cTm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7QcUdBj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so69148761fa.3;
        Mon, 25 Mar 2024 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399505; x=1712004305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgbZCr1mQfvbcSKQLR8Uuga1LyHUh7mtUpXZJxBAGbw=;
        b=i7QcUdBjzYaaKCyVvx03tqvDJO5KUA3f9AM4zN8f+DuXCLMlJr/U3JS+ZVcMZq1BDi
         ulfqcHwKz3bF4F2cJYv2oE4iGLWFwZd7BkmmlmRiXIDrpkphQCmzLEV7WFGQCVcbTAgw
         6Lrw8N7lENUCQJf2aZkyO/naSBlkAE4jdyYBMlLbLIG8z4HTJhLqcebd6QOW6OgRNVo6
         SYihBBTejipIC4rprxz/0HncUP3a/CNRKCnEms8wLS3K2nuDvEvRMjoEcm2iC7L2qGrZ
         WuS7bVPdqJX0y53K9sxuKU+t+4tWaxZCeyhpNLl5tEeIVq2coBoeBQQkNLPRWIeoof7O
         Hgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399505; x=1712004305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgbZCr1mQfvbcSKQLR8Uuga1LyHUh7mtUpXZJxBAGbw=;
        b=wijEL2zpgZY7DcVjJuEs1Nzl36um8JaEPFwJznMSPqKxgaj3kW4aNLYmhqfd783H5D
         WA9vNF+YioGgIYA+eI8SDO0UktmvK/PkicV7q9l+Z7qoRSf2m2KduD6p5Qp8i0UVGhGD
         1L51Eqeh/tU9+XNukwvm60TIg5L9jZhqlREumlNFlSwi8sp4rFLFcc9FfV+a2b2veDha
         KgciYU6azYJSqqeOROTgaTFn7anniUbgPbMFYTDOoSo/R0DKMv8p3udHol/8dt3Bo5XN
         uoSnbcAPeMEXegeukA0i5Jb6jihre8mbNlgiJAfMJesiT1ooAl5FQXqI/ULL3/3psJRK
         Wwpw==
X-Forwarded-Encrypted: i=1; AJvYcCX8kFfgRfK+W1RhUUFERDZ0awZCJSxh97zulF3Npc0P1CQvz9RDYhDQFyEPliy2E+1oJrd9OZhDtc7Px6eXmFC4T6Zcgur/CQM15L/C
X-Gm-Message-State: AOJu0YxKb0CRnyOJ0sopbBeazXkXl9VeBd7OfcdzXwtzlkaUPEgmji9W
	FDGBvlUWPxp5THAloiKVYHopn2ltSupJOf4L94ukigQP4hdUqQ5l7pauEOJKUDs=
X-Google-Smtp-Source: AGHT+IHPLDbb1xiPdMlLKbLxm72JC1Us9Tzj69+k4BbcCuLV6jxvi4hgKO3PFoyNac0BIK85ny1kSQ==
X-Received: by 2002:a19:5f53:0:b0:513:a88b:3296 with SMTP id a19-20020a195f53000000b00513a88b3296mr4885575lfj.9.1711399504747;
        Mon, 25 Mar 2024 13:45:04 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:45:04 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 08/16] net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()
Date: Mon, 25 Mar 2024 21:43:33 +0100
Message-Id: <20240325204344.2298241-9-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In both sja1105_rcv() and sja1110_rcv(), we may have precise source port
information coming from parallel hardware mechanisms, in addition to the
tag_8021q header.

Only sja1105_rcv() has extra logic to not overwrite that precise info
with what's present in the VLAN tag. This is because sja1110_rcv() gets
by, by having a reversed set of checks when assigning skb->dev. When the
source port is imprecise (vbid >=1), source_port and switch_id will be
set to zeroes by dsa_8021q_rcv(), which might be problematic. But by
checking for vbid >= 1 first, sja1110_rcv() fends that off.

We would like to make more code common between sja1105_rcv() and
sja1110_rcv(), and for that, we need to make sure that sja1110_rcv()
also goes through the precise source port preservation logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v7, v6:
  - resend only
v5:
  - add missing SoB
v4:
  - introduced patch

 net/dsa/tag_8021q.c   | 32 +++++++++++++++++++++++++++++---
 net/dsa/tag_sja1105.c | 23 +++--------------------
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 71b26ae6db39..3cb0293793a5 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -497,9 +497,21 @@ struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 }
 EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_port_by_vbid);
 
+/**
+ * dsa_8021q_rcv - Decode source information from tag_8021q header
+ * @skb: RX socket buffer
+ * @source_port: pointer to storage for precise source port information.
+ *	If this is known already from outside tag_8021q, the pre-initialized
+ *	value is preserved. If not known, pass -1.
+ * @switch_id: similar to source_port.
+ * @vbid: pointer to storage for imprecise bridge ID. Must be pre-initialized
+ *	with -1. If a positive value is returned, the source_port and switch_id
+ *	are invalid.
+ */
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 		   int *vbid)
 {
+	int tmp_source_port, tmp_switch_id, tmp_vbid;
 	u16 vid, tci;
 
 	if (skb_vlan_tag_present(skb)) {
@@ -513,11 +525,25 @@ void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 
 	vid = tci & VLAN_VID_MASK;
 
-	*source_port = dsa_8021q_rx_source_port(vid);
-	*switch_id = dsa_8021q_rx_switch_id(vid);
+	tmp_source_port = dsa_8021q_rx_source_port(vid);
+	tmp_switch_id = dsa_8021q_rx_switch_id(vid);
+	tmp_vbid = dsa_tag_8021q_rx_vbid(vid);
+
+	/* Precise source port information is unknown when receiving from a
+	 * VLAN-unaware bridging domain, and tmp_source_port and tmp_switch_id
+	 * are zeroes in this case.
+	 *
+	 * Preserve the source information from hardware-specific mechanisms,
+	 * if available. This allows us to not overwrite a valid source port
+	 * and switch ID with less precise values.
+	 */
+	if (tmp_vbid == 0 && *source_port == -1)
+		*source_port = tmp_source_port;
+	if (tmp_vbid == 0 && *switch_id == -1)
+		*switch_id = tmp_switch_id;
 
 	if (vbid)
-		*vbid = dsa_tag_8021q_rx_vbid(vid);
+		*vbid = tmp_vbid;
 
 	skb->priority = (tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
 }
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 1aba1d05c27a..48886d4b7e3e 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -524,30 +524,13 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	/* Normal data plane traffic and link-local frames are tagged with
 	 * a tag_8021q VLAN which we have to strip
 	 */
-	if (sja1105_skb_has_tag_8021q(skb)) {
-		int tmp_source_port = -1, tmp_switch_id = -1;
-
-		sja1105_vlan_rcv(skb, &tmp_source_port, &tmp_switch_id, &vbid,
-				 &vid);
-		/* Preserve the source information from the INCL_SRCPT option,
-		 * if available. This allows us to not overwrite a valid source
-		 * port and switch ID with zeroes when receiving link-local
-		 * frames from a VLAN-unaware bridged port (non-zero vbid) or a
-		 * VLAN-aware bridged port (non-zero vid). Furthermore, the
-		 * tag_8021q source port information is only of trust when the
-		 * vbid is 0 (precise port). Otherwise, tmp_source_port and
-		 * tmp_switch_id will be zeroes.
-		 */
-		if (vbid == 0 && source_port == -1)
-			source_port = tmp_source_port;
-		if (vbid == 0 && switch_id == -1)
-			switch_id = tmp_switch_id;
-	} else if (source_port == -1 && switch_id == -1) {
+	if (sja1105_skb_has_tag_8021q(skb))
+		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
+	else if (source_port == -1 && switch_id == -1)
 		/* Packets with no source information have no chance of
 		 * getting accepted, drop them straight away.
 		 */
 		return NULL;
-	}
 
 	if (source_port != -1 && switch_id != -1)
 		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
-- 
2.34.1


