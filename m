Return-Path: <linux-kernel+bounces-125010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF90891F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96B9B2871A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED71B629A;
	Fri, 29 Mar 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OymGRkmH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01B1B6289;
	Fri, 29 Mar 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716623; cv=none; b=epwvA3wrL2G7i53BKIKVSh5JRP0EVbqAK99Qi2PDJN5r3JfVe534DL1Mq+CQJ3aUEB6qYKdWyCcp4QNOwMjvnX9Z7FEjDlGjLdvf74PJw1PnR3MOZtW3mB+qFCLKOL7/snQdD5PhNheDLD1u2on8dWoM96trgN+cArGkfJifMSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716623; c=relaxed/simple;
	bh=sHUhxif8Mj7FBTMgP1JlQscVfmV99ViSxkXzdJZaudk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUGliUoBmqs3MGCSebKek85Tveu5Jx0LH+9H1uOSCHgjGcA/wGszAUuw91JC0SDXcQUWVLBDrcu03T8Xz4+kM8PnBaSJV4vActbCasbUKrmqnzje/aGU4iikjHwsx3tPxxj5apQB0/yHRoYMJJ0Lf/l//Aln4BTIJqh2PloP368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OymGRkmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195B9C433F1;
	Fri, 29 Mar 2024 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716623;
	bh=sHUhxif8Mj7FBTMgP1JlQscVfmV99ViSxkXzdJZaudk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OymGRkmHpl8WY40655CPX0iaRMUUbkW5bia9kkL9z3Ko63jTLF61nbX9tWh5c6DiX
	 +oF9QP1xzKGSnPmZdfFXpKq5x/GYtK6516Y9uOSuEMQ1d4lwNmgvsZwwu1Gbh/vDnl
	 8HD9nHVG36R6V4HDzJ4CuONu6tBWsTtp/Dnv9EdvqXh+0O2O54cn1DXlXT1iwgjiVQ
	 BbzaStwL2M4ZyLczuBgv7nEff1KScjV5O7r90zkuM9PoftNwEEi080w4Gdj/ObmLOG
	 J532bd7lYST3wKQWeKsY1ctG9YiJ1Jfl4N9z6I2vXmS1Ph3Gui54w4bEUh2ifhzgRC
	 HE/BoJnwlM86g==
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
	jay.xu@rock-chips.com,
	shironeko@tesaguri.club,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 08/23] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:49:41 -0400
Message-ID: <20240329125009.3093845-8-sashal@kernel.org>
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

[ Upstream commit 1d00ba4700d1e0f88ae70d028d2e17e39078fa1c ]

Fix rk3328 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/e5dea3b7-bf84-4474-9530-cc2da3c41104@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6ddb6b8c1fad5..ef45d5607ea1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -684,11 +684,20 @@ hdmi: hdmi@ff3c0000 {
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+
 				hdmi_in_vop: endpoint {
 					remote-endpoint = <&vop_out_hdmi>;
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


