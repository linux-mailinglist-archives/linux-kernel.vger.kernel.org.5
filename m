Return-Path: <linux-kernel+bounces-125011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AA1891EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D611D1C2841D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A966A1B7691;
	Fri, 29 Mar 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaeP8Qh2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADA1B7680;
	Fri, 29 Mar 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716627; cv=none; b=Sz8m0qrP9OHRnD/34BUJVfKSiwiFoCIqh3C6IwhfrklvZ15QWaZzc6cPjwI9S/UdbQqwhWVQUSvuVp7BqQxZ2UbvN1iYVBKqH3h1DLRoMMSg+LYTvaKx8lVcS5aEk8kFkIrEJoOeAGKhPxIJtB16bBrP5wlC4yVsgYMM0+HsPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716627; c=relaxed/simple;
	bh=V52EbVAy2r4mrqffOnFZrJCyqX/WHbQWIBaOCzvqbNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPgQ7M+oGedPWVI+6srrUP+PZynjmd9v3iOn2OBA1AQezmRXczHEljgH/ijOrzZb5Sq/F4sa+oyzIDmL5MKFE2vK5wsGJS35u2F6sWYyUD3/38On7v9j/hZRGAzofmQPucsjqH+5GwV5F6wMKAZtJndrCV5mOQ6+UDCuaoRw4FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaeP8Qh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE4FC43390;
	Fri, 29 Mar 2024 12:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716626;
	bh=V52EbVAy2r4mrqffOnFZrJCyqX/WHbQWIBaOCzvqbNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaeP8Qh2xnhH45nxVOp+16uplwcutAShEC7W8ShKrnLOZSMule26Z8gsMs8znoOHz
	 KAiN4kmZGS79U31EZSUFdrmDUSc1Z1U+3cWS908mxspMzz5hB5TGkGr5YlS6W0na5Y
	 8ua/QBpSE2XGW2L7n+wGG2C0Kq7PTAjqemo6X+7DUcsKg7ozQTCevWwXhhy+QFVr5G
	 QF7lI1zIsqkPggp+M8EMhHvc61nUp3vTzh8dNzbaxXaCAM7ehufftqvPwdmCyk5HIj
	 6cGqNKVV0l5L5GprVnGU4CLFFKPNurHV6QpYTZ3tK7phOe3l3875UIoJK2IwX1N5D+
	 myCE9QCFY7o6A==
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
	rick.wertenbroek@gmail.com,
	knaerzche@gmail.com,
	quentin.schulz@theobroma-systems.com,
	chris.obbard@collabora.com,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 09/23] arm64: dts: rockchip: fix rk3399 hdmi ports node
Date: Fri, 29 Mar 2024 08:49:42 -0400
Message-ID: <20240329125009.3093845-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 4496f7e1c68f8..e5a25bc7d7997 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1743,6 +1743,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1751,13 +1752,16 @@ hdmi: hdmi@ff940000 {
 			 <&cru PLL_VPLL>;
 		clock-names = "iahb", "isfr", "cec", "grf", "vpll";
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
 
@@ -1770,6 +1774,10 @@ hdmi_in_vopl: endpoint@1 {
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


