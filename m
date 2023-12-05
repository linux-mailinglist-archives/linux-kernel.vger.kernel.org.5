Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75D805080
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbjLEKh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346829AbjLEKgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F01985;
        Tue,  5 Dec 2023 02:36:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so1856306e87.1;
        Tue, 05 Dec 2023 02:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772590; x=1702377390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnWeBpfqtvqCDqeZAExTorADExkavt7pqbm3ec9WO1c=;
        b=iCNdakXCOSBCIi7nmUXrJwMhu5UwpNbZgL9GM9B9zaExDAt1mwkK+AbRS4/OorCtj0
         tFxMomloGV0r6XKm5+NRpKfj++MHSYdNWv5/QZL3EUl+2t13XN9P+8D/Vf/LTD5/gKla
         FltfguMe5/tDHBDEy8v4edxhbUfscWXdl8yJtIb6TKzH58zNmSB9vZgLZT7t+J4gxxtR
         Sv2LVB55wt5MP1PW1+7p8HKTf+dmwBU4uMJqv8j4VlhZAthsmvc2yAC8jQEFCYhS3RrU
         ybZalk15UWCRJzVyrUyqnuS6iXTTi2IBVqSuREQ2OQI9YZVxiuW28m/8UCcS3pOZzFwG
         eG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772590; x=1702377390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnWeBpfqtvqCDqeZAExTorADExkavt7pqbm3ec9WO1c=;
        b=j701bad1KWvoIXUqRBASEG+/t/FvtGi+YBdbSM5nxJBbhYHmouKHE98BKcc34E6r1J
         CXCsnCS4CAPoieG40hixmSJwu0VSxz4KEbJ4+YOmgvVPQA2+76HPkBJ7lM1/TjZTcsz8
         wA/WCaG3lnc3nHdRPTDeeSuphpwFfIsgeeHCSuAunBZKJqGQveETus3wNV/9dCdJCeeW
         mDU79zhg48EMIfyPKeDeyqRtwiU3ipBpIn02AWs2oAByZcSadQBHRNL/4bxxSadPa79L
         F7sPTFsYTApy7sRYtDvG9sXPHQ5TKhCHTzyFY1rO4MncjKzy6R3OufSxSwnjWv7RBgh1
         uSCg==
X-Gm-Message-State: AOJu0Yyy+WFUQ85dLNMRXPSg5xvnDuwQYSsZHppse2r3BQxNUbbZutHY
        tpo2xU2nhQRy8F63D/g1aiI=
X-Google-Smtp-Source: AGHT+IFCUWZhdYHhKb8nG0l8H2uVfvXP7CMp59To4aI5jWsBTPXwOd7IoX4cD7Nlfspv3sfeyfBb1A==
X-Received: by 2002:ac2:5f43:0:b0:50b:ccc1:201e with SMTP id 3-20020ac25f43000000b0050bccc1201emr1469322lfz.0.1701772590456;
        Tue, 05 Dec 2023 02:36:30 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d19-20020a196b13000000b0050bf365e8c8sm679554lfa.63.2023.12.05.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:30 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 15/16] net: stmmac: Add dedicated XPCS cleanup method
Date:   Tue,  5 Dec 2023 13:35:36 +0300
Message-ID: <20231205103559.9605-16-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the XPCS handler destruction is performed in the
stmmac_mdio_unregister() method. It doesn't look well because the handler
isn't originally created in the corresponding protagonist
stmmac_mdio_unregister(), but in the stmmac_xpcs_setup() function. In
order to have a bit more coherent MDIO and XPCS setup/cleanup procedures
let's move the DW XPCS destruction to the dedicated stmmac_xpcs_clean()
method.

Note besides of that this change is a preparation to adding the PCS device
supplied by means of the "pcs-handle" property. It's required since DW
XPCS IP-core can be synthesized embedded into the chip with directly
accessible CSRs. In that case the SMA interface can be absent so no
corresponding MDIO bus will be registered.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  6 +++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 14 +++++++++++---
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index d8a1c84880c5..1709de519813 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -344,6 +344,7 @@ int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
 int stmmac_xpcs_setup(struct net_device *ndev);
+void stmmac_xpcs_clean(struct net_device *ndev);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
 
 int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c3641db00f96..379552240ac9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7639,8 +7639,9 @@ int stmmac_dvr_probe(struct device *device,
 
 error_netdev_register:
 	phylink_destroy(priv->phylink);
-error_xpcs_setup:
 error_phy_setup:
+	stmmac_xpcs_clean(ndev);
+error_xpcs_setup:
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
@@ -7682,6 +7683,9 @@ void stmmac_dvr_remove(struct device *dev)
 	if (priv->plat->stmmac_rst)
 		reset_control_assert(priv->plat->stmmac_rst);
 	reset_control_assert(priv->plat->stmmac_ahb_rst);
+
+	stmmac_xpcs_clean(ndev);
+
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index e6133510e28d..101fa50c3c96 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -522,6 +522,17 @@ int stmmac_xpcs_setup(struct net_device *ndev)
 	return 0;
 }
 
+void stmmac_xpcs_clean(struct net_device *ndev)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	if (!priv->hw->xpcs)
+		return;
+
+	xpcs_destroy(priv->hw->xpcs);
+	priv->hw->xpcs = NULL;
+}
+
 /**
  * stmmac_mdio_register
  * @ndev: net device structure
@@ -674,9 +685,6 @@ int stmmac_mdio_unregister(struct net_device *ndev)
 	if (!priv->mii)
 		return 0;
 
-	if (priv->hw->xpcs)
-		xpcs_destroy(priv->hw->xpcs);
-
 	mdiobus_unregister(priv->mii);
 	priv->mii->priv = NULL;
 	mdiobus_free(priv->mii);
-- 
2.42.1

