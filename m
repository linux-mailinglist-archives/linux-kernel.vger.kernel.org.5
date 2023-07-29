Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1F7767EE8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjG2Lz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjG2LzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:55:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5093A9A;
        Sat, 29 Jul 2023 04:55:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317744867a6so2892841f8f.1;
        Sat, 29 Jul 2023 04:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690631718; x=1691236518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vvhoh9QJAZ5vY3S5v394L9Qg5vdXetVA6QXz3jblEY=;
        b=YTsZ3WetzFF2lSQzN8eTim4wzeGEeKvnpMKvOQd687rYOl+i+uP+cHh/qzqg3avwgL
         YLItAtWDH+xxcQtE2VY0dXMMBJqTdK89eSAiv7TnDRd0Rl4/f5HE3tqM5j4IyU7z+POL
         ocBEOdjf70DkJ7zMWdgATd80Us57UfmjfwgLoI1Gsx7NhzgMj75ykk79Sc8iFbloc9RU
         8MdcJ6kG0RYS7SXu8WVPdsA3hfFYL/tjfgXwQgyOOIXo31EjUZnLfgYhs5hGVQO6NmjX
         rCPgMEHXfgJNd3HUY8z1t3U3rzOhMUC6uAK170Q5kNGw+VBpnAjag6mgkVC5i55JIzg3
         zv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690631718; x=1691236518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Vvhoh9QJAZ5vY3S5v394L9Qg5vdXetVA6QXz3jblEY=;
        b=aWvnb0DEHRW48d2hiEZoQXBXZPb3h73Txsf024boQjlVLaeybb4Jr/ie9hDaQ/7OcS
         ZO8kfbMXcAgS6VKdmt6cXvOEOVXZSXe7d88PBZ2Dw7HdEQNeIvlooVPNfs6iOv1LFXhA
         yBeZnITfkv4WHJxJ4Y//AsESXOgNRWteMjgYgvmsWo6K0hNByq1XJzu3E6hJ2CxUHnzu
         2Sj8HcuW/XaVKLSvsgB3NFrnRE9I4CUGRlF56G656qJmz+AreWsaao/ATjDPzhw1CLO8
         TkCEjq1iqHpk/LkBUCHXYoKKyPA0I5+zC38jV5+ESbn1+rGThUe3PJOfAyLTmFbvxTdm
         j0ig==
X-Gm-Message-State: ABy/qLZfN7sx1gp644t5FskdxX0L0a5WDMXXoKXLQg17lQPJio7Rs80f
        5mPjS6bw8FOMTQJ8Tr2L8xo=
X-Google-Smtp-Source: APBJJlFH2pUYGCOVgkZSumMzTUZ2OTaTqlK4fr4UbAa9Ee3wv+9VoGbSBoqZdJoYhGne/0EFq6Qjfg==
X-Received: by 2002:a05:6000:1a47:b0:317:6ebe:d7c5 with SMTP id t7-20020a0560001a4700b003176ebed7c5mr3442130wry.51.1690631717945;
        Sat, 29 Jul 2023 04:55:17 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm7295289wrv.71.2023.07.29.04.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 04:55:17 -0700 (PDT)
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
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [net-next PATCH v2 3/5] net: dsa: qca8k: limit user ports access to the first CPU port on setup
Date:   Sat, 29 Jul 2023 13:55:07 +0200
Message-Id: <20230729115509.32601-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230729115509.32601-1-ansuelsmth@gmail.com>
References: <20230729115509.32601-1-ansuelsmth@gmail.com>
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

In preparation for multi-CPU support, set CPU port LOOKUP MEMBER outside
the port loop and setup the LOOKUP MEMBER mask for user ports only to
the first CPU port.

This is to handle flooding condition where every CPU port is set as
target and prevent packet duplication for unknown frames from user ports.

Secondary CPU port LOOKUP MEMBER mask will be setup later when
port_change_master will be implemented.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 31552853fdd4..6286a64a2fe3 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1850,18 +1850,16 @@ qca8k_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	/* CPU port gets connected to all user ports of the switch */
+	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(cpu_port),
+			QCA8K_PORT_LOOKUP_MEMBER, dsa_user_ports(ds));
+	if (ret)
+		return ret;
+
 	/* Setup connection between CPU port & user ports
 	 * Configure specific switch configuration for ports
 	 */
 	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
-		/* CPU port gets connected to all user ports of the switch */
-		if (dsa_is_cpu_port(ds, i)) {
-			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
-					QCA8K_PORT_LOOKUP_MEMBER, dsa_user_ports(ds));
-			if (ret)
-				return ret;
-		}
-
 		/* Individual user ports get connected to CPU port only */
 		if (dsa_is_user_port(ds, i)) {
 			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
-- 
2.40.1

