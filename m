Return-Path: <linux-kernel+bounces-94876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788987463D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39823B22254
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E671CAA1;
	Thu,  7 Mar 2024 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZWlsCrBG"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80A4C8B;
	Thu,  7 Mar 2024 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779257; cv=none; b=SxWtemnbQkudA3HyJrppxi3J2hNFQZUiV0NSu2OjozHw7tXXZO8i3VpajYHpWg90g5z6ztCaMDYt7rJtg4E4oY40L1qP+vxV4MUrqMdfDQtl1z28tYTSbwP0YkRPqcagG2zTVxM2LDnrydB0ojA2VRRuj0cMZJ++BYYfpoVCt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779257; c=relaxed/simple;
	bh=5IGhjunV2hAmlgsdkLV8Tg/Fpxd45I02KlxjIntlF8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5Jookzi1Uncs7EEptgWltf/EY47hGUhOq/kBfKaFv87+isvA9A4w5mSvFZ1Ayz9oDwHtyKX6hclUyQ7QfSA9/+XAvkGgecm4UdoCBsVUK2wMWiVn7/zOtybicR9bq+6wz3wxZtfr5uX+ZJfbZUPidxThuAQ+HV04hvA/xqQeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ZWlsCrBG; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7AA3D10003A;
	Thu,  7 Mar 2024 05:40:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7AA3D10003A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709779246;
	bh=9xjL3ldEl071R5nZpqc+4uOtXpIAYgEXiDe8edy0VvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ZWlsCrBGOEK+F3p8ssLvbis08QhtmTLVfwi30KcZt7QBhmC2HAklFEBVUPnoNUFiV
	 hVriW75UHXI20eojErsh2eTq5P3F+BWoHW2rtYnVhk5axFhswlr8zaev33VVycotX+
	 fWoZ/spYz6a4zZSquwrSWrKkmp0/pysyITDOLD5eyreSDO99ehG3fwFEgZgLaud2Ae
	 dPYs4k7AAVnpy05Kj8VTo7jYFD5eh8NWiCeTkC38hkddvvhj+iIRj3JW7JwlTUUvOT
	 Jcvd1rymAGnK96O2o5bd6IwUuGN+YFtf/OJC/PvEgRgqBd5Muc1fI7o0BqGoIEizma
	 h/8feEcVMDfOg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 05:40:46 +0300 (MSK)
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
Subject: [PATCH v5 07/10] leds: nic78bx: use devm API to cleanup module's resources
Date: Thu, 7 Mar 2024 05:40:31 +0300
Message-ID: <20240307024034.1548605-8-gnstark@salutedevices.com>
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
 drivers/leds/leds-nic78bx.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-nic78bx.c b/drivers/leds/leds-nic78bx.c
index a86b43dd995e..f3049fa14f04 100644
--- a/drivers/leds/leds-nic78bx.c
+++ b/drivers/leds/leds-nic78bx.c
@@ -118,6 +118,15 @@ static struct nic78bx_led nic78bx_leds[] = {
 	}
 };
 
+static void lock_led_reg_action(void *data)
+{
+	struct nic78bx_led_data *led_data = (struct nic78bx_led_data *)data;
+
+	/* Lock LED register */
+	outb(NIC78BX_LOCK_VALUE,
+	     led_data->io_base + NIC78BX_LOCK_REG_OFFSET);
+}
+
 static int nic78bx_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -152,6 +161,10 @@ static int nic78bx_probe(struct platform_device *pdev)
 	led_data->io_base = io_rc->start;
 	spin_lock_init(&led_data->lock);
 
+	ret = devm_add_action(dev, lock_led_reg_action, led_data);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(nic78bx_leds); i++) {
 		nic78bx_leds[i].data = led_data;
 
@@ -167,15 +180,6 @@ static int nic78bx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void nic78bx_remove(struct platform_device *pdev)
-{
-	struct nic78bx_led_data *led_data = platform_get_drvdata(pdev);
-
-	/* Lock LED register */
-	outb(NIC78BX_LOCK_VALUE,
-	     led_data->io_base + NIC78BX_LOCK_REG_OFFSET);
-}
-
 static const struct acpi_device_id led_device_ids[] = {
 	{"NIC78B3", 0},
 	{"", 0},
@@ -184,7 +188,6 @@ MODULE_DEVICE_TABLE(acpi, led_device_ids);
 
 static struct platform_driver led_driver = {
 	.probe = nic78bx_probe,
-	.remove_new = nic78bx_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.acpi_match_table = ACPI_PTR(led_device_ids),
-- 
2.25.1


