Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C079BE09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348997AbjIKVcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbjIKRmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:21 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E94CCC;
        Mon, 11 Sep 2023 10:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454124; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H6WN+5g2fon5HCZwh24XC8ppe5UUbXP710b1xt2gk9iyUF3LwUyFnhtOobLaGjFu3Y
    6Hryt2gIBBYP5FWKfUjj2vJnDwIYWNQniP07eFGxDDM9WXm0bxqG5wKf2EfAI2rdmGeE
    JY61u+IfwyshRtpQvAEhdZ351IIPf7X2xJGrqyQFPyXX6qBVYjFa+LEg6nedk1aQzO1A
    ZenCYwAI2DaeNhMN1KFqRu83TCeAORJOeTfeRYyI8GZeMCmXFJafUV5ZharFu2ZysHJn
    WcuGNBnvsIbVEmsIuh1QbzvgvIz1aWGwnGmy0csVhel8DDzbVstDnINWS94xO4qnmHjR
    +KwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454124;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=P4Dwi4/5beXuX8qW3vf++EWtOQ4RCdZB/xmssOAW4VY=;
    b=YJ2CjPlsUCWSnMhhk5zTwXgdibLX+HnxDvNzzyZP9wH5DYAyAnJkfr8WxLmSKCzu00
    lew4TLzEohsf9rReCrnbejkvXhSZhhponFkj21f64ywtgVelGkMXzA87ebxPJsPK6LNH
    fV4JQHzOvmG7iCmRYX7RHFa+dpKOninsiLn43QoyX+RC/lwCODkD69CWZ7K1z8yoJarR
    Jc9FPLSeCP5/muKpflnwCuP6fnYEpvu60W8KXZGVmsB2QG0WqgCCN1dPorE08S0nekev
    04de1pBOpjZazOpgDiELlselVycB3pEqlD/zWn1fGZ5QEIIWL4km3uJNyO+u/XXkEA0a
    nC0w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=P4Dwi4/5beXuX8qW3vf++EWtOQ4RCdZB/xmssOAW4VY=;
    b=IEgc4HOo3RLYrQx7nCqFo8OeccXfSiLDmLHV8McqgShvw69NreqFcJoxPVHMjfGc92
    H5hGQIYhWt791yyckCam5nzb8b+D/qpU9gupVeo/vu5LFhyEn3RZg03GEGxAmHuPe08E
    uOJCv8bQ8ik86R6+M3ClL4lDcN1fjVomL61daivgE3H1KHYxr4nG8wk80VpeavnGOQGg
    oVA2hhYp54egx3LIUID1zYWkV61GwU34CSg5sh6+p551GOcfIeUyfIbNkUqqw7ueV241
    ck39eoIPqXWwJUZgk7sYJhLsBOGPFFRHjxYutgoIuJwoiXVW0MIX3TxLjJvwJmlOEg4O
    MtLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=P4Dwi4/5beXuX8qW3vf++EWtOQ4RCdZB/xmssOAW4VY=;
    b=qHBRHblbRGcYCIWPPRfXBsq7ibyvJfRgH/ijVawDM8eInZymzqtTSHi0j54cmcKxrt
    SWD8e9DB96s19KtFcXAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg3awR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:03 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:49 +0200
Subject: [PATCH 7/9] arm64: dts: qcom: msm8916/39: Disable unneeded
 firmware reservations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-7-b7089ec3e3a1@gerhold.net>
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

Now that we no longer have fixed addresses for the firmware memory
regions, disable them by default and only enable them together with
the actual user in the board DT.

This frees up unnecessary reserved memory for boards that do not use
some of the remoteprocs and allows moving selected device-specific
properties (such as firmware size) to the board-specific DT part in
the next step.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                 | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8039-t2.dts                  |  4 ++++
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts         |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts     |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts           |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts       |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts           |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts     |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts     |  8 ++++++++
 .../boot/dts/qcom/msm8916-samsung-a2015-common.dtsi      |  4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts     |  4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts     |  4 ++++
 .../boot/dts/qcom/msm8916-samsung-e2015-common.dtsi      |  4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi  |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts   |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi                | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts    |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                    |  4 ++++
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts          |  4 ++++
 .../boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts   |  4 ++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi                    |  4 ++++
 22 files changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index bd68f4793acd..ae510c5ec830 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -242,6 +242,10 @@ &lpass_codec {
 	status = "okay";
 };
 
