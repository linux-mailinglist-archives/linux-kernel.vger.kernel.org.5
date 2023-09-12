Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6D79D15F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjILMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjILMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:49:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE910D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:49:54 -0700 (PDT)
Date:   Tue, 12 Sep 2023 12:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694522992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhVVrWXa7IW/fxQupWP7PXUBWHy79bTLsdUIjJCRATQ=;
        b=tHqx/5veA85m29J6MiMsnsm0aB+UqrSPMkoOKghbEc2XqAAzpkUN6J45Gn2x1Yyund1XbO
        3opWj2HLQaN+ces1TKSKz8kqb+HQ8xB2bhc9UtES+GnfmFkupFxWpegkj7cFLjAPk6JlB4
        iLNJuYmREz8VlIy6NhElxQKjwFSVhWg3pm/pTkiVNrcxYrDyp81vrEIpaiqo46Cz4XjnoU
        l8DBDG895p1U1yGhGxxIPW82ZUcTsvxkTXSw5yzm9+5WyXSA65bbRSkIuVHvGS3F13QdMV
        G3F6vUdEREOFiGwz+5nwyUVE3Mexw5tUve20y0ngMQP3LiOqA1lo1aS+EdyL0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694522992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhVVrWXa7IW/fxQupWP7PXUBWHy79bTLsdUIjJCRATQ=;
        b=QP2csRYh2wN0u2JD6OpLO+DcipxoVThUddnwPywr5DH0ueZAmtZZ3CgPZFZmGuTwFNCdad
        +lF+XKZszEjk92Ag==
From:   "irqchip-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] arm64: dts: qcom: sm8150: extend the
 size of the PDC resource
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230905-topic-sm8x50-upstream-pdc-ver-v4-2-fc633c7df84b@linaro.org>
References: <20230905-topic-sm8x50-upstream-pdc-ver-v4-2-fc633c7df84b@linaro.org>
MIME-Version: 1.0
Message-ID: <169452299198.27769.14062957602111362266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     cf5716acbfc6190b3f97f4614affdf5991aed7b2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/cf5716acbfc6190b3f97f4614affdf5991aed7b2
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Tue, 05 Sep 2023 15:19:26 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 12 Sep 2023 13:38:08 +01:00

arm64: dts: qcom: sm8150: extend the size of the PDC resource

Follow the example of other platforms and extend the PDC resource region
to 0x30000, so that the PDC driver can read the PDC_VERSION register.

Fixes: 397ad94668c1 ("arm64: dts: qcom: sm8150: Add pdc interrupt controller node")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230905-topic-sm8x50-upstream-pdc-ver-v4-2-fc633c7df84b@linaro.org
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a7c3020..06c5300 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3958,7 +3958,7 @@
 
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8150-pdc", "qcom,pdc";
-			reg = <0 0x0b220000 0 0x400>;
+			reg = <0 0x0b220000 0 0x30000>;
 			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
 					  <125 63 1>;
 			#interrupt-cells = <2>;
