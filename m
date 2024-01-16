Return-Path: <linux-kernel+bounces-27856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E782F6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0805C1C2428C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3615DF0E;
	Tue, 16 Jan 2024 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElaW5NEV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B511DA34;
	Tue, 16 Jan 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434379; cv=none; b=VMSytWdnyK6iIGHedQTfGw2FxwZQuBZcxNperW+xOTB4SSEWlvNRuWrnKopBCcIZQFCWZS4gfkz7Ogh/SM9HNR5BwDNbbp2nZShjNSmMuO1Zf+c6Cem10j4+v07tglmXZCcw7xnhJ6n/qJf9P0aOr8Au/8a3zBI6RJO0G3QdMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434379; c=relaxed/simple;
	bh=/y6+3HjgYjNnpTdMaVWkVlxhCKFAi4i1YjiUCUTAo6o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=LQyYcehyPy7CztYjGl+hj1zvD/p+zLhvGuzcvU3yugj1tmlXi01NZrVb2Gr/YsncCuNOURc25sJbSsrKGgfGnh17ne/P0oxS0XI0EfdpqY4Ok8g0v+KYmOmm67zdU/IMEWlNxhktX8YcCh606VQxEp5LRfoQUWCcmUWkFDus0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElaW5NEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884F5C43399;
	Tue, 16 Jan 2024 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434378;
	bh=/y6+3HjgYjNnpTdMaVWkVlxhCKFAi4i1YjiUCUTAo6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElaW5NEVEdZI0RpHqeU/3WVy8ZMkHqDJgbrQSKb0hMO9HVZEV12eWDNXo4kmZNOTn
	 rlO7MNwrAqD6N3OuSfMS8Stsz9ADDgRvyiZmlJbONvvqzGTRhSZxdFNKYogknUPs34
	 IvIQmj+xQ9pG2yIWa4MrkjaPwEMZHVgePdQdgms6b8ggYPFZd93lgf1qAix2BLqS9+
	 YBsUV0Jpbw9oq5jmfMaRJu6h7+KlaH2iJKyR0zLBfdUAE17EVFPiZxBgI9S5chRM6n
	 YCpo3F2ayswxirOXOcvjXWLbWFcYGcMszvWOdnH1cmlLhH3IR6czcCfXQh8okFwDi0
	 azo9dBih0ib1A==
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
Subject: [PATCH AUTOSEL 6.7 085/108] arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
Date: Tue, 16 Jan 2024 14:39:51 -0500
Message-ID: <20240116194225.250921-85-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index b485bf925ce6..ebc5ba1b369e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2031,9 +2031,11 @@ etm5: etm@7c40000 {
 
 			cpu = <&CPU4>;
 
-			port {
-				etm4_out: endpoint {
-					remote-endpoint = <&apss_funnel_in4>;
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint = <&apss_funnel_in4>;
+					};
 				};
 			};
 		};
@@ -2048,9 +2050,11 @@ etm6: etm@7d40000 {
 
 			cpu = <&CPU5>;
 
-			port {
-				etm5_out: endpoint {
-					remote-endpoint = <&apss_funnel_in5>;
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint = <&apss_funnel_in5>;
+					};
 				};
 			};
 		};
@@ -2065,9 +2069,11 @@ etm7: etm@7e40000 {
 
 			cpu = <&CPU6>;
 
-			port {
-				etm6_out: endpoint {
-					remote-endpoint = <&apss_funnel_in6>;
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint = <&apss_funnel_in6>;
+					};
 				};
 			};
 		};
@@ -2082,9 +2088,11 @@ etm8: etm@7f40000 {
 
 			cpu = <&CPU7>;
 
-			port {
-				etm7_out: endpoint {
-					remote-endpoint = <&apss_funnel_in7>;
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint = <&apss_funnel_in7>;
+					};
 				};
 			};
 		};
-- 
2.43.0


