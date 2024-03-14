Return-Path: <linux-kernel+bounces-103766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8587C429
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB40C2815A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3FB763FA;
	Thu, 14 Mar 2024 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Hbtdgi20"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30EC76034;
	Thu, 14 Mar 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447563; cv=none; b=paaL9qo9qY99C5CjqIMBmLZevKzXoT9Bkyoa3TVt66U2RPrL0s81P7QQ3a6SaWI4TRD+pcdPYkkHGyMtucHDx0I1HKexnDfCeyM2YsziGM12uzOK9cOcOzOgBsKI+B0X6/3poZcXv3Kxb4tW3qD+by65n+ExejP6dlT6Wt3uEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447563; c=relaxed/simple;
	bh=NQ0t6+WUh/1PErpgCXsjTjUPRQo8SoyoPUTdinF2stQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hp+G97vj260Z1thmN3XYt+W+lAmZr2rcgJVv9eqGI7XvIh1MYdxtsL4JZXmPHCpq0wR++YYRmEg8qkHDiuMAriB6wyzuwidc7yQLacN5rVWk+z2iCkSI8MQj7hCIKNBz/fVAVSofwkviQJcdlN05o1bukzQ+T6kRZTsPDsdivdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Hbtdgi20; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9970612000B;
	Thu, 14 Mar 2024 23:19:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9970612000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710447557;
	bh=2bwV6P2QNBuBXkovEaePsPnQMetWmXvmhijTjHCaCW0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Hbtdgi20Q12YEx66H6L0kj5QNvsGiZ/7rv7iQgzEjPwPj9kCseDNA452huRH5AVx0
	 WyvVk4HWbo0isDLmHJkQfZV8mwqahOgrw7tzvp5EDOMPnukUaPTzU+DSTZJtPCMIJq
	 qsOv1TeqcUeWJdmUh/ymjcbXKtfnLYThxRVYwNi7GExZKszW/p+r8UFg5yR9w26LRG
	 GtZIJX5nm/6V8msBVJjPrJojiRt818AhzzUSARsJsG/Cl/7MEtJiME31pWTicpxT7/
	 57GgA9eVzEfYUEOPJq1bsYdYhx62NsDDENlFHujOyEO9MgA3h96zozE8ocH0+hitaK
	 kb2z9paLkK7fw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Mar 2024 23:19:17 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 23:19:17 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v7 5/8] leds: lm3532: use devm API to cleanup module's resources
Date: Thu, 14 Mar 2024 23:18:53 +0300
Message-ID: <20240314201856.1991899-6-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314201856.1991899-1-gnstark@salutedevices.com>
References: <20240314201856.1991899-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/leds-lm3532.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
index 13662a4aa1f2..aa7966eb506f 100644
--- a/drivers/leds/leds-lm3532.c
+++ b/drivers/leds/leds-lm3532.c
@@ -542,6 +542,13 @@ static int lm3532_parse_als(struct lm3532_data *priv)
 	return ret;
 }
 
+static void gpio_set_low_action(void *data)
+{
+	struct lm3532_data *priv = (struct lm3532_data *)data;
+
+	gpiod_direction_output(priv->enable_gpio, 0);
+}
+
 static int lm3532_parse_node(struct lm3532_data *priv)
 {
 	struct fwnode_handle *child = NULL;
@@ -556,6 +563,12 @@ static int lm3532_parse_node(struct lm3532_data *priv)
 	if (IS_ERR(priv->enable_gpio))
 		priv->enable_gpio = NULL;
 
+	if (priv->enable_gpio) {
+		ret = devm_add_action(&priv->client->dev, gpio_set_low_action, priv);
+		if (ret)
+			return ret;
+	}
+
 	priv->regulator = devm_regulator_get(&priv->client->dev, "vin");
 	if (IS_ERR(priv->regulator))
 		priv->regulator = NULL;
@@ -691,7 +704,10 @@ static int lm3532_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	mutex_init(&drvdata->lock);
+	ret = devm_mutex_init(&client->dev, &drvdata->lock);
+	if (ret)
+		return ret;
+
 	i2c_set_clientdata(client, drvdata);
 
 	ret = lm3532_parse_node(drvdata);
@@ -703,16 +719,6 @@ static int lm3532_probe(struct i2c_client *client)
 	return ret;
 }
 
-static void lm3532_remove(struct i2c_client *client)
-{
-	struct lm3532_data *drvdata = i2c_get_clientdata(client);
-
-	mutex_destroy(&drvdata->lock);
-
-	if (drvdata->enable_gpio)
-		gpiod_direction_output(drvdata->enable_gpio, 0);
-}
-
 static const struct of_device_id of_lm3532_leds_match[] = {
 	{ .compatible = "ti,lm3532", },
 	{},
@@ -727,7 +733,6 @@ MODULE_DEVICE_TABLE(i2c, lm3532_id);
 
 static struct i2c_driver lm3532_i2c_driver = {
 	.probe = lm3532_probe,
-	.remove = lm3532_remove,
 	.id_table = lm3532_id,
 	.driver = {
 		.name = LM3532_NAME,
-- 
2.25.1


