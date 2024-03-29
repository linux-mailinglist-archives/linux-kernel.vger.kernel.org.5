Return-Path: <linux-kernel+bounces-124947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12493891E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448371C27C42
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C516C696;
	Fri, 29 Mar 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rU77mshG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50816C683;
	Fri, 29 Mar 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716490; cv=none; b=RK9Nqp60Z31COZQPEAfxkvzfV0DDAgY3CGByFeIX+nEc77s1WbCPaqTxnw2oJXTKYc82S/ACaIC4hpneZCKDw/rn5JWHGvmWDJ0xP2vlqJSFUNV9DXuOnJjKz1wo7S6BD/4n+5gXhm6GuHoLoQc7HYw3kqD/Xh1R/Anpbl9a298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716490; c=relaxed/simple;
	bh=M5buJNV+qQhLKyx2nfN6O+tqrro0jxkp6HTincHzTdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5G0PWj9QMRgCJ7QSkSM9t9wdYDH3ztSxaQF7SM6YxF8F3ndUSdWGdrtbWkw3B5Oxr79axjRWHWeFXVQONbdx/ycSaompxjJrJea6I5qQyGLTVl+rKxJF1lGBrdNCMJyGWRAwvhc+PQwIgcJtFworPgNEtpNKdwnEHUqgIS3hGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rU77mshG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE45C433C7;
	Fri, 29 Mar 2024 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716490;
	bh=M5buJNV+qQhLKyx2nfN6O+tqrro0jxkp6HTincHzTdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rU77mshGkWCtCo91K9wXYiP4Ra6Jo6N1tQeB9UjuT7YDvHlV4hBx9aDB1sHgKAVSd
	 21541KkSWjNXfcT+JYNZ2xTXVmvXtK0cPx0POoQxvuk0QpDP8Lc02YqJNIfSL6+n1A
	 yZv0Ab9gXuL/Z6frq/dYUUDiHDH5n296XBEQa9mCfuuAn5UnWEW6YP9qsOm1Bx+w9M
	 cWrXJRQ+5QrkbuXOaFbAI66xuimTTE46plUPWy2FM5DgputsVnfB2nH9EID7Zm4hJu
	 9VoCG+dcFSh2tHMYeaX+02tm2nhiDR95z+wmJHIew5nAlR8mW8lc77wXxzEdsjN2yL
	 jeiQ8WcLZM3xQ==
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
	knaerzche@gmail.com,
	jonas@kwiboo.se,
	chris.obbard@collabora.com,
	quentin.schulz@theobroma-systems.com,
	rick.wertenbroek@gmail.com,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 11/34] arm64: dts: rockchip: fix rk3399 hdmi ports node
Date: Fri, 29 Mar 2024 08:47:12 -0400
Message-ID: <20240329124750.3092394-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 9e33f0e6ed504..e98966899f53c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1801,6 +1801,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1809,13 +1810,16 @@ hdmi: hdmi@ff940000 {
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
 
@@ -1828,6 +1832,10 @@ hdmi_in_vopl: endpoint@1 {
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


