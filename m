Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED15797AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbjIGRsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245660AbjIGRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:48:00 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F1A1FFC;
        Thu,  7 Sep 2023 10:47:40 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id DC57B4245A;
        Thu,  7 Sep 2023 15:03:09 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694080990; bh=StFemIF/2ACZvZh/Pxi85yeBz6CK2ME+JWLfl5kUCzw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=f30AMxqbk0xdk+4TMKvlx5bJI2pcI93dY8gIwoTAdmuKrWOEPpCM3CngiMIIKVEJK
         8mObrrMSKoMUr9kdiNJbQFijLj0qziTT5EIVYmOVYjN55NGOy4jycWx+1p7tuLSfbN
         1oc+3SYWs3tlRpOGow2zT9UR+mTh47PPfLP+5uM2UxhGV0GaXHgvuvK3mf8pBzZwuB
         Esy0UEmH15dAzSwRL1IwoNBGXvf+RFA7U4oDUv0F4pfs3e/utQUXL14fF41J6JXs8i
         71I6uMOMRgEAgXV5R8MyvXoRJBc49kzLbcTmRnQ2b3IXpoQapDl+1Ka8GliaUwEp/I
         YBZWvHVnxRwVg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Thu, 07 Sep 2023 15:02:37 +0500
Subject: [PATCH v3 4/4] arm64: dts: qcom: sc7180: Add ADSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-sc7180-adsp-rproc-v3-4-6515c3fbe0a3@trvn.ru>
References: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
In-Reply-To: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4341; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=StFemIF/2ACZvZh/Pxi85yeBz6CK2ME+JWLfl5kUCzw=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk+Z/XXACb1HQKlfdqcudVWbdURrRzfhFbQvUWq
 VfnEkqxIfqJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPmf1wAKCRBDHOzuKBm/
 dbkMD/4hGWIxQrkM2fnC2ef1yMyx8LWMltMVgtwmULrymGHd76pRuIH1Ecra8sCFayqiV/Q5mFk
 /9XIxv/RMMlwtVuLD82MsAC+btLCWeELNhTyDMj2wD2nC4aab/sHGbLv3mwCw0rtGnN7ehB4aq5
 kzsgVMNBweT6ese3thUdNwSw9NPmbgnVkWDeGNMyj8AtNzl17697FYotkjS27CBcSp5Z34zFXEM
 HeRxrB9Fu/1TH66SPNvx8njJ9mWn2iDQ3oi4Ze5A6quXmJq+18nrkgj/yv99jR6eAclXDtF2n70
 eBF5iXoAPI95b9qDZH4Y6l3oRI5vZ4FihMlg2B/dfhpf3bRaJMyPv0RmK2q8nLAoWdYMGHKvozE
 dYBUCYh3TfB3VOC/rlz9wBfSQsqRjih6OKU5DLZAZq/xNh+GmlKv4GaLWXunet6tdoHBh2bQ1En
 JkNrUlQwNIwOihxpifpGU5VJ1VIIj+llSyrIyos3SSUKJwg6OrpM/zsAs/ahC5egRivDuiChV48
 Qta3QA6XRrHxMOyzuLFmnAtW0iT9FDAOlUk8B9G4QuaDfpwDY3k3BvkeyNHQ5e8lUlSUvOa7a4C
 6gF8pdoY6TYQKjMLknZsfRM86d+rSgtyKRnThmYTANqI7oI6w+Wi+I7MjmMO3KKs2UblsWwh8Te
 qQ3xsLEZMhRxT5Q==
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
index 322fa478515f..eca1c34d2306 100644
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
+					qcom,domain = <APR_DOMAIN_ADSP>;
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
+						q6afecc: clock-controller {
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

