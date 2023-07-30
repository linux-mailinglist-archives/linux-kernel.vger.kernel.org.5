Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C487684AC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjG3JkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjG3JkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:40:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E161BE5;
        Sun, 30 Jul 2023 02:39:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso33518065e9.0;
        Sun, 30 Jul 2023 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690709997; x=1691314797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Rk7t1E5DhGQ1pORnpZFlzRE4LWcZ9ydkNYKXYDX32o=;
        b=DU50+8ijaCum0qT6GV+BHzU8I6sQEAdqXZmT1iI7+9pCysXpKGr/gI20kvpbGLhDpc
         +yRHN+5wZLbl3fK76BtNqXxEJdaVDgd5W/I5vtvJ/1i2jqrRIaVUm6JZ6jsZiyeCTzjp
         SX6/3j5o0kxw9TyIGF/N0zqTdsKdCWi3pQPcCwOVpui/TAy26aKQwbIscdY5BOnVkGi3
         H2BvctKPYOqtonmttjuqY8zWr6916377V53pOhFEYhxgBb8bFeXHK+rsDGPG0CvTBop0
         jAI4GwkPkjqEEalLCw3EHaesWUGOqzxStjBNOS8ZhSYmKTINdZsoFoXBEuITq/ioHgDi
         Coog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690709997; x=1691314797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Rk7t1E5DhGQ1pORnpZFlzRE4LWcZ9ydkNYKXYDX32o=;
        b=Tzni7VmSjYNtjTvKhRFeCPQTynlhHbmQPGNbRwz+UNePXSkigV2tbobD1Vvt8ghJSk
         bvk3J+mwUOtsN8Ol0CxVPqYLMkADE0P7zECpuyqDvNo+qEVw6VEIYtI5j+tN6vOJjdWf
         oqFMctpZuUwK3ofpSitPYOSTFo75AfWQCjvwsHzR3VWtQDmitkSGDO5KQJMWgf98dMAP
         MMc8wwF8RsDTc3K01BQlHGdZDPMCz+PK+IvQCTP73TAKY78jqT1UsNuyzwmJryDM2JDZ
         oWnD/jjXmb+XuYEN6yllOqf5UBuXJv9nEW3tjlM/LguLuRLIlc9bv8h4iFB16eRWZPYT
         KnOw==
X-Gm-Message-State: ABy/qLYvFtW5dCMu8tf43IfLzFRsnOY3ZHf9MQ7n2/NivChm1yHh26Mh
        Np5q9NSp7HcAeSP4OMXqSlI=
X-Google-Smtp-Source: APBJJlHHdAGqkph1WHpqRloPfuqnnY0hTB29cpMqUGBeHvwkhPcSVm/x+T/jia3q3Hx+3ZISedy/zg==
X-Received: by 2002:adf:fc10:0:b0:317:6459:e3ae with SMTP id i16-20020adffc10000000b003176459e3aemr4560322wrr.68.1690709997542;
        Sun, 30 Jul 2023 02:39:57 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffa90000000b0031423a8f4f7sm9574599wrr.56.2023.07.30.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 02:39:57 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Atin Bainada <hi@atinb.me>,
        Michal Kubiak <michal.kubiak@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH v3 5/5] net: dsa: qca8k: use dsa_for_each macro instead of for loop
Date:   Sun, 30 Jul 2023 09:41:13 +0200
Message-Id: <20230730074113.21889-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230730074113.21889-1-ansuelsmth@gmail.com>
References: <20230730074113.21889-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert for loop to dsa_for_each macro to save some redundant write on
unconnected/unused port and tidy things up.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
changes v3:
- Fix compilation error with unfinished patch in v2

 drivers/net/dsa/qca/qca8k-8xxx.c | 107 ++++++++++++++++---------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 81c6fab0a01b..f8a573679101 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1800,7 +1800,8 @@ static int
 qca8k_setup(struct dsa_switch *ds)
 {
 	struct qca8k_priv *priv = ds->priv;
-	int cpu_port, ret, i;
+	struct dsa_port *dp;
+	int cpu_port, ret;
 	u32 mask;
 
 	cpu_port = qca8k_find_cpu_port(ds);
@@ -1855,27 +1856,27 @@ qca8k_setup(struct dsa_switch *ds)
 		dev_warn(priv->dev, "mib init failed");
 
 	/* Initial setup of all ports */
-	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+	dsa_switch_for_each_port(dp, ds) {
 		/* Disable forwarding by default on all ports */
-		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(dp->index),
 				QCA8K_PORT_LOOKUP_MEMBER, 0);
 		if (ret)
 			return ret;
+	}
 
