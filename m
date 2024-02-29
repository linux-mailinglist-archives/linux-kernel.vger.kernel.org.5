Return-Path: <linux-kernel+bounces-87480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307886D4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B392844A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711E74BFC;
	Thu, 29 Feb 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD3QnQMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB714F9C4;
	Thu, 29 Feb 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239230; cv=none; b=ISzw0Hl3iuH4KvWmWN+IKhkt7pTd6HVkwRY4UNAAdxG0gTGO34sTDCLgrb3HPl37aykfdzz+8bElUlOgXPAl6GO6vsBDNR3PSmTpg8G1U76rfvEHnK8KjTrO+48yjsdxnT8UHumON5ciTZmSWUrDptQH/zimGB0TwADUWg9Gwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239230; c=relaxed/simple;
	bh=+VkSfxLjq9zTh2Um2OakZb7sD8Gj8u1Q9eEf/0H2ymo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVq0tmG3aXHyHB+uZRgjcQujDd/P7RiF3xJRqQM9tWyIPQRMj+pE9Es8f4+wbqIRK4mjKK91YyXGCmb5R9vlbCtmjKjE0Q3s82cc8A9xFulrmgYyMjo+Jq3sC0oonF+YBDClQ5xLt32Wrb1w0HguBje/a08oSmK/73qyeL0htf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD3QnQMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42630C433A6;
	Thu, 29 Feb 2024 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239229;
	bh=+VkSfxLjq9zTh2Um2OakZb7sD8Gj8u1Q9eEf/0H2ymo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pD3QnQMDiNE1ntCPRoEDWm4mjBzCD+H+lfgVx9Whw5w2PSEVFb0rUtek4JuyKRClM
	 tSaGmcIcqNWa/VRc/BRAR/TNRfK8pcWJstbRzeZg6Q7AwvRcKlTo4Xb6HR7kD3ApPb
	 LGKvMaoYOUbqoynXZXnYqdRVe5pmwB/iTW/SiGaaBHM7nU/jfjXfeZRyBISHcObawR
	 AFmbkIILBK+7w88FwtZtZrVw/73vhPTc52+liLLpjpgYxX4RxuttvQ4YdDKwzOwCqd
	 bMCtiOqzpaJfG99CMK41UEwN8OMnohg7LFfOVVnOgwpfOLyUknf5RCyrqlHtFRqthu
	 GNnx/ZxCxHfTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 21/22] arm64: dts: qcom: Fix interrupt-map cell sizes
Date: Thu, 29 Feb 2024 15:39:14 -0500
Message-ID: <20240229203933.2861006-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

[ Upstream commit 704dccec0d490f2ad06f3f16ebed254d81906c3a ]

The PCI node interrupt-map properties have the wrong size as #address-cells
in the interrupt parent are not accounted for.

The dtc interrupt_map check catches this, but the warning is off because
its dependency, interrupt_provider, is off by default.

Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20240213-arm-dt-cleanups-v1-5-f2dee1292525@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |  8 ++++----
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index fc907afe5174c..4294a5405c012 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -767,10 +767,10 @@ pcie0: pci@20000000 {
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 0 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
 				 <&gcc GCC_PCIE0_AXI_M_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 92fd924bbdbe5..5effd8180cc41 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -817,13 +817,13 @@ pcie1: pci@10000000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 142
+			interrupt-map = <0 0 0 1 &intc 0 0 142
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 143
+					<0 0 0 2 &intc 0 0 143
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 144
+					<0 0 0 3 &intc 0 0 144
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 145
+					<0 0 0 4 &intc 0 0 145
 					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
@@ -879,13 +879,13 @@ pcie0: pci@20000000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 75
+			interrupt-map = <0 0 0 1 &intc 0 0 75
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 78
+					<0 0 0 2 &intc 0 0 78
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 79
+					<0 0 0 3 &intc 0 0 79
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 83
+					<0 0 0 4 &intc 0 0 83
 					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
-- 
2.43.0


