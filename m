Return-Path: <linux-kernel+bounces-79171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C6861E70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B418B239DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9986A14F98A;
	Fri, 23 Feb 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAdqjQr7"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249D14F97D;
	Fri, 23 Feb 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722171; cv=none; b=kAMvTK8VMcM+lN42E1PS5uH+WHsDIwjyt6iquTogq/CTEtEyZBgoBLR6LZd0hcYdKsYCQBOVl0u5/pwko2gb/hdUT12cL0iGlH26p7FFsouEEjgS86v5dTd8D9Wi9Q41giiiOYLqnogOJhoEqfHOmFzRrml67G5oWGAMrNE6bnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722171; c=relaxed/simple;
	bh=8uvTSaExNf5N7PUZxerkiyfetwuQs19cLIADLSML+BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSjr/no+rRDrdzGUzkmI0q5746Wl0u6B4jPHZkGheA41SkfEB39VAH+5dp+93TNBcSNz+V8BnWlmrn0L4ppDrc7ouwShPB3e8HiWEKfXIGiZsK61BLIhuNhX52dX9IwozHA1kSJnl971vjNdkx/ckciDgInWJ2yTzQ9qr84u/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAdqjQr7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26fa294e56so213728066b.0;
        Fri, 23 Feb 2024 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722168; x=1709326968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS69myIkjHM/Z9zwIn1rxkv4VNTb80UGHf3LfnDuhFs=;
        b=iAdqjQr7QixbARClfSI9xuqFvxlbMTxFojdvK70s9BdsEX1rYdr6cbSd5PGjn1XkPr
         jEBjf33/Bp/kWDoaLyisjWaiYBe+9DQFKg+WLSo8uyftYoOs8aQfS2/wZc1kpjggwckM
         pZwkUiEzcp7jYX/di9EcdropASCs9YrG3qf8/bZ+MDKzzVeJZjlRlFB5T9WLiR63eH63
         in6q4bVndCijabFWdGW6Sl7LRHTcLEnrx7aCW6pe0nwgTCs2VYnVkwQt1eeLKgNpVsFP
         9iHnrgfx/BFpw8gwpCo7MXJ+CVeE+lLH8zGIUrnWCatbmmZeaAYQgHTYmED7+xO+FJzD
         KPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722168; x=1709326968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CS69myIkjHM/Z9zwIn1rxkv4VNTb80UGHf3LfnDuhFs=;
        b=NvLC05v8PGIn51MKcreYum2L1r6mx5PhESisPYYNNQqy2OTYH9nD0CfijCnFiIJBwc
         AJLkssDmbTNH/B3chmQBRjzWvnC6uUI97BxNChryflU2uu9MkgLGoKzHACn1tvYMx8VE
         oss4P0WxvScH1oeX3lFeNph82KVppj4GBjj6GVSTt7GbcTEKX3mrioSkHcITol2Iy3+Q
         Fma/JmOkzBJ4903jUx6IQ1+PRwf/m9IJZgmzwVK80SvE8hXP782lL7A93OpRYdKewUoa
         3cPWlqgIdWJ4tmjOuAn4RSBpUcwkFTtCBg5AOtrWcZwXF645WU9qlOsT0+OHlkTBR+9N
         35qg==
X-Forwarded-Encrypted: i=1; AJvYcCX0ml8QEdRDYwMOGKBCVvcoLgHZIWfP8xxyp/lHNCyO2v9U41LIrmHLQ7/+Te0twpdZRM1hMJJfl5JTarkCG3nM9S18uw5vwWKQRDMv
X-Gm-Message-State: AOJu0YyNL4FyIFFRG994iTdJ3IYVHxZZVI5IpOGs0RRnIew7tNZXlqug
	iSzBzJLm+apLRch/sNIzGrOmud6mgTmNKLSTHIAlyH5N3kY4IWQ0nO4tRIfWSvQ=
X-Google-Smtp-Source: AGHT+IENP38wU4sFXdwDYIYmN+0anXzNC7F15y0nlkEiyfksPp8Rr5iOYV9+NfCBn2jssyTlbhyrrg==
X-Received: by 2002:a17:906:a850:b0:a3e:980c:699d with SMTP id dx16-20020a170906a85000b00a3e980c699dmr631390ejb.57.1708722168076;
        Fri, 23 Feb 2024 13:02:48 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:47 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
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
Subject: [PATCH net-next v5 12/16] net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
Date: Fri, 23 Feb 2024 22:00:42 +0100
Message-Id: <20240223210049.3197486-13-paweldembicki@gmail.com>
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

This commit introduces a new tagger based on 802.1q tagging.
It's designed for the vsc73xx driver. The VSC73xx family doesn't have
any tag support for the RGMII port, but it could be based on VLANs.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
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
 net/dsa/tag_vsc73xx_8021q.c | 66 +++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
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
index 000000000000..3197c2f0d472
--- /dev/null
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -0,0 +1,66 @@
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
+		netdev_warn(netdev, "Couldn't decode source port\n");
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
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_VSC73XX_8021Q, VSC73XX_8021Q_NAME);
+
+module_dsa_tag_driver(vsc73xx_8021q_netdev_ops);
-- 
2.34.1


