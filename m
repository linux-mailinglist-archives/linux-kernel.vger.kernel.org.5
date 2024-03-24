Return-Path: <linux-kernel+bounces-113174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F2E88820C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C41C21F19
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73366175CB4;
	Sun, 24 Mar 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln7VZ+rH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87522175C9A;
	Sun, 24 Mar 2024 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319976; cv=none; b=hiUbwklH0Tix21hskJCYy3wIl436oNaAB9L4rG4PB/RUN5+QZXp+rXGdGIt0EmIcmw8wWvA9An7dDGVuS5FzmSFqSe1PmzaGsp9m8Gguy+wNrRKgayWjszESEh5+YO7YE24HAYkRkPbTzePCtdA6USz1rptTK8x4C+G9RI3qmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319976; c=relaxed/simple;
	bh=puQb5c0VDCrUhJLPMw1yY8HRPfs5JtJz+AqwO2U7XmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6QsE3ZU3pe257VGp9VSsgdjoVveaszSTV6TVq/5p1FEq6lSnHEHLMWPmaLo6Rq5kCG2w+8VI1kmOAf5vL60W1gD3pH3LRZ8fsnrRmswD7rrpAttebdu6UNZtI6m+hQPe/GligqRqTaTB2s/VTYU2+ZJL+I2OtJkqp5qX7z70NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln7VZ+rH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DB2C43394;
	Sun, 24 Mar 2024 22:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319976;
	bh=puQb5c0VDCrUhJLPMw1yY8HRPfs5JtJz+AqwO2U7XmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ln7VZ+rHNud/3OCSu89VJ33V0bIBl9Pr6GM5XoaQpSdiDBkRFgKpfgU+sMWNIs0xJ
	 HujEwdO67aD4Pm0STxfGi/QknujGxvJaEwaIdX4GO5bLnbfUGKbyb7wFfRwebUlFje
	 8vn5tyUM0+wQLmlNmmJsVvfJDyvTYppyI1nbuJkzb2YbyVcpx81le93ADYfy60uequ
	 1aN35ysZ3V25iAx3eSC4iYKQrqiTPjmYTkhD3uEH79bjhajRXKkf2oYRde7akrse9s
	 gi+xaWzP5LqPBXUdPL3jemdkFEgUFw1DuGBFhoAgckp6IhPm0+KdiOuhg8OokH/glN
	 YW/ebfjoeUBpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 283/715] arm64: dts: qcom: sm8650: Fix SPMI channels size
Date: Sun, 24 Mar 2024 18:27:42 -0400
Message-ID: <20240324223455.1342824-284-sashal@kernel.org>
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

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit a4f82b8045e3c7913266aa6ea1ee15752a062abd ]

The actual size of the channels registers region is 4MB, according to the
documentation. This issue was not caught until now because the driver was
supposed to allow same regions being mapped multiple times for supporting
multiple buses. Thie driver is using platform_get_resource_byname() and
devm_ioremap() towards that purpose, which intentionally avoids
devm_request_mem_region() altogether.

Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Link: https://lore.kernel.org/r/20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-2-72b5efd9dc4f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index bad0eb84549fe..0e4bd83b2c68a 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3705,7 +3705,7 @@ sram@c3f0000 {
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c400000 0 0x3000>,
-			      <0 0x0c500000 0 0x4000000>,
+			      <0 0x0c500000 0 0x400000>,
 			      <0 0x0c440000 0 0x80000>,
 			      <0 0x0c4c0000 0 0x20000>,
 			      <0 0x0c42d000 0 0x4000>;
-- 
2.43.0


