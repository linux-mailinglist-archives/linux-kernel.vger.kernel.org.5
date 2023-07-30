Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C605D7684A8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjG3Jj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjG3Jjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:39:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817701BDC;
        Sun, 30 Jul 2023 02:39:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31783d02093so3157121f8f.0;
        Sun, 30 Jul 2023 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690709993; x=1691314793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVvb7llve9pJsIAfqXRB6HIfyDuylIO0ZQ0la81l44g=;
        b=BlMKD5Cew4zlPpXl/ocIrOS5kdJwUJWm+yxbb+4l2Cb4UUmmRx1VkU+fBU+qNm6oIw
         CocroWdcv8AOYZy5rMG9w6dcyl6xYwwjdxghopNf5f/oBnWdE8xNFGCx8oQ3spxtQPr1
         ouDwWQHdUQEHlRtpvsLs0eLHr8of5wfbF1dhoojn8n+dxLX1Chd2CsPzqaoMtlMGAuFA
         ymt67C8pJsyShJQ8tpP1ZHUmLfMuSSVN5HTiqGn198I4XFpYpMTqC2lgAGzLxNq3KdCg
         GtT4gtm9/SLPKjZJAX41TLszWyP9RTatVDNmVGFfUNk9+PXxGOMnUFNdxuIdsXlW00Bv
         ERqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690709993; x=1691314793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVvb7llve9pJsIAfqXRB6HIfyDuylIO0ZQ0la81l44g=;
        b=CzCXfhelWWybs7wlMoopFr1QQyCJ6duSjAihyWC12Oob7Wp4+CaptOiDCEeTFcHY/m
         rum/Otnfkrgq5G/JTYjWLqQSGYabPogJNv8b3r0QnMii+iR4LQr+KCyxY8gVJ6fnaY9N
         qX7qavt9LpJX7Sn8pOhzGHuDH1r3MNRcW5CbK68VdTn3QMxbbyZEZ00scecpIl4ysdaw
         r0Hqr22raHqDGNUq79OL2x7anEb5nY/RCtWe1/rS150Kf+/w8woBtRbtypkQCWoEnpg5
         OM0UcYPRk5u35ua722V2DPBdOSDQRsAyMjHzijdXb8Cy7I4pEbO8LOHX01itq/8/YkZJ
         H5PQ==
X-Gm-Message-State: ABy/qLZj+Afz5ZTlPRwqPtaAY2PCs+uC1C+v8kwwm33cfHcsj3tfSPf/
        Imb/XN8leymM8rbEBMjIV94=
X-Google-Smtp-Source: APBJJlHJU5YOEh/lpQ/szAo8ABLBqQepFNnIBQ3XmVCJuP31gQV/ldPNNtqYeR3O2taiQMNedoRemw==
X-Received: by 2002:a5d:548b:0:b0:316:fc86:28ae with SMTP id h11-20020a5d548b000000b00316fc8628aemr6491695wrv.15.1690709992651;
        Sun, 30 Jul 2023 02:39:52 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffa90000000b0031423a8f4f7sm9574599wrr.56.2023.07.30.02.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 02:39:52 -0700 (PDT)
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
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [net-next PATCH v3 2/5] net: dsa: qca8k: make learning configurable and keep off if standalone
Date:   Sun, 30 Jul 2023 09:41:10 +0200
Message-Id: <20230730074113.21889-2-ansuelsmth@gmail.com>
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

Address learning should initially be turned off by the driver for port
operation in standalone mode, then the DSA core handles changes to it
via ds->ops->port_bridge_flags().

Currently this is not the case for qca8k where learning is enabled
unconditionally in qca8k_setup for every user port.

Handle ports configured in standalone mode by making the learning
configurable and not enabling it by default.

Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
enable learning for bridge that request it and tweak
.port_stp_state_set to correctly disable learning when port is
configured in standalone mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
changes v2:
- Add review tag
- Change qca8k_port_bridge_flags to be more explicit with flag handling
  as suggested by Vladimir

 drivers/net/dsa/qca/qca8k-8xxx.c   |  7 +++--
 drivers/net/dsa/qca/qca8k-common.c | 48 ++++++++++++++++++++++++++++++
 drivers/net/dsa/qca/qca8k.h        |  6 ++++
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ae088a4df794..31552853fdd4 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1870,9 +1870,8 @@ qca8k_setup(struct dsa_switch *ds)
 			if (ret)
 				return ret;
 
-			/* Enable ARP Auto-learning by default */
-			ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
-					      QCA8K_PORT_LOOKUP_LEARN);
+			ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
+						QCA8K_PORT_LOOKUP_LEARN);
 			if (ret)
 				return ret;
 
@@ -1978,6 +1977,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.port_change_mtu	= qca8k_port_change_mtu,
 	.port_max_mtu		= qca8k_port_max_mtu,
 	.port_stp_state_set	= qca8k_port_stp_state_set,
+	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
+	.port_bridge_flags	= qca8k_port_bridge_flags,
 	.port_bridge_join	= qca8k_port_bridge_join,
 	.port_bridge_leave	= qca8k_port_bridge_leave,
 	.port_fast_age		= qca8k_port_fast_age,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13b8452ce5b2..fce04ce12cf9 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -565,9 +565,26 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
+					 bool learning)
+{
+	struct qca8k_priv *priv = ds->priv;
+
+	if (learning)
+		return regmap_set_bits(priv->regmap,
+				       QCA8K_PORT_LOOKUP_CTRL(port),
+				       QCA8K_PORT_LOOKUP_LEARN);
+	else
+		return regmap_clear_bits(priv->regmap,
+					 QCA8K_PORT_LOOKUP_CTRL(port),
+					 QCA8K_PORT_LOOKUP_LEARN);
+}
+
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct qca8k_priv *priv = ds->priv;
+	bool learning = false;
 	u32 stp_state;
 
 	switch (state) {
@@ -582,8 +599,11 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 		break;
 	case BR_STATE_LEARNING:
 		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
+		learning = dp->learning;
 		break;
 	case BR_STATE_FORWARDING:
+		learning = dp->learning;
+		fallthrough;
 	default:
 		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
 		break;
@@ -591,6 +611,34 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
+
+	qca8k_port_configure_learning(ds, port, learning);
+}
+
+int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				struct switchdev_brport_flags flags,
+				struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
+			    struct switchdev_brport_flags flags,
+			    struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	if (flags.mask & BR_LEARNING) {
+		ret = qca8k_port_configure_learning(ds, port,
+						    flags.val & BR_LEARNING);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index c5cc8a172d65..8f88b7db384d 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -522,6 +522,12 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
 
 /* Common bridge function */
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
+int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				struct switchdev_brport_flags flags,
+				struct netlink_ext_ack *extack);
+int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
+			    struct switchdev_brport_flags flags,
+			    struct netlink_ext_ack *extack);
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 			   struct dsa_bridge bridge,
 			   bool *tx_fwd_offload,
-- 
2.40.1