+&mba_mem {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
@@ -257,6 +261,10 @@ &mpss {
 	firmware-name = "qcom/apq8016/mba.mbn", "qcom/apq8016/modem.mbn";
 };
 
+&mpss_mem {
+	status = "okay";
+};
+
 &pm8916_codec {
 	status = "okay";
 	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
@@ -372,6 +380,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 	firmware-name = "qcom/apq8016/wcnss.mbn";
@@ -385,6 +397,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 /* Enable CoreSight */
 &cti0 { status = "okay"; };
 &cti1 { status = "okay"; };
diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index f591d6e78d6e..4f82bb668616 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -395,3 +395,7 @@ &wcnss {
 &wcnss_iris {
 	compatible = "qcom,wcn3680";
 };
+
+&wcnss_mem {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index 1d1af1260938..57a74eea1005 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -159,6 +159,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -167,6 +171,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index e130f19fdccf..aa4c1ab1e673 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -196,6 +196,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -204,6 +208,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio31";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index 6f38e765ed3c..a8be6ff66893 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -164,6 +164,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -172,6 +176,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107", "gpio117";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 1d1113958625..b748d140b52e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -154,6 +154,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -162,6 +166,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	camera_flash_default: camera-flash-default-state {
 		pins = "gpio31", "gpio32";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index c46df67b4d10..bf7fc89dd106 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -332,6 +332,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -340,6 +344,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	accel_irq_default: accel-irq-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 503155aefa55..47d1c5cb13f4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -268,6 +268,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -276,6 +280,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio116";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 919677969b3e..41cadb906b98 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -150,6 +150,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -158,6 +162,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	button_backlight_default: button-backlight-default-state {
 		pins = "gpio17";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 15d2486cdb45..0b29132b74e1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -292,6 +292,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &tlmm {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index e5a569698c4f..f5a808369518 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -120,6 +120,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	panel_vdd3_default: panel-vdd3-default-state {
 		pins = "gpio9";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
index 388482a1e3d9..391befa22bb4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
@@ -71,6 +71,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3660b";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	tkey_en_default: tkey-en-default-state {
 		pins = "gpio97";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 6f65fd4b3ed3..0824ab041d80 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -83,6 +83,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	tkey_en_default: tkey-en-default-state {
 		pins = "gpio97";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 06602db25e5f..c19cf20d7427 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -162,6 +162,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -170,6 +174,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3660b";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 9897089d2243..62692d2c32d5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -142,6 +142,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -150,6 +154,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 		pins = "gpio52";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 286ba7bb2b5a..68da2a2d3077 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -363,6 +363,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -371,6 +375,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3660b";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	fg_alert_default: fg-alert-default-state {
 		pins = "gpio121";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 1d92c2e57216..c77ed04bb6c3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -80,12 +80,17 @@ &gcc {
 	clocks = <&xo_board>, <&sleep_clk>, <0>, <0>, <0>, <0>, <0>;
 };
 
+&mba_mem {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 };
 
 &mpss_mem {
 	reg = <0x0 0x86800000 0x0 0x5500000>;
+	status = "okay";
 };
 
 &pm8916_usbin {
@@ -111,6 +116,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -119,6 +128,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	/* pins are board-specific */
 	button_default: button-default-state {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 82ed50610b24..419f35c1fc92 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -193,6 +193,10 @@ &venus {
 	status = "okay";
 };
 
+&venus_mem {
+	status = "okay";
+};
+
 &wcnss {
 	status = "okay";
 };
@@ -201,6 +205,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	camera_flash_default: camera-flash-default-state {
 		pins = "gpio31", "gpio32";
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 38f6c8ea605a..8457472c9ad8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -86,6 +86,7 @@ mpss_mem: mpss@86800000 {
 			 */
 			reg = <0x0 0x86800000 0x0 0x2b00000>;
 			no-map;
+			status = "disabled";
 		};
 
 		wcnss_mem: wcnss {
@@ -93,6 +94,7 @@ wcnss_mem: wcnss {
 			alignment = <0x0 0x100000>;
 			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
+			status = "disabled";
 		};
 
 		venus_mem: venus {
@@ -100,6 +102,7 @@ venus_mem: venus {
 			alignment = <0x0 0x100000>;
 			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
+			status = "disabled";
 		};
 
 		mba_mem: mba {
@@ -107,6 +110,7 @@ mba_mem: mba {
 			alignment = <0x0 0x100000>;
 			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
index ba652909d162..fccd8fec8b8f 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -352,6 +352,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3660b";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index cb893345c44b..eeb4d578c6fa 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -91,3 +91,7 @@ &wcnss {
 &wcnss_iris {
 	compatible = "qcom,wcn3660";
 };
+
+&wcnss_mem {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index ebea6de1177b..c50f6d828fed 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -358,6 +358,7 @@ mpss_mem: mpss@86800000 {
 			 */
 			reg = <0x0 0x86800000 0x0 0x5500000>;
 			no-map;
+			status = "disabled";
 		};
 
 		wcnss_mem: wcnss {
@@ -365,6 +366,7 @@ wcnss_mem: wcnss {
 			alignment = <0x0 0x100000>;
 			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
+			status = "disabled";
 		};
 
 		venus_mem: venus {
@@ -372,6 +374,7 @@ venus_mem: venus {
 			alignment = <0x0 0x100000>;
 			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
+			status = "disabled";
 		};
 
 		mba_mem: mba {
@@ -379,6 +382,7 @@ mba_mem: mba {
 			alignment = <0x0 0x100000>;
 			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
+			status = "disabled";
 		};
 	};
 

-- 
2.42.0

