Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2C75E628
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGXBPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjGXBPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D39E6A;
        Sun, 23 Jul 2023 18:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DE0E60F13;
        Mon, 24 Jul 2023 01:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD4CC433CA;
        Mon, 24 Jul 2023 01:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161301;
        bh=ffiy/BuX+FpebDZznlAWahYjOgiu720u1XXkbgF04/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKJEcCnE8HxhxoTWRcA4UQaj1CGuYfVswG2Ye5HrWq7k2VYd9rNPkITv01GINPgvw
         XMz3t58460XvXPF3E17aye1hv/k2KEf90jJZGiiFQTtIvIDzIFFweA135Xc2lKghkg
         2uMGbEaROUv53pYfpSZMVVx8xmjUVDoqWWGB/9sJyHXQqgDO2Y8iKkS2eaUbR/xjFQ
         X8b0WGmBjQq/F8RvcJnQtMR/ij9QzQyDEMHjJuGWvdX/3L2l4SnEu/KNK/BJwPEfyO
         YWYt7s6iZxXV4qyRnNw6/F5MP2zfzb4hXcPn4X1rQ+JGLpy5zN3tywNwmYUV9z9xIq
         bMm3N/bSjS0Fw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kathiravan T <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 17/58] arm64: dts: qcom: ipq5332: add QFPROM node
Date:   Sun, 23 Jul 2023 21:12:45 -0400
Message-Id: <20230724011338.2298062-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kathiravan T <quic_kathirav@quicinc.com>

[ Upstream commit 2f34a2aa4c88f4882e3c5df8c9b78f8bbd3f564f ]

IPQ5332 has efuse region to determine the various HW quirks. Lets
add the initial support and the individual fuses will be added as they
are required.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230526125305.19626-3-quic_kathirav@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index af4d97143bcf5..c2d6cc65a323a 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -135,6 +135,13 @@ soc@0 {
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		qfprom: efuse@a4000 {
+			compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
+			reg = <0x000a4000 0x721>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		rng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
-- 
2.39.2

