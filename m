Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D684770991
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjHDUTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHDUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:19:17 -0400
Received: from mail-pl1-x662.google.com (mail-pl1-x662.google.com [IPv6:2607:f8b0:4864:20::662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0BD4C28
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:19:15 -0700 (PDT)
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-1bc3bec2c95so17531995ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691180354; x=1691785154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQFjBf7YtxXmJlSdHAu4ArmD+GnCH3KaGA7nl8cwkTs=;
        b=UtRNJsHxz1UB+ekhwkbt9C6Dtk5h5XbMoumFtaOzkQEv7IxKftbaDFQN+lTKl/AbZq
         bbotrbh+PtwAHlsbd7VATsfzrz4K1LmfvsCb3eTyJ03K6PP/cWp9eLArYWEztxFf9mZu
         qakKdMsiXit6f/0Nrst3iazklcxEc0oshWrHoAkQBb9D9X+VIECWWFqTVMAfKzLyijTz
         HQaJGrX0+fu0JdVokc6FczhJrI7skr833dGmXo9fTWsYTy7aaCN3wihbZeuCJfUgouab
         kiyKrKRSQ5MPhOmof8V8SGYdOb1EbVdrzpXF7MfbtyK1eh6+GIxlxUO2eZm3Kc5enz2s
         HEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691180354; x=1691785154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQFjBf7YtxXmJlSdHAu4ArmD+GnCH3KaGA7nl8cwkTs=;
        b=lKzvCYyzR3IfNglQjZn1PTwxw6IZKeGlOVoLtgRQN79KvBHBwDfLLUJt9Dy5qOzSFj
         cvoXtWPd2hwc89rKCp4gfXdDszxGGWzq07chY167GB7Bbi52f7aWCWYzS4NY3KwiIuDV
         udGzk2Jb3SbbPob9tRorF/VhUu3aaA5mjoYn/awIkkvHcbOS+Mht1Cw3irUUECcgEuoy
         3nXFnblq5L6VLUSEP65ivqs9SYDRBuaIP8oFWAfCGzgj/oeSLRoIihG9H0/+FwFGE+tS
         LNinOUnkRMZt6iR1+nBcOI8LgEKvOwwTS3KAiI/ojeWzVPRNYUdzDI2ToP1JeVivfeCP
         XqTw==
X-Gm-Message-State: AOJu0YxVFil/kyTwAggbWYpA8X9GJfbVdCGmL7dMPPdOg+89404EsTU5
        7YG8e+Q2dJB+kdO1Y11nDl2Dk4rKYBnqrZt//RirsfQ6t9cT
X-Google-Smtp-Source: AGHT+IG8HYHsBb1cwD/a6m826Y9iwPZnuIAKjiIHJsIkwHtJraIeAGfz9scoH18va3RFBbCIMIdNo+4mCugP
X-Received: by 2002:a17:902:f551:b0:1bb:c7bc:ceb8 with SMTP id h17-20020a170902f55100b001bbc7bcceb8mr768160plf.22.1691180354378;
        Fri, 04 Aug 2023 13:19:14 -0700 (PDT)
Received: from dxue-amd-5700g.libretech.co ([72.76.64.93])
        by smtp-relay.gmail.com with ESMTPS id q7-20020a170902a3c700b001b9dbb0e802sm377270plb.137.2023.08.04.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:19:14 -0700 (PDT)
X-Relaying-Domain: libre.computer
From:   Da Xue <da@libre.computer>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Da Xue <da@libre.computer>, Luke Lu <luke.lu@libre.computer>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH v2] net: phy: meson-gxl: implement meson_gxl_phy_resume()
Date:   Fri,  4 Aug 2023 16:19:02 -0400
Message-Id: <20230804201903.1303713-1-da@libre.computer>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After suspend and resume, the meson GXL internal PHY config needs to be initialized again or the carrier cannot be found.

Signed-off-by: Luke Lu <luke.lu@libre.computer>
Reviewed-by: Da Xue <da@libre.computer>
---
 drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index bb9b33b6b..2df516ed4 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int meson_gxl_phy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	genphy_resume();
+	ret = meson_gxl_config_init(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /* This function is provided to cope with the possible failures of this phy
  * during aneg process. When aneg fails, the PHY reports that aneg is done
  * but the value found in MII_LPA is wrong:
@@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.config_intr	= smsc_phy_config_intr,
 		.handle_interrupt = smsc_phy_handle_interrupt,
 		.suspend        = genphy_suspend,
-		.resume         = genphy_resume,
+		.resume         = meson_gxl_phy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
 	}, {
-- 
2.39.2

