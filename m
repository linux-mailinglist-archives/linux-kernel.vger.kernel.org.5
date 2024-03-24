Return-Path: <linux-kernel+bounces-113101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710D888177
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A6D1C218F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276954BD8;
	Sun, 24 Mar 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkMmn+df"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299C15531F;
	Sun, 24 Mar 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319909; cv=none; b=f6dRVV2AZAdExLgeDB7heI2HRtR/Vlf/5OYTsUQPBJFWXh2pFRTGR5ImX/NdIU2Vy0cp+QVOWjdPhD4eb4gc2RyD8uTY2EhjdkcFm6Mw51OdF8VOls4fKQqH2yBf0RGHj/1w8P84rcKCqS2nBXxpjqSGMXuFxUKt1St7QsGvPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319909; c=relaxed/simple;
	bh=y1oXh9npTIO0O2nMld9d9/Y4lPp0t3KM/HN98aO+7WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeWeR72eayukFfa+Jbxv5ZVw3kq7aU1JQDFpwrohNLVaHVf932dB94uJQvE/20XiZut5chHfJ/MOGYLOvpPPTVaRHN5OVyOTdjSDgXJDeFsAhWboqsQFwVbtRZUF8rMVBwgmJqpuUMpUFr6y4utcqigZiEo9Cs9/tEI9n4Nw7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkMmn+df; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF3BC433C7;
	Sun, 24 Mar 2024 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319909;
	bh=y1oXh9npTIO0O2nMld9d9/Y4lPp0t3KM/HN98aO+7WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkMmn+dfAA/q35KUGkOVNICtuOn4N97jKiLrzN/rH5u/n/JySovJPCWQ2FJsGxn1o
	 xn+Btk3463MbSJvPmBSG2yu7xtdNAQZRjSv0TwQrGsaM20jL4HN4qpBeDUhy4tB57T
	 WWQCufHljxhaoz1V/rSAuG5Q5gvuOakZ44XlN5h+alM3JIEG4Hd8sxJHk8iscYrT0E
	 g12EU9b3EkVebzdEwgwCYatcg0CkI/LMjuT7uPYyWCS+PSSt0tozkPvXpQUyVgWZlu
	 gqUVzONHeQ+0D/G74mmNrZY+ygGajWTkrtdE6uqd0t+E5BuOJy1Ryzq1jNXDGsiAc6
	 0SG8CFwRv41JQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 214/715] arm64: dts: qcom: sm8150: correct PCIe wake-gpios
Date: Sun, 24 Mar 2024 18:26:33 -0400
Message-ID: <20240324223455.1342824-215-sashal@kernel.org>
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
index 761a6757dc26f..2abd4c87a3ca9 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1879,7 +1879,7 @@ pcie0: pcie@1c00000 {
 			phy-names = "pciephy";
 
 			perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
-			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+			wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
-- 
2.43.0


