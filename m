Return-Path: <linux-kernel+bounces-114149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA218891BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2DEB3418B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B7161939;
	Sun, 24 Mar 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFBJ7ZoD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADA1E891B;
	Sun, 24 Mar 2024 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321464; cv=none; b=PN9WWYSnwrA45Qs/7QzQ/qlLFBxrICd0SzMBubUqdQ0aPz+B4k0qXN+HpZpOXyOLQWATa+oajodYdNNj4X7kWJT8RyWYmAgAAQU8ukrIYwHFVLij8AX5u8sf+vUtGTMGL26A9P5GFme4mKIzAPNKy2HnHsJXki8/UMRkfa7lswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321464; c=relaxed/simple;
	bh=2S5XEGW6CG13vWHDGj9DQWHEEeuS4sTIhIweWGlCY8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD9C6YoHOePSSFWUmHWHJawu6T4PytZZVApkpOTmzLg94jW9MPgjXQFE9n2aAN/oS8D/TtFCPHKyJmXQN2VpVgNlIXBg4afXvY+5QwvYOOmupHdpstd62ZoVYS5x8RVXdMauO6QtPekN5T4vzgApyNyktLWsgYlknFWfcJ7CfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFBJ7ZoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C23C433C7;
	Sun, 24 Mar 2024 23:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321462;
	bh=2S5XEGW6CG13vWHDGj9DQWHEEeuS4sTIhIweWGlCY8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFBJ7ZoDllyecSlaVt27ItQb1/OEnhavJB0qX6C7gsqIZlVBXuBS0Jl3zLUgLFxin
	 FYab25PzNnRoYeHDHu9bz81hMI+3hmGQZ5r+hCWXHs0/lQGxumuFek0tVZ23mGC62f
	 2DI4xFhpY3USAA277jUz+j0Z9R6Yz1kdSu4IO99dnEdPclruwRS++3dT51y/1zpg4b
	 Xb/4HdRcICgvo+Wmx4yn+nz4mzIvAHcWpOzmK1x34Ut83LmlIl9XXUmjNXVx+zxV+f
	 RvzYcDIFNUa+SJsOvhf5IK0vHNWnWvSFjNz+XsCWFSmTHB0JU+kLpaIntPiyG1hpYO
	 ciL4S28P7Acxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 187/638] arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:53:44 -0400
Message-ID: <20240324230116.1348576-188-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 85fcbb24b4642..b3bac8a420568 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1085,6 +1085,11 @@ tcsr_regs_1: syscon@1f60000 {
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
@@ -2188,6 +2193,8 @@ usb3phy: phy@c010000 {
 			reset-names = "phy",
 				      "phy_phy";
 
+			qcom,tcsr-reg = <&tcsr_regs_2 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


