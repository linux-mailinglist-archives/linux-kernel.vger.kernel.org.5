Return-Path: <linux-kernel+bounces-28071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8316382F9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB5E1F25405
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F332E622;
	Tue, 16 Jan 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwCo5eje"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32AD14AD0B;
	Tue, 16 Jan 2024 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435037; cv=none; b=LYvvTkuBNhT1/fFl8WhRfJhY37XJO80BCnayJy55v4qqJ9gsugTeWJfb5/xixMNW63qRV9f1Cq29+MsFQOuBM8BTeGl+RhvSgsSGsqU7wMFXkYS+c3rneKp0eQFOhEVro63K1TCIyM6fXL8n4i4J8doLbyJCjxY4DNktmRM1X14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435037; c=relaxed/simple;
	bh=TQmfilBwqcBPOZ19e0B8VE75OmEHjrr9+g0oAjI14H0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=auv4bEVdWuiBNz+mcP1doiOAbxssMIQZwhH5V7BvJeNFCj/PtGhQ8HVUX/ZDkl/h+mU4t7FG5BK1P4u2qpFW0rioSUgIvQzPbBWCNevpEGNGrHp6IxTOWIxT8y0mamaauJ1/ftQW75PR0KNdnvFttwXqC4wYwQ9HZs2GrGaV6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwCo5eje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AC7C43394;
	Tue, 16 Jan 2024 19:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435036;
	bh=TQmfilBwqcBPOZ19e0B8VE75OmEHjrr9+g0oAjI14H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwCo5ejen6l8Du7tyfdLptMJ6zLDHq+RC7wy7qeBHXKa39J/S62OXVVu2+y7dsloB
	 dGFOuSSYsd4ykjd+mTD9ReNOSdpCI4Q9G+OmODY2IvNpqhYGnrqFoOPmusISe42+vu
	 VfgHyrNMsK4JXkAt0YgMxfF7WaLqLbBxpqVWtYL2NucmMmdMaPR3SOF8U5pJo3eOxM
	 MgDH2jlH2vwltiGI0VqsGZe6xa7Nx9hXfdKTRppxVxtcestTMZNnklfkESfPSQMd/P
	 GVuzKxvwqCWPg5xu2wk3mRIltTBoisEzFim4oIdobJB7anonyZ3iJAhfDdhhOg8p1d
	 H7tyV1mTw0Kaw==
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
Subject: [PATCH AUTOSEL 6.1 53/68] arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
Date: Tue, 16 Jan 2024 14:53:52 -0500
Message-ID: <20240116195511.255854-53-sashal@kernel.org>
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

[ Upstream commit ae5ee3562a2519214b12228545e88a203dd68bbd ]

out-ports is a required property for coresight ETM. Add out-ports for
ETM nodes to fix the warning.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
Link: https://lore.kernel.org/r/20231210072633.4243-4-quic_jinlmao@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 32 +++++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b00b8164c4aa..7a41250539ff 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1903,9 +1903,11 @@ etm5: etm@7c40000 {
 
 			cpu = <&CPU4>;
 
-			port{
-				etm4_out: endpoint {
-					remote-endpoint = <&apss_funnel_in4>;
+			out-ports {
+				port{
+					etm4_out: endpoint {
+						remote-endpoint = <&apss_funnel_in4>;
+					};
 				};
 			};
 		};
@@ -1920,9 +1922,11 @@ etm6: etm@7d40000 {
 
 			cpu = <&CPU5>;
 
-			port{
-				etm5_out: endpoint {
-					remote-endpoint = <&apss_funnel_in5>;
+			out-ports {
+				port{
+					etm5_out: endpoint {
+						remote-endpoint = <&apss_funnel_in5>;
+					};
 				};
 			};
 		};
@@ -1937,9 +1941,11 @@ etm7: etm@7e40000 {
 
 			cpu = <&CPU6>;
 
-			port{
-				etm6_out: endpoint {
-					remote-endpoint = <&apss_funnel_in6>;
+			out-ports {
+				port{
+					etm6_out: endpoint {
+						remote-endpoint = <&apss_funnel_in6>;
+					};
 				};
 			};
 		};
@@ -1954,9 +1960,11 @@ etm8: etm@7f40000 {
 
 			cpu = <&CPU7>;
 
-			port{
-				etm7_out: endpoint {
-					remote-endpoint = <&apss_funnel_in7>;
+			out-ports {
+				port{
+					etm7_out: endpoint {
+						remote-endpoint = <&apss_funnel_in7>;
+					};
 				};
 			};
 		};
-- 
2.43.0


