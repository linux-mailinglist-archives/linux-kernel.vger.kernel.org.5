Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A0B7C5933
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346876AbjJKQdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjJKQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:33:35 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18EB6;
        Wed, 11 Oct 2023 09:33:31 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AD4F4CD2DE;
        Wed, 11 Oct 2023 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697042009; bh=8g/YfES0v8t05diXHUePZLF5PXaN9mElmGUtMj35Yks=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=vwldJMw6ldNwjX5oSI6KMeA3dFITSEaXb9KFRUYhNJSsckpBSpOnKbObQSawYcWCr
         0cxr3RBEfzf5VrtQjh6wnfU6LftAf/mcw/hSy2fIafSr1MoIqLJG1HLaa8cNelYA/e
         Fv+cjNMc7zuwXUX6DSRt9OsBjVQ5LaoDMCfaMwmE=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 11 Oct 2023 18:33:15 +0200
Subject: [PATCH 3/3] ARM: dts: qcom: msm8974: Add watchdog node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231011-msm8226-msm8974-watchdog-v1-3-2c472818fbce@z3ntu.xyz>
References: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
In-Reply-To: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=E+F/Hhj1CB9aUX5EIjUXqb42IcC8Koc3Sj2dk06Hdx8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlJs5YtpYca/hMJceIqPYwj1svU5pSsXLWDgf94
 40V5T76iIWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSbOWAAKCRBy2EO4nU3X
 VuuID/951JcQECOWy/t86yCyh2v2PPNrcv2msiFH+P4EIAo7tRkj7F9xpPyi0P5OSEsDNuARfyF
 n5FEgov7+x3zkuBFDmeVRvYuIvVd2CPaLnV6Lj3L3cHrdqq9bbGK4avzVGJYP/z1kJIXxbfanG6
 woPPHE002XNIABIwQRlORgguFbf5fSBAfxi7lNRtz9vMtn7HWePYrYLIAZ4mNUAjXFZlyrvaoc5
 KzCnCLuB/JzuZwJhO+hjYiKWXHevUTiuKUvjuVzYMvLDMsP6c3vezv/SZBtmiDs4vC/LubrqIaQ
 2mSawN/werlLYgUFG7Vk8CxXxiJ5FfylDOSiq/upjhfMpksls4lo7UWwq0vsV7dPUg2nTzSBU0z
 wLtecla8QYbVfIn9/+J/4T565c/pNhJj0J6B1SG/Gm1o3HkCbKbT2Aln4IIx9Ac1KSvnGF3Ie+o
 oqoRJKNj/u0ponJT38AYbzpJhvs5RulDLpHwe4+EO2S6rQ7GOJHJWjssFab3rI426ial6fVIMh/
 CtrgdRDp9PZoj2FV94KEE7KfxE+YXfgmX0NSxXTx3WqRPi44Bc18nyBx3bP6c7qCS57W3lg9H/J
 bqkbYht0CUoAYpselD4MzU6OUNDHqEqo3N+CSbks5mDU2H3OK5igoQ9kV1VDTkfzOh017sfklJn
 N+yG3u3seS1w3Cw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Add watchdog for MSM8974 platform.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 0bc2e66d15b1..fbeadd43c9ad 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -346,6 +346,14 @@ apcs: syscon@f9011000 {
 			reg = <0xf9011000 0x1000>;
 		};
 
+		watchdog@f9017000 {
+			compatible = "qcom,apss-wdt-msm8974", "qcom,kpss-wdt";
+			reg = <0xf9017000 0x1000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sleep_clk>;
+		};
+
 		timer@f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;

-- 
2.42.0

