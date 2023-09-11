Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7932A79A47C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjIKH3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjIKH3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:29:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51E8CEA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:28:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f915c3c42so1489894f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694417330; x=1695022130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNUj62/M4tmKX/2DqRZP4HVxTwSJsxlX5VsGMGceMUs=;
        b=lK7poQ18MK++qPsAXx7ZqN75o7S/a/uj0MKVNs6zq22AK/oJL+yX23XoAf792LpDc3
         GYOgg/W9dr67XFOE8vX/aifw+ikEAFF185mpI1gpV4wLr7oSIgbyeTX13UM6+Yvxjbik
         wPVY4mdtmL2vE984Clo88UIZJ79K09WEBS00ixn0V7OB1PuQSnGB7sBK7PADMEcpQLkV
         Vo4Vo5EdwRpEmp96SX4ECCXfoLd8xxnAIgZdspweDrLUnTeR9dDlIHnrZhr3Q59UC5qh
         3f/xX1pTLAdgSRHa19gLkqRITK1amPJlvqNCgCn9ghYv264mCVLxEBh5mCm53rkESYD4
         o0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694417330; x=1695022130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNUj62/M4tmKX/2DqRZP4HVxTwSJsxlX5VsGMGceMUs=;
        b=KIE5/ZsqCi7oGuoGlWT4QHb6yrhbFCAHu8sV+v9JkvGSfX96DRM1+At8bOxmzp9sm/
         l+uu3R4TvEAahorjUnsFYZSPuw7C25xPxn8G80TQJjkBKq1RUe9qA4dBxHg5FiIRZ/n1
         S7nX4SKDEBL44uMHg3qrYv3VF/NdP75xN01WaALWnqiLUhYjurXT83qp7hMbVJCQKcMX
         LtKZXzzwMOQjpAG4TrlhRWyoZrua3qWM28JmliVMWjZa9WYDwrtpTKpepN3XHdQkoeIl
         46+AldenvX1A7xK3c6Xv/Vsd18mYv6MMpw0sylESxjudiC/NQqodjDCnoyOu8o3ZrqwM
         +0Ew==
X-Gm-Message-State: AOJu0YxgD+tDpNkY8OGoNq0Ia58YkXiA8iwTlfYX/WOuOxF2IvhNydV4
        /1JXG0H+lK5cmbz7W2Lrbkg/ww==
X-Google-Smtp-Source: AGHT+IGmSjX3IT75Zk0BefGyDnNOjOY7Ph0JzDqH960D2dH81wBL7UvgbQdZDJe5WPDVElegXjiV5A==
X-Received: by 2002:adf:ce89:0:b0:31a:d4d0:6e98 with SMTP id r9-20020adfce89000000b0031ad4d06e98mr6689874wrn.8.1694417330310;
        Mon, 11 Sep 2023 00:28:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c17-20020adfed91000000b0031779a6b451sm9250075wro.83.2023.09.11.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 00:28:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 11 Sep 2023 09:28:46 +0200
Subject: [PATCH v4 1/2] arm64: dts: qcom: sm8550: add UART14 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-sm8550-upstream-bt-v4-1-a5a428c77418@linaro.org>
References: <20230911-topic-sm8550-upstream-bt-v4-0-a5a428c77418@linaro.org>
In-Reply-To: <20230911-topic-sm8550-upstream-bt-v4-0-a5a428c77418@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Jx1oOXLodxCtBg0nzOzN4S7TEr0xljs+0VicKiw5/8s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk/sGvH3WKMfgPSq8J2S4r3oh8huQzx4NBfptxOJMx
 uJU2tTSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZP7BrwAKCRB33NvayMhJ0cfZD/
 9ctPinjqGvGoh6dcZRRS5G8tFV6B4YpQjbrPW65UpzZfI/5I1O7cAkRcyZP+lQ59Gdop20r7FTRMRR
 Bk0MUvlTZXsWngXT9ut56mHTiL8XD4GBAfGdPxZ/gFM4HuzB78qHpT9i+tQulj500Mb1bjSt83T6Kq
 Kq1HPL2jbKu6FJUa5SbNM7VjkakkJnrn7oEHe7u6Tb0yeALZbCHrV/4JFIUn6h0TA9ezJ5dhmHpAHN
 y4qHTj+2iy85z9OmGEkqlDOCPp4p39Q+32JKTCCdcT3UUZCa15r80aVrzqzHQTK5zqilQNmVkt8rG0
 m2Y+VZQMtjiPOXW1HxdHirj5OG73smRRu5AuqfWxo3V13OJTtVX9cukziXLpoFfDHZB8D9BBjudS4L
 FV2tmXj5PAngFQOEPdnj8wkieJuwYW/47nHs2UCUqs3hNCpVBuq4/TydtI8SkBhGlOB6BpeOIeoTkO
 O8a+ue9sFBSsxfOtvlkpOSNWs6Yaq8lh4wfi7JHxx3KKh+QYgIIMWKBhqTo9X8WvmGlsZ2KDLue+vF
 kigMjtI5Dk4ctWQLtDVSxGgAGSrB7PgOABnFVdyiyzma/LR7ydSt+z3SlJCwf7R5Ul8+86zqOlOHuq
 YIIdSHSMZh1g2OtpBAiYsswtHW8MEgi/0FUoZbjuwTV/S7rRikvumoIeutSw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Geni High Speed UART QUP instance 2 element 6
node and associated default pinctrl.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d115960bdeec..4be10a9bf933 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1054,6 +1054,20 @@ spi13: spi@894000 {
 				status = "disabled";
 			};
 
+			uart14: uart@898000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x898000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart14_default>, <&qup_uart14_cts_rts>;
+				interrupts = <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
 			i2c15: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0089c000 0 0x4000>;
@@ -3498,6 +3512,22 @@ qup_uart7_default: qup-uart7-default-state {
 				bias-disable;
 			};
 
+			qup_uart14_default: qup-uart14-default-state {
+				/* TX, RX */
+				pins = "gpio78", "gpio79";
+				function = "qup2_se6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart14_cts_rts: qup-uart14-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio76", "gpio77";
+				function = "qup2_se6";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			sdc2_sleep: sdc2-sleep-state {
 				clk-pins {
 					pins = "sdc2_clk";

-- 
2.34.1

