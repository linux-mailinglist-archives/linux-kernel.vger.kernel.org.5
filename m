Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D987C7FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjJMIKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJMIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:10:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B87CE8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:10:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9bda758748eso22307666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697184615; x=1697789415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jlv+KGmApZQb5ngFkmANnSdVyEJSRpRKLkkFinUp/fw=;
        b=xHvpy+3UUaAd16gpq8FGrYjYUqq4ushKYwSL8Gm54N+cGA97K8V/eB3/HlAXcXoXcC
         zvePbfQsW+94CkgIN5tJAYCruK0bnNHVTvQRaAD8+WxFQ+QiqilE1DyOLniFtvY4VBn6
         /+aRpaXMKP6lCaKQol1BlMrVCvihl9XYDQJA4/CqEn6vTIZrTf7OcPuG83KBzHqVRktN
         rixygb1US+5hij4OfXGrEs92lzP6OYn10gnw65jGrZyDkobxbdyTkGYzt6B3zdbyfE+A
         b1Iro7nYT5IcOdbiEO7PNkm8j916n1xHIZkWJPZRYBwryMIy2iTu6O19NMOBcjuE5Bpt
         R2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697184615; x=1697789415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jlv+KGmApZQb5ngFkmANnSdVyEJSRpRKLkkFinUp/fw=;
        b=Fb0JYw6SnUt4TuhNuWlZ5OszZRdc2txYdSEHCjH4KciCV3N3Sn0evmHq0n+aBYixsx
         1yni7fp7JrPg9rDMD7s4G8EBNG4LeyAOSXK1Ud/hhlOcmmJ0f/Yx9qiteZtpmMhZ7PS8
         0aFwGnZrb3UFQRlRm7fW+BbQ/TRaewKPghvz1zgD4vp1RJMIdyl97mH8pXqaIInxVla2
         Q3h3gcqt+wCdWUYriJ6IlWUI8DEK5MWnu4/KXc+iBA9foy2tR/kCzxymqAd2rkhT3mdQ
         MWX05NkNzI8qp5wG1kX7X9DS4ge1MUiYmkxTy1+FVdiwey1kNDCH1Gh7NXIMUmmPCp6T
         /sKg==
X-Gm-Message-State: AOJu0YzBRWvT8Wnxr0yWg6Om86JqNzViJO5Ag01zAIfxdOaexu5dBIBp
        BfFCH0N1Z4FKUghrnJFzMa01dA==
X-Google-Smtp-Source: AGHT+IH6fKZ6Dd+Z/J7NrjhZ5tEemEPVoWu2xo8L6j2bj4m320D5czjSmYk6p9ksaCTKFydidoegew==
X-Received: by 2002:a17:906:31cc:b0:9b2:b2f8:85dc with SMTP id f12-20020a17090631cc00b009b2b2f885dcmr21672339ejf.34.1697184615263;
        Fri, 13 Oct 2023 01:10:15 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q14-20020a170906360e00b009a5f1d1564dsm11910761ejb.126.2023.10.13.01.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:10:15 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 13 Oct 2023 10:09:54 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7250B
 thermals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-fp5-thermals-v1-2-f14df01922e6@fairphone.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the thermals for the CHARGER_SKIN_THERM and USB_CONN_THERM
thermistors connected to PM7250B.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 2de0b8c26c35..7fe19b556e6a 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -134,6 +134,36 @@ afvdd_2p8: regulator-afvdd-2p8 {
 		enable-active-high;
 		vin-supply = <&vreg_bob>;
 	};
+
+	thermal-zones {
+		chg-skin-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm7250b_adc_tm 0>;
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
+		conn-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm7250b_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -425,6 +455,42 @@ &ipa {
 	status = "okay";
 };
 
+&pm7250b_adc {
+	channel@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "charger_skin_therm";
+	};
+
+	channel@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "conn_therm";
+	};
+};
+
+&pm7250b_adc_tm {
+	status = "okay";
+
+	charger-skin-therm@0 {
+		reg = <0>;
+		io-channels = <&pm7250b_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	conn-therm@1 {
+		reg = <1>;
+		io-channels = <&pm7250b_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &pm7325_gpios {
 	volume_down_default: volume-down-default-state {
 		pins = "gpio6";

-- 
2.42.0

