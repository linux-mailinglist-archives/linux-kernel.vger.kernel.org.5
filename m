Return-Path: <linux-kernel+bounces-141285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9B88A1C23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61BF1C22AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBED15382C;
	Thu, 11 Apr 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="cATENxcS"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE82DF84;
	Thu, 11 Apr 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851845; cv=none; b=iz+WTDoG9FDNuQ7AMyNupOhSFLh6n5+DeC5FWTNxgGvuS6Pi2n0blLp/D8XZ+GxE5Cu7J9fRp67CZKkc34WM8f1qQXN/ZnwksJMPmh71jFdppQTwVazLM9k6KVPk4IWrgKw+l+2ruZ/dqYZny2PgQlRi4bZpPKIWG0A1Ri75VGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851845; c=relaxed/simple;
	bh=YrFUXpKFZjIrDFt23to5aJksa5NkAaPagqMfCoJao4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzNiTS17Du/BzoKKiz4ljlbunc4R+9n1t4+k9gGko9GPMLOgRji3zNqsca9cxCyxrbnFLCT7JGQTcpPRv7aFR5tccPDL7YYmmOS6qfEV8GaTNoarZj0Z53uTzcOcnV3cGv/W4brSyN1awVVDEPOZvSjDh/JCZHxDBnRxwmbppv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=cATENxcS; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 84F9D120074;
	Thu, 11 Apr 2024 19:10:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 84F9D120074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712851841;
	bh=Gg4VD7krOgd1nsrFz5L0eWRpEbtXVfyqyU7Jkdx9Zzk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=cATENxcS+szALY2mLzl8KnO8O23E0TN8/9+vEyHyNl+LRtnWg466Ce845SlJbRs8B
	 piMxT8qymhLNMpJpy08zmEBWkWQ65N7O74WmrmafOkn6LROoh/RI5ne9ZurguFGmXh
	 OH6XR6nL/pB1Uy7q61rOZiBR5FB4HoJy1Vp1GVkFUqi3yNsLOc0tKTEMZsuAV+cqFB
	 c4yNwX8qTSV/pMcNXf8yNAXvrDIJJdt1uWd6wnhi0W9xNVNdqwJJrKqj4XbW8eFdK5
	 1E1fdTJiOJ4lZkprkwvNiu2iMk40fGOYvD0Eo1567olFWnsYK2GHyTRyb5SZEmtBm7
	 1Sgu+ZIdqwtqQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 19:10:41 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Apr 2024 19:10:41 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v8 8/8] leds: an30259a: use devm_mutex_init() for mutex initialization
Date: Thu, 11 Apr 2024 19:10:32 +0300
Message-ID: <20240411161032.609544-9-gnstark@salutedevices.com>
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
the LEDs and that callback uses mutex which was destroyed already
in module's remove() so use devm API instead.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/leds-an30259a.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index 0216afed3b6e..decfca447d8a 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -283,7 +283,10 @@ static int an30259a_probe(struct i2c_client *client)
 	if (err < 0)
 		return err;
 
-	mutex_init(&chip->mutex);
+	err = devm_mutex_init(&client->dev, &chip->mutex);
+	if (err)
+		return err;
+
 	chip->client = client;
 	i2c_set_clientdata(client, chip);
 
@@ -317,17 +320,9 @@ static int an30259a_probe(struct i2c_client *client)
 	return 0;
 
 exit:
-	mutex_destroy(&chip->mutex);
 	return err;
 }
 
-static void an30259a_remove(struct i2c_client *client)
-{
-	struct an30259a *chip = i2c_get_clientdata(client);
-
-	mutex_destroy(&chip->mutex);
-}
-
 static const struct of_device_id an30259a_match_table[] = {
 	{ .compatible = "panasonic,an30259a", },
 	{ /* sentinel */ },
@@ -347,7 +342,6 @@ static struct i2c_driver an30259a_driver = {
 		.of_match_table = an30259a_match_table,
 	},
 	.probe = an30259a_probe,
-	.remove = an30259a_remove,
 	.id_table = an30259a_id,
 };
 
-- 
2.25.1


