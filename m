Return-Path: <linux-kernel+bounces-113720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42F88863B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF0F292FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA2E1E85D5;
	Sun, 24 Mar 2024 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rinmN9dk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA01DBF4C;
	Sun, 24 Mar 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320703; cv=none; b=CW06je/JgAKcNCFjwZMXQP7gznA8zOXftmoHxUpsXSjxTunBB/mXwFyZRooCe6dZLfCiXUpQeKB6y73324ie9Qb63yrix0Em2HFUI0LBliQunEA6t8rW2tTeYNbaeETbPft0w4mGQ8UPZO5fGoM1s805DctN3Ed5R3DLlY8mjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320703; c=relaxed/simple;
	bh=aFO4d3waUVIdp56vRLYvX2gEdfvS8SByBmZjjBuvnb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jE/42wXEexWI+XraqfGAcz55Rm6DrmNvJA6ZSzzOKfzKEBkjI63MpwAiFZzRdCwicLJQG9nNPti/ifprtiDwiW7tAGqbB+GQ1yEXapKBgRFKNF47yiJHdVNGKbED7pjMvJBEe+VkBvoShVZmI8ZCkywI5D6qMJ3E+oL+wOTrzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rinmN9dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8E9C433F1;
	Sun, 24 Mar 2024 22:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320701;
	bh=aFO4d3waUVIdp56vRLYvX2gEdfvS8SByBmZjjBuvnb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rinmN9dk/Eb9Ih23ktdsj8tj9XN5Xpc6xO6uHuugVDyIHJ17mmoJW1ERWGXIi/afw
	 WgB6TT4CYE5Tadgs3pZsjLMu8CcKLFylGnvSV1mY7GycrHn+/s6kPU45O15wVRPatK
	 NSCAZ6F2PPsW7aiYdWhYuvg2o7fQFSsQTavZ3ajqL2wHLe8tslR2avjbQapzhpFEPE
	 Re2zbecK800Zuneanh7R2QZ8D7QhUGrpmwLiU5GRCjSySjW1b2RnHUmSFAruS6Sd/7
	 AGhc3k0ZveAdIgJ9sxPpx9ZTXSPen5bkOL62EL2luRTmUUES98E7ygJyB5/JtsAYr9
	 7y3lV/Z2fWUhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 264/713] arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
Date: Sun, 24 Mar 2024 18:39:50 -0400
Message-ID: <20240324224720.1345309-265-sashal@kernel.org>
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


