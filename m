Return-Path: <linux-kernel+bounces-117968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E6188B3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98550B68285
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94B1745C2;
	Mon, 25 Mar 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQHE09Uv"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304B6EB52;
	Mon, 25 Mar 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399499; cv=none; b=DvonoDHM1ZGfe6x/+P5Juk10oxLS+TXLTW5ZX/bdPbDnVrFYGyf9dcXqq6qUhcjFbN2ZzHikjh2JozXqivLLQJMaf/V2rN41Osi9ndoxKZURRWZviVlqzi3O/yP+OazuFwTfwPSD9Z+xwBXLquFinCyM1AsGIJb0IvJmjgdx1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399499; c=relaxed/simple;
	bh=MNy4a9LrRLFB9UFbrtc1jj60lgKwWYTXEKysX0ELC+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKYwdKTmaABhVQCpwGsPnXkj99Et2eLdcBbAzp3zHtdSiaTCYDI+mgDWxihb8+PtEKMpg3e6cyeR0ZjQiMb5LT5OsWaRZSXfEWXIKHQb7SdTpfFgRy7UbmrFfrB8M/fIYIkl/PjziOe5zZkfdeLJJBfdXVZqiUyeMC10lN50scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQHE09Uv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c1a520659so1204813a12.1;
        Mon, 25 Mar 2024 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399496; x=1712004296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJOhT/NhfBRNemKHQ4KsvY/IdcyTqEthLWerBC7um4A=;
        b=IQHE09UvMtYS/4bgybSW88yoXmivpvAm7SnMObYPvZdAkJKxvMvGdwGZGLrQt1DURi
         iirLh6pvvHvOr+T7ZD0ZfRu7KpC+qi3i1cH7kxFY7wGYK072zCJxXRwMezEh0P3nQ8L/
         JN/FuindBVgToUt6xhDOrCBkRAS7MTpFCapzORE45hsUeKca4y8tsRqwgK/YMo1yqHlZ
         glRVeRZdBbnJ/vozb6gaI5fpYUTbS5rFeCdommw0lv8QvYFabd05CT47uALkx0k4XsE6
         2rVCJ4Xb4yR8Ls2JFVtOQXT3+QE0k0iXaEsp0bkK8wmGm+xC5F1SR+ao/7Ce6Qh3/qua
         qBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399496; x=1712004296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJOhT/NhfBRNemKHQ4KsvY/IdcyTqEthLWerBC7um4A=;
        b=GeTkQBixSMGY4sDFI+e9kmtzccZOJ4rwQcV/q2f+04rC8Zf1USMiaoQnKtZeZtI0cc
         tDob8+qqtYrsmiQVrC3MFM52NJjbLi0asCCxFWLvkOTgvVu/g500BeSKEJWt5YkWO6hX
         bKK7oFb+Lm70K6bdzqfyDRcDfWzQK1q4Ib340gNvwW8luGU1CDC4C7Mp6bo4d6LUj4Gj
         Ayw3bBoG8zDnsOnaXS71CSuCvKwO0CXhLJN6Qi1i0/cA0sOvrBy83qfZQCyJJCQcFPEv
         CKBuZRP9nKl4oRALK89RDAgzhcIBqXhx5ZtfywR53fXy4I0Hd+2JYYIKsAUbEYrwjDnO
         DU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUuZRnLDYUHcjLHo6LAmUz/3am/tueUpEauJn00sci3Tl+iOuvFa+lmXEJUGyPCKSFdxfuM8wcBT2GOamHq0iLZlJsj6T0cV8dna8E
X-Gm-Message-State: AOJu0YyiPahc7bvw4Vh3nKC2suj+kZE3jA1lz7TPRFahhEOu0Q+dAU5T
	T0gd1z4ktcrqYByE5izmpcOhgllbG1AoE2WhgAPcSpHBJEfZfioX1baz85u6JAk=
