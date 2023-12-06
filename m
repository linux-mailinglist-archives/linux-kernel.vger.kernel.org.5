Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982C08072DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442166AbjLFOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442092AbjLFOoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:44:46 -0500
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61210EB;
        Wed,  6 Dec 2023 06:44:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64F7BC00E1;
        Wed,  6 Dec 2023 15:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701873880; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=wTGxRgaKGKupnoXw4GHvrCi9OifBL1yEtA/OEf2ONgk=;
        b=TWBfRiIBUbghnDgwE6d1IzO6XlWafpLVCkuR6KMgN+kNwUHDqJPLimKn8F1FVJnCCoYkN3
        W94CGtzWTunAH9KCbNyhHMy0yNv527Xl275PT3Jv6xiHRztSb7jUU/9qqQsdkxbaA2CWC1
        O8z89qFUm2lZk6XkgYtq75H5WWbzquHgO9PLnZroDLFqHrJfyfjVTc4oAElz38ln2BboQ7
        jEn9HLmND3tCxX6Fh516MO2bXQ8NA8hCAR/qsd9/q2j5aYnLVUVA7ijS9Xb4CbaJjHNsz0
        9xv52VscFsHuGqouMDk7hHo5a6PQkqyxazDgzuAgRWLeEC4xUCb3zNnNyMlF/Q==
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
Subject: [PATCH v3 09/14] arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM module
Date:   Wed,  6 Dec 2023 15:41:12 +0100
Message-ID: <20231206144201.46911-10-frieder@fris.de>
In-Reply-To: <20231206144201.46911-1-frieder@fris.de>
References: <20231206144201.46911-1-frieder@fris.de>
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
Changes for v3:
* none

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

