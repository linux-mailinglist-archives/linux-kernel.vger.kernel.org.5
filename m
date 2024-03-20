Return-Path: <linux-kernel+bounces-109131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3605B881509
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658371C2109B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC45676E;
	Wed, 20 Mar 2024 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="IYKSHbW9"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71B524D7;
	Wed, 20 Mar 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950132; cv=none; b=EHGSSu2xzkVIposvgn6kjf/trtx6QbaXBF6TqPIsN578k6G2X8XhjLx4dCPqsaPOrOXkErch5G2TT97qh0jH7tYc/VE5Kjy6ImTrY53bAKJFQeLHrGU6LL/8UG/r6HNUpyk+Bqmak8e3zfEDs2nMEQVjryvmTvUfwCrNVJMMkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950132; c=relaxed/simple;
	bh=/5XpSmpOtu3Gyn/58hMv8Oc+cA0wcAwlwOnm0kwsue4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dASZ+G9UismiTqVVpXiEnKcNKTerrblibPlJ4YtimAmZiREesMsEN72P59aSnDJHtdM69kdnfyYsrcS/bjY5olTBYX5XGjJODKiu1wo8JXpjJ+N2SJOhPToHL6s8Aw71QJ8Bmz7UFUdA1APGC+laLzOB7xroLl7KmHdmIJ4fk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=IYKSHbW9; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 85D6F10001B;
	Wed, 20 Mar 2024 18:55:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 85D6F10001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710950120;
	bh=0Fa4Y34XfUVQyedPaiuMQc4mBGz6JmwcoPWvUkgtW24=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IYKSHbW9O4ZzTIfYmM0ds1tK7elpYzLGJXSTvOMinLQxGNhLZXqjRqyk/mbcQRkJm
	 B8pEFqoZJsd1rfSoi+2nWSsZeTYPBnipwp/I5KND5Fnf/ZCDmFw9xXCcjQjUZM+nLG
	 mUtp1cwvv3cxQS8v9vagWlEYW/gFFSxsHPeQijBEWjhnbWzCTKm93ZMr+aBIfUXH4Y
	 vLWBZhlNZO+SswVpobLQKwF/6fn6O+MY9fhauUIVWVG8im9Cz3MBwyb7dPJZp2tnv3
	 WnY2L6Q7c1/jjyi0Se5FiLXKDIaI8ObinK2jrsSIkz6f30BDy47zqRJTEZT37h0sT+
	 lfRCoBT858RCg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 20 Mar 2024 18:55:20 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 18:55:19 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <sboyd@kernel.org>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 1/4] clk: meson: a1: peripherals: determine maximum register in regmap config
Date: Wed, 20 Mar 2024 18:54:45 +0300
Message-ID: <20240320155512.3544-2-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184302 [Mar 20 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 10 0.3.10 53c821b925e16276b831986eabc71d60ab82ee60, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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
 drivers/clk/meson/a1-peripherals.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index e2a1f12f9175..621af1e6e4b2 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -2187,6 +2187,7 @@ static struct regmap_config a1_periphs_regmap_cfg = {
 	.reg_bits   = 32,
 	.val_bits   = 32,
 	.reg_stride = 4,
+	.max_register = DMC_CLK_CTRL,
 };
 
 static struct meson_clk_hw_data a1_periphs_clks = {
-- 
2.43.0


