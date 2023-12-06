Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9D807310
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379014AbjLFOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379120AbjLFOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:44:49 -0500
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C45D59;
        Wed,  6 Dec 2023 06:44:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB699C0190;
        Wed,  6 Dec 2023 15:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701873885; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=IKeKgwpFsNj9YrDVbsZmnB9SqQh3ugfmHYM2RQIQqoo=;
        b=DUQik+0wkRvmJAHx/RNOxS6DwLKwXsI2bs3Za+zyQz4Ep6gYREaLLpuU9xmVVdhfK4gYkd
        1+CSK1660MIbrOoCl68VX4htwC/zj8RNwn0IiokbS06mMpjgzzTM3lr+wIxMCyFbuR/Glk
        V8hZq4YA7wUFBkiATYnv93/nmLsOWOP9/crBJTtQYC2wapV/tM/6PHtEMr7r5dx7i/qjaF
        bxnjly63f+Ag0HDuKUNImdJC/Eeu5sqIBxxMOREBI9Jctmk9Rim+dz0Wnre6kQ7FFz32Ls
        YlRhM1nkoIALE8G8tGi1GxbgmfL6cF1ZVE1SNIDdvB8zsViFpvDiraMRpmO2vA==
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
Subject: [PATCH v3 12/14] arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable from RTC node
Date:   Wed,  6 Dec 2023 15:41:15 +0100
Message-ID: <20231206144201.46911-13-frieder@fris.de>
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

The RV3028 driver doesn't use this property. Remove it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* none

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

