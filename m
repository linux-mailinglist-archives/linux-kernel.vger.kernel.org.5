Return-Path: <linux-kernel+bounces-156983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282A38B0B31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D440E283D94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A38116D339;
	Wed, 24 Apr 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="MW/oZF6X"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365116C87A;
	Wed, 24 Apr 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965654; cv=none; b=kuNlRLPvgO6eEA6lLsxhWXB0/gYo6iFhMdjKF4Qr0g3dgdHwdNIbkDzF3oZOOEiuuUav/7dUcix5TeHF3Y1K+Z9mCon++WRDk45SDmqGgG8V27RECcKHK780+9nJxXljRJAD0ppWsGBUhcx1lxI+5wTnX1t+h8hgFqymaYqkap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965654; c=relaxed/simple;
	bh=xnKosAF7RWG/EEqRPJR9IKmIjQpWZgLPeCE1v8EEP70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ac1s1VmXQcMzNdhAPkD0AqQoF2bol5KSlLeuxwnd5LvFfEVT0At49bb5/gGkIuQpynrDHqPnIXcZgKts1Vz0xzwmh9EzF00Rd/0lH6t+T/OyBCobaPFW1eaAfTbhzP4jLO2qB5LAeklrryyS+k2Xc0aGXh1JrZTJdi9p6vbufVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=MW/oZF6X; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9C282120010;
	Wed, 24 Apr 2024 16:24:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9C282120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713965056;
	bh=PivDwMlzP3nP6SQyIPep/9C0T91zkfzg9QOFeyHrECI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=MW/oZF6XmtOrUR5Y+CLP41Oo+RO9d5R08yTkNmYZwU3z5XdN6mDBAqsTzUU7BJxQw
	 WADMLcSmNil2Tjvhkrf7j8/lQ2B1Oks39pG071Nfurm4XRI2f5mj7ewF5uDBXImVgh
	 d3moSJtbhwtuFfG9pFrFAsBFEH7dX8tumklylYSqscHI7ipqAg5OJ6B62zQv5Ch5L5
	 S7krrV1/CjhDMp4SWsrCFZNzlDSap/0MiV54szWhv9J41PfcbKYcOWzkhPzC1DFI04
	 T+i1ObR6WykIEk9wWwplr0k9TJIxVFNHLh8FXQVvihmLAYYcpSmZqv5HQ6YU3G5Z9i
	 ng9Sh/uG+sgZg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 16:24:16 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Apr 2024 16:24:16 +0300
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <thierry.reding@gmail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v2 0/2] meson pwm small fixes
Date: Wed, 24 Apr 2024 16:24:06 +0300
Message-ID: <20240424132408.2565916-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
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
X-KSMG-AntiSpam-Lua-Profiles: 184897 [Apr 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/24 10:33:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/24 10:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/24 08:29:00 #24954596
X-KSMG-AntiVirus-Status: Clean, skipped

Just some small fixes for meson pwm.

Changelog:
v1->v2:
  pwm: meson: Drop unneeded check in .get_state()
    - update commit message
    - drop Fixes tag. It's not actually a bug
    previous version: [1]

  pwm: meson: Add check for error from clk_round_rate()
    - update commit message
    - change unsigned long fin_freq; to long fin_freq;
    previous version: [2]

[1] https://lore.kernel.org/lkml/20240423161356.2522636-2-gnstark@salutedevices.com/T/#m6d1d5cf100dc5b77f85e2a7d01c0b0097b6a04da
[2] https://lore.kernel.org/lkml/20240423161356.2522636-2-gnstark@salutedevices.com/T/#ma84e2d490bf79bda12f8393773c1af37b48d5473

George Stark (2):
  pwm: meson: Drop unneeded check in .get_state()
  pwm: meson: Add check for error from clk_round_rate()

 drivers/pwm/pwm-meson.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--
2.25.1


