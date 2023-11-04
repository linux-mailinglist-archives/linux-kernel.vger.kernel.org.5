Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BB37E0E61
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 09:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjKDIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 04:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKDIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 04:52:28 -0400
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29596D44
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 01:52:22 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20231104085220acd58ef895f05d141d
        for <linux-kernel@vger.kernel.org>;
        Sat, 04 Nov 2023 09:52:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WAgTrsyOkM2Z/pbjkiAN/Jv1epYEBMIOyHeuSB3TCUc=;
 b=peTiw96tvDCj4Hf9WNZIdOMTre7Wh0zr+t0bRUkOUcUvMCw5/B2J067CwQfXrMNYw7U2nU
 ua/aJEDJZR+v8075/NoPgFZfQ28R7RFBCS1fmfa82Tg0++GzhFrWsAnnvgH/YgcUPOLGsfgu
 Rbaf5/321Tpoaa+uOLQZUDxF39zEk=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH v4 2/5] arm64: dts: ti: iot2050: Drop unused ecap0 PWM
Date:   Sat,  4 Nov 2023 09:52:16 +0100
Message-Id: <6131d44e0505ca3efbb9039e5f2b637a3e139312.1699087938.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1699087938.git.jan.kiszka@siemens.com>
References: <cover.1699087938.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

In fact, this was never used by the final device, only dates back to
first prototypes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index b849648d51f9..fc39ae0f9587 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -355,12 +355,6 @@ AM65X_IOPAD(0x0008, PIN_INPUT,  0)  /* (B21) I2C1_SCL */
 			AM65X_IOPAD(0x000c, PIN_INPUT,  0)  /* (E21) I2C1_SDA */
 		>;
 	};
-
-	ecap0_pins_default: ecap0-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0010, PIN_INPUT,  0)  /* (D21) ECAP0_IN_APWM_OUT */
-		>;
-	};
 };
 
 &wkup_uart0 {
@@ -557,12 +551,6 @@ &mcu_cpsw {
 	status = "disabled";
 };
 
-&ecap0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&ecap0_pins_default>;
-};
-
 &sdhci1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-- 
2.35.3

