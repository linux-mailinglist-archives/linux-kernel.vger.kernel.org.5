Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99E7ABEBB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjIWIBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjIWIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:01:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154C180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:01:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817B3C433CC;
        Sat, 23 Sep 2023 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695456099;
        bh=+0bl9JdtpO6RZoE8citmM/PLqhG+QSEn497rexS26YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cONVAf0RPSXuf0xSZUfskI+UYtgfC3rYPXKa8jYXWC/kUG3+NdAiYZN4x0KHEJ0G/
         kzQMmlQZFlIqix/Gpuyv3NMIzhzCvHhMSHdEtHOFQaP5WzJc7X3ntaFR5+tctqxJmt
         psGPyYbx5Ca8hpnJWL42BXAm/ceTI3HIwis/KxXJa3mfNyNKmHR37tsCXPdwCyZTgz
         3B76PVZrtPrdO4Rx93VFY0gKKW/nV/2PBu9XTj9ltW40tjRDixrWxCTNdzTu8I6QCU
         lyFa5GK9+eVCgc4eCxZrcyYpVv1pvBaqrbG7YOvxf2wiSDPZOjx28wizokUAZG27FJ
         7i7RSucWZy5ug==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, afd@ti.com, robh+dt@kernel.org
Cc:     vigneshr@ti.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srk@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am64: Add GPIO expander on I2C0
Date:   Sat, 23 Sep 2023 11:00:46 +0300
Message-Id: <20230923080046.5373-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923080046.5373-1-rogerq@kernel.org>
References: <20230923080046.5373-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A TCA9554 GPIO expander is present on I2C0. Add it.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index b4a1f73d4fb1..3dccc597f516 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -392,6 +392,15 @@ &main_i2c0 {
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
 
+	gpio@38 {
+		/* TCA9554 */
+		compatible = "nxp,pca9554";
+		reg = <0x38>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "HSE_DETECT";
+	};
+
 	eeprom@50 {
 		/* AT24CM01 */
 		compatible = "atmel,24c1024";
-- 
2.34.1

