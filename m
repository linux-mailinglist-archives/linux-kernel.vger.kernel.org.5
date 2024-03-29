Return-Path: <linux-kernel+bounces-125424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F018925C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743A2B21FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD713AD03;
	Fri, 29 Mar 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="dp4WYq+E"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21923C24;
	Fri, 29 Mar 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746304; cv=none; b=oeDPv1xka3y304g3tIOX35J1TnknrvYUQyFlAB6lu2O5m81lLRun8kd6QBgghGqNVc45p/v/qxSUvK6wGayNNE362k7xLHX0LQLKp418frQhIK2d8Dca2gUQrE1mGOMMQt1VPBZXXiw/gNrle8M9iIbkc2Di/OpwXlThk76cRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746304; c=relaxed/simple;
	bh=U6SesKKbBSIt/fV1BNuPVF9r0eu2glG+ec+5wDOxWAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vg1genio6WeIANtnZ7rOmgV66+K3i2t/MHzObRJ4MfVg6WjyctcOnTsUiXWi8ukHQ21rA6O8uXRlSaEspmT3DzbU9Jd0P99byJ9v1xduVLE97rh6/AoFhNRbgHhsqhzg95dcJdf2sJmjIUuO20XP8C/Wqd+QgZ4o9UNfeNFaz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=dp4WYq+E; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E1CE9120009;
	Sat, 30 Mar 2024 00:04:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E1CE9120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711746299;
	bh=BOzJ/UQk73u7rYGUWad9P8uZdXKp35zw7XuG7Hha4U4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dp4WYq+ENurJPA8Zh2q4Vr7zwF/VRdSNUzuqqvGvdF/jY4VmtkW/6XCQDF8WPRG3d
	 PpE5+ZKzX5ba2KGAiK/lKN9n7gsCsrxJ+tCmyX98tP/8NncX669fVufudY6pZZzkJu
	 ECe7ZNB0Fe1O8ENHIZUmWKsby6JOCGVDGxMlKnhTjCA/tXQ3nRCYlTUVkEaZPkTqlN
	 iDUMa4bTD4Z00yZ0MEsk0IgJa8/tF+4JUXDTFWmLRTXI17eOwD+NCbbFQ17rpA+OpF
	 y00EJMdfPwtl8GtBu4q8ALhRWJ5DaRbtUJbbfZzFxTwqvg0EW1YjW2v6lWhRDwQslI
	 ehyRT/zQd6tpg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 30 Mar 2024 00:04:59 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 00:04:59 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 0/4] arm64: dts: amlogic: a1: Support CPU Power Management
Date: Sat, 30 Mar 2024 00:04:38 +0300
Message-ID: <20240329210453.27530-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184500 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/29 19:32:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/29 19:32:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

The Amlogic A1 SoC family utilizes static operating points and a
PWM-controlled core voltage regulator that is specific to the board. As
the main CPU clock input, the SoC uses CLKID_CPU_CLK from the CPU clock
controller, which can be inherited from the system PLL (syspll) or a
fixed CPU clock.

Currently, the stable operating points at all frequencies are set to
800mV. This value is obtained from the vendor setup of several A1
boards.

The current patch series includes:
    * CPU clock controller declaration
    * syspll setup in the PLL controller
    * operating points
    * CPU special power parameters: voltage-tolerance, clock-latency,
      capacity-dmips-mhz, dynamic-power-coefficient

Please be informed that the AD402 vddcpu PWM regulator does not exist in
this patch series because currently PWM A1 support is under development.
However, it should look like:

```
vddcpu: regulator-vddcpu {
	compatible = "pwm-regulator";
	pinctrl-0 = <&pwm_f_pins4>;
	pinctrl-names = "default";
	regulator-name = "VDDCPU";
	regulator-min-microvolt = <690000>;
	regulator-max-microvolt = <1050000>;
	pwm-supply = <&dc_12v_in>;
	pwms = <&pwm_ef 1 1500 0>; // 667kHz
	voltage-table = <1050000 0>,
			<1040000 3>,
			<1030000 6>,
			<1020000 8>,
			<1010000 11>,
			<1000000 14>,
			<990000 17>,
			<980000 20>,
			<970000 23>,
			<960000 26>,
			<950000 29>,
			<940000 31>,
			<930000 34>,
			<920000 37>,
			<910000 40>,
			<900000 43>,
			<890000 45>,
			<880000 48>,
			<870000 51>,
			<860000 54>,
			<850000 56>,
			<840000 59>,
			<830000 62>,
			<820000 65>,
			<810000 68>,
			<800000 70>,
			<790000 73>,
			<780000 76>,
			<770000 79>,
			<760000 81>,
			<750000 84>,
			<740000 87>,
			<730000 89>,
			<720000 92>,
			<710000 95>,
			<700000 98>,
			<690000 100>;
	regulator-boot-on;
	regulator-always-on;
};
```

This patch series depends on [1].

Links:
    [1] https://lore.kernel.org/all/20240329205904.25002-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (4):
  arm64: dts: amlogic: a1: add new syspll_in input for clkc_pll
    controller
  arm64: dts: amlogic: a1: declare cpu clock controller
  arm64: dts: amlogic: a1: add new input clock 'sys_pll_div16' to
    clkc_periphs
  arm64: dts: amlogic: a1: setup CPU power management

 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 68 ++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 3 deletions(-)

-- 
2.43.0


