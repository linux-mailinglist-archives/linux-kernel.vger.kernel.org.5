Return-Path: <linux-kernel+bounces-28124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855AD82FA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357541F27710
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0577B156987;
	Tue, 16 Jan 2024 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx/uATMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07E156971;
	Tue, 16 Jan 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435190; cv=none; b=V6ChfOY1ljr2swlZ5xju48lxsxDaHt7ilTgJT/fQi+qD2nJMhW7mMvuLe31g8pT6UFMZP7gVjElaFKcsMGFkq/aTcBwqgkujHg+Ab4mYK7rhvYSMlLEz39qfN0h16mvh/0qvacLiHjy1MwMxl+rwfNXums3yDeoFI2P3inEnP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435190; c=relaxed/simple;
	bh=8Mu08XlxOMz5cmdJXOmnM9uzX3GDPwM8lI/R9syugXQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=l24WoRpqkjTclf/fmnw7KsVUZazOGvFOtdWtQeM0P98OR5dLS8XD1qB5t8MoBFMNP3qJGC5TegHvO5Og4484qCMHYtOSXkOAORiIaOVLSU+qebg/DXZarnxUfFaiyyOLMkjTo1CFUaNE6qIS0ReVB/bnWvuSLGnQecZojq7bMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx/uATMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675D2C43330;
	Tue, 16 Jan 2024 19:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435190;
	bh=8Mu08XlxOMz5cmdJXOmnM9uzX3GDPwM8lI/R9syugXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cx/uATMHGihxoCqFp8m0vgELzZhqGZtc6/1wY11g/TKDVajkzJnsQs+cjbJs3woSi
	 cr/35tjnPMaoVbYmwU9fOYFsxme+Zq3rZPVdWgTJYd6VCqIdB4K2aKMZwTHnewpzEg
	 /Fxjyipd99OhlKbvvFLOc0CXEHyKObSQ5xeX/BP4pY8VzqVcGPmVq++WVsXi0OXuOW
	 bzgyVGhKhtq4wwKA/zvHHVP4CkCpLr+YkIZvDU6vJ/H3FdmnBFmBND+sM/Kjn83Tir
	 D34fwUfjccvRmycmQq0gKHWlMOLKpRIuS4X3jBZm1Y6yvlpAR4tfNIsJS/F5aU1XV5
	 g90DjFHKTHoIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 36/47] arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
Date: Tue, 16 Jan 2024 14:57:39 -0500
Message-ID: <20240116195834.257313-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Mao Jinlong <quic_jinlmao@quicinc.com>

[ Upstream commit 9a6fc510a6a3ec150cb7450aec1e5f257e6fc77b ]

Add the inport of funnel@3023000 to fix 'in-ports' is a required property
warning.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
Link: https://lore.kernel.org/r/20231210072633.4243-3-quic_jinlmao@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8a7c65178507..fd9ffe8448b0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -394,6 +394,19 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	etm {
+		compatible = "qcom,coresight-remote-etm";
+
+		out-ports {
+			port {
+				modem_etm_out_funnel_in2: endpoint {
+					remote-endpoint =
+					  <&funnel_in2_in_modem_etm>;
+				};
+			};
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -2203,6 +2216,14 @@ funnel@3023000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
+			in-ports {
+				port {
+					funnel_in2_in_modem_etm: endpoint {
+						remote-endpoint =
+						  <&modem_etm_out_funnel_in2>;
+					};
+				};
+			};
 
 			out-ports {
 				port {
-- 
2.43.0


