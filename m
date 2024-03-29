Return-Path: <linux-kernel+bounces-124513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90F891927
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE801C23CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5CC143C61;
	Fri, 29 Mar 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrVpzndg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0681327F3;
	Fri, 29 Mar 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715276; cv=none; b=Frb/JQsqiD3+L+iZNRXwcSrgGcO2meVCricPxF7FrkSmk8GErzsEPGf75zvx7DY8pCeManejeI4Rnm+umCThw8F3IYc1v3kFwfNvfjy5C4l5iGomL/rX7ub5U95GITtoZYMlc+DU61Qg8V1SEn1Fq7099zvcnaUPW54x+URmCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715276; c=relaxed/simple;
	bh=my/elSpyjr/TnRLeoRL6MxnBmfoFrfy+xZT2hl4f2+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU6ZT9TgR6D5q0Mbat3CkiJv+P333ymC9KZF8j9VMqf3mju1wY2qjO63vQheQvvw+2cHgWKq5Trd7CluKaz1sZROLV85lY2TIlb/ql9Vez9iZElo0CPYKpHdLRwfjZkhntswL+O2p/OKyLtPaQOHXW9vGaOTBk6dBVZ+falzl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrVpzndg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB771C433C7;
	Fri, 29 Mar 2024 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715276;
	bh=my/elSpyjr/TnRLeoRL6MxnBmfoFrfy+xZT2hl4f2+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrVpzndgvu7kIXB4sgIzWbqqCXHwzfHw5nNOtFToJ1mEAbTyP40LBRegSXR5aviLs
	 jRbRx76IT9qfrKmm36JOU3YefopLQF1Dr2f9a/22Sf0Lv3DbipELWs6zS5wu+lWYSk
	 KHPiICbgiPhv8EOt01H/AaMPwlUTT8Gqp9wZhMaH343VzVDJ+DaaKGuWP5PLVCTn9v
	 DiVB8Z8B3xn1e3LM30eEMVKbus5BSCwOiikKtGe/JMChzPISXr3AqR9u6zD2GF9r8k
	 y/Xl9zU5/u94Xzo44fdENqHO5X/AvEoq5nRW7WLoPegdLW7KBsMOb9P/h4aQMj/Wu8
	 rqJxdX7mm2TvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 32/68] arm64: dts: sc8280xp: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:25:28 -0400
Message-ID: <20240329122652.3082296-32-sashal@kernel.org>
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

[ Upstream commit 61474b18e762671a69b2df9665f3cec5c87a38af ]

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240212172335.124845-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index eb657e544961d..5fca27f668a5b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1204,7 +1204,7 @@ &usb_1_role_switch {
 };
 
 &vamacro {
-	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
 
 	vdd-micb-supply = <&vreg_s10b>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8b..38351e8ea8b33 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2978,7 +2978,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
@@ -2994,7 +2994,7 @@ data-pins {
 				};
 			};
 
-			dmic02_sleep: dmic02-sleep-state {
+			dmic23_sleep: dmic23-sleep-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


