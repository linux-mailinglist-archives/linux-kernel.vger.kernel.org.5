Return-Path: <linux-kernel+bounces-124568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F98891A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FA7B24900
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC05154BE8;
	Fri, 29 Mar 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7Ql4rgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855115382F;
	Fri, 29 Mar 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715425; cv=none; b=Y9pKG9+q8I0w94LgXdCzDOae64cK9NbN8hDaM075bDcjC6BSnPDvzA0hNDZzRrZCrE+hTtk3lz+S03z+5bEGRwPJve3SijrWJw9XSM28gOil0aL1anSGkuf623VTpaS81Gi6UH4wn703JKZv2CZx5QohR29uhVsOcQl8bFcBImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715425; c=relaxed/simple;
	bh=1O8WeNlxDS48rttxgb2bRu0jWhzK9FcC7muewo1Lu1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+2ArjrPJGCj28WkNQuCNGcvqg1BSWY6aMMl/lBRsGxjayImMQ1Fwg25mh1EvLo5JoDNA6/F0eJwkceXyHThZTFhtBUS88buUFC7dxAdXuuW8ecPGVsWz96na8OuSEcIVa8EqNjUDWankFPSVKdUTdJRsMsOD6p5+aCKBGEdePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7Ql4rgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3961C433F1;
	Fri, 29 Mar 2024 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715425;
	bh=1O8WeNlxDS48rttxgb2bRu0jWhzK9FcC7muewo1Lu1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7Ql4rgTcgACTJ/x0mAz2QyBNy9eWOAmL1czWkM92WYDnAqt0zHiTVtYmxFRyuKuG
	 Ipv4t8COY4STTPIEnzO9+D/Eqy07bPw7zZu4uVeWiODqVdKnbmMf3mhR8yCVX2mdO+
	 ASZQcDt1R/Rzwkg73lmtEQdAxxJSNmxx8pWAdwLDK66nPbg8f3HfNmaYAxrryS7TCk
	 TaHo26aib4uFQsXvAY6jkPNKdz4aQ7kjTi/tbxbzxbLoPrAnN5QhsFvNuiRBq0M2TC
	 3raKe478TrXPtLKOgN5Pzjc7tgpIHubl60ozXHoBCTTNDhiGN/59dQUrWgyAoX1ekc
	 yN4kgJykOgFHQ==
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
Subject: [PATCH AUTOSEL 6.6 17/52] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:28:47 -0400
Message-ID: <20240329122956.3083859-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index cc8209795c3e5..3778fe5c42a4b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -743,11 +743,20 @@ hdmi: hdmi@ff3c0000 {
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


