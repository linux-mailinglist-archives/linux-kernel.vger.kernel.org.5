Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615267E4586
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbjKGQKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbjKGQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:09:31 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285D2BBCE;
        Tue,  7 Nov 2023 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=xGRenfqQZdi2lQn1cViqb8siKduR9EzX8BshZ0vUjaM=; b=SVNFB5hdMjgsNycHzMQD7ahyNc
        txV6przMnRMbx9KJk/GVy+uO0h0rRjl6P7fVRT8IwCE6mTccdilG376b8ilPXUue0/Z0ba15VeKWV
        DSwxKfyD1f46xuUKfv1lMrC/cxXZxc7YlrewOo+ToZQERzccdLobEoQtmy2s+rQ7gSds=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35618 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r0OW4-0007eo-A3; Tue, 07 Nov 2023 11:01:24 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue,  7 Nov 2023 11:01:22 -0500
Message-Id: <20231107160122.1648093-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.hugovil.com
X-Spam-Level: 
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH] arm64: dts: imx8mn-var-som: reorder reg properties after compatible strings
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Move reg nodes after the compatible string, to follow DT conventions.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
index b8946edf317b..9124476500f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -60,8 +60,8 @@ &ecspi1 {
 
 	/* Resistive touch controller */
 	touchscreen@0 {
-		reg = <0>;
 		compatible = "ti,ads7846";
+		reg = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_restouch>;
 		interrupt-parent = <&gpio1>;
@@ -292,8 +292,8 @@ &usdhc1 {
 	status = "okay";
 
 	brcmf: bcrmf@1 {
-		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
 	};
 };
 

base-commit: be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
-- 
2.39.2

