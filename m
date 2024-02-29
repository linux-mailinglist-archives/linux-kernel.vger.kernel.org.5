Return-Path: <linux-kernel+bounces-87455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8E386D4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFAD0B21BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE11552F7;
	Thu, 29 Feb 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq20E13a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A114AD10;
	Thu, 29 Feb 2024 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239106; cv=none; b=ff3ANIwNBWBP3u/0F8sKp2+uOSubXh8KfgfBkpoqf6dfeCsFLi7Z32QDHx98O11rpNajShxzgVnlVbYs/eHCJKigS3MsatCyzgZOWFgHFZoRW3j7FsTCKSgBXCmK18rcPjm8YJLwC2WDYmG/dPAXOd7lV0jy4Ob3bz7QbF0tWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239106; c=relaxed/simple;
	bh=MSMHSSINMJYUm8BK2KXGSpQia4mfnHTv+VfS9CXCscw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkQGp0PZbTfYo2xc+V/Non3dw/FEX8adacoo7JFhtcz36fTeN+q9TBB7H7iNTI3EF0ybU/r12rzsDaJvPKGVGEwjQdC74W16FbE6eA3nikAjxIr0VuLmbdQDAprXfM2RfIPziHsEMVNE/nT0e9pPmHQEoMX4ld5TAthckS0bTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq20E13a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89C8C43394;
	Thu, 29 Feb 2024 20:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239106;
	bh=MSMHSSINMJYUm8BK2KXGSpQia4mfnHTv+VfS9CXCscw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iq20E13aMTEg1XERMI7wP8oFa3lv8VfLbKTxrdeL6rplV6YzbguRRaOigaUs+0v/L
	 oteInsSUorVKHUtP2RWgz5p0/cDqgdIGUNMjiJC1TBQz/IIeSmVjlnJYxhPI61UTFQ
	 7JXOVgiRErKli3x5ELF5xoVZwIrSBRaHruwNrhSPkiwM/Rb5DsPDk8ot7mTxYtcjTK
	 wASWrbY6q6EKy6cdOWzMG22Ajbp+g8WGX5yJ0CQb0AUHGqlYD0MdTpMtQLDIqoMZgo
	 RzdYfSzEwGmpCSqPmJHJpNHZmFGhIYgiqX87PErCdKinKckRjOxCOjMAYOrCzztbR+
	 2pyI9HS+pYARw==
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
Subject: [PATCH AUTOSEL 6.7 22/24] arm64: dts: qcom: Fix interrupt-map cell sizes
Date: Thu, 29 Feb 2024 15:37:02 -0500
Message-ID: <20240229203729.2860356-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index 0b1330b521df4..cf4e501c84bcc 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -759,10 +759,10 @@ pcie0: pci@20000000 {
 
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
index 2f275c84e5665..b33145b756ebe 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -806,13 +806,13 @@ pcie1: pci@10000000 {
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
@@ -868,13 +868,13 @@ pcie0: pci@20000000 {
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


