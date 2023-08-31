Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5459378F03E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbjHaP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjHaPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:25:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF15E4F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:25:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso9422835e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693495555; x=1694100355; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6znyQKCV8DafBmq+P0iqvg8LkmCAkhxHacNwGIHAdE=;
        b=pVwKLqqiaSAFqang4Gtl2lH+IrGStVepPDktHzErhLw7EaJ+vAxRFFEnB60XaWxoqY
         Ni+GMpr6obfFyfReCy+cJ/EwfqVwa8exsnKJoZvRgJ/nkVBbefhB8UlywaVMZhvfKiG/
         9pEshq5yryYF5ToQpIv6aSI1rNgFIJursguh8DX6FKTz4TVugtNMdKOV6gxwY4fAsPvl
         U/BHMhOgbvpk7S79oEWbgIm90CsNFl5y/95rRAP0Hqn6xvEoIjqOJriD/kQrHqHU9136
         cCRbux8LS1EPPSA4nIXO+DCH/f3L+tk8g9rnVzSRNXmPp1+wGBG1YlPwBPj4nQF1bShf
         juCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495555; x=1694100355;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6znyQKCV8DafBmq+P0iqvg8LkmCAkhxHacNwGIHAdE=;
        b=Uw39aocuBzpe8H+cHfkUeV6fuEyIvlqFHCiuPPuQF/REoFKwNrXXqp/vG/s++epg9H
         +Zza/JN8Xc6r0GCrfzvUvavoMoyumeNwfPHYktO2UdcWh5RILAtbyhK71cRtgBPuVeJM
         j+LsJL0cwBB5wIsAiC9BxgGe1y5tOzrA4nfCzgSluXavBmCv5We3OkEwI/TunE9+6hR0
         Amiqru0tYBV9413GQlkUMvfN+s8ZZ4bIGLO9NoM4IMyfUdnRVMYEiTLitrfJRKu7SEFm
         KF+bQ6MvaFQdsJll7WdvepiP9Q2sbTe2ESW/w04YQX17TqcPjViWpp6gFJZr6m5AaXAx
         +62g==
X-Gm-Message-State: AOJu0Yxm2dCclnjhECEHLKaTbajLekTaSh4crBcrOt+pnU/Aa4qE+NHJ
        2/1KzONcjhZqrCbNQIZAa8ck7Q==
X-Google-Smtp-Source: AGHT+IGqi6Zhg7O/e3nNg0h/YAXgrMhFBgTWmCrq5DFYHS6y7lj1ivdYRiX1hWZH0S5ZMRcWpnLT8w==
X-Received: by 2002:a5d:44c5:0:b0:319:6b6c:dd01 with SMTP id z5-20020a5d44c5000000b003196b6cdd01mr4202339wrr.17.1693495554816;
        Thu, 31 Aug 2023 08:25:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d4084000000b00317b0155502sm2546410wrp.8.2023.08.31.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:25:54 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 31 Aug 2023 17:25:49 +0200
Subject: [PATCH] arm64: dts: qcom: split pmr735d into 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230831-topic-sm8550-upstream-pmr735d-split-v1-1-98e632636415@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPyw8GQC/x3NwQrCMAyA4VcZORvIVqqbryIeShc1YLeQdCKMv
 bvF43f5/x2cTdjh2u1g/BGXdWnoTx3kV1qejDI3w0BDoDH0WFeVjF7GGAk39WqcCmqxS4gzur6
 l4jTFTER8TpygldT4Id//5XY/jh9Y6I88dQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4777;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9fw5Mg+Da85nnJhVVEO1GAnxk4nSA+fneKHtZag2yj4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk8LEB2EbaTJ09Te/feC97tbyfSwS3tA6XVDNYmkAh
 z8J+H2SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZPCxAQAKCRB33NvayMhJ0UTgD/
 9pWE+/6Hjn/x0eUcC2yelmeWou5gRf/8Rp5garpQI4Cajod9jvC5wIYafGVSnBYuRzhIke0fwcv/a2
 /R4Lv0m4eZaU/LkYRcTJ5iz5PJSse6oQtq09F87SSteAe+3OA+v1p28jYC1v+FN7/IbNA5FHDNB1u9
 TafL2XLqgTs1zhRt/padMxVQl5G3eTxpn69DhYjzZDWFONH3XR++GEvH93wlpse+IEryuXB/YSZOYU
 RZb3j7X9RGTB4DwgPK7MvOqrVWXv8spn9r6fMWtlcnd9q+Alk/rRP1GvrYBI20kOcLvwWLTmzGmYgO
 PAW9sSmu5HHELHzcnZLe4kV7+z2EvLBQM6y6fevMR32OIaSMC+f8Yhj1sktcfdD2tJ5JokE/Ec7sRO
 6wqgvrZpyM/vEbVT0WfTCMWzxhRMqV/x9SI054+uY9BvKICy15nI+dDNj0k9HaafP8yxGy9B8k3ycy
 iajF7y9hfwXKgWrS8nY4Z5dzZs0qhWfu6nUEZwTvEyBeA1D8SjcW38kHUnSKyPZzy7lq6DoI+602rD
 JU/8oejz73uLiJ2M8d+ee9h8jy9fGHtc6rA7FyVyZBilvXMC+EUsSRAtVnFFRsI+8HUldZ9SVkh+o8
 cHOpnYbyZq5NYWPS1MYrEBNiX++HZNixf/H9YRwJcTKnVzgccxgQEM50vmig==
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

