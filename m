Return-Path: <linux-kernel+bounces-151439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B98AAEF8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEA31F22D97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0998128811;
	Fri, 19 Apr 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Gw+XRuSq"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF498614B;
	Fri, 19 Apr 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531638; cv=none; b=YSh+na2zc+ORXW6yD3QAnyFvypM2ZaCytr1v6nimYEWXJIx4nOx5ji+xhTK9MhWpHL8z32/w3LTGmpA3GSheiDz/mK3hMU/CMu1Gb1kRuu08UZfu5uvZ/5NwK9MHSM6gy/RP17Pj5iJXflWwr2QqJvsybmPHC1ZLnrIyMmtjJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531638; c=relaxed/simple;
	bh=DElho3Mb/w3HK6/xOXgygEqefvf9rPBbVa1vqoCNYT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rouvS4Io2JITUG5C+LUPr72El0/6pEHZO5HF54Nq2lVfFFrDOj+9Ck+Y4lUPQ/lNqKRl9NuQuiadvngBO4LuXn+DTgyrtWS62K1HneKCrjznT5mw8ufjOt8JdMTv85OzbODj3wyF4wvZtZP74N1CosqC7M3Djeg2v8zZklGtTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Gw+XRuSq; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1159D10000B;
	Fri, 19 Apr 2024 16:00:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1159D10000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713531628;
	bh=KIuGAr064Uhr/J/wzqdUXxyIs1qnbRClXG3hlcnxZzs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Gw+XRuSqvKMjnf+7GtKvUJLYy8p23vmHiIZhAPW3gc5DUUg3NwXJlYvMGhaaQG3ug
	 hDFEB3UGCPGeiNU7X/LEwGpGq/p3H5FKrcohaXgKKPI8phcACa7pafFAEWRd6MCI5R
	 AoHeqfRPLnGOfgJgOGP6K41uQnPKZRGZs9Repo9FOqjb5KZzcEvTgHFneOmyKytik9
	 7CLURLQ61RSVobjCE55L3soLmBLNs/YGhBQ7AJMqWxWHR3STwomfqWgH8ZSyKqHJSe
	 shlTG0X5gWjDAVyZDYCFCNX9mE4UfDpzlEzArNbJk2EJynaI53uVnMZkw3pNfLRVMX
	 87kPj3gLomS1A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 19 Apr 2024 16:00:27 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Apr 2024 16:00:27 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v3 3/6] clk: meson: axg: introduce AUD_MUX_TABLE() helper macro
Date: Fri, 19 Apr 2024 15:58:09 +0300
Message-ID: <20240419125812.983409-4-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184806 [Apr 19 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_smtp_not_equal_from}, sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/18 23:49:00 #24865988
X-KSMG-AntiVirus-Status: Clean, skipped

This macro takes into account ->table property of
'struct clk_regmap_mux_data'.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/meson-audio.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson-audio.h b/drivers/clk/meson/meson-audio.h
index cbcdbd487d4a..1947c6cbf233 100644
--- a/drivers/clk/meson/meson-audio.h
+++ b/drivers/clk/meson/meson-audio.h
@@ -17,9 +17,11 @@
 	},								\
 }
 
-#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags) {	\
+#define AUD_MUX_TABLE(_name, _reg, _table, _mask, _shift, _dflags,	\
+		      _pdata, _iflags) {				\
 	.data = &(struct clk_regmap_mux_data){				\
 		.offset = (_reg),					\
+		.table = (_table),					\
 		.mask = (_mask),					\
 		.shift = (_shift),					\
 		.flags = (_dflags),					\
@@ -33,6 +35,10 @@
 	},								\
 }
 
+#define AUD_MUX(_name, _reg, _mask, _shift, _dflags, _pdata, _iflags)	\
+	AUD_MUX_TABLE(_name, (_reg), NULL, (_mask), (_shift),		\
+		      (_dflags), (_pdata), (_iflags))
+
 #define AUD_DIV(_name, _reg, _shift, _width, _dflags, _pname, _iflags) { \
 	.data = &(struct clk_regmap_div_data){				\
 		.offset = (_reg),					\
-- 
2.34.1


