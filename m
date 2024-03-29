Return-Path: <linux-kernel+bounces-124834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F342891CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF91C289CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F51B6FA1;
	Fri, 29 Mar 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAHo5odG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC31B6767;
	Fri, 29 Mar 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716258; cv=none; b=ZuNEg7YkAVgVBbI5a/uHzddcrS8fNJa18IsJQxTtxeE01gjNSRV8AF7fwQDU2ZMRUgjRIhsfWZ90mZ8go92VE3Y6+NocqKY4jpzZIgRUPbrTMnhNc09uC4WjzdIJIrGwNcYdiCQMW1j2tStP19bVXf1LncfdiDIrJUVdc+2+bNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716258; c=relaxed/simple;
	bh=3N9khgHtFIEgjgZuj7xDwjlZxq4GJFMytHxppSbxm08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XW6nsVKduIuHeZRcZwc7qk4Mtt6CsZaUmqzttaP9G+wfiKfADQEb4q6mLchdaa/lPNGZfHXKDu//VoG59ZAZJT2wuCQNuc5sNae8yM/rPg+7ZJYT9E4600ETXbtqgEnv7BsY5R5hwaD0vo9LiX+5MUvNoCKPBhihS2M7aaV+wOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAHo5odG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37124C433C7;
	Fri, 29 Mar 2024 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716258;
	bh=3N9khgHtFIEgjgZuj7xDwjlZxq4GJFMytHxppSbxm08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAHo5odGqdsot4NXkD8MWu1GPyKd5PYWmSkc/RvQ6lfBq21JCZcPVpIprBG6eHzxK
	 wjgbjnI1hh3KLU1mTbqhTdCtUERXFxhSWHE3QeHi+NlxTqcTmZHBMvIUPvUKpaIZxU
	 vv50DeKQV1tw1YiKzVoZBICD5aDOAWvTNra56gHYY23whuunLEzjzd6PR+ctrkVmiU
	 0C0e7b+0rKnZAQFLLME4jzn5ZAethjMCFBbn+hCfWVnmDfRPINYU+Wv2kJ9KBSNksO
	 xUaoY7vHRrUe5ZEVwAtjNIPI0LkJDVJnjtKnvrg4j8Nchw32sh2gUWth3SKwLgiSki
	 36y29ih+o52ow==
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
Subject: [PATCH AUTOSEL 6.6 25/75] arm64: dts: sc8280xp: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:42:06 -0400
Message-ID: <20240329124330.3089520-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
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
index f2055899ae7ae..4669af3fdb75e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1201,7 +1201,7 @@ &usb_1_role_switch {
 };
 
 &vamacro {
-	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
 
 	vdd-micb-supply = <&vreg_s10b>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index b8081513176ac..f4dbb69b4ff37 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2977,7 +2977,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
@@ -2993,7 +2993,7 @@ data-pins {
 				};
 			};
 
-			dmic02_sleep: dmic02-sleep-state {
+			dmic23_sleep: dmic23-sleep-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


