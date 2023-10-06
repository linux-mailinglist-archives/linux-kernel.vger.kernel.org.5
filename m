Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689817BB3BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjJFJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjJFJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:03:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6CDB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:03:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so3278664a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696582982; x=1697187782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZwC3GB6k52kbCUUG9Ix1b8EAEchE7aYZwBVKYjR4XA=;
        b=uiL0L/ezXdt8TqcFVna0gJA15pZ3yx/BmSfYEIZfaZNflfyqi8tQrQhrrVjn1zw3st
         iwYQIVK/K/GfiDUCco86wrvn92RnThu6dLyCONeB1HshadrUxLjGxhYty3t4bnwMAqJF
         3w90cPoWLS/9RYzUZN8vQBGWtueet0lOurC5QRuqiwbsvA4l5yPM5w2dswRvqGDRvQQ/
         q4tg3KangOHIYr8IeDaNkJul4BVXPLAs7hPCLtB4uWuay86uULqb7Lll3YBanIAafls+
         tt+9cV2wD2nAMcnyMNsGi2eXwUAZyawEwg2qrGKMAHJwfGmE9zfu/HVypxKk/GaQn53J
         gUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696582982; x=1697187782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZwC3GB6k52kbCUUG9Ix1b8EAEchE7aYZwBVKYjR4XA=;
        b=PGIyQWB+X+XV0kTSq6vSa2N+Rb70GOagNncQylgJ9mj8dy+hzzTK9b7FbHOBsW+cEC
         7OxmT2gt9rGxZgUWl33i48f6RvYuExQBXLiiCNKouhiXIo7tiEt7MJZKKSDMQrJUlW+A
         58QeWy777t+ern4ouQ6h3105nm5yS78wN7d3rpsPjOfoPkQ97XgCey080/rBhEjg/gxQ
         CSbs1snYBvTObZalqtkr2I711+iwtWWC6/JcrSiiDqhB3SmsOmMF2G/NUW7EKeT8pHO5
         R0I7hanHCmjW+QtTDB4MLBaPTpshNunP2c0KZJExXyN01h9WBzrStJlT/9XwylFQ1HSH
         EUmw==
X-Gm-Message-State: AOJu0YxVVM0HwK5pNu2KiM/Ru0o4U0KcW36njyo1trKtrgG2LywMA9ny
        vsRSqa2F5Tbh52gEv6hVGWEFpA==
X-Google-Smtp-Source: AGHT+IFgjvKWajihYoYVd4S6stcnv/3r5UDUv8WzSGycctPSMtIc+S8OOAMWOy8pTIYna42MU/fWTg==
X-Received: by 2002:a17:907:6c14:b0:9ae:5c99:f2e2 with SMTP id rl20-20020a1709076c1400b009ae5c99f2e2mr5796258ejc.43.1696582982431;
        Fri, 06 Oct 2023 02:03:02 -0700 (PDT)
