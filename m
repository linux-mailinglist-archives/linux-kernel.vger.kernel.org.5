Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51CC780F18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbjHRPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378111AbjHRPX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:23:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA8F3C31
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:23:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so1500304e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692372234; x=1692977034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1xzZ0W874SEOTWXH4StKneqaFG4tNGn8zR8JVsBtJY=;
        b=K7hWwjPjF3NXbtwTMofTwi/l9EVUmi7Qff+2+TwRxiwXOSJBkuIu8+g0btD3BB/Z+C
         3VXB1WX6k20LzuAatijJZngb5+KhQ6fENe2r21nYWtu3LWLmKY3hdJ7jeUmbgvMVY1lp
         bKRj7ZMM2MdTsAjr4F4tbGOQOQxtI7rDYLvxqyI//aKJhbD2QeBJnJuHjGcorMVj/KNj
         6M/xMyqS6KQ2ygw/ZJ0wyE0HGcu3aaXO2hgQPwHWs7VLBWsZZjgP9K9ds7CfDPG1tkyp
         c7h/GhDXIe8MXJ1ST4L0R7m4IoTgxVN3odamSWzZxhAnfjhuMZ5em8ukCXavAob4Qj7+
         o9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372234; x=1692977034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1xzZ0W874SEOTWXH4StKneqaFG4tNGn8zR8JVsBtJY=;
        b=cT7BIfkXnpdCP5e8B4n+17oPqGyNIwOJenmWRt89jM/zyDVITOvAhnYPqyETkEm81J
         1jahDZIrSxq2Pf7v7MW0XZXqPr5tuNmSbiJ0PLPiDPzj9KhnNw3MyZwJCH4Wz12fRa+7
         pIDH6kaf58w6DjPX+kb6/A2m27HXsTeFU8/ZyiulMvqwzCEn42+E3uwHw5CTyfIWaQDU
         /CNoxaI/hg9WUBCCwf7Q/lfZa41FqgBMCuCbaDL0OtkUc7aWDmuHtZnvNcEXjRRFQEMe
         l5tHvvfCH9KOOpEicgI5tQVu9ABWz+L1iPp7CxWuspR/HZVGllCEb3nx2pxmjqHd1yBt
         C07g==
X-Gm-Message-State: AOJu0Yyqv+Vm0/Zt+fXk5TnIO+5mgE3ESIQVl9BglpX+CwUmhMZv1eOq
        i+cV/aVF1NoWO/cksUKwfefZFA==
X-Google-Smtp-Source: AGHT+IFF4rnawnb53u4vrk4XB2bVsn7nH1espPZcaE6YHG2waURr1kzdZm48bHSY6Murfiq0BVDv8w==
X-Received: by 2002:a05:6512:3f08:b0:4fb:7626:31a8 with SMTP id y8-20020a0565123f0800b004fb762631a8mr2430283lfa.27.1692372234600;
        Fri, 18 Aug 2023 08:23:54 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004fe4d122a66sm383715lfh.187.2023.08.18.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:23:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 18 Aug 2023 17:23:28 +0200
Subject: [PATCH 5/5] arm64: dts: qcom: Add Sony Xperia 10 V (PDX235)
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-topic-10v-v1-5-dbb6464223c6@linaro.org>
References: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
In-Reply-To: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692372226; l=3712;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Z35ZpUbsrhhBdyuWtuCpz49GDxm3TdMr+tz0YwDoIqY=;
 b=bTRX/Ls1me+ATmFgcrzQ918R7yguBLKDzXbR/R+jEKiQxFn89aa3Fu9LPRsW2jNwQmyj+27Ey
 d9EClFPwV2qBFYmclPhLXPRDpu/YyQI3hqKBGzVKIOBR7hdDEF9hE0J
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10 V is a carbon copy of the 10 IV, sans:

- camera setup (V obviously has a new, better one)
- the phone's body and SIM/sdcard tray changed a bit
- SM5038 is gone, PMIC QGauge is used for battery monitoring
- some wires may be routed differently (e.g. i2c devices are routed to
  different hosts)
- possibly some small other differences that we're about to discover

Introduce support for PDX235, currently requiring zero changes other
than adding msm-id and board-id, which seems to be the result of Sony
(or their chinese ODM) fusing in a non-zero value in there..

All of the flashing and prepwork shenanigans described in
Commit 4420e60416cb ("arm64: dts: qcom: Add device tree for Sony Xperia
10 IV") are also necessary on this device :/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../dts/qcom/sm6375-sony-xperia-murray-pdx235.dts  | 54 ++++++++++++++++++++++
 .../boot/dts/qcom/sm6375-sony-xperia-murray.dtsi   |  2 +-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2cca20563a1d..832b4acb20dd 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -196,6 +196,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx235.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx235.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx235.dts
new file mode 100644
index 000000000000..80a61961e5c5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx235.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Konrad Dybcio <konrad.dybcio@linaro.org>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/arm/qcom,ids.h>
+
+#include "sm6375-sony-xperia-murray.dtsi"
+
+/ {
+	model = "Sony Xperia 10 V";
+	compatible = "sony,pdx235", "qcom,sm6375";
+	chassis-type = "handset";
+	qcom,msm-id = <QCOM_ID_SM6375 0x10000>;
+	qcom,board-id = <QCOM_BOARD_ID(QRD, 0x1, 0x0) 0x0>;
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c7;
+		i2c2 = &i2c10;
+		i2c3 = &i2c8;
+	};
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* NXP SN2x0 NFC @ 28. (or on &spi2.. TBD!) */
+};
+
+&i2c7 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Awinic AW882xx audio amplifier ("channel 0") @ 34 */
+};
+
+/* I2C8 inherited from common DTSI */
+
+&i2c10 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Awinic AW882xx audio amplifier ("channel 1") @ 34 */
+	/* PM8008 @ 8, 9 */
+};
+
+/* For reasons yet unknown, it's broken on the mark V.. */
+&touchscreen {
+	status = "fail";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi
index 072f7ce2a7f6..243e60d9bbb5 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi
@@ -123,7 +123,7 @@ &i2c8 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	touchscreen@48 {
+	touchscreen: touchscreen@48 {
 		compatible = "samsung,s6sy761";
 		reg = <0x48>;
 		interrupt-parent = <&tlmm>;

-- 
2.41.0

