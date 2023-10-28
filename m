Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71057DA957
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjJ1Usq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Uso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:48:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01142D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:48:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507e85ebf50so4473335e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698526120; x=1699130920; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVLQjXVLKZfGCSGch/qGFr8re6qYrJR23uX27QZ5BbI=;
        b=UPUocww3P8hragmlvqHKHM1kAfZDoyiO12bcrM282lqvAjJov/aUmHudFhiTttvMB0
         6oBEb4/7cPiqNmFUdoh8q7LnRvlegqtpp6v/BQtFDjPWIoeC4QMLUtxbEIG6lt3E14B4
         h2TIHyVfHwFk8UHVfa0JNksr7BfbFUhqfKeLoedN5ZTODwamQ4jrzaOCmcOJt/Sivwh+
         RmotqlevDs+a6Ytts+m9+JnaI/PtTWRFO4O0+3jIwu2aGBKREA2UtyJl2m5iVEsdvewK
         CuEha96BlWH4NbcSkF6FVDDEflawgp+oVb2yPsXMAl8VEI5Ko7kCZgwwQkRHH55lf4tR
         G1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698526120; x=1699130920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVLQjXVLKZfGCSGch/qGFr8re6qYrJR23uX27QZ5BbI=;
        b=v6G5rdHciNErBWVSnRVvztFMo7dPWRxVOeD7C069HkFSkOf83rfIatMPN2vKB0ZNDz
         8c0I2t1MuMW0+byUe1yiNws9xC9wkLHXWvjX45WZ/Lc0NkgXpnMuTJkawBmdyTsnOI6Z
         /IiY6MHSYmDfvmQeY9vlcZO/Tq/l+827/4fxNzkXjYHdesSVSzofWTlgngH+ZlytPDgX
         gJ/oZo9MVnlZ1IDfeFAHdx0UBwYqOp1E3z1FdoWwoH/UYzJvjQT3V2VQz+tVX4Qh05k8
         p8zgNz6nLZkuyWnQmzmcnfO1Z9my7NZVSuxG7D+7b6a2Cclpckv7YfJHJ1+QVySPpCHl
         GYlw==
X-Gm-Message-State: AOJu0Yz8JOEJLIhMNbOx3rc9rVkVyk4BM6CfnKBCQvRuWwWcDvutlTqL
        C9kCQmVZo7Ge5f/Y/9s5FTWBwg==
X-Google-Smtp-Source: AGHT+IEbWdI89KrKJ0QcwjzCF/uBDgK1n6sTTVv+58ModTMzwrwhkH4H6gODqlwhlitRT3Pkz1fpzA==
X-Received: by 2002:a05:6512:324a:b0:4fa:5e76:7ad4 with SMTP id c10-20020a056512324a00b004fa5e767ad4mr3946367lfr.10.1698526120201;
        Sat, 28 Oct 2023 13:48:40 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n4-20020ac24904000000b0050300e013f3sm770940lfi.254.2023.10.28.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:48:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Oct 2023 22:48:35 +0200
Subject: [PATCH net-next] net: xscale: Drop unused PHY number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231028-ixp4xx-eth-id-v1-1-57be486d7f0f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKJzPWUC/x2MSQqAMAwAv1JyNmCr4PIV8aA1ai61tEUC4t8NH
 odh5oFMiSnDaB5IdHPmKyjYyoA/l3AQ8qYMrnaNrV2PLLEVQSqnGuw2tw67Cut70CYm2ln+3wS
 BCgaSAvP7fp1i1YtpAAAA
To:     Krzysztof Halasa <khalasa@piap.pl>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Howard Harte <hharte@magicandroidapps.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some cargoculted reason on incomplete cleanup, we have a
PHY number which refers to nothing and gives confusing messages
about PHY 0 on all ports.

Print the name of the actual PHY device instead.

Reported-by: Howard Harte <hharte@magicandroidapps.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 3b0c5f177447..711f2727fa33 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -154,7 +154,6 @@ typedef void buffer_t;
 
 /* Information about built-in Ethernet MAC interfaces */
 struct eth_plat_info {
-	u8 phy;		/* MII PHY ID, 0 - 31 */
 	u8 rxq;		/* configurable, currently 0 - 31 only */
 	u8 txreadyq;
 	u8 hwaddr[ETH_ALEN];
@@ -1520,7 +1519,7 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
 	if ((err = register_netdev(ndev)))
 		goto err_phy_dis;
 
-	netdev_info(ndev, "%s: MII PHY %i on %s\n", ndev->name, plat->phy,
+	netdev_info(ndev, "%s: MII PHY %s on %s\n", ndev->name, phydev_name(phydev),
 		    npe_name(port->npe));
 
 	return 0;

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231028-ixp4xx-eth-id-7d2b9f1021c8

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

