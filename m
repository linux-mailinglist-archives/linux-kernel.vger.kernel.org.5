Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FDA79B62C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350388AbjIKVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbjIKRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:17 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13104CE;
        Mon, 11 Sep 2023 10:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XOhVEomkO2KtspCvui5R+lw/tBgeDwWv6+/7mz8HQA8dMw2kM9V80s/quyucNrPcfI
    CszpN3VWMDys+SSGQ1RjGSJoNzrLlsiFImaQU//7Ja79LfH0QaxWP5vmpqGHPqKYf4+k
    pkM/Kya5ofPsXYZvlnHQosd+wHU9beRMPKQtDBVH8qKpkiD4i8jeU0Z0sxdLC/A1fUA9
    deBNm6dFKuBc5bXaLZs3+SY710A9tfzYOvDgYTJ14/2e6nrN9icqzy3+kx/CT8Q2kZXE
    pt6XZvF0cWU/RUTs6p57QGrTlB1R4RiiIYVL+lgxg4+MGYBXrSUMUruAHlGeKAlo40sN
    +h9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=4pQuP3sI5WLCQf048Q7dFj6HEPnKaK4qRToh3MKGbFY=;
    b=SCVv+zAEN8pskdSByR1Z0O8VLzyPZ3wn8180teqGstsveWX765wFcCGOP5UYA4z3u7
    bxvW9+2FxeiIBy0fvYeQH/7qMj2ckYTUIOffq1I1mOcQGvqVz93l/dd0TB7FFotkQ3xW
    TahLddEyWqzGPyLEzst+WJhg3Dwn6THrdhkQ3k7KFPjpEwvRSJhmhuU5VBYUK8AmVly+
    kIsGBPIRPkSqPC70q7Q2rsIP8g8Syz+s2opT9Wv/nFvam/ELwBkiqG2yh6oVljWArcxc
    a7zh8m3RNf5Rr7qRDWL4scVL5NcBY+l42oYd/rFHswtchHrOGYZN1KoCRyZxNLaxJwPH
    oPzg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=4pQuP3sI5WLCQf048Q7dFj6HEPnKaK4qRToh3MKGbFY=;
    b=ZjvACTKqtVouxsbATtaveTQZe4J7zWildWqlaIkQFpZh3Ks380FJqyVogC6ecsag1m
    EekChMCnHzvLKVD25tSViFGCkn0hCf00e7syc4CLlgSivZIJqfoF0fNpDmID4WYeH+3Y
    lGlps3DVjmXNrfgkDillzua3f/UYI57Dc8bMwxZzp+Wc9jOj19oASYtWkFLb3YU6n/cp
    VP9+itba10TJ6jfkPz/qZ4Bbt+3ejNN46bf2I5kfKGmoMkDHqGBjq/eVzZXM2I9AqDKh
    +SgHg/iac3mlCF5lsdfHJsmVcXMVnC+XrBWT+/Fb7Yl6YsgfrlOzmUXGlbOzhU4Sz/ho
    7C6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=4pQuP3sI5WLCQf048Q7dFj6HEPnKaK4qRToh3MKGbFY=;
    b=gdY7MP6yrDSXrpt/bqE472QkRexCIXb5fJyXA8GDisKSYYupdWP2xw0ElmdF4tu5s+
    S5kOx4XMrErFEkJHG1BQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg2awL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:02 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:43 +0200
Subject: [PATCH 1/9] arm64: dts: qcom: msm8916: Disable venus by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-1-b7089ec3e3a1@gerhold.net>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Venus needs firmware that is usually signed with a device-specific key.
There are also devices that might not need it (especially during
bring-up), so let's follow more recent SoCs and disable it by default.

Enable it explicitly for all current devices except msm8916-mtp. That
one has just UART enabled currently so it cannot really benefit from
Venus.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                   | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts           | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts       | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts             | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts         | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts             | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts       | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts       | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi   | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi    | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts     | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi                  | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts      | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                      | 2 +-
 15 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 4f5541e9be0e..c13230217c3c 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -364,6 +364,10 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 	firmware-name = "qcom/apq8016/wcnss.mbn";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index 84723c9b73b4..1d1af1260938 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -155,6 +155,10 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 47da738661bf..e130f19fdccf 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -192,6 +192,10 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index 92f695481769..6f38e765ed3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -160,6 +160,10 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 4aeeee24cedc..1d1113958625 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -150,6 +150,10 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 484e488a5eca..c46df67b4d10 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -328,6 +328,10 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 3892ad4f639a..a0bb8de54fb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -259,6 +259,10 @@ &usb_hs_phy {
 	extcon = <&pm8916_usbin>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index d73294af1a06..919677969b3e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -146,6 +146,10 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 019bf73178fa..5f78004a24bd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -284,6 +284,10 @@ &usb_hs_phy {
 	extcon = <&muic>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &tlmm {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 54d648972d35..06602db25e5f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -158,6 +158,10 @@ &usb_hs_phy {
 	extcon = <&pm8916_usbin>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index cb0e4a7faf91..9897089d2243 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -138,6 +138,10 @@ &usb_hs_phy {
 	extcon = <&muic>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index eaf877378937..286ba7bb2b5a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -359,6 +359,10 @@ &usb_hs_phy {
 	extcon = <&muic>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 004a129a2ee2..c759c0544dd9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -115,6 +115,10 @@ &usb_hs_phy {
 	extcon = <&pm8916_usbin>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 8e238976ab1c..82ed50610b24 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -189,6 +189,10 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 33fb65d73104..f093ab83938d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1797,7 +1797,7 @@ venus: video-codec@1d00000 {
 			clock-names = "core", "iface", "bus";
 			iommus = <&apps_iommu 5>;
 			memory-region = <&venus_mem>;
-			status = "okay";
+			status = "disabled";
 
 			video-decoder {
 				compatible = "venus-decoder";

-- 
2.42.0

