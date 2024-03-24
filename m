Return-Path: <linux-kernel+bounces-115841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B958C88983F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76B51C317D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8737BFB8;
	Mon, 25 Mar 2024 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC1mlgw+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08380145FF6;
	Sun, 24 Mar 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322057; cv=none; b=hvOxCziT7mAog6YnvsA2genikBpc3PF6e4sB2n0DM/o8DIZ7X/CQyPnWGHF1PkBR3rJlHDQ5p13NexqrJ0tpfvfnUnw75oyGHVmECOl+CdHNlE5W1wFXvAy5G6tm7bD/HhyTO1eQTlPh0sCUBPGTqY2uLepDw5SJDa/Fbyb1lBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322057; c=relaxed/simple;
	bh=VpsD2P4bz6+1wRTNrTSuNjvgkclOAGy4jeGl9qKsjhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngkXXrS127/s3dvt4YCxJfg50gDgvlRs3LY+Ey0vD39uBt1iePIm0Qo2h3M2oOhZ/ERzWcVhH6TxRyx6o15nh6PaQ6+ycwE0ByYiKufDbSWYVrVyyAhrB2ynnL6u9Ih7inhvMI8mi4JGhyUq2HCWU4G/orIqbZo1GR5NR6HZqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC1mlgw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61C9C43394;
	Sun, 24 Mar 2024 23:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322056;
	bh=VpsD2P4bz6+1wRTNrTSuNjvgkclOAGy4jeGl9qKsjhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fC1mlgw+0lDUsFvjrshctcWEoo0V4UD+U8J/ILJgbDpD4PgHlbc2xJwXM2mFtk2Qk
	 Q1rUSqipyQT1PUgwSSwTe4UvyucKrwtlQuNQzQViZUE6WDlmb9ZeZ8V94KqbelD6V/
	 eoHL6s96pOmvK/udWEfFESrE37yS4Ogg6g8Rq/FRSaHgvGd3KYvNTtDviTIFBQSgpT
	 jbJjCfkti3hbQVonUedvKstQ9mCrOX2y/HsAqZXFqoBXrd5DjMM6hg7b9/kqFa554K
	 0x4W1KLijONCZ8ICO6V5fkMuMDEfHr+GDLQx0Lm6PfNZJ558Cg5ze0Welp4omneF34
	 WSZ2dnIiRknzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 129/451] arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 19:06:45 -0400
Message-ID: <20240324231207.1351418-130-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 6eef7cbe7d7bf..6c3aecea20370 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1052,6 +1052,11 @@ tcsr_regs_1: syscon@1f60000 {
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
@@ -2058,6 +2063,8 @@ usb3phy: phy@c010000 {
 			reset-names = "phy",
 				      "phy_phy";
 
+			qcom,tcsr-reg = <&tcsr_regs_2 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


