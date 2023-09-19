Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6215B7A6390
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjISMqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjISMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:46:17 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3DC12F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:46:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so60881225e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695127566; x=1695732366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cayq2XwlrQqenkKdhvhc7PohXHp9znYKa41IjUAF5M=;
        b=1jHnQ4nnifw4Tu6o8RPPr/cQxt9dmogX5YtccjTHuwNL7YhLYIL5v6HyOk7WP2Yxn2
         XPmwVGwch5YBwGeBzjiJ2yit/yBPvI53LZ/RHPleL1Rd7PYpGLLx20cQHLCypcDA2cr7
         /a1LtU6oDy9B2v5q/OfQ1X4y0Bnw8VSMP++8g4rHEmim6PQ3Ch7+40sNs7URuMJlteJJ
         nzA/1POYQ7UvRnNvfvHAHYt1YzxOz8fKVw+cOWgdeF1j6MczUYbN/dnZ5Jhc2boXfRup
         BtNTBPU2D7j1Ehk1gFd38lFHGbYXvRQpUZDIgEvpzkAKjmOLw4juM8AdP0bBzY/P9yyF
         4FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127566; x=1695732366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cayq2XwlrQqenkKdhvhc7PohXHp9znYKa41IjUAF5M=;
        b=mpYlT/wABvhYBQl8juJ+mnVZbt4Yh92Rvjk1XBxXnVzFNOwoU86UrOQGN26zOwsKBP
         wfjtHg2ROSpvw9/BptaNIfShFZtSFNkdf4Ue5d9IK7JKBnvkUgf63JLbJB3oZrYIEahs
         J+T7ZxI7us65bxBydV09P0R5YF+TDndxfYAhb36Bp4F5FcU9+9dWMh45OOrhrbqfoXsn
         a4Bg4haDiD5ECiLAOJ515/IS6ICH1G/jTEgXZbtd1OG90hTgWjXI7ZUodj4d+thiwHej
         V/LuZWa8RdWOnJ4rQn7r47EVJlr39L2T0YvcEZwfD3w9wo+AbJboyz5FlDoG3T0LZmF8
         oW1w==
X-Gm-Message-State: AOJu0YxgBi9Od3X4Dto/x9Vl6hPQ3HNGFYrq0H8xTs6W7qXlNmfikCex
        8/jKhPt1MRLzIYfabk1JUU9Nqafu/0nEEd2F9HKwyh1G
X-Google-Smtp-Source: AGHT+IHQmdZ3mCAQWWF0IvQWyCVEp8mSaOHrK4oyGbefs0W0x7kd31beka/YHFqu8VaqZfM7QZIPNA==
X-Received: by 2002:a05:6000:612:b0:321:55e6:9a12 with SMTP id bn18-20020a056000061200b0032155e69a12mr4808624wrb.6.1695127566482;
        Tue, 19 Sep 2023 05:46:06 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00532c1dfe8ecsm635878edb.66.2023.09.19.05.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:46:06 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 19 Sep 2023 14:45:57 +0200
Subject: [PATCH v2 3/7] arm64: dts: qcom: pm7250b: make SID configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-fp5-initial-v2-3-14bb7cedadf5@fairphone.com>
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
In-Reply-To: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other Qualcomm PMICs the PM7250B can be used on different addresses
on the SPMI bus. Use similar defines like the PMK8350 to make this
possible but skip the ifndef based on maintainer feedback.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi             | 14 +++++++-------
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts |  4 ++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index e8540c36bd99..df0afe82f250 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -39,16 +39,16 @@ trip2 {
 };
 
 &spmi_bus {
-	pmic@2 {
+	pmic@PM7250B_SID {
 		compatible = "qcom,pm7250b", "qcom,spmi-pmic";
-		reg = <0x2 SPMI_USID>;
+		reg = <PM7250B_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		pm7250b_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
-			interrupts = <0x2 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <PM7250B_SID 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
 			io-channels = <&pm7250b_adc ADC5_DIE_TEMP>;
 			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
@@ -60,7 +60,7 @@ pm7250b_adc: adc@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PM7250B_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
 			channel@0 {
 				reg = <ADC5_REF_GND>;
@@ -141,7 +141,7 @@ channel@99 {
 		pm7250b_adc_tm: adc-tm@3500 {
 			compatible = "qcom,spmi-adc-tm5";
 			reg = <0x3500>;
-			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PM7250B_SID 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
 			#thermal-sensor-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -159,9 +159,9 @@ pm7250b_gpios: pinctrl@c000 {
 		};
 	};
 
-	pmic@3 {
+	pmic@PM7250B_SID1 {
 		compatible = "qcom,pm7250b", "qcom,spmi-pmic";
-		reg = <0x3 SPMI_USID>;
+		reg = <PM7250B_SID1 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 136e273d09a7..943d5a150b64 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -5,6 +5,10 @@
 
 /dts-v1/;
 
+/* PM7250B is configured to use SID2/3 */
+#define PM7250B_SID 2
+#define PM7250B_SID1 3
+
 /* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0 */
 #define PMK8350_SID 6
 

-- 
2.42.0

