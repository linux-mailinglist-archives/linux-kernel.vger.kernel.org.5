Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD92751DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjGMJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjGMJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:58:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B0212B;
        Thu, 13 Jul 2023 02:58:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so898977e87.3;
        Thu, 13 Jul 2023 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689242301; x=1691834301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cojSysAMXAGtnXzivDEmLEf5S6SkC06gAHJZrjzFWos=;
        b=eqzkyxfdBiS/0GFbYznPWRyufD/z4GsnNmgmkFRC0Uih1WtmgqqUyrkxbDekFMJHT2
         D2xdo73XnJNS9R4WvDoK1s7ORaVsP2NuEA5DdjN7KO3Sax2JW+ZHq9qR0lxqjPXi7M/w
         4aQI6GowaRyEhRFYZKV+6cmfw64m4gwfwMTfVaASR6OaMxu2D7lu+CCZYCcP61Q8zL07
         +L00KNGS1o6nbH7DBnPFWDe0Ra8kkeEKZY2VhfGTi4Q8FsozJkZhZJoWZJjsJSYBfVU7
         1JRx9XUWv+wU4v2GRzqkcMaQVUO1G5fiylynRNfjoCMmnqu47Ua3KyT39MLyzP2E1m0+
         y5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242301; x=1691834301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cojSysAMXAGtnXzivDEmLEf5S6SkC06gAHJZrjzFWos=;
        b=cFIW8WPxZ3sUUga8Ecv8MsK9C/gObNgyWw7wkl4f/KGioxPQ6sDz3wLsTA3jjre2h0
         qsr2FGyy13vtV8Ouq/TekbsmNVfRzB6c5n7rxd2dI/fysurEbkOPdIvvMXrZGxKP0/O6
         Xe9tJrFi+FTn91SmP82h7k/YtPlBQ3Dm9C4LIdoOvDcaN+J4vf6lfDZ49EOFLzuJdYqa
         bO4IetEASHSu2H/ESpkQsvZfyHalrVDpSEU8tzOk0Iwfzj922TfYc9KKqM2mkb5ML8Za
         Uqa4Lf3VLHvgXyslJr1gxWKsYh1U0ei6+z+Gp/YNlnrHC8GkxgAPPaksvmUjGnpMDwUL
         YADQ==
X-Gm-Message-State: ABy/qLa8hPOW8wPc3iliabeRgkpULRXn6pf0vrShzHS4Kyo4YxSLPsFt
        /DFAIs5q9ibKLl6oxpd5EKB0AONejdrxjw==
X-Google-Smtp-Source: APBJJlEm6+XHxZtoswu/zB4wJP8OnPnpvO9fT6LNOOeNewb14cpRxqHFRmCLYMoP2GTU0GshA1HLHQ==
X-Received: by 2002:a05:6512:3b2a:b0:4fa:9817:c1da with SMTP id f42-20020a0565123b2a00b004fa9817c1damr1077376lfv.21.1689242300402;
        Thu, 13 Jul 2023 02:58:20 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id i9-20020ac25d29000000b004faa82946d8sm1056932lfb.178.2023.07.13.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:58:19 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-22) with ESMTP id 36D9wGaC030561;
        Thu, 13 Jul 2023 12:58:17 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 36D9wCKD030560;
        Thu, 13 Jul 2023 12:58:12 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Liang He <windhl@126.com>, Geoff Levand <geoff@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Fertser <fercerpav@gmail.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ftgmac100: support getting MAC address from NVMEM
Date:   Thu, 13 Jul 2023 12:57:43 +0300
Message-Id: <20230713095743.30517-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of of_get_ethdev_address() to support reading MAC address not
only from the usual DT nodes but also from an NVMEM provider (e.g. using
a dedicated area in an FRU EEPROM).

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a03879a27b04..9135b918dd49 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -177,16 +177,20 @@ static void ftgmac100_write_mac_addr(struct ftgmac100 *priv, const u8 *mac)
 	iowrite32(laddr, priv->base + FTGMAC100_OFFSET_MAC_LADR);
 }
 
-static void ftgmac100_initial_mac(struct ftgmac100 *priv)
+static int ftgmac100_initial_mac(struct ftgmac100 *priv)
 {
 	u8 mac[ETH_ALEN];
 	unsigned int m;
 	unsigned int l;
+	int err;
 
-	if (!device_get_ethdev_address(priv->dev, priv->netdev)) {
+	err = of_get_ethdev_address(priv->dev->of_node, priv->netdev);
+	if (err == -EPROBE_DEFER)
+		return err;
+	if (!err) {
 		dev_info(priv->dev, "Read MAC address %pM from device tree\n",
 			 priv->netdev->dev_addr);
-		return;
+		return 0;
 	}
 
 	m = ioread32(priv->base + FTGMAC100_OFFSET_MAC_MADR);
@@ -207,6 +211,8 @@ static void ftgmac100_initial_mac(struct ftgmac100 *priv)
 		dev_info(priv->dev, "Generated random MAC address %pM\n",
 			 priv->netdev->dev_addr);
 	}
+
+	return 0;
 }
 
 static int ftgmac100_set_mac_addr(struct net_device *dev, void *p)
@@ -1843,7 +1849,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	priv->aneg_pause = true;
 
 	/* MAC address from chip or random one */
-	ftgmac100_initial_mac(priv);
+	err = ftgmac100_initial_mac(priv);
+	if (err)
+		goto err_phy_connect;
 
 	np = pdev->dev.of_node;
 	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-- 
2.34.1

