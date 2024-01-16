Return-Path: <linux-kernel+bounces-27996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C398E82F8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D4B27809
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560C28DAD;
	Tue, 16 Jan 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXXliYSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04FB13A25C;
	Tue, 16 Jan 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434804; cv=none; b=hF1odCmrt6P4dpfOmt2qkTIf7lea0BAjJXVW0lSz4F/mAQIwyNex5SlCurNTy2bQh4RBb7nt80+1TEp7r2H/rIzfAMCNX7pjQ2n8393X2vKMHAFxmLvtyQzeVCw4pxuocH3G51oaWZ2+5sY36bJlAQjiGsJH5/3VVnvV0ueA6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434804; c=relaxed/simple;
	bh=Tyk/aprcfqpI37EGshT92tn98SfJrI2142dd2Nb/S7I=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=CN02dNDfvE+am0TXP495cR1srJo6WHwcVVvluzUWyR/QhMFQve+9Ht29KyxiFmDzRRnUAaZQ1jHNemPtNwJaclG3T/Zp3mmTvUcEV6nvrCuSelZz7vgWjn2OWQ2kn8P4wtMqrbSkzdvjpKfMUVp3fjsvvjJVw21eDlbSG3QwDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXXliYSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5ECC433F1;
	Tue, 16 Jan 2024 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434803;
	bh=Tyk/aprcfqpI37EGshT92tn98SfJrI2142dd2Nb/S7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXXliYSyffVlOSH/UvG/0l/OljsltdkJ8MzGvIXAzEPbSj6Yvwx8tlV+2AUlWf9GX
	 J8fSOTMK8it530ofNFoyR4yyGug1khemruLB+crBoBcJl0qpgnyCc579r7FPbXmweo
	 RNwjrYarVByVtM8Um1YCucQvlG+dm6PvRP17SUA7bivU6EAZBNYsqX2AzKxAoWhyb8
	 43/otXltNWr23lGTg3Hw3BE+7wa6AwXdVXwUNIN1vlKIbTl1K3QaduxPXreCU8S8ta
	 IBjjTTlofac0mXsDpmJN8OXr6U5NsSCgofWsxGNfZoux5I8pAKJD+96neP5/+epylY
	 wsAvXfpqlFlDw==
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
Subject: [PATCH AUTOSEL 6.6 084/104] arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports
Date: Tue, 16 Jan 2024 14:46:50 -0500
Message-ID: <20240116194908.253437-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Mao Jinlong <quic_jinlmao@quicinc.com>

[ Upstream commit bdb6339fd46b8702ea7411b0b414587b86a40562 ]

When a node is only one in port or one out port, address-cells and
size-cells are not required in in-ports and out-ports. And the number
and reg of the port need to be removed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
Link: https://lore.kernel.org/r/20231210072633.4243-5-quic_jinlmao@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi |  5 +----
 arch/arm64/boot/dts/qcom/sm8150.dtsi |  5 +----
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 24 ++++--------------------
 3 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 055ca80c0075..5af7f52d8a8d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3555,11 +3555,8 @@ etf_out: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				port@1 {
-					reg = <1>;
+				port {
 					etf_in: endpoint {
 						remote-endpoint =
 						  <&merge_funnel_out>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 19c6003dca15..513dcebd6ed4 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2973,11 +2973,8 @@ replicator1_out: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				port@1 {
-					reg = <1>;
+				port {
 					replicator1_in: endpoint {
 						remote-endpoint = <&replicator_out1>;
 					};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a4e58ad731c3..35998bf23b60 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2830,11 +2830,8 @@ tpda@6004000 {
 			clock-names = "apb_pclk";
 
 			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				port@0 {
-					reg = <0>;
+				port {
 					tpda_out_funnel_qatb: endpoint {
 						remote-endpoint = <&funnel_qatb_in_tpda>;
 					};
@@ -2877,11 +2874,7 @@ funnel_qatb_out_funnel_in0: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+				port {
 					funnel_qatb_in_tpda: endpoint {
 						remote-endpoint = <&tpda_out_funnel_qatb>;
 					};
@@ -3090,11 +3083,8 @@ etf_out: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				port@0 {
-					reg = <0>;
+				port {
 					etf_in_funnel_swao_out: endpoint {
 						remote-endpoint = <&funnel_swao_out_etf>;
 					};
@@ -3178,8 +3168,6 @@ funnel@6c2d000 {
 			clock-names = "apb_pclk";
 
 			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				port {
 					tpdm_mm_out_tpda9: endpoint {
 						remote-endpoint = <&tpda_9_in_tpdm_mm>;
@@ -3445,11 +3433,7 @@ funnel_apss_merg_out_funnel_in1: endpoint {
 			};
 
 			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+				port {
 					funnel_apss_merg_in_funnel_apss: endpoint {
 					remote-endpoint = <&funnel_apss_out_funnel_apss_merg>;
 					};
-- 
2.43.0


