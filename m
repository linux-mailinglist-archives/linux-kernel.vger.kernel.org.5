Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200887806DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358427AbjHRIGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358466AbjHRIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:06:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB63A93
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:06:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-523b066d7ceso728596a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1692345974; x=1692950774;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eESbdi+sXASvn68iSJvLrBwEDy04NwSpznyg0rKKf8g=;
        b=VawtA6I1iqWJBWULkCg9sSVdDKGcNF3Ump/sKwPjdfdmMXYcxisAK79yo9p6pE3gYA
         9CgKiqBC/8BwL59rvKNxNG/qQirR6t/4AVq2Cs4LlrgB14lyMEZwKsil/kZg4EmXXwz9
         6QzH32kuQ3Swk5Tq0DFh9zHB8UuTA5QbFQJ+nIBxPv+wZu+08fJQfAZbuRXwNSQLfKYi
         2rHBJ+L3x/gpcL9YylPG8/fOCTOnMxGrgeZV/f7iDcSlaewzLS9LIRskmO754jLq1Oyi
         XJxo49ZpFGSLwK2fanmVgB6BKvpwKiDmkEhaRARKRdIvfqmnZ6V5D2kivTV8S/pyLkzy
         A0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345974; x=1692950774;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eESbdi+sXASvn68iSJvLrBwEDy04NwSpznyg0rKKf8g=;
        b=JptzFdvNBtcy87ooN4+w+OVNVWJ3l8julC30/BYuN/SGVyf2DT2KeH3OeyjCjflQc2
         J5SM0nXzKbm/GsVu5RJjE4b8DlBcdQ2aNjLHMSbSjPVihuPDzwG8imuWchT7icw2ROdK
         //V0ctpPAPbIzyQgOyG/Kwai3rZrs4Zt4il3GrbtxcLuAozAd46BbLbUM/cVAN2dG8jD
         L+wKNGl+17ZLGB9lC8ZfDwjfXm2MJeUpuLgpGfLzL2gqvjdI+vt0HfwLuxFmZSlWuoT4
         RKp7SK0YOY+UUU/tDuEJ/VoH8A56KWfhHGTCL0y2qDun18xMGzj7iQL2hpwop1jFDRwg
         NPlg==
X-Gm-Message-State: AOJu0Yxjahzg/3J7gTHc8euAEPsUtGYLPWDsSNK8R6j3X/YVmNHT0YT5
        qGdpZPamagqM0RfUPYmeNSmAVQ==
X-Google-Smtp-Source: AGHT+IG+h6Na9ThX7Y1u1EiAijpbLApeHPO9tNiwKvQ++IY07ofJXDbX7vIU3sJXRz4dUy/C/Ip4Ag==
X-Received: by 2002:aa7:df89:0:b0:523:b133:5c7e with SMTP id b9-20020aa7df89000000b00523b1335c7emr1535626edy.1.1692345974458;
        Fri, 18 Aug 2023 01:06:14 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (212095005021.public.telering.at. [212.95.5.21])
        by smtp.gmail.com with ESMTPSA id o15-20020aa7dd4f000000b0051dd19d6d6esm797416edw.73.2023.08.18.01.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:06:14 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 18 Aug 2023 10:06:09 +0200
Subject: [PATCH] arm64: dts: qcom: Use QCOM_SCM_VMID defines for qcom,vmid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-qcom-vmid-defines-v1-1-45b610c96b13@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAHAm32QC/x2MQQqAIBAAvxJ7bkEryvpKdBB3qz1opSBB9Pek4
 zDMPJA4CieYqgciZ0lyhAK6rsDtNmyMQoWhUU2rjDZ4ucNj9kJIvErghJacHsbO9aQ0lO6MRdz
 /c17e9wMRVmG2YwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have those defines available in a header, let's use them
