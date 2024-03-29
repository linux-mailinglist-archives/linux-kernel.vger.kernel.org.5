Return-Path: <linux-kernel+bounces-124505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3BD891904
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372702866ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0AD1419BA;
	Fri, 29 Mar 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPjUdAmE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B151411FA;
	Fri, 29 Mar 2024 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715257; cv=none; b=qkrZv7AdXehsjwt7hPbELqGHI42fM2mXcEK/sT/VLUUvrn0LYgNTXN08EmLAxvS1N2LeoEiTszN+1Zg0FDK/i7kZOw9hWjALSjBnPY7upnDf7Rm/TKtwiw4375Mv1hHVSGgffxI7YUY2TcgwRRRE3VUFf1xsu0B745nRxla9OQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715257; c=relaxed/simple;
	bh=4RMOa72KKzmhh+jE1nxP1CER4E3Wa2YBrXuinwX99So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAysZeNSPRIKv4GexMoT1bnJIF+Dr4U52IVB0OdU23c4TJycNqR/fozMy+b1Y2qIDz/Jj6U5x1nR/DecJDgriZI08RQSGooGb3mx/6XOfc4bOUF4MzDDPT+/wkquHS4pXxCpwT103L+96SrwBAruNWW9WLkXoJnWccCv0ejDdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPjUdAmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F70C433F1;
	Fri, 29 Mar 2024 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715257;
	bh=4RMOa72KKzmhh+jE1nxP1CER4E3Wa2YBrXuinwX99So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPjUdAmEriM855Ul0btdSvZ2q4ZRtaPt9u96eKiJzO1w84loRrMfdSBSJ9HMiBqCf
	 kqOoXOJrZjiJybBcMXt7CiLNBgwkCpVmV1NbptAFkNvTxgDiV44vCY3lDEQgGYcagg
	 iDTFogYifSfY2JQt3aafHInm0YaB61qwRioGsZ0ieu2D9aUAGQnjjGZh8pWwyFpRqn
	 3JbiTdUfiOquQY1XLh7ujP0MCh5S5dhEhmFTZ6ZMP+4xr6EsT7OawF3YFdFqMJ5oBn
	 IuCEPGfrNn2rT4H2oo3xcEgdsTrx03dxdziy67+Sqg4H51wR/iU7om/iuC21vEsz9D
	 yhT7jlXToaKRA==
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
Subject: [PATCH AUTOSEL 6.8 24/68] ARM: dts: rockchip: fix rk3288 hdmi ports node
Date: Fri, 29 Mar 2024 08:25:20 -0400
Message-ID: <20240329122652.3082296-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


