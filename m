Return-Path: <linux-kernel+bounces-28172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F3282FB21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B943E1C26810
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00A65BBD;
	Tue, 16 Jan 2024 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb5BVS2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC99665BA5;
	Tue, 16 Jan 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435337; cv=none; b=KkvpAhTTsh2lvW+LJMARIM5EsVnyCdj/RgZnr0flRt8FIKc+9zsIkHuMz1UCgJmzjBDF/k3UGznBqyFOdzUZiFk5Pb2roAvISR9I2co56vNaRjsSEDsuo6lv3yiS3cEvPM49U5nawtQlJJJkAE5O6yADLquzvSRL1xRO4nNc9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435337; c=relaxed/simple;
	bh=gq5JoAXNMweGcEU6rvDYblIMP5Mecs9lRwxC0fZO2es=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Ch9CoMHUKT70+XJ/xhzs5PDcniLHjlpVK1lZLbJY0p72QR2xSWwNBvP0cLL1ITGNG6yKwTOAzwV9AkyQM1pGqWCFJqVc7PHwyaAWdOKiyuClV0phaLqB/a1IRCKk/OVPFJbcqO0EH33ZsZicYyyYBz2MrMbUtXx1ZxK1P2N+TjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb5BVS2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A3DC433B1;
	Tue, 16 Jan 2024 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435337;
	bh=gq5JoAXNMweGcEU6rvDYblIMP5Mecs9lRwxC0fZO2es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pb5BVS2J6etOTJnDReKs/SE6Y/CsvONeJZZbcQd1xvPo01jr8Dsc+k46cWEsW1yEx
	 lbihdoFC56TGzNdbTe9rpdk34IEqk447sCghLMyA1A5imZwD1jM6GKatv5tL+1zv0Z
	 tf5HTfVpBOVbbA/DNh4C2vMvFnZSDTi2qiEVa9M6ZBOac+pX0sir6BLsx+o3wERFT9
	 UTz7zCSADil+xjy8Q95bGCflh6IMlJblqZC85aPjJOOLO4aPJPRWubGlIvkioVzi4w
	 wNz9nIgqhW9yqSueA8VrNgTJgyOi/nZaRjTt/Dt6qlLzfd/w8QWJY1FZzqAMob6jAH
	 E9P/QFDzP0BEw==
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
Subject: [PATCH AUTOSEL 5.10 36/44] arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
Date: Tue, 16 Jan 2024 15:00:05 -0500
Message-ID: <20240116200044.258335-36-sashal@kernel.org>
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
index 7c8d69ca91cf..ca8e7848769a 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1577,9 +1577,11 @@ etm5: etm@7c40000 {
 
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
@@ -1594,9 +1596,11 @@ etm6: etm@7d40000 {
 
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
@@ -1611,9 +1615,11 @@ etm7: etm@7e40000 {
 
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
@@ -1628,9 +1634,11 @@ etm8: etm@7f40000 {
 
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


