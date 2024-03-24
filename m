Return-Path: <linux-kernel+bounces-112962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A11888017
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABF8B227C7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1A126F25;
	Sun, 24 Mar 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0DFw21T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757F127B6B;
	Sun, 24 Mar 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319774; cv=none; b=cpRvnrUWPHXTiPLWmivEE/B4KIq/da7SM9UFsBDRbKfakYM+y6X+tDlxzeLYBt/cVOn/qmLP/GbRfkXCPz/ODq1snaBi2e69AxeVFk/jFV/R0GsvewbIvh8bE//ywlE3S3/AcoT+EObNxwqvKD7M6PLSAXqES/EDv5ZWWHlcCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319774; c=relaxed/simple;
	bh=BVUOlcZ0kGNiaGpte4w8wppOTrP2rpZwLft9Jy2ZPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiwHIAL3vcXUnNznPKH4z/E8MQkjoTbLO26LMaJUv4n6aF2wM4eEZHzaKUfVGqyBTzVbL88VBkL6vY3qwv6NVUcCzow6L4fIdQ/ykfYO6J+o0aacroRohf6zjbUNUJ2+6WJoWyLwO3ezHtoHem0L9UkEgV+VeHxkVLC/fxT1Dn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0DFw21T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622E4C433A6;
	Sun, 24 Mar 2024 22:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319774;
	bh=BVUOlcZ0kGNiaGpte4w8wppOTrP2rpZwLft9Jy2ZPNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0DFw21T2V9vC7FcG5Guin2CxfW4Fr+mrVPcXISP7dexybbObQQIsA9u26W/3zolL
	 VRn0JFjjcua/MtkUh+bE0yLDt7T3b3jsDaOlhGrAQLfLL2yPi/ceddtzz5cq/IiAp0
	 l5Ble2PsBf0mI4guq7e8IT1yRVHXJ2XqmaWEuJ5PsJ6g3qhfG9T0+4TwZzQIH3843j
	 uxuPbGhDBF+qeqkydFaiIdu8bAFw3e+3bZSCRaPySikJM3CkOiWYdngsYUJbWo9MNa
	 /6XQ31el9F1JbtUitv7yDwYihRFuhFFvJJ7X6R4dXKwBEO92JQmy5GKAipEVIvSSQW
	 1NJG2v8VUCztQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 075/715] arm64: dts: qcom: sc8180x: Don't hold MDP core clock at FMAX
Date: Sun, 24 Mar 2024 18:24:14 -0400
Message-ID: <20240324223455.1342824-76-sashal@kernel.org>
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
index 8f7f5b74cdb9f..3bb9d25b1dec6 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2732,10 +2732,8 @@ mdss_mdp: mdp@ae01000 {
 					      "rot",
 					      "lut";
 
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


