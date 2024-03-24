Return-Path: <linux-kernel+bounces-114184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF77E8888EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902421F2BCA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6A157E70;
	Sun, 24 Mar 2024 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2t0QHGp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6E20631F;
	Sun, 24 Mar 2024 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321506; cv=none; b=Hx5HHgsWZmUjbYtjde3qz9xKn93C0q6040bOrFz6MQG+/5MzBP0Z1RIOiTVxc6CcYiO+eOQRbcug1VN+9F3W4RDEwKzu6D0VGy+S+5QK4IVseAVjYjtTJLrYF9D2tf4SvbCt0SP2VlOsUpscG2Mi+x7XILLtridJEegEptY5MOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321506; c=relaxed/simple;
	bh=aFO4d3waUVIdp56vRLYvX2gEdfvS8SByBmZjjBuvnb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYSk/MiktlftwhTUabNhEhKSx3d0HjEKXNQ4GxNv7GCzxRngBWtfLB7j6l9cTYtcTrJqrT5hY+oarrnD0pQerw16qms59Omf+/EhGFin+GZwLwWFNJxwRljcjvZ1mOzaoSiX6Y7jYURVnNxigsuQcW7Jmp/ZYv85rsxwc0l8PBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2t0QHGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAD2C43390;
	Sun, 24 Mar 2024 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321505;
	bh=aFO4d3waUVIdp56vRLYvX2gEdfvS8SByBmZjjBuvnb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2t0QHGpwGL8GA3XP+aXswY1itEKiFN2t1R03aKg1syvFr4EEgGX1utSBKk13+kDQ
	 CV0NUeznzjNnpzC/suKPRv8ca4lCaG97qRrReIrMIka3GZCQU/UO+uYC1RqdZsTA8X
	 QqTxyvIVhzTGu467ggxmxXH6AB4HEbkojGSGp/m4oYTtX6WRHOZpBJ7ePxHgIC5QJu
	 60MH3u4OJoRGDDKjBN3M5lqoCQmG+EjVl+E0tkmnZEuUT1fBsSakiBAvaaVAEOaWPB
	 aG4gNNCBDGYApEUmJ02VCxz17lE3kvzmOTcpX5lLT7LQnGFrQqzZzEXRueVqtP+N+z
	 Nz4vg9I5Ty1Jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 231/638] arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
Date: Sun, 24 Mar 2024 18:54:28 -0400
Message-ID: <20240324230116.1348576-232-sashal@kernel.org>
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
index 7e7bf3fb3be63..0a891a0122446 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -580,7 +580,7 @@ &mss_pil {
 &pcie0 {
 	status = "okay";
 	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
-	enable-gpio = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+	wake-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
 
 	vddpe-3v3-supply = <&pcie0_3p3v_dual>;
 
-- 
2.43.0


