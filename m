Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA5805078
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376552AbjLEKhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjLEKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A521728;
        Tue,  5 Dec 2023 02:36:30 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso1847685e87.0;
        Tue, 05 Dec 2023 02:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772588; x=1702377388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSce1rQ1um+oY77DdZG8yrBJ6NEyKdJwNZU1ix0Nv7k=;
        b=eMjViwzHmyMOborgcvBDCdlmIjgu7cdS5Hzh4HppL9v3W38esVYl+2fx4sPHeXfWTw
         035fVLsLMqxdscQk+bIqXUDcbUYrQs0u1qG+6/MVtE1vH/RQ9K5/HsmMZAeqnjYTR8/b
         /GEgc9fh0RBgRak1u3QR98cQYaXwfHlazTVRNffS/x2aInASIbkyq+jQTSx5oBoblOC+
         V7SmDbyTplG75solCyVOkZW8U8512LXEpBVavc6QAsRHo5Vlc4oFO06IqX4kK8WlSt3s
         CyWcP0jA7o+7S9JJeejkWeIjrY4mi0IW+ZeNE+X6SUlVRT3LsZw5EcC3eZU9kw699TJp
         StWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772588; x=1702377388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSce1rQ1um+oY77DdZG8yrBJ6NEyKdJwNZU1ix0Nv7k=;
        b=HZjP7iSKCZszla19ajP+ppx15N1BPNdeesNhA8eF5wEoP3fhx3cZ0Obl+MUJz9dS6g
         2tlP8x7nrT04uQZzFGqlixtbSCmesVb1Z6Nhszo2lEnC1wmcQ7Jjcsy5FNi2y5vMlr6h
         Ex5KeeCNrHqJfKCQiFtIecREgoqRrSX/OJDcyqq5onNbbbbrVqcgpCET+LmWmW9NW2/T
         z+77TjeycWumTvLq1LD90VHpDvmK0q5kh2f40QMCqoQH+32OSjUEQvddd/nsAZ+CgZKm
         N7kLf9gzeF/5DuBUdf1+98bpiNCDdCkZpd2oa5ZkMm5cdLv4KkiDbCzCnHFr+78LZ9Ro
         VxAg==
X-Gm-Message-State: AOJu0YzXfLDC1Gov7ZTqKr505r8aKKAxzT+9k9AOdl/Id9oLWHTgwwb3
        VtH6oMMZwJe98Nepqq+o8C4=
X-Google-Smtp-Source: AGHT+IHCPdpPY0zKceA3SRi5ga/xIyMFSxmCiObH9MLWtgGsZTqmrUo8sVBhomQ2MmR96xpeV6v2vw==
X-Received: by 2002:a05:6512:2809:b0:50b:f0a9:1e3e with SMTP id cf9-20020a056512280900b0050bf0a91e3emr834935lfb.3.1701772588437;
        Tue, 05 Dec 2023 02:36:28 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x3-20020a056512046300b0050c0215a806sm185275lfd.83.2023.12.05.02.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:27 -0800 (PST)
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
Subject: [PATCH net-next 14/16] net: stmmac: Pass netdev to XPCS setup function
Date:   Tue,  5 Dec 2023 13:35:35 +0300
Message-ID: <20231205103559.9605-15-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to have the XPCS device accessible over a dedicated
management interface which makes the XPCS device available over the MMIO
space. In that case the management interface will be registered as a
separate MDIO bus and the DW xGMAC device will be equipped with the
"pcs-handle" property pointing to the XPCS device instead of
auto-detecting it on the internal MDIO bus. In such configurations the SMA
interface (embedded into the DW xGMAC MDIO interface) might be absent.
Thus passing the MII bus interface handler to the stmmac_xpcs_setup()
method won't let us reach the externally supplied XPCS device especially
if the SMA bus isn't configured. Let's fix it by converting the
stmmac_xpcs_setup(struct mii_bus *bus) prototype to
stmmac_xpcs_setup(struct net_device *ndev).

Note this is a preparation patch before adding the support of the XPCS
devices specified via the "pcs-handle" property.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index cd7a9768de5f..d8a1c84880c5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -343,7 +343,7 @@ enum stmmac_state {
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
-int stmmac_xpcs_setup(struct mii_bus *mii);
+int stmmac_xpcs_setup(struct net_device *ndev);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
 
 int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd53a617..c3641db00f96 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7605,7 +7605,7 @@ int stmmac_dvr_probe(struct device *device,
 		priv->plat->speed_mode_2500(ndev, priv->plat->bsp_priv);
 
 	if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
-		ret = stmmac_xpcs_setup(priv->mii);
+		ret = stmmac_xpcs_setup(ndev);
 		if (ret)
 			goto error_xpcs_setup;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index aa75e4f1e212..e6133510e28d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -495,9 +495,8 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 	return 0;
 }
 
-int stmmac_xpcs_setup(struct mii_bus *bus)
+int stmmac_xpcs_setup(struct net_device *ndev)
 {
-	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv;
 	struct dw_xpcs *xpcs;
 	int mode, addr;
@@ -507,7 +506,7 @@ int stmmac_xpcs_setup(struct mii_bus *bus)
 
 	/* Try to probe the XPCS by scanning all addresses. */
 	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-		xpcs = xpcs_create_byaddr(bus, addr, mode);
+		xpcs = xpcs_create_byaddr(priv->mii, addr, mode);
 		if (IS_ERR(xpcs))
 			continue;
 
-- 
2.42.1

