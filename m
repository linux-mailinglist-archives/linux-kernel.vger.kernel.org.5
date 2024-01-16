Return-Path: <linux-kernel+bounces-28049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F582F98D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7586E1F28BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310D14532E;
	Tue, 16 Jan 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFKU6jZa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AC14534A;
	Tue, 16 Jan 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434982; cv=none; b=AySOe8HaxoFwFPxh6t8pxIIljStzSJRl50uuFMlA6kJ9TNv66lY0k+kOopcoEpY80hmkKvd1UxGRsPg/M49G0t5RZ25nLjnbhE7SW7icdOZvQHBr9IlLYv8sP8JiBNPzXirjcinbqdtBnKRjU46NtV4w61o2QBEdvlKTBZhZyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434982; c=relaxed/simple;
	bh=yhfYtwX6EWd5ukJgS4fQLmoXspnxsbldpZx2hO1RNK8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=totqfrn81BLDSBzPpoJA3qLuk1x2ymUGgxZEZ4IUN+5KuyL2qTKfUbDNVydZG/8bagKsxYsIkaNfCD44gOA1MR7LSCsXqU6udGGmocjuEz7Ux/Tp8ACady8pwNdjc/7irv7wEKpdhDJgDZowxRORHVQSTBNCTvWBO4g6pueMmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFKU6jZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F189FC43390;
	Tue, 16 Jan 2024 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434981;
	bh=yhfYtwX6EWd5ukJgS4fQLmoXspnxsbldpZx2hO1RNK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFKU6jZaotqh9cwgbkQlgtaer/qQPtL5W+65UhwQ2rTOF7mjaHaSIkZRK+FV3RLxg
	 K18GsX/cSfhFKqwngNVP+qo2IISkGjedMHjj7MFqk9L22tmFbA0n5axPjLA/YzrRIq
	 SKA/t2EcacCXhHkci4meNKZl7llYy8g1LXpTN2HRVXotbc0halHs2B5bV33/V+BmO3
	 HZ8JR12VFIMyTHLNVhebZjksnTrmwgE/cV624M409PaDLzk+m9mEriTbHmcnCEa9ah
	 ZpDT4m6L6EcTJXuuWpz93dzh4pcqhEC4gyt1M4yFWez/bEeBYgT/iKeIum51Hex24T
	 KhZ08q2Sp/QJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 31/68] ARM: dts: rockchip: fix rk3036 hdmi ports node
Date: Tue, 16 Jan 2024 14:53:30 -0500
Message-ID: <20240116195511.255854-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
 arch/arm/boot/dts/rk3036.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 78686fc72ce6..c420c7c642cb 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
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


