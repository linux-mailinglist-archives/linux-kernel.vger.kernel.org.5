Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758957AFFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjI0JWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjI0JVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:21:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48692
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:21:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-532c3b4b55eso12712941a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695806510; x=1696411310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrNZz4J5AB8k8tkCs4OKVB/Yb88Y5s1jcClgfUjs9SQ=;
        b=CkgDm/ASGW4OdpwDxXQJPkm+CDuW2cJOvL62rKvItYXe/KmhSkTGOIyAPewEGA2GhE
         U325O+WXTXqPK2crI+v7C9sGl3vSdL5MKklcUDpSU477Y1yblgqfIInqL1Vv5ePS0ZEU
         G4iSHtmZ1LGhm4bKt+3s72omxgaQxSLX/bvuV4wzNgJrKN53DnuTZiu2/U8ZnNoa6E8O
         eye6XWg9hvhQMFyDusXdkmxoU3aw0Xx96DdGuPJP32mF3qrDL1L6/JOkNRRmhuQeZ9QL
         DXTeAdhb4N1iJY4o/nLpwc4rlmmvqg0mRu92vG5hfHtzClP8/KJwREdtQW0WWTacNWOo
         tirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806510; x=1696411310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrNZz4J5AB8k8tkCs4OKVB/Yb88Y5s1jcClgfUjs9SQ=;
        b=vi5wZpmQC6jpW4BPNW8swdoR0+0X5w9w8K1TaqLZCgEias3NimkflZ6J41Emd6Qsu8
         UKDUrEP2ydAGahxIJBGUEbZURXFJeAlw15Bw5DEjn/RT6yte4tMa3nndAsWW1f9cuAnr
         QLOVXgs1pt1DWZLHGNSVNXf9ZHK4kKYrHWn3e4f225HWUQ1j9uOXXkZKQUJ8np/14Bz6
         dUeSP3I8RiaYWIOQNSxhdNK/2859wQyadGEcz+fEFYASdphTdrVVfJF6yQchkZXuW3Km
         cy/CswHGRUo+CuNJ2zJuivLR2KQ6q1jiE2OYzVJ/BOxqdS9VX9Fi6F9akkweTbBUlLyF
         euHQ==
X-Gm-Message-State: AOJu0YxGaOuyodgFuMW4sStC6OQjqH86eqhMGWT6YokBTGvBc8sYY/1H
        k4jgv1SdfkU3KOqBeRMe1cvG5A==
X-Google-Smtp-Source: AGHT+IFbt6Dah7lOsFQtzhQHBHg4JDw/GoaNADJYwYUjaZ6OMSv0x0CSOroAvI4lphVB03y81EZiFw==
X-Received: by 2002:a17:906:8466:b0:9ad:e2c8:1741 with SMTP id hx6-20020a170906846600b009ade2c81741mr1143116ejc.58.1695806510527;
        Wed, 27 Sep 2023 02:21:50 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id qq23-20020a17090720d700b00993664a9987sm8948574ejb.103.2023.09.27.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:21:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 27 Sep 2023 11:21:40 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: sm6375: Add UART1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-topic-6375_stuff-v1-1-12243e36b45c@linaro.org>
References: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
In-Reply-To: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695806508; l=1838;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nKwVvVENwQlrT+MFxAKAsgUztjCszp4MAxYLAwEAU5E=;
 b=5qenOHOxD4iU/AlqhBhUgcQlADszVQIO/2tGeWeoTJqDP014QTQEhy/Ox/uA3gak6K8orXIgY
 tnRfRXcQ8uZAX8K+svitb1nJSgAy9wXymQhYnK0H6/m4xnGfoTRtKxA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UART1 node, generally used for the Bluetooth module.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index e7ff55443da7..2fba0e7ea4e6 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -896,6 +896,36 @@ qup_spi0_default: qup-spi0-default-state {
 				drive-strength = <6>;
 				bias-disable;
 			};
+
+			qup_uart1_default: qup-uart1-default-state {
+				cts-pins {
+					pins = "gpio61";
+					function = "qup01";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				rts-pins {
+					pins = "gpio62";
+					function = "qup01";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				tx-pins {
+					pins = "gpio63";
+					function = "qup01";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				rx-pins {
+					pins = "gpio64";
+					function = "qup01";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		gcc: clock-controller@1400000 {
@@ -1111,6 +1141,19 @@ spi1: spi@4a84000 {
 				status = "disabled";
 			};
 
+			uart1: serial@4a84000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a84000 0x0 0x4000>;
+				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
+				pinctrl-0 = <&qup_uart1_default>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
 			i2c2: i2c@4a88000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x04a88000 0x0 0x4000>;

-- 
2.42.0

