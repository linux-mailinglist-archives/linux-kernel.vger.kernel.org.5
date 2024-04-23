Return-Path: <linux-kernel+bounces-155534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C78AF3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15511C23903
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5513CAB5;
	Tue, 23 Apr 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="b1yJeJJa"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156DB13CAB3;
	Tue, 23 Apr 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888849; cv=none; b=s8TZT5XSGdA32qqBW77GtZpSF8pYzYR+npoE3i56q3LD2olJ7qi2GzMcIfAxJF18aOm/V4Q/Mju0noMzmYov3anbAUQGZ2V+9CvOfVSQnUgchNWo7OaZn9dlYgvWxE6gmMsHoaZk3ORdQx/GovbD/rFmO/X1Li48P3PLFCXBdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888849; c=relaxed/simple;
	bh=b967/hHJBnWnMCTBji//0dHXuXrl2DP/d/po0fsIoGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaoypCbaxBk4vQRu9zScgOMcS4JG8rDEsBZoBicwf39IbSBPo5gEqJO3AVFDYRHAQqkJZKQnqcyRKCl9FwNGQViNYxyjOjlchuIux3cCu36sUl3YMjOsOmQN2RxIO+JjOpcW3+4J15D3WE4Xh1bvcphNSsWshG9ZX3tRq+ZrvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=b1yJeJJa; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 43D96120011;
	Tue, 23 Apr 2024 19:14:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 43D96120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713888845;
	bh=5Gfs5AmZGozZkrrRTvm140Edujqw0V5kNp9waYflDF8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=b1yJeJJaDHqH69ss+sRunhyufYQj7rb6mouCKXrVFaysnuFWc1mTSgT1EdKNU6Pq3
	 A79gQ+iFnbkN0Ik2WngcXBxeoU35rNHzUXQh3IOuRagb9hDzpBNxo+53kX7rrwtmFf
	 yXSumzqbDzwQ4ffX1nb0oatFzMSYX461Wf41TP6vjjzW0ATntFn5grKADVJzfDfkmB
	 VL3FO6D8MQTQXABxWmID518Txl7ELHqLvPC32mgKsIqlp6xu42EYxFxDIVbedXbA9b
	 zlbsYkG4x9qmvprIbIh5ASsZ7oDjF+OW43b3OLIzQ6ac+CLmxuPZq+U3u2b8O0GYP1
	 QGCVfVjuwnZ2w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Apr 2024 19:14:05 +0300 (MSK)
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
Subject: [PATCH 2/2] pwm: meson: add check for error from clk_round_rate()
Date: Tue, 23 Apr 2024 19:13:56 +0300
Message-ID: <20240423161356.2522636-3-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/23 04:11:00 #24934400
X-KSMG-AntiVirus-Status: Clean, skipped

clk_round_rate() can return not only zero if requested frequency can not
be provided but also negative error code so add check for it too.

Fixes: 329db102a26d ("pwm: meson: make full use of common clock framework")
Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index ebe76298f6e2..52604635b31e 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
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


