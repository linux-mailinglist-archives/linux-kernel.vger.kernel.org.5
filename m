Return-Path: <linux-kernel+bounces-27965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFFF82F86F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D09DB24F77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A1F250ED;
	Tue, 16 Jan 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdf4XAfA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B992132C15;
	Tue, 16 Jan 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434698; cv=none; b=WJ3a7wc7xnAJxbnLgQtVCrryFxUONvkLxRgLhxR8/1E3eTGji/qMKnta2Y/WGK7iwtFZNZ7ajFSX1VsmIcg7odyOs/nNoS0NLceMwrweP9lCKcGfU9WLV3BFT5h8IaAioVOYSqBb0r2BpK8vRK7o4xO/nBa98a2yEWELFotx5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434698; c=relaxed/simple;
	bh=sRESA0Mf6oMOfaCCJFfjN2881zrZn5Z1Kd53N5cU50w=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ALAy7gKfkfpJNTq5HY2iEJJw5W9+Vt3U9I64VDn4Cq54p2LJeS+aat56YAxrlA581/ZSqajpU2hBmION3jnBoJuTxconh/oPg6vc5674zGRv68GYsHRTbKr1/wYr3VJTEB/VSjaeEZnraOwkP95Z1VeYkHaA+uhL8AyJa4b3MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdf4XAfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79159C433F1;
	Tue, 16 Jan 2024 19:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434697;
	bh=sRESA0Mf6oMOfaCCJFfjN2881zrZn5Z1Kd53N5cU50w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdf4XAfAwI3YbwtGvOanqQTGlvzxYN4gAXmc9KPDp6Ff/GAvLPNX2Lhf+QLvqt48m
	 8gVmlz6PF7cw1Zgr2nvclEFsJWgMj1PsyWOmUnyupkx+mpk/elmKgqorkr92Ohuvis
	 ULGUKOVvmgtxrcgPk+Wd+F/8lVZaM5N6OQijPu+cv89FEAqevkXKEff4oVWE3+raL+
	 9jrRXzSc7myla2leLoZBH/plIkzYEHNfUKS0c0sCA1lO+LE9QtUQhmd8SwQ2EV0Hsm
	 QPuQT3GV1U1BOvqmFt0bDkxfwGgeMx7gH/WvtJVj8TkOvvPOzWvcIyJ0XchJEec+Pj
	 zHds4/S1Hi5PQ==
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
Subject: [PATCH AUTOSEL 6.6 054/104] ARM: dts: rockchip: fix rk3036 hdmi ports node
Date: Tue, 16 Jan 2024 14:46:20 -0500
Message-ID: <20240116194908.253437-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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


