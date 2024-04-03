Return-Path: <linux-kernel+bounces-129575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64352896CBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AFE1C2619E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC7146A86;
	Wed,  3 Apr 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWczJYb6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFC139CF3;
	Wed,  3 Apr 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140690; cv=none; b=ngNjZ7ZAvtCdiOTz780dkGJyYDgnz0nhe7p9sA7O39xk47POIoaiZ6FjP6lcndk+0DSAN/N/EvyaSCR31/2lDcGTJeEF2noyO0OInPOoQAaPXH1a0qWZWX7al4DJteZ9hXD2SEtUJi6fLl0KOCgr/noE30AWj/MZrscD25dLMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140690; c=relaxed/simple;
	bh=auxB+6+vqSgfl8jAhbv72KSeilVDU0oDt++0lC5sFK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fytZUz0n4Tgha+y5tbJ41smFvq8hhHN572UZE72ANpy2n330oEswH/QpeeFVZVanFt3C9L6aff6FcF+Wz7CMCD/rBAOL9azt7t1zytI6rPsvBuf4NGsA1PuWS1CIdNok+mSo+CH86tCGhQTjKL1+mR8mcHj3OGJZuCCSh1hLiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWczJYb6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4a387ff7acso753931666b.2;
        Wed, 03 Apr 2024 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140687; x=1712745487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyJMqLNwYKzMWVCjPB1/HkePnJei0qr+ZbKH0COL8dA=;
        b=YWczJYb6Y/y8ulrCYjww55v3PrkfrZEZCz6e4vlIz0jsvIy5DfMifFdkeN8ZWks/Zz
         J3kt6Bi2w0n47eTf/cKVTauDDXE2OYWoaObpGQ7FI6yQlLjUDcjhkEUFgx5SOYMysVcu
         olrdqOAdmcp8ztNN+F65cgmaI+wvKs/mDfIzymXWyBko4SgTXHI6tSciWjp0mWSw16Yo
         lZ3IVGkI4C5rw+wBng/IEeULdpPDV1i6h2Ar7qAu8zN9QAbi93rvF87xGO2xWJf9iFAc
         g3TZnWz9ngMh7mPjXqVzgzb44vtJe8KfKcsHcudJWcN81jA3gLakZSBZ8oBiPzYLIIV7
         0FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140687; x=1712745487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyJMqLNwYKzMWVCjPB1/HkePnJei0qr+ZbKH0COL8dA=;
        b=tdhORDgD3MbFq99nSTcHqswymd51wpZyjJ7Gyi3YXeQvwtIG73lDiYrxwMdpcutFm4
         ooylzhDcbS4hReEN49CGP+TKF8g+ebmvjze0ChW1oJSKNMYNSKtLndmt3bnSEBU3sbUe
         d+krzkfK0KNTKItGMjWpBF+dwahepLTsQTp017+4KaPgc6kALKQvgvoCF32ywGrPzgwo
         NHZlChLXygo5JHA1SCM2O2bdEjI8IxxA8/poj0456NMpEgiXBnCogxIsOuVK9/qWIWHu
         UZZLaN5yltrWO9akh8ExF8/Sdru/H2O2RwxKui/V7PrOzl4cg4mpw/czlpzAjP1WO+Pq
         YHZg==
X-Forwarded-Encrypted: i=1; AJvYcCUDjtiy3kG0XIF4mroQtYbCPDpJ9krzQL7oU9j8m1YpGZ4KK54eMuvaW0XD04XeNFm6UJAqJKTuDZkneDh5c4FNAwxWJKbM5Kwuau94
X-Gm-Message-State: AOJu0Yytlb9aXhF1yOzCqV/iBjRY4BOruCUDtwv30loE0CYL3omQewvR
	8F04wgU9BGbFYOHRRkq7iF3t75UQ7PMwvJ2+r5MQRYPp3Xi3Oxs8ltf8srVogOg=
X-Google-Smtp-Source: AGHT+IH3wHdBzbm/GQWdmEEltBktXDdIgpfWIzLv0dfZvgE2zfmvYc0qaiit0dy9u0NrHslfNGdXRg==
X-Received: by 2002:a17:906:30c1:b0:a4e:2a62:7eb6 with SMTP id b1-20020a17090630c100b00a4e2a627eb6mr1421685ejb.51.1712140687354;
        Wed, 03 Apr 2024 03:38:07 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:06 -0700 (PDT)
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
Subject: [PATCH net-next v8 06/16] net: dsa: vsc73xx: add port_stp_state_set function
Date: Wed,  3 Apr 2024 12:37:22 +0200
Message-Id: <20240403103734.3033398-7-paweldembicki@gmail.com>
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

This isn't a fully functional implementation of 802.1D, but
port_stp_state_set is required for a future tag8021q operations.

This implementation handles properly all states, but vsc73xx doesn't
forward STP packets.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v8:
  - resend only
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


