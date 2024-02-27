Return-Path: <linux-kernel+bounces-83646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C194869CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCD22846B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B94EB49;
	Tue, 27 Feb 2024 16:47:26 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CEA1EB40;
	Tue, 27 Feb 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052445; cv=none; b=CAnoD0gjI+ONa82pgey94FVMlmmh0lME1EPOw5FZ/lrLII8jfKx7scMisgpe6w76LobK/bnLxYeo51jsfKTVr4FPA8ztR2nmhZUrWTnvUr6t+DROlEgNGcxQU1KTIVE82i2ksyiITo71hh9X/799/Mkr7kTU+WV07BeGUH4Kuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052445; c=relaxed/simple;
	bh=lB9WvV3bGuw1pVIKL43i9Syk3YH1W07y1NHUAoHcvbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBtVyUs9oS5KjEKXtvc0KDJ5ggHPhlWMxJN0YnvATxW7NsCu76lzbvATfelIIk8ySodK7FeIAnwfXapZ7sZZ7NnLv3Qwkuiox24O2GF60fOC3+OZCTJk4tHfFxLNncU6tW/Gx/8cdA5Fa5fzsSCRYq501qwFUkoxQZG3kODixjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf0bk-0006qV-IF; Tue, 27 Feb 2024 17:47:08 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	quentin.schulz@theobroma-systems.com,
	heiko@sntech.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 1/4] arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
Date: Tue, 27 Feb 2024 17:46:56 +0100
Message-Id: <20240227164659.705271-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227164659.705271-1-heiko@sntech.de>
References: <20240227164659.705271-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The rockchip,trcm-sync-tx-only property is at this time only documented
for the tdm variant of Rockchip i2s controllers.

While there was a series [0] adding code and binding for the property,
it doesn't seem to have gone forward back in 2021.

So for now fix the devicetree check by removing the property from rk3588
i2s controllers until support for it gets merged.

[0] https://patchwork.kernel.org/project/linux-rockchip/patch/1629796734-4243-5-git-send-email-sugar.zhang@rock-chips.com/

Fixes: 8ae112a5554f ("arm64: dts: rockchip: Add rk3588s I2S nodes")
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 36b1b7acfe6a1..82350ddb262f2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1704,7 +1704,6 @@ i2s2_2ch: i2s@fe490000 {
 		dmas = <&dmac1 0>, <&dmac1 1>;
 		dma-names = "tx", "rx";
 		power-domains = <&power RK3588_PD_AUDIO>;
-		rockchip,trcm-sync-tx-only;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2m1_lrck
 			     &i2s2m1_sclk
@@ -1725,7 +1724,6 @@ i2s3_2ch: i2s@fe4a0000 {
 		dmas = <&dmac1 2>, <&dmac1 3>;
 		dma-names = "tx", "rx";
 		power-domains = <&power RK3588_PD_AUDIO>;
-		rockchip,trcm-sync-tx-only;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s3_lrck
 			     &i2s3_sclk
-- 
2.39.2


