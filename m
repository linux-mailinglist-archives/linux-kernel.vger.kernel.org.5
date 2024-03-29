Return-Path: <linux-kernel+bounces-124748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07097891C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59A2288E74
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836E17BB16;
	Fri, 29 Mar 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxwSfVqi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061917BB03;
	Fri, 29 Mar 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716072; cv=none; b=aMOZB9ZjgV4Pa8s5nf12ET0ctnl/CuwcuWAHXevibT8gfM1QYnHHdJ2n4vleg49duwKN0+V9P4wP89/fTHCDNG/LYGjI2f+alyS7wwMpKc7io6f0vqzVJb/M6OQfCANF4Aw6QtRIRxBM53XjN/1jdoxDJwc577su9dhXE9bAGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716072; c=relaxed/simple;
	bh=PAFtxqD5hRat6aq2EUIy/ncAxJJmKTypFk4j+jhW128=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fykd7l5VefGwJiwTWVvEUnGm/DKVLOFm0W440WLA73PsRHu4/4ilQ3YT8d9WQ2wVsNtwDQJy7fBcdv4/7J9q39kc3mZ4l3mvdyGx2I49Q1M32EQRKXbUNj37jXcbVddzNUmVXi7jqaQtMRoukoCTK+4xODe/aEAFxxTxSupzOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxwSfVqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6184CC43601;
	Fri, 29 Mar 2024 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716072;
	bh=PAFtxqD5hRat6aq2EUIy/ncAxJJmKTypFk4j+jhW128=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxwSfVqiEPoFcqNPHaTCOtsgDjvzuAePQgXc3vNHGAu9+EWI9yEMWVSKOGQutsCFG
	 WFyDJ3/5MrBsrGcMZ320Ub4MifDCJ5Chyt+ef3zjW0qEWjw2uCTA6q2jZb1YFKdQre
	 8MrRavgziLX6Q4pMSxy7+PXIad39/1g05o/nKxwM8/X6fShFVjbpzjZ5xta/4wlqnG
	 d0X7s2i9nDlOYFGuAXuKa911Q1hyutor+dswrHe8SV/y7ZfkhLLN7JytniwYSg1iDZ
	 G3CsBj4BQ7fxK9unwCRlvVN/rF7fNqk3swruZ1JvtWcgb2bfgu//WZxIWWSHQfi46n
	 VGmHUzdXC943g==
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
Subject: [PATCH AUTOSEL 6.8 39/98] arm64: dts: sm8650: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:37:10 -0400
Message-ID: <20240329123919.3087149-39-sashal@kernel.org>
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

[ Upstream commit 94c312767160f0d527da035b9080ff5675d17f4c ]

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240212172335.124845-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7b..27b3917c13277 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2919,7 +2919,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


