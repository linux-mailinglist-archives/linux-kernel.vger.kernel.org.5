Return-Path: <linux-kernel+bounces-113722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC33888641
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3691C24B96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157541E9634;
	Sun, 24 Mar 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbudiNPf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD121DBF5F;
	Sun, 24 Mar 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320705; cv=none; b=clpeIK3DcUOSHg+sXm8Px0zGgZhGtbKBX8/xsv4re/1snk6y5HLJbJ8brZcMsKUb3SILCJpoE/ZH54dRb++Wxu38uOiVhoQvD7LXZuvB4IketvoE7qrByE5LxePd+ZKbdHfIMlySBMq/BoSbB9op5djgiTodSPSik7RTSaJMP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320705; c=relaxed/simple;
	bh=98j6jLoLgdzCjoiivLq8/nnY3kT0E7I8/IbXH8EktOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XocehRnZxS1NEAPSE7PoyjEEU3NwdWmbDhNa91N/8sXAoAgOktTuanof7B/S3PySans7DZpGAv+TIUcbHnk3Wdg3V68sQX4g9T67AYFBTmYbQMzC6NPGd02LmQn5ILms1APeag335Tkqd5BWPUGCDqsxLt9JGucQj0UvygApM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbudiNPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E246C433F1;
	Sun, 24 Mar 2024 22:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320704;
	bh=98j6jLoLgdzCjoiivLq8/nnY3kT0E7I8/IbXH8EktOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbudiNPfYKbowusO9sTJIcMpxM+6s2D0IWoE88DejySLspnxK3IP3KELrZFlusjwd
	 NlPZAe66ei+6kpltWe3V4pmHXLpC/De7t7UjjgidPEYLJs/nNCr+DInc6y9YRedydA
	 9wQNYm1ocbtRK+npEE1/vK1nVjegjgiKeziaUCd9IbBZdv/0K+CRs5nspia+6L/2gD
	 gxc+7vIklCs7/6d0QdS32CPVFQ5UXrUHroeyZdABueEaLxYePpiPvJYUT1JCT/4rd/
	 eFDAvJ6ESUA9puS69gJoousIwlxlZ/clU2d0KudZecCBXE9jLyW6qM0S6+IQdr1kmS
	 ZkRgqy3XznpXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 266/713] arm64: dts: qcom: sm8150: correct PCIe wake-gpios
Date: Sun, 24 Mar 2024 18:39:52 -0400
Message-ID: <20240324224720.1345309-267-sashal@kernel.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 7c38989d0f7a35c83e7c4781271d42662903fa8d ]

Bindings allow a "wake", not "enable", GPIO.  Schematics also use WAKE
name for the pin:

  sa8155p-adp.dtb: pcie@1c00000: Unevaluated properties are not allowed ('enable-gpio' was unexpected)

Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240108131216.53867-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a662f09fdbe19..2678eac1ec794 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1879,7 +1879,7 @@ pcie0: pci@1c00000 {
 			phy-names = "pciephy";
 
 			perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
-			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+			wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
-- 
2.43.0


