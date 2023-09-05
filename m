Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622A3792758
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjIEQD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354317AbjIEKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:41:34 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B376B1B6;
        Tue,  5 Sep 2023 03:41:30 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id A9D2E42435;
        Tue,  5 Sep 2023 15:41:27 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693910488; bh=5Mic3gNnqOTFzu14E8NR8/OpHSVXkykG/cgWNUdKaw8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=s7wB6NCL3RZjwbiCisJyZ/QIjry3x0tKsHpyF+tJnd7si1zT4HSaXkiKjpVMTk05m
         de8knKUnzuUs1WxP2O36oJk0WqVCjHP/KC53gm4XWNS7BSGTT8Xwdr5YSV9NrDchDd
         23laBjHNSAthKIPRhNanaZ4m6NaRN9/JHMsrcw92fJuGG26wC7nPXJ7Rjqgw4kyknU
         LrdejzaW2byxqGwig/cmxBfD0KJMDn12xyWXCnIJZjKrL469RNrIhPmymj9hgJ0Yno
         DdzBfeVpzbZf9ajNTTqvKmZ+mClSCGGnQl14DJUpWtpHmKrMKCBm4gznHmdq/iCZSh
         6dvD9DY6J1xzA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Sep 2023 15:41:07 +0500
Subject: [PATCH v2 4/4] arm64: dts: qcom: sc7180: Add ADSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-sc7180-adsp-rproc-v2-4-8ab7f299600a@trvn.ru>
References: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
In-Reply-To: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4331; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=5Mic3gNnqOTFzu14E8NR8/OpHSVXkykG/cgWNUdKaw8=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9wXTXjtBs1SiekyJhoXzzqVXZlv2oJwck52U/
 Ja49pfBrr2JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPcF0wAKCRBDHOzuKBm/
 dU+/D/9HkUq1DPOWHsIeVXgw9BJdDz2Rne+0+p9YFrCxY67TAYimr2fU1QTcm7He93ZHdDdwbxu
 /72zLwdrogKVxSLI0DMuLXP/s4UisOrO7692baVtkNEFzACaAgWDIhlfF4lnTTNg5WZOoPFqU3k
 FdWDRhF7X9pAomgRg2Ghx+hmNaRXwFgk9TlGlg9X1kD671BCZs1EvIcM0q38bBU3r2KJdwiNcoY
 QW41iz27MYw698MGOOR4gtet4VYyr1uqBAlrLPkFGZmPuVNMhATLCPSImOvZUpxzy2oekpW1F+5
 mmnfRdtqUB88fXndYLDJHinAPy/Ggjmtl5wGTq6xuX36zTbaFM3zQboe2IWfJ3v5Rlqz0qRNEND
 RdOp7CDV9i2G/xLVmA/cMlIbzJqSnJkLTrZpBejOUlXgo5xfPrD+qkJftI+AtmwkUPLAVbH6WJR
 iFvQ/NcvAdSgAW9vqgaxp1ycmUDSiG/cewMH4aBz8jDtldQLPc9CepmSBFPLYufH6bWPre2M2uI
 12H0VO/qU4hGOqyEig3p+5GcLRbhIvod6bnIGNyIapGqyq26L4XbXzt7eEltSspVJu439D2DVJ8
 LUBuyS7KMHH0wd7WQEZAh7+EP+os5aJwEKeWD1vn6mMwaoOKQEN0nqdTQryPNfm5V+YfFyoFyoi
 3PG9uGgZReB2rpw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7180 has an ADSP remoteproc that exclusively controls the audio
hardware on devices that use Qualcomm firmware.

Add it along with the relevant audio services.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
v2: rename service nodes according to the schema, reorder properties
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 122 +++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 9f68b5ff0030..174e7e18bb4d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -20,6 +20,8 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3781,6 +3783,126 @@ wifi: wifi@18800000 {
 			status = "disabled";
 		};
 
+		remoteproc_adsp: remoteproc@62400000 {
+			compatible = "qcom,sc7180-adsp-pas";
+			reg = <0 0x62400000 0 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SC7180_LCX>,
+					<&rpmhpd SC7180_LMX>;
+			power-domain-names = "lcx", "lmx";
+
+			qcom,qmp = <&aoss_qmp>;
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+				label = "lpass";
+				qcom,remote-pid = <2>;
+				mboxes = <&apss_shared 8>;
+
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					qcom,apr-domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					service@3 {
+						compatible = "qcom,q6core";
+						reg = <APR_SVC_ADSP_CORE>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+
+						q6afecc: cc {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&apps_smmu 0x1001 0x0>;
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1003 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1004 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1005 0x0>;
+						qcom,nsessions = <5>;
+					};
+				};
+			};
+		};
+
 		lpasscc: clock-controller@62d00000 {
 			compatible = "qcom,sc7180-lpasscorecc";
 			reg = <0 0x62d00000 0 0x50000>,

-- 
2.41.0

