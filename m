Return-Path: <linux-kernel+bounces-117974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477CB88B1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A4B1F3DE02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759FC83CBC;
	Mon, 25 Mar 2024 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS473dpv"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D006CDDB;
	Mon, 25 Mar 2024 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399524; cv=none; b=jyOQ0ywWXqewBsj+cM+gkR6w12DOB36g4azqGeaXnpEXN3ENS8dYiqnznjUZxi0HjTlqcGJ3bZCCqVYGvhoKLabCHFZkqqXZTGoljHhlIcwcVVhu9UNVlcVLQJb0o5Oo/jNFallWJb6+h/ipwLdCC0b5FWuLMuygJMkM532vmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399524; c=relaxed/simple;
	bh=3Fh9/szZaGY/QRjbESlj6Atfhm3pzShy88grtilyhi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCXUiMK5hY/lyEfDLIVRGNWY6yTS63bv9QNej1Rg0qxdMHVmrxgyiFvQla0SjqFOn0V+0XriF7ZLAqwvZuxbsqdmhMy7IP1iqkofOUbU96ViJoX8d/9vuss7rEdqWjrZS1+bULedss8N2rnRC3XBDR4oMTyiYu+sF90Tg2Orh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS473dpv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so5143989a12.0;
        Mon, 25 Mar 2024 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399521; x=1712004321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5ygUCJTE280Q0jyVNdLwABcw296Un0BHN6laP6hkL0=;
        b=LS473dpvNTUHuzafn41U7/jP5VyDRbyT8Qw6IEcUWoVh6XGwTS3nshi9LFBhkKV0Zt
         BcXhANiKuxmx2ZMUdXQCAr69/96Ec6f13/B4xBnQhD9D0AcPdACaFP7qz9qo0t5oLltA
         EK+KAk3rr6/Xjg8HZsE/HZMJD8fEIM/RGKvGnHLboIK23pm8InxFPGP45q17UtgLC4so
         dk/AQ09kXJCLxSU6iSuge3FL4qRoHlPIIlXeBE9XirJQPZW2TyNJvd5K9CKKWllXt5X2
         HoxqSWAUZ0LNukY6Wsm/jHu+SYStjwDXdlfOQ+AMJgIAvTJ/3jo/xIM91+KpESWJoO09
         MCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399521; x=1712004321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5ygUCJTE280Q0jyVNdLwABcw296Un0BHN6laP6hkL0=;
        b=V6ApvFnJpwkVwTF/EB0uoOLVDdmheJr0TWs3mp864mbqMBNRjN8iLi5I129K+zytgJ
         TEH9I9G0o96deIKbKy8Rf7KJpSPjTF8eBj2v0pjhp179ZiGSVbDbgugcKUQPaO0FkmLl
         vjl2RZg9KVePxmaeF/dinwEej/+qaICFwPLnCbi57rYOCbsK34ZW0lFFM7m3OWP56HMt
         YXyzIYQt5G88UIc5H8bCaUK+jKpOxxoXcrgBasu7j4BYImS4aMhHB8wvLib+D817dIVy
         Pp9DgPvYIpUrzWr6CUFo2XbOjEolMBiFgremeiuuNH0UCLdjsm0pbNr9R0kQRZeUYcMR
         ksjw==
X-Forwarded-Encrypted: i=1; AJvYcCX2rFt9TjHCV9ljfF/MD1Uo67aMFuV70jtKI4suV5wcpmvpaz9sGnib12lemG6LAbxuVzKW9WhAlQCXILOZbWlq8TJofSaxxhmkryiZ
X-Gm-Message-State: AOJu0YzrzX7qSP/BEtG369bAJ8anEAUfR9rd2SW3loQ+wUQG6qUMbzsQ
	jdk6yscl41wDnN8LUX5/n9seP0Bz8y/rIueE4NcW7Ay856Ysn3U2NLcH/us1Xxs=
X-Google-Smtp-Source: AGHT+IEiCF4cyRSybGOjT3TE1zij1G7XxONjgXRCWhfmXwEzzKNGWo8UGxFxPMW7N+db2WpY9qEvcg==
X-Received: by 2002:a50:8e41:0:b0:56b:a03c:4eb with SMTP id 1-20020a508e41000000b0056ba03c04ebmr6554817edx.31.1711399521127;
        Mon, 25 Mar 2024 13:45:21 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:45:20 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 12/16] net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
