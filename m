Return-Path: <linux-kernel+bounces-27952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5496682F841
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051EF285D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F19F24B31;
	Tue, 16 Jan 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXnfMqqA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7824A17;
	Tue, 16 Jan 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434673; cv=none; b=lGWdBy4vFwazZYtydk8WHmmtkHB8y1XvKAUGcjvf/I6m8mv6hx94WcAyzi1mvT4NOHGzAptad5+9mMf+Sd4X8dPzGgNfx1j5uOoBChcReFQgAWUBkVNudhovcuekxJxKDOZGRz1eKljVAZrXaxx6m+yJEXULJ++1EmJ6Yb2F2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434673; c=relaxed/simple;
	bh=IKZxxGzg5duM3v04vbp7+wzdX9arvMiKzIozbXKg00Y=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=bowl7IwnxsSFz6Ayjtun0pVLCkO8866cxetiS/GXHpUNj2UAU/vmdYjsrYBQpu4KAbmft2+f9ssu1Cd+eIrK8EnH4RPrsKbojyWR2P7QqSbfAH2tXjVD8kpW0wJrb43XrkY+hXOdKe303nT7Z9k7R3LKBTxfQJy5ZCUJROfMIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXnfMqqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDD2C43394;
	Tue, 16 Jan 2024 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434672;
	bh=IKZxxGzg5duM3v04vbp7+wzdX9arvMiKzIozbXKg00Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXnfMqqAye7Ih5Sijc1Q+HJ8HevFKer6jkjqDVOZ+Cg4CuQxE31ZUHmy2ZUKfQT7f
	 i3fM66eAkes0bydy8Pvk0OYisbOpJ7xViM26+Gx6UODj7vXiNAC56x0ENgQo8ikmPC
	 f+e+rovv2eRuEhVxAUkcbpRjXPjuFcFlC3tEm56Kql7XQxIY8H+juMJDcyAcls8IoJ
	 Urspkn0oEQ9iOSlsCsqVbDoGgMvXuAkEiynVydlOZIf7UTSepyA9pNmfv61bH68HQS
	 Dpr2TRxmipNg2USPR0Smpfo7gTWcg8ToMAGqC9BJYEXlqLHKAqRg54glLFVg7FF3pr
	 bizW0sn0IaGkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 044/104] arm64: dts: qcom: sm8550: fix soundwire controllers node name
Date: Tue, 16 Jan 2024 14:46:10 -0500
Message-ID: <20240116194908.253437-44-sashal@kernel.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 07c88da81caf0e72c3690b689d30f0d325cfeff4 ]

Fix the following dt bindings check:
arch/arm64/boot/dts/qcom/sm8550-mtp.dtb: soundwire-controller@6ab0000: $nodename:0: 'soundwire-controller@6ab0000' does not match '^soundwire(@.*)?$'
from schema $id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231106-topic-sm8550-upstream-soundwire-bindings-fix-v1-1-4ded91c805a1@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d115960bdeec..1f383944df11 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2034,7 +2034,7 @@ lpass_wsa2macro: codec@6aa0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr3: soundwire-controller@6ab0000 {
+		swr3: soundwire@6ab0000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06ab0000 0 0x10000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
@@ -2080,7 +2080,7 @@ lpass_rxmacro: codec@6ac0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr1: soundwire-controller@6ad0000 {
+		swr1: soundwire@6ad0000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06ad0000 0 0x10000>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
@@ -2145,7 +2145,7 @@ lpass_wsamacro: codec@6b00000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr0: soundwire-controller@6b10000 {
+		swr0: soundwire@6b10000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06b10000 0 0x10000>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
@@ -2172,7 +2172,7 @@ swr0: soundwire-controller@6b10000 {
 			status = "disabled";
 		};
 
-		swr2: soundwire-controller@6d30000 {
+		swr2: soundwire@6d30000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06d30000 0 0x10000>;
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


