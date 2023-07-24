Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19F775F407
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjGXK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjGXK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:59:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704C090;
        Mon, 24 Jul 2023 03:59:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b96789d574so55378601fa.2;
        Mon, 24 Jul 2023 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690196372; x=1690801172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pg3LdyxpJSkdMgcrpAAOq3iMwhvNlpKWfKdNTyn8mhQ=;
        b=fGCTLEynvWOQHnVbYne2y6L2d9vnBZo/jnGWEWmz9zuFcCXTvm6o667Ojx94ghpyA8
         bWcxKpvJTvskyvv38Ih75tsWtryCPG83LE1a11GYVAxD5gLrug468mwu6qGZaKSKxSqO
         7d5BLjzBONIjzO5Zt+gg+Ay4kKv0ku4wpVVAA8LfCjMJGcQDWmggzQ5UJpu26BOiIPU8
         R7+1FkiTzA9dhieeSAQBgqVV1+GqEU0baO62BtZliIcOV/49wXVx5pX/PVoEq+XS4m9o
         ZQFAkuoatPxqatCg0hVLqxx5rxionrbgXKTxMt4P0ZRV5q9vWNcGma+UGOwzSnzhTJfN
         nSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196372; x=1690801172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg3LdyxpJSkdMgcrpAAOq3iMwhvNlpKWfKdNTyn8mhQ=;
        b=BP3/X7kwMrXO+te9e/avjlMTK6X4UGBJoAc/vCJpcCD4yv+GNPKLqNH1PcbXmzgxHB
         Z31+SqRTKCctFK5YbO+9HAdu+dW/VdvCm1swS0cLMfhWxlzrrMygIkor7vzH0ILLPsTP
         PpbDHulns+ycgtzxexboGvyhhDRMKuL7zY0xqloSzwNCj8yKuYmzNFhjG5sz30KjrWda
         zpsbmWa0uLlQDyxN95jUjeYxwZX9oX4AiajpZ7Fgb+pzEW1MRnhYuNS57DEZLL9ECYu/
         KwBUV9OlxxPELjkX9VS04j4FDtpxb6mf0hPvXn7GMuUF0TwJzdOh2Er7IOBNSSnxg2OL
         DXVg==
X-Gm-Message-State: ABy/qLYsQHBtoMymOt6JAK+nNLs/yMYPEBzykzExiXjDWs7+4qSstj11
        5cXCO0NS2pZH4mnhiY8kJRY=
X-Google-Smtp-Source: APBJJlFLKQlYGJVUR8zBuBtVygQ6CORcyKk19Gzmrvbw88E6Skc6S40ZBE0E2VWtSblQH3gKWcnu6A==
X-Received: by 2002:a2e:990d:0:b0:2b6:9dd5:7a5 with SMTP id v13-20020a2e990d000000b002b69dd507a5mr5323602lji.12.1690196371615;
        Mon, 24 Jul 2023 03:59:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m14-20020a7bcb8e000000b003fbc9371193sm10055353wmi.13.2023.07.24.03.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:59:31 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH 3/3] net: dsa: qca8k: limit user ports access to the first CPU port on setup
Date:   Mon, 24 Jul 2023 05:30:58 +0200
Message-Id: <20230724033058.16795-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724033058.16795-1-ansuelsmth@gmail.com>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

