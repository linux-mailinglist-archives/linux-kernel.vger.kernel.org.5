Return-Path: <linux-kernel+bounces-129580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2CD896CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6E11C26A45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2C814883E;
	Wed,  3 Apr 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na6A/V70"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3DD148827;
	Wed,  3 Apr 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140707; cv=none; b=scjc3fXgZ6ECUwpp2MBvwb1bpYi0D2R166g9GBWdJEo+qfQP30NnJx1Z/AYJztzy6rjz2DYga1odyOIPpjyzQHP4eFhrcMGQJrlLOGmPy47hFvXZ+GLobBF9nDlt00jKtbswxh97p/QOm4F9H/C1wYXWMGEBeJdVre1e+canyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140707; c=relaxed/simple;
	bh=cZjp5uVLZQIOhLeBrixOuM4jwIG/7EWXnyZIG2Qqypo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAuWIEm7Ygkb92v3Uh222BXAOJLv9bDl+2jo8FAqVn84kGBDw5XjXLKzIg2c0hRotEod5LTWoq6+uaGw/xV6qMSldxGk+oTBj0mS6v9LqGeb4k7vPC13GyW2mcn6BtvPzEmoXnh7ytV+5SxK4HQOyuJ+zuu3bLemfq81XxLJM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na6A/V70; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4e692ca8c4so417155366b.3;
        Wed, 03 Apr 2024 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140704; x=1712745504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gWm9wooWm3L5N3s5DoTv8ldrCIwk7HKKRoQ/4lSLv4=;
        b=na6A/V70qydAe8sjktYXzKswBz83On9R4Yq7Wcbp3RRR1nQl7p3lej74ewNK6S6D21
         CJizP/rVlA6eXyHyeOHX6DbuxEu/rg2K67z+u8H21DFXNgtjdcOER1HXRivpOBHWprbw
         e2aLC47rmnRmkSDWTL7IVBP7J/fUHgzE+HRSw/yYNSAF+Ec29GGeRHsX0QbNqfuOup3A
         oR17niREtfuJ2cEdaeVFGm+7pZNQ305z/5uVqQgaYaqK4Tg6rpAyafpK6TcQrmvKAxLA
         ofQW0YydYYgZamfDL4Q1nPSdlNdR73cm56bcK+zO2/PrYGvWe7ZWxNZATnuo5q0AIAC6
         +rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140704; x=1712745504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gWm9wooWm3L5N3s5DoTv8ldrCIwk7HKKRoQ/4lSLv4=;
        b=rrIITChS+9pf/JrhMteW7qNBBERnSrUz8aeMezJiFY2W8cSNosgMZoUXFqr8kNG3Tv
         6l3klX2M4soQC6OtnTtMXzqNBzTlJWbnzA4dUHuLIK4mUwfPj+Kl+EjBCCXvvBozLxQw
         xcj4Y3H9Tph4C3PWLsihHpl+j9nhl45ldH04NjhM2bOhYG9dFcps4jINnHV9Cq7YJmTO
         hUZs0jk1GqsdnQGu1gAiEi6Xx+jZD0yCsxRxZ9OrgNF5PEHLnkl8qHGfsvptiKCqyix3
         iCfyPdho9eIbpMIU/M3tpR7BwmH5havZ+jhnUeNNk4AyrmZ97U/lpiWotWY3YiZ7hBHg
         lApA==
X-Forwarded-Encrypted: i=1; AJvYcCXYPHBGfYUePavp6TFJ86K3ODH59lh4TwHYzrHVgX9LqnTPZXcdsQKdwARBGUs+fPWU6KiN2rl9owbNhwjwXF5IcCQa2kyNKQsMUS0e
X-Gm-Message-State: AOJu0YyPcrWvtg4FAxLaw0Yp+ZqqB5/jqNMGh+3iVlGJMJ0kUmLKvCXo
	c2Ww0wXB6QDAI+y8iaOs1ngp4GLj4lS6tnq0M1SUTySNNiPCm1lHlnR3PRT4JA4=
X-Google-Smtp-Source: AGHT+IFFZTRdlRVfTCvB+WQxWukPm5247EzDmcS3fZugTj+PyX+VVznQR25WslTH/DSQ5HPtHzTQLw==
X-Received: by 2002:a17:907:96a6:b0:a4e:7a36:4c38 with SMTP id hd38-20020a17090796a600b00a4e7a364c38mr6719665ejc.20.1712140704088;
        Wed, 03 Apr 2024 03:38:24 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:23 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH net-next v8 11/16] net: dsa: tag_sja1105: refactor skb->dev assignment to dsa_tag_8021q_find_user()
Date: Wed,  3 Apr 2024 12:37:27 +0200
Message-Id: <20240403103734.3033398-12-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403103734.3033398-1-paweldembicki@gmail.com>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6, v5:
  - resend only
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


