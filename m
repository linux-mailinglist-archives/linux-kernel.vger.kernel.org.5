Return-Path: <linux-kernel+bounces-116953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F988A57A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052E9307504
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51046137932;
	Mon, 25 Mar 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="qXUwugYz"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD4179FB8;
	Mon, 25 Mar 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366951; cv=none; b=N+uu7XiioFr3B8rrWkv3dIe6pa07ZFvZ39U1Us5LI20op0QobY1PBUlxrKunhuXRDxPLN6G606xqVNr7xhOidNGzkbfCoRv2Yix1O4EWerg4V+5pTySiQY6KbnxGnOiGLVrugEerap3a2pbDW5aa5xUx6+XYc5eD0YaXgdVTMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366951; c=relaxed/simple;
	bh=hEabN694l4Vs4GZeNBLusB1rNaW6tug6kVhLmI7YUxs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z2t7qqEkboe80e0ZrnytcBUNIkAr3Jih8fasoiYYgN0PpcGYRoS1H/9Tx8+cGHnzzO2Ep8L1a9cDSWDlTCTQPI2aZGv4HpnozJKxluvDihJNL6amANFONZnEr/zpmhJtE1fHe26dsNHDk905yHRzunEFn/8zHSgTLialFRMj984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=qXUwugYz; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 496EA100006;
	Mon, 25 Mar 2024 14:32:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 496EA100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711366332;
	bh=uIDHjNgEbPo1A4FBxlS0ooHDtdg7rfpWta+TckQZIFQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=qXUwugYzmv8v0s/PRYKUQdHBqGxhVaaB6+K6W2CERbs3JKNCz2ptAEmY+YxXGhdzc
	 3FlRAf3vRrBBhl0kIM3Vh5bx+yWH/oyFb+Yww5OQ8SK1DwA70vkY5gDIGZTpFGVfRw
	 mwO5QzxaHntGNV7cRuOe88LEBZAIupf4qTE5rpYWDI8P/Y5FnmPFBvAMEwAOgvwCxM
	 bwThcocv9amOlXrqY9rkl2djMJtgKn7PJpwjgQusEZ97ai//DjWgQY7LUSNl3QQF6S
	 3FucUKDm6jyXRCDWT16OdC0kAT3/9y0FXlwZfrcoJaXBp4p42Q9Rlq9JRL50m1Hqcf
	 joEVjF8FPxMmw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 25 Mar 2024 14:32:12 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 14:32:11 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Linus Walleij
	<linus.walleij@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin
 Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
	<linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] pinctrl/meson: fix typo in PDM's pin name
Date: Mon, 25 Mar 2024 14:30:58 +0300
Message-ID: <20240325113058.248022-1-jan.dakinevich@salutedevices.com>
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
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184391 [Mar 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;lore.kernel.org:7.1.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/25 10:32:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/25 10:32:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/25 07:20:00 #24426778
X-KSMG-AntiVirus-Status: Clean, skipped

Other pins have _a or _x suffix, but this one doesn't have any. Most
likely this is a typo.

Fixes: dabad1ff8561 ("pinctrl: meson: add pinctrl driver support for Meson-A1 SoC")
Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
Links:

 [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/

Changes:
  v1 -> v2: Detached from v1's series (patch 15)

 drivers/pinctrl/meson/pinctrl-meson-a1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
index 79f5d753d7e1..50a87d9618a8 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -250,7 +250,7 @@ static const unsigned int pdm_dclk_x_pins[]		= { GPIOX_10 };
 static const unsigned int pdm_din2_a_pins[]		= { GPIOA_6 };
 static const unsigned int pdm_din1_a_pins[]		= { GPIOA_7 };
 static const unsigned int pdm_din0_a_pins[]		= { GPIOA_8 };
-static const unsigned int pdm_dclk_pins[]		= { GPIOA_9 };
+static const unsigned int pdm_dclk_a_pins[]		= { GPIOA_9 };
 
 /* gen_clk */
 static const unsigned int gen_clk_x_pins[]		= { GPIOX_7 };
@@ -591,7 +591,7 @@ static struct meson_pmx_group meson_a1_periphs_groups[] = {
 	GROUP(pdm_din2_a,		3),
 	GROUP(pdm_din1_a,		3),
 	GROUP(pdm_din0_a,		3),
-	GROUP(pdm_dclk,			3),
+	GROUP(pdm_dclk_a,		3),
 	GROUP(pwm_c_a,			3),
 	GROUP(pwm_b_a,			3),
 
@@ -755,7 +755,7 @@ static const char * const spi_a_groups[] = {
 
 static const char * const pdm_groups[] = {
 	"pdm_din0_x", "pdm_din1_x", "pdm_din2_x", "pdm_dclk_x", "pdm_din2_a",
-	"pdm_din1_a", "pdm_din0_a", "pdm_dclk",
+	"pdm_din1_a", "pdm_din0_a", "pdm_dclk_a",
 };
 
 static const char * const gen_clk_groups[] = {
-- 
2.34.1