X-Google-Smtp-Source: AGHT+IF4lQcHa60qMNikZp1uI7bqrjqUR285+MuN34xZ5raHk3YF2hJBkuhX5/FosFIJ/JWubDlfrg==
X-Received: by 2002:a50:9eea:0:b0:56b:dcdc:6fad with SMTP id a97-20020a509eea000000b0056bdcdc6fadmr625842edf.13.1711399496230;
        Mon, 25 Mar 2024 13:44:56 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:44:55 -0700 (PDT)
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
Subject: [PATCH net-next v7 06/16] net: dsa: vsc73xx: add port_stp_state_set function
Date: Mon, 25 Mar 2024 21:43:31 +0100
Message-Id: <20240325204344.2298241-7-paweldembicki@gmail.com>
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

This isn't a fully functional implementation of 802.1D, but
port_stp_state_set is required for a future tag8021q operations.

This implementation handles properly all states, but vsc73xx doesn't
forward STP packets.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v7:
  - implement 'vsc73xx_refresh_fwd_map' simplification
v6:
  - fix inconsistent indenting
v5:
  - remove unneeded 'RECVMASK' operations
  - reorganise vsc73xx_refresh_fwd_map function
v4:
  - fully reworked port_stp_state_set
v3:
  - use 'VSC73XX_MAX_NUM_PORTS' define
  - add 'state == BR_STATE_DISABLED' condition
  - fix style issues
v2:
  - fix kdoc

 drivers/net/dsa/vitesse-vsc73xx-core.c | 96 +++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 425999d7bf41..07f982cf62dd 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -164,6 +164,10 @@
 #define VSC73XX_AGENCTRL	0xf0
 #define VSC73XX_CAPRST		0xff
 
+#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
+#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
+#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -623,9 +627,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
-	/* Enable reception of frames on all ports */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
-		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -785,10 +786,6 @@ static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int port,
 	/* Allow backward dropping of frames from this port */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
-
-	/* Receive mask (disable forwarding) */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), 0);
 }
 
 static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
@@ -841,10 +838,6 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_ARBDISC, BIT(port), 0);
 
-	/* Enable port (forwarding) in the receieve mask */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), BIT(port));
-
 	/* Disallow backward dropping of frames from this port */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_SBACKWDROP, BIT(port), 0);
@@ -1036,6 +1029,86 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
+{
+	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
+	struct vsc73xx *vsc = ds->priv;
+	u16 mask;
+
+	if (state != BR_STATE_FORWARDING) {
+		/* Ports that aren't in the forwarding state must not
+		 * forward packets anywhere.
+		 */
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
+
+		dsa_switch_for_each_available_port(other_dp, ds) {
+			if (other_dp == dp)
+				continue;
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					    VSC73XX_SRCMASKS + other_dp->index,
+					    BIT(port), 0);
+		}
+
+		return;
+	}
+
+	/* Forwarding ports must forward to the CPU and to other ports
+	 * in the same bridge
+	 */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));
+
+	mask = BIT(CPU_PORT);
+
+	dsa_switch_for_each_user_port(other_dp, ds) {
+		int other_port = other_dp->index;
+
+		if (port == other_port || !dsa_port_bridge_same(dp, other_dp) ||
+		    other_dp->stp_state != BR_STATE_FORWARDING)
+			continue;
+
+		mask |= BIT(other_port);
+
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + other_port,
+				    BIT(port), BIT(port));
+	}
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_SRCMASKS + port,
+			    VSC73XX_SRCMASKS_PORTS_MASK, mask);
+}
+
+/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
+ * forwarded only from and to PI/SI interface. For more info see chapter
+ * 2.7.1 (CPU Forwarding) in datasheet.
+ * This function is required for tag_8021q operations.
+ */
+static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
+				       u8 state)
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
+		vsc73xx_refresh_fwd_map(ds, port, state);
+}
+
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
@@ -1051,6 +1124,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.port_stp_state_set = vsc73xx_port_stp_state_set,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
 };
 
-- 
2.34.1


