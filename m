Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233777766D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjHISAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjHISAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:00:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38AD1BFF;
        Wed,  9 Aug 2023 11:00:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Hxxdq119446;
        Wed, 9 Aug 2023 12:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691603999;
        bh=02Fr7FpFkvXJW7JWwDUp+hBG3pdLEGPhd9v1Jt3pBGs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LA0m70v/MS1QDwz2a7YU60OtOBYn8N+HWq/lwh9ANno7EvEgVygsSIUgFZ/5V0U1t
         mZqQFd1yb/7i/34c12/gI3OZ9HMw23RU90dSP6XQv0OLzqvGHvWb/zyX1cGcnRZINN
         KesMAieaHbcXK0N/2l1RovZwDLvK86LRQ/MmSOdA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Hxx2o094167
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:59:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:59:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:59:58 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Hxm6I098813;
        Wed, 9 Aug 2023 12:59:55 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] arm64: dts: ti: k3: Add cfg reg region to ringacc node
Date:   Wed, 9 Aug 2023 23:29:32 +0530
Message-ID: <20230809175932.2553156-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809175932.2553156-1-vigneshr@ti.com>
References: <20230809175932.2553156-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register range of ringacc cfg node to all k3 SoC dtsi files. This is
normally under Device Management firmware control but some entities like
bootloader have to access directly and thus required to be present in DT.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi         | 5 +++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi          | 6 ++++--
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi        | 5 +++--
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi  | 6 ++++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi        | 5 +++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  | 5 +++--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 5 +++--
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 5 +++--
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       | 5 +++--
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 5 +++--
 10 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index d08f086d7d01..bc460033a37a 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -776,8 +776,9 @@ ringacc: ringacc@3c000000 {
 			reg = <0x0 0x3c000000 0x0 0x400000>,
 			      <0x0 0x38000000 0x0 0x400000>,
 			      <0x0 0x31120000 0x0 0x100>,
-			      <0x0 0x33000000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x0 0x33000000 0x0 0x40000>,
+			      <0x0 0x31080000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <818>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 7b1f94a89eca..1c16c3cac612 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -197,8 +197,10 @@ mcu_ringacc: ringacc@2b800000 {
 			reg = <0x0 0x2b800000 0x0 0x400000>,
 			      <0x0 0x2b000000 0x0 0x400000>,
 			      <0x0 0x28590000 0x0 0x100>,
-			      <0x0 0x2a500000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x0 0x2a500000 0x0 0x40000>,
+			      <0x0 0x28440000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg",
+				    "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 6eaade5aeb42..e695f7881733 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -267,8 +267,9 @@ main_ringacc: ringacc@3c000000 {
 			reg = <0x00 0x3c000000 0x00 0x400000>,
 			      <0x00 0x38000000 0x00 0x400000>,
 			      <0x00 0x31120000 0x00 0x100>,
-			      <0x00 0x33000000 0x00 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x00 0x33000000 0x00 0x40000>,
+			      <0x00 0x31080000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <1024>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index ee7860913c38..04f39b081dc0 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -329,8 +329,10 @@ mcu_ringacc: ringacc@2b800000 {
 			reg = <0x00 0x2b800000 0x00 0x400000>,
 			      <0x00 0x2b000000 0x00 0x400000>,
 			      <0x00 0x28590000 0x00 0x100>,
-			      <0x00 0x2a500000 0x00 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x00 0x2a500000 0x00 0x40000>,
+			      <0x00 0x28440000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg",
+				    "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 3acd55ffd4ff..68a8abf59d24 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -368,8 +368,9 @@ main_ringacc: ringacc@3c000000 {
 			reg = <0x0 0x3c000000 0x0 0x400000>,
 			      <0x0 0x38000000 0x0 0x400000>,
 			      <0x0 0x31120000 0x0 0x100>,
-			      <0x0 0x33000000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x0 0x33000000 0x0 0x40000>,
+			      <0x0 0x31080000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <1024>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index c1b6f8d7d189..c5ede7bbc263 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -448,8 +448,9 @@ mcu_ringacc: ringacc@2b800000 {
 			reg = <0x0 0x2b800000 0x0 0x400000>,
 			      <0x0 0x2b000000 0x0 0x400000>,
 			      <0x0 0x28590000 0x0 0x100>,
-			      <0x0 0x2a500000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x0 0x2a500000 0x0 0x40000>,
+			      <0x0 0x28440000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index dc7920a35237..20548d95ab13 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1065,8 +1065,9 @@ main_ringacc: ringacc@3c000000 {
 			reg = <0x0 0x3c000000 0x0 0x400000>,
 			      <0x0 0x38000000 0x0 0x400000>,
 			      <0x0 0x31120000 0x0 0x100>,
-			      <0x0 0x33000000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x0 0x33000000 0x0 0x40000>,
+			      <0x0 0x31080000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <1024>;
 			ti,sci-rm-range-gp-rings = <0x1>;
 			ti,sci = <&sms>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 736ec5fa0ea2..bba2d75324b8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -455,8 +455,9 @@ mcu_ringacc: ringacc@2b800000 {
 			reg = <0x0 0x2b800000 0x0 0x400000>,
 			      <0x0 0x2b000000 0x0 0x400000>,
 			      <0x0 0x28590000 0x0 0x100>,
-			      <0x0 0x2a500000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x0 0x2a500000 0x0 0x40000>,
+			      <0x0 0x28440000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>;
 			ti,sci = <&sms>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index a04c44708a09..29adf3c6a70d 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -966,8 +966,9 @@ main_ringacc: ringacc@3c000000 {
 			reg = <0x00 0x3c000000 0x00 0x400000>,
 			      <0x00 0x38000000 0x00 0x400000>,
 			      <0x00 0x31120000 0x00 0x100>,
-			      <0x00 0x33000000 0x00 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x00 0x33000000 0x00 0x40000>,
+			      <0x00 0x31080000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <1024>;
 			ti,sci-rm-range-gp-rings = <0x1>;
 			ti,sci = <&sms>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 740ee794d7b9..42709489c5d1 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -455,8 +455,9 @@ mcu_ringacc: ringacc@2b800000 {
 			reg = <0x00 0x2b800000 0x00 0x400000>,
 			      <0x00 0x2b000000 0x00 0x400000>,
 			      <0x00 0x28590000 0x00 0x100>,
-			      <0x00 0x2a500000 0x00 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x00 0x2a500000 0x00 0x40000>,
+			      <0x00 0x28440000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>;
 			ti,sci = <&sms>;
-- 
2.41.0

