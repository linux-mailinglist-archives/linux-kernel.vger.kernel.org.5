Return-Path: <linux-kernel+bounces-158959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A88B275F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3AE1C2425F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB614EC71;
	Thu, 25 Apr 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="VLq7HvOh"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9714E2FB;
	Thu, 25 Apr 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065193; cv=none; b=hSLa27X/f0U85EWaCYTntx5C3cxLCGaS1ZeMnPsBIUp+bCkQ0jiDwSh2SYMzqbs6ecxvMTvxLkKb7Ppzd2OkRK9gZPzjwzpU3nA1oji9PDjgxTQfUwPWyFbYYSX6dckWftdDx6wwcXXjaTPh9XArtDF4m+oF5tIztNcGuiS/1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065193; c=relaxed/simple;
	bh=FGaH4pLH7LYMjkdhr/geohJb9dwhyxxED5l1amL/Ogo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Upx1qRsyXF1RxeEsuV/EExOThBM4/FDdso/quITtWUak8U+GGUIMH58e3n7tTdq3auM9WFzH6iwpqmhPRVTNw10KvLOy2Y1N+wISlVTw+GEJNAEXSGJVurZxNhoSGtpqqHcS4+sj3yYKZKGsi4te4BHMtSLVvRXGiDg6yFdS5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=VLq7HvOh; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AEA5212000D;
	Thu, 25 Apr 2024 20:13:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AEA5212000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1714065181;
	bh=A9GpIzQZVP3rm6DjUNEFW6D9Y7ngu+Gh1hs4Mrn4JxU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VLq7HvOhXhaz9LyhReNa/Tgut3dPhbsangs+j1NwAmTmF2zJIL5Bot/2PIhBvR+3H
	 7IKC+vDzs3R7Fr7fXvA2Svn51kNKlHHIsYNGap3fhG4nvgoYGsa5rLbAGaCG8B67Km
	 LFYXcHPMBgd/PtAfxMHqGeyqIe19EELLLfr4UNHphWQbK4K8Gb6RdmohGfCSRm7u3X
	 gDC9XGAcxJKFjpizpXvXM21T0nT+K4Baxrq9L07hVryhWNBSR9xqfnRYw3ed1z+yc7
	 9YpUq7CFSSw5O7edpiwqMNxiV2znJNwh/XB8Gb6w16TaHC/WJaURh4aZkFNWQvddIw
	 k6mYR5mNeDmag==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 25 Apr 2024 20:13:01 +0300 (MSK)
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
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v3 3/3] pwm: meson: Use mul_u64_u64_div_u64() for frequency calculating
Date: Thu, 25 Apr 2024 20:12:53 +0300
Message-ID: <20240425171253.2752877-4-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425171253.2752877-1-gnstark@salutedevices.com>
References: <20240425171253.2752877-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

While calculating frequency for the given period u64 numbers are
multiplied before division what can lead to overflow in theory so use
secure mul_u64_u64_div_u64() which handles overflow correctly.

Fixes: 329db102a26d ("pwm: meson: make full use of common clock framework")
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 4a652d500dfc..b2f97dfb01bb 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -176,7 +176,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	dev_dbg(pwmchip_parent(chip), "fin_freq: %ld Hz\n", fin_freq);
 
-	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
+	cnt = mul_u64_u64_div_u64(fin_freq, period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
 		dev_err(pwmchip_parent(chip), "unable to get period cnt\n");
 		return -EINVAL;
@@ -191,7 +191,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 		channel->hi = 0;
 		channel->lo = cnt;
 	} else {
-		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
+		duty_cnt = mul_u64_u64_div_u64(fin_freq, duty, NSEC_PER_SEC);
 
 		dev_dbg(pwmchip_parent(chip), "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
 
-- 
2.25.1


