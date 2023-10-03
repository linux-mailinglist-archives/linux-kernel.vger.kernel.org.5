Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0A7B6A43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjJCNTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbjJCNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:54 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A0D7;
        Tue,  3 Oct 2023 06:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339127; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m9nBnBQlIjsjlTOXU5RINHos6/J7VNn7Dm4f4VEVZE4JCtbqzxoTgLUi9/7CZNy9P2
    pKP7GielkEBg3LdVYn3y6p/0hqwhl2DxanhWWSDqu1b9otfB+gaSSvibzH3Zcd/tXUTe
    zMmHS8IDvhUZxhD9rxxElhokrV1Euo416zT6xb4I6Q5H9l2fAAVxlhJ64UYeZA8O1a9P
    J7B3kNoFkfVYlh1pNOHID85uE3zEXWnaVbaaJ9BaIWSkxlznKvco1swEi7wYz2PKKA3e
    VTFlWp3PKFiqxhGxPy0x08ueYwUstfHI8o+kODdmu30PY5KQZ0gGwCq8lnNO0D91FYQO
    qOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339127;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=fl2zPeMOpvqp5YiTJDF1poGBKcAKVmQvhzP6pe1xmJc=;
    b=nZxeR8dZCAD+H9mHntgb56ZPxulUxcn5CmI0uSwVYL92kXbV4yhUL2o3E3nIAmIR1z
    cbvKDsfrfIwQsnzAz+/qOtB+fdP45oox0EwZouxPEacOZgnFX3LNl7fyFa5Fci7mRUxN
    vmQpawYmWrFedLwqhO9bTDZ5ZwHQkaIt9GnLrhYbfMVm/XScJS10qEeXfYqoK3OaiA1W
    mnliF5osbXAYV4Kjm0VKlIrf5pZKBQGxEKfTI1v1stSSp4HE4yfyD1/EDd/TLMCGjHpd
    XOrliFSaQsUq825mDgm47uXONX/adYxg5WtTE7VznKY4EdUvqH4pMLxcPk6xK8mWDIjs
    DOPg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339127;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=fl2zPeMOpvqp5YiTJDF1poGBKcAKVmQvhzP6pe1xmJc=;
    b=CUVMA85IO5/nB8jEayAhcWrW3OLaax6qW/gjNM6Pq/SY8Cg4fO2ZP3jBA/ytuDS949
    2XiN23tzagy2gFRc/Y1Yl1Dw2+gdSd0d3YiUmavlmfCbIfn7iMLXJJajMMDd6laoJ1V6
    YTRdjesm7ZbXqpgqVLB3KQZjf33jPZgLsfmgcU1KhtN3kT1rVXteKYf+X0orw9z49U0c
    YTLv7jaEZuOjT1zilKuUiFm79jqyMghd+RitHH+0qcGpukEHRHwpYK1l6EOu0JLeji4D
    L3aZ82pVyxdgUQlCIu8K7sxMwG9GjsnxWGrV6qVNtb7SiEYVgRLfU8IkIsGul3u4YrDf
    oxaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339127;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=fl2zPeMOpvqp5YiTJDF1poGBKcAKVmQvhzP6pe1xmJc=;
    b=zCq0ZrWN2+ZjnyBSKSOrGk6GNSRYR2VLQIHMgGx6tzFQCW1EVFW49Ang05NK2oed0I
    rGKunBXb3KK9M/7nOuBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIl2OL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:47 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:27 +0200
Subject: [PATCH v2 09/14] arm64: dts: qcom: msm8916-asus-z00l: Add sound
 and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-9-61b684be55c0@gerhold.net>
References: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
In-Reply-To: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
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

Signed-off-by: "J.R. Divya Antony" <d.antony.jr@gmail.com>
[Stephan: rebase and simplify, add consistent commit message]
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index a8be6ff66893..77618c7374df 100644
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
@@ -151,6 +165,13 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
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

