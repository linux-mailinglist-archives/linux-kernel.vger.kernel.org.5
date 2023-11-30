Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6027FF4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjK3QTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjK3QSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:18:50 -0500
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD051991;
        Thu, 30 Nov 2023 08:18:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FB66BFC65;
        Thu, 30 Nov 2023 17:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701361128; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ZbNPEWDbA0n9EE6XFqNkWMsNpks/uKrE8bcK14NAwUk=;
        b=Uwf7C9YbIPkuo+kdcidvDzibociEUVTJyDjYWu7epLuORwJCR+6sYtqKE1pcL9KnkXSX4E
        rMm6gvX2DYeYKHNXO7ag7B4WqmaGJZDYKJN2YRnZ+/FBYjKk3rNVB6jsaKEm+sWDTfWFJI
        iOackmn9e5z4HRmybGZ3ApzB4NullXAmhLKumz+NMFcAL6xNTV8uu1FE2CeUWnqUjT8kMv
        ToTTh9GhZgJtzs1Iertcvk6TFMT2R4FV05gMtOYsHnGCd2QvtyrXtjcJ4ZCYtmWQ+8w5KA
        PtBaxeL8rbQYRcWoC5pZTBfrxwrZdAuTRwWM6cYa7f5vIf52E/OSEs4s9iP+vg==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 09/14] arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM module
Date:   Thu, 30 Nov 2023 17:16:09 +0100
Message-ID: <20231130161657.556483-10-frieder@fris.de>
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

The level of the interrupt signal is active low instead. Fix this.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* none
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 3e7db968f7e64..60abcb636cedf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -210,7 +210,7 @@ rv3028: rtc@52 {
 		reg = <0x52>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc>;
-		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_LOW>;
 		trickle-diode-disable;
 	};
 };
-- 
2.43.0

