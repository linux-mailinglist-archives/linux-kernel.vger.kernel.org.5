Return-Path: <linux-kernel+bounces-124684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4C891B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B99288C30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62731428EF;
	Fri, 29 Mar 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj8cVY0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E69172771;
	Fri, 29 Mar 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715697; cv=none; b=E86IFo4dplO89qQ5EqvBx2bFfIroHQSAI/e6IAr7b4AX4YXTklzy4yWqfIGcmASOXAeaS0WCxs9jIntCKGI4EYM/PaWEaVGN+UlCC2fHSjfB2W8fl7AfD/byl9+jC1ym+m4I2zIBDlO28hhFT4Vs47tTY2ppL4sn9WUEXrHAJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715697; c=relaxed/simple;
	bh=sHUhxif8Mj7FBTMgP1JlQscVfmV99ViSxkXzdJZaudk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpEIngA9zoTdVIgYPPQvZG3ZNpOyyHULZjGMrH44R6zbyGvyNqMFt2iBR6KqHo9v49hzap97smvak5LWhu75rosOgBvgr84PNdYcm631qOPJgztQPNBDXj1ei8HLhg8DqJk2YyjtbIxCLdGBKi/4VRSIRA0C0YqWCEo38IWUMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj8cVY0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D4AC43390;
	Fri, 29 Mar 2024 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715696;
	bh=sHUhxif8Mj7FBTMgP1JlQscVfmV99ViSxkXzdJZaudk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tj8cVY0Yn9RuannK0DZW6PFma9cEhO+4q2BOwnfvWks3ntLqIucw8PCJ6yYarwVku
	 xMJKWgSgYx6B+wPYsdhuhXi/M9poVdZCrGcHm+epEuX5taqNw94PqhaciEr2BfMnk5
	 cV0qxz+295v0wqT0IqpgGpTgBLUmORfNhyxR52KCfUbkwxDdWuK0/nkkXSwFqHhgXf
	 bNwHmZMV2DpW0A8QnLAIgMSPF84osGrsbwYihtRLGrkME1YCRcIrWj74wC3VWVgxl6
	 Ocao8eE7iM/b+4w+MTM4CA1JWiU36vORwUiwGUjLEpmNayDA7ji+Ky6uOKtnwSSeb3
	 +VesB3t+hUH+w==
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
	shironeko@tesaguri.club,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 06/15] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:34:29 -0400
Message-ID: <20240329123445.3086536-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
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


