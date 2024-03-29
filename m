Return-Path: <linux-kernel+bounces-124738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE1891BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8431C24294
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AC9179653;
	Fri, 29 Mar 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDNvvYaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C5179642;
	Fri, 29 Mar 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716053; cv=none; b=r9j3XrbNJoIICOYaDp3ODPrRJtQCNmbShp/PB2NQ8z/rjK/CGRZR0BWFVPJt7MjgitS3lbWb6dVI+TCQQhTGe/yikRL3YlbT+iMIa8fEIoZ+I9IfuIVntcKDsU2bonPY3gBJZA2eVOOylotrJQXWfTQvAWPM6p7xXBbf/gSj1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716053; c=relaxed/simple;
	bh=4RMOa72KKzmhh+jE1nxP1CER4E3Wa2YBrXuinwX99So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0PxWgs9j7bKCgT34oU+f6lwzb4f6fT2nRO113deN/fdHJzgxTkf8cBWgJhUodlZVcqQCorliM595JHCsGPfWFoE/s+SZGWLROCaM3N5SxGdzmhHaPnqsbSxlS/MvNb5azORbxXqF6Otr02Ca37UNfUfJhaCHtB9jURetYSvf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDNvvYaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AC9C433C7;
	Fri, 29 Mar 2024 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716052;
	bh=4RMOa72KKzmhh+jE1nxP1CER4E3Wa2YBrXuinwX99So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDNvvYaGt85WtS0aS6x1+gXs3VD10W/Zpfj15uAOIk11ees/m2jV72MsThhWDi+NN
	 Hh7TYVOxzMCtwwnarZxv/FGALIyTEDzEX2pMJ7hSNAMEfPkwkDUnYOOEWrFp7s1IwJ
	 Sm0A0QOKB814fhFsNxzV4QsBlEbxRouDiL0cWmkQ8OPrgh4oXfPFYw9i3YQ7kZq6Bq
	 OcnMjxoQbLmKC6OXKYkIBILhbiwkwEK98iRGqWCQSZRnimpFrKRdsFiKH2Rkh49Ftf
	 UdMNAKOyS7IP1Z/3jwANv2etA2gZwcxLsZFJzTU8ao/nc2RCD3kIzL1RqRGtxM/76x
	 tVxv3C/jH9xaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 29/98] ARM: dts: rockchip: fix rk3288 hdmi ports node
Date: Fri, 29 Mar 2024 08:37:00 -0400
Message-ID: <20240329123919.3087149-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 585e4dc07100a6465b3da8d24e46188064c1c925 ]

Fix rk3288 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding with some reordering
to align with the (new) documentation about
property ordering.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/cc3a9b4f-076d-4660-b464-615003b6a066@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rockchip/rk3288.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index ead343dc3df10..3f1d640afafae 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -1240,27 +1240,37 @@ hdmi: hdmi@ff980000 {
 		compatible = "rockchip,rk3288-dw-hdmi";
 		reg = <0x0 0xff980000 0x0 0x20000>;
 		reg-io-width = <4>;
-		#sound-dai-cells = <0>;
-		rockchip,grf = <&grf>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>, <&cru SCLK_HDMI_CEC>;
 		clock-names = "iahb", "isfr", "cec";
 		power-domains = <&power RK3288_PD_VIO>;
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
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
+
 				hdmi_in_vopb: endpoint@0 {
 					reg = <0>;
 					remote-endpoint = <&vopb_out_hdmi>;
 				};
+
 				hdmi_in_vopl: endpoint@1 {
 					reg = <1>;
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


