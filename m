Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C2B7765F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjHIRCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjHIRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:02:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A72108;
        Wed,  9 Aug 2023 10:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B23641C3;
        Wed,  9 Aug 2023 17:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0FEC433CC;
        Wed,  9 Aug 2023 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691600518;
        bh=+ysItbKZr2r8wDthNuZTqSVce0mf6PlXK4jyZ+ackfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSJDgiKIr3wPBI9HdtaTnJjlCWTAXshygqxPj3S4cr7PjCURUYZz7K36JFeM6xEbF
         BpNU3bNh4yLma8AZnAxYOcZIVAO5nCrGS6bClAVsN3pAxvWajVWYqGx+TM7xGap2HD
         gE5BiXnxCStgeDB8Y2W5b+rU/P1l+Cihl4G7ELjOHwLbKoj6vnz7FMPR881BMu4q/P
         5bdMs3VtMu6/FgGwi/cbBVfQi0UsCpxkTD6dpNu32WACbGHmNy5EXNg2etgty/bcGa
         wg136JAgiBACQh4iGVfUoKyXEc6s4/3Y8YjMX740JZuKDSfUSHNVdL6THRnvSufpV9
         2QkNB9+jdVL/w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 03/10] net: stmmac: mdio: enlarge the max XGMAC C22 ADDR to 31
Date:   Thu, 10 Aug 2023 00:50:00 +0800
Message-Id: <20230809165007.1439-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230809165007.1439-1-jszhang@kernel.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP can support up to 31 xgmac c22 addresses now.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 3db1cb0fd160..e6d8e34fafef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -40,7 +40,7 @@
 #define MII_XGMAC_WRITE			(1 << MII_XGMAC_CMD_SHIFT)
 #define MII_XGMAC_READ			(3 << MII_XGMAC_CMD_SHIFT)
 #define MII_XGMAC_BUSY			BIT(22)
-#define MII_XGMAC_MAX_C22ADDR		3
+#define MII_XGMAC_MAX_C22ADDR		31
 #define MII_XGMAC_C22P_MASK		GENMASK(MII_XGMAC_MAX_C22ADDR, 0)
 #define MII_XGMAC_PA_SHIFT		16
 #define MII_XGMAC_DA_SHIFT		21
-- 
2.40.1

