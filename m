Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D44D7FF4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjK3QT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjK3QS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:18:58 -0500
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B7C1BD1;
        Thu, 30 Nov 2023 08:18:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2212CBFC65;
        Thu, 30 Nov 2023 17:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701361132; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=vMUqDwo82qK4dTsItk3tN+6GzzDqaT54i6PZPDlfLew=;
        b=ycf4411dTB/jtdnehXOXPANFAxgiozAJkBTrGCMY1B/VWxgA42mTLkWC6xvQd8LxHC0HZH
        tnPZOF7ACXVBNg2Z9HIO3e3JJ7fvaUvoNChJEk80vOhphJDrtz2qBH/7RO9tv57dKvLK87
        FGR7Pb7TKluFzY5xswgFmvPGG+K1aQQR+4imjCoI+MvJcfN3mgGULdg1/jdzAiexzLm6U6
        r9hTR3nLISl3IirBBJGwfe1bQ9bmjyf0rzL2POT5EIGXLJwDA7KFopOYiGNYu0nTRZYQtQ
        BumWc+5KpCUXJ31xQqjx+7EOjWSEGIMMYzwjHRFg4RarcZmNhn6FGNfZRMk6og==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 12/14] arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable from RTC node
Date:   Thu, 30 Nov 2023 17:16:12 +0100
Message-ID: <20231130161657.556483-13-frieder@fris.de>
In-Reply-To: <20231130161657.556483-1-frieder@fris.de>
References: <20231130161657.556483-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The RV3028 driver doesn't use this property. Remove it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* none
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 60abcb636cedf..b161b0c85d61e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -211,7 +211,6 @@ rv3028: rtc@52 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc>;
 		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_LOW>;
-		trickle-diode-disable;
 	};
 };
 
-- 
2.43.0

