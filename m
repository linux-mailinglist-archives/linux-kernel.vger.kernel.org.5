Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDED757AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGRLkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGRLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:40:49 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8961A10F1;
        Tue, 18 Jul 2023 04:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689680437; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CxRkUiuk1qoWsNI605971zn6aOa83fSLJnlK9x04FMmEzxkOI6PDfjqZpC70o9MMPe
    3qXuQ+zA+v1vOSFwUu8fU1MLTGZiwCB15Ng5R2rYeyeujxesxaBecGf8r8PXBM9uuYas
    DRrCC+VjB3qgbyRoUnoJlvB51rqk5GzlYNeZSXWUKF9/klWN2YJyVpZonAw2v16IScbd
    6He6pLBWu9GOhw8XuSS2coqDCsU81I0jAFWex/QJZqeELvFuu3LkgNkrQgbuNhJAaurT
    wQ5neJSJSmze309rDJYLt41M5Ngkbl9lEg/2OPxwkBnNvASz6NcoMS4S5+iRypKlWXCm
    Ix3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=41FgpaaFBB/EYR10zVy+xYoyinNOFdObIZ1G8lDObro=;
    b=Ljj59MTlXUpSptntIk7qgpGtJ9/wJz8TXuiMlebtWYdC2GqRktkRoHloriUUcCcKTG
    RyP3ioano8sUHKMlSSYGYTOAdooBblntcogf31wAOmQPV4UjpEQA3IpiMqQnwr+qYKev
    QjkZC64H8uonCOQr6b7K9folS57sOreT8bi/mPv5kQ+KkPbc/BIH/5Vvn+ubMIC6J3Rn
    G1S9imK8bPQnlDnMIRoyLuQ/555amVuC3F4KJOMaXjs5oaNONEyJQAxxZ3plq93s4XiC
    MkhWWadfPq6GHsF76ym+yUqeGXJH/sYUrZiD/nAA/1/vR1Bfsq6s4+6rFw7Xd4rnBztf
    DrWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=41FgpaaFBB/EYR10zVy+xYoyinNOFdObIZ1G8lDObro=;
    b=b/WA35M2/fd2FL4jEfTcUtLMFQmh9MtQhRnsBew/TPHMvktpS7yAqcL61kG1Ej/5O0
    54avBcpxuamOYhqrWv0lmp2RNMeFrmR3IURN19qi/o8VXNHHfCa9hiuhzn6TykbAJz0o
    jQ0mg724wnDdNzWPiAiQgHPK3trOul7AZbjHo01oTJ1AYwtgycwdIA+ZLt4OMgDzj0dz
    8UcChvECGj+FgBvHvYdoUfvN80rscMg1DHpUzx7QuCOs5wBGFc5LYpbLEo6VkQEDS5n2
    qQFDcxDVUUsmBQWmwu5BV01DdjUpNj9HPS8w+bodT+bRP+hrLmMwD13CmVNz8CJiXfps
    bKsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=41FgpaaFBB/EYR10zVy+xYoyinNOFdObIZ1G8lDObro=;
    b=DevACCK470s9gV9DOy2GyX8xBNUP/mcmqr+oh+6bVh2dcA2ylyS/kNdJHoFqJxia+u
    PviK5ps8vPvMzLWOKADg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u45/mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IBebbpJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Jul 2023 13:40:37 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 18 Jul 2023 13:40:13 +0200
Subject: [PATCH 1/6] ASoC: dt-bindings: pm8916-analog-codec: Fix misleading
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-pm8916-mclk-v1-1-4b4a58b4240a@gerhold.net>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
In-Reply-To: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPMI devices typically have a single address cell and no size cell,
i.e. reg = <0xf000> for the audio codec instead of reg = <0xf000 0x200>.

The example is a bit misleading because it uses the latter. Copying
this into the device tree would be incorrect and was fixed before for
pm8916.dtsi in commit c2f0cbb57dba ("arm64: dts: qcom: pm8916: Remove
invalid reg size from wcd_codec").

Make the example more clear by adding the outer "pmic" node which
specifies the same #address/size-cells that would be used in the
real deivce tree.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../sound/qcom,pm8916-wcd-analog-codec.yaml        | 92 ++++++++++++----------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
index c385028c4296..77e3cfba4746 100644
--- a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
@@ -115,46 +115,54 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-msm8916.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-
-    audio-codec@f000{
-      compatible = "qcom,pm8916-wcd-analog-codec";
-      reg = <0xf000 0x200>;
-      reg-names = "pmic-codec-core";
-      clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-      clock-names = "mclk";
-      qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
-      qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
-      interrupt-parent = <&spmi_bus>;
-      interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
-            <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
-            <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
-      interrupt-names = "cdc_spk_cnp_int",
-                        "cdc_spk_clip_int",
-                        "cdc_spk_ocp_int",
-                        "mbhc_ins_rem_det1",
-                        "mbhc_but_rel_det",
-                        "mbhc_but_press_det",
-                        "mbhc_ins_rem_det",
-                        "mbhc_switch_int",
-                        "cdc_ear_ocp_int",
-                        "cdc_hphr_ocp_int",
-                        "cdc_hphl_ocp_det",
-                        "cdc_ear_cnp_int",
-                        "cdc_hphr_cnp_int",
-                        "cdc_hphl_cnp_int";
-      vdd-cdc-io-supply = <&pm8916_l5>;
-      vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
-      vdd-micbias-supply = <&pm8916_l13>;
-      #sound-dai-cells = <1>;
+    #include <dt-bindings/spmi/spmi.h>
+
+    pmic@1 {
+      compatible = "qcom,pm8916", "qcom,spmi-pmic";
+      reg = <0x1 SPMI_USID>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      audio-codec@f000 {
+        compatible = "qcom,pm8916-wcd-analog-codec";
+        reg = <0xf000>;
+        reg-names = "pmic-codec-core";
+        clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+        clock-names = "mclk";
+        qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+        qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+        interrupt-parent = <&spmi_bus>;
+        interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
+              <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
+              <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
+        interrupt-names = "cdc_spk_cnp_int",
+                          "cdc_spk_clip_int",
+                          "cdc_spk_ocp_int",
+                          "mbhc_ins_rem_det1",
+                          "mbhc_but_rel_det",
+                          "mbhc_but_press_det",
+                          "mbhc_ins_rem_det",
+                          "mbhc_switch_int",
+                          "cdc_ear_ocp_int",
+                          "cdc_hphr_ocp_int",
+                          "cdc_hphl_ocp_det",
+                          "cdc_ear_cnp_int",
+                          "cdc_hphr_cnp_int",
+                          "cdc_hphl_cnp_int";
+        vdd-cdc-io-supply = <&pm8916_l5>;
+        vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+        vdd-micbias-supply = <&pm8916_l13>;
+        #sound-dai-cells = <1>;
+      };
     };

-- 
2.41.0

