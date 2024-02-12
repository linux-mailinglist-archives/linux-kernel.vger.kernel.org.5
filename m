Return-Path: <linux-kernel+bounces-61768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C785165A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4251287933
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B43F8C2;
	Mon, 12 Feb 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mjFcvaqF"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADC446D6;
	Mon, 12 Feb 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745912; cv=none; b=Bd0JI77uTsuRrtqW8Kv/ba9tBoUxd0Y0EQEMAtkyOW5+NrNJNIUbHFNDD1aju9skExnDkJ9jdFdp/RU/gYOREiMG5kp9PiczdU1AVRpGuqbFK1UbLxSKq0PJL3vK1iQQHoQWadZbbnvgPigw7qhte4JNNmSnEGh1A2yt4XOH8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745912; c=relaxed/simple;
	bh=0rpZvxOQ8WFLIh69MfxLBBIT0ej+97+TsV/UNm7SwXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0UCjIBs81+JKtx9uoT98aXGeXNgLdBeQ0Dpcdvq2BrFbyihpG5ePJcgSvg5QLaQBm7lWKcL87WXc/A8e6NWnO5QboiQxoc/K2XVMbnsgw+BqXGCZA4xMYjg/Ul0RwDTj/8fgOEa440DZs1KxvN4oPsK8wCMy4aORLHY+zZY/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=mjFcvaqF; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 15A6810001B;
	Mon, 12 Feb 2024 16:51:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 15A6810001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707745909;
	bh=MDoYO53o9hjbNBR6evxCByByDzZFqFEvMI2ryoM8Lpc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mjFcvaqFFZZP+K4ihX+fP0OpfVysdxhVAG3M/PR3jy03veVUME/mIF1n/TTDkYGj1
	 05u2z2A7jQ67cEPQ0c+Zz/cJbI5rLvv+4dxaQeDoYCq8GNsTXUtfz7qNsgeXPN721A
	 UK6ZQeBMZ/sGdu/XyL9rEDM41PddSvMM3hwLB3mPk3d/AwbnH/3+28yIbgfcLQzvWE
	 vu/Ui8hWNIKqjpZ+OZSfUepxFiMUm7m9HooQNYbWuiNeOdbrJNtpeS6sa/IfMAMwoy
	 ADTATVL/s3J3oJ+peydl727g3j0khO5HLT0tvVQuj+MVTS6ndVKnDsxsXtDvVYYwyO
	 pgsMJV98niq1g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 16:51:48 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:51:48 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <vadim.fedorenko@linux.dev>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v4 18/20] arch: arm64: dts: meson: s4: add crypto node
Date: Mon, 12 Feb 2024 16:51:06 +0300
Message-ID: <20240212135108.549755-19-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212135108.549755-1-avromanov@salutedevices.com>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183368 [Feb 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/12 07:49:00 #23556813
X-KSMG-AntiVirus-Status: Clean, skipped

This patch adds a crypto node declaration for Amlogic S4-series.
With the Amlogic crypto driver we can use HW implementation
of SHA1/224/256 and AES algo.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index ce90b35686a2..dc05e2c5da3b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -339,6 +339,12 @@ mux {
 
 			};
 
+			crypto: crypto@440400 {
+				compatible = "amlogic,s4-crypto", "amlogic,g12a-crypto";
+				reg = <0x0 0x440400 0x0 0x48>;
+				interrupts = <GIC_SPI 24 IRQ_TYPE_EDGE_RISING>;
+			};
+
 			gpio_intc: interrupt-controller@4080 {
 				compatible = "amlogic,meson-s4-gpio-intc",
 					     "amlogic,meson-gpio-intc";
-- 
2.34.1


