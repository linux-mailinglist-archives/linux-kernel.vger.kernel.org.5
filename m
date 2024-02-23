Return-Path: <linux-kernel+bounces-79175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD1861E78
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4139028513A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40E15697D;
	Fri, 23 Feb 2024 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiiuDVRq"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243214939E;
	Fri, 23 Feb 2024 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722194; cv=none; b=FtmqE+iUXbNRbzlSk5Dx3WGvVvgbJhOth0G6fUjptWNTgBYtqtPtPUunpcGsl1udmLrGDEhWsD2Cnzp7RR07ogBXd1Dldpi9SCetEXNo4X4hei+NPEE/MkoBjdveTuFi0qiPsGpaWpTI+WqXzKyu1atox+Vb2bumpkDPHfNzvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722194; c=relaxed/simple;
	bh=wAzmO2nV/mts0uRLd+SnpnPKDzjDEHTguc73SCAqHIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdP4PndMQzEhSesHL8pYbPsV16oLry2U6IcOxR+iRKUlQfkwn4pGFd1+/TsRKxD4Q8xBqAw4SsCy+2BLLNmGM+br45h7lE7vgiuyT+EsciRnH5DjVFOooGhQwHMXwBZ6cuP2pQYGvtU7gs7b+CSdTi2NRnxhv8eDOjH7bzx82gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiiuDVRq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so17331721fa.2;
        Fri, 23 Feb 2024 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722190; x=1709326990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3iU9R8t6ng+bkzwOIZP0nM+fEY42hDYQ8lo7syRMXk=;
        b=OiiuDVRqfO3+yqYy5fGX1OE6y7aqrCPXKTOsbFUfM7Zg6OgJ2HzIlGtvcEhqyxmLEk
         ji4AgD77As+wvhpzBDvEydgJ55IINmmkUyqgeVGUX2G9dl+6h/J6CFtRMdoOX5+IOVBx
         60o1au/kTQdKWvPJ3cyt5jz+VlSTQ2ew1qhkD+5SoD3lZfJOrSOg7daRpdp0wypCfuzq
         uaq4UE68wKTj60Sk4F45yBku+fS/1TnnvqI9ESc9qQ2215wPZX/VF6gi6n1x7FBxr541
         aSxJcyNrg6fpHBy7sxv+oZX0r95C6WVxEtae5dWjHKNCk5sOQOp0Zq/cOJkaIpPaT5sf
         pMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722190; x=1709326990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3iU9R8t6ng+bkzwOIZP0nM+fEY42hDYQ8lo7syRMXk=;
        b=IoEDsKps5+lnhtekXJR04UdZjCnW5QicYtPM5vQtScRgBciP/pa84XE4cl9QaghvSS
         uVdA/oBX/eS8t7lNai/5vpHQsFlXiRC19V6FJjv25zceEKygQT0n7lEwBG8zTMTswizB
         2etHNuIC/EqlwzI5H8e43iN4hnMtt9F7WAFyOcav5+n2mBs1jE4VhUwjY2WxLp04hAA/
         PndF+q2vTV02zuOsvnIH9rz0SITr34qfzL1RaM8c9PvH/IUqvb0ph59tqF5hLkEBTPGa
         Bytk4+xashHKjzhiKaOQ8Dj2fyHkZX9ulwQ+xE9+CSlAnjlBlwmgWpIGWTkQyYv+HcbE
         2Rbg==
X-Forwarded-Encrypted: i=1; AJvYcCWfN+XOMtCnEWMD7JeNgvGB5Jhau88l1UTbtmagNzqLjBZmL0ih+aXXgjz7t/tdxzwdz5B750YZMNcK59mq1YLgu9vL7Ex8ZQHMaude
X-Gm-Message-State: AOJu0YxvKO1zdmKmsmYcCCOf8e8vW3Quf0+Ozl62Yjry3Yrq3rnsg4Yd
	0Bv+Zh0zCpBUSv3CQj+dQxpcS5DTYgg6VKf5HFxXOGkXngy5Xj/LDOwz93H9CjM=
X-Google-Smtp-Source: AGHT+IHVV2y64jRVCacDLEUV+u1xPRhTkyOMvdB8LkVI3WkOF0Ffmnp1ZpGOuI3DJBOG4YKt6gV4gw==
X-Received: by 2002:ac2:5fef:0:b0:512:99c2:dfa with SMTP id s15-20020ac25fef000000b0051299c20dfamr552215lfg.42.1708722189978;
        Fri, 23 Feb 2024 13:03:09 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:03:09 -0800 (PST)
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
Subject: [PATCH net-next v5 16/16] net: dsa: vsc73xx: start treating the BR_LEARNING flag
Date: Fri, 23 Feb 2024 22:00:46 +0100
Message-Id: <20240223210049.3197486-17-paweldembicki@gmail.com>
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

This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
which are required for properly treating the BR_LEARNING flag. Also,
port_stp_state_set() is tweaked and now disables learning for standalone
ports.

Disabling learning for standalone ports is required to avoid situations
where one port sees traffic originating from another, which could cause
invalid operations.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v5:
  - introduce patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 41 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 8dc366461b9c..3b312799cf66 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1590,6 +1590,31 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					 struct switchdev_brport_flags flags,
+					 struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vsc73xx_port_bridge_flags(struct dsa_switch *ds, int port,
+				     struct switchdev_brport_flags flags,
+				     struct netlink_ext_ack *extack)
+{
+	if (flags.mask & BR_LEARNING) {
+		struct vsc73xx *vsc = ds->priv;
+		u32 val = flags.val & BR_LEARNING ? BIT(port) : 0;
+
+		return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					   VSC73XX_LEARNMASK, BIT(port), val);
+	}
+
+	return 0;
+}
+
 static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
 				    struct dsa_bridge bridge,
 				    bool *tx_fwd_offload,
@@ -1706,19 +1731,21 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 				       u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct vsc73xx *vsc = ds->priv;
-	u32 val;
+	u32 val = 0;
+
+	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
+		val = dp->learning ? BIT(port) : 0;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
 
 	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
 	      0 : BIT(port);
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), val);
 
-	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
-	      BIT(port) : 0;
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_LEARNMASK, BIT(port), val);
-
 	/* CPU Port should always forward packets when user ports are forwarding
 	 * so let's configure it from other ports only.
 	 */
@@ -1740,6 +1767,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_pre_bridge_flags = vsc73xx_port_pre_bridge_flags,
+	.port_bridge_flags = vsc73xx_port_bridge_flags,
 	.port_bridge_join = vsc73xx_port_bridge_join,
 	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
-- 
2.34.1


