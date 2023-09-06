Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9B7938EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbjIFJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbjIFJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:52:35 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AB41982;
        Wed,  6 Sep 2023 02:52:28 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7928dc54896so132277639f.3;
        Wed, 06 Sep 2023 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693993947; x=1694598747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LsnxtJChRuEyVRG9ko08TVlT1rSSwwc12RXGyr/Ymo=;
        b=UscDoiEax0oaXrQIGMNKp7dsA0K7NdyhrilY7gUYqnuZmaajjzmJ8fROx8p4kI3uYo
         HhnCM4WyuV8b50Cu5kUfNk3BZ5oOKCdNM4+Sz7QOeToFt0M0uLCvEc23vgorbNTt07HI
         Yd/b86Yq9RAUUvpfdorUsV3gwu6X320B6462XcOGHZHl6Yqonb7TX7oe5x1EuVNfqda0
         A1RAPXUxuUG1kRS/eYKJU02tvnkqFK2U+JSsoS7516E6gFqZlMDK0PaKDFlQK4GoLuh6
         UEWTT5LsOiu/AMnp9YcVgZ9G/iiJonPM8YpaICPbYQSlNTBkZZolFZtyy/uoewTBy+JG
         Ymvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993947; x=1694598747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LsnxtJChRuEyVRG9ko08TVlT1rSSwwc12RXGyr/Ymo=;
        b=Qad46r1F8Aj0QT7CpQ3CSa1EtpyDy18Y61tPWr2TxBdASIp4nI7ypolg5nVmHuVbLZ
         oBSWrdvkFL28putZpdqAZLCqMqwmQRu+DgwySV6rXpmD4BB4GJEP26tGFgpveh937mzf
         NgC7AtvaX7ZZVHZ8qqt0uWXL5BcMwGyAs7qr1kqa9U9ASVx5WvH1Hmxrc4eIDBC24Syv
         izyv5fIRqy8SVkfUDnkuOjz64ytRETgDnbfCRiJTwTwD6ivitKxN/aoGA9jj3nXb4I4b
         TNu8O7h4E+7vauZSfBVRQLHqRo7s0ro0iQBaYR1TNNdnbvow8YVMiWv+KbR/Wu81eR+W
         hp+Q==
X-Gm-Message-State: AOJu0Yz1ddrHEhSBpcSPI3Jk/u/2kucYMVPHxzlaWTALKsYd6nOAMT1p
        RCbRUqoSGyMWWfa5xhLXsvY2Y0Imx2Y=
X-Google-Smtp-Source: AGHT+IGM8yoIsIbDbOiurHN299qtQHq27Z7zBM/Q22b3U9VWVOKETLQ0SXTeR9mi5otFEEf8j8VdAA==
X-Received: by 2002:a6b:680b:0:b0:795:183b:1e3 with SMTP id d11-20020a6b680b000000b00795183b01e3mr16612042ioc.6.1693993947107;
        Wed, 06 Sep 2023 02:52:27 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b68d:99e6:78c9:f0e6])
        by smtp.gmail.com with ESMTPSA id i23-20020a5d9e57000000b007836a9ca101sm4794744ioi.22.2023.09.06.02.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:52:26 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/2] net: ethernet: davinci_emac: Use MAC Address from Device Tree
Date:   Wed,  6 Sep 2023 04:51:42 -0500
Message-Id: <20230906095143.99806-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a device tree entry called "local-mac-address"
which can be filled by the bootloader or manually set.This is
useful when the user does not want to use the MAC address
programmed into the SoC.

Currently, the davinci_emac reads the MAC from the DT, copies
it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
it by reading from registers in the SoC, and falls back to a
random MAC if it's still not valid.  This completely ignores any
MAC address in the device tree.

In order to use the local-mac-address, check to see if the contents
of priv->mac_addr are valid before falling back to reading from the
SoC when the MAC address is not valid.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 2eb9d5a32588..994ddd756782 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1934,18 +1934,20 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		goto err_free_rxchan;
 	ndev->irq = rc;
 
-	rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac_addr);
-	if (!rc)
-		eth_hw_addr_set(ndev, priv->mac_addr);
-
+	/* If the MAC address is not present, read the registers from the SoC */
 	if (!is_valid_ether_addr(priv->mac_addr)) {
-		/* Use random MAC if still none obtained. */
-		eth_hw_addr_random(ndev);
-		memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
-		dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
-			 priv->mac_addr);
+		rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac_addr);
+		if (!rc)
+			eth_hw_addr_set(ndev, priv->mac_addr);
+
+		if (!is_valid_ether_addr(priv->mac_addr)) {
+			/* Use random MAC if still none obtained. */
+			eth_hw_addr_random(ndev);
+			memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
+			dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
+				 priv->mac_addr);
+		}
 	}
-
 	ndev->netdev_ops = &emac_netdev_ops;
 	ndev->ethtool_ops = &ethtool_ops;
 	netif_napi_add(ndev, &priv->napi, emac_poll);
-- 
2.39.2

