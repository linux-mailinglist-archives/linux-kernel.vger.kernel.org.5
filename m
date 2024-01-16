Return-Path: <linux-kernel+bounces-28205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF382FB91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FDE1C26C03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3B167B0E;
	Tue, 16 Jan 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCDAQPcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F08167AF8;
	Tue, 16 Jan 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435441; cv=none; b=bqwz6NYXsM26fenRWSmgvwkwZ//LiRczEOFHtcjXMTNQgCYHSAQgGw7U5JcIXkaTb4GDhHwUGV8N8pFIhWzHG4j8MwPv7MeKc2ty2fs/Gaf29sagSbwrqCOfcQ4lbGP6ZI2Ov7610Q3/md0prK19Qm5LNoFzfdDMzHda0OCVqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435441; c=relaxed/simple;
	bh=pqKAYVU26J9EZxKpX4nyW8VUQkwJV2F+lqrGVHoEXbA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=VRezD2B+g0cNrF4M3sX5CUpzJNnGHyPnNA+yGuo4d8TCFp70JTxCfadKwTrOSsBJdirEDoYHg6dAdP4ii63bel4xaeFNc2mpun+iWGYM6C9ohiHZlYV+T9iBEBahExxyEwSuJVLblsIaRMLCozW/dkZk89LhpGHUyrz1k5ygsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCDAQPcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8A5C43399;
	Tue, 16 Jan 2024 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435440;
	bh=pqKAYVU26J9EZxKpX4nyW8VUQkwJV2F+lqrGVHoEXbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCDAQPcZakZT9fzL9sBiP34WXAXn/tqWz5DVUUVii/Pf9qjWtU44pdo1TO6hpJSe/
	 Hbh/jRVoVYulf1pqoBrjTkXjI37Mfd1j2NlKV75y18eoRckdh2FWGi+FePq2MAXbEQ
	 NZyIgB36JrohTAgXtANyKvJ6yQrx0BxWvweLVULCBXMJLAAMEYK8Clq682EZMZWnJ/
	 18OzE46ilqWqkIekGpsDtrqvEkMJ2DzzjA2sKuE2VF6MCDzYfEq2aeynUR3+mZIN3S
	 EB5hw36+2FEhlS9w7Gi/g9kf4TSYZq2aXHaf0QXnmTRvRBk8vvFASfjgKEHY68JyDj
	 p2MYhHT5i2vdA==
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
Subject: [PATCH AUTOSEL 5.4 25/31] arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
Date: Tue, 16 Jan 2024 15:02:34 -0500
Message-ID: <20240116200310.259340-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index f1d3c51ea8d0..fb9556f57f55 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -433,6 +433,19 @@ sleep_clk: sleep_clk {
 		};
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
@@ -736,6 +749,14 @@ funnel@3023000 {
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


