Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC877F26B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349089AbjHQIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349123AbjHQIrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:47:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7136F1FC3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:47:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so11270781e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692262035; x=1692866835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t4knoTgcpMAoiThrLCBlOztZFf+DUVrX+KwaoYfcMU=;
        b=KIyLDk/dvBbBr+oi6aL3Qh4GCX9z/AZi32P1SZ2JWWozSRLdTLU3rpxWYMthUOU8cF
         5dnyfyMQOFx2RD7hpOKHeWg6b+OLqC5JjoAfHQOmBDsRFnC4PlTOgOWWYPXs5ToER3KE
         nYMxDCRo0lfkG9EbBUAVkrk94rh9lpf1KYX1/nQ4jRcFuxv4Plep1z5Yl3J/n/T9KO0U
         t+cQ/JoaskgiuFVnCN/mpT3anPVkfgHCC+5Kh3jezxrWMAy9vYTgLf8IsdFabD2gOrpN
         S7355qWe1LWuvngCyZt5WIy2Lk/OQLaf3OWlXUxBThCUUqy02xH9qYEDiPwsjpbEfSUq
         Jx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262035; x=1692866835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t4knoTgcpMAoiThrLCBlOztZFf+DUVrX+KwaoYfcMU=;
        b=EndcXmJ1sQ+wP0g4uQhstwwTubzNMQ8wD740g79mZCopKVppZ4OxydWJYEhXWsQ1Cd
         irKEyzPD/zf25v5DyAQKP9bznkCC83LYTdri7kpNb3DBQWopcXiNZHmoqNLgon8T2h6u
         X0PnlYsMawOjYmGwqyENrgZYN8zHDA3hPClJ2t/tIcKBHUSpIxFZrmevp0IDR3DVrGpC
         qKBxgB4axmD9LOM1GfZdIMQi3kHvgFAsPtcGmaI+LMUlKvCzqtM3xn1XnyHyg84AIl0r
         M1pn4epKR5Cyehe9LovjsqZlNzIjddEIMjEM9XPVNB7YPlvPJB3TCIfSWQav3pmDhsds
         /ZLQ==
X-Gm-Message-State: AOJu0Yy44H50NPovAqsmUgAPhY7MXxKsNUc3DmyKETBya77QwO53/Nil
        X0JQZrLWMqFdaDqzP8zQZjYmadF3gbl1T5SZ6QrHrg==
X-Google-Smtp-Source: AGHT+IG6u5+6Wn1fn5uJ/gKC/iV1OP++u+3oO9FHrOsaeIxWT5kYxSQBPhf86/MysuEQZPUDuVryPQ==
X-Received: by 2002:a05:6512:3c87:b0:4fa:f96c:745f with SMTP id h7-20020a0565123c8700b004faf96c745fmr4347010lfv.38.1692262035479;
        Thu, 17 Aug 2023 01:47:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c280900b003fe539b83f2sm2117285wmb.42.2023.08.17.01.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:47:15 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 17 Aug 2023 10:47:06 +0200
Subject: [PATCH v3 1/2] arm64: dts: qcom: sm8550: add UART14 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-topic-sm8550-upstream-bt-v3-1-33f386e7b461@linaro.org>
References: <20230817-topic-sm8550-upstream-bt-v3-0-33f386e7b461@linaro.org>
In-Reply-To: <20230817-topic-sm8550-upstream-bt-v3-0-33f386e7b461@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tbcjsIAk9XwFHFpbOFCyqYsyyRsIObVh70p79lbsc44=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk3d6QRCrxwV0Islpz/NTs+7AAEoluPNwqi8xMOTNu
 djmLQueJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZN3ekAAKCRB33NvayMhJ0Y5IEA
 DM58GC0KqJ6bccbUKVYJ29ocQyPZx5tdw1xVu5EUE3SOb5lmYlC/uNQbVvDo9+c9evu3UwfFqiUPZN
 WxsXOYYzTDwni3CUthKtZO0X0AEDU7PEywshrLqvu5rlOkxYDtL6aFg+tBCCe5WcsIPXRBG09hgLyL
 hIqaLNEuc7mBdrfy0m6BxsOiq2q+k5NmulpuLkRP7F10cWF5OZJxpBvyDyPSv4W51FWluBRHYbiaWq
 jjQq76EhgU68nythnMzULqGUXnkwEmdrqbKZ2l9v4qryp3B+ibgbmV3yrC0qKZFojsLD0+2OnrQat8
 GMZsu1qfiacURY2aL71sdLkZYHmFIJ5cu3whj1ztETh4bbUchxt4PynHgWH0t+2a854cHw7oPkrCr8
 uY5ROCoa9VD4A9gTDk0X1JN0r+U3xoziJhIWT5igbRwdB5J9HdWqCj/OqhWZSb0h31emBr42wB40Ci
 aqIMYakietssBD7dsb6jluiWWsY67FG3/cU6my8FxebAUonGFXCZ+84NUhaqrgVehbcOCSPDHzugxP
 oS1PHCURurCZ/iHrjIGMK/GPgQXlrVRUUnC+DIvxntMZ5I7F7+2UDZeKnso0LEOXnESNvZiAVfGZ4v
 ZiBGFQiJoQUhs0QxzGqTsx6oklUhJM2rr+rqjbYLrJfaQydytK4E9yVMSG+A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Geni High Speed UART QUP instance 2 element 6
node and associated default pinctrl.

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

