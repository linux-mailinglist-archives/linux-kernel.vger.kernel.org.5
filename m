Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3869783BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjHVIkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjHVIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:40:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9D5CC6;
        Tue, 22 Aug 2023 01:40:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5C221BF206;
        Tue, 22 Aug 2023 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692693643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CupauPWOKEGnv6ypWRmLX0hAKr1+lr/el0O5zqDzjfk=;
        b=fv42u8yalRi3HMRzqs5MhcdRJbFJqszlkvGxUJE7pBQA7wIie08tDx6KDG+o/4sdXCb1KK
        wocmGeAnJbzc1TyZ1YO0XDelBSYjbWfMlsd9m5CE+/eaWHx2rMqywVfk6vlGqYN2GXdfVQ
        tSVLV8W+B6JVjiXNrIr/WXyMMGjsp9EiBv3VIZCXK5xJIYWhEo5CkH6QfTaEoSKMTQACb4
        KJm3GL1ed1VZq65e76klD6cNO80J5sno2SxMIfS3FfadzGicUTxbWH3eLOmJ5u72hnIrFx
        HvQqFm4SQ90t1t/1bbUmB2sbJFix8cWFyQgB9DUxOr6Gu5MbymlBVU0SHWjPQQ==
From:   =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Leger?= <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next] net: dsa: rzn1-a5psw: remove redundant logs
Date:   Tue, 22 Aug 2023 10:41:12 +0200
Message-ID: <20230822084112.54803-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Remove debug logs in port vlan management, since there are already multiple
tracepoints defined for those operations in DSA

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
This update is a follow-up to Vladimir Oltean's comment (see [1]) which has
not been addressed before the RZN1 A5PSW vlan series merge

[1] https://lore.kernel.org/netdev/20230811100613.o77ei6updvbndkjm@skbuf/
---
 drivers/net/dsa/rzn1_a5psw.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 9167e83fbceb..2eda10b33f2e 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -735,10 +735,6 @@ static int a5psw_port_vlan_add(struct dsa_switch *ds, int port,
 	u16 vid = vlan->vid;
 	int vlan_res_id;
 
-	dev_dbg(a5psw->dev, "Add VLAN %d on port %d, %s, %s\n",
-		vid, port, tagged ? "tagged" : "untagged",
-		pvid ? "PVID" : "no PVID");
-
 	vlan_res_id = a5psw_find_vlan_entry(a5psw, vid);
 	if (vlan_res_id < 0) {
 		vlan_res_id = a5psw_new_vlan_res_entry(a5psw, vid);
@@ -767,8 +763,6 @@ static int a5psw_port_vlan_del(struct dsa_switch *ds, int port,
 	u16 vid = vlan->vid;
 	int vlan_res_id;
 
-	dev_dbg(a5psw->dev, "Removing VLAN %d on port %d\n", vid, port);
-
 	vlan_res_id = a5psw_find_vlan_entry(a5psw, vid);
 	if (vlan_res_id < 0)
 		return -EINVAL;
-- 
2.41.0

