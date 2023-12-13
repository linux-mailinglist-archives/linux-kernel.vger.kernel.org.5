Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB35811B34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441994AbjLMReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379459AbjLMReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:34:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E5A11B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:34:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEF0C433C9;
        Wed, 13 Dec 2023 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702488859;
        bh=pOzeZqYCumnmyLY7QOO5p/wpjgqUMF/9UXyX7tE2MGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6pAKJKPxD9ImO3af3kB3QdIS3Vukdcv56y93m+ANRPOWTLMMrf3y1jkOIhRrEHVT
         mFAQsnGxpWTs1lRk/Lq+02Cxt+pzoDzvwhPf0q6zmZy9hkMrY53g30Za5vSTlnbyYf
         z77fjnWKBxyygARx8tvDSHvPdS0lKAPWfGoOEoB8Zb1x09Qae0HmtnhSvx3IiNqjh1
         JkJw7K1QY26j5US1ioosTjGz6iu9YsFL8zICiixoSxxpwh/KTa6Rh5gnjIF3jDHGM8
         0BbGniqbEzvUaa5/qu7L1r6F2FWM3OrXDKPQ0DQWi1p2/Vn2iIc62v5hYiG3l2oBTH
         q0mjZia+cOJ0Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rDT7h-0007h4-2I;
        Wed, 13 Dec 2023 18:34:17 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Jack Pham <quic_jackp@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH 5/5] arm64: dts: qcom: sm8150: fix USB SS wakeup
Date:   Wed, 13 Dec 2023 18:34:03 +0100
Message-ID: <20231213173403.29544-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213173403.29544-1-johan+linaro@kernel.org>
References: <20231213173403.29544-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB SS PHY interrupts need to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states.

Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")
Cc: stable@vger.kernel.org      # 5.10
Cc: Jack Pham <quic_jackp@quicinc.com>
Cc: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 5e46b9ef8642..56c74a841d80 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3566,7 +3566,7 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&intc GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
@@ -3619,7 +3619,7 @@ usb_2: usb@a8f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					      <&intc GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 7 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
-- 
2.41.0

