Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0867F4741
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344299AbjKVM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344226AbjKVM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:57:08 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6FB10D5;
        Wed, 22 Nov 2023 04:57:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F41A53EDB;
        Wed, 22 Nov 2023 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1700657815; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=Ulmefl5yig/F+2V9QAbbUBGE0S2hQKZ3IPeqik+z0UI=;
        b=obnqjWRUmpCSg3j42I/4HoO5hACMJaABq0MXfrlaqopRm6vDn6C0+Mj7rsbVzWyuJB6i0R
        rjEYNy2N5QabL5j55uL2EuFfluAXcRx1fVMIf3tqMODJ8ExoqO+oOUWxCMeB2ZZDxgXCtr
        4WkKzmMnRlipOLOWil8NEG8ZgBUTv3Vp9hPkE7Z2lrMctIPzXeWkmdMsWZ7zhjRe10kITM
        sUfdmvw15/XacURTXUN/K3o3z/+4tys4qR+AsvUCkT9H7A86ubeZVzxzOvPG2XDsRLwb0w
        wCCSRyH6+5lprySgxtdAGPrpxv5NwOhk2gFWquNk4bZtT99ub8WMI+zbFJuvAg==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 5/5] arm64: dts: meson: add dts links to secure-monitor for soc driver in a1, axg, gx, g12
Date:   Wed, 22 Nov 2023 15:56:43 +0300
Message-Id: <20231122125643.1717160-6-adeep@lexina.in>
In-Reply-To: <20231122125643.1717160-1-adeep@lexina.in>
References: <20231122125643.1717160-1-adeep@lexina.in>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; h=from:subject; bh=5P5fYju1OuJiL/byEBiP3PSi5QUDOL3VUZ+An0H3Yq0=; b=owGbwMvMwCHmnhFhrJcZuJTxtFoSQ2rst6PzpSIPfZiQwrL/6Lz/Yq6reYpjji2pORTNeLc+Rj79 0t/7HaUsDGIcDLJiiixhHUFT93msvjhxgdEBmDmsTCBDGLg4BWAi50QZ/krcyUy9e1Ag4O/3OF29F6 eL570SVgi+mt7GEMu57ENL3Sagiv4ltcEzrio+it5Q/COaS7csWft72s89slNKV35d8s2VEQA=
X-Developer-Key: i=adeep@lexina.in; a=openpgp; fpr=E2FA1A767ACB0716E02E3E7AEE36B110025A8DFA
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add links to secure-monitor in soc driver section for A1, AXG, GX, G12
Amlogic family.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi         | 1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 648e7f49424f..449b328d62b1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -407,6 +407,7 @@ hwrng: rng@5118 {
 			sec_AO: ao-secure@5a20 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x5a20 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a49aa62e3f9f..6e80bdc525e5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1660,6 +1660,7 @@ mux {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index ff68b911b729..0a6b703b0dc0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2026,6 +2026,7 @@ cec_AO: cec@100 {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 2673f0dbafe7..656e08b3d872 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -471,6 +471,7 @@ cec_AO: cec@100 {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
-- 
2.34.1

