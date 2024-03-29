Return-Path: <linux-kernel+bounces-124516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98929891935
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A07287685
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0DB1448EB;
	Fri, 29 Mar 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJJqMmYR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A2134419;
	Fri, 29 Mar 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715281; cv=none; b=kcp4TknP9xSTuB/rUb3Q1Kc5cBfLcM4uPAcMiJoUxvdWXQv3hJfdz/+ARCTfudsinu8Va6C5duJwkktTc6l4PtZYOp4zNthT0mKRQxCdny2osibShwa5WpUoJC7Men4KSJ8w6bLlwc4i9VD+5i6Y6sTGAp9G7chNmye9lHNX4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715281; c=relaxed/simple;
	bh=PAFtxqD5hRat6aq2EUIy/ncAxJJmKTypFk4j+jhW128=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWDav3+pe+0fk3aGl5ZM5pCIAK+oRPtySDq/TV1CnkQvMLtC8DRzPgshimpR3OHsMDLtyI4aP3oaIn3BLw+UXRlNGFytg01oVBj3fejjcSH37dYDd4PBlCMOZbGm13zmmmX3hlGa7rmVEOts4Gs+q3VG0R24V/JrO5TgE7oAW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJJqMmYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB98AC433C7;
	Fri, 29 Mar 2024 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715281;
	bh=PAFtxqD5hRat6aq2EUIy/ncAxJJmKTypFk4j+jhW128=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJJqMmYRKUa80eLyNvGHZv0gNwWovWl2Puau8PDJObWh/eCSsIwtbXc9wqbURxOJo
	 1RHzsWDOtUBRKqT1aZstj8n+d0KE9f6M/PU2TeP9FWo7yQ5nAJ1rDeVpa/RjtW93sN
	 FiZSBvwJNPzKxEYxLVQw6k7EbC5/tJC8bBy3N4uBcI3cUUD7zqD0KQW/zlhvrG2cRu
	 3SlnU0qqJiZ4gBdI74QttLix/biak0a4ZYmcm+wKTUjL9yA3TgoveIxosLxrzURTWn
	 7qSRwljeDSzCGUPC2nH+Q/7erzIoM+LzC2XylygDAn0vpDBRyLTn5ywIDySbqHcREt
	 OzwrLqu+J46gQ==
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
Subject: [PATCH AUTOSEL 6.8 35/68] arm64: dts: sm8650: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:25:31 -0400
Message-ID: <20240329122652.3082296-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


