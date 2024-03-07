Return-Path: <linux-kernel+bounces-94870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2975087462F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE45B1F23EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEFCD53E;
	Thu,  7 Mar 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="lU5slDiY"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7BD4C83;
	Thu,  7 Mar 2024 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779256; cv=none; b=Ul2kltHQ0/vxWEmauo3y4AEUUy/js8bHa9af2cDbOCIIydHQqCOdUfi08H1w8BJz6dhalaiHTDHsqZ3Wx04lnddQtI1+7mpctvo4nDkqIxUSYKh2Wn4FpimyeKRHY25C+5YDMMQAiIxL0KveVeSiy5g8bUI9bSbNbd+VWyWC+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779256; c=relaxed/simple;
	bh=ZhwIqYSkHeid7IzpzPz46BYX4vhv51LDlh8l+Z+depo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daybfLydBn0w3La2z5VWgytReZ3UbpPkE4Bxf6Fbo/4sAyAfjDH4nw17mxEB/rFMJDaQCEzZE4Pf8wWB06XpVcaENR2xjvW3/DxF39PIGo0GBTVePLwp75HHAAH15rl0jV/5i/E4ZzcvCKp7Qu24i52nd3s04MCbq+kMvOJx7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=lU5slDiY; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id EBF73100037;
	Thu,  7 Mar 2024 05:40:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EBF73100037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709779245;
	bh=UKhnHyf3Q15t1sWab7Ng1cV9QPOXCfl6k9inzlZSB1c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=lU5slDiYOWyLrEh994hiweA22+yzTSHp9jdwJbNqGuNy2A3IWVFi1gIt8iZbi0zUs
	 GqLcDXrqzqXcynHSYKsScDlfwHETyxrDNlQc1LemGiWaPSqVtN18hP7hDl14ieqmIz
	 C/mfeNkyDXiXe0uQxiWka57LBrs/3x8lANQiQ26zzZVNouROM4Qg1WpuraSM5tAolN
	 82EQUUlJA2ymA/895iBnu/4o1YQhJUCnOrT5JHYPA49tMpjIlcVKktec9ls+Vd21gb
	 2Cc8X0jMIksss7BQRk+jWAOfS0Y6lRyoOTi7vRjUH3p6VnWwHyIK8SnSzMciQXX/vt
	 4chEdrHuSM4Pg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 05:40:45 +0300 (MSK)
Received: from localhost.localdomain (100.125.24.169) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 05:40:45 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>
Subject: [PATCH v5 05/10] leds: lp3952: use devm API to cleanup module's resources
Date: Thu, 7 Mar 2024 05:40:29 +0300
Message-ID: <20240307024034.1548605-6-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307024034.1548605-1-gnstark@salutedevices.com>
References: <20240307024034.1548605-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.125.24.169
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

In this driver LEDs are registered using devm_led_classdev_register()
so they are automatically unregistered after module's remove() is done.
led_classdev_unregister() calls module's led_set_brightness() to turn off
the LEDs and that callback uses resources which were destroyed already
in module's remove() so use devm API instead of remove().
Also drop explicit turning LEDs off from remove() due to they will be off
anyway by led_classdev_unregister().

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/leds/leds-lp3952.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-lp3952.c b/drivers/leds/leds-lp3952.c
index 5d18bbfd1f23..e24bfe686312 100644
--- a/drivers/leds/leds-lp3952.c
+++ b/drivers/leds/leds-lp3952.c
@@ -207,6 +207,13 @@ static const struct regmap_config lp3952_regmap = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
+static void gpio_set_low_action(void *data)
+{
+	struct lp3952_led_array *priv = (struct lp3952_led_array *)data;
+
+	gpiod_set_value(priv->enable_gpio, 0);
+}
+
 static int lp3952_probe(struct i2c_client *client)
 {
 	int status;
@@ -226,6 +233,10 @@ static int lp3952_probe(struct i2c_client *client)
 		return status;
 	}
 
+	status = devm_add_action(&client->dev, gpio_set_low_action, priv);
+	if (status)
+		return status;
+
 	priv->regmap = devm_regmap_init_i2c(client, &lp3952_regmap);
 	if (IS_ERR(priv->regmap)) {
 		int err = PTR_ERR(priv->regmap);
@@ -254,15 +265,6 @@ static int lp3952_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void lp3952_remove(struct i2c_client *client)
-{
-	struct lp3952_led_array *priv;
-
-	priv = i2c_get_clientdata(client);
-	lp3952_on_off(priv, LP3952_LED_ALL, false);
-	gpiod_set_value(priv->enable_gpio, 0);
-}
-
 static const struct i2c_device_id lp3952_id[] = {
 	{LP3952_NAME, 0},
 	{}
@@ -274,7 +276,6 @@ static struct i2c_driver lp3952_i2c_driver = {
 			.name = LP3952_NAME,
 	},
 	.probe = lp3952_probe,
-	.remove = lp3952_remove,
 	.id_table = lp3952_id,
 };
 
-- 
2.25.1


