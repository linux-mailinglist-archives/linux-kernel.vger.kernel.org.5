Return-Path: <linux-kernel+bounces-125425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA408925C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBA1C210C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7513BC02;
	Fri, 29 Mar 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="l6y24Rg/"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A581E525;
	Fri, 29 Mar 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746304; cv=none; b=vFnh3xDV2s3praav7K/5REw9SXfJDJoUiVax3rnqXx0SSyUq7s/eVYWLRhdR3DvOpYi9bL3wk9l+BOXAzFXwOLvMRIWMpQIy+AUODZ3CPU0KLBM5oeaYjO8/Vzct/2kbWp7nT2l+v64yJZi0deOvRbWtIRXsFOAGljS5kgNjYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746304; c=relaxed/simple;
	bh=KRZYwJVZ0EXujbN/jUGuChYUOeH3mlMMjgyJ2q8cJks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac8HeZAWjv88tvevoh1YjdA/x+g+RIVWK8rJ+gw+Tva67iEZ6M3KXjE6goky5+ZK+XMdwSxHzV5U0U1MVB9UEU4ZSpzgNaiN82rdOB1xsNgoV+UuqtTqwbTTbkoqcSR4S2BG1stu8LngGhzRzYXCv+hHBTpNsXGgwnTvy3E2inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=l6y24Rg/; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BC282100002;
	Sat, 30 Mar 2024 00:05:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BC282100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711746300;
	bh=+4XbIgsid1u5cLeJIgzo1ObuehJVNiWlmImPNvMCY1E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=l6y24Rg/0JLs3D+XuvGf4WItjkZhp7klgqURqAPYZhSTW+xjzbF//gMTSjNSNbAzA
	 2BDaoDuKR1vFk5HJtx5yXIIrSmdcDtDfMeK9FdICEnNDcE2xq+jz6f1vgOXbVlBBVe
	 xm94BFr1ubOPrL/F96yE5JTDXMRmrDvCHD0aqIiMv21sZ8/6p8YpdgSd1LV97TUmrW
	 A1VPeOAcEksqZ3yiHa0Ew3DhClx4ohQJuxqbtfqEJIU1lY4nKrU0j9hQtLhvjh0sWP
	 yBmr9You5imfvkJ4I+z55tbyzok3DiYlt5fylXjDpKYrfCQyHE/bl9oKNZH20rzFB4
	 jFcswdMGZAmyw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 30 Mar 2024 00:05:00 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 00:05:00 +0300
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
Subject: [PATCH v1 1/4] arm64: dts: amlogic: a1: add new syspll_in input for clkc_pll controller
Date: Sat, 30 Mar 2024 00:04:39 +0300
Message-ID: <20240329210453.27530-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329210453.27530-1-ddrokosov@salutedevices.com>
References: <20240329210453.27530-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

Input clock 'syspll_in' is needed for the 'sys_pll' clock and is
inherited from the Peripherals Clock Controller.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 6f0d0e07e037..8ae944bfeee4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -895,8 +895,10 @@ clkc_pll: pll-clock-controller@7c80 {
 				reg = <0 0x7c80 0 0x18c>;
 				#clock-cells = <1>;
 				clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
-					 <&clkc_periphs CLKID_HIFIPLL_IN>;
-				clock-names = "fixpll_in", "hifipll_in";
+					 <&clkc_periphs CLKID_HIFIPLL_IN>,
+					 <&clkc_periphs CLKID_SYSPLL_IN>;
+				clock-names = "fixpll_in", "hifipll_in",
+					      "syspll_in";
 			};
 
 			sd_emmc: sd@10000 {
-- 
2.43.0


