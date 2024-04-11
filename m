Return-Path: <linux-kernel+bounces-141286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5398A1C24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BCC2857B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877A9153835;
	Thu, 11 Apr 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="kI2ESRTy"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2915351E;
	Thu, 11 Apr 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851845; cv=none; b=ATrmS+etFe2pk48wwq2D45iPJD+FKFIYByjhfz2of5MNs2BOpunqelSigDsz900qqJtBATDoWDEvefRqj4PQ67lcKX2E/T18FxSBSie3F0r2OBPPhiL9GsdpDs1gq63tfDs+F8rfitpIU6A0TAMUWWsK1U5SrLLKv9bXafarW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851845; c=relaxed/simple;
	bh=Ee9t5wgYySOImH3txU7snhqr+aoeqeD/sGYjtiDEwBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHCpH6Gc0PJFdKN3z9D4ZY4T32kW2KoPz2ZzDo5IgjsqoAA5wiR2sl5gKH5cbNmUdBlPWpDZhSQJyVlJt5HWtorxGMi0f1qJ0RojxBlT33JfeIqvSssVtQqo4Pli+EjbIGnwV8Dp3vm1IAcLiKl923GOSYytQf6jrOPiojHpXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=kI2ESRTy; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7923B100088;
	Thu, 11 Apr 2024 19:10:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7923B100088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712851840;
	bh=cuCak+NlmhIY2negLCK2w9g07AJl/hJfG4AVSOva5sg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kI2ESRTyB6m2f/WbcxxaTdQYGqz3FK4MMtBxNxXWRoNKsNnST1auUr9nWShiRHIcv
	 jYTJtaHfKZBx1TBcnEodiCneOr/1wR55+KPGUef1jCz4hGrDHWmcMZy/LTtznIx/53
	 j/1gWlF+ROq1b2cBEBX0aN/yeugwOwWSbZR5bMyL111Gqc+1XSGmPWojbt3sqpkM7c
	 7FPF2QbWXzbEzSJCyaDIjAY+0DsmUltPx+L2uCk5Z9jc2Q3ziUVRVl7tIl20YRpOAX
	 KVDkysLiQCXypOJbr2RvEhK4EfqU9xkjMUHVx8/w5c9zB/7IjAJPgXlx3ceyWGujbm
	 YWIYeCXF3QnAA==
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
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v8 3/8] leds: aw200xx: use devm API to cleanup module's resources
Date: Thu, 11 Apr 2024 19:10:27 +0300
Message-ID: <20240411161032.609544-4-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/11 11:38:00 #24745823
X-KSMG-AntiVirus-Status: Clean, skipped

In this driver LEDs are registered using devm_led_classdev_register()
so they are automatically unregistered after module's remove() is done.
led_classdev_unregister() calls module's led_set_brightness() to turn off
the LEDs and that callback uses resources which were destroyed already
in module's remove() so use devm API instead of remove().

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/leds-aw200xx.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index f584a7f98fc5..5cba52d07b38 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -530,6 +530,16 @@ static const struct regmap_config aw200xx_regmap_config = {
 	.disable_locking = true,
 };
 
+static void aw200xx_chip_reset_action(void *data)
+{
+	aw200xx_chip_reset(data);
+}
+
+static void aw200xx_disable_action(void *data)
+{
+	aw200xx_disable(data);
+}
+
 static int aw200xx_probe(struct i2c_client *client)
 {
 	const struct aw200xx_chipdef *cdef;
@@ -568,11 +578,17 @@ static int aw200xx_probe(struct i2c_client *client)
 
 	aw200xx_enable(chip);
 
+	ret = devm_add_action(&client->dev, aw200xx_disable_action, chip);
+	if (ret)
+		return ret;
+
 	ret = aw200xx_chip_check(chip);
 	if (ret)
 		return ret;
 
-	mutex_init(&chip->mutex);
+	ret = devm_mutex_init(&client->dev, &chip->mutex);
+	if (ret)
+		return ret;
 
 	/* Need a lock now since after call aw200xx_probe_fw, sysfs nodes created */
 	mutex_lock(&chip->mutex);
@@ -581,6 +597,10 @@ static int aw200xx_probe(struct i2c_client *client)
 	if (ret)
 		goto out_unlock;
 
+	ret = devm_add_action(&client->dev, aw200xx_chip_reset_action, chip);
+	if (ret)
+		goto out_unlock;
+
 	ret = aw200xx_probe_fw(&client->dev, chip);
 	if (ret)
 		goto out_unlock;
@@ -595,15 +615,6 @@ static int aw200xx_probe(struct i2c_client *client)
 	return ret;
 }
 
-static void aw200xx_remove(struct i2c_client *client)
-{
-	struct aw200xx *chip = i2c_get_clientdata(client);
-
-	aw200xx_chip_reset(chip);
-	aw200xx_disable(chip);
-	mutex_destroy(&chip->mutex);
-}
-
 static const struct aw200xx_chipdef aw20036_cdef = {
 	.channels = 36,
 	.display_size_rows_max = 3,
@@ -652,7 +663,6 @@ static struct i2c_driver aw200xx_driver = {
 		.of_match_table = aw200xx_match_table,
 	},
 	.probe = aw200xx_probe,
-	.remove = aw200xx_remove,
 	.id_table = aw200xx_id,
 };
 module_i2c_driver(aw200xx_driver);
-- 
2.25.1


