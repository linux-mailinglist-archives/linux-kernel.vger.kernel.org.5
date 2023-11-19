Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C477F0618
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjKSMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSMNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:13:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E76126;
        Sun, 19 Nov 2023 04:13:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so4940197a12.2;
        Sun, 19 Nov 2023 04:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700396024; x=1701000824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVr7goYhFLlmDZmc5xEl9s20CmZbe4+FAt3N2E9piDg=;
        b=k4wCUNeg4CBKnxnqD9cVlYYuPUs1MS134M8W7OvFRA8DN7cdv8G736PbOg6QTS8i4x
         nsCHJrlJzA0Gkp5YqgMhySJRFGMFTMuQVBc/rvLwE05eQ4hyXbHkvhH4X+eEQ1xXfIj0
         2BLf9tyezXWn9pM1Qvq/zZmP6Cjz4QbhB7jmC4B1CoHVyoaYoPELfZ8JuALSp2+Pai1f
         vbuKHPiDvigDCwQr4xhGpo8LESEnCoiljPRst6VhNrT0wb3I8DC/PJ5hVzu4zDO10nRh
         aeDiMYvNZgnKPdIM8c6wJyIf7ygoNnFp8nDBDF9pr28qUSm5OgD3RXUjtfQz5hJB3ztu
         knDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700396024; x=1701000824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVr7goYhFLlmDZmc5xEl9s20CmZbe4+FAt3N2E9piDg=;
        b=mHNei6ufjC2Gx2sz4As96d1e7ZRCAGGADvfX51CZzyT1J4KAmi4aY8m9dfzW6tW9kK
         vaDs3IM00ThpmZgYaKMei9YNEiT/HsI8E/pAh325GHc6PXdyk43C0dfSVRLPuKV8GjQB
         P5/W1LrrkoE+QBmw4rkmTQ/O6Am+5DcbkrYT/gwfjbZLLvEUHlKk8BzUT4tMe/6pdZHG
         tG76JZcQ4zmP01v88L7jIr4xYstRtidvsylrJEtClx04AEYWKQUEU30s5H1PuFyQeDSD
         tTQmuDj++0Nf0MaQcg6JwCUk1kckOy6TfzCW6BtTfszXxMrP2UbUSJGaI/RHhGogdlfv
         G2rA==
X-Gm-Message-State: AOJu0YxaKBJWZzvzt10xWbwoIsN2Vt4eeQX2AIvg7ASEGlkO5EnD0d3j
        NXTA6bU8q3RykrXh7RL2DQ==
X-Google-Smtp-Source: AGHT+IHBJU9wdIXPTCBk407dwoGGEi1XpoVY+fEgUXOjjM0NXJSTbbLeARn5Up3BUus6sIH24XikDw==
X-Received: by 2002:a05:6402:64f:b0:548:4dd2:aa58 with SMTP id u15-20020a056402064f00b005484dd2aa58mr3510536edx.28.1700396023758;
        Sun, 19 Nov 2023 04:13:43 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7017:f42c:e243:8c57])
        by smtp.gmail.com with ESMTPSA id r5-20020a056402018500b0053dec545c8fsm2523634edv.3.2023.11.19.04.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 04:13:43 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 1/5] phy: rockchip-inno-usb2: Split ID interrupt phy registers
Date:   Sun, 19 Nov 2023 13:13:36 +0100
Message-ID: <20231119121340.109025-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119121340.109025-1-knaerzche@gmail.com>
References: <20231119121340.109025-1-knaerzche@gmail.com>
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

Commit 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ") added ID
detection interrupt registers. However the current implementation assumes
that falling and rising edge interrupt are always enabled in registers
spanning over subsequent bits.
That is not the case for RK3128's version of the phy and this
implementation can't be used as-is, since there are bits with different
purpose in between.

