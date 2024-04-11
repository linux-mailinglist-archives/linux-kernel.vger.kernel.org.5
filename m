Return-Path: <linux-kernel+bounces-141290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCC38A1C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4AF1C21329
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D66159904;
	Thu, 11 Apr 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="AD+fX3ha"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E4153561;
	Thu, 11 Apr 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851847; cv=none; b=aNHJ678kExYT/FJ60zdknPpfd62+UhnycOXh8Gf6Z8wfP/uF6ydn4f5YEB8YCpn21+gAAfa+1dHZCnEQScG9KF7QdnWRc2fx5FZMZBHXe2SxU1ktjOopa1j0rhBt51KzZi0tCeotqs+5kd9fBH7c+CIg30aWhUepBCGrIxxwlfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851847; c=relaxed/simple;
	bh=km5tfIIVGKNwKDNZhdPYWzBEl6TL/6iXUWcTA0Hj06k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGfeSOxS9FDmIoaf0dFMahcW4mgdLuU33SZBvoNPbce3eiinrPk2YqCNp//AkgBlmXRYVFXVzFCyrBUjhpsz8u7mEvcNOCnNlFOm6UaIj8gI1b3caYneeyxNmNWOwVMjTjPsdhakcG1+grMMuizargFcfm37jkB70NIFHhIhYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=AD+fX3ha; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 48389120065;
	Thu, 11 Apr 2024 19:10:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 48389120065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712851840;
	bh=kUQZvb5TQE+27CS7ipmNtMTScgT6hB7NkwHTRSUgx7w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=AD+fX3haf7F3WNQBbLGxP1iw8WAcKHF39XraYjM14TI6LI+9fEJOo/lwaabVKVJAb
	 T9LztFt+iJe3BUhSedAnJYzKBtqdE+Zo01u8GSTdAxB5vYtQlhwia7PQNa2Wnc2Fkc
	 4oPIya4fs4Mpq5udvnj1P5cKUp7LCdKHro+a66qkyUd2kZqLMv2uvCPv97J865Kkit
	 k4sy1cSxB+QUcFd7TeXmttsvmaLEu3s3GIKGTLLXWC78gTU6JORNoLHchHAjD9cDb9
	 QuvHVtHLO/sLGl45uSw0n2FAxfVCLa6aeEfwKTX3bD9Wjij65c4a6vf6kvVY57X205
	 lbm3KDtrzvY+Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 19:10:40 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Apr 2024 19:10:39 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>, Nikita
 Travkin <nikita@trvn.ru>
Subject: [PATCH v8 2/8] leds: aw2013: use devm API to cleanup module's resources
Date: Thu, 11 Apr 2024 19:10:26 +0300
Message-ID: <20240411161032.609544-3-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240411161032.609544-1-gnstark@salutedevices.com>
References: <20240411161032.609544-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184677 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/11 15:00:00 #24747318
X-KSMG-AntiVirus-Status: Clean, skipped

In this driver LEDs are registered using devm_led_classdev_register()
so they are automatically unregistered after module's remove() is done.
led_classdev_unregister() calls module's led_set_brightness() to turn off
the LEDs and that callback uses resources which were destroyed already
in module's remove() so use devm API instead of remove().

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/leds/leds-aw2013.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 17235a5e576a..6475eadcb0df 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -320,6 +320,11 @@ static int aw2013_probe_dt(struct aw2013 *chip)
 	return 0;
 }
 
+static void aw2013_chip_disable_action(void *data)
+{
+	aw2013_chip_disable(data);
+}
+
 static const struct regmap_config aw2013_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -336,7 +341,10 @@ static int aw2013_probe(struct i2c_client *client)
 	if (!chip)
 		return -ENOMEM;
 
-	mutex_init(&chip->mutex);
+	ret = devm_mutex_init(&client->dev, &chip->mutex);
+	if (ret)
+		return ret;
+
 	mutex_lock(&chip->mutex);
 
 	chip->client = client;
@@ -384,6 +392,10 @@ static int aw2013_probe(struct i2c_client *client)
 		goto error_reg;
 	}
 
+	ret = devm_add_action(&client->dev, aw2013_chip_disable_action, chip);
+	if (ret)
+		goto error_reg;
+
 	ret = aw2013_probe_dt(chip);
 	if (ret < 0)
 		goto error_reg;
@@ -406,19 +418,9 @@ static int aw2013_probe(struct i2c_client *client)
 
 error:
 	mutex_unlock(&chip->mutex);
-	mutex_destroy(&chip->mutex);
 	return ret;
 }
 
-static void aw2013_remove(struct i2c_client *client)
-{
-	struct aw2013 *chip = i2c_get_clientdata(client);
-
-	aw2013_chip_disable(chip);
-
-	mutex_destroy(&chip->mutex);
-}
-
 static const struct of_device_id aw2013_match_table[] = {
 	{ .compatible = "awinic,aw2013", },
 	{ /* sentinel */ },
@@ -432,7 +434,6 @@ static struct i2c_driver aw2013_driver = {
 		.of_match_table = aw2013_match_table,
 	},
 	.probe = aw2013_probe,
-	.remove = aw2013_remove,
 };
 
 module_i2c_driver(aw2013_driver);
-- 
2.25.1


