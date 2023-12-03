Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA580286B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjLCW3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjLCW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:29:13 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F1CDB;
        Sun,  3 Dec 2023 14:29:19 -0800 (PST)
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r9uxc-006zEy-G1; Sun, 03 Dec 2023 23:29:12 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r9uxb-001RbX-37;
        Sun, 03 Dec 2023 23:29:11 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v3 6/6] ARM: dts: omap: gta04: standardize system-power-controller
Date:   Sun,  3 Dec 2023 23:29:03 +0100
Message-Id: <20231203222903.343711-7-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231203222903.343711-1-andreas@kemnade.info>
References: <20231203222903.343711-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace TI-specific property by generic one.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
cannot be applied independently of the other ones, so maybe simply delay
it.

 arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
index 3661340009e7a..5001c4ea35658 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
@@ -476,6 +476,7 @@ twl: twl@48 {
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+		system-power-controller;
 
 		clocks = <&hfclk_26m>;
 		clock-names = "fck";
@@ -490,7 +491,6 @@ codec {
 
 		twl_power: power {
 			compatible = "ti,twl4030-power-idle";
-			ti,system-power-controller;
 		};
 	};
 };
-- 
2.39.2

