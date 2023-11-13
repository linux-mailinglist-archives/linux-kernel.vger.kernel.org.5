Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088297E9862
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjKMI4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjKMI4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84621701
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso629920066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865786; x=1700470586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/hNm4O9kcVsvOqtUmdrdc/s5ca+FA6jP0qMvQxdFYY=;
        b=Yq+xSWfh0Mky7/oPSXdYDHkxhQft7aCWa2ARVtJcPOc0PkzfTJCNT1UxeES0DdAiBw
         rQw5LT9RfB0EKafwgtaF7roKMPb5MuFohpLAS261R8F8cDunZcMpPEWoulwUqWiCsYm4
         EuZrzeukcDrqJNpvwxVwb3OqMyIEi6QuhO4Yu4KwcntYEpJHTaS/A8u5PeKkIzTgt9hQ
         3UrMBelWR8AlPvhOBBFLOdtHEL82rFob9CWwSmJMeYFIL/CdXiFyz6PmS5nqTQpM8R5d
         2PPgH2/OhI4eB5ZJqpQCyJnJIpFO2LiTKIksH41FgH+O2d5nHbyDdZi/C4NkgQ/onpiP
         Q62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865786; x=1700470586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/hNm4O9kcVsvOqtUmdrdc/s5ca+FA6jP0qMvQxdFYY=;
        b=J6pC92PEXIFPHQN4GkerGYLdxboxT2yffgXCsuRizTswZ5j1uGu71sk9+roQqFlmmU
         q8qXX7p1/KMmNuz/f677J1Z5b4wW4I7OHPuLZDBGrYbe/8/nEnUiXKzq64Z0jJlsph+B
         PkiZptTFUV+0m0m1Mts0OhMX2EZ0Axkj0TF8FgOdW3BC3kjqLRAt65VmmUZhh3E9KgXn
         Jz0mJOH8CsEbu3C7KFpI59H1lA2gDvmQ0u3DjvaTuR56TZ+OlSovwHxBP1hintiDJqvb
         CFCikqERVykxFdxPbzIMzYkceNQ+OLxSGR5IEfuVHc9NDw7YiBSt+ak1t5+k3gynJRlq
         Zgow==
X-Gm-Message-State: AOJu0Yz2IY9wkG1HWWBUUpDWY2L9BRDdrzvHrM4HDP97WMoOiHFBftku
        itNPBd2PnzfJjKHsOr2aXKX4Bw==
X-Google-Smtp-Source: AGHT+IHokc2IGjiccAW8Etk8Ejn4Otdsg5e1wKFTt0MuaHU7H32lrJAywc+4Egxj6Qj29749qjsPlQ==
X-Received: by 2002:a17:907:6d07:b0:9e8:de5e:911a with SMTP id sa7-20020a1709076d0700b009e8de5e911amr2802953ejc.73.1699865786243;
        Mon, 13 Nov 2023 00:56:26 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:25 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Nov 2023 09:56:15 +0100
Subject: [PATCH v2 04/11] arm64: dts: qcom: sc7280*: move MPSS and WPSS
 memory to dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-sc7280-remoteprocs-v2-4-e5c5fd5268a7@fairphone.com>
References: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that all SC7280-based devices so far have mpss_mem and
wpss_mem on the same reg with the same size.

Also these memory regions are referenced already in sc7280.dtsi so
that's where they should also be defined.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts      | 10 ----------
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi      |  5 -----
 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi  |  5 -----
 arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi |  1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi                    | 10 ++++++++++
 5 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index cc092735ce17..cb78b03bd831 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -85,16 +85,6 @@ cdsp_mem: cdsp@88f00000 {
 			no-map;
 		};
 
-		mpss_mem: mpss@8b800000 {
-			reg = <0x0 0x8b800000 0x0 0xf600000>;
-			no-map;
-		};
-
-		wpss_mem: wpss@9ae00000 {
-			reg = <0x0 0x9ae00000 0x0 0x1900000>;
-			no-map;
-		};
-
 		rmtfs_mem: memory@f8500000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0xf8500000 0x0 0x600000>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index cd491e46666d..69e30d539dc6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -38,11 +38,6 @@ venus_mem: memory@8b200000 {
 			reg = <0x0 0x8b200000 0x0 0x500000>;
 			no-map;
 		};
-
-		wpss_mem: memory@9ae00000 {
-			reg = <0x0 0x9ae00000 0x0 0x1900000>;
-			no-map;
-		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index 203274c10532..b721a8546800 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -8,11 +8,6 @@
 
 / {
 	reserved-memory {
-		mpss_mem: memory@8b800000 {
-			reg = <0x0 0x8b800000 0x0 0xf600000>;
-			no-map;
-		};
-
 		mba_mem: memory@9c700000 {
 			reg = <0x0 0x9c700000 0x0 0x200000>;
 			no-map;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
index 2febd6126d4c..3ebc915f0dc2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
@@ -7,5 +7,6 @@
 
 /* WIFI SKUs save 256M by not having modem/mba/rmtfs memory regions defined. */
 
+/delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &rmtfs_mem;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 7bfe93713eb6..e41200bd7bed 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -152,6 +152,16 @@ ipa_fw_mem: ipa-fw@8b700000 {
 			no-map;
 		};
 
+		mpss_mem: mpss@8b800000 {
+			reg = <0x0 0x8b800000 0x0 0xf600000>;
+			no-map;
+		};
+
+		wpss_mem: wpss@9ae00000 {
+			reg = <0x0 0x9ae00000 0x0 0x1900000>;
+			no-map;
+		};
+
 		rmtfs_mem: rmtfs@9c900000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0x9c900000 0x0 0x280000>;

-- 
2.42.1

