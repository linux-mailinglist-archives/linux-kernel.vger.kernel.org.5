Return-Path: <linux-kernel+bounces-114784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F6B88924E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D4297C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD81B52EE;
	Mon, 25 Mar 2024 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3L3Rcv6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF13175C84;
	Sun, 24 Mar 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323389; cv=none; b=Pmh37daldGYkf602kHvqoSzEn5LFiM4uwVM3YxF99aJF5Lyk4gLUiho3MtI4jpN/cAr7zLMB1qmSInnpMbxDevVlTbc84e24GNNU4HBmmDRcWSQvcWOOckK/Ri+Gf/sqIoPfs/HPoHXVpZ7tMI2Y0pGER2ggFE6uAa4EZJI55go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323389; c=relaxed/simple;
	bh=MyT7mOET00kWAGJobb86ugKpx4ruCR/LeO1Hr6qS+UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWEDVcVkJAktCgTZp+6pl44Tt5plGbuV7G5qbfsvf/0ppEV8C6WyPrvpFN87559/CrWbr+oe7c5Hfmt57b3IgGZCTn29enHGncU9T3ttbxWG/BovBECn09dI4RanWDb4M83GcPFyM/Y+zEHHCnPmb6lQE+59YP5GAQKmmdbL6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3L3Rcv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41492C433F1;
	Sun, 24 Mar 2024 23:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323389;
	bh=MyT7mOET00kWAGJobb86ugKpx4ruCR/LeO1Hr6qS+UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3L3Rcv6UxaDpCWDZR3jnqsf+VFs+21lBDjvRyVcvcHVMiAlxg0+T3r97fxURbovn
	 7EJNhwh6Y/RuvAC84z9rzPRcesXoFQYK9Cb7MSG6t7JA7qOQm1RWFOA2iAZlg/L7PS
	 o9Awii2NaKq+TxgQIfzh+MclwF55Y/3H70GfdJdDD15cKya20yKVkZUoqJjkLUVNQQ
	 q1caXwgo/m2WZqBAY3/IPKkupAyGIMF5iAWiM4L/mJW7MblwjyQyj/Sc2yOoGp2BQR
	 3uskDqG7iTqU1/T7BrrMyG/3Rxl68YlZ2BM1G6tgb2Ga1E+nUkrJIY2LFZdMV4jfUM
	 VGc2GrV2hm8Gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 089/317] arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 19:31:09 -0400
Message-ID: <20240324233458.1352854-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index b3b1258f2d6f8..3d32bf0986e1e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1081,6 +1081,11 @@ tcsr_mutex_regs: syscon@1f40000 {
 			reg = <0x01f40000 0x40000>;
 		};
 
+		tcsr_regs_2: syscon@1fc0000 {
+			compatible = "qcom,msm8998-tcsr", "syscon";
+			reg = <0x01fc0000 0x26000>;
+		};
+
 		tlmm: pinctrl@3400000 {
 			compatible = "qcom,msm8998-pinctrl";
 			reg = <0x03400000 0xc00000>;
@@ -2010,6 +2015,8 @@ usb3phy: phy@c010000 {
 			reset-names = "phy",
 				      "phy_phy";
 
+			qcom,tcsr-reg = <&tcsr_regs_2 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


