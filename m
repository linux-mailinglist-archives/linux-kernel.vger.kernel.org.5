Return-Path: <linux-kernel+bounces-115408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE38893D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC5F296640
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CDB203709;
	Mon, 25 Mar 2024 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0wTv+zc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6082D7A;
	Sun, 24 Mar 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320586; cv=none; b=mH5l6pofw00HZaUNHDN+i21XW0adNdtK44vZ/qca0aKy0zJMN1YPUWJEu2YJYpNrN6Gss1ppmRfusRmfstHWVzW8iuFRd55nnsr5p0OhJaWFL3BwLRMdiVzZyBmIS3wubDnddwI/ecasRuB9XiQzm0s5hhiPmUdktTFyPy10WpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320586; c=relaxed/simple;
	bh=ZO59JFqtgl/T+PX6b6DMW9EVL6IiYtwpAYSt1odHLGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQdXoCv/Fd7T4KwinKeJ6ikRkJxCsV3s+c2O+woWOAX9OQrEaQky2kEFm/3mVhsxp9fx3NDANCKSaj7s72k/WPK4ECi/iL22zsCS7We13L9vyjhIowRduSdaGBmws/OzxjfWHWVxSrZQliBLK9E+ZaxfqsXE0tAJBxdhyF3TPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0wTv+zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1807EC433F1;
	Sun, 24 Mar 2024 22:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320585;
	bh=ZO59JFqtgl/T+PX6b6DMW9EVL6IiYtwpAYSt1odHLGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0wTv+zcsMiwjQelcZHB8qydNR0eorLc/LPXX1EwS0WN5T5ybWZ26IDxJ/vRfsvxP
	 9/NpIeOrwwOBW9R1BoiJT6RmguU8oI77VhD2CX055Hc9MRK2qOb4St5gxuGj6OlqCg
	 CXOP2FgBKNnOjlzX/oXjKFB0AIyNJ8KUskFWgi/pFJ4W971scFaYfUaSzouVDkgldJ
	 O23iSsVL3QhPpg/0t2BwRPnvSNYhJ/RjjPW9lLi8v1j7xIAbuT4JDZJ9HN5bUfB6G1
	 6gh17qsdLuEOwh4wV5pe1Hf2h96SUQCHjzn4yvQ6fIsJR29Ufz1RnVZYmwlnhmjgtF
	 CPWFn0eN561Qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 147/713] arm64: dts: qcom: sc8180x: Don't hold MDP core clock at FMAX
Date: Sun, 24 Mar 2024 18:37:53 -0400
Message-ID: <20240324224720.1345309-148-sashal@kernel.org>
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
index df40157f2ec63..687efe3404ce5 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2723,10 +2723,8 @@ mdss_mdp: mdp@ae01000 {
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