Received: from tudordana.roam.corp.google.com ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709064ed000b0099bd0b5a2bcsm2536884ejv.101.2023.10.06.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:03:01 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        conor+dt@kernel.org, alim.akhtar@samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        semen.protsenko@linaro.org, peter.griffin@linaro.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] arm64: dts: exynos: set USI mode in board dts
Date:   Fri,  6 Oct 2023 10:02:58 +0100
Message-ID: <20231006090258.278369-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Universal Serial Interface (USI) provides selectable serial protocol
(UART, SPI, I2C). Only one function can be used at a time. The SoC
provides flexibility for boards to choose the protocol desired. Instead
of selecting the USI protocol mode in the SoC dtsi file, select the mode
in the board dts file as the USI IP can work in either of the 3 modes,
but the board uses just one. Where the USI node was not enabled in the
board dts file, just remove the samsung,mode specified in dtsi.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../boot/dts/exynos/exynos850-e850-96.dts     |  2 ++
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |  8 ------
 .../boot/dts/exynos/exynosautov9-sadk.dts     |  2 ++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi  | 25 -------------------
 4 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index 6ed38912507f..615c1d6647ea 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/samsung,exynos-usi.h>
 
 / {
 	model = "WinLink E850-96 board";
@@ -187,6 +188,7 @@ &serial_0 {
 };
 
 &usi_uart {
+	samsung,mode = <USI_V2_UART>;
 	samsung,clkreq-on; /* needed for UART mode */
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index aa077008b3be..db35ee742a27 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -12,7 +12,6 @@
 
 #include <dt-bindings/clock/exynos850.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/soc/samsung,exynos-usi.h>
 
 / {
 	/* Also known under engineering name Exynos3830 */
@@ -574,7 +573,6 @@ usi_uart: usi@138200c0 {
 			compatible = "samsung,exynos850-usi";
 			reg = <0x138200c0 0x20>;
 			samsung,sysreg = <&sysreg_peri 0x1010>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -600,7 +598,6 @@ usi_hsi2c_0: usi@138a00c0 {
 			compatible = "samsung,exynos850-usi";
 			reg = <0x138a00c0 0x20>;
 			samsung,sysreg = <&sysreg_peri 0x1020>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -628,7 +625,6 @@ usi_hsi2c_1: usi@138b00c0 {
 			compatible = "samsung,exynos850-usi";
 			reg = <0x138b00c0 0x20>;
 			samsung,sysreg = <&sysreg_peri 0x1030>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -656,7 +652,6 @@ usi_hsi2c_2: usi@138c00c0 {
 			compatible = "samsung,exynos850-usi";
 			reg = <0x138c00c0 0x20>;
 			samsung,sysreg = <&sysreg_peri 0x1040>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -684,7 +679,6 @@ usi_spi_0: usi@139400c0 {
 			compatible = "samsung,exynos850-usi";
 			reg = <0x139400c0 0x20>;
 			samsung,sysreg = <&sysreg_peri 0x1050>;
-			samsung,mode = <USI_V2_SPI>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -698,7 +692,6 @@ usi_cmgp0: usi@11d000c0 {
 			compatible = "samsung,exynos850-usi";
 			reg = <0x11d000c0 0x20>;
 			samsung,sysreg = <&sysreg_cmgp 0x2000>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -738,7 +731,6 @@ usi_cmgp1: usi@11d200c0 {
 			compatible = "samsung,exynos850-usi";
 			reg = <0x11d200c0 0x20>;
 			samsung,sysreg = <&sysreg_cmgp 0x2010>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
index bc1815f6ada2..91d302703366 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 #include "exynosautov9.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/soc/samsung,exynos-usi.h>
 
 / {
 	model = "Samsung ExynosAuto v9 SADK board";
@@ -79,6 +80,7 @@ &ufs_1 {
 };
 
 &usi_0 {
+	samsung,mode = <USI_V2_UART>;
 	samsung,clkreq-on; /* needed for UART mode */
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index b228cd7e351e..92f4b738834a 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -9,7 +9,6 @@
 #include <dt-bindings/clock/samsung,exynosautov9.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/samsung,boot-mode.h>
-#include <dt-bindings/soc/samsung,exynos-usi.h>
 
 / {
 	compatible = "samsung,exynosautov9";
@@ -392,7 +391,6 @@ usi_0: usi@103000c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103000c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1000>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -454,7 +452,6 @@ usi_i2c_0: usi@103100c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103100c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1004>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -483,7 +480,6 @@ usi_1: usi@103200c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103200c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1008>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -545,7 +541,6 @@ usi_i2c_1: usi@103300c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103300c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x100c>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -574,7 +569,6 @@ usi_2: usi@103400c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103400c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1010>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -636,7 +630,6 @@ usi_i2c_2: usi@103500c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103500c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1014>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -665,7 +658,6 @@ usi_3: usi@103600c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103600c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1018>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -727,7 +719,6 @@ usi_i2c_3: usi@103700c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103700c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x101c>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -756,7 +747,6 @@ usi_4: usi@103800c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103800c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1020>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -818,7 +808,6 @@ usi_i2c_4: usi@103900c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103900c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1024>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -847,7 +836,6 @@ usi_5: usi@103a00c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103a00c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x1028>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -909,7 +897,6 @@ usi_i2c_5: usi@103b00c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x103b00c0 0x20>;
 			samsung,sysreg = <&syscon_peric0 0x102c>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -938,7 +925,6 @@ usi_6: usi@109000c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109000c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1000>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1000,7 +986,6 @@ usi_i2c_6: usi@109100c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109100c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1004>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1029,7 +1014,6 @@ usi_7: usi@109200c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109200c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1008>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1091,7 +1075,6 @@ usi_i2c_7: usi@109300c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109300c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x100c>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1120,7 +1103,6 @@ usi_8: usi@109400c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109400c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1010>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1182,7 +1164,6 @@ usi_i2c_8: usi@109500c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109500c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1014>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1211,7 +1192,6 @@ usi_9: usi@109600c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109600c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1018>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1273,7 +1253,6 @@ usi_i2c_9: usi@109700c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109700c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x101c>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1302,7 +1281,6 @@ usi_10: usi@109800c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109800c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1020>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1364,7 +1342,6 @@ usi_i2c_10: usi@109900c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109900c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1024>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1393,7 +1370,6 @@ usi_11: usi@109a00c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109a00c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x1028>;
-			samsung,mode = <USI_V2_UART>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1453,7 +1429,6 @@ usi_i2c_11: usi@109b00c0 {
 				     "samsung,exynos850-usi";
 			reg = <0x109b00c0 0x20>;
 			samsung,sysreg = <&syscon_peric1 0x102c>;
-			samsung,mode = <USI_V2_I2C>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.42.0.609.gbb76f46606-goog

