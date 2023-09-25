Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22727AD99A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjIYNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjIYNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:53:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9497107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:53:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401187f8071so44678445e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695650017; x=1696254817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEyyBOiumqlPrTY/pNDi/jSPRVb77LUtZxDS6rWVxtM=;
        b=BGHWQT479/wlqRvKLsfru+Y7+2PNr8s21m9ZNfj5L97tYmde91lFmdKAwk0yvcGur8
         6QTIR+t6tyopPy4pvh/iBjsSGMeSILuIzd1arfiLgArXQGz3OVqDZUQe86Hy/YggZp6p
         3Yz8m3RhyPwIEmelp4e/a/dI+Nkwug5dRaLYxkPuhk40+inR8sTqbKjnCMJrtY8g2frn
         6OhHumU9548wRxUR8Jowj1kQv7GEZ4aLtuM8rgRhr1yFO+hR19FHRfQGqMYNLDfZnJls
         zZ4z+Mj3OGZMe68o7RVPYa+EwUtd+o7bHdC/XYFrFNQWRMwo7Vjhiko1e4ZTTlvusSVj
         OGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695650017; x=1696254817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEyyBOiumqlPrTY/pNDi/jSPRVb77LUtZxDS6rWVxtM=;
        b=LEP0J41kb4MeSKMpw67/Xpo6pVWAnrOWl5Fb4kng70prMAqo2MEdI4fsViIUQKWi4j
         2qKOzVaNDi4z1/Lyj8O3wBWE27zMcQZEv93f/d/xc4FxvZKtaKooVmXqgKuZtggpOqjk
         tTTOp1bLbjqt7TEhjc0olN2TbjEWxH7c8byriUjVLzTfRdiawoMFIyMQxxWH2o3eB6e/
         IIX2HPwodSM6BRfyK+oSJPMaUISv+N0aeFlMvJoKXH07znutQ4unIRdOT90Tm1iPwBx+
         xArso7JerD/HhVjjWHN0B+iWdKKOCZLDqXtJlFubMvZ73N9DCVfk1szSk5Hr/98/10+B
         Lgog==
X-Gm-Message-State: AOJu0YxqaqPUSph89cOf2hv/6hnhc5Ss3OnUvp4PLXGyJrMk8Bbezia4
        i0Jo7XOSZlb2Cme1S/z2SzrT+g==
X-Google-Smtp-Source: AGHT+IGFzUj08pHjRNoUk/5V7szaTjs5BgBSaCQCfPcY3wT4ugjofFmWzBmIPF/q1gq35Asy4Wf/6w==
X-Received: by 2002:a7b:c8cb:0:b0:405:251f:8455 with SMTP id f11-20020a7bc8cb000000b00405251f8455mr7644308wml.7.1695650017304;
        Mon, 25 Sep 2023 06:53:37 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:38f4:d5ca:ab87:c1bc])
        by smtp.googlemail.com with ESMTPSA id v11-20020a5d610b000000b0031435731dfasm11889903wrt.35.2023.09.25.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:53:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH] arm64: dts: meson: g12: name spdifout consistently
Date:   Mon, 25 Sep 2023 15:53:26 +0200
Message-Id: <20230925135326.1689396-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

g12 and sm1 are fairly similar when it comes to audio.
Both have 2 spdif outputs. While the 2nd output is named "spdifout_b" for
both, the 1st one is named 'spdifout' for g12 and 'spdifout_a' for sm1.

Use 'spdifout_a' for both instead.

This change does not fix any particular problem. The intent is just to make
it easier to have a common card definitions for platform designs using both
SoC families, when spdifout is used.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi           |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts      | 10 +++++-----
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts   | 10 +++++-----
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts    | 10 +++++-----
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 10 +++++-----
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
index eb442aaf57e4..e732df3f3114 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -268,12 +268,12 @@ spdifin: audio-controller@400 {
 			status = "disabled";
 		};
 
-		spdifout: audio-controller@480 {
+		spdifout_a: audio-controller@480 {
 			compatible = "amlogic,g12a-spdifout",
 				     "amlogic,axg-spdifout";
 			reg = <0x0 0x480 0x0 0x50>;
 			#sound-dai-cells = <0>;
-			sound-name-prefix = "SPDIFOUT";
+			sound-name-prefix = "SPDIFOUT_A";
 			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
 				 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
 			clock-names = "pclk", "mclk";
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 7310e192efe7..8355ddd7e9ae 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -189,9 +189,9 @@ sound {
 				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
 				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
 				"TDM_C Playback", "TDMOUT_C OUT",
-				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
-				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
-				"SPDIFOUT IN 2", "FRDDR_C OUT 3",
+				"SPDIFOUT_A IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3",
 				"SPDIFOUT_B IN 0", "FRDDR_A OUT 4",
 				"SPDIFOUT_B IN 1", "FRDDR_B OUT 4",
 				"SPDIFOUT_B IN 2", "FRDDR_C OUT 4",
@@ -324,7 +324,7 @@ codec-1 {
 
 		/* spdif hdmi and coax output */
 		dai-link-9 {
-			sound-dai = <&spdifout>;
+			sound-dai = <&spdifout_a>;
 
 			codec-0 {
 				sound-dai = <&spdif_dit>;
@@ -546,7 +546,7 @@ &spdifin {
 	status = "okay";
 };
 
-&spdifout {
+&spdifout_a {
 	pinctrl-0 = <&spdif_ao_out_pins>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 7ca904f5acbb..4969a76460fa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -155,9 +155,9 @@ sound {
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT",
-				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
-				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
-				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
+				"SPDIFOUT_A IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
@@ -196,7 +196,7 @@ codec {
 
 		/* spdif hdmi or toslink interface */
 		dai-link-4 {
-			sound-dai = <&spdifout>;
+			sound-dai = <&spdifout_a>;
 
 			codec-0 {
 				sound-dai = <&spdif_dit>;
@@ -456,7 +456,7 @@ &sd_emmc_c {
 	vqmmc-supply = <&flash_1v8>;
 };
 
-&spdifout {
+&spdifout_a {
 	pinctrl-0 = <&spdif_out_h_pins>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
index 3e826095e792..8fc2e143cb54 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -34,9 +34,9 @@ sound {
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT",
-				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
-				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
-				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
+				"SPDIFOUT_A IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
@@ -75,7 +75,7 @@ codec {
 
 		/* spdif hdmi or toslink interface */
 		dai-link-4 {
-			sound-dai = <&spdifout>;
+			sound-dai = <&spdifout_a>;
 
 			codec-0 {
 				sound-dai = <&spdif_dit>;
@@ -139,7 +139,7 @@ rtc: rtc@51 {
 	};
 };
 
-&spdifout {
+&spdifout_a {
 	pinctrl-0 = <&spdif_out_h_pins>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index 098a3af6d381..ce548b373296 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -29,9 +29,9 @@ sound {
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT",
-				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
-				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
-				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
+				"SPDIFOUT_A IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
@@ -70,7 +70,7 @@ codec {
 
 		/* spdif hdmi or toslink interface */
 		dai-link-4 {
-			sound-dai = <&spdifout>;
+			sound-dai = <&spdifout_a>;
 
 			codec-0 {
 				sound-dai = <&spdif_dit>;
@@ -125,7 +125,7 @@ &ir {
 	linux,rc-map-name = "rc-khadas";
 };
 
-&spdifout {
+&spdifout_a {
 	pinctrl-0 = <&spdif_out_h_pins>;
 	pinctrl-names = "default";
 	status = "okay";
-- 
2.40.1

