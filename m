Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B778DDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbjH3SxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242722AbjH3JVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:21:42 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A1819A;
        Wed, 30 Aug 2023 02:21:38 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 90B5A80275;
        Wed, 30 Aug 2023 11:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693387296;
        bh=8gcFOC/2uBV9d6Zh6OBWuDG8T9992HsFPQ8XUQ9AYYc=;
        h=From:To:Cc:Subject:Date:From;
        b=kx5VvspDtHYkAP1o9+LbpHM5F8xUEufZhJ1X6vmAffyF62M7m6bKwuVi/dNTw2Qg5
         n/b+GxJXmMWndywlIhvmrLQprYUSMKrGe9G6JFEID4vcElNrbPqBp6VOib7gWlTsFX
         WxI+uEYgWDsPS9sYPpCbbIg36EckkxU4ZxEh2xwRP4RRZ5/bGfweReU2U2Ln0BmHnB
         6piHv2M5XAQWtqTxKcrlBa4DKctObjD2qEnbGk7AgtlZ0/dB7ZwRYijoTmxzSmzQ6C
         nWDgIUd5VA0PJbTozwTBipBaVvUZFk42B/XsJycVF9F7A+aDN9XVtdHGmJot79qPEq
         UY0xRm5K4otfw==
From:   Lukasz Majewski <lukma@denx.de>
To:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] net: phy: Rename KSZ9477 get features function (to ksz9131_get_features)
Date:   Wed, 30 Aug 2023 11:21:18 +0200
Message-Id: <20230830092119.458330-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KSZ9131 differs in supported features from KSZ9477 - namely in the
EEE (Energy Efficient Ethernet) support.

To prepare the code for upcoming changes the ksz9477_get_features
has been renamed to ksz9131_get_features.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/net/phy/micrel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index b6d7981b2d1e..87b090ad2874 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1398,7 +1398,7 @@ static int ksz9131_config_aneg(struct phy_device *phydev)
 	return genphy_config_aneg(phydev);
 }
 
-static int ksz9477_get_features(struct phy_device *phydev)
+static int ksz9131_get_features(struct phy_device *phydev)
 {
 	int ret;
 
@@ -4829,7 +4829,7 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= kszphy_resume,
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
-	.get_features	= ksz9477_get_features,
+	.get_features	= ksz9131_get_features,
 }, {
 	.phy_id		= PHY_ID_KSZ8873MLL,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -4871,7 +4871,7 @@ static struct phy_driver ksphy_driver[] = {
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-	.get_features	= ksz9477_get_features,
+	.get_features	= ksz9131_get_features,
 } };
 
 module_phy_driver(ksphy_driver);
-- 
2.20.1

