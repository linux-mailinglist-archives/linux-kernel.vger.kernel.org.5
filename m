Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED38580A423
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573774AbjLHNHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjLHNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:07:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24A171F;
        Fri,  8 Dec 2023 05:07:25 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54f4fa5002cso742712a12.1;
        Fri, 08 Dec 2023 05:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702040844; x=1702645644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3tkIl1Zsu8hqtQpagsNeL2rVPQBWVM0/G1ApY7SfSE=;
        b=gTLWgtdps8AjhfojDVLEsos+crcltNS2szg+D/vRaItTnbi+4L7jpnwGsHsiAX14zG
         GGOGCGzyvjS1u5CF0X1iBiY2s1oGxCiGkJjyWVMsnHH8pFk9VlDxZB64TbIqN4A467Kc
         fQQll/9/GUl2YwZR4A7Wglie4kbQx9BzwpzQ3N9Ouau9v1bxA8tjet8O6d8GMDESFl3l
         Cjg2/HnHPrEgPVzb65EkEgREmgiga+9492K8r4hsoKzZvRq1AjDR9354FZiAnV+ZIJkS
         ATZ2jew91DQy3rqSKinRbpjPWNb3O34c2gE3F2MZA/PZVvifklc+KsX3UYPtBsDmVP7Q
         6Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702040844; x=1702645644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3tkIl1Zsu8hqtQpagsNeL2rVPQBWVM0/G1ApY7SfSE=;
        b=nALe2OeHdsX4J7JvlsbgOJ0eKGrOXt+b8OVJ5NipzCSQsO3rPyxyMJFT7NnGhzf14X
         uiXjwVNuoHdDID4rYoMclA7D/TQbJmpv3iPIh1z+IXCO9M1MqEJqLI75TOHB3P6Tvh1V
         SMpIEJ+ajurP5zo1StjV7zZ5reVhe+RjLXH6FSE+oScou/T5sUEfRi0wYjLy2Icz0jkx
         MC2T0xiJxPLaoS/SEddWGfY3E//PF2/so2H6dQbnqycI1kaKS2kspe88QeOFd6+97add
         ISakP2giAf92JUGKuQNDNPkCJYscEYY+Z90WJw36Yegs4/3M3mk+slYAnoJAx3OtK+AQ
         T21g==
X-Gm-Message-State: AOJu0YwSNWRPa33TzKYFJbhJZnrzcv/FpMjIs8wJ1KnkAF2LeVvDGcVX
        K70ytTEpjnK3qZzf+d89H5A2+k5ApKcYSA==
X-Google-Smtp-Source: AGHT+IH3XEJoMqsYORycz0VV7hsMQpSHTPj2yDbFbnc2ItgQyONcW0I4swcY+6zr43NA6Kof9oh9Ng==
X-Received: by 2002:a17:907:8f1a:b0:a19:a19b:55da with SMTP id wg26-20020a1709078f1a00b00a19a19b55damr2149804ejc.106.1702040843766;
        Fri, 08 Dec 2023 05:07:23 -0800 (PST)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906d00900b009c5c5c2c5a4sm985445ejy.219.2023.12.08.05.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:07:23 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (corsair-psu) Fix failure to load when built-in to kernel
Date:   Fri,  8 Dec 2023 14:07:10 +0100
Message-ID: <20231208130710.191420-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When built-in to the kernel, the corsair-psu driver fails to register with
the following message:

"Driver 'corsair-psu' was unable to register with bus_type 'hid'
because the bus was not initialized."

Fix this by initializing the driver after the HID bus using
late_initcall(), as hwmon is built before HID.

Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/corsair-psu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 904890598c11..48831a528965 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -899,7 +899,20 @@ static struct hid_driver corsairpsu_driver = {
 	.reset_resume	= corsairpsu_resume,
 #endif
 };
-module_hid_driver(corsairpsu_driver);
+
+static int __init corsairpsu_hid_init(void)
+{
+	return hid_register_driver(&corsairpsu_driver);
+}
+
+static void __exit corsairpsu_hid_exit(void)
+{
+	hid_unregister_driver(&corsairpsu_driver);
+}
+
+/* When compiled into the kernel, initialize after the hid bus */
+late_initcall(corsairpsu_hid_init);
+module_exit(corsairpsu_hid_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
-- 
2.43.0

