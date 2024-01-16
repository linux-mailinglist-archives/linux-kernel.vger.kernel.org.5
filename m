Return-Path: <linux-kernel+bounces-28070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0509A82F9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B3728A0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958B514A4FF;
	Tue, 16 Jan 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLrUzx4l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44EF14A4EA;
	Tue, 16 Jan 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435034; cv=none; b=ebG+X/MqB4oZZYIbpEeI2X8XgSYyLh2Hx5Rm4tIM59nv1KG+YuYTulgawcXCgc01noUnHEuF37R9ZDc5B8o48aDw1vXVxejaheJQ9UueodZDzuU2anCyVUKIdEfxG5XyO1sBkLVNUuKeUeR+AaSxrf1wugSJh0nF+ZbQPYcC12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435034; c=relaxed/simple;
	bh=+chJaTaEeJ7ADT1okLW5FlwbJPRKpKDMOmwMmhKkqBE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=C8CmoL1eLBddk4Bnxs5ZNyOvRvITT0xhpUaO/fyoE6eOKT0bAe5J3B0jxmm2hgOgCTf7bfdB24wGuLBQ0IjF5BEY2UjUGaqtOR3/JIa6vmOy6pJdsxQvEdotl7Xncx+DhUISjdZeWsSSqWDZmivwTN8vxDohw28NjNUPS/pWEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLrUzx4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783F6C43609;
	Tue, 16 Jan 2024 19:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435034;
	bh=+chJaTaEeJ7ADT1okLW5FlwbJPRKpKDMOmwMmhKkqBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLrUzx4lSCVLtxu7PHF3cBBAMTFcF9Zi5x+Rtm1d5p8u6zZ53y9Okx7xlrZuySXrF
	 KR6n65RA511lxELAIQp8ZJDpbBq5W7cozehTWO/jhFdksyD0K1KKKZH6CgFgTLueeu
	 HvfGyniUPkV0Gw9rYe7GtPLEIFG5h6eyZwNlBDUGw7/dg8XhX7HLjrd5ERoNlcevWN
	 pDvssyMaMRumeHlQQF9D8g+bBlf6BSScKc+cQnMRfzd6FyFgb/nCkpAXAeHaJVkySX
	 OBDGPQlLzUmLiGGNFJPjVdw8CsfMMbvpRujrgUgD2AY9QmrOQlkgjSEDy9TRslj62w
	 ktmwYDTk86HgA==
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
Subject: [PATCH AUTOSEL 6.1 52/68] arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
Date: Tue, 16 Jan 2024 14:53:51 -0500
Message-ID: <20240116195511.255854-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 9de2248a385a..789121171a11 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -390,6 +390,19 @@ memory@80000000 {
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
@@ -2565,6 +2578,14 @@ funnel@3023000 {
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


