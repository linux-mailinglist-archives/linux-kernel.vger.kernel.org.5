Return-Path: <linux-kernel+bounces-79168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE18861E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1901F26265
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8749514EFD6;
	Fri, 23 Feb 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E83Bieqn"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5614A4EB;
	Fri, 23 Feb 2024 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722156; cv=none; b=E19i2/O454JYTUljRHpGVHGYZLS6qvX2DqlZVz2eCnBh5TZYO4KjkbI8KQXQKCjzq/FnT7Tx+7Ou7Lhi4xZUmgCfIMWuYlRefP+XuGsDoHufYZmmJlR+DPtSN4Ui3AACM5awuFPwn//rnIQNDsb0iVh8EhINSWHyutLQATgXdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722156; c=relaxed/simple;
	bh=dD5FfujAc94OXdU0UClPUt602iyIqBlyvP8ocvrvfVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgGbpnNBu822PdZyA8IVHb6wu67JpaI4EnJpEcvreXtD6n/iF6unapkK1QbWiBOJcG3eg2tvaiPXjN16zVO+HeMnpmlJlTFCXD7WvL6K5h+mgtlofI1eCFWa7P466ByjpqSOqJkkzmIcnQ7LyDdEafAqoqozaOtUF9raIKGqIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E83Bieqn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so128070966b.0;
        Fri, 23 Feb 2024 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722153; x=1709326953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+4J3DQCVz1HXUjDsjFpN8O2XmJVUHvuuUmsIb+sDcU=;
        b=E83Bieqn6IiesVir9ilLbVu+91AkXUw67lP21vjZ+Ea2YSBbnQm03OZwHg/36jLW9H
         NtjDNanHht88EuKIWBuC7AfSzDCXKK38xIPKwIcQ79nNMhZt9eyNuR9qcebQhyo0bfEw
         c1mjWDBw3z3NXnPG3/HEcUZf3wyXxW4UxLeFEtWGoyoFhLV6lN1d8hBYAmVYtz9EisTg
         Kvkk26exLCs2Q2VZyYXodwmtbAsRqgZUnL3/oljbmperkcAA0CwRue3+1mqfR/Z0ST7v
         NHFIb6QagK7+XRmOGwaNI5+B6PucCJ9v/FFFjTMCshUgiAOr594drZSOCsnYkppZxIKU
         tgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722153; x=1709326953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+4J3DQCVz1HXUjDsjFpN8O2XmJVUHvuuUmsIb+sDcU=;
        b=naNqMz2hy4WvjPO+8b+V7gx7szsXrOZgTwUcbQ8ZmFAM/TfzRAprSQjAVbZpKVngld
         1xsHsC1pxawWQ7NGtx7l2TsPG6AfRBZ74uKWdXGlM+aDOD8KDGylSVVswuytASqLsxm1
         QBky2mwJdZ7Y8QIa6kooZm5WuIvqhJV8YYjxB/aNFL0oU88QU3aHjD4INTfNoTcIU1Dn
         KP6O6OebS86k6EXG8SVtgqlEVuNPrWHasfahKuyXCVOaunbwO5hFtkEiNRu+VwhaE/8Q
         vpy77cpI7a/OG3/DDPp/hC/YyNv9BPm3JXDWPJL6BIoEjeck8tGQLTLY8kDHK8vph6vv
         BQsw==
X-Forwarded-Encrypted: i=1; AJvYcCXNVIMqBWJZ4MUoZKEHM+fwfBiw6ENctnj58O1nsQUGv6MhuAbOt4XGtRPvrJ1cWKPT7cDOR8Ssjamym4kifTxQs6fLrTlOwBEXWqAf
X-Gm-Message-State: AOJu0YzjMV/bVfysDlxWOk9SjXipu8+bqV6jq5GLwg4azIEVoqurcd9e
	WExR5jLOCopB/8bkXHexTiR9gznfPNXhg5YlmDEOG6XY+7euseojFpC+ucoAl8Q=
X-Google-Smtp-Source: AGHT+IGSSogorGvYlhayIwMoENUQ9CaXYWb1KW09w49EFKsdj7EqhxE6w0cptI38FBNNTiwE6FacKw==
X-Received: by 2002:a17:906:b2d9:b0:a3f:b4f0:6206 with SMTP id cf25-20020a170906b2d900b00a3fb4f06206mr907432ejb.7.1708722152628;
        Fri, 23 Feb 2024 13:02:32 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:32 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
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
Subject: [PATCH net-next v5 09/16] net: dsa: tag_sja1105: absorb entire sja1105_vlan_rcv() into dsa_8021q_rcv()
Date: Fri, 23 Feb 2024 22:00:39 +0100
Message-Id: <20240223210049.3197486-10-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

tag_sja1105 has a wrapper over dsa_8021q_rcv(): sja1105_vlan_rcv(),
which determines whether the packet came from a bridge with
vlan_filtering=1 (the case resolved via
dsa_find_designated_bridge_port_by_vid()), or if it contains a tag_8021q
header.

Looking at a new tagger implementation for vsc73xx, based also on
tag_8021q, it is becoming clear that the logic is needed there as well.
So instead of forcing each tagger to wrap around dsa_8021q_rcv(), let's
merge the logic into the core.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v5:
  - add missing SoB
v4:
  - introduced patch

 net/dsa/tag_8021q.c        | 34 ++++++++++++++++++++++++++++------
 net/dsa/tag_8021q.h        |  2 +-
 net/dsa/tag_ocelot_8021q.c |  2 +-
 net/dsa/tag_sja1105.c      | 32 ++++----------------------------
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 3cb0293793a5..332b0ae02645 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -507,27 +507,39 @@ EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_port_by_vbid);
  * @vbid: pointer to storage for imprecise bridge ID. Must be pre-initialized
  *	with -1. If a positive value is returned, the source_port and switch_id
  *	are invalid.