This splits up the register definitions for id_det_en, id_det_en and
id_det_clr registers in rising and falling edge variants.
It's required as preparation to support RK3128's Innosilicon usb2 phy as
well in this driver and matches pretty much to what the vendor does, so I'm
not expecting issues for other SoCs with that change.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
Changes in v3:
 - rebased on linux-next
 
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 99 +++++++++++++------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index a24d2af154df..b5a1d30df83a 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -123,9 +123,12 @@ struct rockchip_chg_det_reg {
  * @disrise_en: host disconnect rise edge detection enable.
  * @disrise_st: host disconnect rise edge detection state.
  * @disrise_clr: host disconnect rise edge detection clear.
- * @id_det_en: id detection enable register.
- * @id_det_st: id detection state register.
- * @id_det_clr: id detection clear register.
+ * @idfall_det_en: id detection enable register, falling edge
+ * @idfall_det_st: id detection state register, falling edge
+ * @idfall_det_clr: id detection clear register, falling edge
+ * @idrise_det_en: id detection enable register, rising edge
+ * @idrise_det_st: id detection state register, rising edge
+ * @idrise_det_clr: id detection clear register, rising edge
  * @ls_det_en: linestate detection enable register.
  * @ls_det_st: linestate detection state register.
  * @ls_det_clr: linestate detection clear register.
@@ -146,9 +149,12 @@ struct rockchip_usb2phy_port_cfg {
 	struct usb2phy_reg      disrise_en;
 	struct usb2phy_reg      disrise_st;
 	struct usb2phy_reg      disrise_clr;
-	struct usb2phy_reg	id_det_en;
-	struct usb2phy_reg	id_det_st;
-	struct usb2phy_reg	id_det_clr;
+	struct usb2phy_reg	idfall_det_en;
+	struct usb2phy_reg	idfall_det_st;
+	struct usb2phy_reg	idfall_det_clr;
+	struct usb2phy_reg	idrise_det_en;
+	struct usb2phy_reg	idrise_det_st;
+	struct usb2phy_reg	idrise_det_clr;
 	struct usb2phy_reg	ls_det_en;
 	struct usb2phy_reg	ls_det_st;
 	struct usb2phy_reg	ls_det_clr;
@@ -488,15 +494,27 @@ static int rockchip_usb2phy_init(struct phy *phy)
 			if (ret)
 				goto out;
 
-			/* clear id status and enable id detect irq */
+			/* clear id status and enable id detect irqs */
 			ret = property_enable(rphy->grf,
-					      &rport->port_cfg->id_det_clr,
+					      &rport->port_cfg->idfall_det_clr,
 					      true);
 			if (ret)
 				goto out;
 
 			ret = property_enable(rphy->grf,
-					      &rport->port_cfg->id_det_en,
+					      &rport->port_cfg->idrise_det_clr,
+					      true);
+			if (ret)
+				goto out;
+
+			ret = property_enable(rphy->grf,
+					      &rport->port_cfg->idfall_det_en,
+					      true);
+			if (ret)
+				goto out;
+
+			ret = property_enable(rphy->grf,
+					      &rport->port_cfg->idrise_det_en,
 					      true);
 			if (ret)
 				goto out;
@@ -1030,11 +1048,16 @@ static irqreturn_t rockchip_usb2phy_id_irq(int irq, void *data)
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
 	bool id;
 
-	if (!property_enabled(rphy->grf, &rport->port_cfg->id_det_st))
+	if (!property_enabled(rphy->grf, &rport->port_cfg->idfall_det_st) &&
+	    !property_enabled(rphy->grf, &rport->port_cfg->idrise_det_st))
 		return IRQ_NONE;
 
 	/* clear id detect irq pending status */
-	property_enable(rphy->grf, &rport->port_cfg->id_det_clr, true);
+	if (property_enabled(rphy->grf, &rport->port_cfg->idfall_det_st))
+		property_enable(rphy->grf, &rport->port_cfg->idfall_det_clr, true);
+
+	if (property_enabled(rphy->grf, &rport->port_cfg->idrise_det_st))
+		property_enable(rphy->grf, &rport->port_cfg->idrise_det_clr, true);
 
 	id = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
 	extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !id);
@@ -1524,9 +1547,12 @@ static const struct rockchip_usb2phy_cfg rk3228_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0680, 3, 3, 0, 1 },
 				.bvalid_det_st	= { 0x0690, 3, 3, 0, 1 },
 				.bvalid_det_clr	= { 0x06a0, 3, 3, 0, 1 },
-				.id_det_en	= { 0x0680, 6, 5, 0, 3 },
-				.id_det_st	= { 0x0690, 6, 5, 0, 3 },
-				.id_det_clr	= { 0x06a0, 6, 5, 0, 3 },
+				.idfall_det_en	= { 0x0680, 6, 6, 0, 1 },
+				.idfall_det_st	= { 0x0690, 6, 6, 0, 1 },
+				.idfall_det_clr	= { 0x06a0, 6, 6, 0, 1 },
+				.idrise_det_en	= { 0x0680, 5, 5, 0, 1 },
+				.idrise_det_st	= { 0x0690, 5, 5, 0, 1 },
+				.idrise_det_clr	= { 0x06a0, 5, 5, 0, 1 },
 				.ls_det_en	= { 0x0680, 2, 2, 0, 1 },
 				.ls_det_st	= { 0x0690, 2, 2, 0, 1 },
 				.ls_det_clr	= { 0x06a0, 2, 2, 0, 1 },
