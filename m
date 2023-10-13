Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932F67C83F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJMLCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMLCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:02:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1D91;
        Fri, 13 Oct 2023 04:02:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9936b3d0286so327859266b.0;
        Fri, 13 Oct 2023 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697194927; x=1697799727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/BQk+HYkPOCwfKTzErvfhOabI324ceUMs/WOvUQN+Q=;
        b=HOJ64/0LJ6BZSrzIpPUsiSEM4wmDpJU+67sxR031GkwAO6SdO68v3qhRCSnHO+ygtv
         sbtyBGC3P6IWVyk971Cu7ryz/LM7lqzEpNEF320qFwYpArSRRc123obZVjRHBVc3wnAm
         d80rIm5ekK6rPFP+dUvephS4PS8WPk5qWfF9rppVJQCq+xmKlF5HUr42NEYGQ0BaiZll
         AV5C6k0pqYFOCf4/nzg8woaM1nJM5ZyBfEZcHqn6dIL996qNCJD+6FGbyhWwO0CDAI7S
         1R0XjTJapJW0qL2SgZRjh3pnMjWR+m355fvptZl99Jstf8A+kZMNssWpBPrNAAy3/eBu
         B2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194927; x=1697799727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/BQk+HYkPOCwfKTzErvfhOabI324ceUMs/WOvUQN+Q=;
        b=HELKRneJkCId2zhR+1/9lPB/yISm2Z+j2m9H/vdHXnl1SG5lYNL6Z59lA6ZuwvWXZh
         CrvtLLnWUmCvtw10bbKSB63HGNTCPU+IUk2lZK0QXfLlauBkCq0zqqYFn0eK5WQcOLAv
         S4dmcVPpsX6O4AgfTc1zYgXKlb9G8FuK33Giv/Z6ntdnqgYA/BLVisexo1XQWepwx7Ph
         tsTNhQ9uG2krSeX5Sc27b2gNpk3NK+nhuvc+z67KDMopTYWYaS0ThjPDufc0TKGxMlTa
         xlHGb1z34rD0K/bnbkQUuBGTq7K+XuDBnBvVy43iIphLeEEuu0SmlDM9NJhbjAX0RqJR
         BxZQ==
X-Gm-Message-State: AOJu0YxCYnWD1PSoXcuSFFChMUFEvPAOO2bdggIhRfZQSlDkt6AZxU2m
        7ijuzGZMO5c2P+caI8lCg9E=
X-Google-Smtp-Source: AGHT+IFquNwq8Aav6LZJFXoWpkjPCAY+VtzFfCWRbnt1fjcsOHWkWpGpF5FYA2NGIsVJ9vtihYe1Ew==
X-Received: by 2002:a17:906:7382:b0:9ae:284:c93d with SMTP id f2-20020a170906738200b009ae0284c93dmr20261880ejl.5.1697194926562;
        Fri, 13 Oct 2023 04:02:06 -0700 (PDT)
Received: from arch-laptop.tail46804.ts.net (net-93-65-126-31.cust.vodafonedsl.it. [93.65.126.31])
        by smtp.googlemail.com with ESMTPSA id a6-20020a170906190600b009ad89697c86sm12341169eje.144.2023.10.13.04.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:02:06 -0700 (PDT)
From:   M0Rf30 <morf3089@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     morf3089@gmail.com
Subject: [PATCH] arm64: dts: qcom: msm8953: add SPI interfaces
Date:   Fri, 13 Oct 2023 13:01:36 +0200
Message-ID: <20231013110137.82439-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gianluca Boiano <morf3089@gmail.com>

This change add spi_3, spi_5 and spi_6 interfaces to
MSM8953 devices.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 102 ++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index e7de7632669a..cdfc38e562b6 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -726,6 +726,48 @@ i2c_8_sleep: i2c-8-sleep-state {
 				bias-disable;
 			};
 
+			spi_3_default: spi-3-default-state {
+				pins = "gpio10", "gpio11";
+				function = "blsp_spi3";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			spi_3_sleep: spi-3-sleep-state {
+				pins = "gpio10", "gpio11";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			spi_5_default: spi-5-default-state {
+				pins = "gpio18", "gpio19";
+				function = "blsp_spi5";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			spi_5_sleep: spi-5-sleep-state {
+				pins = "gpio18", "gpio19";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			spi_6_default: spi-6-default-state {
+				pins = "gpio22", "gpio23";
+				function = "blsp_spi6";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			spi_6_sleep: spi-6-sleep-state {
+				pins = "gpio22", "gpio23";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			wcnss_pin_a: wcnss-active-state {
 
 				wcss-wlan2-pins {
@@ -1360,6 +1402,26 @@ i2c_3: i2c@78b7000 {
 			status = "disabled";
 		};
 
+		spi_3: spi@78b7000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
+			dma-names = "tx", "rx";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi_3_default>;
+			pinctrl-1 = <&spi_3_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		i2c_4: i2c@78b8000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x078b8000 0x600>;
@@ -1413,6 +1475,26 @@ i2c_5: i2c@7af5000 {
 			status = "disabled";
 		};
 
+		spi_5: spi@7af5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x07af5000 0x600>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
+				<&gcc GCC_BLSP2_AHB_CLK>;
+			dmas = <&blsp2_dma 4>, <&blsp2_dma 5>;
+			dma-names = "tx", "rx";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi_5_default>;
+			pinctrl-1 = <&spi_5_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		i2c_6: i2c@7af6000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x07af6000 0x600>;
@@ -1433,6 +1515,26 @@ i2c_6: i2c@7af6000 {
 			status = "disabled";
 		};
 
+		spi_6: spi@7af6000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x07af6000 0x600>;
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
+			dma-names = "tx", "rx";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi_6_default>;
+			pinctrl-1 = <&spi_6_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		i2c_7: i2c@7af7000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x07af7000 0x600>;
-- 
2.42.0

