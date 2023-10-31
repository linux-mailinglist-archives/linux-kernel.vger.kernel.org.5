Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2C7DD75C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjJaUr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343927AbjJaUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:47:18 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45532113;
        Tue, 31 Oct 2023 13:47:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56BCAC03DD;
        Tue, 31 Oct 2023 21:39:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1698784774; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=YpM5vxrR6ZrUF/Hkjv41Um8dF7koOSkUsqfyGCRk++E=;
        b=QG1kIjaXhwIl5fCCU06yivRLQ3/G8AS4T/xogJexbos+pLX3FHVr1gYnIilTvDw6rY5Neh
        hn/wpcnO0j7dy2V/Ep1F2Z6y/Z0nD7pzVb6uWIuMpVK+Cuq0fCeH4DVlxpxJ3iNUYTqNks
        UVhYBYLNcjlKSIeKg8bVi4czsM1BdazDxG4QmYNxJTgH6RNBkAjgAqOMRasvsUZ7zWdf0x
        XZJ2z9c2gdXdTgMrY14eOMdw1mG+bbEduM66QHtKL6KTSv6OP5XUL0e8Woe+xLVhAf4jpX
        a4MW9zjH09CKdcLecFXFZJoWrhI9327PbrxGF+agjhTSu4zLTvMVFQPR82O4yA==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 13/14] arm64: dts: imx8mm-kontron: Add I2C EEPROM on OSM-S Kontron i.MX8MM
Date:   Tue, 31 Oct 2023 21:37:50 +0100
Message-ID: <20231031203836.3888404-14-frieder@fris.de>
In-Reply-To: <20231031203836.3888404-1-frieder@fris.de>
References: <20231031203836.3888404-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

There is an EEPROM on the SoM module. Add it to the description.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index b161b0c85d61e..6b9058fc53332 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -205,6 +205,14 @@ reg_nvcc_sd: LDO5 {
 		};
 	};
 
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+		address-width = <16>;
+		pagesize = <32>;
+		size = <8192>;
+	};
+
 	rv3028: rtc@52 {
 		compatible = "microcrystal,rv3028";
 		reg = <0x52>;
-- 
2.42.0