@@ -1587,9 +1613,12 @@ static const struct rockchip_usb2phy_cfg rk3308_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x3020, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x3024, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x3028, 3, 2, 0, 3 },
-				.id_det_en	= { 0x3020, 5, 4, 0, 3 },
-				.id_det_st	= { 0x3024, 5, 4, 0, 3 },
-				.id_det_clr	= { 0x3028, 5, 4, 0, 3 },
+				.idfall_det_en	= { 0x3020, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0x3024, 5, 5, 0, 1 },
+				.idfall_det_clr = { 0x3028, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0x3020, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0x3024, 4, 4, 0, 1 },
+				.idrise_det_clr = { 0x3028, 4, 4, 0, 1 },
 				.ls_det_en	= { 0x3020, 0, 0, 0, 1 },
 				.ls_det_st	= { 0x3024, 0, 0, 0, 1 },
 				.ls_det_clr	= { 0x3028, 0, 0, 0, 1 },
@@ -1634,9 +1663,12 @@ static const struct rockchip_usb2phy_cfg rk3328_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0110, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x0114, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x0118, 3, 2, 0, 3 },
-				.id_det_en	= { 0x0110, 5, 4, 0, 3 },
-				.id_det_st	= { 0x0114, 5, 4, 0, 3 },
-				.id_det_clr	= { 0x0118, 5, 4, 0, 3 },
+				.idfall_det_en	= { 0x0110, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0x0114, 5, 5, 0, 1 },
+				.idfall_det_clr = { 0x0118, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0x0110, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0x0114, 4, 4, 0, 1 },
+				.idrise_det_clr = { 0x0118, 4, 4, 0, 1 },
 				.ls_det_en	= { 0x0110, 0, 0, 0, 1 },
 				.ls_det_st	= { 0x0114, 0, 0, 0, 1 },
 				.ls_det_clr	= { 0x0118, 0, 0, 0, 1 },
@@ -1700,9 +1732,12 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 				.bvalid_det_en	= { 0xe3c0, 3, 3, 0, 1 },
 				.bvalid_det_st	= { 0xe3e0, 3, 3, 0, 1 },
 				.bvalid_det_clr	= { 0xe3d0, 3, 3, 0, 1 },
-				.id_det_en	= { 0xe3c0, 5, 4, 0, 3 },
-				.id_det_st	= { 0xe3e0, 5, 4, 0, 3 },
-				.id_det_clr	= { 0xe3d0, 5, 4, 0, 3 },
+				.idfall_det_en	= { 0xe3c0, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0xe3e0, 5, 5, 0, 1 },
+				.idfall_det_clr	= { 0xe3d0, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0xe3c0, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0xe3e0, 4, 4, 0, 1 },
+				.idrise_det_clr	= { 0xe3d0, 4, 4, 0, 1 },
 				.utmi_avalid	= { 0xe2ac, 7, 7, 0, 1 },
 				.utmi_bvalid	= { 0xe2ac, 12, 12, 0, 1 },
 				.utmi_id	= { 0xe2ac, 8, 8, 0, 1 },
@@ -1739,9 +1774,12 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 				.bvalid_det_en  = { 0xe3c0, 8, 8, 0, 1 },
 				.bvalid_det_st  = { 0xe3e0, 8, 8, 0, 1 },
 				.bvalid_det_clr = { 0xe3d0, 8, 8, 0, 1 },
-				.id_det_en	= { 0xe3c0, 10, 9, 0, 3 },
-				.id_det_st	= { 0xe3e0, 10, 9, 0, 3 },
-				.id_det_clr	= { 0xe3d0, 10, 9, 0, 3 },
+				.idfall_det_en	= { 0xe3c0, 10, 10, 0, 1 },
+				.idfall_det_st	= { 0xe3e0, 10, 10, 0, 1 },
+				.idfall_det_clr	= { 0xe3d0, 10, 10, 0, 1 },
+				.idrise_det_en	= { 0xe3c0, 9, 9, 0, 1 },
+				.idrise_det_st	= { 0xe3e0, 9, 9, 0, 1 },
+				.idrise_det_clr	= { 0xe3d0, 9, 9, 0, 1 },
 				.utmi_avalid	= { 0xe2ac, 10, 10, 0, 1 },
 				.utmi_bvalid    = { 0xe2ac, 16, 16, 0, 1 },
 				.utmi_id	= { 0xe2ac, 11, 11, 0, 1 },
@@ -1770,9 +1808,12 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0080, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x0084, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x0088, 3, 2, 0, 3 },
-				.id_det_en	= { 0x0080, 5, 4, 0, 3 },
-				.id_det_st	= { 0x0084, 5, 4, 0, 3 },
-				.id_det_clr	= { 0x0088, 5, 4, 0, 3 },
+				.idfall_det_en	= { 0x0080, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0x0084, 5, 5, 0, 1 },
+				.idfall_det_clr	= { 0x0088, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0x0080, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0x0084, 4, 4, 0, 1 },
+				.idrise_det_clr	= { 0x0088, 4, 4, 0, 1 },
 				.utmi_avalid	= { 0x00c0, 10, 10, 0, 1 },
 				.utmi_bvalid	= { 0x00c0, 9, 9, 0, 1 },
 				.utmi_id	= { 0x00c0, 6, 6, 0, 1 },
-- 
2.42.0

