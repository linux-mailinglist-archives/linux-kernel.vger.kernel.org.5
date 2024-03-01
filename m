Return-Path: <linux-kernel+bounces-89191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81FD86EBC2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643F91F23E61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B65DF1E;
	Fri,  1 Mar 2024 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfvIHDnc"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B35DF0F;
	Fri,  1 Mar 2024 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331509; cv=none; b=H+fYT/aFHjO9gG7yfnAS1jryWstE/vjHM/W+SdS5fgcysw+XdW2/OL+C7frFL7aPZoF37SgYMOwYgNDN3pJ+ASJ8HWR7R7QGZTwkIK7F3nnL/eyu2NRehBEKm/IQ+H1ZIEfbfdMI7SMwfH7vNvcJ63tnl0Hcux+VvxO2w1mvIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331509; c=relaxed/simple;
	bh=oMWfEUdkiHtgDJv4f5ewX+cq0ViokbW9l3TCC6Yn3Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgZeicsAVl5tj0YvryRxVhAe12KirB3IreUOGr1uU7Sis1ffng8dOJNSAhlmN/777J31gCqRzATEiXHhwzlNpeNVv8AUafnq9fpMAsbv3u2L/tJLvuoX9fADYUd33SWGf3GRJzszcJmA3SIb+fWjg8NfUW7FnPcSlOxRu8SMbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfvIHDnc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3566c0309fso359571766b.1;
        Fri, 01 Mar 2024 14:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331506; x=1709936306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYa5oSkzGFM4mmqUgWirMBxknEvs8NNQYFQwruOE0as=;
        b=WfvIHDncr7+bVQaaYaSdNSUDyC8ktj/Q2RhKc/cq46ga80VpYRLz49vQcgMX+iNbPJ
         jqQEC/S/SYlLxu1ZqOvaHMkSkuaXlWM/1138TtwglEF+n7jRtFegf7ZMXZUGrMiSWZqT
         2GzGwF3LXSuDiPA7oOM2I1FWXpDlSpsneBRcXlBvi9CS11NNqoZqkgtpkirZPUSZj7C6
         LqJpOwg8hXiltPloaCjo1I29hU58PhodGD2QMeL/Ay+GgWMD7HUj8qYerpYAWEkv4bor
         C7PW9dSiGLPE/hD1b8DxzLldCzWm9ktQh0BEEN7brauATQZIkSoR1ZlRF1RJiDU8kRTH
         Og8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331506; x=1709936306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYa5oSkzGFM4mmqUgWirMBxknEvs8NNQYFQwruOE0as=;
        b=UkO06QkL/OOPUeXpu2sPVwxQHf0sKGtJsL1GleIV8GOYj6+voyWi6venZX5tUYj592
         PVrFFyu3CEF2Dn422gGcDrMLdWHDDpyHRirwKTgU8XQwpOb/G7B7u+awocl7RwU1OkEu
         OdktLTaTAbedatWVcNp+LaSWqGj7Lm1QuQNdASl7kFdY5ZOLx77JTo3DJ21k0znNAJZF
         qYkPOXe59XNqiwi0dlHRBF/s6Dcb+pQ1JvNduLfOCuW0+31uyGEUSbaWywcEnxO47jcQ
         obJbQA3ef/f3BFBYfGaBp39aaCID7avb9UckP9jsTwi1edmn7yh58AFfWNIAaygHr2jT
         v70Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyOrXilgPj8x5HGZuQTvAivwl++ua7JTfcX6X9qateJb9p7PCcf7ipbjalyBcpSK6KkuRIC9qnYDDpZhXAb9+qFkk+ibG0msdLN1dD
X-Gm-Message-State: AOJu0Yyp5uC+12DTV2lWoY+TbPX+HAvdhhOnVmGwRakkwcD4rkX1MfpJ
	PXspt3dtV9sCp9MmeqCf0RkczBJajwWQ0rxCagS7Hw79pyiKNYKLsPkNlBsksnU=
X-Google-Smtp-Source: AGHT+IGqUySkaqbS71UhvrTchYNKYXYkyC5tA7GKZ0qgu42XB9vpSjL0efPBNPtJYi4JMUqA3FxDJQ==
X-Received: by 2002:a17:906:4685:b0:a44:97fc:bc56 with SMTP id a5-20020a170906468500b00a4497fcbc56mr2039398ejr.76.1709331506049;
        Fri, 01 Mar 2024 14:18:26 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:18:25 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
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
Subject: [PATCH net-next v6 15/16] net: dsa: vsc73xx: Add bridge support
Date: Fri,  1 Mar 2024 23:16:37 +0100
Message-Id: <20240301221641.159542-16-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds bridge support for vsc73xx driver.
It introduce two functions for port_bridge_join and
vsc73xx_port_bridge_leave handling.

Those functions implement forwarding adjust and use
dsa_tag_8021q_bridge_* api for adjust VLAN configuration.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - remove forward configuration after stp patch refactoring
  - implement new define with max num of bridges for tag8021q devices
v3:
  - All vlan commits was reworked
  - move VLAN_AWR and VLAN_DBLAWR to port setup in other commit
  - drop vlan table upgrade
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index f8175a33c0a6..e7dea48672d7 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -687,6 +687,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
+	ds->untag_bridge_pvid = true;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_MASTER_RESET);
@@ -1587,6 +1590,22 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
+				    struct dsa_bridge bridge,
+				    bool *tx_fwd_offload,
+				    struct netlink_ext_ack *extack)
+{
+	*tx_fwd_offload = true;
+
+	return dsa_tag_8021q_bridge_join(ds, port, bridge);
+}
+
+static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				      struct dsa_bridge bridge)
+{
+	dsa_tag_8021q_bridge_leave(ds, port, bridge);
+}
+
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -1721,6 +1740,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = vsc73xx_port_bridge_join,
+	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1


