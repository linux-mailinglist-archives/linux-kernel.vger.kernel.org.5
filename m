Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4179272C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbjIEQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352453AbjIEFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:48:23 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D29812E;
        Mon,  4 Sep 2023 22:48:19 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id ECA5742444;
        Tue,  5 Sep 2023 10:48:11 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693892892; bh=wAuaJLhjPcRFdx6t9Gz0AhRtHiLNO8hfsMHaHITa5So=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YVElSKZjLW727lxP8uVtwgKmze3bpUkpnM1SCcAYY+5HZMeDnta7TgXVaha6rKdsJ
         DrCO4ZqV7rPu3qFpGIH8GJzwd37S7gcoFUOFMTsY9vxs5G+rgEEN2qRpnVfBpksBPe
         Axtxu1IGY7Tqn9yX/Np7JJADklr6dTwa7/r9nELknwfJ39yzAXddYvtz5IxO0veKpN
         XlqYRb/1IvEp+5WDJJ3cqH49CLHTOlxdTUNYa+dVboQtj3ZuuzDRUEyMjjZwpRUoEq
         f1ouxpkYjdJXEYMd8nLGruEReZkX4GmOYnuUW7jt/UmAhZK/Phy1sk/BPvhZoLLNSM
         iECXRjwIP6lKw==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Sep 2023 10:47:23 +0500
Subject: [PATCH 4/4] arm64: dts: qcom: sc7180: Add ADSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-sc7180-adsp-rproc-v1-4-dfea7699da7b@trvn.ru>
References: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
In-Reply-To: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4272; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=wAuaJLhjPcRFdx6t9Gz0AhRtHiLNO8hfsMHaHITa5So=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9sETu7ptQNZMsIhrHe2sebPNY5ZWc8nampQd1
 MqDNP0vwOqJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPbBEwAKCRBDHOzuKBm/
 dXgKD/sF0PRhjkDK5pa/Bq73qltDf6YNa4veyquiRzUDlIQbD8+mpocQUC1V8mrMk8b7WM99Jea
 SEB56pTz47IxmZRP2KTb0aPHws8ZWvtU2LiBam1HjUQJ/ZVcpd6qUdgUEURFtxErZsxOXNAyxZU
 pxYgBTLIPum0mQCCRX+jWYQYlUbj94E0uT5VKSPOpkBNOly5vFQnDbYnHgB8HevtQJcAg9tb48Z
 zxacix3nXaBtrZxOTy0bTfM0UoGgp31J0E9ObfO1FLTIydUWWEYq6M1qKgaRQ46gnkmnkDqPNwy
 N7i4XsR5zYmMz6bkiaXbqyefUEn4eGL0Tkr/OLSAwjfUMQMSxNwgQt389ztG/EOLnQC8SmKiaL5
 WtgvA269NyM9eSvzpdnA3icXZJlXDZZhoK44uB/tSm94Slr/JiA1MsHQheKYA/0zI06UVIEHNp/
 KI82iZEn9EOmIDht3gHpOVQO9E2WK4RQd+lmsdvt4GXEHqAeP03H7MNQJkspoiyavABi4vr5OHD
 la2Wq3rFmDnm9ZqcYs4U3xSFBh2JriUeXlyzE96Vd2ZVzttFT23n12FOSOUN1jb9cQdcJ/AqgXV
 lyVKn/OUyvBSwyfKNHAywpIfMc4WsJSlideTBPEugtNR56VUXPLpUWFse0AEyU/IzJZ11xL0Uvv
 AFwnMQSet4dFbXg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 122 +++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 9f68b5ff0030..30c58186900a 100644
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
+					apr-service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					};
+
+					q6afe: apr-service@4 {
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
+					q6asm: apr-service@7 {
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
+					q6adm: apr-service@8 {
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

