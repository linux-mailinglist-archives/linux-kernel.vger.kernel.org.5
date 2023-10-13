Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3427C7FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjJMIKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjJMIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:10:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393CDFA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:10:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso3370859a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697184617; x=1697789417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT253bU1TN+2VYGYyTK7tnK4dl9BBDdqFWVEHyQXP0Q=;
        b=2nqsGwrRpvwg6YT0WPFGKfZl4mqK7tdOps0qTh8CCjsDTt1DJzlcUp1i28Ktc2oKnZ
         bKCwiIBekakHVfrgr6XaJIy4/3l6pYYTSOdaRh6vLgJSHUk03WSHsYmH4CmO4U7N75VF
         xWa+Rt3GqKoI0sLcpu2rvTRuB7L7OJRpNDnMVitQB4Fg8SghCOUKxnMOm5oLM4gzgMj9
         o2yjA7kNylHnfk35yAZXYJraIWlZbufXXWqvt7ol+gmAV71g4mvfQ7xDDqVK1GSM8ovj
         dz8r2BZbx/MeGkJQnxb4Cul4ZvSlSjDYQ0ycU4co/Ph3FVFv3e6eX5RhDn0DZEVaEFlz
         Uu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697184617; x=1697789417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT253bU1TN+2VYGYyTK7tnK4dl9BBDdqFWVEHyQXP0Q=;
        b=V3YYbY8x4aZnU9JzQKtT/ShxekWEaeEzzxg+Jp2y2VWHnGtVs6XRQfHKBoU3UetNIn
         ysZI92GQmCNTMDbW6mGS3722RI2oE6s8PB7SGEOBja33RjHGF+t64iEpz2dDJ9JYZaWt
         HKHS7CXoBGi8ZAb6cnfvw5Zj7qgQISb1TjYig7VNHQC3im4uFD1Miey5yGLMMfkGz2ww
         zk9tPh2x1sH0Zg8pHCr+HdA9ThoKGNUuoLN94DnSD8xRWw335p5APepDGpTeSKa0Fiy0
         tZH62DhUF2KYW+i1uTYfWdK410IDQZKZl//hI+vF3+OAzbCwW7IkCmtjuqc6PPy5bT3O
         bSGA==
X-Gm-Message-State: AOJu0YwXCIgpNMsrY/2Sl61mVfDjHOcGTbHabho5s0Y+E/QBKaCv4ZYb
        U2L3Rf7IgFqaXpA7Srf8YPKn+g==
X-Google-Smtp-Source: AGHT+IGPXVTWcKw9dwcC63fjjdOYNbEqaNkFCBQ0Y8FaQfhMMN2PFBzCRziai2IqwqfPGZjkOtmpKQ==
X-Received: by 2002:a17:907:75da:b0:9ad:cf30:10c with SMTP id jl26-20020a17090775da00b009adcf30010cmr25008658ejc.46.1697184616863;
        Fri, 13 Oct 2023 01:10:16 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q14-20020a170906360e00b009a5f1d1564dsm11910761ejb.126.2023.10.13.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:10:16 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 13 Oct 2023 10:09:56 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7325
 thermals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-fp5-thermals-v1-4-f14df01922e6@fairphone.com>
References: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
In-Reply-To: <20231013-fp5-thermals-v1-0-f14df01922e6@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
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

Configure the thermals for the QUIET_THERM, CAM_FLASH_THERM, MSM_THERM
and RFC_CAM_THERM thermistors connected to PM7325.

With this PMIC the software communication to the ADC is going through
PMK7325 (= PMK8350).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 2c01f799a6b2..d0b1e4e507ff 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -9,6 +9,7 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
+#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
@@ -137,6 +138,20 @@ afvdd_2p8: regulator-afvdd-2p8 {
 	};
 
 	thermal-zones {
+		camera-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
 		chg-skin-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
@@ -165,6 +180,48 @@ active-config0 {
 			};
 		};
 
+		quiet-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		rear-cam-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 4>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		sdm-skin-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 3>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
 		xo-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
@@ -538,6 +595,34 @@ xo-therm@0 {
 		qcom,ratiometric;
 		qcom,hw-settle-time-us = <200>;
 	};
+
+	quiet-therm@1 {
+		reg = <1>;
+		io-channels = <&pmk8350_vadc PM7325_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	cam-flash-therm@2 {
+		reg = <2>;
+		io-channels = <&pmk8350_vadc PM7325_ADC7_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	sdm-skin-therm@3 {
+		reg = <3>;
+		io-channels = <&pmk8350_vadc PM7325_ADC7_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	wide-rfc-therm@4 {
+		reg = <4>;
+		io-channels = <&pmk8350_vadc PM7325_ADC7_AMUX_THM4_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
 };
 
 &pmk8350_rtc {
@@ -554,6 +639,38 @@ channel@44 {
 		qcom,pre-scaling = <1 1>;
 		label = "pmk8350_xo_therm";
 	};
+
+	channel@144 {
+		reg = <PM7325_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm7325_quiet_therm";
+	};
+
+	channel@145 {
+		reg = <PM7325_ADC7_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm7325_cam_flash_therm";
+	};
+
+	channel@146 {
+		reg = <PM7325_ADC7_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm7325_sdm_skin_therm";
+	};
+
+	channel@147 {
+		reg = <PM7325_ADC7_AMUX_THM4_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm7325_wide_rfc_therm";
+	};
 };
 
 &pon_pwrkey {

-- 
2.42.0

