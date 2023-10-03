Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8337B6A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjJCNSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjJCNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:50 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734DCA3;
        Tue,  3 Oct 2023 06:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339124; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fdIfBg7djrGLNldQCyqyw/z3+FAfxmNj876eOnFAGf17lNgABA+FpB83mO2xPS89H+
    9TM+syGHdI9GD0gsNMKT+SxoBneJbG9hTUU1tPqvdjZjeMNJGWi0FUhcCR2vn7eQzamH
    +xzAJgc0hZOOMFQsUwu0InAk5EN5TH//2q8K02vW3DcT4qMw4Kwul6PjEYDzJbaUZLF5
    OHWjJBPa+RX+aVvkSQwKYLMJUQp/CS1FYoFuWyrJTRgiq/pM55pRhIbi0GPJCYFTW6By
    ds34oLa+xta8502APYokUXmnr+kosBE2D8c8Dh+7jIyw1uvd71h2dnxqYKDklrFl4PYh
    5BRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339124;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Tcfqcvw/OBMlFrrMXxA2/+w2/9iajTV/ZetLrmXPr8s=;
    b=DCi4E7ZWUVqdjsLkIe5tRTtu8IEnkexI9n7TMfnMzGxnQ0usU7WDsjzH6vcLBTPRKo
    KsWbYGRyWUZ+VByq6nWRszr88+GfSwgnyWZ6MFuZrdXucFvrpBUv7SJ/0tbG2K+sXD+E
    fRJHd8XgCXw2Ou0xnZcQC+Y963uSaZ9y30ZqD8PZPEpDnaEEQPioo4V84iywlUxvee9X
    yNf5L4mvNnHjzSY9EbMv6akYkbznclADEmDPe/faIP6W7k2sBfes0PND1FXlouMpds9+
    +TZVkrdCW7jYIJVc8yMndDlrQfcKQghgWuD/BlYleqG9ZY71+4T4sbcRpqrXJ+u1LAo9
    J6Wg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339124;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Tcfqcvw/OBMlFrrMXxA2/+w2/9iajTV/ZetLrmXPr8s=;
    b=TTN/0qTzq5ooaTjlgDYyskDve3QCpL8IBd8D++SIj8QzKl1iHDvgI7lq1DMLSiU5v/
    EJ/gOjmfrbWwAQktLxs1hXAV3DwS36kkBrCsP56Jgr9Mi3/uAR41iBAJ/1rQpb33xhZH
    G/qvYUf+MtG8WPPQQu1Sp2hM5A6ficSxmqVJCGIhzXYOEqG/7sEC6vV5hVOB8XLFJrKi
    XMRAJxBUcYZf3Es02q18nLJrnyxIUA6I6qKQAkqb39yXG+OJ80euxKHiedu0Mf2RdhWg
    jeseAv4A4amNokVVbzDkrn4h/HYKtvLNuQld1xCJ4qxONq7F64FPwUU8RCe46mA6vB0z
    QoAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339124;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Tcfqcvw/OBMlFrrMXxA2/+w2/9iajTV/ZetLrmXPr8s=;
    b=Ca2ZaqRXe+vS2Mmip733TQ0F1mXpBOswp8jwB1xvQghGKwyvEi9/tIeThlwGsKLSUG
    LgsQYh8R1qzO4H+0Z3Cw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIi2OD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:44 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:19 +0200
Subject: [PATCH v2 01/14] arm64: dts: qcom: msm8939: Add BAM-DMUX WWAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-1-61b684be55c0@gerhold.net>
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
        Vincent Knecht <vincent.knecht@mailoo.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Knecht <vincent.knecht@mailoo.org>

BAM DMUX is used as the network interface to the modem. This is copied
as-is from msm8916.dtsi.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 324b5d26db40..65c68e0e88d5 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1537,6 +1537,20 @@ spmi_bus: spmi@200f000 {
 			#interrupt-cells = <4>;
 		};
 
+		bam_dmux_dma: dma-controller@4044000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x04044000 0x19000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+
+			num-channels = <6>;
+			qcom,num-ees = <1>;
+			qcom,powered-remotely;
+
+			status = "disabled";
+		};
+
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,msm8916-mss-pil";
 			reg = <0x04080000 0x100>, <0x04020000 0x040>;
@@ -1569,6 +1583,22 @@ mpss: remoteproc@4080000 {
 			qcom,halt-regs = <&tcsr 0x18000 0x19000 0x1a000>;
 			status = "disabled";
 
+			bam_dmux: bam-dmux {
+				compatible = "qcom,bam-dmux";
+
+				interrupt-parent = <&hexagon_smsm>;
+				interrupts = <1 IRQ_TYPE_EDGE_BOTH>, <11 IRQ_TYPE_EDGE_BOTH>;
+				interrupt-names = "pc", "pc-ack";
+
+				qcom,smem-states = <&apps_smsm 1>, <&apps_smsm 11>;
+				qcom,smem-state-names = "pc", "pc-ack";
+
+				dmas = <&bam_dmux_dma 4>, <&bam_dmux_dma 5>;
+				dma-names = "tx", "rx";
+
+				status = "disabled";
+			};
+
 			mba {
 				memory-region = <&mba_mem>;
 			};

-- 
2.42.0

