Return-Path: <linux-kernel+bounces-124575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422A891A24
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57081C25452
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD3156245;
	Fri, 29 Mar 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSW4cUpN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252F15622F;
	Fri, 29 Mar 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715441; cv=none; b=rp+0cUay435kv12QEbxezz5t8QAiwEZxfEKaq0ppGGyKFk7j9Sm7uVZy3rPyfOi8jeKX/XCyYuESfShtZ/+XBeEkNwMjWaKReQV14W+IfhkFvy/CFCzjtKUTWcpwJJJ6yh2PytioX1bEsqykqaboqvkf4NL39EzRY78BuzK0IMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715441; c=relaxed/simple;
	bh=Zf9SH2KKIcmGWom4kI0psGsCEjWWApaXl+hwf9Dc73U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQhDSvtlKjc90Ng9yF5OyywrnnSEtqb98b9tz3vrwqi1jfVhYveA/L+lTswpThjiWheB5NiuYYQHXSyWSp2ovNR1Ba40zaq/+mHPQrqMgpnSJsUaYc78LWLzaBbIHAl9s7/5pWyFuoBASS2QSFLSi0ngsnHENlXVDtDZTKqN1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSW4cUpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA03C43330;
	Fri, 29 Mar 2024 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715441;
	bh=Zf9SH2KKIcmGWom4kI0psGsCEjWWApaXl+hwf9Dc73U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSW4cUpNqeGLjWL0CY1hAv46umDpHIKcINO8Bn2B9Qy0XLwsV7e0PZSptLkK5ZcHa
	 4dAtogs3x4pklHEtblqpbM7GFXJ+AxfoekAHBw3Aymv+watQnSsII12IWcElIum8OC
	 skInKoBWUgO/iYFSmf82Pi8p02kbkZ79ctumd102rOx8fA1O5j7e3sGiWcWu81VQDR
	 UTVttFrHg3ulieZmIjt9TzVLTEfMlX4U+O8TVzk2d6ye9KDHWI7R9OjAVaA5/varro
	 gn0iR2uJw84ez7IBiauLn0XfQ6XNiDPz6+zc6f2OM7pLPlhKuJJ4C4VStpB6LMppKN
	 FiHLVObBnNGhw==
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
Subject: [PATCH AUTOSEL 6.6 24/52] arm64: dts: sm8550: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:28:54 -0400
Message-ID: <20240329122956.3083859-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 076715ef09d56..48c7dcca62764 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2290,7 +2290,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


