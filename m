Return-Path: <linux-kernel+bounces-124740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F2891BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B9B1C263C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DDB179954;
	Fri, 29 Mar 2024 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AclGI4i9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448421474CD;
	Fri, 29 Mar 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716058; cv=none; b=VE/yexbhHae5yDvJErNHsg27L6StbX5atTbqlrrmDPJpuPhXJF9cZsWX9kDYkGggXQBoVl5qbgUZPj42j94AuzK/gAyiwOPMMp4Cc6ds12YgmEcBt9aVf++ORbtqcLvNVMruosu9fotBozVpcFTkoT6B6xac+W7fwwLVqROGTC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716058; c=relaxed/simple;
	bh=yHxgtU2OTtRiz2jnpK76bff4C6A+TYTVw1JRL8ZQwv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ93agsTICj4JZcLW39Vr3QTvZmdfE3kPAfRxtMQads3mFW9WRk4bGiBFb+S8On/lZUtJYZlQ77/7/ZKp/47G1H5Y+7aKQyzluyEBR0rgUQRAKEmfwHjz3LpN5oUQMp5jiVyRYynfIKRrq1DrhIlvU+KWpMjr/IKU40L1XdKv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AclGI4i9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D2CC433C7;
	Fri, 29 Mar 2024 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716056;
	bh=yHxgtU2OTtRiz2jnpK76bff4C6A+TYTVw1JRL8ZQwv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AclGI4i9q4fY0vR1zDUAERn0G5Vh5uhvtDEAs6OXpz5wxJFqne08vSJV/7lw8a/vM
	 mXXtVDtit2JU6U8bmaew1qDvLWP0lnIjeOcPLhdu4xUB1iQvBXYi1GbbnlFj2aGN+7
	 zpXRQ0FNyAj90h/0neyPp2PT/yd1Uu7ME5ilBjdXjZw5Pu57Q3uDK76S2IX0vORwXq
	 JIwvVZiJ8gxEPT5ci8LDSHgmlvolmdudCH5aA5w1+faGu8Ra6uNO7ffcDmk0SNkgJE
	 rWqr8J05BZVir0lMZ5jZsQhJUzLGTIawfwsKG43MC71E2K2UB2XcPUD16Dm//yaLqG
	 Sc4f5exrsVpFA==
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
	jonas@kwiboo.se,
	shironeko@tesaguri.club,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 31/98] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:37:02 -0400
Message-ID: <20240329123919.3087149-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
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
index 7b4c15c4a9c31..b6f045069ee2f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -744,11 +744,20 @@ hdmi: hdmi@ff3c0000 {
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


