Return-Path: <linux-kernel+bounces-134593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AB689B356
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC9A280CBB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C93BBD6;
	Sun,  7 Apr 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="sLDE50pK"
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8366107A6;
	Sun,  7 Apr 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712511235; cv=none; b=ZrUBPbeX3rswBmbAUYe0P1XLsEri798h22YwyR7tSD0P3wmCDlWmDqj+pOloceb2rTwsPw0Xuo82vPQPrg1MAyJFVRZz+XEMayeLOrUP3AX1Rkvt3kLJXPTsaEPKns6k4Jl/Ytr2iuj779Z6Si+4H2idzkwl6WzqDjdzZrkpQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712511235; c=relaxed/simple;
	bh=D+YvEMaAigqFWCRxNG6V+6r/6UJgBPgVSlwnDlejGAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIpC5HXUrbUHwSKW0Y+pL/qhmLp+OM7K3GUEafN1GGv/kBcdTnRUKwQNnYphiNFAflpTmgeah3Gp/aT0MUsdZEvZn4mcnL2vI2iO30uGMYFcn8iZ+P2iIACpBllk1XmZar+P7dw//CUT25EJIJ6VKDs4gwyXlVqq9PVFmHBDeq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=sLDE50pK; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f0b:0:640:2d63:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTPS id 62002608FC;
	Sun,  7 Apr 2024 20:33:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MXbpHdhoE4Y0-ZUKzSviq;
	Sun, 07 Apr 2024 20:33:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1712511222; bh=E8E7VpkTwqMaLTdo6EG4QaRlM0WpseQ15mLUPmQca6Q=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=sLDE50pKC0RnVfAPf+OcwjQdJLYn5WeinNqVd7yrv/4mAwZAOWF+wKTTWp4e8277D
	 gUVmLajXrClBzGnvoG886+bivlTmC6rusQMXbKwieFJaLETBcUC8Ov+61n9Hv9InH7
	 eGWofUiv1PL1X+Q51E8G+PjeD1XCqPp4c1OOyxRU=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From: efectn@6tel.net
To: heiko@sntech.de,
	linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	sebastian.reichel@collabora.com,
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: [PATCH] arm64: dts: rockchip: mark system power controller and fix typo on orangepi-5-plus
Date: Sun,  7 Apr 2024 20:32:10 +0300
Message-ID: <20240407173210.372585-1-efectn@6tel.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Mark the PMIC as system power controller, so the board will shut-down
properly and fix the typo on rk806_dvs1_null pins property.

Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-plus")
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index 1b606ea5b6cf..1a604429fb26 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -485,6 +485,7 @@ pmic@0 {
 		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 		spi-max-frequency = <1000000>;
+		system-power-controller;
 
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
@@ -506,7 +507,7 @@ pmic@0 {
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
-- 
2.44.0


