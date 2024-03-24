Return-Path: <linux-kernel+bounces-115642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B714E88945C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719EA28F57E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED99D34F4C2;
	Mon, 25 Mar 2024 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjosR13y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAFE20631D;
	Sun, 24 Mar 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321506; cv=none; b=F9LmQBoas8T/Y3bh2kRdpWDaE55H4P+B77jRt8PRddwCkHbD8VgydrhDr0UIwVKz6ghVbUP0vpDYIiqeKZotenuGjt3xQPNmZOtPqdY7AMCxt1hGAQXdphpGw++LfvG6owkSAS5Lun8XOeOxUjuycRH0qOgN8ZqueBQtuVGT29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321506; c=relaxed/simple;
	bh=0CTLz8Fm4sY192CSbsLXhOLCqVFdR9OCNk4bsnybU8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNqTAzQ3m26wLXEsp4xUjG0M2WEV813Diybx26AAxl+8fX4ul+0lYrMXfYHZq6rATbVJvMscnkur4Fj0knOoJl1dwiWhC1ngLPVvDSDAUtbQTMrQuVNynWBsA4rngufjJMUzI7tMLkz5O0knDHFPYltj70IBZ+VtzY0ydWbxYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjosR13y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B37BC433F1;
	Sun, 24 Mar 2024 23:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321506;
	bh=0CTLz8Fm4sY192CSbsLXhOLCqVFdR9OCNk4bsnybU8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjosR13yLdErvVx9CBFaInUsdWtBRDwFiV9KGdJ3SmK+38WbpiclHpua14xgxTtth
	 JbAdY794MZEshqFgh0ZOOhcQZSfnL3+Ig721qEW+9RNqclfkOIPFHOLgA2Ck77D13e
	 rEJr//4Tf4cz3vOdjV3Llt7iojfyU3JH/J+R8oxk7RTWvPYPJNedIp4L4PYbbHLe6c
	 i8nnwTIuF5zCg0av4nzejorn8s6HOGr1dqcLQxIDpf57sKyT0P+6FSBLf/xB5QH7Iu
	 BKTapjayRdkvlg72fpY+RmQrk9PZ7mDtwJPRmUOLnQvtEwL6nwt9n8ijRh+BJSt85C
	 FtGbLGaz2j1Ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 232/638] arm64: dts: qcom: sm8150: use 'gpios' suffix for PCI GPIOs
Date: Sun, 24 Mar 2024 18:54:29 -0400
Message-ID: <20240324230116.1348576-233-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit af6f6778d34cb40e60368e288767f674cc0c5f60 ]

Linux handles both versions, but bindings expect GPIO properties to
have 'gpios' suffix instead of 'gpio':

  sa8155p-adp.dtb: pci@1c00000: Unevaluated properties are not allowed ('perst-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231111164229.63803-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 7c38989d0f7a ("arm64: dts: qcom: sm8150: correct PCIe wake-gpios")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 26b6d84548a56..a3e801fe6fee4 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1876,7 +1876,7 @@ pcie0: pci@1c00000 {
 			phys = <&pcie0_lane>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
@@ -1978,7 +1978,7 @@ pcie1: pci@1c08000 {
 			phys = <&pcie1_lane>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 102 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tlmm 104 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
-- 
2.43.0


