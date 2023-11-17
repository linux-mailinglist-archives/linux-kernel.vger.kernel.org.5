Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A417EEFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbjKQKI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKQKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:08:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF45FA6;
        Fri, 17 Nov 2023 02:08:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso2598846a12.2;
        Fri, 17 Nov 2023 02:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700215731; x=1700820531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EbmgR2wWjkRCjoHXAmGAF8yTKa5Bp0SAasTthhu3X1w=;
        b=VhASmIP3iTphEAWMfz1ZyJ8teYhhq70fay9LNZzcNhpIeSnGDnXxJIvk9C07CS38Wf
         T6xqW6kxM0wIrUwDDmXiORQBAAmQbAVNLXwQpXZWdc0qmqGsskqki9g1aEWTKR7iAozP
         F6ji+yLJRPt9YVKNvCNj2AehyfC1sITgkqqdAIWI7U3f+D1uJzTp8iseDXdVPScMqpQT
         2qMj1rUh4KnnSWBfM/RnOOJQctxzXBXNzc4z8UzYLmVlTRRDsI1W1wxGrUgHrJnNkbik
         0G+CdXgC84dMeWuprD8tTzqqBTKQnQTNaAN53y08IhOQiU6fCIiUCsGUppoBEGMYA8o3
         7hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700215731; x=1700820531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbmgR2wWjkRCjoHXAmGAF8yTKa5Bp0SAasTthhu3X1w=;
        b=QxvjRoMAr87X0XFfh1gBXRBKVosuD9pIJi/8vGtLLt+zaVoeVe6DqLGk3IbFrXxlLE
         bb9yREnmZahY37y3lW/znnmIrCJXcyRK3leZzhcdu3wnthHR3u/Uw4B7HOX9YtIWPF9q
         xa8UiFdLs9gjuKQ9+1qAYtRZCc6uCyGA2TysE4NDmdBMM2Utyu4ggGPlYNTW6dnuo5oS
         O15XOjH6R51kcqP3Bb14mJ/MWByE5w/OBwxO8QyHsl8+Ig8YZX49ob0M7TawtfFzsn8M
         ZER1r05tjRprwnrSbhd+taiiooQS28ORxEW/NXykKYAVmTi3+gOLwvol5JdQvENnTw0L
         rEHA==
X-Gm-Message-State: AOJu0Yz4/DtRs1ryHuea1fZFLGcvVXF69rjKiUe6LgUpv8wOHbQZUMTW
        r/n9LshexRu+TCk96RiQAyQ=
X-Google-Smtp-Source: AGHT+IECgkxdQdU9bxD60OX+sU3zhWfKV3n8cBsWD4ljTBzUxmLZEmKXWQeY91gOusS4DVmThHuXFQ==
X-Received: by 2002:aa7:d801:0:b0:545:5601:414e with SMTP id v1-20020aa7d801000000b005455601414emr14671872edq.5.1700215730944;
        Fri, 17 Nov 2023 02:08:50 -0800 (PST)
Received: from fedora.. (dh207-97-146.xnet.hr. [88.207.97.146])
        by smtp.googlemail.com with ESMTPSA id n26-20020a056402061a00b0054358525a5bsm554368edv.62.2023.11.17.02.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 02:08:50 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] net: phy: aquantia: validate PHY mode on AQR107
Date:   Fri, 17 Nov 2023 11:05:04 +0100
Message-ID: <20231117100848.424372-1-robimarko@gmail.com>
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

