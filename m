Return-Path: <linux-kernel+bounces-94871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E9874633
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD561F23F89
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B479E56E;
	Thu,  7 Mar 2024 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="JDo6+irj"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634716139;
	Thu,  7 Mar 2024 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779256; cv=none; b=I9TtZe5XwfQ8wyLpm9sqgjhUdFq0T8tT8VKi52pElOxeCMH6kGmuqqYhPs6s+cqUJ08WQCCnHiMkbtXChvoMPvX7RR79bD7n/NcO4QWujwCkqg11hDSLrZCaymLOtMwyJG8BNuz7Ok9WJcxJ2BEgu5W+mSOMMXejqz8Do5HuH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779256; c=relaxed/simple;
	bh=PIDOEaAKLWz5GNkyRQxsE0YdmWP8uMNFDBG7DQx5cxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pypkdx9iIKmU4GBtfj2wxRjNqhf6Iy6esusiQsoh44zNDhOvZCA35gnBeZOmIable8yOl4r2RZAp4T2Ptsod7dB/UV950/ZK0jVV2aYD0XsCvk1sjH8D/9hNODG+aD+v7S7sMpF9RpLDOY5JKnf9u8vIQPwUIyQX2GDE3tOa5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=JDo6+irj; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B5301120028;
	Thu,  7 Mar 2024 05:40:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B5301120028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709779246;
	bh=LmfiAF+FpdVlIohenEIhk6shsOuTjKAZ1y/DMUyjSdQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=JDo6+irj+Sd6POWGiTGvCfuRNFoPU4Aa2TzpOA2OO/VBCIsvzqexbGkOgMc61quhg
	 FV9o1Lbvgdi5DlaOBfO6KUU8XHEW31/s2SpxIZuL20Uf0GWqewzaQchKJ8QAV0Gs1A
	 PAlTKDsdm0slLYr6BZMG1L/baX/9rOEkr25yGIEK/Cgs5FoOD6yhrpjGPZRTpv4xfW
	 fyLDkiq3rZvjJw58QQ3l4O4AmcQhY9oXO0wn6VklxQShNvt51OZxSPwAJ4B+J/+JGQ
	 hfZ5czn5yRT+c7BnZE8Hqf8XDrB8MVc+2uClTwGjsMok+7iLUNXHfvi+1W7TSFG/i8
	 TyhcrHbTS5kiQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 05:40:46 +0300 (MSK)
Received: from localhost.localdomain (100.125.24.169) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 05:40:46 +0300
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
Subject: [PATCH v5 08/10] leds: mlxreg: use devm_mutex_init for mutex initializtion
Date: Thu, 7 Mar 2024 05:40:32 +0300
Message-ID: <20240307024034.1548605-9-gnstark@salutedevices.com>
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
the LEDs and that callback uses mutex which was destroyed already
in module's remove() so use devm API instead.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/leds/leds-mlxreg.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index d8e3d5d8d2d0..b1510cd32e47 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -257,6 +257,7 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *led_pdata;
 	struct mlxreg_led_priv_data *priv;
+	int err;
 
 	led_pdata = dev_get_platdata(&pdev->dev);
 	if (!led_pdata) {
@@ -268,26 +269,21 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	mutex_init(&priv->access_lock);
+	err = devm_mutex_init(&pdev->dev, &priv->access_lock);
+	if (err)
+		return err;
+
 	priv->pdev = pdev;
 	priv->pdata = led_pdata;
 
 	return mlxreg_led_config(priv);
 }
 
-static void mlxreg_led_remove(struct platform_device *pdev)
-{
-	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
-
-	mutex_destroy(&priv->access_lock);
-}
-
 static struct platform_driver mlxreg_led_driver = {
 	.driver = {
 	    .name = "leds-mlxreg",
 	},
 	.probe = mlxreg_led_probe,
-	.remove_new = mlxreg_led_remove,
 };
 
 module_platform_driver(mlxreg_led_driver);
-- 
2.25.1


