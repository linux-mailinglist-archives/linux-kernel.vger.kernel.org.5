Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB71768EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjGaHd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjGaHcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:32:51 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50A281BFB;
        Mon, 31 Jul 2023 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4QzEY
        IktEA2+sOlnGV7rZYJnYleI7xYKEEZG31RhhOY=; b=SjA7izv8EbXsrjF7antlF
        wongP/KnyRu9bisW7vU2CmecVYp+YPevp3tOXGyh4jbJaCgIV7OQrheYZNtEWc41
        hlXvUz797PghwUMbG3oBWDX90lTZoqWJ7iQBBk1HL0dHRAWtQ0UbSEyH+0tJn0qU
        VIWZTIPjZyyeyhTN5lxMb4=
Received: from localhost.localdomain (unknown [39.144.138.187])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wBHp79qX8dkyjkSBw--.38597S3;
        Mon, 31 Jul 2023 15:14:53 +0800 (CST)
From:   xingtong_wu@163.com
To:     hdegoede@redhat.com, markgross@kernel.org,
        henning.schild@siemens.com, andriy.shevchenko@linux.intel.com,
        lee@kernel.org, xingtong.wu@siemens.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: simatic-ipc: add new models BX-56A/BX-59A
Date:   Mon, 31 Jul 2023 15:14:24 +0800
Message-Id: <20230731071424.4663-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731071424.4663-1-xingtong_wu@163.com>
References: <20230731071424.4663-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHp79qX8dkyjkSBw--.38597S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWDWry3JFW5tF43Kry7GFg_yoW5KFW7pF
        n5ArW8AFW3Wa40ywn3Ga9rZFZxZwsIkr47GayUArnrA3sFgrsYqF9rAF4fJFy3Jw45W3y3
        W3Z5trW7WF4DZrUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyQ6JUUUUU=
X-Originating-IP: [39.144.138.187]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbCfge90GDcO8jJkQAAsD
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

This adds support for the Siemens Simatic IPC models BX-56A/BX-59A,
led/watchdog/battery on these models are same, actual drivers for
models will be sent in separate patches.

Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
---
 drivers/platform/x86/siemens/simatic-ipc.c         | 12 ++++++++++--
 include/linux/platform_data/x86/simatic-ipc-base.h |  1 +
 include/linux/platform_data/x86/simatic-ipc.h      |  2 ++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 13c857316c7f..02c540cf4070 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -78,6 +78,12 @@ static struct {
 	{SIMATIC_IPC_IPCBX_21A,
 		SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_21A,
 		{ "emc1403", NULL }},
+	{SIMATIC_IPC_IPCBX_56A,
+		SIMATIC_IPC_DEVICE_BX_59A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_59A,
+		{ "emc1403", "w83627hf_wdt" }},
+	{SIMATIC_IPC_IPCBX_59A,
+		SIMATIC_IPC_DEVICE_BX_59A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_59A,
+		{ "emc1403", "w83627hf_wdt" }},
 };
 
 static int register_platform_devices(u32 station_id)
@@ -103,7 +109,9 @@ static int register_platform_devices(u32 station_id)
 			pdevname = KBUILD_MODNAME "_batt_apollolake";
 		if (battmode == SIMATIC_IPC_DEVICE_BX_21A)
 			pdevname = KBUILD_MODNAME "_batt_elkhartlake";
-		if (battmode == SIMATIC_IPC_DEVICE_227G || battmode == SIMATIC_IPC_DEVICE_BX_39A)
+		if (battmode == SIMATIC_IPC_DEVICE_227G ||
+		    battmode == SIMATIC_IPC_DEVICE_BX_39A ||
+		    battmode == SIMATIC_IPC_DEVICE_BX_59A)
 			pdevname = KBUILD_MODNAME "_batt_f7188x";
 		platform_data.devmode = battmode;
 		ipc_batt_platform_device =
@@ -121,7 +129,7 @@ static int register_platform_devices(u32 station_id)
 		pdevname = KBUILD_MODNAME "_leds";
 		if (ledmode == SIMATIC_IPC_DEVICE_127E)
 			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
-		if (ledmode == SIMATIC_IPC_DEVICE_227G)
+		if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
 			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
 		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
 			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";
diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
index 4ca21065c862..2d7f7120ba6b 100644
--- a/include/linux/platform_data/x86/simatic-ipc-base.h
+++ b/include/linux/platform_data/x86/simatic-ipc-base.h
@@ -22,6 +22,7 @@
 #define SIMATIC_IPC_DEVICE_227G 5
 #define SIMATIC_IPC_DEVICE_BX_21A 6
 #define SIMATIC_IPC_DEVICE_BX_39A 7
+#define SIMATIC_IPC_DEVICE_BX_59A 8
 
 struct simatic_ipc_platform {
 	u8	devmode;
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index f2eafa43a605..8d8b3b919674 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -36,6 +36,8 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPCBX_39A = 0x00001001,
 	SIMATIC_IPC_IPCPX_39A = 0x00001002,
 	SIMATIC_IPC_IPCBX_21A = 0x00001101,
+	SIMATIC_IPC_IPCBX_56A = 0x00001201,
+	SIMATIC_IPC_IPCBX_59A = 0x00001202,
 };
 
 static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)
-- 
2.25.1

