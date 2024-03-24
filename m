Return-Path: <linux-kernel+bounces-115407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC63889B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A322C3C52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD40203700;
	Mon, 25 Mar 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqcRYOs0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB782C7E;
	Sun, 24 Mar 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320586; cv=none; b=KhraUa2dV22tvAwOmJU/7QQccUziH9csANMUlyZ2kaBsxdNiu01CH6OGjGZToKLQLfbI6uK3avLdlEEkOgCm9kKbnssO2jjfP8gFmtG5U9vx1gvaCbCfos0+9TK4Klh1vFxoHSbeUOIiGjVCizYypBh8rtdlqnr+Sa7F2IFBgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320586; c=relaxed/simple;
	bh=PcFvhoYZE+ee2vGKAy5yCnMiJVxLRzXZE4mdK5yBUrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLpSrfZcHDlQxjwJ8Gh0Pz3NWA2lLLocGd1wQDsbH6JlHdYC7BL5iImAKXnsDRj4Jy6FgUgF/9+50c+15gO61HqNgoiaSLBUYv14OYF5yDF3odhsO1Cg4VKvsxCAExRAlOq5nxGoTLC6S0D+kAEyOCm7/yjtcb7r4hJZE+buaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqcRYOs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33420C43399;
	Sun, 24 Mar 2024 22:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320584;
	bh=PcFvhoYZE+ee2vGKAy5yCnMiJVxLRzXZE4mdK5yBUrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqcRYOs0eZNU93e1pvfgwRdryz8KMbTpfL+JuiH/Z4a8h3DXQ6Tu6k15KgTRNV20n
	 54cdfT/27qhT6uUS89LJfrYiv3JkZwjSmR5P8ICf6Fc/+aAKoRjQ1ZRUMiPmvuOjw1
	 /bF0bAWCSFQA0QAnAkTMB3Yroo6qP9x/Ry/tOEYYL6RriDVNUo/k9nq4b9mO+Hyvg7
	 KHkrM6RAZgp6kVdUcqOkoX5dsOfBlPdFjwt0mVeOhSVJHjYUXaCQDcrPzJ/1LmEiqs
	 wS22cVdfmuCVtEp0/Ft88IxynU2bPaq986do/YZPwcR/0OfDN0ddy6tqXmGWXIKIZB
	 tREUtyIOoe95g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 146/713] arm64: dts: qcom: sc8180x: Fix eDP PHY power-domains
Date: Sun, 24 Mar 2024 18:37:52 -0400
Message-ID: <20240324224720.1345309-147-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index a7acaa8ca6055..df40157f2ec63 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3186,7 +3186,7 @@ edp_phy: phy@aec2a00 {
 				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
 
-			power-domains = <&dispcc MDSS_GDSC>;
+			power-domains = <&rpmhpd SC8180X_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
-- 
2.43.0


