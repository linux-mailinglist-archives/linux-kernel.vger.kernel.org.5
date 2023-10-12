Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8514A7C7829
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442682AbjJLUxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347397AbjJLUxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:53:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76C8BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:53:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ace796374so1197981276.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697144011; x=1697748811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9qMyKcmw99DX827Us0Ir8X62G9i7RVHJymUAik4/rk4=;
        b=0d5nCSJlTdRhUPHwhYQnxoVi3UtZ574BnEENc2+2qBtCNVTGARki6Mih+71cApVv2Z
         u8JEb51OWMNUbLsiqtVd+RDEzRcYIles3pd8ogtAhTlR1eomYHJj4TgQmq7zxKzh3e1R
         M3J1w+8IE//EhFMVCEBQ2c0Jw/amaii+wRabYt1MPXeb+Aq/pR+4F8dXHkqIOq4rvckM
         GzjJnHtoNhQNBtzH2zrqHqD03FSIzjU/DRRdGufZ6HeQEQ8JA0Q09v4rM43AfzznCctR
         5KDVEgW8v1yPRsYzEWwzT69aYi1eM3LQPXebTICxZ3jphug7fU+yrjuTHuN+/DSilo+S
         z0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144011; x=1697748811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qMyKcmw99DX827Us0Ir8X62G9i7RVHJymUAik4/rk4=;
        b=ccPjBvD3BHNzVKQ4sXpsUQf/Wlu0FVUvHlnMpAqn26wryuFZ3K8sjuxcL0gt8SDmk+
         Dsak15FeRPowgFfhJboVPXFOHEdphAEVSnoiZ6J9oUYzeUJ6Ye/jMhj6F0nLV88VjkVb
         yVVhlJ6TvVSyZxmrpPwijyaXrIxYx+KLxHBC27KPbZOClct6CusJ1MgMdv238nrnur8I
         xTnGS4eNGlDwDOCLnDoVK2DfTCQjGvDODlZohFlkoKXc8uao5J3TWUMgAM8Mmtze42ja
         ZCR/tLvPViqBH6yOHH/cjvXO8ppQoGPRwDL5cRVFITP5C5S79gRxYmt+bO2Sq+S0oe9m
         wYrQ==
X-Gm-Message-State: AOJu0Ywv6VLA2hg4gDul/2Z9F4ZlZZ0Cbfmd5/GqD038j+1VJp/toWfF
        793eiIwJ53e5cA7uENOC512cXKGKqly0dWg9jw==
X-Google-Smtp-Source: AGHT+IH3gGvUMFkpZyn2OdHdiE2aCb3F0wUpMTtBIvNk1WAdia53rQdbysSXuYs/OpqtdoR3yKA3z1upKDpbTP6KCg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:73c6:0:b0:d9a:47ea:69a5 with SMTP
 id o189-20020a2573c6000000b00d9a47ea69a5mr201863ybc.1.1697144010383; Thu, 12
 Oct 2023 13:53:30 -0700 (PDT)
Date:   Thu, 12 Oct 2023 20:53:30 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMlcKGUC/x2NMQ7CMAwAv1J5xlKTqEP4CmIottt6IER2VIGq/
 p3AdrfcHeBiKg7X4QCTXV1fpUu4DEDbXFZB5e4Qx5jCGCJ6s0L1g2y6izkWaShtE/tBU6T6nAk JM2cOj5R4yhP0WjVZ9P0/3e7n+QXDonCYeQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697144009; l=3180;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wSXQtO6YQEI2fzVqzOd2KMWvl+reGo3f85eDud1+9jM=; b=uf2ccLXY05oAOnVAj/yVAodzrjxLDwPefdZMr52ViFvbdYe6uBHPN1PnSK7aH0QQ27qBClyiS
 cF1SLN7sE0pCPW4hlYyjuqbi0XD6avEvcVP8OzIVMsvut7PgK//LWZZ
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
Subject: [PATCH] net: cpmac: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect mdio_bus_id to be NUL-terminated based on its use with
snprint():
|       snprintf(priv->phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT,
|                                               mdio_bus_id, phy_id);

Moreover, as this is the only use of mdio_bus_id, we can see that
NUL-padding is not required.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Note that for the replacement involving cpmac_mii->id, the source
buffer's length is equal to MII_BUS_ID_SIZE which could result in a
buffer overread. However, there is no buffer overread since "cpmac-1"
(the string copied into cpmac_mii->id) is smaller than MII_BUS_ID_SIZE
thus meaning the previous usage of strncpy() here did _not_ have any
overread bugs. Nonetheless, let's still favor strscpy() over strncpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/ti/cpmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
index 80eeeb463c4f..714328ee7487 100644
--- a/drivers/net/ethernet/ti/cpmac.c
+++ b/drivers/net/ethernet/ti/cpmac.c
@@ -1068,7 +1068,7 @@ static int cpmac_probe(struct platform_device *pdev)
 	pdata = dev_get_platdata(&pdev->dev);
 
 	if (external_switch || dumb_switch) {
-		strncpy(mdio_bus_id, "fixed-0", MII_BUS_ID_SIZE); /* fixed phys bus */
+		strscpy(mdio_bus_id, "fixed-0", sizeof(mdio_bus_id)); /* fixed phys bus */
 		phy_id = pdev->id;
 	} else {
 		for (phy_id = 0; phy_id < PHY_MAX_ADDR; phy_id++) {
@@ -1076,7 +1076,8 @@ static int cpmac_probe(struct platform_device *pdev)
 				continue;
 			if (!mdiobus_get_phy(cpmac_mii, phy_id))
 				continue;
-			strncpy(mdio_bus_id, cpmac_mii->id, MII_BUS_ID_SIZE);
+			strscpy(mdio_bus_id, cpmac_mii->id,
+				sizeof(mdio_bus_id));
 			break;
 		}
 	}
@@ -1084,10 +1085,9 @@ static int cpmac_probe(struct platform_device *pdev)
 	if (phy_id == PHY_MAX_ADDR) {
 		dev_err(&pdev->dev, "no PHY present, falling back "
 			"to switch on MDIO bus 0\n");
-		strncpy(mdio_bus_id, "fixed-0", MII_BUS_ID_SIZE); /* fixed phys bus */
+		strscpy(mdio_bus_id, "fixed-0", sizeof(mdio_bus_id)); /* fixed phys bus */
 		phy_id = pdev->id;
 	}
-	mdio_bus_id[sizeof(mdio_bus_id) - 1] = '\0';
 
 	dev = alloc_etherdev_mq(sizeof(*priv), CPMAC_QUEUES);
 	if (!dev)

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-9d9d1b33d595

Best regards,
--
Justin Stitt <justinstitt@google.com>

