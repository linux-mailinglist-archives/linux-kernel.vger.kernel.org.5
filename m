Return-Path: <linux-kernel+bounces-109129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000B881505
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0164D1F21D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E34B55783;
	Wed, 20 Mar 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gR850vVy"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA375535C6;
	Wed, 20 Mar 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950131; cv=none; b=c9jHQuQVZs/QJ7Zkc1lQIHxZU7T/mBmu7w/ImZy4k59svrSkE7NxMdw+vpmznZfEobF7zUqnu5642m3jdwfcXgB9n/xL34hs/hGwQKm02Bw4/3pkgUhEeFSkgq7l8eg0em/lp8mO9Bs2SXMd/FcwtcVoSE9mTyT76/4Qu2ZivpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950131; c=relaxed/simple;
	bh=sp3m9QbQYAXBlVFwOK2kAiZEr/oN/nC07ZZpFV7dV0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJrxw7O39UpoqaOJ/CblveeomlfE8kNrkGFzB/64dGwBvBQpgm2a2OgiblNn/EQWdagpG703MdsVxDE+JB007vRuHWC9WbTw/rS54SFXR1TP+xXYjkWA4oIWathX60MktB/ekeV16J9ja8pa4bN6r1iTLiGeLgZPR5EOE8yyADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gR850vVy; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 53A81120016;
	Wed, 20 Mar 2024 18:55:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 53A81120016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710950121;
	bh=xFwkKn3odkHNxtGC/+UItpOw2vtOIU30piZ6aaGUN60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gR850vVyvX4goW3VAE/NlP5pFm5ALCRU+0SHhT7pKeBMkwXzqU5dOXbYmkC2Xy9RW
	 xZJRmTF7xDfpk0gSj7jMHyzdbGDD2XnUaQlKB0ydqR1cELDzUnWjs/lJt/J22k/hvV
	 Jk1fV9uOrLIYZqXpdUUITxJ1/W7mgCnIWgxTRdk2l3OLM+KbAyAoLT6Lz+X+ECoyhB
	 ukY3DjHRYTdAgnTn7PBucyWW4kc6y+vWYbCRcEMti4Pu0bc5YYLFoiAsEhX/VSYSkL
	 2oVFstOsl19UDeGWH0FcgtW9bHSKcLrJPGjAayDOZmkTwhRA11Xnp+Awp4IXJui8rL
	 uSn4xNXm77ilQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 20 Mar 2024 18:55:21 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 18:55:20 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <sboyd@kernel.org>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 2/4] clk: meson: a1: pll: determine maximum register in regmap config
Date: Wed, 20 Mar 2024 18:54:46 +0300
Message-ID: <20240320155512.3544-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320155512.3544-1-ddrokosov@salutedevices.com>
References: <20240320155512.3544-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184300 [Mar 20 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 10 0.3.10 53c821b925e16276b831986eabc71d60ab82ee60, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/20 06:45:00 #24314254
X-KSMG-AntiVirus-Status: Clean, skipped

When the max_register value is not set, the regmap debugfs 'registers'
file does not display the entire range of the regmap.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/clk/meson/a1-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index 00e06d03445b..60b2e53e7e51 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -299,6 +299,7 @@ static struct regmap_config a1_pll_regmap_cfg = {
 	.reg_bits   = 32,
 	.val_bits   = 32,
 	.reg_stride = 4,
+	.max_register = ANACTRL_HIFIPLL_STS,
 };
 
 static struct meson_clk_hw_data a1_pll_clks = {
-- 
2.43.0


