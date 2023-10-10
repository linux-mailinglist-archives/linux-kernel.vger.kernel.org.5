Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9027BF164
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442006AbjJJDZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441902AbjJJDZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:25:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B0EF0;
        Mon,  9 Oct 2023 20:25:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690ba63891dso3810983b3a.2;
        Mon, 09 Oct 2023 20:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696908302; x=1697513102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+t8tXe6ccmmDxngyTtST79lozTn11v8rTEVF91HUREg=;
        b=NtLdpSEoJLYh/6a2iempfokr0ZK1SM6lV6FJ2agyhr5FaxbOwOW5wNcQTfXzzyXFTt
         q3wRfj1o6YaT896QmQ0HIAdkcCW6wyg6h4URuzVojLUBWNK6uhZR7EfsmjCn15E3DTRK
         XfJb1DVI3yThay/o+2ndznLsUDMVnRI6vwsK4IxCs3FXSCI9MR1qN1S75OZU/yVN0NiR
         NkLz0PVvKMSwoSV8ZKFI3NzvhNkQbtApHeSyOUvJlais1lPjvvygcpJEg1bdfI9//r1G
         OHEnUV5arRgjtXH3tR+mO7ruun2tWGvCMRmoMqw4kLAQ/I2pFZmW/Idtoon0CEdDQ0la
         gNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908302; x=1697513102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+t8tXe6ccmmDxngyTtST79lozTn11v8rTEVF91HUREg=;
        b=uATi7TB3532vyDmjqHCn7YEpV20co84Na/eMcJPVNmxN+zXj1ZtiRbQ6TW3SDc9NFt
         jJvhcXg74mANlPvqW2XZoVrmjfg3TmEvFwue4N55nZPG6pYtz8m6VbleGQesBaP3IGpk
         KSpsUtJtKRVI6Qh9HLW2eP8gPSpocO5KZ7GBSJ4YJiIea9Xpl9DohErpBEhbUNU6lGYy
         QwMYwoOY/Y20UG95o/NDEMAQ7O+dPJRoBZHVqtu+GRL+7WNp+HLrmqoNysoi+q7Baxzz
         Huew6QsJ62+cxivJ4I7BVNXntaFRFL/Fkyls8N4xxi6Ymasp8D/FLwWolmhGUb0am+pI
         7JWg==
X-Gm-Message-State: AOJu0Yw7GKcTTgBcOle+YViuvEJA+cElz0oE4qLM4z0bNAUgxz/9y16P
        v1ukDguxfkfQHHHFAk2qgis=
X-Google-Smtp-Source: AGHT+IEL8ecO+HWvFjZFChLjSmGujXLE1GhBRWwD35P3NWAIekKYEDrLkkZ+63uXO2us0bKMFodICQ==
X-Received: by 2002:a05:6a21:3294:b0:16b:8572:5a4a with SMTP id yt20-20020a056a21329400b0016b85725a4amr10166460pzb.61.1696908301825;
        Mon, 09 Oct 2023 20:25:01 -0700 (PDT)
Received: from localhost.localdomain ([49.205.243.94])
        by smtp.gmail.com with ESMTPSA id c16-20020a62e810000000b00690f662a1cbsm7053851pfi.0.2023.10.09.20.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 20:25:01 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: amlogic: Used onboard usb hub reset on odroid n2
Date:   Tue, 10 Oct 2023 08:54:43 +0530
Message-ID: <20231010032446.3194-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid n2/n2+ previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 91c9769fda20..9e671444eca6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -31,6 +31,30 @@ hub_5v: regulator-hub_5v {
 		enable-active-high;
 	};
 
+	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
+	usb-hub {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 2.0 hub on port 1 */
+		hub_2_0: hub@1 {
+			compatible = "usb5e3,610";
+			reg = <1>;
+			peer-hub = <&hub_3_0>;
+			vdd-supply = <&usb_pwr_en>;
+		};
+
+		/* 3.0 hub on port 4 */
+		hub_3_0: hub@2 {
+			compatible = "usb5e3,620";
+			reg = <2>;
+			peer-hub = <&hub_2_0>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+			vdd-supply = <&vcc_5v>;
+		};
+	};
+
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "ODROID-N2";
@@ -234,18 +258,6 @@ &gpio {
 		"PIN_3",  /* GPIOX_17 */
 		"PIN_5",  /* GPIOX_18 */
 		"PIN_36"; /* GPIOX_19 */
-	/*
-	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	usb-hub-hog {
-		gpio-hog;
-		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
 };
 
 &i2c3 {
-- 
2.42.0

