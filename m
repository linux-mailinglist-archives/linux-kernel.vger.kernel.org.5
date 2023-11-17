Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82B7EEFC9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbjKQKKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbjKQKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:10:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D2C1;
        Fri, 17 Nov 2023 02:10:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso2617591a12.3;
        Fri, 17 Nov 2023 02:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700215802; x=1700820602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EbmgR2wWjkRCjoHXAmGAF8yTKa5Bp0SAasTthhu3X1w=;
        b=bWXrr3m9qWsYYNPIrD4Qy0lCRISA9hZF8/VR9jGw1uRLQbu89Iwa0f6Lf0reMCK0nv
         dESP82PsWqLfyLIOx8NYFXQ1RyzKD7SZQ/BdWQ7L/29BpFyVJ+SEYfMA/1w+vGSoJ2JZ
         HmntYV4Ku0JygIFNOuoIs6/kYn4W1NBG0DS5Xik7qi7poa+Qe+DYSAaL1BU49EuG6Gtb
         0mKCOzavECCZPLRWUDTxyJLpwn5R2wA6SAQnyn1IzADCb+CxwhFZtrrNWuO3kmYSonS2
         M9iVz0kcLhRARSWtrmDuCTa0581NAOMjEvyVktF9eAGSrYQC/HswjT+qhZTwffhNfwrb
         Mx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700215802; x=1700820602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbmgR2wWjkRCjoHXAmGAF8yTKa5Bp0SAasTthhu3X1w=;
        b=wFiyVrXDWnxdsiuecHnIFz/WKeCw8xwd0P3pfnE1+o1rmIAo4LGJQUrUqFCFLPB3mE
         fecBUfWU+GlE97//Dhls7VHN0BeeG6NKxfDBZ0TDKmGFqSc0P/qA7X4qJMMih9qG1nQY
         7WHPDQ65IK8+sbBoU4kETgaom3hgnu1Ju0nZuA8VKRI/FexLmo1ddNRADR15i8AQN6dk
         d9zC9D/R6b4IqWnaq2WrzkN0ImUqRzZx+kqEmux51D0r4PDr3R+nGlO5X8u33XH+Kk1s
         yTWwtZzIkD3BqfL87Cq/+6ZhUBSPliH4QRkJCfUU7URSRkG29hhWohRCptA6dg0HBUs9
         Z/5Q==
X-Gm-Message-State: AOJu0YzY2J6BuS54HgtQHyenfwqn5qU1Usp9scug34d8CaXwLGkvlbBy
        yW9Hxv4vev4Eg5zShdaZUfQ=
X-Google-Smtp-Source: AGHT+IEKZfNdY+HGK7jgZHN1ygxawnbT/LgdYY1CYA8Mq3hXsFHFChaR6YdcUch8CkPX5fYcSt6X5A==
X-Received: by 2002:a17:906:eb11:b0:9e3:f24d:5496 with SMTP id mb17-20020a170906eb1100b009e3f24d5496mr11799779ejb.28.1700215801929;
        Fri, 17 Nov 2023 02:10:01 -0800 (PST)
Received: from fedora.. (dh207-97-146.xnet.hr. [88.207.97.146])
        by smtp.googlemail.com with ESMTPSA id u22-20020a17090617d600b009e5e4ff01d4sm610599eje.129.2023.11.17.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 02:10:00 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next 1/2] net: phy: aquantia: validate PHY mode on AQR107
Date:   Fri, 17 Nov 2023 11:09:48 +0100
Message-ID: <20231117100958.425354-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.42.0
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

The Aquantia driver is not setting the PHY mode itself, but it does however
still check if the PHY mode set in DTS is one of the supported modes.

However, the set PHY mode does not have to match the actual one, so lets
add update the PHY mode during .config_init and warn if they differ.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index cc4a97741c4a..7711e052e737 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -505,6 +505,21 @@ static void aqr107_chip_info(struct phy_device *phydev)
 		   fw_major, fw_minor, build_id, prov_id);
 }
 
+static void aqr107_validate_mode(struct phy_device *phydev,
+				 phy_interface_t dts_mode)
+{
+	int ret;
+
+	/* Get the actual PHY mode */
+	ret = aqr107_read_status(phydev);
+	if (ret)
+		return;
+
+	if (dts_mode != phydev->interface)
+		phydev_info(phydev, "%s mode is set in DTS while %s mode is actual. Please update your devicetree.\n",
+			    phy_modes(dts_mode), phy_modes(phydev->interface));
+}
+
 static int aqr107_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -528,6 +543,8 @@ static int aqr107_config_init(struct phy_device *phydev)
 	if (!ret)
 		aqr107_chip_info(phydev);
 
+	aqr107_validate_mode(phydev, phydev->interface);
+
 	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 }
 
-- 
2.42.0

