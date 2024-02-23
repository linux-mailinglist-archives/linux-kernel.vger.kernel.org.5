Return-Path: <linux-kernel+bounces-79167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49C861E68
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1310EB217F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B714E2C6;
	Fri, 23 Feb 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJZHHeJQ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561D1493B6;
	Fri, 23 Feb 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722150; cv=none; b=bNZLYJwncN/IzW8U9iokhI7AQUzjwy1evsXJ2rNg3lkFfJTNW3HoVaieUj+6+T6ErgLHAuc17SKY8a3n/S3SS+MKGp7a0T265soJjCIkSlnZuSvcAELIxq58R2mKe/GDmV6zuQAvaUlo8qFruNLu2JRWf89RqO272Srm9Rs/bgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722150; c=relaxed/simple;
	bh=Ge4QXGCmrLjaNvVszjPRi3oZ/cuOJtfxYaMZ7XeCdNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZAWxVHH/sC7fgFBD4zmgk6KyAXpOmGBTwZmHJG1VvSBAZUPtu0MhP0fqfEY7DPBcZYKrCgd7gIoP4dt9sbRX2AJpi5S7wNz0l86NP7L+B+/d5UGRHuNkwJ460sI7vo6oDQ848njh6X7yl2K4rWRpEo+aGocBauVzq5ZW0KxbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJZHHeJQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so1649096a12.0;
        Fri, 23 Feb 2024 13:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722147; x=1709326947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcBeMQ6U+yvrfqhVopecDLTi+IwDrZJeE1wPHz5lZzs=;
        b=VJZHHeJQgnY00gZsXrt9NurbfQnBScobSmvrwzmB8oIk7CKqFmjqHwbDKytFZyJR+v
         GbgVp6OeAJeLLWcyvH4Ls0OL/k5OqVDQUbtrtscBWpz/3EbqqRc34jH69EQOvOF1IwuU
         4PalivfV/o+Zx3p91iabLU7wYa6t+/tUwlbPqjPF54OAUSrulDmWmzTi9bgOsKGv7XFn
         Tec0aNEzkSp8zbTAu2vUPIs9bRLND07mwC2Z/xYTaRfG6/WE7MpFa3xEUPDhIk+vtF6w
         Ok338ND+H8ZNnRSHMczlc1zocEVzwyAyFBd1HsN+yyj5U1DSc4+cqCKdGDk0+1ihmgzP
         LdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722147; x=1709326947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcBeMQ6U+yvrfqhVopecDLTi+IwDrZJeE1wPHz5lZzs=;
        b=lqUMdGoROvE7gvYWX1fczW/k+gyYVAnly3S2Z3sSOI05dkSTolar/PcOPCavhKkN8X
         2Ywz6llG8mqDRDd7Kg9/mdZqHRpjgRr8i4IBR8nm+k2gc00QDW/7WwoYnUq74D05uL+8
         E+TrYW+TtavSWTI+OrUyrX0LaQKz/WxemJfDbFrzCDZvnvxweE/WOup4RVZk0JgWxSwL
         19ErH6l3zjNIberJldrsMgspUc5FNsjbjvIkeaPRS/S0HipUSKAt2KIDARIv8PpKyH62
         eN2pURF939NHGnxn3fHzZOBJu8/ws9q+zscplCloLnnS/Aw1Dt8Kd5T/lapKRBreDVJ6
         afhw==
X-Forwarded-Encrypted: i=1; AJvYcCXYUu1yzd2GRW/oKkf3c4DARNZfoJMFvJ+yQNJ0u47DqxCHZ8iWgj3Ny0vJihLKhfIKl8NL0V84Wo91gXOzh+CV54bPCta8dCL0GOPu
X-Gm-Message-State: AOJu0YylRS+GC78AgVOBWeLfabd5KJTMN6yfQJwUsewzdXjnafGI8I+a
	G6+FSyUfmfH7PH0TyMv15TwPVHiZc4/zA3tzjAVYZytTC2/LbKi8kvdV2y9318g=
X-Google-Smtp-Source: AGHT+IHwBAMoti2alBUocy9BwyUKIE2FZEzonj/kFxEGgnpORtjpx5CsCoE5zkrsRA2A2uSe/j0qiQ==
X-Received: by 2002:a17:906:a40f:b0:a3e:8300:7647 with SMTP id l15-20020a170906a40f00b00a3e83007647mr663043ejz.63.1708722147035;
        Fri, 23 Feb 2024 13:02:27 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:26 -0800 (PST)
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
Subject: [PATCH net-next v5 08/16] net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()
Date: Fri, 23 Feb 2024 22:00:38 +0100
Message-Id: <20240223210049.3197486-9-paweldembicki@gmail.com>
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


