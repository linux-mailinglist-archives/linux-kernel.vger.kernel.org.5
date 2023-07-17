Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E0D7559FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGQDNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGQDMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:12:43 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3A5C010F0;
        Sun, 16 Jul 2023 20:12:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 5E8326012605B;
        Mon, 17 Jul 2023 11:12:13 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next v3 7/9] net: mdio: Remove unnecessary (void*) conversions
Date:   Mon, 17 Jul 2023 11:12:12 +0800
Message-Id: <20230717031212.54991-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct xgene_mdio_pdata *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/mdio/mdio-xgene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 7aafc221b5cf..683e8f8319ab 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(xgene_mdio_wr_mac);
 
 int xgene_mdio_rgmii_read(struct mii_bus *bus, int phy_id, int reg)
 {
-	struct xgene_mdio_pdata *pdata = (struct xgene_mdio_pdata *)bus->priv;
+	struct xgene_mdio_pdata *pdata = bus->priv;
 	u32 data, done;
 	u8 wait = 10;
 
@@ -105,7 +105,7 @@ EXPORT_SYMBOL(xgene_mdio_rgmii_read);
 
 int xgene_mdio_rgmii_write(struct mii_bus *bus, int phy_id, int reg, u16 data)
 {
-	struct xgene_mdio_pdata *pdata = (struct xgene_mdio_pdata *)bus->priv;
+	struct xgene_mdio_pdata *pdata = bus->priv;
 	u32 val, done;
 	u8 wait = 10;
 
-- 
2.30.2

