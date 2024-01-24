Return-Path: <linux-kernel+bounces-37048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8BA83AAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7ACB2D0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA977F08;
	Wed, 24 Jan 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="uZPRmfDo"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CD960BAC;
	Wed, 24 Jan 2024 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101605; cv=none; b=dl8SgbWYZOk2GUABJtTXRaJG8uEFQYD6JxFrX0Bfl7rzX3JbrA0+YfsNneoMF9s9Lcrg/2BhfHSv6RjolAObCeUMFjb/ED7YFFRN4yi3V10R11csT5LOlU4VZZ6Ho34jZVtynUUohuW/QQ0694hcL2bZkDN5LOt1Pvh56DAtC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101605; c=relaxed/simple;
	bh=FNsi1MgnOiCafwg2BDbZxoXkj+iUycBe8HXoYwKqzMg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdPCmU2m5sozjVo88BKPbwb+FVN7vkPUw4HjEl8gCLjnqRsL00hiPcUmK0mI4dt7xwEhrThffe8WBI7ASJhecxBquGi14lWtBNQUvJD9oqsCo1aG//W2IqmHA4GzIFJB+UAKUHEUp3tQHTS8QqB81hhWdx436oSayyGBj1QPKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=uZPRmfDo; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2D63610000A;
	Wed, 24 Jan 2024 16:06:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2D63610000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706101598;
	bh=zsaAaLH6CJR21EnkfyKWpwpt24RWdug8/kf9Nmutwtk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=uZPRmfDoQb5g2BQ5jsyq/TzsVOm1HBSDitGpyhC/BnFNLtuBpXV4UZ/1PnoR1v1+r
	 6qzJaVFiIX8wIdWxXTV0zfM4igd4rrTJZqvGXWhj9gvZ68xjnhfzjoDG0135SgHKiY
	 9WtLkvcuUT9hfbBecjS+jINhfi/nJnUphA95n+xnY4un1IJYrL7s0ZfZpeYHUHFLiC
	 4q3EBQfKAsLqk86jqpnjinde/CcfPdlIvh0gfGQhoF0iX/pjRSyWQxxqIy+KRKOWXY
	 9E+pGec/yTGkntT8Q3aBjf4RCqlcDW3aPl5Ug/eEI/gHGqCIQDNi0LEs2v8s9fbkTh
	 SGowzrEJgXegg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 24 Jan 2024 16:06:37 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 16:06:37 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC: <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1] arch: arm64: dts: meson: a1: add assigned-clocks for usb node
Date: Wed, 24 Jan 2024 16:06:23 +0300
Message-ID: <20240124130623.3471236-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
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
X-KSMG-AntiSpam-Lua-Profiles: 182891 [Jan 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/24 11:47:00 #23399457
X-KSMG-AntiVirus-Status: Clean, skipped

To ensure proper functionality of USB, it is necessary to use
the rate of 64000000 for CLKID_USB_BUS. For instance, adb may
not function correctly without this setting. This information
has been derived from the vendor SDK.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index cf150f568335..b9fd69112535 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -668,6 +668,8 @@ usb: usb@fe004400 {
 				 <&clkc_periphs CLKID_USB_BUS>,
 				 <&clkc_periphs CLKID_USB_CTRL_IN>;
 			clock-names = "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
+			assigned-clocks = <&clkc_periphs CLKID_USB_BUS>;
+			assigned-clock-rates = <64000000>;
 			resets = <&reset RESET_USBCTRL>;
 			reset-name = "usb_ctrl";
 
-- 
2.34.1


