Return-Path: <linux-kernel+bounces-158958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321878B275E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C0D1F24A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2714EC6D;
	Thu, 25 Apr 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="uDRWWGvr"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62214E2FA;
	Thu, 25 Apr 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065193; cv=none; b=sKfFE5ZsorvGvLp7kNHpQhd0OnRKPQ/plJFyMDokzBynrg7PQNZgGgJdIbJoEAq1VUNMfYQjA805I7Xo8kOyIo2uGloUbUIdHYiw1TLdsgyPNLUXnCd7EqX6miyz3mK2crwNeC8V5pf40ofjJjVg8fTcOi+oBieR3tEfeeA9VSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065193; c=relaxed/simple;
	bh=z+HI6GPCB0cq78nBc580F0sK4x91gp4xJCIe6d2S6gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kL32ADmw87LUHLg4qw4qh6aGMsaJqSi/GmR1BsPJthrrPdugkrgIXxuHrT2MYY4Y3kIpMcxFCWcCUAU2ptbWahZ6diiUEQpnq9zdUoVilb59xgLYy2Cjv7X4MrqCApx2q8m4VlsS5WLISn465SN0RUQOUAM4JAwFYH/ezd+19yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=uDRWWGvr; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2D2E512000B;
	Thu, 25 Apr 2024 20:13:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2D2E512000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1714065181;
	bh=CJqJH6Aem+/Zgl9mTPvkSpY22mVAhX57+bi5i0Gt8yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=uDRWWGvrKFm3INDbb3i4wRym37hwu3R1vuirLTjgbAtvFZCqcNueMfBLFc7wXVI94
	 bTZiVb4NfVLeqIWN0jKqx3/9BCbFmXYg6mqyp+2TQRtsAEe0iVcEet/cKVBAHYXLDg
	 uj+1+c4RcHcO7AzsTRNGR46T9zD8i2LmyLsrvqwIUH+Ng1+q/PmimH2dXoS6SNaZ+G
	 6iQRBHnJAMz3nQkMlBmwor8215SzYdHpQid3SANpDs0ZNHmewG6wVXBN8EHOdMIZWy
	 xnYJN5g7Q5FAv1lOMPMcQVQ0Wn7skYI0fiI4SSogQTkw5T7iL1G7jquu2ihmFU9wk8
	 JBgUN5tp7IZZw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 25 Apr 2024 20:13:00 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Apr 2024 20:13:00 +0300
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <thierry.reding@gmail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>, Dmitry
 Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 1/3] pwm: meson: Drop unneeded check in .get_state()
Date: Thu, 25 Apr 2024 20:12:51 +0300
Message-ID: <20240425171253.2752877-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425171253.2752877-1-gnstark@salutedevices.com>
References: <20240425171253.2752877-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184930 [Apr 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/25 14:02:00 #24969020
X-KSMG-AntiVirus-Status: Clean, skipped

Drop checking state argument for NULL pointer in meson_pwm_get_state()
due to it is called only from pwm core with always valid arguments.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index ea96c5973488..f4d70da621ec 100644
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


