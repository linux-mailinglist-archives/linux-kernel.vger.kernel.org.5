Return-Path: <linux-kernel+bounces-124641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A2F891AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17341C25EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178041607B6;
	Fri, 29 Mar 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kon6dTOc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B361607A2;
	Fri, 29 Mar 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715610; cv=none; b=R5GzEMr/uSbNMJCrrUYuLthlwEH/Ub9bRXF6UR26x+aPGW+0oBlQdBV/30wWjZ3uQtxzhEDD6Fz+iryhE+SIox8Vyj8d8ckzm8bIKSwNGfm1V+r2SFi6PdiI+mZJpS3Po2yKrOwp8j0X+nOgEbrWl7GUU4kruJWC3uABflCMafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715610; c=relaxed/simple;
	bh=7N3CJhPsRMlpeKmyoDFHiXmED3LwVA7upRbobm8TQj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMvnZ5oThNvt2hHFzEsZ8AGKMe+T0ynCW4Ppg3lPIFEg1YYhyWG2iXo4oVwEOMNposlSJ/9YPwofHuYSaMnjmm38meTtg0b8xujSFMES2b29qzOplrLumrlwVLOwZjohLT5e6KgWYuOOgk0anZz9ch2Nh9sBjY79iWvA8VUdr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kon6dTOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E45C43390;
	Fri, 29 Mar 2024 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715610;
	bh=7N3CJhPsRMlpeKmyoDFHiXmED3LwVA7upRbobm8TQj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kon6dTOcRWhp80a1rFuJx7/qk0Ng0LuDddZSc+z4vqqx+ze0V7oQbrd9RaCoJ/zYl
	 OYy/fXBUZn1m8vyrMOfi4LM356xdwO3bMdkzz4UMCyoqvJek6wGAc5hu/psMnpkpiS
	 zlQN0tZPABmhQ0TjbPztq/LMoQkxR/IEbLz5LtuKXamXrNOvePCS6mXrcMcrcsc0jS
	 slGJnDm3jgHmN7464hxJm5ljAUVEGEjU9uOv7L81rjmtIsqs8UGx+7Tm4+zMgBxp9g
	 kvKayVPsgHJpYIyj58oDfasrwxuu2apLKrcB/ufbFGlYTl+H1QORptwqWu218VOrEC
	 LLL9B7ov+T6OA==
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
Subject: [PATCH AUTOSEL 5.15 07/20] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:32:55 -0400
Message-ID: <20240329123316.3085691-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 3cbe83e6fb9a4..26f02cc70dc5d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -728,11 +728,20 @@ hdmi: hdmi@ff3c0000 {
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


