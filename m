Return-Path: <linux-kernel+bounces-124613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0C891A96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326EF1C25813
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573DF15B123;
	Fri, 29 Mar 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktXLA7qL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460715B111;
	Fri, 29 Mar 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715546; cv=none; b=fy5iOq+x4/eBdUCmMHhewcpeiQX247GG7btvR/SiEuoQt23Vvk9CTMMNQHeoyFDK3uCUHHQLPwdeRe+fMr7XrgHQMvJfJcqadchn2cRJuRLOFpvCs6kBrRAGxqeBdipqvk/OUQIoHuZDq+FCQhdBtma0jWc6oVcntzFkFQWixBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715546; c=relaxed/simple;
	bh=XHHcbiSrNTwKbYxM5W9y+dP0VAGaaEp7rtcy3Rj1pQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIAnRQJ4BdyASQ5S/6Zs9nId6XVAluIXU7uSXaPQqD2w1qhjjs+DEylCu+oVJvYI7TcRl2Q66H/WzjwrbPxH9sg/hpgD0xgUCDRRg0EoWOh+R2OEjVewZShGLCaH9QMX5cUFSQkfdEJgq8QPlqXkLW4gJwRABFcne4fsUu/vlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktXLA7qL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA78EC43394;
	Fri, 29 Mar 2024 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715546;
	bh=XHHcbiSrNTwKbYxM5W9y+dP0VAGaaEp7rtcy3Rj1pQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktXLA7qLX0ajVqgr4Dz7WP90CWoKXkU8oq4Od1fj/p1tx+3Z7AaKP3yGie3kG8MAH
	 Tw8mymAutx+rII8RYkn6F6dwkZYHP5YgBUNPwbqYVL0xNQHcrt0LCZXdFORuSHG9Tq
	 bz5WkxiznStReN2H/EbPyNjRtfMUmlkmc9mMefeSrQyQOGGJQ0q/R8ILs4Byx/IUkW
	 t9uCLdSsyxWHt95z0mmLqV0uWBO4+EwknKqgZo03aPvGh5s2/EdlvT142lokeRa1sP
	 9zJRLsDUFwi+PITV4lofOPR/BdodtvS2O4N5VEKrqB4Bcl4PmNwj8dqWr2lGexEzM6
	 pgpPrWiVM2OCw==
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
	jay.xu@rock-chips.com,
	shironeko@tesaguri.club,
	jonas@kwiboo.se,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 10/31] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:31:29 -0400
Message-ID: <20240329123207.3085013-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 905a50aa5dc38..d42846efff2fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -741,11 +741,20 @@ hdmi: hdmi@ff3c0000 {
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


