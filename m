Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F87B6A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjJCNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjJCNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:53 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97968C9;
        Tue,  3 Oct 2023 06:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339128; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TD1KFakuRZxiSGXYRwMy++LKN5m/TwQVAup1OshHdXHDHjZlulOS5gp6mjEYMcRYIo
    nNWCXtOmU8pcGLFarvpIWth361Wx27APwN7cmCty2bVyvihAUgR5W8/P68yHwMfTpvr4
    F/U/8m4Fjeroj2R6nbwpv02x3JygRbxDoRi0gWvfWuaEwgQjjGDoT9Q1Zck+/ydTMmdP
    2AMfUcm5bxRVSS2TvqSRRq/Sa8nPkEUStf/V4nracW81aCFK80pabPQB2tZaxJz0eBZb
    UDEKt8W4iqT8JROJEtrVBCSYD5AjbisONNsoBablUI9XRVKyHQc62axx8cLlI3V8x62D
    05og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=5bjXhesMmGj3qm6NxqLDNr7lzDiYOW8cVTbalWvbuQc=;
    b=a240hws91gaaA/tI9/tPi0xK9GYMCzuSrHS1EKOe3khoCifItn3V34cehYNmtd6/ZV
    gH1Q5QMJoXcAL/Mc3rFTLlQbGtJusry40dwtOVHPgkyh/9fxj/ILYvdtwzE4SRbwC1Vw
    XHJJq8dUxUbZq9OqBSPpbTEBdBI37fS3K/8fSA+Me2SXwIrRJFX3p/weqUr0WFpXdJ5N
    iKKuaIbJs7X+CfaJf8/L5Az5JzHTK0PTgHsUnLjkm2yluYdxQ8lCSvoE3XiSfzHdglMS
    51GPDPo38WqWsBAlgoUXoqV0haDEYup/u3szRFo+O2ZebsRULZ0oyvwUN0BsvyVfHRvs
    sNvA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=5bjXhesMmGj3qm6NxqLDNr7lzDiYOW8cVTbalWvbuQc=;
    b=SatUV8jMwzJWRYy+QYQz5EDs3Od8DmThzcd2f2wNyf9lLJkIyHni/IdnztjCSo8PRW
    P0F4WSty6g4MFDM6IC2Dfz1/FIIYxA+FOFHB/ALJ5q31m0eURlRsbNAr6IngvlJUsDVx
    1KD05E/DWA9GGxHCQr1kpXFWH7hwJBU7UpiBfGRld8LA3RhG2RSB0N2DXCUBCUQ9lSkD
    YGcLGSw65CSqRTDBXPMTv2ZGy8Nq5s1kvVB2yn++bJh3RKcW6VREl66OejMB4wDaukIu
    MWnwkfgkbD0AXU+daW0xheaYLUOdB9lVLsHIlg2wXgAiFBkskJhQ8R5glUD5LjtKieXH
    3wLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=5bjXhesMmGj3qm6NxqLDNr7lzDiYOW8cVTbalWvbuQc=;
    b=jNGWsy1w0WWdM5V5n0Xblcc4uRuG988okfqOTbx1E7gMttEmqudKafIP7LMbZ7Cqu4
    ga5oJo2NSGvt7yV7gHCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIl2OM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:47 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:28 +0200
Subject: [PATCH v2 10/14] arm64: dts: qcom: msm8916-longcheer-l8150: Add
 sound and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-10-61b684be55c0@gerhold.net>
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
        Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Travkin <nikita@trvn.ru>

Enable sound and modem for the Longcheer L8150 (e.g. Wileyfox Swift).
The setup is similar to most MSM8916 devices, i.e.:

 - QDSP6 audio
 - Speaker/earpiece/headphones/microphones via digital/analog codec
   in MSM8916/PM8916
 - Audio jack detection via analog codec in PM8916
 - WWAN Internet via BAM-DMUX

except:

 - The mpss firmware region must be relocated to a different address.
   This is because the wcnss firmware is not relocatable for some
   reason. The mpss firmware is too large to avoid overlap with wcnss
   when placed at the default address (0x86800000).

   Surprisingly the vendor kernel does not handle this. The firmware
   regions end up overlapping there and somehow this does not explode.
   We try to handle this more safely by relocating the mpss region to
   the first higher address that is working correctly: 0x8e800000.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 31 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 47d1c5cb13f4..37fa55166918 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -3,6 +3,8 @@
 /dts-v1/;
 
 #include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -25,17 +27,26 @@ chosen {
 
 	/*
 	 * For some reason, the signed wcnss firmware is not relocatable.
-	 * It must be loaded at 0x8b600000. All other firmware is relocatable,
-	 * so place wcnss at the fixed address and then all other firmware
-	 * regions will be automatically allocated at a fitting place.
+	 * It must be loaded at 0x8b600000. Unfortunately, this also means that
+	 * mpss_mem does not fit when loaded to the typical address at 0x86800000.
+	 *
+	 * Load wcnss_mem to the fixed address and relocate mpss_mem to the next
+	 * working higher address. For some reason the modem firmware does not
+	 * boot when placed at 0x8a800000 to 0x8e800000.
 	 */
 	reserved-memory {
+		/delete-node/ mpss@86800000;
 		/delete-node/ wcnss;
 
 		wcnss_mem: wcnss@8b600000 {
 			reg = <0x0 0x8b600000 0x0 0x600000>;
 			no-map;
 		};
+
+		mpss_mem: mpss@8e800000 {
+			reg = <0x0 0x8e800000 0x0 0x5000000>;
+			no-map;
+		};
 	};
 
 	gpio-keys {
@@ -225,6 +236,13 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&pm8916_codec {
+	qcom,micbias-lvl = <2800>;
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+	qcom,hphl-jack-type-normally-open;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -254,6 +272,13 @@ &sdhc_2 {
 	non-removable;
 };
 
+&sound {
+	audio-routing =
+		"AMIC1", "MIC BIAS Internal1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS Internal3";
+};
+
 &usb {
 	status = "okay";
 	dr_mode = "peripheral";

-- 
2.42.0

