Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7EF811947
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjLMQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjLMQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:25:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847C91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:25:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bee606265so7595053e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702484739; x=1703089539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEzLaoNa4BA2w8OvaI5sizwaYC3nqK5NDpqXu6xPo90=;
        b=bwDCU34TKOnn+rqduMXMYWzpqQM5AzEVU6bc5VmcCt0BSjXQyWIh1SuUPpoammUKh4
         wUgWCytNMULSJZmgDwWstN/JWh86Ll9VA6tXLfDHLC78tY07rpS8focHK1HPMvldES3g
         E60GLPnWZVEWAU+ziYQ4qrqDKOM1OSWhN4r4kapHVW2dGRGAVknLQ6qA5VUGmcvb6smC
         5v59m2nhyScF4oq3ic+G76k9p724JEFisBcbgqmjE69zUiUrzW9YT61V+5ULRCVMEC7z
         M8SDj9Pp9UuID+zyC1ynobqBZjuLYmGKpSHHfn5Tg8LEvH4seFz81/VjmK8YzyRon41+
         gtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484739; x=1703089539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEzLaoNa4BA2w8OvaI5sizwaYC3nqK5NDpqXu6xPo90=;
        b=B/MP9kRPLD0oTTPXSRcAVt9LixvK47mup9rEDqDnBc2Y5rzKnP3IW2v7/NYT9UuvrM
         SSGDmEisas8ulE9UW+pI5/VkYqAAKMPtWpTM3xqQcx5C6eydO7DJx/At3FRB85bjk857
         5JDjOTkdAaiwsT0sn7ZOCoUZHtZcBev01s94gEBGH3X6eSdba2x4ZFG/I+r/GuNKrVyg
         GcwWcN5dFevwTYC57FVh5PCH6f5QhsAtJuMrWWhrVXdnWY/r6pvOa/ID73JtlPGh77Xg
         1pn8GWH/z0MQ8GX1QpDSX8eGx3qPbo3I3r6kwYl5sxwW2x5tEMjYY79hMBgqlAzQaSdi
         f+AQ==
X-Gm-Message-State: AOJu0YwRpNCldepzLrJ1QDNiHpsWnfsRfVmkhVUitJBuSck9Xs/txaVW
        G6LY6ZIa693+oSkNrsR8tLD/MQ==
X-Google-Smtp-Source: AGHT+IG5E98UlR0GcrnhVIDtGNzI9Lp1cS9Z1Gd+hPYxMOSd7wpz4W9RmVacJEy0D/WAkK4N263y/Q==
X-Received: by 2002:a05:6512:110d:b0:50b:f858:f138 with SMTP id l13-20020a056512110d00b0050bf858f138mr4628794lfg.89.1702484739673;
        Wed, 13 Dec 2023 08:25:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id kv18-20020a17090778d200b00a1dfc541282sm8048914ejc.225.2023.12.13.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:25:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] arm64: dts: qcom: sm8450: move Soundwire pinctrl to its nodes
Date:   Wed, 13 Dec 2023 17:25:32 +0100
Message-Id: <20231213162536.171475-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin configuration for Soundwire bus should be set in Soundwire
controller nodes, not in the associated macro codec node.  This
placement change should not have big impact in general, because macro
codec is a clock provider for Soundwire controller, thus its devices is
probed first.  However it will have impact for disabled Soundwire buses,
e.g. WSA2, because after this change the pins will be left in default
state.

We also follow similar approach in newer SoCs, like Qualcomm SM8650.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 12e55a0c7417..3b6ea9653d2a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2160,8 +2160,6 @@ wsa2macro: codec@31e0000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&wsa2_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2173,6 +2171,9 @@ swr4: soundwire-controller@31f0000 {
 			clock-names = "iface";
 			label = "WSA2";
 
+			pinctrl-0 = <&wsa2_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <2>;
 			qcom,dout-ports = <6>;
 
@@ -2208,8 +2209,6 @@ rxmacro: codec@3200000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&rx_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2223,6 +2222,9 @@ swr1: soundwire-controller@3210000 {
 			qcom,din-ports = <0>;
 			qcom,dout-ports = <5>;
 
+			pinctrl-0 = <&rx_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x1f 0x1f 0x07 0x00>;
 			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00>;
 			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
@@ -2254,8 +2256,6 @@ txmacro: codec@3220000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&tx_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2275,8 +2275,6 @@ wsamacro: codec@3240000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&wsa_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2288,6 +2286,9 @@ swr0: soundwire-controller@3250000 {
 			clock-names = "iface";
 			label = "WSA";
 
+			pinctrl-0 = <&wsa_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <2>;
 			qcom,dout-ports = <6>;
 
@@ -2318,6 +2319,9 @@ swr2: soundwire-controller@33b0000 {
 			clock-names = "iface";
 			label = "TX";
 
+			pinctrl-0 = <&tx_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <4>;
 			qcom,dout-ports = <0>;
 			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x01 0x03 0x03>;
-- 
2.34.1

