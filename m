Return-Path: <linux-kernel+bounces-87461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AFE86D4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700E01F24650
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD814BF2F;
	Thu, 29 Feb 2024 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUMxhqDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0814AD2A;
	Thu, 29 Feb 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239178; cv=none; b=O6wyh8WJquiWY94X1kZo11oa1eT2NJVoo6Gy0NX0nXx13PilxKYTLLujcJjDnnxRafwSUTUC1q+Ar12FqAHxXuPXluua55NnE6PhH31mWg2j8uzt8b2PFM9tV5DQ8n2mXro9tvhjStKjs1dPzj254PGkLt4qHnOMMQQW8mpXwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239178; c=relaxed/simple;
	bh=2BdqdFEP9DNIj4Ti/gNcxrXdKA23Zc1z1zE0/5TQH0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6yfXLMA51JrYKiq61wRubxwAAQZe6grySWaCVPTeqUvwkV9JHGhX9oWrdkTbL55CkZiu8b+MJN468t+7qS9NuRpg0NNo5RMAIYF+iS9lMIZKDKu3Ccg97oiincGWvWHw3nd6k6hJS7A4mpJqckFLwHn0q41DJFPVS4+Zy84+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUMxhqDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DC8C43390;
	Thu, 29 Feb 2024 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239178;
	bh=2BdqdFEP9DNIj4Ti/gNcxrXdKA23Zc1z1zE0/5TQH0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUMxhqDv10qJS+Vt8/05i0tpnRkZcq/t58R4MEH+YesqhmS/yGJAf6hKn09wTTmyy
	 8+6H7OC2GmVqmirIfZCWzGVuEMOqSbxYwFnBvr18EqjhmMKKAs/S+FZHrtaNlSmtAN
	 YT/wjVTKulxzJwh9kbsPdjUMe8nslZGOCoPvF67fZ2c+Mq84FWZtalWMj4MnQ2DaN1
	 1wr4boaSI8IG+D+iCo5m4NdlRfaXqfojDIwLwCFQXwXP7yIPGWxQvUbDmQE7Td8Zp8
	 yBeHjcMLUH3tL3SUV5wpTKU0wTvtrUOmNOy8PAFkIm8tZPsE7uVIGF403v1VOl/JuW
	 9Zf0A7gwuCETw==
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
	jagan@edgeble.ai,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 02/22] arm64: dts: rockchip: mark system power controller on rk3588-evb1
Date: Thu, 29 Feb 2024 15:38:55 -0500
Message-ID: <20240229203933.2861006-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index 229a9111f5eb0..fa8286a325af7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -215,6 +215,7 @@ pmic@0 {
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
+		system-power-controller;
 
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
-- 
2.43.0


