Return-Path: <linux-kernel+bounces-2666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D9581602C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07605281980
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5D45BF9;
	Sun, 17 Dec 2023 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="DQG1pI4D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963044C88;
	Sun, 17 Dec 2023 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1702826610; bh=qPu+3MGKmpA8cB1TI/AWPRME8L11HdiUsjw4dCTJzEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DQG1pI4DwVX8pxm50vijFX9kWoJ10XieG1yUeLPzO+XVxRxPal/BinlLq2f56eAgD
	 gvF2iHEAwrXfRzckd3p+srlz37jOelfySO3IF7Fn+M3WIW9QtcyNN7RykxHrLBpeIy
	 ugtk+XomnGUCKa2BoHcL/z9PXyHFxDProPro+W3s=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 17 Dec 2023 16:22:54 +0100
Subject: [PATCH 2/3] ARM: dts: qcom: msm8974: Remove bogus cd-gpio pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-msm8974-misc-v1-2-bece1ba2667d@z3ntu.xyz>
References: <20231217-msm8974-misc-v1-0-bece1ba2667d@z3ntu.xyz>
In-Reply-To: <20231217-msm8974-misc-v1-0-bece1ba2667d@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Pascua <pascua.samuel.14@gmail.com>, Iskren Chernev <me@iskren.info>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=qPu+3MGKmpA8cB1TI/AWPRME8L11HdiUsjw4dCTJzEk=;
 b=kA0DAAgBcthDuJ1N11YByyZiAGV/Em+hEFtVdeT7BLjKobhvRSGLUscyX5ClNbhOXP3LHp4Vw
 okCMwQAAQgAHRYhBDm60i8ILNqRuhWP+nLYQ7idTddWBQJlfxJvAAoJEHLYQ7idTddWkasP/jxx
 qbnkqGjEpUGAxRvF9ddF6zPKfxEIINgPo3eMesP4PHZ6Rg8cKEyIPHwrzGFMb+0KUSDjcJfx63v
 XwkSHttKObLbhvwbrQ7TQ6wJtXJ9W5/OAQjyovxAc2zKNsSXVRdRsKQCvLef6WSrGiK1A2ekEqb
 psqLpOa3bemV/4ldTvEfl8ImntLjtNxfYLQ5VMRFi9MNn4L/3AVt2fcOCr34G66XBjo5bqECEGe
 oEqF960bOSNREzGA4QgK7dGUOx2YBGZdAIXhaQCnfdaWXKEDeBsjh5iF09Jk4KzSyzjIhVFjBJR
 Q+168CMLO3p3B5c1eeazN2/5SEAGL/3IiKU+ODB94HUwg5Ux/j3qFpSiMgjaI6zMh5miRJL5M5D
 NtNQi7OVv+gBPP685ArjLkKzDa5iPM/Tk9+/JDoxxfyVJXJRmn+urVqTwaL0AYooY8PqEyUR8zY
 U9qujwjE/VbPfMv76BPE3+l4Op40WEAKGs/eEAeSVDjHA/pbg/O0LAyieDPk7UMLPuHEQfqXp+0
 QRSjWWgTViMvcXCfFuC6F3LnWCV5FdmTknAXQZyPpBoQ6syJW4ia35WcqrNHZrGHS+ng04Bzcwy
 TeQpOhY9ronb5om5ThgDftJkdZGDtHkmcajPl7H+TRs4pATQm477upGn+1ABFxoXwu9ftgYypqM
 9xLlE
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

No board in mainline uses GPIO 54 for card-detect on sdhc_2, and this
also causes conflict when both sdhc_2 and blsp2_uart4 are used, such as
on qcom-msm8974-lge-nexus5-hammerhead.

Fixes: 1dfe967ec7cf ("ARM: dts: qcom-msm8974*: Consolidate I2C/UART/SDHCI")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index ee202f3f161e..b1413983787c 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1641,13 +1641,6 @@ data-pins {
 					bias-pull-up;
 					drive-strength = <2>;
 				};
-
-				cd-pins {
-					pins = "gpio54";
-					function = "gpio";
-					bias-disable;
-					drive-strength = <2>;
-				};
 			};
 
 			blsp1_uart2_default: blsp1-uart2-default-state {

-- 
2.43.0


