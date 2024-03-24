Return-Path: <linux-kernel+bounces-114185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A2C8888F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10216B25390
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ABD157E86;
	Sun, 24 Mar 2024 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3tvcFNZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24F206C86;
	Sun, 24 Mar 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321508; cv=none; b=DrUbzx5ouISo3PzYzpA9nZ7p/sffM3XMc8zXrg6BZJwbMdiheNBcOhmque4kHnqU/DkxZhjgVgYHFucFLbDX0r4PgOpn+ODk/iCpxTI0wwsKlgK+hp+VJule6y4RhUSHYMnaLDhwSasFSR8dS+x3YX3THa1eORG3BnlASdr6hbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321508; c=relaxed/simple;
	bh=9A8CvqHLodxtVSH/LLHu6eUeDRRB7EerJYiIkJtlK6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUsedg+6rNPsp1fpnBCXQuxJY4EYToKyLIQI+zizUfmudL8NiftHO3obzt9jRj7riI+9UiX7jH43sJVaRNIJ8F0BkcOi9Oet9OG47nhCODHSEBDpGVj1USq7oHJ/CYMOBV9DS88cENAnnlmsVNmzJX7IlFHR38ZS5vqNUgXViOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3tvcFNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63C5C433C7;
	Sun, 24 Mar 2024 23:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321507;
	bh=9A8CvqHLodxtVSH/LLHu6eUeDRRB7EerJYiIkJtlK6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3tvcFNZeNUBx7eoW4NBzdOrG9RWMX9KrBcN1UII5idsAl0MpjybOudQWCXM6rJlw
	 ClBh91+HuhNgtrQY7pBl7P1XYl4SBTmACUrKs/KfSDW0xm+EouQMvflMLD2Rd1R3De
	 iuBb2xLGYaNgqfv3wBQuf1F98YRJW0KUTPQu8VNxnF4BEHJxH+kyLOJ9DWNhFbCAqf
	 sD9uXHb6arU6fqTBeVVqFAN4fjCBgkqzN6AUqajBnvvVtpFIcR1N2cNd7c92VQtzEi
	 uMKE8yxU/IErmXiq0uWHVkPD4tGtE8avld/xErQ/Ge4OI64DokU5Ozcp4fuj7OqUat
	 8y2K6VBiZjyyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 233/638] arm64: dts: qcom: sm8150: correct PCIe wake-gpios
Date: Sun, 24 Mar 2024 18:54:30 -0400
Message-ID: <20240324230116.1348576-234-sashal@kernel.org>
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
index a3e801fe6fee4..73ef228ff2689 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1877,7 +1877,7 @@ pcie0: pci@1c00000 {
 			phy-names = "pciephy";
 
 			perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
-			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+			wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
-- 
2.43.0


