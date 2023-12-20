Return-Path: <linux-kernel+bounces-6540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D1819A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28BD282E36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55A18AF6;
	Wed, 20 Dec 2023 08:09:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-79.mail.aliyun.com (out28-79.mail.aliyun.com [115.124.28.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D561BDD5;
	Wed, 20 Dec 2023 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cyg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2314591|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.458863-0.00232898-0.538808;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=40;RT=40;SR=0;TI=SMTPD_---.Vol0DEB_1703059736;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.Vol0DEB_1703059736)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 16:08:57 +0800
Date: Wed, 20 Dec 2023 16:08:56 +0800
From: fuyao <fuyao1697@cyg.com>
To: Rob@debian.cyg, Herring@debian.cyg, robh+dt@kernel.org,
	Krzysztof@debian.cyg, Kozlowski@debian.cyg,
	krzysztof.kozlowski+dt@linaro.org, Conor@debian.cyg,
	Dooley@debian.cyg, conor+dt@kernel.org, Chen-Yu@debian.cyg,
	Tsai@debian.cyg, wens@csie.org, Jernej@debian.cyg,
	Skrabec@debian.cyg, jernej.skrabec@gmail.com, Samuel@debian.cyg,
	Holland@debian.cyg, samuel@sholland.org, Andre@debian.cyg,
	Przywara@debian.cyg, andre.przywara@arm.com, Tony@debian.cyg,
	Lindgren@debian.cyg, tony@atomide.com, Jisheng@debian.cyg,
	Zhang@debian.cyg, jszhang@kernel.org, Neil@debian.cyg,
	Armstrong@debian.cyg, neil.armstrong@linaro.org, Linus@debian.cyg,
	Walleij@debian.cyg, linus.walleij@linaro.org,
	fuyao <fuyao@debian.cyg>, fuyao1697@cyg.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: =?utf-8?B?6bqm5qif5qif?= <maijianzhang@allwinnertech.com>
Subject: [PATCH] ARM: dts: sun8i: r40: open the regulator aldo1
Message-ID: <ZYKhGL0gH6MvUK_H@debian.cyg>
Mail-Followup-To: Rob@debian.cyg, Herring@debian.cyg, robh+dt@kernel.org,
	Krzysztof@debian.cyg, Kozlowski@debian.cyg,
	krzysztof.kozlowski+dt@linaro.org, Conor@debian.cyg,
	Dooley@debian.cyg, conor+dt@kernel.org, Chen-Yu@debian.cyg,
	Tsai@debian.cyg, wens@csie.org, Jernej@debian.cyg,
	Skrabec@debian.cyg, jernej.skrabec@gmail.com, Samuel@debian.cyg,
	Holland@debian.cyg, samuel@sholland.org, Andre@debian.cyg,
	Przywara@debian.cyg, andre.przywara@arm.com, Tony@debian.cyg,
	Lindgren@debian.cyg, tony@atomide.com, Jisheng@debian.cyg,
	Zhang@debian.cyg, jszhang@kernel.org, Neil@debian.cyg,
	Armstrong@debian.cyg, neil.armstrong@linaro.org, Linus@debian.cyg,
	Walleij@debian.cyg, linus.walleij@linaro.org, fuyao1697@cyg.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	=?utf-8?B?6bqm5qif5qif?= <maijianzhang@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: work_work_work

the aldo1 is connect regulator pin which power the TV.
The USB core use TV ref as reference Voltage.

Signed-off-by: fuyao <fuyao1697@cyg.com>
---
 arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
index 9f39b5a2bb35..8906170461df 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
@@ -42,6 +42,13 @@ &pio {
 	vcc-pg-supply = <&reg_dldo1>;
 };
 
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-aldo1";
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1800000>;
-- 
2.39.2


-- 
CYG Technology.

