Return-Path: <linux-kernel+bounces-113041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46EF888100
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128E11C21414
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644DD140368;
	Sun, 24 Mar 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGHvmtDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB013F456;
	Sun, 24 Mar 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319851; cv=none; b=e4Er+JFIrHUBuMASo5W/gXu75DdmMGAdSWohjWoo0cIWgUkNtpG2Zfriv+m8RzZd9mupqvUPZPFpK8Krq/KwIidi5GJwm/ryLU8bNnG45u0X8HFCPgBjMIGK7hsu+ye005DbvJj22fuOMHNzZWfmBt1knx/41T8fDVGjODTao/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319851; c=relaxed/simple;
	bh=cNdB/pqQYyF0iJeryPbJ9ObnQ7YMg6C50WwnaW6HwYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQA+dlIqAEl2QmXw4v9MKwlPvWUQHHuJB794/zcoTIr1n1R1uyr1KIdrLZo3PfLpM3bJdVeUtpFkRX7IDiK/FkLXvmFqMa56ksIPQtIBWBaPPb/ocDLzES4CIgBjEI9qriGJCliaPSH0UG9M3Aqu15E2mcv1vJ1VModby9xMg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGHvmtDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FBFC43399;
	Sun, 24 Mar 2024 22:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319851;
	bh=cNdB/pqQYyF0iJeryPbJ9ObnQ7YMg6C50WwnaW6HwYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGHvmtDC4Olu4JUVfkg5SpxFpRPTYQ5gKrolcoXnpbaOYyNJXlCCr7vS6s/dr6VK0
	 6dPIb6sy4qg1FsWR5qKUdCQCPrOEK5yb4JhS8OWXMlPPacVG+3wqUQYn7N7+5Kr7F3
	 kFYFF8cVGjaA7v0FzCyn3Z29Q15Y/MvQ3WPQi7LwMnDAEc3VVHL3ASNKQ0Sn+rtUmM
	 SlUA3lXPLzBIjdc9V5o4/xo/4ZZQpnTXFCqfpfjzFi+3eDEX5tD/19ya4VFgiQEI3y
	 oCM7pO/97O8rk+AOTEcN8t4pIDaKC76UBVLUjdUleHLWw4BvJQ3R8Ub9N38OHkhsyM
	 ponNdfoeDSQAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 154/715] arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:25:33 -0400
Message-ID: <20240324223455.1342824-155-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit fc835b2311d4deb85d776c1d73562338462aa7ac ]

The USB3 PHY on the MSM8998 platform doesn't have built-in
PCS_MISC_CLAMP_ENABLE register. Instead clamping is handled separately
via the register in the TCSR space. Declare corresponding register.

Fixes: 026dad8f5873 ("arm64: dts: qcom: msm8998: Add USB-related nodes")
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://lore.kernel.org/r/20240117-usbc-phy-vls-clamp-v2-4-a950c223f10f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 2793cc22d381a..317a91d669f82 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1072,6 +1072,11 @@ tcsr_regs_1: syscon@1f60000 {
 			reg = <0x01f60000 0x20000>;
 		};
 
+		tcsr_regs_2: syscon@1fc0000 {
+			compatible = "qcom,msm8998-tcsr", "syscon";
+			reg = <0x01fc0000 0x26000>;
+		};
+
 		tlmm: pinctrl@3400000 {
 			compatible = "qcom,msm8998-pinctrl";
 			reg = <0x03400000 0xc00000>;
@@ -2174,6 +2179,8 @@ usb3phy: phy@c010000 {
 			reset-names = "phy",
 				      "phy_phy";
 
+			qcom,tcsr-reg = <&tcsr_regs_2 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


