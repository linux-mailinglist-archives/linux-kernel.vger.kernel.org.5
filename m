Return-Path: <linux-kernel+bounces-112961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B0888014
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE521C210D9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702D127B5D;
	Sun, 24 Mar 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRH+1Yol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0986AC9;
	Sun, 24 Mar 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319773; cv=none; b=RTr9yQQeYMqbYB1OSqQAmqQX5dGUyzRqBkmodmP807eKxwEShuZeHzCbOozgAqLB4M4ku3MNFqoB4KIMHpVJz7T0dPb09XLdEUO87NBz3nbc6urQlted3JaYY25Y69zbBk6XwzsgossCIt4lsARpWOEydSf58bZEFzAr8j6pqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319773; c=relaxed/simple;
	bh=U/7ozjVEdbXt7Kzw2m1O4hRYL7yDtZq3zrZBCHN1xno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIXzAybARWLYGONX+DdsDKk6l0I1/AL5ggsUERrVeNM81B4Ig0nxEBQ6JHtKz8spYdJQhyXW1+Vr0znujNTvSsEMq9+5yBfUKWZQu4ZuQsrAFl74FaUTRwVXpkH647DXym3x9RCNof7ERpeQbKW6FaRkbPOoH2hNqP5OkwMpBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRH+1Yol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D473C433F1;
	Sun, 24 Mar 2024 22:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319773;
	bh=U/7ozjVEdbXt7Kzw2m1O4hRYL7yDtZq3zrZBCHN1xno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jRH+1Yol+5UL77b0Kfvjvee8wv4bSIsxOoMmXEvJyM+tZjpYKl1POM/vJ0qkQVliq
	 Z1SD9JSGzcS5/yuIOSF8QABj8+NTKxfT1AHh++7x3bt0/9Q3I0AJY2wcI6gbetAPdO
	 qNcLzcvWlyIJmF0acIm2cgeV2RYOBCI4D/y427KF1ACd6OlytA53VVupFrLTpX7twY
	 re17NCqVSaV2k3E+kgIsXwUCJolq1QbXM4bIQUnYUKbg1Si1I5cZDTNiP80FY398V9
	 KLsxZBMsHUgh/xLsJpJmHkedmWiPWhGl2D45OVLyPuIxkhIUdcAlzFl5eIkSrr5obi
	 /V6ieh4D6AiRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 074/715] arm64: dts: qcom: sc8180x: Fix eDP PHY power-domains
Date: Sun, 24 Mar 2024 18:24:13 -0400
Message-ID: <20240324223455.1342824-75-sashal@kernel.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 24e98cb3d5e2c86565680e00008a794b4eac0040 ]

The (e)DP PHYs are powered by the MX line, not through the MDSS GDSC.
Fix that up.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-5-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 8849469d0aa10..8f7f5b74cdb9f 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3193,7 +3193,7 @@ edp_phy: phy@aec2a00 {
 				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
 
-			power-domains = <&dispcc MDSS_GDSC>;
+			power-domains = <&rpmhpd SC8180X_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
-- 
2.43.0


