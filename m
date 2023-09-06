Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D779381F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbjIFJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbjIFJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:25:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF00F1708
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:25:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so4890610a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693992303; x=1694597103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6p/xZXs900v4vDHCTqR/tX5qKtbr2J5Y6y2wWsKdjA=;
        b=ApaOGQd9FqXgZftmrsjFERD93alSlyBQfC7VrDm2OYdejxYI5HchDzEAg+mnxUypBu
         udcs9NfIkuJPtb7uMHvVMnld0KUApqujZ/qqYIxrDu74Bh3kLe8o/Qy0/CQSVqg9zMFd
         1R5A+Z+UrZ8O6sy+XSLV4uYqaeQpuZSBJqYyS5vuY87M8EUhKD7tn7/Ldmb435/ZLxMf
         QVEJae2jruQvRbdk6n/YRXAI2Ok/61ArsfS2iVLR7XPkRU+Tfd43gATRsHmlsb7t75oq
         aTjI8zXqBhSAmnviR9thMBgf8YPFfz197MW/JhhdSW6ozzbIggArQYBv8hPnLtajowXP
         ALZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992303; x=1694597103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6p/xZXs900v4vDHCTqR/tX5qKtbr2J5Y6y2wWsKdjA=;
        b=WBwD0dd8HP7/5Jr7HfqwjM3CMtUxj4zb4zSSAKE3lhXi5F/ZPz6BxGo4A9HU+XhEbo
         xsrbVji/Je1zK54bhsrVNVJ4y2ESaEErwXBRwPNw093igy7EA1E2S8B8Xg7Ke4akhQIe
         ugLsIRXMGRM01FhYsgPMhWmOtzAvFXkZy0XAq+zTJTU5QbIt5mAVszteLr0wAbSZqKOs
         GMSEk0MCVloX8+cRQpDGkPxnpjf2BSWYFG9GIhO21ae1fxbUPRwmIRKpHftF0AgkPf5p
         xAcVR17mVeB2/HjD4Pxg6fxj30Oj5CSO3//HFeynp5I7tdjE7a4IDqf3ijhG1JzqQeuk
         goZw==
X-Gm-Message-State: AOJu0YzimJ9Y5A+hlBXetJcQgzHYZBoYxceqkxB5le+NA9ShYBuh+h6L
        yVEi1XQ7YRtRS60u4q6vP9gq9g==
X-Google-Smtp-Source: AGHT+IFdAEMUz+88edXZb43tzldXC9wcDLVBbqV0a4yyVzNmNROPo4VCN1khS5KFMQ3UGo0caLGccw==
X-Received: by 2002:a05:6402:5172:b0:523:2e30:aaee with SMTP id d18-20020a056402517200b005232e30aaeemr1773809ede.32.1693992303456;
        Wed, 06 Sep 2023 02:25:03 -0700 (PDT)
Received: from [10.167.154.1] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b005232c051605sm8096155edt.19.2023.09.06.02.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:25:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 06 Sep 2023 11:24:58 +0200
Subject: [PATCH 4/5] arm64: dts: qcom: qrb2210-rb1: Add GPIO LEDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-topic-rb1_features_sans_icc-v1-4-e92ce6fbde16@linaro.org>
References: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
In-Reply-To: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693992295; l=1581;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UuNd8tggE5iWiyJA3F8yW6H2YAWEjVItZbSqtIqrHRA=;
 b=vlWYHvPSLfOkpmRgpAeQijRsCZdcBV9xDwMZbr3XygAYB4tIIDlFLKMfebwqwlESs2L4oJgD8
 7D5yBqy0iY7CyizPLcKGRnj/YaKJeYHUUMtF8ZnPsqnuyR1Z94G53vc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the three LEDs (blue/yellow/green) connected to TLMM GPIOs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 5f7619518deb..fd45f58e254d 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include "qcm2290.dtsi"
 #include "pm2250.dtsi"
 
@@ -39,6 +40,38 @@ key-volume-up {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-bt {
+			label = "blue:bt";
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+
+		led-user0 {
+			label = "green:user0";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&tlmm 52 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			panic-indicator;
+		};
+
+		led-wlan {
+			label = "yellow:wlan";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
+
 	vreg_hdmi_out_1p2: regulator-hdmi-out-1p2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VREG_HDMI_OUT_1P2";

-- 
2.42.0

