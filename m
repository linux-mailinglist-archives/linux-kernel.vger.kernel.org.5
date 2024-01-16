Return-Path: <linux-kernel+bounces-28125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2281F82FA96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0899AB27FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1D157022;
	Tue, 16 Jan 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgcORtVf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A0156995;
	Tue, 16 Jan 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435192; cv=none; b=VGfIIK3dRWZl60XpmV0dlO8j+YwRWGRHZUIPdPH5vhXPyFI9ZluaNzhgSuMroJvzj1X1w/WbIB12AtiC+/2ljgUvHKprmxTt/ubmqXCiWzhH4tOAyDOh8tq8/I723osZDS3O/UUK4zpZS8XwrS/E02x1ZeMlgkQDKxBTWFQI3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435192; c=relaxed/simple;
	bh=1XOKCTJkJkU9i1ndf86hBNYaso2EgKzOHH3Fzly86hw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=HSmyYJLBZHl1gUqcpY5R6RQPV+KBzPCTYy4uRyk0h8lOWGBwRp2tKp9Vc146AYXzCR0R3jH7loOfdELN88iQ8qItfbQnT00hUGg8aOd07JT9VEUZkLe3vV5PjxPR9Lbr4SWOaDeLl2QfYmBzxXdFA40Sh7xMQAJiFwPXCkMO/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgcORtVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E6BC43399;
	Tue, 16 Jan 2024 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435191;
	bh=1XOKCTJkJkU9i1ndf86hBNYaso2EgKzOHH3Fzly86hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgcORtVfCBkBZ/voUxjWItUxGtEYBDjfprMg6i3Vvk26tv4JiSyjuvj6/M/7vyLSt
	 p5m3t5WQhbLI5Kgd+PB0vFa8kVRZeRjLtBc1dfq5XxrLSU6hwZ7F8DBRQJ4nE4HZ0i
	 yZBkPkF8gaxnCfCHOwBLbLP6I0ncNsnOiuJejfAqTCZvR1a8al31yquPXCsyIAjvdI
	 2hMO/AlKD/NSvdtsQHr6cO9t2AqXIBAMrYaTUd1eIseCUe2BN5CdsgXxWhpG62TkhF
	 YDQ7zg6Funhu+KlgYnTB0R9dhJHuvagDL74mPD8JQ6z9zc9H3jEMfIpm+M2UPeMn4J
	 4Zl7lqMsQoAgA==
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
Subject: [PATCH AUTOSEL 5.15 37/47] arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
Date: Tue, 16 Jan 2024 14:57:40 -0500
Message-ID: <20240116195834.257313-37-sashal@kernel.org>
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
index b7d72b0d579e..7eadecba0175 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1863,9 +1863,11 @@ etm5: etm@7c40000 {
 
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
@@ -1880,9 +1882,11 @@ etm6: etm@7d40000 {
 
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
@@ -1897,9 +1901,11 @@ etm7: etm@7e40000 {
 
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
@@ -1914,9 +1920,11 @@ etm8: etm@7f40000 {
 
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


