Return-Path: <linux-kernel+bounces-28171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961B82FB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B171F2ADFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0A16089C;
	Tue, 16 Jan 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXNYlNXO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FBA160887;
	Tue, 16 Jan 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435335; cv=none; b=gw7gnfqgxD5lHiarmJJW4V2HtcoBsFnLcwdWEIBe003RnFi8ev3ygapl9CFiOdcRyFgGnSKk9BKuilbNRHNFD/MyUclsFKnOpSm7Sgw3Nt/Yc6CcsUhYtvLfgmfLaUR0I9Prok9fo+ywh+TZ+n66BfWRB8C9NiFiTgdld4+QAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435335; c=relaxed/simple;
	bh=5RPEMoF6hNrpIcui20yP9ZheIMEanOO89jHbvBiXaY4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=D54XtlFNlp8RIIzroK5gVohSxzz/oy60jZZfePG3Sz2hsJpBSdHdpgGawe9rZ0Ts0xSv2JmTojnARyOKDU8PjuDFscYeztgEbQSrf8MJE1/3uCDpkJK3Fqwy+WCkftfGV4QKvyC0UFZcgqA7YX9Q/zPtcdFen1GN4hLJCsM+ZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXNYlNXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AD9C433F1;
	Tue, 16 Jan 2024 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435335;
	bh=5RPEMoF6hNrpIcui20yP9ZheIMEanOO89jHbvBiXaY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXNYlNXOeExn6w/ed0SR9c5RzLecrBbbtWZrsJ2QRXiG3frircc9toYJQ4WsqJH8n
	 X15/aW9/R2pyMWmZhnjrASo0S0bZvVNVvxlcUSf8OT7gFU6ZrAiac27RQHPV7zzoyt
	 /o2gVVkwoDvzpfjRkKtATaTFPU2XcmJ4p4mJk2FLs8XRJB3sT0DHTp43AEYpRPnbpx
	 hgwSl7Si6FBIlyttgor0CA4NJyNtypq/hBY+6VyH2JEhvXdqf99+OZbalqrI3bO6Cp
	 LnukB4Adne9TKkSoYUmLH5vsX5GREgDZGLkaiqZDGu7BYm9eyX0WnEc4hA7e5+yjoD
	 XNnCoccC1sxlg==
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
Subject: [PATCH AUTOSEL 5.10 35/44] arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
Date: Tue, 16 Jan 2024 15:00:04 -0500
Message-ID: <20240116200044.258335-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 0bc5fefb7a49..d766f3b5c03e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -139,6 +139,19 @@ memory {
 		reg = <0 0 0 0>;
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
@@ -1374,6 +1387,14 @@ funnel@3023000 {
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


