Return-Path: <linux-kernel+bounces-60030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA384FEDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9739D1F237EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A77210FB;
	Fri,  9 Feb 2024 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="NAKyYun/"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18848DDC3;
	Fri,  9 Feb 2024 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514117; cv=none; b=t6jYDDbxP7v8tBAYq4Spsm2J1n0ln7RZWds7xuVN4XzIxIHBt3zxDqbN0LUDW2T3LlFfl7fwDloltWBd5CqxopZ6kkK5dD+z1anlR2sMjoN9Rn/Zch8NU72Kvf/2JaYdR5Jrn88Y+UAYgHXTkIKQVk0I/mFBC7tZ9y/BTdGszjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514117; c=relaxed/simple;
	bh=+wSk16rWtWzHXM9Q9SlcXKZL7HXEw7oUA3RQJn4rL5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kX18l8tYnusKLrbTIHf0YcOSB/N6Mqhfcpe2cUibUUlzPFHk8uZu0vJt3A1oYvii9O7uzqi/JuYo+r11V24Vx0qwViOisTM4n1U0GkNODyCci9v+zRojsvZVEysyhcJnm/SY5+mzompnx9yqxrPVdokHcRFdgz8ZlLGMFh949Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=NAKyYun/; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 15EB2120012;
	Sat, 10 Feb 2024 00:28:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 15EB2120012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707514107;
	bh=UksBPVFmefUFUHqRznndwrxhRo3WIvAX17OojuW++vk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NAKyYun/KMWjbEBPsY60+209iu7D1M+61o46g0yJz71Lt1goi9WhHBRYTcaMcT1nj
	 b+pQHQn8O5PAqV+m6ER1to5UnWEQD9/jy9PJhusqlOudl+ncHYs9vT+2pJzEXM9x1J
	 9NX/2WELBUTkQ6RigZCfWk1Qst7xwtxJvomJkBefaFvlwLT7l9+wsAl6++oZ9B00PI
	 XIZCvmrPRDN6oMY41hvkZuv6rCrVmb6n0Q8exETslA2OojC/1k6JnM/wOvy50hw/oU
	 RdpC33l9HVDnqD3oAcLbQtvJpwLoT2KOuNevWoB7pFZfU+Y1WasYqj59KFvGbNRNqk
	 4PDJ6KWZq++Ew==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 10 Feb 2024 00:28:26 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 10 Feb 2024 00:28:26 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <adeep@lexina.in>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <conor+dt@kernel.org>
CC: <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
	<rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 2/2] arm64: dts: amlogic: axg: initialize default SoC capacitance
Date: Sat, 10 Feb 2024 00:28:06 +0300
Message-ID: <20240209212816.11187-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209212816.11187-1-ddrokosov@salutedevices.com>
References: <20240209212816.11187-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183341 [Feb 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/09 20:35:00 #23447606
X-KSMG-AntiVirus-Status: Clean, skipped

The capacitance value is required for the usage of the cpufreq cooling
device and power_allocator thermal governor in the appropriate energy
model.

It helps to compute the power estimated by the SoC at the appropriate
frequency. If it is the frequency of an existing OPP, or at the
frequency of the first OPP above the requested value otherwise.

The power is estimated as P = C * V^2 * f, with C being the SoC's
capacitance and V and f respectively representing the voltage and
frequency of the OPP.

Since AXG SoC doesn't have SCMI protocol support, we need to initialize
capacitance using the 'dynamic-power-coefficient' DT entry. Its value is
retrieved from the vendor kernel, and it gives us the following
freq2power mapping:
    +-----------+--------+
    | frequency,| power, |
    |    MHz    |   uW   |
    +-----------+--------+
    |     100   |  10354 |
    +-----------+--------+
    |     250   |  27104 |
    +-----------+--------+
    |     500   |  55447 |
    +-----------+--------+
    |     667   |  77327 |
    +-----------+--------+
    |    1000   | 129024 |
    +-----------+--------+
    |    1200   | 164656 |
    +-----------+--------+
    |    1296   | 192489 |
    +-----------+--------+
    |    1416   | 239870 |
    +-----------+--------+

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index ea96fef328e8..6d12b760b90f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -74,6 +74,7 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			dynamic-power-coefficient = <140>;
 			#cooling-cells = <2>;
 		};
 
@@ -84,6 +85,7 @@ cpu1: cpu@1 {
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			dynamic-power-coefficient = <140>;
 			#cooling-cells = <2>;
 		};
 
@@ -94,6 +96,7 @@ cpu2: cpu@2 {
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			dynamic-power-coefficient = <140>;
 			#cooling-cells = <2>;
 		};
 
@@ -104,6 +107,7 @@ cpu3: cpu@3 {
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
+			dynamic-power-coefficient = <140>;
 			#cooling-cells = <2>;
 		};
 
-- 
2.43.0


