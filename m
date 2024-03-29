Return-Path: <linux-kernel+bounces-124835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE3891CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65841F266A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316431B6FCF;
	Fri, 29 Mar 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TweapObl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6B1B6FB4;
	Fri, 29 Mar 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716260; cv=none; b=s3iSizzW/ucHZyTwPdBuzmlbPQGhTCIxoShCyk1YDVs8jZQdOcCwnsTuzSnI2V0uZcltdr24kBVvs0dRQxASgGgDao6rFdJZgh6GhJXfyM40zS1bMphK15hTlzL/aCfqo7EzUatJ3QywMWZGrICe93aX88skQdFEZHrahIQPj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716260; c=relaxed/simple;
	bh=MbeWrcMdf2eEBAMXOJ41Og82HMKLg9i/HDKp0mCLC+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRrm9fESS64Tan39qvxbRD/NGRnTm7xkED+Gh1e7a6E8QhJ9ZJjJfagcJwfdWJkdxAA8QcpLpNS8mvmy/O8x+RK2LuDcYc19qwInnCN94y7XPzwa4xKYRUj8HkmVQs3AC6v6W/Y9xbZw/Gb5+EprxjdWR+2QTW6w6z4NX226K+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TweapObl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D04C43390;
	Fri, 29 Mar 2024 12:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716260;
	bh=MbeWrcMdf2eEBAMXOJ41Og82HMKLg9i/HDKp0mCLC+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TweapOblx/dsX/MJv8IZKgJdwCAo3iRym4WOwrB+/V9El2SOkg7gvPMwSFq0UybmU
	 OY2CLFtOVNsRPYTnlqurKLlLlayK5Lxc2GGFHCqfxkKHQ6OmTp3pJPqq8amHfDWSMZ
	 M+9XWop5WPq7rGR/GzcWE8zKNVtTk5AGUXgm6GhgNPGGaFrxnMq/kWhH1lEyJJT6Rl
	 xNXLeqkgBlsapiDb6MhUmH7F0XKfJY3pBWpKq0DICvBcWqwqzc0XqrL5JI4O6+hvpX
	 bt4rBYQ05RyGDneDa+w8pwriXfVbQN2JKmhHIfBv+QWd5wWsihXDfN43ve+v50pd5t
	 uZNRhU4sDPU8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 26/75] arm64: dts: sm8450: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:42:07 -0400
Message-ID: <20240329124330.3089520-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 0d3eb7ff1f3a994a5b3e49a9bd48f0c2f3c80ef5 ]

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240212172335.124845-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index bd5e8181f2aa0..c1f58449f08c7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -1129,7 +1129,7 @@ &usb_1_qmpphy_usb_ss_in {
 };
 
 &vamacro {
-	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
 	vdd-micb-supply = <&vreg_s10b_1p8>;
 	qcom,dmic-sample-rate = <600000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 91d856e5b06b5..77c90b3c616b6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3755,7 +3755,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


