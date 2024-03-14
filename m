Return-Path: <linux-kernel+bounces-103864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2E87C5EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2591F21CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19A14A8E;
	Thu, 14 Mar 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Pnxk4JYQ"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B311F9FE;
	Thu, 14 Mar 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458586; cv=none; b=bEoGfXO1HMXzlkHlL0QFHysRbubJL/iYR2MOMOoeeMJQVKgsS/egAf0TLvkSK5cMweYiApDTbQ7qPRin+vw9YHjIFgXEwnnt88dp1kfdxDVNjjTQzr8mQZFRbZqUWycyrH/URYlQsouQiIoroJT1tnZ36dwIOfig8LyIRkn2cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458586; c=relaxed/simple;
	bh=IzEKonS3Rk9mP1viG+w4DpVU37kIVPLD3KQHL9qY338=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKPwsMsy1eCl4QyEV+LORnySUY1H7ZziiXAZviS/UXASuHMBXXNm2YWyy9X/XBYOx+qGCgX3Zs5/40dzz0m2K6zewWRsDcotWE982hFy3+WrWjAJ1pssRIftt67F1wrEflMIE//ONsx66/Fgnc4DLlmDXW3OrOiYMCBMkbI+aUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Pnxk4JYQ; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BFF02120005;
	Fri, 15 Mar 2024 02:23:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BFF02120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458580;
	bh=JVEInx1VsQ+k5oHrMWuJJb1gmeD/iUbSkd2IAOMDuc8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Pnxk4JYQBKVCYVvRS/2Brp3Ukypy7RKzgprVi0yh+stIP98DPYmv5GriGrKlsewzg
	 3eXevzf8rSqB2LMWKc+LISmVwiqWdNiDdr+EfgZKhADZPTmuFZnHH4IzAdxe4bTaHD
	 4YlOa3nz4MC9X2xzM5xvSihLRVnjnNGnIPSpniXSG1N35YIqAskEkbcRjr9Q7MMIRw
	 nM3xaSeEKQgnG8lWaNUvWoEYd+fLsZUfLjRZ/T6inuQfXk5pcY9e9L6TUkEg+QX/w0
	 vMStx9edszET+iCpoomFrDZh3fz96XwHjIMKdVHDZ1kd0/Ks1ZzRyNWb0PiH/rJTJU
	 IjJsqsBvZNY9Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:00 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 02:23:00 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
CC: <kernel@salutedevices.com>
Subject: [PATCH 01/25] clk: meson: a1: restrict an amount of 'hifi_pll' params
Date: Fri, 15 Mar 2024 02:21:37 +0300
Message-ID: <20240314232201.2102178-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

Existing values were insufficient to produce accurate clock for audio
devices. New values are safe and most suitable to produce 48000Hz sample
rate.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/a1-pll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index 4325e8a6a3ef..00e06d03445b 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -74,9 +74,9 @@ static struct clk_regmap fixed_pll = {
 	},
 };
 
-static const struct pll_mult_range hifi_pll_mult_range = {
-	.min = 32,
-	.max = 64,
+static const struct pll_params_table hifi_pll_params_table[] = {
+	PLL_PARAMS(128, 5),
+	{ },
 };
 
 static const struct reg_sequence hifi_init_regs[] = {
@@ -124,7 +124,7 @@ static struct clk_regmap hifi_pll = {
 			.shift   = 6,
 			.width   = 1,
 		},
-		.range = &hifi_pll_mult_range,
+		.table = hifi_pll_params_table,
 		.init_regs = hifi_init_regs,
 		.init_count = ARRAY_SIZE(hifi_init_regs),
 	},
-- 
2.34.1


