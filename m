Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C357479B372
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378092AbjIKWaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243770AbjIKRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00955CF;
        Mon, 11 Sep 2023 10:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l5I2ENrYi6G07PG5/vyOfElCYpYYv4JP6NQpStcDR0AhkXYy0iXLbEQYVWFtj/dmlk
    LVuyQ0qenwY4GezmAxy8psGQy0/aaVkH40iYcoF5ZWo+niS9Ylw+JqDX6mcnpCYqYMlE
    sR2hmrC2DnncY+8hahU8wt5+JLbpKqa18pVAQ0KtGC9aYKHHkLw5XB33XEXK/ZllPAgn
    yPw6pLzvwYw6g9zdZZ5rff5gVFJIBYTuIh70/jsU7AK2pHjr/GuWdk5Z8ew+cj5CpdzZ
    VIUBqZ97hmmBf9ReSoSp25OR1/gIiqLJzZro71YKDeETN7Pe3p1coVzLRXeYLQxwHRL9
    pXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dW9YirrLJkurT02lSzzl3uY0O9p2Eb+8xKry61dJ4Wk=;
    b=kLnbAx2yY+5POTDRNdSBUcIoVFfmH6x6qyVjA2Q76M44gBOQculOObU+5Eq6OVfT8u
    3aK84s82bUg1hOZAYzCu01RFBF2N/VczAVj74uYuT9i6gwYjGJrccRvnGorDH69P97bW
    ZVWppxf+1ooxObi95XeO4fL+26bxn7LYyavZoLYhmqGVHcyaiz39fSg0wgwYe5EJCh/C
    ch3vpmynbtc+hnKffmdH/DB4dGs1tfyTeLRKNCsbnK5OknxKHXa6vivPArkRDEHmSf/p
    gTPNiJsO90s5pyk8cx7dENHFJ+S1a0jexuYQC+cfiCVYNOhrzHJzt/tiHnkA5jGfHbWk
    C4jA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dW9YirrLJkurT02lSzzl3uY0O9p2Eb+8xKry61dJ4Wk=;
    b=C7q7Z7FmmkzY9pZPeCQsiOasQpz9pYn7gtFZUDmb997x+JFXCkp2IAw7BZDHUCfxVk
    /Gd3x5qs6Jqz/0DY+DrKTDjbnu8QVgO5OMzqcfw51GU3GVlqDRlOvWyhg7dEcIt9xODO
    zUiUWWXKZYEU25+5+gpVFbPN7+p93ZD564duhH0s5W6gllOmLazKMvMGL9dZ4xJHitm9
    JBr7DAqz6Zww4g2g8mg3LIEBo41BEn2AhirDdrr2mcOSA82gFSHGYuAj15DIoU+NCTex
    Ne/lga1rSE8MUKYAhXpFCitOOTROyNbMV1aWYut08zqVXNK0a38b4GtI2FyXsjFL49OV
    zbfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dW9YirrLJkurT02lSzzl3uY0O9p2Eb+8xKry61dJ4Wk=;
    b=yYR7J5HQRuzYW5zy/wEoUz92ghM0g/paZpimiv8tsH+GYmY9ftm3k1xyV8fQcn22uL
    iNwbZRkuvKSODBTcscDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg2awM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:02 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:44 +0200
Subject: [PATCH 2/9] arm64: dts: qcom: msm8916/39: Disable GPU by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-2-b7089ec3e3a1@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
In-Reply-To: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8916/39 do not need signed GPU firmware so it is generally okay to
have it enabled by default. However, currently the GPU does not work
without also enabling MDSS and it's questionable if someone would
really need it without a display in practice.

For consistency let's follow newer SoCs and disable the GPU by default.
Enable it for all existing devices that already have &mdss enabled.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                      | 4 ++++
 arch/arm64/boot/dts/qcom/apq8039-t2.dts                       | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi    | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                         | 3 ++-
 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts | 4 ++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi                         | 3 ++-
 6 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index c13230217c3c..bd68f4793acd 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -230,6 +230,10 @@ &camss {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &lpass {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index 027d1da7e81d..f591d6e78d6e 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -131,6 +131,10 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &lpass {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 5f78004a24bd..15d2486cdb45 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -239,6 +239,10 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index f093ab83938d..0257cbbb4971 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1750,7 +1750,7 @@ cci_i2c0: i2c-bus@0 {
 			};
 		};
 
-		gpu@1c00000 {
+		gpu: gpu@1c00000 {
 			compatible = "qcom,adreno-306.0", "qcom,adreno";
 			reg = <0x01c00000 0x20000>;
 			reg-names = "kgsl_3d0_reg_memory";
@@ -1773,6 +1773,7 @@ gpu@1c00000 {
 			power-domains = <&gcc OXILI_GDSC>;
 			operating-points-v2 = <&gpu_opp_table>;
 			iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
+			status = "disabled";
 
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index 89b6aebba404..cb893345c44b 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -39,6 +39,10 @@ usb_id: usb-id {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 6e24f0f2374f..b0a64e468629 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1395,7 +1395,7 @@ mdss_dsi1_phy: phy@1aa0300 {
 			};
 		};
 
-		gpu@1c00000 {
+		gpu: gpu@1c00000 {
 			compatible = "qcom,adreno-405.0", "qcom,adreno";
 			reg = <0x01c00000 0x10000>;
 			reg-names = "kgsl_3d0_reg_memory";
@@ -1418,6 +1418,7 @@ gpu@1c00000 {
 			power-domains = <&gcc OXILI_GDSC>;
 			operating-points-v2 = <&opp_table>;
 			iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
+			status = "disabled";
 
 			opp_table: opp-table {
 				compatible = "operating-points-v2";

-- 
2.42.0

