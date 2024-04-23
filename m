Return-Path: <linux-kernel+bounces-155533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3358AF3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2971C2388A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BF13D250;
	Tue, 23 Apr 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="rAWXG9MT"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38613CAAC;
	Tue, 23 Apr 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888848; cv=none; b=jFdZ1d0DHGIXL5Jhj9ZEA0O0cdCeWym/1SSaeABWXUY6FTmFpTp6Gr/Y/FTP8N72YIbacKPwhjyNAqRBpyd0i2dgkacck5kQzH/aZD6ZwoPXXroLNOSQ6Z3E3wU6ndbefPQeX+gyANt+a3L8KY7lqJs/yF7ZpKKnWvF5Z6uHUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888848; c=relaxed/simple;
	bh=3Hb8fkopiaFcoVY/nTpG4eAeke/uDxk6uuyav9yWPcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsuRM/jiyGr0zOV8cnJw764j2i08zB/++07jIiUG58poqO49RyNMFt5b2ZfQnmQgl8IyP2HjVJZdgU/4Ontd+Cb8FrVyJJDNRaPGK+UlnM1P+CXu6NNKuzH7pV1BuOtaGnJ0PL/0TXl5A/iyVUzYIaC3oIjwDGU8zFBADZPtdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=rAWXG9MT; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id F38FC10000F;
	Tue, 23 Apr 2024 19:14:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F38FC10000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713888844;
	bh=Eb7vuPSuYnLMwuwGHzpqpt0wDC94w7XsXp1ME5MdeHM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rAWXG9MTkFJR8xM9NJQegShLU8uEwEu2YxwpPSX4u4ccFgdSmtiPJAtZepxmV0flQ
	 2NIuYWF5/eZs3NadRRTTBcvvA5MA5TuOcRxLzUpcZxZEipGMIoUgZEzETKcVo+6jSs
	 96ODG7/fU44CEaWDjdxp1cgI6tkeIWja2uDjeQgeM0MyBuG+ZQEL0L7Y44kmCafL3s
	 tuTWRVPFa4M4Oi6vo1wlmE+bMScl5Y732jQJfYcMFjtmtHb3n80+PxPB44vaYMK8/j
	 kXe23Yx/LSUFxxxIRfBM/5OP0dUIrqgFO27JPQlck7A3CHpDd+ebwrj8wiCnMHmKJq
	 156PXjxde7AxA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Apr 2024 19:14:04 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Apr 2024 19:14:04 +0300
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <thierry.reding@gmail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>, Dmitry
 Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH 1/2] pwm: meson: drop unneeded check in get_state callback
Date: Tue, 23 Apr 2024 19:13:55 +0300
Message-ID: <20240423161356.2522636-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423161356.2522636-1-gnstark@salutedevices.com>
References: <20240423161356.2522636-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184882 [Apr 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/23 04:11:00 #24934400
X-KSMG-AntiVirus-Status: Clean, skipped

Drop checking state argument for null pointer in meson_pwm_get_state()
due to it is called only from pwm core with always valid arguments.

Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")
Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 529a541ba7b6..ebe76298f6e2 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -311,9 +311,6 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct meson_pwm_channel *channel;
 	u32 value;
 
-	if (!state)
-		return 0;
-
 	channel = &meson->channels[pwm->hwpwm];
 	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
 
-- 
2.25.1


