Return-Path: <linux-kernel+bounces-87435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79E86D45C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2D91F2425D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C114A4E6;
	Thu, 29 Feb 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyDhBpOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C92142917;
	Thu, 29 Feb 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239054; cv=none; b=pYnhW6TECwvsRe8Yor7jYN1psFWM4z1WOAp2Wsc4ll7te0uR5mN8XT0BpMZMzliwyOpTpjZe9DGIlKqGFOrzQK9BNQKV9JdTc8PrO/tQ2DyYyw2XtNTSMvr5xtcfcBEl7o4fu7/ot1to1r+p91bzNKG6nsHbj81Yc+lk51KYXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239054; c=relaxed/simple;
	bh=IsMtaPO2nRbjGtVcG7DjgE1BW1fqCgoEtlxwZS2MSXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz0KS4ZrBXEKDkrFdO+653Wg+Coc9XArg5OKK172yxKhLi4w8/xvKHJ85M4Apikzdr3Dlleop67ZQdLlNK28XI8WiNWQYDPmJHXbcmb8HMce34IcwEY/oZzQrhQN7t1hK3LbYOU1Z9D3Iz/0ObRNNIASIQDqaJlpGj+bXc5NXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyDhBpOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F92C433F1;
	Thu, 29 Feb 2024 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239054;
	bh=IsMtaPO2nRbjGtVcG7DjgE1BW1fqCgoEtlxwZS2MSXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyDhBpOiJr5j2w0GsixIUOnZLmQ+1VYrJMxurldwnfVuIAdqvlK81eE3TRtVJ2T4G
	 XcaZkqnXModBE6df/dhfdDNgAh6k3h3YZGiRkZxuhsKncVipe8E6/EvUoPSdiKmhJx
	 Zbs0p+YEKIy0KuJIOZZAXPocJag5nljHPh9QqkAWIFoWvXsk9sCHhaVSYp07w8xXp0
	 f+ycs92oJ1FezDgbQVZYiw9rngOb19W6VZ/axnXi8T0yQvWn0Gk80Yx7aOF+7rEGOp
	 SpWCS7B7xRpZ12aPA4OBnnUvofYhqeO3cs2ZIHZlbLxbPx0pE/BCeDkOE2ixY60JSx
	 DF9sPavoXEwIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dsimic@manjaro.org,
	xsf@rock-chips.com,
	angelogioacchino.delregno@collabora.com,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 02/24] arm64: dts: rockchip: mark system power controller on rk3588-evb1
Date: Thu, 29 Feb 2024 15:36:42 -0500
Message-ID: <20240229203729.2860356-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit fc4657971be31ae679e2bbeee2fb8e93a7a063eb ]

Mark the primary PMIC as system-power-controller, so that the
system properly shuts down on poweroff.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20240117191555.86138-1-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index b9d789d57862c..bbbe00bcd14e7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -351,6 +351,7 @@ pmic@0 {
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
+		system-power-controller;
 
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
-- 
2.43.0


