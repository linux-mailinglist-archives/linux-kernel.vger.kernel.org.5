Return-Path: <linux-kernel+bounces-143742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85628A3CE2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AD91C20BDA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7752446A2;
	Sat, 13 Apr 2024 13:57:29 +0000 (UTC)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DF1DFF4;
	Sat, 13 Apr 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713016649; cv=none; b=qcui/jdDdyD1+gHUF9EDbCOnG0XWI9cytLOMAvfRnahmyahNp5k8V0WbNzuDlD6eo0iV2QpipOpQaRMIOQWqoCEUamUNTIGOVA0NtL1P35Id0MaRgFdQKFdLKBmpsUMlINHeLaWnrc6fXHzx9S9bjt6qqa+siJ3fd1L6uZK4Rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713016649; c=relaxed/simple;
	bh=qawpc/DTqLcugOlpFIlyHOPojCNwyUlB8c5oN7kOICo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=loQHW2sIRi8f6MMh83WICXB19R6ydQxRhtRFR3wCbgwjiydnGJ8zgMtrjsyLihxEfCPTONlfTo9R2qvb0c8q4K/xY/PQuIsvAYVAaMVFu/R+ynSyDnO97DsKPM5OSknP1iPdTmQt98NbtuZUfNXm5h9y5ufPe6TCz+dKSY8hWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from localhost.localdomain (unknown [82.64.135.138])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id BA8FE2003C8;
	Sat, 13 Apr 2024 15:57:01 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 5423D40039; Sat, 13 Apr 2024 15:56:08 +0200 (CEST)
Date: Sat, 13 Apr 2024 15:56:08 +0200
From: Etienne Buira <etienne.buira@free.fr>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	shironeko <shironeko@tesaguri.club>,
	Etienne Buira <etienne.buira@free.fr>,
	Jonas Karlman <jonas@kwiboo.se>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Avoid error message on rk3328 use
Message-ID: <ZhqO-DEmh-6TeHrt@Z926fQmE5jqhFMgp6>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	shironeko <shironeko@tesaguri.club>,
	Etienne Buira <etienne.buira@free.fr>,
	Jonas Karlman <jonas@kwiboo.se>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

rockchip,rk3328-grf-gpio is handled as syscon, but syscon mandates
presence of gpio,syscon-dev node (or it will call dev_err() when probed).
Correct rk3328.dtsi and related documentation to follow syscon's
expectations.

Signed-off-by: Etienne Buira <etienne.buira@free.fr>
---
 .../devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml      | 2 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml
index d8cce73ea0ae..2c878e7db900 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml
@@ -38,6 +38,7 @@ required:
   - compatible
   - gpio-controller
   - "#gpio-cells"
+  - gpio,syscon-dev
 
 additionalProperties: false
 
@@ -47,4 +48,5 @@ examples:
       compatible = "rockchip,rk3328-grf-gpio";
       gpio-controller;
       #gpio-cells = <2>;
+      gpio,syscon-dev = <&grf 0 0>;
     };
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b6f045069ee2..fd25d5bee19f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -296,6 +296,7 @@ grf_gpio: gpio {
 			compatible = "rockchip,rk3328-grf-gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio,syscon-dev = <&grf 0 0>;
 		};
 
 		power: power-controller {

base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
-- 
2.43.0


