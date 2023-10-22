Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D410D7D25F1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJVUxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJVUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 16:53:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C7B126
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=41fdQH/ffNpQD3j/yF5QWKflpbrtFGENdcb0zJGbhv4=; b=IQjrwP
        xl/KOxykwnqkWARL6MND8U7bCdgGBsCyKCkRgGZHx0VWhLwGlf0v/pb7kmscVe9O
        01HTguZd2+7q9yCXVW4U0N41/4ug2BRd+1MMbULxBFHUCAuv66UezwOBYFdm8zDp
        vEI70NwLssB60bUXdxySpHpZKmK0ssoybOEd2KT2ECqoJKZQZ4G4YjBfR7IevLTh
        Xlfbt++S6zsNF1ZTkOXMOl0iNQs08avyr3iM0Qc4CR672TwZ5Qys8Ge3vFTICJx1
        8BLJwEvasxmFpR5dVHvf/LJaeIZQAjSzT+J9ylOcqRDKNK1i/1HbMGSikA76GpIe
        SyJYJ67ZrkMsFMeg==
Received: (qmail 1741731 invoked from network); 22 Oct 2023 22:53:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2023 22:53:25 +0200
X-UD-Smtp-Session: l3s3148p1@HGP/S1QIrscujnvq
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
Subject: [PATCH net-next 2/2] net: ethernet: renesas: drop SoC names in Kconfig
Date:   Sun, 22 Oct 2023 22:53:16 +0200
Message-Id: <20231022205316.3209-3-wsa+renesas@sang-engineering.com>
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

Mentioning SoCs in Kconfig descriptions tends to get stale (e.g. RAVB is
missing RZV2M) or imprecise (e.g. SH_ETH is not available on all
R8A779x). Drop them instead of providing vague information. Improve the
file description a tad while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/ethernet/renesas/Kconfig | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index 3ceb57408ed0..8ef5b0241e64 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Renesas device configuration
+# Renesas network device configuration
 #
 
 config NET_VENDOR_RENESAS
@@ -25,9 +25,6 @@ config SH_ETH
 	select PHYLIB
 	help
 	  Renesas SuperH Ethernet device driver.
-	  This driver supporting CPUs are:
-		- SH7619, SH7710, SH7712, SH7724, SH7734, SH7763, SH7757,
-		  R8A7740, R8A774x, R8A777x and R8A779x.
 
 config RAVB
 	tristate "Renesas Ethernet AVB support"
@@ -39,8 +36,6 @@ config RAVB
 	select PHYLIB
 	help
 	  Renesas Ethernet AVB device driver.
-	  This driver supports the following SoCs:
-		- R8A779x.
 
 config RENESAS_ETHER_SWITCH
 	tristate "Renesas Ethernet Switch support"
@@ -51,7 +46,5 @@ config RENESAS_ETHER_SWITCH
 	select PHYLINK
 	help
 	  Renesas Ethernet Switch device driver.
-	  This driver supports the following SoCs:
-		- R8A779Fx.
 
 endif # NET_VENDOR_RENESAS
-- 
2.35.1

