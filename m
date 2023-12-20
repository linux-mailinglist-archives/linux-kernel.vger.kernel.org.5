Return-Path: <linux-kernel+bounces-6604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D667F819AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148F21C20B95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5021D528;
	Wed, 20 Dec 2023 08:49:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA21C69D;
	Wed, 20 Dec 2023 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cyg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2025447|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.458863-0.00232898-0.538808;FP=4633144898312032682|5|2|17|0|-1|-1|-1;HT=ay29a033018047198;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.Vom0D41_1703060323;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.Vom0D41_1703060323)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 16:18:43 +0800
Date: Wed, 20 Dec 2023 16:18:43 +0800
From: fuyao <fuyao1697@cyg.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Paul Barker <paul.barker@sancloud.com>, fuyao <fuyao1697@cyg.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ARM: dts: sun8i: r40: open the regulator aldo1
Message-ID: <ZYKjYypuAx7gNuam@debian.cyg>
Mail-Followup-To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Paul Barker <paul.barker@sancloud.com>, fuyao <fuyao1697@cyg.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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

