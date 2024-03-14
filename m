Return-Path: <linux-kernel+bounces-103764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D387C425
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445C3281611
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641CF763E5;
	Thu, 14 Mar 2024 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="rQKxR+W1"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411276054;
	Thu, 14 Mar 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447563; cv=none; b=rMcdz9ZwW05qJbpSW5BGBHKsbjgH8NpPCqZi5MVABzV4wCOLNuQmC6klzArR6vF7ybuh3ktH6pXElon14unu8vrwCS0kZnFXnfM951GiZ79u9X26nLcFVFFA+JgdwJsP2JQ7cy3XWTVl2GumjKPZ8+Z2bu+iUPVRD/uSiJw1XdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447563; c=relaxed/simple;
	bh=km5tfIIVGKNwKDNZhdPYWzBEl6TL/6iXUWcTA0Hj06k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHIcU7uk1YlcY6AAQmrbPxyuz9XB86r3Zv4+IxKvIm7qv+3Fw8785UeZ3QDEbjuatn8j5RdMvauT4bS7DZHcUd4MWBPGZ9XOy6RWBDANJcigo40XQmCz+9lZdH5FtCWNgDuwCLHCRiBWn7tx4U6iWLYFNUxFwh6o3ofNlsz3t94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=rQKxR+W1; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E946E10000E;
	Thu, 14 Mar 2024 23:19:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E946E10000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710447556;
	bh=kUQZvb5TQE+27CS7ipmNtMTScgT6hB7NkwHTRSUgx7w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rQKxR+W1aHubAxB43VvBYbQ5CV6AuikGwWl3qVDB2XqOSkujyBIz16/ejTSKhkUft
	 0OmDn+9hjMNv5h2+3YknFR4k2HU3tyLkQvkGMqH9A6gqV7/48lJutdbgusTAT7SVqo
	 xL1wCIjavZY94nAMwCckcoNH6muJGhLT3ZuZI7K4Y+DoBhhrzJXy2MCbOHciJL/UJc
	 wCHe4Ll+WKqpgc1ezg3pXMV+CM2qnGDdjxC4OD1BtF+Lfi8a/haWRViaJAcG6ed4rO
	 gFNqpV2znT2/MPdPpdf8dtCoUk8ufAcRs3n030T6zDB8QsMvis0HxEtrBC2g9z9Dwe
	 ktoJOx5lZoxvA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Mar 2024 23:19:16 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 23:19:16 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>, Nikita
 Travkin <nikita@trvn.ru>
Subject: [PATCH v7 2/8] leds: aw2013: use devm API to cleanup module's resources
Date: Thu, 14 Mar 2024 23:18:50 +0300
Message-ID: <20240314201856.1991899-3-gnstark@salutedevices.com>
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


