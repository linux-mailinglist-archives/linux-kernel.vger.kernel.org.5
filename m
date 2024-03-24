Return-Path: <linux-kernel+bounces-113042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E1888102
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D20280F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB3140394;
	Sun, 24 Mar 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0ISpO2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4C482EE;
	Sun, 24 Mar 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319852; cv=none; b=bNfx8G3GuOLNPjxLSUaMC7JT1n5Cb3It5qn0RPMiQa1Y6HvIGhGMiCqL/l46dOhCC9rNmt+uXe1UjNwudiZzrmX08B1DmFYCS4OFBXZ4cNMzIN5i6zxNbPfl2ay0/nknsB1I+cdw2SvcCn6Vi+drRQkLu6PCDwjM5rMs/Iz9njc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319852; c=relaxed/simple;
	bh=E2EDG6e7E1HOrhGCm5ge/wOxqVvEJkTrwXvXG19O9sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUh+SXpMdkTYXWZhGyXg/k4kYtuPdFFBz5SQBR/6JOSimiOg5+9fLic048EhdLm1/zSFuUBx97V7r5dW9W6E/b/2LuXk495/gLPbh1r5BU9bC44Z138H4H43Sc4htbrfOC+c8cXH1i/IiirT57QWOaDKn1RFx4Iddm7EcD9Hiyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0ISpO2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69225C433C7;
	Sun, 24 Mar 2024 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319852;
	bh=E2EDG6e7E1HOrhGCm5ge/wOxqVvEJkTrwXvXG19O9sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0ISpO2Xq03ZxKKGyR2wyFi4NVu6/a4WAGBdRMs9OB37HSoaR86qVV+9ovVXrn2WO
	 x4W1nwDftULrjYnPD09OVixJqO/0n3k2tH2/zhhL+JJ876Crza+hKJ6TgHdBgo7u7F
	 K60G8Rf9JoTlPYG6URPod/lekcJ1c7IsVWCOmhSpZpBRRCSWTjJ61AOA3YigPCBqwH
	 39R7sagSE3qQaSBTFxQewITgTirTiDGb4ftJCaYBBWvHfg+UNotCFSEE0igY4QPa0Q
	 +iRwXbSfJ5TIUHpcLVJ3wMUzy6NwmutanrMgRuSfa2K/G/R+3wRr1wvspzlAPH2prg
	 XLC3QluVUtLSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 155/715] arm64: dts: qcom: qcm2290: declare VLS CLAMP register for USB3 PHY
Date: Sun, 24 Mar 2024 18:25:34 -0400
Message-ID: <20240324223455.1342824-156-sashal@kernel.org>
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

[ Upstream commit acb94d67f5a23dbb2e0021b6c30609ed05d7d6a5 ]

The USB3 PHY on the QCM2290 platform doesn't have built-in
PCS_MISC_CLAMP_ENABLE register. Instead clamping is handled separately
via the register in the TCSR space. Declare corresponding register.

Fixes: 0c55f6229bc3 ("arm64: dts: qcom: qcm2290: Add USB3 PHY")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240117-usbc-phy-vls-clamp-v2-5-a950c223f10f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 0911fb08ed632..89beac833d435 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -442,6 +442,11 @@ tcsr_mutex: hwlock@340000 {
 			#hwlock-cells = <1>;
 		};
 
+		tcsr_regs: syscon@3c0000 {
+			compatible = "qcom,qcm2290-tcsr", "syscon";
+			reg = <0x0 0x003c0000 0x0 0x40000>;
+		};
+
 		tlmm: pinctrl@500000 {
 			compatible = "qcom,qcm2290-tlmm";
 			reg = <0x0 0x00500000 0x0 0x300000>;
@@ -690,6 +695,8 @@ usb_qmpphy: phy@1615000 {
 
 			#phy-cells = <0>;
 
+			qcom,tcsr-reg = <&tcsr_regs 0xb244>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