+ * @vid: pointer to storage for original VID, in case tag_8021q decoding failed.
+ *
+ * If the packet has a tag_8021q header, decode it and set @source_port,
+ * @switch_id and @vbid, and strip the header. Otherwise set @vid and keep the
+ * header in the hwaccel area of the packet.
  */
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
-		   int *vbid)
+		   int *vbid, int *vid)
 {
 	int tmp_source_port, tmp_switch_id, tmp_vbid;
-	u16 vid, tci;
+	__be16 vlan_proto;
+	u16 tmp_vid, tci;
 
 	if (skb_vlan_tag_present(skb)) {
+		vlan_proto = skb->vlan_proto;
 		tci = skb_vlan_tag_get(skb);
 		__vlan_hwaccel_clear_tag(skb);
 	} else {
+		struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
+
+		vlan_proto = hdr->h_vlan_proto;
 		skb_push_rcsum(skb, ETH_HLEN);
 		__skb_vlan_pop(skb, &tci);
 		skb_pull_rcsum(skb, ETH_HLEN);
 	}
 
-	vid = tci & VLAN_VID_MASK;
+	tmp_vid = tci & VLAN_VID_MASK;
+	if (!vid_is_dsa_8021q(tmp_vid))
+		goto not_tag_8021q;
 
-	tmp_source_port = dsa_8021q_rx_source_port(vid);
-	tmp_switch_id = dsa_8021q_rx_switch_id(vid);
-	tmp_vbid = dsa_tag_8021q_rx_vbid(vid);
+	tmp_source_port = dsa_8021q_rx_source_port(tmp_vid);
+	tmp_switch_id = dsa_8021q_rx_switch_id(tmp_vid);
+	tmp_vbid = dsa_tag_8021q_rx_vbid(tmp_vid);
 
 	/* Precise source port information is unknown when receiving from a
 	 * VLAN-unaware bridging domain, and tmp_source_port and tmp_switch_id
@@ -546,5 +558,15 @@ void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 		*vbid = tmp_vbid;
 
 	skb->priority = (tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+	return;
+
+not_tag_8021q:
+	if (vid)
+		*vid = tmp_vid;
+	if (vbid)
+		*vbid = -1;
+
+	/* Put the tag back */
+	__vlan_hwaccel_put_tag(skb, vlan_proto, tci);
 }
 EXPORT_SYMBOL_GPL(dsa_8021q_rcv);
diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
index 41f7167ac520..0c6671d7c1c2 100644
--- a/net/dsa/tag_8021q.h
+++ b/net/dsa/tag_8021q.h
@@ -14,7 +14,7 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 			       u16 tpid, u16 tci);
 
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
-		   int *vbid);
+		   int *vbid, int *vid);
 
 struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 						   int vbid);
diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index b059381310fe..8e8b1bef6af6 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -81,7 +81,7 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 {
 	int src_port, switch_id;
 
-	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL);
+	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
 
 	skb->dev = dsa_conduit_find_user(netdev, switch_id, src_port);
 	if (!skb->dev)
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 48886d4b7e3e..7639ccb94d35 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -472,37 +472,14 @@ static bool sja1110_skb_has_inband_control_extension(const struct sk_buff *skb)
 	return ntohs(eth_hdr(skb)->h_proto) == ETH_P_SJA1110;
 }
 
-/* If the VLAN in the packet is a tag_8021q one, set @source_port and
- * @switch_id and strip the header. Otherwise set @vid and keep it in the
- * packet.
- */
-static void sja1105_vlan_rcv(struct sk_buff *skb, int *source_port,
-			     int *switch_id, int *vbid, u16 *vid)
-{
-	struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
-	u16 vlan_tci;
-
-	if (skb_vlan_tag_present(skb))
-		vlan_tci = skb_vlan_tag_get(skb);
-	else
-		vlan_tci = ntohs(hdr->h_vlan_TCI);
-
-	if (vid_is_dsa_8021q(vlan_tci & VLAN_VID_MASK))
-		return dsa_8021q_rcv(skb, source_port, switch_id, vbid);
-
-	/* Try our best with imprecise RX */
-	*vid = vlan_tci & VLAN_VID_MASK;
-}
-
 static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	int source_port = -1, switch_id = -1, vbid = -1;
+	int source_port = -1, switch_id = -1, vbid = -1, vid = -1;
 	struct sja1105_meta meta = {0};
 	struct ethhdr *hdr;
 	bool is_link_local;
 	bool is_meta;
-	u16 vid;
 
 	hdr = eth_hdr(skb);
 	is_link_local = sja1105_is_link_local(skb);
@@ -525,7 +502,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	 * a tag_8021q VLAN which we have to strip
 	 */
 	if (sja1105_skb_has_tag_8021q(skb))
-		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
+		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 	else if (source_port == -1 && switch_id == -1)
 		/* Packets with no source information have no chance of
 		 * getting accepted, drop them straight away.
@@ -660,9 +637,8 @@ static struct sk_buff *sja1110_rcv_inband_control_extension(struct sk_buff *skb,
 static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	int source_port = -1, switch_id = -1, vbid = -1;
+	int source_port = -1, switch_id = -1, vbid = -1, vid = -1;
 	bool host_only = false;
-	u16 vid = 0;
 
 	if (sja1110_skb_has_inband_control_extension(skb)) {
 		skb = sja1110_rcv_inband_control_extension(skb, &source_port,
@@ -674,7 +650,7 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 
 	/* Packets with in-band control extensions might still have RX VLANs */
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
-		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
+		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
 	if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-- 
2.34.1


