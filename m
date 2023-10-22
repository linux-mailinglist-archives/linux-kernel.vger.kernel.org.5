Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E257D25F2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 22:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjJVUxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 16:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjJVUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 16:53:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86363FB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=uqg/71DNqlYBu9Jd0uaNQkliMLuejjBAWornZC8f+ow=; b=TtDPyh
        Z4kNmQAGAqlzU5OBx6xIhRUsA7YOLj8CMIeuyFNwXXF1gssGLBZBh1HCYaISfe1B
        rI9mYIAxxhwCjmkhQTI3xCU3076yfZitZc40+hG2loG8uyHpuhsh1btaINzxoGto
        KQWzzDMTzppx3iw6bwlUbnD2bgF+nTtEU20frctr7b4TL6YJGFawkb/OA65Gqera
        aQzUyt9h8l7yGxC6eJ+H9uyJOUqwVnK0OuxB0YVNikmUdatd33ZAmhHkA+zKUNaR
        BBA1mKsj/gSRbXaZZkkuc+MS+DePVP/NdqEcBiQBI0kYd2OEZZR3Hea5nFi7dteq
        jzNmdZh7bGD8oZlw==
Received: (qmail 1741676 invoked from network); 22 Oct 2023 22:53:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2023 22:53:25 +0200
X-UD-Smtp-Session: l3s3148p1@8XPzS1QIrMcujnvq
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: ethernet: renesas: group entries in Makefile
Date:   Sun, 22 Oct 2023 22:53:15 +0200
Message-Id: <20231022205316.3209-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new Renesas driver shall be added soon. Prepare the Makefile by
grouping the specific objects to the Kconfig symbol for better
readability. Improve the file description a tad while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/ethernet/renesas/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/Makefile b/drivers/net/ethernet/renesas/Makefile
index 592005893464..e8fd85b5fe8f 100644
--- a/drivers/net/ethernet/renesas/Makefile
+++ b/drivers/net/ethernet/renesas/Makefile
@@ -1,14 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for the Renesas device drivers.
+# Makefile for the Renesas network device drivers
 #
 
 obj-$(CONFIG_SH_ETH) += sh_eth.o
 
 ravb-objs := ravb_main.o ravb_ptp.o
-
 obj-$(CONFIG_RAVB) += ravb.o
 
 rswitch_drv-objs := rswitch.o rcar_gen4_ptp.o
-
 obj-$(CONFIG_RENESAS_ETHER_SWITCH) += rswitch_drv.o
-- 
2.35.1

