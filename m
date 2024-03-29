Return-Path: <linux-kernel+bounces-124745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37412891C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9E2B27BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3F417AFAF;
	Fri, 29 Mar 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZW/7GTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89E17AF9C;
	Fri, 29 Mar 2024 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716068; cv=none; b=JqzBvH/ok4YJTGCBclCK1539SELWEbPWo7sdMaS8lXOKZacwn6lQGctlgTthhIuzmqF1HL0U2cPJx3Bi1Br3MkCxG+qSNsVbmJIf/2f7VyrGdxjXof3j1VtsG03YiIbhfmHfYIR8avjvRW+2wXiBMTCQJXfY5XJaFLuKciULESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716068; c=relaxed/simple;
	bh=my/elSpyjr/TnRLeoRL6MxnBmfoFrfy+xZT2hl4f2+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbRNBSjILuv6it0tosI/0BK2uhuDuiPckUev7qoWYZcyJfBlrtMFrhxRkeFUEQzvy64Fsjs+H8m1VJX3qQsmWolLLuhbPpQvG8KyXpJWyMix5lepQ4l2FRNVWDF7U8IWE/QL0TWVpSzvZE49CZXZeouZUczBbTHcu+KChUIIGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZW/7GTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89734C43394;
	Fri, 29 Mar 2024 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716067;
	bh=my/elSpyjr/TnRLeoRL6MxnBmfoFrfy+xZT2hl4f2+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZW/7GTzmBXANUAWI7mIWXoUWsbOc0NPjKtiw1n6znb2kR51Giayc1pAfo+rAubdZ
	 tJIAhGdG+y76yy7Ux6/yQyLSaoYRbaaPuwefg3MdiErXZ8MlCUNE1zMTU1ChgcB6zj
	 eItZ82i9L8RotIDikxOklwEMZks+r2UhRFCtPL3+UXpPCmSBVl8FHfh6V5+/elYHHY
	 Ii5l6v7A/BwRO/tOsj6YTbaa8SNYgY1s4W8YYXCKiF8Vrv0eNDvQFTkldsNnF2h7jb
	 1DU39QEonsfEg5vyr3+ggrYGTbOqNKcrwiAjI2aDBvcuKUCrxgvD6E+hV4vamWaZn4
	 rKlBk7uWQG9ag==
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
Subject: [PATCH AUTOSEL 6.8 36/98] arm64: dts: sc8280xp: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:37:07 -0400
Message-ID: <20240329123919.3087149-36-sashal@kernel.org>
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


