Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE0805059
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346594AbjLEKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjLEKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:13 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F39198;
        Tue,  5 Dec 2023 02:36:14 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so40624241fa.2;
        Tue, 05 Dec 2023 02:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772572; x=1702377372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGpa0GtJpSi8L3mCQm30bghRnsn1XAa98foEtQJ/KWs=;
        b=GYYXnentdvnu/1Y2K8ftCOd5KrjA2w3ScIenFuKM/DpQPhs7rY52J+BE4C4cH9cxgF
         lUn4mFFGJ8TNtvNSayj9jhV+oLncNYmVjusfikmQgDoDMUwv+xGqFG9YpIKGnZUBWgqM
         ngwp5n0bafZxZaAyYRkDgsZ4JrhDdVbMogRqB5uHjUBVEi1DqSehkVtA5w549P4dJG9f
         omHekrxYVDq4AZKIzibf9xv+kMzn0IimPeSix2SImJp5wdzntTl0s3EGrCG6iHYIZiYG
         N0zHCEDaFIpGvJRAUtyRp87VA5CBuEi6pT+WIc8PAwmBFtON/iSXRMTAa1BpVPG0WTyF
         lg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772572; x=1702377372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGpa0GtJpSi8L3mCQm30bghRnsn1XAa98foEtQJ/KWs=;
        b=a3PvXxmIBhNpaICB8YU9guw2IBaXA0EBqcGDyjmAz+KlmpeNbpHnfGwiWFrp5U/GdI
         mj6VY7TmzsTnoYL5hgLWs3rxk27QXf2ip8K17mkVCFfWYbbpWrs1crvpLv7zvhUi9og+
         n3vXlK08pCrPv492fxRyVkaihI6CIC8pL2Ci+jcYWQf9y2YpfwqsXtt0TD3MvszGjiez
         OoH+slQXop3B9CBhbdRBUvvAIAb8FjUd5DaP8Z5cbWa3RdPK1hjoJV8y7tcjb66cGd14
         YWIIB5fNWRkwB8hrr48ttnraWmXb/1sjdme6Y2GVcZzozBSkzpKenAjZm46blBhXwdAh
         s9Qg==
X-Gm-Message-State: AOJu0Yymdi1dEAAQ1ne1bxR/Vgus0v/5qIc7DML5UuSdV3TBf7fQLYoY
        cyoiXYaPSsOYE5DupeHdjxQ=
X-Google-Smtp-Source: AGHT+IFIhxBRZreE0ykFzf7E++LBQs6vRs4czi1iz3uLMDedC+tOqSVXU3dh9yp28YVSHIo1DRs6Rg==
X-Received: by 2002:a05:6512:2343:b0:50b:fcd6:cb10 with SMTP id p3-20020a056512234300b0050bfcd6cb10mr1522544lfu.130.1701772572652;
        Tue, 05 Dec 2023 02:36:12 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t6-20020a199106000000b0050bfdb1392fsm377230lfd.221.2023.12.05.02.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:12 -0800 (PST)
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
        Paolo Abeni <pabeni@redhat.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS MDIO device
Date:   Tue,  5 Dec 2023 13:35:27 +0300
Message-ID: <20231205103559.9605-7-fancer.lancer@gmail.com>
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

If the DW XPCS MDIO devices are either left unmasked for being auto-probed
or explicitly registered in the MDIO subsystem by means of the
mdiobus_register_board_info() method there is no point in creating the
dummy MDIO device instance in order to get the DW XPCS handler since the
MDIO core subsystem will create the device during the MDIO bus
registration procedure. All what needs to be done is to just reuse the
MDIO-device instance available in the mii_bus.mdio_map array (using some
getter for it would look better though). It shall prevent the XPCS devices
been accessed over several MDIO-device instances.

Note since the MDIO-device instance might be retrieved from the MDIO-bus
map array its reference counter shall be increased. If the MDIO-device
instance is created in the xpcs_create_mdiodev() method its reference
counter will be already increased. So there is no point in toggling the
reference counter in the xpcs_create() function. Just drop it from there.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 2850122f354a..a53376472394 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1376,7 +1376,6 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	if (!xpcs)
 		return ERR_PTR(-ENOMEM);
 
-	mdio_device_get(mdiodev);
 	xpcs->mdiodev = mdiodev;
 
 	xpcs_id = xpcs_get_id(xpcs);
@@ -1417,7 +1416,6 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	ret = -ENODEV;
 
 out:
-	mdio_device_put(mdiodev);
 	kfree(xpcs);
 
 	return ERR_PTR(ret);
@@ -1437,19 +1435,21 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 	struct mdio_device *mdiodev;
 	struct dw_xpcs *xpcs;
 
-	mdiodev = mdio_device_create(bus, addr);
-	if (IS_ERR(mdiodev))
-		return ERR_CAST(mdiodev);
+	if (addr >= PHY_MAX_ADDR)
+		return ERR_PTR(-EINVAL);
 
-	xpcs = xpcs_create(mdiodev, interface);
+	if (mdiobus_is_registered_device(bus, addr)) {
+		mdiodev = bus->mdio_map[addr];
+		mdio_device_get(mdiodev);
+	} else {
+		mdiodev = mdio_device_create(bus, addr);
+		if (IS_ERR(mdiodev))
+			return ERR_CAST(mdiodev);
+	}
 
-	/* xpcs_create() has taken a refcount on the mdiodev if it was
-	 * successful. If xpcs_create() fails, this will free the mdio
-	 * device here. In any case, we don't need to hold our reference
-	 * anymore, and putting it here will allow mdio_device_put() in
-	 * xpcs_destroy() to automatically free the mdio device.
-	 */
-	mdio_device_put(mdiodev);
+	xpcs = xpcs_create(mdiodev, interface);
+	if (IS_ERR(xpcs))
+		mdio_device_put(mdiodev);
 
 	return xpcs;
 }
-- 
2.42.1

