Return-Path: <linux-kernel+bounces-64430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE440853E38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF781C2875D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2196A359;
	Tue, 13 Feb 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGN2gAOO"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714369E10;
	Tue, 13 Feb 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861949; cv=none; b=LwnTJMb6SZm2kySJD2nSQN6X3f6rDQxdI5ekPRTGljraEDYusV2ZJtS+fa7L40LzhwTfblhQDubYiSFxV1ieiifOpL/Je7vJsLtCmKO2Fc5FtGWsqkKTHviRdiPbIq0vB+U2PkocYLhOg86mJIoFbcCv8tH9nLIen74haMx2es0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861949; c=relaxed/simple;
	bh=30wAuor8M+3rBgvHsgL+WF5JOPTFm3WXG/R2QNvezrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RstN8/PYxh8t3ReVU0USSMwiLE3QnMVuio6kBPWlYbiC2eTNAGESdIwDXi4dwmhApww3LObabNSheSuGX9pFA6iju8X1k0hOVsNObLXUACoHECbFe0rxLS0hBm0z10XMBhwSgJeFdnNjfqh8r/j+xZYiKlAyShWvOlhZw1e1VFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGN2gAOO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so6453507a12.1;
        Tue, 13 Feb 2024 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861945; x=1708466745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU/EzzAZ+26p7VR+AL+8noQM2sIMSv95utTyaUMHIAk=;
        b=RGN2gAOOzCnhcKSSXCP1Lkq8+EYrYAwoUTqROc3YTp+Z2z0R2vjUeI4mHYd7AFISUo
         AKizuXy3z0pLtxqQZuB2sdGdMTfTSks/Mtv0nVdKvDM61urBKtDhwc6uGBhHuyCcdUbt
         2dmICdRPHrRZkQwKKBeNhSf5PdCQ3x7cF40tJfEz1BOOa1l1i9rHiOWTf0gZuJMy4xmI
         RAhVRv3fjFZ2jxRZQzGlICFeAavQAxKqRnvk2dq1lRjF/n4ANjkcBnEhBlVfBrJu/wDs
         mf7b/B+hITEue1PjBCrEE8mL7Gg98bEuHuFZjQLfu9e6hi3yTtxMrAPav65dxl5TdjJ9
         /Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861945; x=1708466745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU/EzzAZ+26p7VR+AL+8noQM2sIMSv95utTyaUMHIAk=;
        b=dVzput3A9muX7Vy6wg3io3Y+ERjibJydqdCPLsyKQM2kFq6+poU7l/+XriVxlA+1Rl
         crvxlgSll1IST7SJAZUE8j46VnJubp5u+w28p6QTeR7Nj9H4AueyQ+IB1HfOvDzirO5K
         ED9BKlkWI28KGhgM3X0ZTE+mehQq9YmiJJIcs9YiDs62K3oChbraKqPqe6daJXJQjQlg
         sEXtvnVo1XyR1q70jdSSiZA114/KFzJsgK+UGYQtPZHTp8Q/hJI8Wzg8E9AghNBwJ9p9
         2Jw2ke+cZBY11pMNDFcbVDczn7yRgI+X15ZtTpRaWijIFz1UHb5LfyUMpHQUHHz3KWWf
         XJXA==
X-Forwarded-Encrypted: i=1; AJvYcCUORXMzKrUhqUMjOtDlHrMn36/zttx4WW0rSLz+XRPsgeMk8tPBYyr5neV7hQ7I2jxBCY0e8HLPBQPEXg5ERZM24QahXJ/MdzRlOhyp
X-Gm-Message-State: AOJu0YxNP4qkBOzhzGeSaQR5zCOqh3+6ApfrKWX1/7OhHVmJ2qhDHGRD
	xXCtu9ruUc+1hFOGbUgsCsW6axoV2DuUDJnAdT5GcSMZj5Wf2hc9CgVeTBoLRs4=
X-Google-Smtp-Source: AGHT+IEu2iWvEwOIyqeuEWVQnyqHB8H/uCkDsSGQZAmgVcwi5rivcl4dCuAcZl3j272XDjmrSo6/tA==
X-Received: by 2002:a17:906:495:b0:a3d:1a89:7054 with SMTP id f21-20020a170906049500b00a3d1a897054mr486760eja.39.1707861945378;
        Tue, 13 Feb 2024 14:05:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWK4qxbePgjYGlDE0gi9ls5TD1pLfnEevyvGm8A1VCaFV6ho/2jGjFgvpPKd+2PGU5YRkEjchB8OaUr08bd5O1PO+NkneZp3vx7ROmfKa7/n8pZ1qZReg14zZIcrf79o/hG5gsibENB3qqaoKdF2shbQj06+X5cgUsrhX8L3TWUWlJOEGhXa+3z9KWO3vN9GmPTDOzgMvjV03w/WtyAJdlfXl326ElGH5Usi92MTXQXbC2Yup2zbeWZWst6+Dcjz40/EUIyPk+6X1mQ24OymhtUkX1pxrrToUrccERlAJsTK3MC+FaTKHOADT5gBFl6hSQSoFkqDXJJiWWPrs1Cq/CsHI4GYsdWs37nJHB+Vmj24bb1f/ZZoNQ/OcdlxBEhGdn52tnrtuEdlwB+ddv79iYnhkUKROND07n5k3Fn5b3GcEIjJx9HkpFsX5NOC7CJkNV+EwAdAfxjkA==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:05:45 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
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
Subject: [PATCH net-next v4 08/15] net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()
Date: Tue, 13 Feb 2024 23:03:21 +0100
Message-Id: <20240213220331.239031-9-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
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
---
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


