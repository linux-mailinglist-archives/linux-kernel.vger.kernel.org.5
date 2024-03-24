Return-Path: <linux-kernel+bounces-113100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071D888175
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B999288153
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E915531B;
	Sun, 24 Mar 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFzysawy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DAB1552FD;
	Sun, 24 Mar 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319908; cv=none; b=Mo9YRukFtum8PC+456PyjjHh/ndzvEpmZ/XjaU4z8TaFL6lKUp65mI1OXLPO0b5Mib4RodH0Thgrgl7F1WlCwLaavRLWAZYkVsvNpiv2oR7TdjM6CW2Lp0dcfs/W6fhNsa18zijtbH4877ca0N5C041caTF2h//zE+eXgrIQ2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319908; c=relaxed/simple;
	bh=cfMRW/npnSb3gZVTKDkgAfAeDudw9+aidofO2uKEBmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVTEmtHNhODVjORM5DmzYim2C2WoXhHZdlSEAyPrSJPo9/MkGddKLVOY8hC3EoiANwDGPSL8UDCXtL4kdfy2Ur+iDKjD8j+Ye0hplzzYkNEIRvb7TguOi5uhUFjunSYjXAnHq3n4l/zJN5+jaOIy1elavmVXi2ZwDu96Tv7ThNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFzysawy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DB5C433F1;
	Sun, 24 Mar 2024 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319908;
	bh=cfMRW/npnSb3gZVTKDkgAfAeDudw9+aidofO2uKEBmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFzysawyeHsEsDEHIwtrq5z7Os5njgY8agCjZA40ICMxFOMoaQsc1naGaRo/4azj4
	 Lf07/NP8TnNnPljizbxBrZzEz8MRzhfSmWaMrKSZCpQufR7bRQ7vCbgWfY10hwSHn9
	 yu/Xn/IB4bjEojVRg9YddcJ8rIbFMe7rmgdCzoe5MWX6TKqsK7WeJSe9JFzNQVt6Ra
	 J26Q9WcExfRd6jzT4vsduo3GJqdYSrvI8uKughjhykigowf3wJ3rje+UkQk2f4qeXH
	 D070OBYIqlGG0xKhJzP4rldk0d8dQAX8uprsANc7FzATeKvgFpUtWtL9YEOvezqkP7
	 UaOEe3ovU0F9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 213/715] arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
Date: Sun, 24 Mar 2024 18:26:32 -0400
Message-ID: <20240324223455.1342824-214-sashal@kernel.org>
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
index ab6220456513c..1f517328199b9 100644
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


