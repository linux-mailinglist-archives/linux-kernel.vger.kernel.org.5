Return-Path: <linux-kernel+bounces-129585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39786896CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93501286E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38C6149DE3;
	Wed,  3 Apr 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyR2CME8"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165C149C65;
	Wed,  3 Apr 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140723; cv=none; b=DAwFf9E3uGIhk85unAH6cmEfPz7ncmDTZB3wdifAJYcY5Dgu4Wwc9y7Mynl6X1ex+8vzOa8tPLfjUU1n0JQO7YrI/k1ZxJ+DmTHKA5refUKD+ec1l4JQESe0eQZuf577PqZRRDgiPa6PDq3RxXXHNx/sFMAydpywbUtBNeyz74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140723; c=relaxed/simple;
	bh=lsJZYamIb7pKWq/pJ2WHv4Qhp7DutSf4JF7cAzPEE8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrUXljxSktSSDH03COuAMCTKDR8pFL5ujWmd3lsP7R28MjPZt+K7FcJ6rVID4EjCbV/DlKzI0AA1G2mFpFN7oH4i42QylJ/L+119TbQndijbNFduSgJx6jJv0ckJF57eyNJZjrrn94uZX7AwVhBUkQ6PgezpHif8JFJhIBODHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyR2CME8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a47385a4379so153289066b.0;
        Wed, 03 Apr 2024 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140720; x=1712745520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwXfSiRRYMgELktuVNuW2aivXcVrEj4Wx7dt2BW3WIo=;
        b=ZyR2CME8VEb+TJKtlinza6Uy4kNatfywPFv+uf+NuiV0pp/jLk0TvAdmd/hlMdrdyN
         XziREP7zHJB/ady3k9qQE3i3wOGlmWgwSB+edpkKXGJgzRM5Y1w9G9HzO7Dm6UzvDKwz
         IKWWfymlDU/0QzXxY2pTWMgrqZVIHHf2krGUVBRBi+Trx7clYcx8Zb/sBxG0T0jmaElC
         IRt8eWxDJC8+pt/WZ2JyC/kKlryBNUtKlDo/CnwD8JSroz69YOlhhW+oVQIJt6AiGsQL
         7pGU9nMheDPAnQpVIZX4r3GV5HzIvhGC6HVDFYM3X35OHAeV3juu+Rrtth8Qg0cgV7cl
         LWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140720; x=1712745520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwXfSiRRYMgELktuVNuW2aivXcVrEj4Wx7dt2BW3WIo=;
        b=vfcLgI/CuQ46AzNLCnzy5yaqHppudoBAGWb22FvP5XQbeWRixEO9tQe/ojsYTmh0Eh
         Utndpdcky6kPq3tUsd4omBBD/519OzGd2/kEjrwDN21fO2HQHj8KfYrF4dVZdcEO24y/
         ZwK4YwssDXWa4Zr5ZCqnJ+srIXeF1XRqB6R2XvSYAklSHivpxV4f5eSSjbhJix6PUrIo
         YB2J9EhHP/w829h8d0XJHtHz6iBcS4afYNCvll0QumHyqwpLzpBzU8YGbMw0VYIiLxmL
         tmYFO8RjEPYmJ0O6d6K4RKE7NV32fqSxlytEMioMHWv9zIR6Hka1VOz4O+nEUde+APhH
         bofQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNs6pzIq9b2v06Sf44vd5A8umjpVnvt8pdUjklxbaLNpQndjBRlYDKyFJSwc3xyIui0AaaC0ICB/4QXuzmU60CWcSBzr8B+F07MMiZ
X-Gm-Message-State: AOJu0YyqbDPWhV0tbuZT1rD/3mZGUsD3r/JnoizbZSXFK/Mh430xb9OR
	s21yGe+cI/9ZJ78bOfxFJcwkA878asl9+yXGvOf5nYIvFsLVkH7Y6W7ctoVphIg=
X-Google-Smtp-Source: AGHT+IG+QtCZKqPMzZNQVwNyVKDtHDuBSBbJvPN37rAVDUNJjrkTWV1iD5+oITX8pfXlygCN+jhd8g==
X-Received: by 2002:a17:906:e2c9:b0:a51:6386:2a5b with SMTP id gr9-20020a170906e2c900b00a5163862a5bmr448387ejb.0.1712140720276;
        Wed, 03 Apr 2024 03:38:40 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:40 -0700 (PDT)
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
Subject: [PATCH net-next v8 16/16] net: dsa: vsc73xx: start treating the BR_LEARNING flag
Date: Wed,  3 Apr 2024 12:37:32 +0200
Message-Id: <20240403103734.3033398-17-paweldembicki@gmail.com>
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

This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
which are required for properly treating the BR_LEARNING flag. Also,
port_stp_state_set() is tweaked and now disables learning for standalone
ports.

Disabling learning for standalone ports is required to avoid situations
where one port sees traffic originating from another, which could cause
packet drops.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v8:
  - resend only
v7:
  - added 'Acked-by' and 'Reviewed-by' and improve  commit message
v6:
  - fix arranging local variables in reverse xmas tree order
v5:
  - introduce patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 41 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 87922804d1c1..90ca791add06 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1588,6 +1588,31 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
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
+		u32 val = flags.val & BR_LEARNING ? BIT(port) : 0;
+		struct vsc73xx *vsc = ds->priv;
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
@@ -1693,19 +1718,21 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
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
@@ -1727,6 +1754,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
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


