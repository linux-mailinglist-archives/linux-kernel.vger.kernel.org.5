Return-Path: <linux-kernel+bounces-64427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4112853E31
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B28228C24D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A0B62A04;
	Tue, 13 Feb 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdFcB2/7"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA169D2E;
	Tue, 13 Feb 2024 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861938; cv=none; b=A568t7clR7kiXb20Mw3TWRNBbsTZDUtVm0CpsCe/+vUwhdmigcTzUF5jg0K0CTGgO40VtBMHwUqX94hwLluyjqDcA5sDfJk4Fjbh7JB6+b207Zoam8gyQp64cTFScYmZrWyG6ZSLwWPNbRwQsxwaZog7nxpJTh6T6mD8IM9bd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861938; c=relaxed/simple;
	bh=aSfhz/n2RCJGOr6hG14wnL3tSy0jymdagBk+PlbYLf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V55SxLFxsjk8Bxuhq1dzymyU0lWWx5hk46Y7ot3u4f9U5u0+qnuChg3/t9kwOQDtZK5kc+7xmZOIyYcSTGNwkoM2YmuGG3jnqNbSjOUyLRsHlUfFrubHkYeh+sWbHOV2GJ72RzYfL5uyPMCWyrDMdySBnpfqb254bCDxpzg9KfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdFcB2/7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso149971666b.1;
        Tue, 13 Feb 2024 14:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861935; x=1708466735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwJcHCbiEJFiPaixjIdrmQwiczYM9/vn6dsLmIZry58=;
        b=jdFcB2/7kyE5ojdvbVC1UwXcBby/bARnk2hS0R9FTrcJrKeNLT9aVEGCWjMogapC7P
         XvVc5MIATgBr5nblEcep1ow/X3A5MXW9HYwZcnxFmZSRLsf7pAKDvL6tCohYOOKa8PDA
         neiXHqMd4y5uhKiGMD05Oe8izl3Xxf8/tksNGI9ywtJP7C6hSVv5iQ9YstmcmwqIMY4+
         L2A19wvAkWPxbkEDaiORtrpQbg1Z6ZeyKAEKvyB6l8Tsq3SK+5Bq6RXLDO1W1G8CGDDd
         OuiiBcJMvBjGQSJ90fN2UHg3upPeWsMbkMJsS9C6JMYAtZBfKRUihuh50GINFr4+A4uL
         6+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861935; x=1708466735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwJcHCbiEJFiPaixjIdrmQwiczYM9/vn6dsLmIZry58=;
        b=gS2zK8CiOfZamNPivniJGuA8+DHfbI1dm2/Bu++ZsrEdkVYdzGIZkvGYsLlYCbUTBE
         PBk2T9W9vDqVOo6eG+0yWHeot0NRgOf+/fhVJbuChAHe3FXiGikmbVn8IiYd4AEHQz65
         Mdbn6q1Q9beJIUYtSyEF+V+PC3F7/B/kxgZlTXZ5352LofhaYaIJkimwxYcEgdcGOFT/
         jPiop0GJBYomH8ZdA7N+QN/NMQQGDEiAMrZeuoK8xB147djWJe3ChvBrJHLRF2jFwAQ6
         xZbBz6wbg4YK3dPdL811nBD//f4x6mgxMkmqH9vWVOe8wa37XuGnn/wLZM7JGE7Su5Bt
         Vuiw==
X-Forwarded-Encrypted: i=1; AJvYcCXxHLj7daSQfbSfoOF7EA5QeOyNbYcbL8atW2Ktguh0X857gZRW9DZBHPpEtl4+l7oLObcW6bDqKehcMcAgWgb+aj/eY+gpfPjfPPoF
X-Gm-Message-State: AOJu0YwH+fI+WOU2hMD7TwSJWxE8hMhV3C/NxKr3y92tD13yofIF8w7f
	/4AVqjup8zKi3a0XYXzsRENBHjxNG2k1n4Jv8THvM+6bfahnZNQdQPnp38uo4aM=
