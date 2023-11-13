Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86C67E986A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjKMI5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjKMI4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:41 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD810CF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:32 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9df8d0c2505so847253566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865791; x=1700470591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTZ4Jv1zdCihXH8N7DKF5MknE/I83u0rI4dws1dftsM=;
        b=Bmn9WL+/Mm7B0Q5UdRZgXyXwp00f5pyQAb6K+/vCCRyE6c4Shi5/3+NV1zfd1Du+F1
         a7O9dhdN8lTZdgAz6vW7GJVC1036poyZ+hlNHgTib4TWsmQfv7Wfg0phCUAcaFjwxwH/
         MZ23PiRbBUnmM9qHQ5lA+jN5b4oMUN7+P2WFr9wbXreDA2u8T3sFEXkqLbMRV0F1FUaa
         PieTzXzD5Zw9kpYm6MNdZtYaoZBrGe50Uff0NqyeedZ4XOe8grt2YLdyuW3CcPIuKV8e
         CYuA34ph/lLW6zMo9aQlKmQ4DBIGcJ3PIFUoy8phT2CEiXJ+Kmk0UEv6axkdJ5neWuVG
         ASlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865791; x=1700470591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTZ4Jv1zdCihXH8N7DKF5MknE/I83u0rI4dws1dftsM=;
        b=pJ8trKUmUuaNJakHQBKlDR/X9O15qogxTflX0M4H1uiNnr5dJYyvn2nHyjSV1hNATY
         bfi8dtpVFeyDsxIYWK5fSA5yZiu3dyoNZCp42TXw4VUyzYV03reMAn2myBZJYPwA09RR
         ySFfso6fkOrrij4/7gOQ+lNQKpB44mmqM9kZ76+T+dFB3ZF5L8yVJeaybtqHDLobglT3
         yPiq65vdblLOSKBps/Cq7CYvvHJsJZqG9tu5HT+x1bU4RebFzHdppGhvw9Yz8T31tk3l
         0AQsgig+c2ltzc6fg5+7zIDtPhKvHMf970pH1NPjqVvrewY4O8Arndu5i6oe1X3cjsOy
         qoUA==
X-Gm-Message-State: AOJu0YxGNMmk6mLN07GLktJvTadHiuu9IPUJD2XvQm+77Km+PuBl9+Ia
        GJyLIvgC1U4W2vEdrJdEp8ZINg==
X-Google-Smtp-Source: AGHT+IFKyrrfrE3KVe/m+TupE0FuZYr86cdnYjqZ06CDcn1JVPFRKBIeld+mQx1mJeVr+gaZ3iroUQ==
X-Received: by 2002:a17:906:f215:b0:9e8:1ba0:18fb with SMTP id gt21-20020a170906f21500b009e81ba018fbmr4288808ejb.29.1699865790754;
        Mon, 13 Nov 2023 00:56:30 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:30 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Nov 2023 09:56:19 +0100
Subject: [PATCH v2 08/11] arm64: dts: qcom: sc7280: Add ADSP node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-sc7280-remoteprocs-v2-8-e5c5fd5268a7@fairphone.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the node for the ADSP found on the SC7280 SoC, using standard
Qualcomm firmware.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  5 --
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  5 --
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 74 ++++++++++++++++++++++
 3 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index cb78b03bd831..92be951fc0e4 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -75,11 +75,6 @@ cont_splash_mem: cont-splash@e1000000 {
 			no-map;
 		};
 
-		adsp_mem: adsp@86700000 {
-			reg = <0x0 0x86700000 0x0 0x2800000>;
-			no-map;
-		};
-
 		cdsp_mem: cdsp@88f00000 {
 			reg = <0x0 0x88f00000 0x0 0x1e00000>;
 			no-map;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 14511a69658c..9cbe0fe64420 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -24,11 +24,6 @@
 
 / {
 	reserved-memory {
-		adsp_mem: memory@86700000 {
-			reg = <0x0 0x86700000 0x0 0x2800000>;
-			no-map;
-		};
-
 		camera_mem: memory@8ad00000 {
 			reg = <0x0 0x8ad00000 0x0 0x500000>;
 			no-map;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8c21695646c6..2b11ccc9a6b8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -142,6 +142,11 @@ wlan_fw_mem: wlan-fw@80c00000 {
 			no-map;
 		};
 
+		adsp_mem: adsp@86700000 {
+			reg = <0x0 0x86700000 0x0 0x2800000>;
+			no-map;
+		};
+
 		video_mem: video@8b200000 {
 			reg = <0x0 0x8b200000 0x0 0x500000>;
 			no-map;
@@ -3588,6 +3593,75 @@ qspi: spi@88dc000 {
 			status = "disabled";
 		};
 
+		remoteproc_adsp: remoteproc@3700000 {
+			compatible = "qcom,sc7280-adsp-pas";
+			reg = <0 0x03700000 0 0x100>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SC7280_LCX>,
+					<&rpmhpd SC7280_LMX>;
+			power-domain-names = "lcx", "lmx";
+
+			memory-region = <&adsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+					qcom,non-secure-domain;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1803 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1804 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1805 0x0>;
+					};
+				};
+			};
+		};
+
 		remoteproc_wpss: remoteproc@8a00000 {
 			compatible = "qcom,sc7280-wpss-pas";
 			reg = <0 0x08a00000 0 0x10000>;

-- 
2.42.1

