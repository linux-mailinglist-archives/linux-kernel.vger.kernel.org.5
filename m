Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE27DA593
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJ1Hyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1Hyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:54:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213AF2;
        Sat, 28 Oct 2023 00:54:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso4329131e87.1;
        Sat, 28 Oct 2023 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698479690; x=1699084490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWNJsQxt66edieq3NUjONu874gZwqx0vvF3MCSn9U9E=;
        b=CzHS1bE84rwOQuiZ2YP3IJIVIEt8f2U64UuZMM5XsV/RznCyMnrZZPJVCCYQpC1Iaw
         6QdjWvns74jnpjSuUSwYN3s8qGMmC1r0FX1RrYMtjJakW9C6rpv8qWs+yo71dpyCBYaj
         EchXoiIcqmMHluv/JwKiql2CQ1L0YIQtq2UKmkfMy/kPYz1hKzvVGJglM73yUzfZSlRT
         uzC7VkqrrcnYxuE94nZHMyWMARPgbsXsHe3Od8ueTZrIOvrgj/HvIPFTQe2x7fm5sRu1
         HqKQlpR0fdK9kJLnIrFA4xdFp69ImAeIQSWmXbBAThVXrbFJUoAAZQwDTBIzGjdpSz4l
         Lg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698479690; x=1699084490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWNJsQxt66edieq3NUjONu874gZwqx0vvF3MCSn9U9E=;
        b=F29VUGRlv8hC8Yqdt9VYcwVtqYdqiul32Rt8HiXghW7FMZdRu3UG5uaeq6p5PH1Kvo
         6WPMGii9qkfwpJRh6MFmWCRjF6DctGYeL2O8AZhPXqlJ2unyDeB301OpOzLUxMfB/4Y5
         HcoTQrCCP/kXGWmLfg0SHUC28ZoOW3ol5DlwDXe8lPIE5LdqEQV3zqPRsiD2wPGqhfcX
         3yv5fIUc9GrdFIIS/a+2OoIILkSv9idblNDfjNm53b7q3C9gHP2k370RETKs10TsDTfc
         ncKzxbJHvBxDSiAb7WDZryV0e0+ddTRbYfLFU2kESXJ9lbbD9QG25I3G3+KJEZucsIBq
         DBIA==
X-Gm-Message-State: AOJu0YxMu3cxehcCf1bsWuK51+JrqPJq7rMDFfTjBjs+B/77IncTLJab
        DGftQseXbagwY7T0Zj8GS8E=
X-Google-Smtp-Source: AGHT+IELtqMRnbnklk2OPXep08KqdzueFWidMDXKJVoTtHqqgwhjS6C32Ie18V8tpr1Tuw8Y+M7g1g==
X-Received: by 2002:a19:8c19:0:b0:507:b9e9:3e8d with SMTP id o25-20020a198c19000000b00507b9e93e8dmr3529803lfd.28.1698479690039;
        Sat, 28 Oct 2023 00:54:50 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b0032f7e832cabsm250845wrt.90.2023.10.28.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 00:54:49 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>
Subject: [PATCH] arm64: dts: meson: radxa-zero2: add pwm-fan support
Date:   Sat, 28 Oct 2023 07:54:45 +0000
Message-Id: <20231028075445.3515664-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A311D on Zero2 needs active cooling and the board includes a header to
connect a simple fan. Add pwm-fan support with basic thermal properties so
the fan runs when connected.

Suggested-by: Yuntian Zhang <yt@radxa.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../dts/amlogic/meson-g12b-radxa-zero2.dts    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
index 890f5bfebb03..895b6ea67180 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
@@ -33,6 +33,15 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-min-state = <0>;
+		cooling-max-state = <4>;
+		cooling-levels = <0 64 128 192 255>;
+		pwms = <&pwm_AO_ab 0 40000 0>;
+	};
+
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <100>;
@@ -286,6 +295,24 @@ &cpu103 {
 	clock-latency = <50000>;
 };
 
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&cpu_passive>;
+			cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&ddr_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&ddr_passive>;
+			cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &frddr_a {
 	status = "okay";
 };
-- 
2.34.1

