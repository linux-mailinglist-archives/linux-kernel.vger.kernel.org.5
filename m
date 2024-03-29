Return-Path: <linux-kernel+bounces-124828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A6F891D94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D32B2E1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF91B48BF;
	Fri, 29 Mar 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhCSlYTJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B461B48AC;
	Fri, 29 Mar 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716244; cv=none; b=HaOkP5huabqK3jkbuE4fayq3BSbV6MSyZ3Pwbn4O7RqyWqPyXMx2XZ1n4Qd7rOcxuQkxd8MisitI3uHF/phnW9myCgl9FGBOExRpGncgP/BNs8BpAPrNGZUFiuEhYnm7whktPVoxatN7MprnzrgjDkha9IaHBMcWi2LhqVufDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716244; c=relaxed/simple;
	bh=Jdipl9dhbhD2aPQP+czHIyw4oCivbOrlA9Ax0ZnpNiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2XLOGIGGksnoE0kVdBAZldMqNuYj6Bb8pByEtbXLuk6/6kBJmOtP3bvsmnkx1JTXCEokRfWgfmvEoj/14t7UONIbxSIGVUcovs9L1+kiSTWl2E+408QF1w45k+M1XRGn0qHGJeQp+W29qttyQgBw3laUuiOo4GtPaEBPS/v53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhCSlYTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F79C43394;
	Fri, 29 Mar 2024 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716244;
	bh=Jdipl9dhbhD2aPQP+czHIyw4oCivbOrlA9Ax0ZnpNiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhCSlYTJoKiLhHjeVibX18cFHasux7VGSPIpBEGWwAvdD69FtvcspjZJcFeO6W/lV
	 9YsjxUsokJURMJZYyqD8XHzrnzVgDgVwpUyjXk/fsU2jkHflw7xnUVIzVTzu/tapt9
	 EoD6erxQWGUALBRExVUbjArHQwS2wQ7K9UGFPN7E49/8DsdjoINbqETVDGrpvAMokB
	 +sXH675qnbTw1TOsDWngshFntlNOQuXXFkM/CG+bmDIwphrkdgiu8f9zveDcQOajgu
	 +uvR8f0R4XbKsOSh+O+NLmkR/NT/mv9FWfyp1gJfcmksvbk9oZiXvShN6dgKC2enX7
	 WO1jlt01xjKgw==
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
Subject: [PATCH AUTOSEL 6.6 19/75] ARM: dts: rockchip: fix rk3288 hdmi ports node
Date: Fri, 29 Mar 2024 08:42:00 -0400
Message-ID: <20240329124330.3089520-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index cb9cdaddffd42..8593a83599376 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -1231,27 +1231,37 @@ hdmi: hdmi@ff980000 {
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


