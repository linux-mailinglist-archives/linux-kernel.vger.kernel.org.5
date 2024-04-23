Return-Path: <linux-kernel+bounces-155524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA58AF38C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A21282138
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364F313D255;
	Tue, 23 Apr 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Xs70cbns"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FCD13CA8C;
	Tue, 23 Apr 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888628; cv=none; b=iNUePV5DZuhhVS85xdnd6MX5cw50o1AzoXVb5JHoDioVbB2fadbYDAbVDb7xp7zg4EEWFOKYx6tMJqUuX07xJFUFClgYPxrGJFeIF4NqtbRiCTCKfxwp9sfRjYNgieo//pHZz1V+as/ztBMRYIYRSYd2gRQrwFwCYQtMYzQ5wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888628; c=relaxed/simple;
	bh=jSSOGChwNzlyYmcg5cKeXR9ZvEjAgbTwHE3FjsekhmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjjJZRQSFPNkTSLUId4ykZ6QpGPbWaOe6+c2vpWAGyKNBcThJrCQunK44lLMHgm5ICQW503qbRooI5fiSVg3GY1I0Vv0UHg0dLZi9hxSC2IH71u8sfNY7ZvzrGSDGilFRFC243c5jg1mBr6g/vSlq1C25Ue6cA39N80/Pr4+5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Xs70cbns; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8981E100014;
	Tue, 23 Apr 2024 19:10:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8981E100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713888617;
	bh=AjYUV33RB86oJg+nTKakP4FezRMrY73vE/+v4LYaSsk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Xs70cbnsb1hAp8xJuUHKjTAl0z4UeO0Ebrc3P7uHmIHD/BgzFwXCgf7/LFU9OaZYk
	 Oss/0y5enExkLkuKCPXpH0TYjiqGkF0qQGXDrnMLsWFgEhL3SJAdMIdTlIBwXGiFYk
	 aXBtWNAIm8MPZJYCYgOxA3kyo26VgD0/UPWLS2M8U0biG11+2G9Vt9xdPVygHbuTu0
	 zPVYrAi8ETs9Xxuiks86NvexNa9gXr4DRfFY6JQ5OtOuKMbgDHyZtGRjv6zKr62/hP
	 A/YCOr+v/Gg/9SgWnkX6FHhur9gFVdg3ltnssF84P82YCvrlEtPPQZJx45Uu9HlBHl
	 AKBKPH3zM68mw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Apr 2024 19:10:17 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Apr 2024 19:10:16 +0300
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <thierry.reding@gmail.com>,
	<hkallweit1@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@sberdevices.ru>, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH 2/2] pwm: meson: support meson A1 SoC family
Date: Tue, 23 Apr 2024 19:10:06 +0300
Message-ID: <20240423161006.2522351-3-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423161006.2522351-1-gnstark@salutedevices.com>
References: <20240423161006.2522351-1-gnstark@salutedevices.com>
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

From: George Stark <gnstark@sberdevices.ru>

Add a compatible string and configuration for the meson A1 SoC family
PWM. Additionally, provide an external clock initialization helper
specifically designed for these PWM IPs.

Signed-off-by: George Stark <gnstark@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/pwm/pwm-meson.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index ea96c5973488..529a541ba7b6 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -462,6 +462,33 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
 	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
 }
 
+static int meson_pwm_init_channels_ext_clock(struct pwm_chip *chip)
+{
+	struct device *dev = pwmchip_parent(chip);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channels = meson->channels;
+	struct clk_bulk_data *clks = NULL;
+	unsigned int i;
+	int res;
+
+	res = devm_clk_bulk_get_all(dev, &clks);
+	if (res < 0) {
+		dev_err(dev, "can't get device clocks\n");
+		return res;
+	}
+
+	if (res != MESON_NUM_PWMS) {
+		dev_err(dev, "clock count must be %d, got %d\n",
+			MESON_NUM_PWMS, res);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MESON_NUM_PWMS; i++)
+		channels[i].clk = clks[i].clk;
+
+	return 0;
+}
+
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
@@ -500,11 +527,19 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
 };
 
+static const struct meson_pwm_data pwm_meson_ext_clock_data = {
+	.channels_init = meson_pwm_init_channels_ext_clock,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
 		.data = &pwm_meson8_v2_data
 	},
+	{
+		.compatible = "amlogic,meson-a1-pwm",
+		.data = &pwm_meson_ext_clock_data
+	},
 	/* The following compatibles are obsolete */
 	{
 		.compatible = "amlogic,meson8b-pwm",
-- 
2.25.1


