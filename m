Return-Path: <linux-kernel+bounces-114773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB555889248
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A0A1C2D546
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500431B883A;
	Mon, 25 Mar 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iENJbFK7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9052762BE;
	Sun, 24 Mar 2024 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323388; cv=none; b=eRT+y5Bn+jCF/GU7Vz5H2DcCtEB78C1uaGREvcRnFO7Xa4fKnFqY2pknflNx5y5TOdXGm8vPVQn53qy6gU4OfvYoALCukAh6Zpmd1py9Bpn94CbQq5TyenroXcRr+T89z2hWS83IwovaQ2qMgt8kLNvKAmTwxif7ZlpvkIzsvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323388; c=relaxed/simple;
	bh=pIl9FtZqut4b3vzp0F8W5d2QAW/HQiF2glpiPmUwTBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3N+TomN9zUCaNtL8YPdozVLByEvaLuc2Ch8ewfjpkgbKHa+EwJi6+dN7o+LSUPwfL7mPg9tGXgE5wYrSJZfhmSn2OAJr2+ureb5RV+Ij/+VsdW37E11OXWh17o5GE7vXIVjKFKzmoZ2hH8ybQtSm2pKSirwtuOqhsev5M5rCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iENJbFK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618CFC433B1;
	Sun, 24 Mar 2024 23:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323387;
	bh=pIl9FtZqut4b3vzp0F8W5d2QAW/HQiF2glpiPmUwTBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iENJbFK7PFHE0D2GfJw3Y/N5QFelPaS37E0AUrLUKhfXa4qPaihWcVOIMwvzJnDWp
	 lbcXAh0bYGZ672a/zpQXhn2P3bqqMmeubg+ge11k3hdzRoHUOdZ2xEceFYhyFqA15L
	 ZrVlxN7+eeDvTQp0W+kPIItNQIPEbKEtbQvcl/JiA78sKWhN2wXzrVsnmLRGXj6g+T
	 yeKLuO+Xjbg4YM9MwBgpqZV+fSRhldlvOOHYoX51y432OpXCCoWxdJZOhGx8yrcprZ
	 WfroISQQ0AGaRHCitWd/p3sAkqRt9X9IbjdrArwYVKgRUxQiWZ+VA/Jbo+gmBT70TK
	 3n7BQsgFGCi0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 087/317] arm64: dts: qcom: msm8998: drop USB PHY clock index
Date: Sun, 24 Mar 2024 19:31:07 -0400
Message-ID: <20240324233458.1352854-88-sashal@kernel.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit ed9cbbcb8c6a1925db7995214602c6a8983ff870 ]

The QMP USB PHY provides a single clock so drop the redundant clock
index.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220705114032.22787-7-johan+linaro@kernel.org
Stable-dep-of: fc835b2311d4 ("arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 6dbed85fa53e5..e1b744d76251d 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2013,7 +2013,7 @@ usb1_ssphy: phy@c010200 {
 				      <0xc010600 0x128>,
 				      <0xc010800 0x200>;
 				#phy-cells = <0>;
-				#clock-cells = <1>;
+				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3_phy_pipe_clk_src";
-- 
2.43.0