X-Google-Smtp-Source: AGHT+IEkt2zrtA7tLHriJE/BgVIY098/3HhmQpSjIsl5BIiaVm3fdLYxNbLEqW3dfJpcW4nYGpIYKA==
X-Received: by 2002:a17:906:5a8a:b0:a3c:f38b:ec4e with SMTP id l10-20020a1709065a8a00b00a3cf38bec4emr395277ejq.16.1707861934882;
        Tue, 13 Feb 2024 14:05:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXswr14b8uYnfaE61bHXSkCtVnwB0LXtgndBOSCLt2TaDGAF49nsx8CXfIr/v8kfzAvmoXp2KBr2DKaMaHA0hmAK28w94XApE0yZsNFXXbfNRvZ+bDrkrG1ENfElECB5TMgwFyevBXwtmAzrGhFq79XrzsNLgANoC5QfdOFW7eV7eBhwrhYWzovo/z/Bogq9qN0eqvwaBNHB2dux1exfrxrwwvf+rfwnj8wkvQiN4EKwE5N4E2kzwEyh3fQNusDSAvpQnzfIYFSOVmYLhapX5QR0q0rPZxixdOonGRqZurZKNjq0SG1QSjGMwcoZINcsRSZE3TYA+LQdeAb4f4kYDwLmiRxru8o+BMqklCEfX5+vA30yN2Ct0l6U8wwOA4VA6NOVHXXJvxy1gMUCzFw9I5Xg0Wza4NXV0DsL0e+MohVc0JDxR/CnHs3xNPKJrWwnEWXBJmB/PJgIQ==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:05:34 -0800 (PST)
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
Subject: [PATCH net-next v4 06/15] net: dsa: vsc73xx: add port_stp_state_set function
Date: Tue, 13 Feb 2024 23:03:19 +0100
Message-Id: <20240213220331.239031-7-paweldembicki@gmail.com>
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

This isn't a fully functional implementation of 802.1D, but
port_stp_state_set is required for a future tag8021q operations.

This implementation handles properly all states, but vsc73xx doesn't
forward STP packets.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - fully reworked port_stp_state_set
v3:
  - use 'VSC73XX_MAX_NUM_PORTS' define
  - add 'state == BR_STATE_DISABLED' condition
  - fix style issues
v2:
  - fix kdoc

 drivers/net/dsa/vitesse-vsc73xx-core.c | 83 ++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 75597daaad17..1dca3c476fac 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -163,6 +163,10 @@
 #define VSC73XX_AGENCTRL	0xf0
 #define VSC73XX_CAPRST		0xff
 
+#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
+#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
+#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -619,9 +623,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
-	/* Enable reception of frames on all ports */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
-		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -841,9 +842,6 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	if (duplex == DUPLEX_FULL)
 		val |= VSC73XX_MAC_CFG_FDX;
 
-	/* Enable port (forwarding) in the receieve mask */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), BIT(port));
 	vsc73xx_adjust_enable_port(vsc, port, val);
 }
 
@@ -1026,6 +1024,78 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, bool configure)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct vsc73xx *vsc = ds->priv;
+	int i;
+
+	if (configure) {
+		u16 mask = BIT(CPU_PORT);
+
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));
+
+		if (dp->bridge) {
+			struct dsa_port *other_dp;
+
+			dsa_switch_for_each_user_port(other_dp, ds) {
+				if (other_dp->bridge == dp->bridge &&
+				    other_dp->index != port &&
+				    other_dp->stp_state == BR_STATE_FORWARDING) {
+					int other_port = other_dp->index;
+
+					mask |= BIT(other_port);
+					vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+							    VSC73XX_SRCMASKS + other_port,
+							    BIT(port), BIT(port));
+				}
+			}
+		}
+
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK, mask);
+	} else {
+		for (i = 0; i < vsc->ds->num_ports; i++) {
+			if (i == port)
+				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+						    VSC73XX_SRCMASKS + i,
+						    VSC73XX_SRCMASKS_PORTS_MASK, 0);
+			else
+				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+						    VSC73XX_SRCMASKS + i, BIT(port), 0);
+		}
+	}
+}
+
+/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
+ * forwarded only from and to PI/SI interface. For more info see chapter
+ * 2.7.1 (CPU Forwarding) in datasheet.
+ * This function is required for tag8021q operations.
+ */
+
+static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
+
+	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
+	      0 : BIT(port);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_RECVMASK, BIT(port), val);
+
+	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
+	      BIT(port) : 0;
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
+
+	/* CPU Port should always forward packets when user ports are forwarding
+	 * so let's configure it from other ports only.
+	 */
+	if (port != CPU_PORT)
+		vsc73xx_refresh_fwd_map(ds, port, state == BR_STATE_FORWARDING);
+}
+
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
@@ -1041,6 +1111,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.port_stp_state_set = vsc73xx_port_stp_state_set,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
 };
 
-- 
2.34.1


