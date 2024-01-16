Return-Path: <linux-kernel+bounces-28156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D982FAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C421288802
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F615D5BA;
	Tue, 16 Jan 2024 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpFS74fE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64115D5A0;
	Tue, 16 Jan 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435293; cv=none; b=LGqPKzoVNQQoFbm/4OU2LlRVGeoG/7MIAyQ8ZPfdjGCYoi7YNGfY76rKYIKzzjTZId3rSyJ+0IGIrc9b0giLnZmQuXKxIOKbFe9NdnQ9AJ+A7rTvdhU/afFW//Fmz930aQFFLWUy/IHPCLUWMouF3tVvjkzhJp0rtDgNoCLUViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435293; c=relaxed/simple;
	bh=8qOQ8frZW9+f6tpZ+Ls6j4lXfztphdPnW53RzJmlsDI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=stoGN8fkfyrnjLpWv2n8kpjU66vqv0FRXL61aURs8wU8p8E1zqRQ4qQs0bQJo5bGWyoKPHwlfxzn7kMZSJPJFX+xNKT6uQZ2gnbedTG1lfy9qCOI+/BmdIdERH0+fwDXGj97ovRT/fAewSoeiQe6EcQtduYL1pojpT1PG7oqJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpFS74fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C668C43390;
	Tue, 16 Jan 2024 20:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435293;
	bh=8qOQ8frZW9+f6tpZ+Ls6j4lXfztphdPnW53RzJmlsDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpFS74fEYrbUvmW7og4Lux+Kv+MltLzSWsTjRaVc1tW8pfExWNh4mB7MpH9jfb9TD
	 WE4f4sg03/XYM2wLJ6HO+mbhJAQghF2VyExf8Gj4cuC7otvJnJvYX+D18MePOtAOnI
	 vGZ9B6ELnbVKygts3u7ZH4Cgb7GSYwOHCzTPin4SO3B7p6WmD5LFS6rXBFa+2HkQJM
	 DMjrLo1YITM4lMuDPKR0dKrK/sX+bzNq2m3c7En80HmFWLtyrHRxZoLISYKJb/bkE2
	 vCbyCbPXsgyjCSPEtObvZh5HcEvj88TFXqyhQFYpo93DU0ThTk18OOpsOesp63sdZd
	 ttMSS5LA1oL3Q==
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
Subject: [PATCH AUTOSEL 5.10 20/44] ARM: dts: rockchip: fix rk3036 hdmi ports node
Date: Tue, 16 Jan 2024 14:59:49 -0500
Message-ID: <20240116200044.258335-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 093567022386..5f47b638f532 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -336,12 +336,20 @@ hdmi: hdmi@20034000 {
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


