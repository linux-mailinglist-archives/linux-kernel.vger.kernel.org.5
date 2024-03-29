Return-Path: <linux-kernel+bounces-124614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE16891A99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9151C25835
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC9F15B141;
	Fri, 29 Mar 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol1nT8/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8F15B137;
	Fri, 29 Mar 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715550; cv=none; b=ENQh9O0lybDBcV3DLfPyOnWqfBn5hQe298A07DbEBRmJ+jpDker2qjX2NayPpDEEzpwtEU6PuW79b28zjmURBTgObUiGjtlfAVMezTU14xw2gNf9ISCeRIM58CRObURK0jy1dttwzMUvu8pcCpYuWtPYKVSjCwMQa6zXINCvJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715550; c=relaxed/simple;
	bh=2/ZljzUOk4PkU7XUkRXO7j07VgyUBXZnAZ4r8S1aQhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRRXLnMS9/qtwpqTOqGhHauEjAGntWKx4CPavNt+LXk3f5gVoLimNmLGuZOiTXPV82hkx9x5L1/pCWkVYuDZ99IsQXJnI1AW5qES0L3Y1DhbgQS5WYmJiRnjsrjhHG79disB0sIxRD2hNWJiCLz824Keu8eZgzJI/Ib1uxjoQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol1nT8/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA523C433F1;
	Fri, 29 Mar 2024 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715549;
	bh=2/ZljzUOk4PkU7XUkRXO7j07VgyUBXZnAZ4r8S1aQhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ol1nT8/gGLy8GWD1SKLhraYaViTm7f/OBrHIRqfTyjikrQ9ggKUel3RR46QG3m7Lx
	 WCq0XxqAqtOSuSssErxhywDUoPJHZ95sY78OETt0AyJP2deMA4dACuZpJHWt9zZZHm
	 j5Q0Cd28AEwZxlAIPlbwk4vJMyMJXu7mpls/9mhAIV4AD1uaRQwV2vWWXHS0sUxSMK
	 Qn4PSaVK2H7Vb3t0UgsnEz9DGnEcCWugQSvxe2FvylKdp25enxoBkD/673U/D9j26S
	 INVGUZIpmGXjFUlAL275P4fcqCetQ5EXIr0ik68um77NOysIn6OzT7h3ALPCEtH5Qn
	 2eYWdW6vAtH3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dsimic@manjaro.org,
	jonas@kwiboo.se,
	lukasz.luba@arm.com,
	knaerzche@gmail.com,
	chris.obbard@collabora.com,
	rick.wertenbroek@gmail.com,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/31] arm64: dts: rockchip: fix rk3399 hdmi ports node
Date: Fri, 29 Mar 2024 08:31:30 -0400
Message-ID: <20240329123207.3085013-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit f051b6ace7ffcc48d6d1017191f167c0a85799f6 ]

Fix rk3399 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/a6ab6f75-3b80-40b1-bd30-3113e14becdd@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a7e6eccb14cc6..8363cc13ec517 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1906,6 +1906,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1914,13 +1915,16 @@ hdmi: hdmi@ff940000 {
 			 <&cru PLL_VPLL>;
 		clock-names = "iahb", "isfr", "cec", "grf", "ref";
 		power-domains = <&power RK3399_PD_HDCP>;
-		reg-io-width = <4>;
 		rockchip,grf = <&grf>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1933,6 +1937,10 @@ hdmi_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-- 
2.43.0