everywhere where qcom,vmid property is used.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi          | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi                        | 3 ++-
 arch/arm64/boot/dts/qcom/msm8998.dtsi                        | 3 ++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi                         | 3 ++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi                         | 3 ++-
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts          | 3 ++-
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts                  | 3 ++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi                         | 3 ++-
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi          | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts            | 3 ++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi                         | 3 ++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi                         | 3 ++-
 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi                         | 3 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi                         | 3 ++-
 19 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index bcd2397eb373..baa7472b7a28 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -117,7 +117,7 @@ rmtfs@f6c00000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		/delete-node/ mba@91500000;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c8e0986425ab..6ba9da9e6a8b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/interconnect/qcom,msm8996.h>
 #include <dt-bindings/interconnect/qcom,msm8996-cbf.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,apr.h>
@@ -538,7 +539,7 @@ rmtfs_mem: rmtfs {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		mpss_mem: mpss@88800000 {
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f180047cacb0..aac23a8ef6c8 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,gpucc-msm8998.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8998.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/gpio/gpio.h>
 
@@ -56,7 +57,7 @@ rmtfs_mem: memory@88f00000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		spss_mem: memory@8ab00000 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a79c0f2e1879..d57418113b36 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,lpasscorecc-sc7180.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7180.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc7180.h>
@@ -687,7 +688,7 @@ rmtfs_mem: memory@94600000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 925428a5f6ae..042908048d09 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7280.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
@@ -156,7 +157,7 @@ rmtfs_mem: memory@9c900000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index abc66613ccaa..3ea07d094b60 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
@@ -130,7 +131,7 @@ rmtfs_mem: rmtfs-region@85500000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		wlan_mem: wlan-region@8bc00000 {
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index 834e6f9fb7c8..fd2fab4895b3 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
@@ -135,7 +136,7 @@ rmtfs_mem: rmtfs-region@85500000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		wlan_mem: wlan-region@8bc00000 {
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index ec6003212c4d..c17719086085 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,gpucc-sdm660.h>
 #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interconnect/qcom,sdm660.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -453,7 +454,7 @@ rmtfs_mem: memory@85e00000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		smem_region: smem-mem@86000000 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index f942c5afea9b..99dafc6716e7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -111,7 +111,7 @@ rmtfs_mem: memory@f0801000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		/* rmtfs upper guard */
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 122c7128dea9..b523b5fff702 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -90,7 +90,7 @@ rmtfs_mem: rmtfs-mem@f5b01000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 		rmtfs_upper_guard: rmtfs-upper-guard@f5d01000 {
 			no-map;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 9d6faeb65624..93b1582e807d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -111,7 +111,7 @@ rmtfs_mem: memory@f6301000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 6db12abaa88d..e386b504e978 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -108,7 +108,7 @@ rmtfs_mem: memory@f6301000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 055ca80c0075..eede4b18fb98 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -813,7 +813,7 @@ rmtfs_mem: rmtfs@88f00000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		qseecom_mem: qseecom@8ab00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 18171c5d8a38..136e273d09a7 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -8,6 +8,7 @@
 /* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0 */
 #define PMK8350_SID 6
 
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/input.h>
@@ -75,7 +76,7 @@ memory@efe01000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a7c3020a5de4..fd5c3139f4ce 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -720,7 +721,7 @@ rmtfs_mem: memory@89b00000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		camera_mem: memory@8b700000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 00604bf7724f..4989a3971c94 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,gpucc-sm8350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,sm8350.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -503,7 +504,7 @@ rmtfs_mem: memory@9b800000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		hyp_reserved_mem: memory@d0000000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 001fb2723fbb..8b29fcf483a3 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -80,7 +80,7 @@ rmtfs_mem: memory@f3300000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		ramoops@ffc00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2a60cf8bd891..09a0c35dd514 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,sm8450-dispcc.h>
 #include <dt-bindings/clock/qcom,sm8450-videocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
@@ -540,7 +541,7 @@ rmtfs_mem: memory@9fd00000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		xbl_sc_mem2: memory@a6e00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d115960bdeec..1a3bbd62e540 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
 #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
@@ -570,7 +571,7 @@ rmtfs_mem: rmtfs-region@d4a80000 {
 			no-map;
 
 			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 
 		mpss_dsm_mem: mpss-dsm-region@d4d00000 {

---
base-commit: 7271b2a530428b879443b274c191b34536a4ea11
change-id: 20230818-qcom-vmid-defines-adc1794c6d01

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

