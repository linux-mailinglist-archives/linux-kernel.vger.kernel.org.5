Return-Path: <linux-kernel+bounces-113067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F85888133
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67811C215B2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792514900C;
	Sun, 24 Mar 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU96WHjJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FF148FF1;
	Sun, 24 Mar 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319875; cv=none; b=EiSSTkahxIpl2WH3UxCDoH6bdwnmtUiIR0e2/d8/I3am42r4ITHwaUUsN/ZVD+FcNan/47qG/VuN3LZC0hsUBELuECsAvO1LXZUEwxa8Q1l7PFt3LN8dmI6QWNFKCXdxpcuPNyNy/j/dOCSITyXBl3oUpHv5LcWqhxtf71FPLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319875; c=relaxed/simple;
	bh=krVTbJ8AJBoOHI4fjxKAGFx/O03ugBxGshBY+MbovKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cA0e4BrouA8yYdPXVyhBlcphxtxL8SECNM6SsLU/3icu267r7wU03mWCAI6QQeExm8L/GqhtJ5ixJQCIXN3UeJo+Kclz3r85ngdgy5Yhoz1Jd1RBPFaK3H2HsJtiEhFEl11/qex7Nt6f1NPoWiwnVsUTkACNnPBsft8YvtLne20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU96WHjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B14C433B1;
	Sun, 24 Mar 2024 22:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319875;
	bh=krVTbJ8AJBoOHI4fjxKAGFx/O03ugBxGshBY+MbovKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BU96WHjJ5ZN39l0VKNNC1WFOFjlCgcx/J7qaiNV+IowasQ+PFa5XATU2GJV0oGdh/
	 8NATkuoS/xsN3quWl8Cv50fVmAmemO+hBh5ElvwW4GTAdncHThE9xmXvnPxf+NFIYw
	 8ncKAMP1tqnQxmFwN65UjyWQ2LpLF0TaU+SqFtI9RJ+527I0FOoAMgtiE2W/9u+CdW
	 u+bOfyoBKWCtOzC0RZFVe+ho1BmQWan57XPlmyV9fj+gLQCTUrnfDxn+kfpVYvoe1N
	 natcgctCUyKFWY8kA9Vue/9dlha9xvji9eZSll3VtmIS0C3RlRAKDra7lglnJyB+Cy
	 xgysZVyLz4Krw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 180/715] arm64: dts: qcom: sm6115: drop pipe clock selection
Date: Sun, 24 Mar 2024 18:25:59 -0400
Message-ID: <20240324223455.1342824-181-sashal@kernel.org>
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

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 7e3a1f6470f7243c81156d2ead60f87da1184225 ]

Stop selecting UTMI clock as the USB3 PIPE clock. This setting is
incompatible with the USB host working in USB3 (SuperSpeed) mode.
While we are at it, also drop the default setting for the port speed.

Fixes: 9dd5f6dba729 ("arm64: dts: qcom: sm6115: Add USB SS qmp phy node")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
[DB: fixed commit message, dropped dr_mode setting]
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240130-pmi632-typec-v3-5-b05fe44f0a51@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 4 ----
 arch/arm64/boot/dts/qcom/sm6115.dtsi     | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 7c19f874fa716..52f31f3166c2f 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -607,10 +607,6 @@ &usb {
 	status = "okay";
 };
 
-&usb_dwc3 {
-	maximum-speed = "super-speed";
-};
-
 &usb_hsphy {
 	vdd-supply = <&vreg_l4a_0p9>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index b627c473ffa54..d33763d092659 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1610,7 +1610,6 @@ &bimc SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
 			interconnect-names = "usb-ddr",
 					     "apps-usb";
 
-			qcom,select-utmi-as-pipe-clk;
 			status = "disabled";
 
 			usb_dwc3: usb@4e00000 {
-- 
2.43.0


