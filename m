Return-Path: <linux-kernel+bounces-113158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919F8881EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBEB1C21B62
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CA3172BD2;
	Sun, 24 Mar 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNJ8fgo9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6511172BB3;
	Sun, 24 Mar 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319960; cv=none; b=E0LumgYKIt1KgPXlvH7xd1Vlu+1fJpHxkIh+IL3PBQ8LHzSV19KM7Vqdzxc8OAYBWpy/9c3oaLHiP4mYWTr99KU0zEtesLefwZuKuLPCMVMwbrvNlSki96VUaSoboSH2bu1nZIWQMbMEoufftuBbxcIy2Nq+j/FnI8ggJuUQhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319960; c=relaxed/simple;
	bh=im1qitA3y3Fjmo4eLlVmZm8/7y/SC+50O7yYIeNO5Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs7N82Q32Eu5hISPOxwitbmPAAf6vt9CW+PqUeBVXzX/4Mr/XagdIN5hsXUEgWUB422Ovx+eHl/EOHCKhVEDJG+n7dCCewvdwVmbiD7aMbGyeFApKPYP9EkFi9a62i0IOV6KOaaj8ahMbPIONQftNa93B4tDZPa83DpCd+khp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNJ8fgo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB42FC43390;
	Sun, 24 Mar 2024 22:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319960;
	bh=im1qitA3y3Fjmo4eLlVmZm8/7y/SC+50O7yYIeNO5Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNJ8fgo9jq2gR6Yfhe/D1d92VvEi8fXIr5G3YnzWqQGnAdTxdJc98fbgAJWcDxZGJ
	 veo0BTU0nI+PtEMZZ4MeQZo37PCyK+hccdVunerN7LtTjWopX/1kINPCXITGCylN7i
	 ucw/NNU72H59PQXwdZq6hHk4rznPqWZUNpKklpBUDWrf5hF84K2bea30oieZIAEAJV
	 1hd4+Rz3rvcKqIfdltjufyXEt+GOVJeFBwP4K6mALccFPBn7LC++8PIgBMCQlCdRQX
	 CBwq9nULDJ4K+MvxCzStnBsHIbVLBZEOoKXjE8q99PNhTxnx4IhgTRriSABxxZqdJr
	 FVRHylA83KysQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liu Ying <victor.liu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 267/715] arm64: dts: imx8mp-evk: Fix hdmi@3d node
Date: Sun, 24 Mar 2024 18:27:26 -0400
Message-ID: <20240324223455.1342824-268-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Liu Ying <victor.liu@nxp.com>

[ Upstream commit 0ff08803eca417dfa9372194bebf3d1b1f501f98 ]

The hdmi@3d node's compatible string is "adi,adv7535" instead of
"adi,adv7533" or "adi,adv751*".

Fix the hdmi@3d node by means of:
* Use default register addresses for "cec", "edid" and "packet", because
  there is no need to use a non-default address map.
* Add missing interrupt related properties.
* Drop "adi,input-*" properties which are only valid for adv751*.
* Add VEXT_3V3 fixed regulator.
* Add "*-supply" properties, since most are required.
* Fix label names - s/adv7533/adv7535/.

Fixes: 65344b9bed3a ("arm64: dts: imx8mp-evk: Add HDMI support")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 33 +++++++++++++-------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index f87fa5a948ccc..9beba8d6a0dfe 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -23,7 +23,7 @@ hdmi-connector {
 
 		port {
 			hdmi_connector_in: endpoint {
-				remote-endpoint = <&adv7533_out>;
+				remote-endpoint = <&adv7535_out>;
 			};
 		};
 	};
@@ -107,6 +107,13 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 	};
 
+	reg_vext_3v3: regulator-vext-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VEXT_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "wm8960-audio";
@@ -364,7 +371,7 @@ BUCK4 {
 				regulator-always-on;
 			};
 
-			BUCK5 {
+			reg_buck5: BUCK5 {
 				regulator-name = "BUCK5";
 				regulator-min-microvolt = <1650000>;
 				regulator-max-microvolt = <1950000>;
@@ -415,14 +422,16 @@ &i2c2 {
 
 	hdmi@3d {
 		compatible = "adi,adv7535";
-		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
-		reg-names = "main", "cec", "edid", "packet";
+		reg = <0x3d>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 		adi,dsi-lanes = <4>;
-		adi,input-depth = <8>;
-		adi,input-colorspace = "rgb";
-		adi,input-clock = "1x";
-		adi,input-style = <1>;
-		adi,input-justification = "evenly";
+		avdd-supply = <&reg_buck5>;
+		dvdd-supply = <&reg_buck5>;
+		pvdd-supply = <&reg_buck5>;
+		a2vdd-supply = <&reg_buck5>;
+		v3p3-supply = <&reg_vext_3v3>;
+		v1p2-supply = <&reg_buck5>;
 
 		ports {
 			#address-cells = <1>;
@@ -431,7 +440,7 @@ ports {
 			port@0 {
 				reg = <0>;
 
-				adv7533_in: endpoint {
+				adv7535_in: endpoint {
 					remote-endpoint = <&dsi_out>;
 				};
 			};
@@ -439,7 +448,7 @@ adv7533_in: endpoint {
 			port@1 {
 				reg = <1>;
 
-				adv7533_out: endpoint {
+				adv7535_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
@@ -524,7 +533,7 @@ port@1 {
 			reg = <1>;
 
 			dsi_out: endpoint {
-				remote-endpoint = <&adv7533_in>;
+				remote-endpoint = <&adv7535_in>;
 				data-lanes = <1 2 3 4>;
 			};
 		};
-- 
2.43.0