-		/* Enable QCA header mode on all cpu ports */
-		if (dsa_is_cpu_port(ds, i)) {
-			ret = qca8k_write(priv, QCA8K_REG_PORT_HDR_CTRL(i),
-					  FIELD_PREP(QCA8K_PORT_HDR_CTRL_TX_MASK, QCA8K_PORT_HDR_CTRL_ALL) |
-					  FIELD_PREP(QCA8K_PORT_HDR_CTRL_RX_MASK, QCA8K_PORT_HDR_CTRL_ALL));
-			if (ret) {
-				dev_err(priv->dev, "failed enabling QCA header mode");
-				return ret;
-			}
+	/* Disable MAC by default on all user ports */
+	dsa_switch_for_each_user_port(dp, ds)
+		qca8k_port_set_status(priv, dp->index, 0);
+
+	/* Enable QCA header mode on all cpu ports */
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		ret = qca8k_write(priv, QCA8K_REG_PORT_HDR_CTRL(dp->index),
+				  FIELD_PREP(QCA8K_PORT_HDR_CTRL_TX_MASK, QCA8K_PORT_HDR_CTRL_ALL) |
+				  FIELD_PREP(QCA8K_PORT_HDR_CTRL_RX_MASK, QCA8K_PORT_HDR_CTRL_ALL));
+		if (ret) {
+			dev_err(priv->dev, "failed enabling QCA header mode on port %d", dp->index);
+			return ret;
 		}
-
-		/* Disable MAC by default on all user ports */
-		if (dsa_is_user_port(ds, i))
-			qca8k_port_set_status(priv, i, 0);
 	}
 
 	/* Forward all unknown frames to CPU port for Linux processing
@@ -1897,48 +1898,48 @@ qca8k_setup(struct dsa_switch *ds)
 		return ret;
 
 	/* Setup connection between CPU port & user ports
-	 * Configure specific switch configuration for ports
+	 * Individual user ports get connected to CPU port only
 	 */
-	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
-		/* Individual user ports get connected to CPU port only */
-		if (dsa_is_user_port(ds, i)) {
-			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
-					QCA8K_PORT_LOOKUP_MEMBER,
-					BIT(cpu_port));
-			if (ret)
-				return ret;
-
-			ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
-						QCA8K_PORT_LOOKUP_LEARN);
-			if (ret)
-				return ret;
-
-			/* For port based vlans to work we need to set the
-			 * default egress vid
-			 */
-			ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(i),
-					QCA8K_EGREES_VLAN_PORT_MASK(i),
-					QCA8K_EGREES_VLAN_PORT(i, QCA8K_PORT_VID_DEF));
-			if (ret)
-				return ret;
-
-			ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(i),
-					  QCA8K_PORT_VLAN_CVID(QCA8K_PORT_VID_DEF) |
-					  QCA8K_PORT_VLAN_SVID(QCA8K_PORT_VID_DEF));
-			if (ret)
-				return ret;
-		}
+	dsa_switch_for_each_user_port(dp, ds) {
+		u8 port = dp->index;
+
+		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
+				QCA8K_PORT_LOOKUP_MEMBER,
+				BIT(cpu_port));
+		if (ret)
+			return ret;
+
+		ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(port),
+					QCA8K_PORT_LOOKUP_LEARN);
+		if (ret)
+			return ret;
 
-		/* The port 5 of the qca8337 have some problem in flood condition. The
-		 * original legacy driver had some specific buffer and priority settings
-		 * for the different port suggested by the QCA switch team. Add this
-		 * missing settings to improve switch stability under load condition.
-		 * This problem is limited to qca8337 and other qca8k switch are not affected.
+		/* For port based vlans to work we need to set the
+		 * default egress vid
 		 */
-		if (priv->switch_id == QCA8K_ID_QCA8337)
-			qca8k_setup_hol_fixup(priv, i);
+		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port),
+				QCA8K_EGREES_VLAN_PORT_MASK(port),
+				QCA8K_EGREES_VLAN_PORT(port, QCA8K_PORT_VID_DEF));
+		if (ret)
+			return ret;
+
+		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port),
+				  QCA8K_PORT_VLAN_CVID(QCA8K_PORT_VID_DEF) |
+				  QCA8K_PORT_VLAN_SVID(QCA8K_PORT_VID_DEF));
+		if (ret)
+			return ret;
 	}
 
+	/* The port 5 of the qca8337 have some problem in flood condition. The
+	 * original legacy driver had some specific buffer and priority settings
+	 * for the different port suggested by the QCA switch team. Add this
+	 * missing settings to improve switch stability under load condition.
+	 * This problem is limited to qca8337 and other qca8k switch are not affected.
+	 */
+	if (priv->switch_id == QCA8K_ID_QCA8337)
+		dsa_switch_for_each_available_port(dp, ds)
+			qca8k_setup_hol_fixup(priv, dp->index);
+
 	/* Special GLOBAL_FC_THRESH value are needed for ar8327 switch */
 	if (priv->switch_id == QCA8K_ID_QCA8327) {
 		mask = QCA8K_GLOBAL_FC_GOL_XON_THRES(288) |
-- 
2.40.1

