Return-Path: <linux-kernel+bounces-115892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A636889885
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAA91C31D56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0C38518E;
	Mon, 25 Mar 2024 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA4uoB1U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D031474A9;
	Sun, 24 Mar 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322085; cv=none; b=GtUzuaSbN9a+3TDFs9eMgnbVgCUYaOHetA/W0h1cUolc/+2X+ondSSwnLSohUJTsIa8XjMbtqxrQaK+7Md8VhqBHITe5lK5mbWT58QR9S7HBHgJ0zTWbRDZGpD+mGzq6bBdM2iODDvrf6f9aTpVWR3aVdMZWmNQoUyrKWqgAbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322085; c=relaxed/simple;
	bh=KAHO7zjgVIVu6W25Q0ZwuI0wfkUUhs8BewBCkPDZx9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwdwGpDBvdpvruGaNpOpVS5OxvpbAdtG6JvG9xJTAomKYUdjwEr1RqVmfuFO8owiMXGtr+JfyROgrrNxt0OJyCoDqzbhWnuLF6jBpWU+Qe/jfaHuNPWQn8wRbE7yoigBKz1O+FNcEimnVdQCTPg+ulL22fJFavZg4Kra9vUFMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA4uoB1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FADC433A6;
	Sun, 24 Mar 2024 23:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322083;
	bh=KAHO7zjgVIVu6W25Q0ZwuI0wfkUUhs8BewBCkPDZx9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kA4uoB1Upyson1QPTNah1Mtu0ijQcA+nhBG9U74XqKIrDcm8QLBBA/TJ2fnNB31/h
	 M6WjHXv9JRHJnJRT7CT7b+s6Ol5kGft5Kl588cv6F/8iAc/eeY1OlOretpiUvfWd0y
	 ZRO0RCBiE3jqgCB9fAe6qfCo3oKrwkxZYJvHTZ1eezlQHwaUhxnpeSeSbA3PxrogS7
	 s6A7aDOr2osWp9D0ZlKDuwxJ71Y5GRYDRDM4pbFdh0ZuSHzr4PsKubhS9gByaSbzjb
	 /WCesb/zLdJmMnIlG/k5z0vxjrTqxBvqn++Ptnl+4ajHbktm3pxaTm1idEo8KKP4IC
	 SbM4EOUg8gX7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 157/451] arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
Date: Sun, 24 Mar 2024 19:07:13 -0400
Message-ID: <20240324231207.1351418-158-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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

[ Upstream commit 584a327c5cffc36369b2a8953d9448826240f1ac ]

Bindings allow a "wake", not "enable", GPIO.  Schematics also use WAKE
name for the pin:

  sdm845-db845c.dtb: pcie@1c00000: Unevaluated properties are not allowed ('enable-gpio' was unexpected)

Fixes: 4a657c264b78 ("arm64: dts: qcom: db845c: Enable PCIe controllers")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240108131216.53867-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 135ff4368c4a6..5c04c91b0ee2b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -532,7 +532,7 @@ &mss_pil {
 &pcie0 {
 	status = "okay";
 	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
-	enable-gpio = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+	wake-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
 
 	vddpe-3v3-supply = <&pcie0_3p3v_dual>;
 
-- 
2.43.0


