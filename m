Return-Path: <linux-kernel+bounces-156985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233E8B0B35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A223B21D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51615F415;
	Wed, 24 Apr 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="tS5crxao"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE815CD75;
	Wed, 24 Apr 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965669; cv=none; b=SiWzgCLvhVPs+W5sb/7EwleoDiDY0E4vJP5ByLbZYRFtDgUyjINcq3wPoMAjZz2Nja2dfm243K6gegJR8P8eJLWq2tIo8TvOi97kB/fjEajaeD1yolwKM9NwKf/DDB6HHBj8q8EW7B31hEJfSCgwCp9epD5qEpfp2XokKc4auVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965669; c=relaxed/simple;
	bh=IwkocQoiEsPFLMe76gOZtJyZ7fUrfncVRvJvqh/N5Qo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj2W10zHgQ1KAPTthtFw23zk+8rXtfWvBwcfPyfIFu8RK9GTmWIlwuCy0HMYYX87CbJmORcXBrU0fSl7oaQfnl/OJRGpG9RFnljIpldK1iyEpUh2V+uKaodZkuDtI3zBTVX/KLjC4kv7Lho45sxeZdCrBU7tnswyhgj12viq7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=tS5crxao; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0DF08100014;
	Wed, 24 Apr 2024 16:24:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0DF08100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713965057;
	bh=P3gJosMyO15rQMcOY6eGDpvCUcmma/l8WDr0SIlJGFY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=tS5crxaor0clxEgV4A7QWdlmSgbipRYHdLmKDwl0lhCBQQZbZQZYUmFs5JNYwmeQE
	 e455Oo9oug+lDlsWMNAoM9PQYPqXlEqGLmomYAwlCtxHE6IXVe5zF8CjYdLU4MCGWA
	 rtukjd8T8nb9XLFePMmJ2ISpEi+sNI/YVK0vyITHPyxlK22WAnohZ099PW6p8Mn6p7
	 qhzQ7GFHlbylUPPlpUWpeNZ88sZ33PVBOFSBe5i/mcMEXXM/RUqrLc2aI/XZ2NoYJb
	 hf6nYYImEIuVt5ud/9/p2IsedJCapJ9xZu6sby+L5OauTh8z00mCazLD2Foc8Li3qr
	 tXjIq8JmW1K8w==
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
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>, Dmitry
 Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 2/2] pwm: meson: Add check for error from clk_round_rate()
Date: Wed, 24 Apr 2024 16:24:08 +0300
Message-ID: <20240424132408.2565916-3-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424132408.2565916-1-gnstark@salutedevices.com>
References: <20240424132408.2565916-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/24 08:29:00 #24954596
X-KSMG-AntiVirus-Status: Clean, skipped

clk_round_rate() can return not only zero if requested frequency can not
be provided but also negative error code so add check for it too.

Also change type of variable holding clk_round_rate() result from
unsigned long to long. It's safe due to clk_round_rate() returns long.

Fixes: 329db102a26d ("pwm: meson: make full use of common clock framework")
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index f4d70da621ec..d4228ac1e7ea 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -148,7 +148,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	unsigned int cnt, duty_cnt;
-	unsigned long fin_freq;
+	long fin_freq;
 	u64 duty, period, freq;
 
 	duty = state->duty_cycle;
@@ -168,9 +168,10 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 		freq = ULONG_MAX;
 
 	fin_freq = clk_round_rate(channel->clk, freq);
-	if (fin_freq == 0) {
-		dev_err(pwmchip_parent(chip), "invalid source clock frequency\n");
-		return -EINVAL;
+	if (fin_freq <= 0) {
+		dev_err(pwmchip_parent(chip),
+			"invalid source clock frequency %llu\n", freq);
+		return fin_freq ? fin_freq : -EINVAL;
 	}
 
 	dev_dbg(pwmchip_parent(chip), "fin_freq: %lu Hz\n", fin_freq);
-- 
2.25.1