The second PMR735D PMIC is not always presend on SM8550 based devices,
split the pmr735d.dtsi file in two so boards files can only include the
ones present on the platform.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../boot/dts/qcom/{pmr735d.dtsi => pmr735d_a.dtsi} | 45 -----------------
 arch/arm64/boot/dts/qcom/pmr735d_b.dtsi            | 59 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |  3 +-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |  3 +-
 4 files changed, 63 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmr735d.dtsi b/arch/arm64/boot/dts/qcom/pmr735d_a.dtsi
similarity index 55%
rename from arch/arm64/boot/dts/qcom/pmr735d.dtsi
rename to arch/arm64/boot/dts/qcom/pmr735d_a.dtsi
index 41fb664a10b3..37daaefe3431 100644
--- a/arch/arm64/boot/dts/qcom/pmr735d.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmr735d_a.dtsi
@@ -28,27 +28,6 @@ trip1 {
 				};
 			};
 		};
-
-		pmr735d-l-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
-			thermal-sensors = <&pmr735d_l_temp_alarm>;
-
-			trips {
-				trip0 {
-					temperature = <95000>;
-					hysteresis = <0>;
-					type = "passive";
-				};
-
-				trip1 {
-					temperature = <115000>;
-					hysteresis = <0>;
-					type = "hot";
-				};
-			};
-		};
 	};
 };
 
@@ -77,28 +56,4 @@ pmr735d_k_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 	};
-
-	pmr735d_l: pmic@b {
-		compatible = "qcom,pmr735d", "qcom,spmi-pmic";
-		reg = <0xb SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pmr735d_l_temp_alarm: temp-alarm@a00 {
-			compatible = "qcom,spmi-temp-alarm";
-			reg = <0xa00>;
-			interrupts = <0xb 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
-			#thermal-sensor-cells = <0>;
-		};
-
-		pmr735d_l_gpios: gpio@8800 {
-			compatible = "qcom,pmr735d-gpio", "qcom,spmi-gpio";
-			reg = <0x8800>;
-			gpio-controller;
-			gpio-ranges = <&pmr735d_l_gpios 0 0 2>;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
 };
diff --git a/arch/arm64/boot/dts/qcom/pmr735d_b.dtsi b/arch/arm64/boot/dts/qcom/pmr735d_b.dtsi
new file mode 100644
index 000000000000..3b470f6ac46f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmr735d_b.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pmr735d-l-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmr735d_l_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+			};
+		};
+	};
+};
+
+
+&spmi_bus {
+	pmr735d_l: pmic@b {
+		compatible = "qcom,pmr735d", "qcom,spmi-pmic";
+		reg = <0xb SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmr735d_l_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0xb 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmr735d_l_gpios: gpio@8800 {
+			compatible = "qcom,pmr735d-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmr735d_l_gpios 0 0 2>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index f29cce5186ac..a0d7d6eba0c6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -13,7 +13,8 @@
 #include "pm8550ve.dtsi"
 #include "pm8550vs.dtsi"
 #include "pmk8550.dtsi"
-#include "pmr735d.dtsi"
+#include "pmr735d_a.dtsi"
+#include "pmr735d_b.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SM8550 MTP";
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 2c09ce8aeafd..afee755c075a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -14,7 +14,8 @@
 #include "pm8550ve.dtsi"
 #include "pm8550vs.dtsi"
 #include "pmk8550.dtsi"
-#include "pmr735d.dtsi"
+#include "pmr735d_a.dtsi"
+#include "pmr735d_b.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SM8550 QRD";

---
base-commit: a47fc304d2b678db1a5d760a7d644dac9b067752
change-id: 20230831-topic-sm8550-upstream-pmr735d-split-995c000e6aea

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

