Return-Path: <linux-kernel+bounces-94877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F22A87463E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41DEB22561
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A148C1CAA4;
	Thu,  7 Mar 2024 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="b8PTFif/"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8415C8B;
	Thu,  7 Mar 2024 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779257; cv=none; b=fwhjdtuWX++Du293m//k/qA8TM2TPAt6E+3fU67ZabRydphBcr3tEd7nVuy9xL1gDlqjkEBAWQI8jgPdd49KrcZcA6bICTv0YKneud/urJMrpWJ8QoS7kJ3CQmUk66m5KJyXpyS7oQq3HAO6i3SW9fvczrDiRUr+9qzILpXw150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779257; c=relaxed/simple;
	bh=Rlhm1dbHK3QZmBGqM0Yvi7Buk6BTwyDX+ubGHWclzeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3/cbsgWsQim/xlmJHGOIUOq1hCxE+ifdyos+nnOw9jX7PaQNKu8upGbmTIgRCf1hLqmt5NedsiXUOcaI7WM+n2bNmOFskCMCilZ64zOfAH3NxMQuKQCir38YCAwozz6sihayBBu73mQ4Ixogt0B9hOVUu3jw3TlKeVilkYT3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=b8PTFif/; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C5AFB100029;
	Thu,  7 Mar 2024 05:40:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C5AFB100029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709779245;
	bh=gvlhRnJ5xJg26euVayo9SmeLTTcIC3Y5vdfnz8cqeiE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=b8PTFif/KCCMwBd+eHpYZVy7Q8lh/YTwIlp0mbtFteVA5FZH5v16o3nQqNWgHOUuB
	 ODHr7rJ78XNcdoelSLw608n7b8xuaIbPCq8KCPbWjHBlEFVaInvvCzFzTicQB7f5jx
	 iayQNmGybdpAxKKo9ZHOB6USVjMYZI1AveFiaT06SAS4Nlul93CMwyIuzOrwxj/dqt
	 7SUrQZPKo9x6AbwhnplKrCSbJD+M2+hIDuDIrJGotU5wSw/hdz+P1O5nwsq3sVyA22
	 MqATd2kS7VBdD2DCQNLb9iBIXEI/e6NmKRNvHKel6ODqP1nj/DTSpZqKJf8AUj0cNd
	 DICfjWSPQrZSw==
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
Subject: [PATCH v5 04/10] leds: aw200xx: use devm API to cleanup module's resources
Date: Thu, 7 Mar 2024 05:40:28 +0300
Message-ID: <20240307024034.1548605-5-gnstark@salutedevices.com>
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

Signed-off-by: George Stark <gnstark@salutedevices.com>
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


