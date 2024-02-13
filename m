Return-Path: <linux-kernel+bounces-64433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CCB853E42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC4A1F219F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB4876901;
	Tue, 13 Feb 2024 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVjMYKIR"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21396768FB;
	Tue, 13 Feb 2024 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861967; cv=none; b=Hm+6AX8XSoRdGEDOxDeOUWKNppgImlxxQI/BIzGhTw18FjEkQYcrtLtobaYDQTtJv6yyjc0E1VJuw9jJwrDCxej9NoVLMe/CdL+tNlIyf1RAXX5oldrrWb0Cju/TTT+mLM9Us6AQRyD1pXv3RBkbfD74zF9hPNWRPsZOT8CXJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861967; c=relaxed/simple;
	bh=gbxVPJ6WPRdDj/VlfQnJSPWObXat+GMFe+pa9vsdy8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfYT6BX7H6aiiV5wEWXe39cUQn6CCw/lJE28D55IzNMfkkSkE+WH9JexDMsDf6St0JHub01AO1k3GMFSFgAG7QZa20DL463lGk1VLOm+nomtIht1uqIcrpnl2mJ/RJkWwtYXsRaGwiZ630wBX7+XKNm/VeYgtYZW71BgSiA7Sow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVjMYKIR; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51176eb6a4bso5034634e87.3;
        Tue, 13 Feb 2024 14:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861964; x=1708466764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsV3RWi5mt3annbxTmJGAA4zUOZXwChRzqMr98hPMQE=;
        b=kVjMYKIRBQw1BhPhGNzwLcWenlmsxIlDH0bk7q62f9QqgCOFhiLHom0sfcqxxnDBaZ
         zQqZg9FCZ19q0yNv9tvrKlWnrdWdV+4EvXh8KJ3A77nQW4y5gwDV/n9hMdgx8e4XSAnX
         Zrq7KmG3Q4fv4fbBZaQaK8O++axGD/ew2X86QCTvSxhvIS5U83R/G+QucRTLcMViotWY
         TW67HrdmWXl7yF/9TUomAf2JF46jitowoKzCEdnTRekQYJx6XWyWP4Gwu0AHafqUutGd
         adMNkC1H37Xp8XmHJL1uziJ/lwspkRpJayShSytMwHMZ5VEEAS3EP1ZLsfi/jG3pUbRC
         iuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861964; x=1708466764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsV3RWi5mt3annbxTmJGAA4zUOZXwChRzqMr98hPMQE=;
        b=AJHLUYO3MSfox04FFi01bJ2OntjPuoVWV1NodDTrY8bmHb4gSH9Cew02CgcKolK8OT
         K0BFSCWYlfpbtQ2Yhz9VxQSdIcEgvXpQbEQ+6LXBXb/SdVPc+8D0939JEhrVyE2TmcCz
         EGN19MfZSifmSC7lqEE7RTjlU/mAevsFxqxX2kpkqyixsSM49FmVgN5FHO/yb65PXkrP
         c/nGT+2sDIl78xTElLZSvVqmrCDa2SYjcMMIrJ1pt6/txnIIR3UrXwDEo2TB18w95zUJ
         VSQYaenBVjNlf73169jDJLLb6tq+QiqaKy7rKn8bcA6AYO+DroawkM84m63LT2j+pEA+
         +rVw==
X-Forwarded-Encrypted: i=1; AJvYcCWv8UcNaa5hf/PJ2d7ew1SBRMsPTUGOo3KlX0RoW8k4Hg4XS+bRk7CulItQLOSnXh8SBFLouIJiDdZQraNRcSjYPBMrA39tz0+k13f9
X-Gm-Message-State: AOJu0YzYYeoKEmPTfDT/qPwU/5VYHx/VmGWR89dekP/xOlyFPMc83rKg
	1qQKH+6XIPyDrohesgf2V3uviw8tEdTS6fE3k5w8s32/l2L2MTjpr3bFaqec10k=
