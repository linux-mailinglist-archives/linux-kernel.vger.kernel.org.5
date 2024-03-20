Return-Path: <linux-kernel+bounces-109128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8CC881503
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF45DB22718
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BD954FA2;
	Wed, 20 Mar 2024 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="XDydmRx5"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B14E1D5;
	Wed, 20 Mar 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950130; cv=none; b=S++VMTfzJVinqOhZ3XoM/Po1hMIkyfbSqXJjbAqtTofNh7sTFF0uyKcY3mXJ7Wpgpytr2zaLgNX4PlVfKjTCyix0SAB7SmiImq9r8+u7x2X5fF4GJRaScCcNedaaXiQpktY12n7E1xNn9FM0Ob+/1yE0Da6hEc8lR6zAqNVKqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950130; c=relaxed/simple;
	bh=uz5YSWprNfbLYOxKpYNHjtfMySvV4RFWv4ndcLCY5AM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WfWr37fbg1hrCPSo+BWvN2RbymK8CU5QHVbMX906e1cAQPGzmgFfTwohB4HJs1gHoXyvk8OFz1MBQLzlgNoVa7LUWy87d90mkP60dZXccFmQlaHwQr9napzHzN1uJrRlB1ChO+eqM6HIEOwtqWefvqjGC5AY/QrBPZSlzy00+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=XDydmRx5; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0C270120015;
	Wed, 20 Mar 2024 18:55:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0C270120015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710950119;
	bh=LsoQ3oF2kg2yK04bv75oYHFuvgq3Hd3YI9kmS9zzWiE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=XDydmRx53U4e4RBhlk3rasEQtc43OdENArhGOxnkb80H5xxbVbJv264GHZnQrNE52
	 jhZbqmT+yk9H5HzRDmaYwzq6Ul5LJi5VA7DXxTqF8oE8mKowK6T33U2hjp7vqYqwlD
	 yKmJ7mGPgdBwWhdLMqVjNofutV6RbKrCg982ivOv0xr6TrisyUKfZ3al6fe7qDK4PA
	 Xp+H9fGda71a1R1OjE63WDhQE01uNQlLu6HSb3bxVJPZGaYiMdEVrwhciY+JLvL4Aa
	 nsfAfgDdq5UvAR5AgiRFuy5bj9eJJ4Bx61fZn64YVj+pVQHX2Ih4aeZVibsEPSU553
	 8tVbXtWfcC9Bg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 20 Mar 2024 18:55:18 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 18:55:18 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <sboyd@kernel.org>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 0/4] clk: meson: treewide: define maximum register in regmap config
Date: Wed, 20 Mar 2024 18:54:44 +0300
Message-ID: <20240320155512.3544-1-ddrokosov@salutedevices.com>
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

The 'max_register' field in the regmap_config is an optional value that
specifies the maximum valid register address. If this value is not
determined, the regmap debugfs API will not show the full regmap dump,
but only show the first register value.

Compare 'registers' debugfs file data on the A113L SoC-based board
before the patch:

```
~ # cat /sys/kernel/debug/regmap/fe007c80.pll-clock-controller/registers
00: 14f10440
```

and after the patch:

```
~ # cat /sys/kernel/debug/regmap/fe007c80.pll-clock-controller/registers
00: 14f10440
04: 01800000
08: 00001100
0c: 100a2300
10: 00300000
14: c000002b
18: 00000000
1c: 00000000
20: 00000000
24: 00000000
28: 00000000
2c: 00000000
30: 00000000
34: 00000000
38: 00000000
3c: 00000000
40: 00000000
44: 00000000
48: 00000000
4c: 00000000
50: 00000000
54: 00000000
58: 00000000
5c: 00000000
60: 00000000
64: 00000000
68: 00000000
6c: 00000000
70: 00000000
74: 00000000
78: 00000000
7c: 00000000
80: 15f18432
84: 01800000
88: 00001100
8c: 10022300
90: 00300000
94: c000001d
98: 00000000
9c: 00000000
a0: 00000000
a4: 00000000
a8: 00000000
ac: 00000000
b0: 00000000
b4: 00000000
b8: 00000000
bc: 00000000
c0: 01f19480
c4: 01800000
c8: 00001100
cc: 100a1100
d0: 00302000
d4: 00000020
```

Dmitry Rokosov (4):
  clk: meson: a1: peripherals: determine maximum register in regmap
    config
  clk: meson: a1: pll: determine maximum register in regmap config
  clk: meson: s4: peripherals: determine maximum register in regmap
    config
  clk: meson: s4: pll: determine maximum register in regmap config

 drivers/clk/meson/a1-peripherals.c | 1 +
 drivers/clk/meson/a1-pll.c         | 1 +
 drivers/clk/meson/s4-peripherals.c | 1 +
 drivers/clk/meson/s4-pll.c         | 1 +
 4 files changed, 4 insertions(+)

-- 
2.43.0


