Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425FE7D9A01
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjJ0Ne7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbjJ0Ner (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:34:47 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B4D6C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:34:41 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202310271334398d0eaff66e47583012
        for <linux-kernel@vger.kernel.org>;
        Fri, 27 Oct 2023 15:34:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WAgTrsyOkM2Z/pbjkiAN/Jv1epYEBMIOyHeuSB3TCUc=;
 b=Ow/dupZE1G89ABU0bsQ9WaCabxF+vTs9AQBpMUwkWV9l74a5J9WhfL0+MviHgXYmh7xhT0
 TSK8+RORCwqe4v93d36qNEg8HbxD2eT3Z/x9ygEwsjRJdSNb95BsfPumKDF9XMSXAoJYV0gT
 hXguAzwTMTCej6O9Hf49m2weFT8EA=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH 2/7] arm64: dts: ti: iot2050: Drop unused ecap0 PWM
Date:   Fri, 27 Oct 2023 15:34:33 +0200
Message-Id: <230ab0a39038a3a5e233c3e257e5589c4d715ac1.1698413678.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1698413678.git.jan.kiszka@siemens.com>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

