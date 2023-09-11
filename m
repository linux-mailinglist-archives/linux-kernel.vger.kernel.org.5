Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D388979BEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjIKUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbjIKRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A79CC3;
        Mon, 11 Sep 2023 10:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454124; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X/XuP2Nx1SMc88icfHpmoSqa7hCnjIumPmX/AohoFcFRMwPGl5Fv+E7g+O+iC7sENs
    0SXkdnebhqWi6EzCNFIYXXX2yU7zwbl2/M3MR9FrZ5VnFDO3L/OLCYjU+HopHoYXZ7eX
    MTPv6DIYVRJLvSOiI5xYBX8k3DlXeKQtoRDDoG08bmYSyHYBjqF2omyaBkruaEfZcbTP
    zhtHXYPn/RIo1BURE4xcFKaKTiHyoIsguEuWG6o4/+Ui3BeBww3cEb2hl+lZtg3gKTvE
    RUF6CludLBUh0uk5CCjpm5h2oCkilRdF/TwJQM8Pb00/LoBInknH1mzw3AioT2/BRXzD
    bnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454124;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=FYqygZxToenRNHUlAQbQ38YDoGCcQBs/RUIH46z7j6k=;
    b=fA4kaPJ+tzelg6jwOu4LYLmbX4NAD1vN6RI04bPTyx5i7F/0yCRtf2+B53fzx802if
    PXKFJCe38sErNo+tuokGMX/ehaR+HRL4YuD51qrMJyMmRs39WRGA8FaK2Jvhpb8p9Kt3
    Ci6nbqCQiBrUQg25ToxMokiM9AmLWXkL7F3cXdgSiEkCVRfrhcoM8FtnIYJbqddH/+9R
    TKkHtXGLCJD9MCKlEDmZj1WvJYSlSFOJNykIgK3pHDDH2EZJYQaPMhNCL8mbwZ/r1g4H
    2OQOoel7HQDJnwpbe5wBcTM/9feBE5uIbRUswxHhWx/QfFcHcLbN3cG+9NbfDWpKaQTK
    VRIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454124;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=FYqygZxToenRNHUlAQbQ38YDoGCcQBs/RUIH46z7j6k=;
    b=BEwHyORmDQuqLulEBLG3pO7MtMiqJ1I/0HR/9AB9d8QTr4/MpplyzKCWwN0s5VIv22
    piv9X0ToREwHBuoeHbuosTfbEI8UZjgodTWg/OoRn7fI+SJJwiyYIYAI4N2qFREZcaGC
    On2j8wUsgz+5XvlXHc+jnrL30MZ1/rIN39j3wPYnO+1BskrWwgcEGRaJhAYjy8JR9zAY
    sHxgyh+i9XTZknv0DO1hwnyWPpe1JgKUZl4aje5thk5wKbwuiaFpXU+5/zxQc52kWxxX
    8AqqjKW2v3FIO5L1fN5pIg7FD58RauVGPkwudXrdlo+7/377DvM1lBf2LZXlCWMbXh96
    yl6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454124;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=FYqygZxToenRNHUlAQbQ38YDoGCcQBs/RUIH46z7j6k=;
    b=gj8iSLefgty9qVWRT42C9ntujIQMW6Cnuj1heOLznr4s4EmvxBs2aQ1nPH3A3nIxuy
    hn4Jfbs4s8z7sHM26EDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg4awS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:04 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:50 +0200
Subject: [PATCH 8/9] arm64: dts: qcom: msm8916/39: Move mpss_mem size to
 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-8-b7089ec3e3a1@gerhold.net>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modem firmware size is typically highly device-specific.
The current size of the mpss_mem region in msm8916.dtsi (0x2b00000)
only works for some APQ8016 devices without full-featured modem,
such as the DragonBoard 410c.

The full modem firmware is typically about twice as large (~45 MiB
-> ~90 MiB) but also varies by a few MiB from device to device. Since
these devices are quite memory-constrained nowadays it's important to
minimize the unnecessary memory reservations.

Make it clear that each board needs to specify the necessary mpss_mem
size by replacing the DB410c-specific size in msm8916.dtsi with a
simple comment. &mpss_mem is disabled by default so it's fine to leave
some properties up to the boards if they want to enable it.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi    | 2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi    | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index ae510c5ec830..3381550a5c9e 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -263,6 +263,7 @@ &mpss {
 
 &mpss_mem {
 	status = "okay";
+	reg = <0x0 0x86800000 0x0 0x2b00000>;
 };
 
 &pm8916_codec {
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8457472c9ad8..4d867078388d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -84,7 +84,7 @@ mpss_mem: mpss@86800000 {
 			 * alignment = <0x0 0x400000>;
 			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			 */
-			reg = <0x0 0x86800000 0x0 0x2b00000>;
+			reg = <0x0 0x86800000 0x0 0>; /* size is device-specific */
 			no-map;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index c50f6d828fed..ba177725f3d7 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -356,7 +356,7 @@ mpss_mem: mpss@86800000 {
 			 * alignment = <0x0 0x400000>;
 			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			 */
-			reg = <0x0 0x86800000 0x0 0x5500000>;
+			reg = <0x0 0x86800000 0x0 0>; /* size is device-specific */
 			no-map;
 			status = "disabled";
 		};

-- 
2.42.0