Date: Mon, 25 Mar 2024 21:43:37 +0100
Message-Id: <20240325204344.2298241-13-paweldembicki@gmail.com>
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

This commit introduces a new tagger based on 802.1q tagging.
It's designed for the vsc73xx driver. The VSC73xx family doesn't have
any tag support for the RGMII port, but it could be based on VLANs.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v7:
  - replace netdev_warn by dev_warn_ratelimited
v6:
  - added missing MODULE_DESCRIPTION()
v5:
  - removed skb_vlan_tag_present(skb) checking
  - use 80 characters per line limit
v4:
  - rebase to net-next/main
v3:
  - Introduce a patch after the tagging patch split

 include/net/dsa.h           |  2 ++
 net/dsa/Kconfig             |  6 ++++
 net/dsa/Makefile            |  1 +
 net/dsa/tag_vsc73xx_8021q.c | 68 +++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e..b79e136e4c41 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -56,6 +56,7 @@ struct phylink_link_state;
 #define DSA_TAG_PROTO_RTL8_4T_VALUE		25
 #define DSA_TAG_PROTO_RZN1_A5PSW_VALUE		26
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
+#define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -86,6 +87,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_RTL8_4T		= DSA_TAG_PROTO_RTL8_4T_VALUE,
 	DSA_TAG_PROTO_RZN1_A5PSW	= DSA_TAG_PROTO_RZN1_A5PSW_VALUE,
 	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
+	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 8e698bea99a3..e59360071c67 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -166,6 +166,12 @@ config NET_DSA_TAG_TRAILER
 	  Say Y or M if you want to enable support for tagging frames at
 	  with a trailed. e.g. Marvell 88E6060.
 
+config NET_DSA_TAG_VSC73XX_8021Q
+	tristate "Tag driver for Microchip/Vitesse VSC73xx family of switches, using VLAN"
+	help
+	  Say Y or M if you want to enable support for tagging frames with a
+	  custom VLAN-based header.
+
 config NET_DSA_TAG_XRS700X
 	tristate "Tag driver for XRS700x switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 8a1894a42552..555c07cfeb71 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_NET_DSA_TAG_RTL8_4) += tag_rtl8_4.o
 obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
 obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
+obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
 
 # for tracing framework to find trace.h
diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
new file mode 100644
index 000000000000..af121a9aff7f
--- /dev/null
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/* Copyright (C) 2024 Pawel Dembicki <paweldembicki@gmail.com>
+ */
+#include <linux/dsa/8021q.h>
+
+#include "tag.h"
+#include "tag_8021q.h"
+
+#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
+
+static struct sk_buff *
+vsc73xx_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_user_to_port(netdev);
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
+	u8 pcp;
+
+	if (skb->offload_fwd_mark) {
+		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
+		struct net_device *br = dsa_port_bridge_dev_get(dp);
+
+		if (br_vlan_enabled(br))
+			return skb;
+
+		tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
+	}
+
+	pcp = netdev_txq_to_tc(netdev, queue_mapping);
+
+	return dsa_8021q_xmit(skb, netdev, ETH_P_8021Q,
+			      ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
+}
+
+static struct sk_buff *
+vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
+{
+	int src_port = -1, switch_id = -1, vbid = -1, vid = -1;
+
+	dsa_8021q_rcv(skb, &src_port, &switch_id, &vbid, &vid);
+
+	skb->dev = dsa_tag_8021q_find_user(netdev, src_port, switch_id,
+					   vid, vbid);
+	if (!skb->dev) {
+		dev_warn_ratelimited(&netdev->dev,
+				     "Couldn't decode source port\n");
+		return NULL;
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+
+	return skb;
+}
+
+static const struct dsa_device_ops vsc73xx_8021q_netdev_ops = {
+	.name			= VSC73XX_8021Q_NAME,
+	.proto			= DSA_TAG_PROTO_VSC73XX_8021Q,
+	.xmit			= vsc73xx_xmit,
+	.rcv			= vsc73xx_rcv,
+	.needed_headroom	= VLAN_HLEN,
+	.promisc_on_conduit	= true,
+};
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DSA tag driver for VSC73XX family of switches, using VLAN");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_VSC73XX_8021Q, VSC73XX_8021Q_NAME);
+
+module_dsa_tag_driver(vsc73xx_8021q_netdev_ops);
-- 
2.34.1


