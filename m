Return-Path: <linux-kernel+bounces-113173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF3E88820A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA121F21B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC2175C97;
	Sun, 24 Mar 2024 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgwspFE0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF2174945;
	Sun, 24 Mar 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319975; cv=none; b=q4wGAFr6bsTnXILdRBMhojt35gjgDTv9SpnFy/5WjP0vdkXLKEMNn7gdpwOgDPH6N5sJdL9q2oQ9ZjKy2jLA76V81DfehgNSua4JnipEMX/en17/zsElgZPchViXgsSCHyuC+eriX5ryV0G4ViwOxnWb7WccUnkDeRqUFPS5MAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319975; c=relaxed/simple;
	bh=syZ7zM0ZQCpE2wuH6W5pZKG769FBlLja+iwHGtXJ1Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcQMsOIwV33Vf0gJ6Wlhstb72gQl8h29kqTlSAoJCPoaxaHTJ5CbTsvYt31QHHXOF15YH6XsU/0b1a1LMlmm+TE70gUd5c3Mwr/PJxu2uPztUyNvK8HtzWVNCH9BvuJFVgQHb6qaQDgkGgSt2lTLuA4hcihK0MOgCIdG/5X19pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgwspFE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C32C43390;
	Sun, 24 Mar 2024 22:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319975;
	bh=syZ7zM0ZQCpE2wuH6W5pZKG769FBlLja+iwHGtXJ1Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgwspFE0k2R40Z8fdN1q+enl9S3XYs/8igsXhwuEJG2FpPIrXd4baHj6qmA5wJakk
	 bYtkSHujcJW+rCgu75pbYrE3A80z49SyMXwAJVbZtjndhttVAL8lbnP2dcgDCAH7vL
	 QlMZhk6IzwQCeq4fHGb6MlZrWRbC1EGK1AkAk1Ya0JdTBF6csSfyTucMHGD0iemC7o
	 Bd2jBtUFc0HiH/xqqa5MDWOA96Z1kJNwEq3NE0aULjaBIvc67fnnKs/m2TygyP47hE
	 XJ0/uglhWA2YFNnbzQol4j8R2qVKaSD+GDpzeGZcejZi6fuWUJgoSSpE+kJk0PTpSX
	 SxKY6Z20FTC9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 282/715] arm64: dts: qcom: sm8550: Fix SPMI channels size
Date: Sun, 24 Mar 2024 18:27:41 -0400
Message-ID: <20240324223455.1342824-283-sashal@kernel.org>
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

[ Upstream commit 77dd1e50ffcba33c3195ae4fc78f354368ddacb2 ]

The actual size of the channels registers region is 4MB, according to the
documentation. This issue was not caught until now because the driver was
supposed to allow same regions being mapped multiple times for supporting
multiple buses. Thie driver is using platform_get_resource_byname() and
devm_ioremap() towards that purpose, which intentionally avoids
devm_request_mem_region() altogether.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Link: https://lore.kernel.org/r/20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-1-72b5efd9dc4f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc2..90acdf16b8307 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3248,7 +3248,7 @@ sram@c3f0000 {
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


