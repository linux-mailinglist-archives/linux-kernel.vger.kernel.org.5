Return-Path: <linux-kernel+bounces-112957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13488800C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C113D1F21877
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75D126F05;
	Sun, 24 Mar 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njofFJDx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9B86AC9;
	Sun, 24 Mar 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319769; cv=none; b=HAXutAfmWIDKOqqB/TrBqC7b29tnJK8mSOGD5/lnXYBsc3/Q0jGcgqOUR1ljDuUINgwXQ8mcWQKmLCm/LTDFX0VxF6juAPTcvH3Mre1QaJZ4uh+C0wIvGWgo126UjZTAV12a7jYZtTxpTHwd6xtGfjBJZ0Xo87KfhOsgzHAqi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319769; c=relaxed/simple;
	bh=OEcpBvYt6RTe0MaBpB3+cd6RgldMLzd60t+NxZBffJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1sk+1nFYRf2tQ7n51mgkuxLnf3LJh0juu13zWJRW3xCtZhJMW75a1zTQP0ZsfqtKlPmufY7y7kDRKvp5Su6Id0tKObtqH1kWv0EeUXo1LrGxRHDLVzuqZ+CXc+pVwuxRAqoW4gpI6KjOiEqikf4qz4FNeJ9k3PO4L0FoLWvMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njofFJDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E532EC43399;
	Sun, 24 Mar 2024 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319769;
	bh=OEcpBvYt6RTe0MaBpB3+cd6RgldMLzd60t+NxZBffJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njofFJDxA0G1g+BKS3LGTNVxO6Yca/UEGB+S7cTWDD1pEi1GxlQdJ8M/oKkNQulEN
	 4b5gsehDG7WswVtkftgSwYotDHdW0O4VE89ERrwx7VM1eFa7jfxeWr2pRfkjYiCBnv
	 DqOF9kzK7025/ugr8tg0WRgL/SDZ/0VGhirWyvYik8g+a6Sf1rWMt9nXAnbtAGVxec
	 hkNVkh1XGqJqTVADju/upyybZMPEqOPzE9Q+Y1vhJIGGa+I3VALVqenSLpM99MnkR7
	 jwe4+0nmLrDuKXD98KPUx4m6yRiIB/8JDGPSah8+r59y3wL/rm3xwF1IGucLZComjk
	 Y5muJ5AnuHYAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 070/715] arm64: dts: qcom: x1e80100: drop qcom,drv-count
Date: Sun, 24 Mar 2024 18:24:09 -0400
Message-ID: <20240324223455.1342824-71-sashal@kernel.org>
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

[ Upstream commit e81e86765f957f3c5d48df9e275c527bd8c14156 ]

Property qcom,drv-count in the RSC node is not allowed and not used:

  x1e80100-crd.dtb: rsc@17500000: 'qcom,drv-count' does not match any of the regexes: '^regulators(-[0-9])?$', 'pinctrl-[0-9]+'

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231218145050.66394-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 6f75fc342ceb3..be1285d9919e0 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3315,7 +3315,6 @@ apps_rsc: rsc@17500000 {
 			      <0 0x17510000 0 0x10000>,
 			      <0 0x17520000 0 0x10000>;
 			reg-names = "drv-0", "drv-1", "drv-2";
-			qcom,drv-count = <3>;
 
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