X-Google-Smtp-Source: AGHT+IGnLwxRXqh7Vnva/GmEq50Zj0Jzqcqk82fg01VT2b+8mhwiCg+jlDhgx1TNCTdsTAhTQiaq+w==
X-Received: by 2002:ac2:4c2e:0:b0:511:48aa:d621 with SMTP id u14-20020ac24c2e000000b0051148aad621mr596887lfq.66.1707861963831;
        Tue, 13 Feb 2024 14:06:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiHsKUaFLJtSg26Ue6/yjHqtoSQycOdoVPF9xVAWZZ6A8ApxSlgT5sYHHdOg34B4LVHABTZJjb0fgPUXgXbCsOWt5YX3U233/9BBONll1rm05kwglv/n6TM10oBK3cUVaxALALDmILw1qHV7unWBbqsU9jzQHtnF17vHouc9faqY+bFeh6WLzvsRVPQ+RBOt91zeODGWprJkcnitiayv59Ab+XqlW7yNX5LTPB/f6WLfKl8XjRVcPZ4NUXiuZCk3M0HGZY2XK//IsCTSJcA9DMLnGduafS1loL7JGVb40QzeZXlWXW6qC/OE1FnESHi4gk5a54FttHBSO9rwTHe7UW80ljfcYlpj6jASNxqyhEOha59HgUFsxBWgAx1nk1G6hBy46mhnIOVIb7xchrz27InXRt9RWXYlKYW0+vql5hUnXlA1ilhozc5oblaJS5fj5+8DCdk3ednavarxZSkL7kahApD8QLlO0YEKvjpSDJmpI=
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:06:03 -0800 (PST)
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
Subject: [PATCH net-next v4 11/15] net: dsa: tag_sja1105: refactor skb->dev assignment to dsa_tag_8021q_find_user()
Date: Tue, 13 Feb 2024 23:03:24 +0100
Message-Id: <20240213220331.239031-12-paweldembicki@gmail.com>
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

A new tagging protocol implementation based on tag_8021q is on the
horizon, and it appears that it also has to open-code the complicated
logic of finding a source port based on a VLAN header.

Create a single dsa_tag_8021q_find_user() and make sja1105 call it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - introduce patch and change from master to conduit and slave to user

 net/dsa/tag_8021q.c   | 19 ++++++++++++++++---
 net/dsa/tag_8021q.h   |  5 +++--
 net/dsa/tag_sja1105.c | 17 +++++------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 332b0ae02645..454d36c84671 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -468,8 +468,8 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 }
 EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
 
-struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
-						   int vbid)
+static struct net_device *
+dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit, int vbid)
 {
 	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
@@ -495,7 +495,20 @@ struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_port_by_vbid);
+
+struct net_device *dsa_tag_8021q_find_user(struct net_device *conduit,
+					   int source_port, int switch_id,
+					   int vid, int vbid)
+{
+	/* Always prefer precise source port information, if available */
+	if (source_port != -1 && switch_id != -1)
+		return dsa_conduit_find_user(conduit, switch_id, source_port);
+	else if (vbid >= 1)
+		return dsa_tag_8021q_find_port_by_vbid(conduit, vbid);
+
+	return dsa_find_designated_bridge_port_by_vid(conduit, vid);
+}
+EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_user);
 
 /**
  * dsa_8021q_rcv - Decode source information from tag_8021q header
diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
index 0c6671d7c1c2..27b8906f99ec 100644
--- a/net/dsa/tag_8021q.h
+++ b/net/dsa/tag_8021q.h
@@ -16,8 +16,9 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 		   int *vbid, int *vid);
 
-struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
-						   int vbid);
+struct net_device *dsa_tag_8021q_find_user(struct net_device *conduit,
+					   int source_port, int switch_id,
+					   int vid, int vbid);
 
 int dsa_switch_tag_8021q_vlan_add(struct dsa_switch *ds,
 				  struct dsa_notifier_tag_8021q_vlan_info *info);
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 35a6346549f2..3e902af7eea6 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -509,12 +509,8 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		 */
 		return NULL;
 
-	if (source_port != -1 && switch_id != -1)
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
-	else if (vbid >= 1)
-		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
+	skb->dev = dsa_tag_8021q_find_user(netdev, source_port, switch_id,
+					   vid, vbid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
@@ -652,12 +648,9 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (source_port != -1 && switch_id != -1)
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
-	else if (vbid >= 1)
-		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
+	skb->dev = dsa_tag_8021q_find_user(netdev, source_port, switch_id,
+					   vid, vbid);
+
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


