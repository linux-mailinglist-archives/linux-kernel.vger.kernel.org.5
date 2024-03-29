Return-Path: <linux-kernel+bounces-124698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D991891B89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCB629248C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8262D142E9D;
	Fri, 29 Mar 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI07LB8C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5334175554;
	Fri, 29 Mar 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715729; cv=none; b=Gq5CkqsJsa4iiZbx0uFAFT7t7rtVZVBmjcZHaS53UoqYM5cUa63McfZhM84b7ncykZeQ/7gtHuEAfaHbwPwa9vtaZ+dALAyKWIygwZt/knkBGvofvXoWqgQiRzmqwQu6r6OuRnMiKvBO7v3JKp+Mp59nwZlXti73/yJRqo3MTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715729; c=relaxed/simple;
	bh=deZd//LGlzfXbOoyIuC9pT3KxFatDQLnTJxA7SS8whk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMWE+S5jgfdawn/HA1fTJUIYcFq1stfxOHZO2jLqzvyR1tlmnodHG56a65I0nixMF/xXtoKOZOzvU8daZspjW/89SEW4x53ZBNN9bKq5uXx9xMQNSDDGaJn6YnAhvHWr5Uz/ddq8zkZgL48DeOIna5xlCTfbnPusJtmo5fFRMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI07LB8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90A9C43390;
	Fri, 29 Mar 2024 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715729;
	bh=deZd//LGlzfXbOoyIuC9pT3KxFatDQLnTJxA7SS8whk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LI07LB8CAQjywQAPSud8B0z9trx80U4Ex73HaAbYg2jCHez/Ic+d6FHbgNDdnDN3s
	 ZI3dQcpI+tEDrKNy+J4WlqxKUWNEcRGzIoNCQdTVlZKGcnq6Q+Dh89UD7IW/9fde+y
	 imZ7HhU3hkml154a6JycF5NRArc0htOI1WWg9iuLZRkOPTpleoU7UghmURoIR81jqk
	 xI8mAsmiWTB0C9No3CpzmmEzpkiGPymERLwZeKoCb4DdBz/XErDBP1B0IKMd+K8B+k
	 cEeQ0XlCT95wfx3n2D6gIQDHIgXiJE4ArdmrkwpLAvp0GAzv9GZX41EOCIiafzMAcm
	 P/232lwNdi5xQ==
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
	kmcopper@danwin1210.me,
	lukasz.luba@arm.com,
	rick.wertenbroek@gmail.com,
	chris.obbard@collabora.com,
	s.hauer@pengutronix.de,
	knaerzche@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 04/11] arm64: dts: rockchip: fix rk3399 hdmi ports node
Date: Fri, 29 Mar 2024 08:35:10 -0400
Message-ID: <20240329123522.3086878-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index 5a60faa8e9998..f19d43021a4e7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1683,6 +1683,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1691,13 +1692,16 @@ hdmi: hdmi@ff940000 {
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
 
@@ -1710,6 +1714,10 @@ hdmi_in_vopl: endpoint@1 {
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


