Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2CC7AF146
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjIZQwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:52:04 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED6126;
        Tue, 26 Sep 2023 09:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695747100; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kyS9j3istprNUcTC6bgnIEhaTIkRL6SVLdcGxlsrwqYoxsLkWI5/7xBUAOLiZqaQM0
    KhRIj/Rbkf0Jh3egdyD3byW+IEGfU5Wi6XRG7z/oBO5Ad1PeC5/zBm5AS0HQWCAl/J/M
    gKrs+opVEo5K6GEsZfhrDOta5iYhYTA6Q3O6sXNWLCF1FDfzAwPWeT2es12Zw6oaUDaR
    7rRV/czRcxdfaUo4gBPiITMvb2GwzHcbiTvI5Yz646r6skaMbQ15zF49x/ABQ+kiQFYX
    QU3IF25iy1iLl8d13Qmrcimgl5AfNoq6/32Le5wfcSoco9HYrHgfj9cyqJNrDT1mXkOM
    scVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747100;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=hfQak+qd/CwUYQT+9N6dyj+xLdEMvd0p5kk5akj7nGU=;
    b=Tzd1U2NF+NtOQ2MhvE3g/gbqVb5Daoju0zmRwL5fvbQmpome6SDCqD6R2d1y1rN9m2
    GRYvcN77aAwq5Quxpb2470byvWow1Ieo+diCoxlBHKgDidKll9GFZKMp14GC+QCrA77l
    kp3QHf8/7j3ONY9Li/FovmliarobQomNvMCpFbwzdt5RbGTA3HeXrBwIunn2pXvWPsho
    kliK99zd2qJrP4KXwJ0Rf+GHcSMGfhwVgVCH/Xw9dL1b0vLlWjeuotkX+x9iANsVoA8t
    S8tSzOUXe1kB2CxUmOMAqf0d3AwxJ9pGoFWUUDmNzQfeQNL0xnBWaVizt55jgeV8IFPy
    /Qmw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747100;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=hfQak+qd/CwUYQT+9N6dyj+xLdEMvd0p5kk5akj7nGU=;
    b=VnQHgOps50nsAIiERHfVNOuSa40qCFL6yGuN276zeDuD6msOE2c/VcMvJICs/1MPHl
    yJqQwTpzVKyXK54lrG3gp/eIe3hD/R0pOt9kaMKQL6wKky2sMq80Zg8a2R7Ada35zREo
    hov5Mlw9IVRb4Jf1G3oAdyphG8W2ms2Ll6aMlr1vT8iMlbdtLTApehlWwBpTlGedw0l/
    U3ydHVsvqykfGDB+o1uVU+dliOhKW++cEGz+HVfhdJDty1dBPQv6qICzT6rQKTEAEehu
    RlsyQxr3gLss42En7ORoK7mvlnWPMkldDm+VRMcfh+8XmHOKwB9IVgroHmoiHUAyh9b3
    iO0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695747100;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=hfQak+qd/CwUYQT+9N6dyj+xLdEMvd0p5kk5akj7nGU=;
    b=rqIulaC7MlJuPwOTo2//YHIuOUFMhYcyls2nynyq5XIpuWDB9OvBOndaUzy0frrlsw
    9FF4O6UCl7O2Ppn1msCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH+nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QGpdg5f
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 18:51:39 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 26 Sep 2023 18:51:22 +0200
Subject: [PATCH 08/13] arm64: dts: qcom: msm8916-asus-z00l: Add sound and
 modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-msm8916-modem-v1-8-398eec74bac9@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
In-Reply-To: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        "J.R. Divya Antony" <d.antony.jr@gmail.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.R. Divya Antony" <d.antony.jr@gmail.com>

Enable sound and modem for the ASUS Zenfone 2 Laser. The setup is
similar to most MSM8916 devices, i.e.:

 - QDSP6 audio
 - Speakear/earpiece/headphones/microphones via digital/analog codec
   in MSM8916/PM8916
 - Audio jack detection via analog codec in PM8916
 - WWAN Internet via BAM-DMUX

Signed-off-by: J.R. Divya Antony <d.antony.jr@gmail.com>
[Stephan: rebase and simplify, add consistent commit message]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index a8be6ff66893..ff8eb0a94795 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -3,6 +3,8 @@
 /dts-v1/;
 
 #include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -130,6 +132,18 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5500000>;
+};
+
+&pm8916_codec {
+	qcom,micbias-lvl = <2800>;
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+	qcom,micbias1-ext-cap;
+	qcom,hphl-jack-type-normally-open;
+};
+
 &pm8916_rpm_regulators {
 	pm8916_l17: l17 {
 		regulator-min-microvolt = <2850000>;
@@ -151,6 +165,14 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
+	status = "okay";
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+};
+
 &usb {
 	status = "okay";
 	extcon = <&usb_id>, <&usb_id>;

-- 
2.42.0

