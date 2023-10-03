Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842747B6A42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbjJCNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjJCNTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:19:02 -0400
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10121CC;
        Tue,  3 Oct 2023 06:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339129; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FS5+Y/AfTep34ifUSpJ8zB8RurYCufhoKSfXI9nuaVGcWkCAoRvwqcseP1EjXyG2tK
    rjNBiD7lR36KdxMv+ha5x7UUq4DJk5Y3ZnwlvS7yM48bUTQPQL5ESSDUJ2Pk0iz4Pk44
    s5v2yxqBk4FSKkvacGihl99w79odK/Dpe3JHJaoE2rVHo1EjiCTkJJ51W+1NDNAOE4dq
    AyPrhMxIuOAMpjo4FsRi/m06pD6TulDoLn8lMUiXLLAND9pfzygutWeFLvhNwaq0uplx
    TD1m1eEZ9UN+NVxbl4jsKBku0ieqz5d6l+OFiElLdzBg997y/7uh5AN6Rcc9P0EPDCxX
    GXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339129;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=R4s/lgVmJSqQs8BGSp4xT87hMmc1uv7f8BEO2YPhFgk=;
    b=fG8hXeQqxJl4GWJkbShX8jdJBVS3yorIpcYbc3UAdqLo9r4bf44T+9TmYwIyjHcoDX
    ENG6KmBzQ3essMhE7DN7aUh9ohP3m5OhpwFZkYMRcqNvjtPLVXopjmk0aHwetZ6t+uZM
    rHwfaRsEDw6xCsyrxZiox1R9rBB4AUrSr2mCQOAPYrx8bdFwJLHlCOXiKSldQmzCN9UW
    UXRmL+W2feXnmOo+TlTbVZwtOTQJM+1b9uGHKhHGeM365IoSQj6Pk01cntlX8Jvow57/
    TyPVDRaK3Ek5JxmoUrqgnj1lBZ7v1yZvETv55UXwmVKk8E/ddSuSZuLy9lO07H/iBojc
    5YSw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339129;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=R4s/lgVmJSqQs8BGSp4xT87hMmc1uv7f8BEO2YPhFgk=;
    b=Q7BSuBMaPb/fvXbYBDYbusu8qG2+0jkLuQpvn+n/RaydPANXT85WzF+PRW7/rF5J4H
    Lq7g4aNbb6WxsYyMCGt5isFJAPWKjjkMLlOcMhQW2cGm9SiEhb+tv0hibXHOtLXZ5c5a
    CeUZKW0oZTZ5pHZJTqggpmwHReVol2t2tQS8bHQ5C+8plAHUepSCxqLk4OViTZrcsk9N
    UKBt1txkL8Jmjkyz4ZApzixecOimCWjLkQgBQ9LgVp53/lqQO3iYHqnN+VMJh0/6uSlP
    JlDir1GjIQYB4xK/YC3LKN/KXORQcrGtmy2/cxzsOpippMfxWIis5CMFx9TTaKnmNXJX
    Sswg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339129;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=R4s/lgVmJSqQs8BGSp4xT87hMmc1uv7f8BEO2YPhFgk=;
    b=NRufaT6G56Rng47fiYU4lUKx58p6XehzYKsQu2NDPe01dHKJxxmYVJ+tCsufx/EYdo
    bZ0JAtNYFiiIp4z3oDDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIn2OP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:49 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:31 +0200
Subject: [PATCH v2 13/14] arm64: dts: qcom: msm8916-samsung-j5: Add sound
 and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-13-61b684be55c0@gerhold.net>
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
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>

Enable sound and modem for the Samsung J5 smartphones. The setup is
similar to most MSM8916 devices, i.e.:

 - QDSP6 audio
 - Speaker/earpiece/headphones/microphones via digital/analog codec
   in MSM8916/PM8916
 - WWAN Internet via BAM-DMUX

except:

 - There is no secondary microphone, so a different "model" is used to
   differentiate that in the UCM configuration.
 - Samsung-specific audio jack detection (not supported yet)

Co-developed-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
[Stephan: Add consistent commit message]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts         |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index fe59be3505fe..5ca2ada266f4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -135,6 +137,10 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5800000>;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -154,6 +160,14 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
+	model = "msm8916-1mic";
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+};
+
 &usb {
 	extcon = <&muic>, <&muic>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
index 58c2f5a70e78..ba8650971d6a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -19,6 +19,10 @@ &blsp_i2c5 {
 	status = "disabled";
 };
 
+&pm8916_codec {
+	qcom,micbias1-ext-cap;
+};
+
 &touchscreen {
 	/* FIXME: Missing sm5703-mfd driver to power up vdd-supply */
 };

-- 
2.42.0

