Return-Path: <linux-kernel+bounces-27826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D0F82F670
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B261C240EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C954E20313;
	Tue, 16 Jan 2024 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N94xfS1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605C3588C;
	Tue, 16 Jan 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434294; cv=none; b=aL8T4Bn+/WuMvDeTOsQnrpa71oDVJ3/JMgLT/lQ4k/fVehObshEegFe0rL+7lqIK/3vjz7ztyVywNKCKElwAy6v4oaRPESHENsUuj+M08SKkmHQmtfSrZpofwLsITTPtraA1j97+Ek7hr1uZEt9kTdRrbrMPutJL9jAEo0AXKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434294; c=relaxed/simple;
	bh=sRESA0Mf6oMOfaCCJFfjN2881zrZn5Z1Kd53N5cU50w=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=n9cB3vsGqC3Yh6VObt/L7/dL+UPwGOMpO2gazd4HX9muDaMkBxOxhh6ZWwPSISA3mUrVuxMeNkyd/ScJF1QDNN0NK8fsPE4PYNGnTd6DKOGZqhgCu1HXf1Rb1S4a8ttjAjyDk+AG/jf46aiCRgkyQabgvavqJQ/ZAT6tPS8ceNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N94xfS1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4BBC433F1;
	Tue, 16 Jan 2024 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434293;
	bh=sRESA0Mf6oMOfaCCJFfjN2881zrZn5Z1Kd53N5cU50w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N94xfS1wTGZTEvFEL0SyLD4VNFpe/tzol5zzFkuD+HombkKD18uhUL9QseQsLduRO
	 3eNQTp/DIM3yFJZPvbqVeQxi7jPcFNwEKG+q1E+Qz9l3lEtKZJn8n6epIzp+iULPhR
	 /Mqgk+f5obHjp6dDYh9XMvRbLDrIpnO9fMmTR5q4YSUD9uTWTANJB65CHRyAiPnp+n
	 GR0k7sdZkP9ENvrt6R/b5lvEpdqbkQlec95SZygeBCLo7tBwi1h7gto1nvvWFLbcN3
	 1QV9xS3/z0HqGYpBgX7vEXp3kmb3RX8ZX6spmjVLjPloLQHUzANR7WDQyn4pHGzSQQ
	 dufycqBLgs9lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 055/108] ARM: dts: rockchip: fix rk3036 hdmi ports node
Date: Tue, 16 Jan 2024 14:39:21 -0500
Message-ID: <20240116194225.250921-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 27ded76ef0fcfcf939914532aae575cf23c221b4 ]

Fix hdmi ports node so that it matches the
rockchip,inno-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/9a2afac1-ed5c-382d-02b0-b2f5f1af3abb@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rockchip/rk3036.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 78686fc72ce6..c420c7c642cb 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -402,12 +402,20 @@ hdmi: hdmi@20034000 {
 		pinctrl-0 = <&hdmi_ctl>;
 		status = "disabled";
 
-		hdmi_in: port {
+		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			hdmi_in_vop: endpoint@0 {
+
+			hdmi_in: port@0 {
 				reg = <0>;
-				remote-endpoint = <&vop_out_hdmi>;
+
+				hdmi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
 			};
 		};
 	};
-- 
2.43.0


