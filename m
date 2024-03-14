Return-Path: <linux-kernel+bounces-102990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BBD87B982
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C121C22061
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100146BFBF;
	Thu, 14 Mar 2024 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="llg9699W"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF196BB46;
	Thu, 14 Mar 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405979; cv=none; b=DSb2u6hx44wlGbmkyGthPKJbUdJQS84Efc+La543PR/Ks1yDk2B4/vbaYRiruN6r3k5FqlqCoPx0yKzCQvhrG1R15LNPVm4IPRLgnY4EukSqew8zKj7ze9WVNRTamjiTLankxMiw5MWkj0GEjPXto89uvKkpY0+hFXStvj/3yd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405979; c=relaxed/simple;
	bh=ZhwIqYSkHeid7IzpzPz46BYX4vhv51LDlh8l+Z+depo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHlDrx1/IKM2Ur+8BqV5fD3fHr72d8DMFx8mQ5B7E4pubxC35/g2c/67S+OJW6CklKlu7yHTAzJ5kJBmAgYCYGdEmDbD5/t38vUNspwiVQE61qpahdyitHCJ2QIyyC4SrYEVgt8kMCkdUm2ok4TElOr6P4AzesyK8bwG+RsU51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=llg9699W; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9C1EE100017;
	Thu, 14 Mar 2024 11:46:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9C1EE100017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710405974;
	bh=UKhnHyf3Q15t1sWab7Ng1cV9QPOXCfl6k9inzlZSB1c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=llg9699W2rj5jl7v8yvCPkzJKdUhJpldOk6JTJwKKcOidKi6wgSTIZfXHTxDvt10F
	 GvDRhAcEDAcj55+arFTzbJHLpMRtGGvHVku7AyzTwtiIohc8OQiVARs4qhzcfwHNWX
	 fDT8X3G+CQJK5AEi+icnfhCWbenJaozvYAoDDkmyiiibtCbIIaHaq3+/8JVoyhZjL0
	 MhZKF0np04TVDbMB8+IoDcEOoR7dmLSESFAEEtPUjk3rB3piPI/rKAQmpJ2Mno+fRu
	 /DmTy1ObF3/BpHT+EYC+/Hjz+PvHK09CX7ExRiJ9Mx8OYGpMMyTsG7OPc7IMQiMFDY
	 7R+SarmqMTygg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Mar 2024 11:46:14 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 11:46:14 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>
Subject: [PATCH v6 4/9] leds: lp3952: use devm API to cleanup module's resources
Date: Thu, 14 Mar 2024 11:45:26 +0300
Message-ID: <20240314084531.1935545-5-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314084531.1935545-1-gnstark@salutedevices.com>
References: <20240314084531.1935545-1-gnstark@salutedevices.com>
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


