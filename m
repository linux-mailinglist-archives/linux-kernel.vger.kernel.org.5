Return-Path: <linux-kernel+bounces-114102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4BA88886E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E070F1C26BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49623B46B;
	Sun, 24 Mar 2024 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ/1Mf6o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01317201269;
	Sun, 24 Mar 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321406; cv=none; b=BjGR8eME0GmxNJ55CvOp639TBOPqhE9O0G5rzEGNyZLPcLukvAIyu3/hcnIC1xbZfc1qQ4kSnAzgrGSuXxCgO4XGpuKCMD0enZ/3W7hxCfX9ZxY+EHiv+mSsCokbOye1Vt9jKdnF/WC93A6wcFrbqVh6tsUfCSMR84g58J0zfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321406; c=relaxed/simple;
	bh=e2XEe/34ToubMn1TmZNWy0dLXvUW5KbYYFnCoLGaG/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAdxYDQqlgX9x6gk5smYnN8FxQA8i8h3hyZsrr8cC4HDGvNujI9xRfOPygOnyZfSHihO34Emw+Uvm+bsuw7LHNPs87vCqMtLTAKcxnywuPsLmiK87ZGMvOVIxvOey1/pZMgPiHNWUx7DXS/Jc21oYq0F+oZrvCs9GNdW53jNmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ/1Mf6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A1FC43390;
	Sun, 24 Mar 2024 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321404;
	bh=e2XEe/34ToubMn1TmZNWy0dLXvUW5KbYYFnCoLGaG/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZ/1Mf6oAzOKYniPGtp45HsX4YgoHnivuG8amj70gtUZrEug8klrYNjaJ54nwNeWp
	 38Ncob9Y5fManhZrp//KJll3qpICMxtCXpW92qHeG9IijBg8lq40sk7BX89tA2+b7n
	 +ncGiVKrU4ltbyebM7njAWL8dh3K3TiPWqvkZKxXxqhFr2jN2ioxIbTPPf0fy8z4cE
	 6dIVjOQ6qTvcwsIvVA5fNFsxNtg245RWxJ1oh70rABislRibem8vcsiZ03WZYUOYps
	 IqqUMzll0sCijZz4goen4rUnQWu0PxoyLxx8j6y83XrvN1oEwHJWGy558VE6QKNhmX
	 dKbibK7fNk+pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 129/638] arm64: dts: qcom: sc8180x: Don't hold MDP core clock at FMAX
Date: Sun, 24 Mar 2024 18:52:46 -0400
Message-ID: <20240324230116.1348576-130-sashal@kernel.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 309b5774f45aafd002efdb2656673542419abd6f ]

There's an OPP table to handle this, drop the permanent vote.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-6-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 548dbeaf823e4..5ef7500004896 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2731,10 +2731,8 @@ mdss_mdp: mdp@ae01000 {
 					      "core",
 					      "vsync";
 
-				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
-						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
-				assigned-clock-rates = <460000000>,
-						       <19200000>;
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
 				power-domains = <&rpmhpd SC8180X_MMCX>;
-- 
2.43.0


