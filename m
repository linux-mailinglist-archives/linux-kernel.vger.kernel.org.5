Return-Path: <linux-kernel+bounces-124747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93568891C17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23132B27DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BF147C6B;
	Fri, 29 Mar 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB3bzVxR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B517B500;
	Fri, 29 Mar 2024 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716071; cv=none; b=kCUjwUpdD3073yCKcLb5ORlB4wKG38w2CfBSYX9rJVSTS/WIEu2rm2iBrbABILuLBBskey1grO2DCrh1fL75cJoRdToIt/0NWn2ERN0r4LEmdpguRh7e3BXRnTP5x0rFUm8Ij5qaeVuwOUGQYjwBjCcq4/9PAz+JBwPNju3kv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716071; c=relaxed/simple;
	bh=Kps7FkLHl15XxPJabm+dtUCA7YF7PfDf7FI2VXBD8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwXusfBrdIR3zoV+9u33uozT+OYOK7fPWIvlqbswduWypBkkPhSPJHx4Ha+10mhy19GCpfSwc1zN+lRAounUI2hClGOjJbe/N5R+Wgk87IGSU2K6NlbWtGoSKEeh3eMdPUzluI7NtpPG5vknHT/4LfZ6QN7C8YK1lOL8L2jjPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB3bzVxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CBBC433C7;
	Fri, 29 Mar 2024 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716071;
	bh=Kps7FkLHl15XxPJabm+dtUCA7YF7PfDf7FI2VXBD8Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB3bzVxRbJcsRStqM9IW5TBvu/o5Sqd+0hjKL4IZydGNjwmxg2ExSnlA26Aimdd4y
	 Ed/xTw242rGvcR86Gmf1MsCL4XgpUeJenO1PQZYhY+/XPA/mKCM+y3y2NUxQfE6MG7
	 5LlATcOYnBXfdm952Lexigbxt9LJhndEAdmPMj953G0u2CvMsg+WQKFu2qYo1xXb3R
	 U7BYUl8xZ3fBoraxaxHqv3zZQZpTo9GtFcxhiy+c83wlZmPFRJrM0yEZw3KG/zEj/s
	 evNvXq0N0kFSkbJ9yTGqE4MosfB6rie6yZbhC4upAzXY0Ya5nvDVHKWsv3IQpbm2/X
	 6Qkw7OlFkectw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 38/98] arm64: dts: sm8550: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:37:09 -0400
Message-ID: <20240329123919.3087149-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c6e5bf9278749eaa094dc944add747f10a15dceb ]

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240212172335.124845-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc2..a6663eefd3a30 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2507,7 +2507,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


