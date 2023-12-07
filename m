Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3C809310
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443967AbjLGVHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjLGVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:07:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4501718;
        Thu,  7 Dec 2023 13:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701983253; x=1702588053; i=w_armin@gmx.de;
        bh=dokTWT5/qKEIWL3FjJAfR6lazLd3nT0Z4f+vw5U4Urg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PqXNYQK65B3Z1cuoUX+pUYSpj+feZYpdLXyrFla7F+ShY+RbsJYKOy0aV0MsapHh
         2NUUkrkjRtaia8BAnATWr+/dCQAfCdk4Eg72YudIZvG85sn3swvi8cEZiP6eFHPft
         ReYx/3KvdctwQvS6sxa61rbIFVWn1parj07M0fDh/3f2/fQMPmjtLEfVZZveTwyDj
         MzAyzicDD6Sq3faUuKLmoKoZ2gpNXZqGXB1TZpc9NLQZQgXOYCnfceKb35PheNUk1
         D2PI88aWlJ7y26PFxHmWpyYBrPhVajVLfaMsB5sgtA7NFodRr3eFNiP8j1vsqa9Sa
         pRMW8a6uGsMlHW0FEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MmUHp-1rc7q02jfF-00iQck; Thu, 07 Dec 2023 22:07:33 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     wilken.gottwalt@posteo.net
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (corsair-psu) Fix probe when built-in
Date:   Thu,  7 Dec 2023 22:07:23 +0100
Message-Id: <20231207210723.222552-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GCP0IYyl6x0+7OkHz3se1KwxZHXxR7z9mJpNQtKLxCeiqWUcqKF
 sWLZKmt9pQCxmcmgCLFtmHBpc9oGRalpZRtXADrgH7xUscT9B12Dy6vPgZgMDAZqtTwT30M
 7toyZtXQWCO/FVpA9CaZJfGFxFTqphENMZXQWQvCuv3jwV67QHTl+S9m/+q3azcXTdIm3si
 zzWeu1pnMDLYXVs1bs1+Q==
UI-OutboundReport: notjunk:1;M01:P0:vHqp8faGvxk=;VPD02ArP9LJBfdJYyRNb5iGd9bE
 oYy6JcnGI+jpPnZpbLXra+I1k2Un/Q1ODq2DVk8tLB2ed70csY6c25QEwDfs7XxXrbrOCGh0O
 GPz4uLcOi3WtRi25MeKybEWbd5FDX6aGdIM1J5qjIKUqqlO29UX8D5YCE1Q9Am/ayaipPJ7bN
 HTjAiwWmZFPwPqpb+QpCjfK4A2UQDbwVC6ZvruHkmy3fv5YFJIBoZdzUBKseoIShG+ZErsX1n
 8dFQA0enQNcxvs6FNTaqncO88dRzYNhPs1x+9D6QVa8Th4fRR4+UlHTXr0WMrZxDCBJ4J7FGU
 5hxGXdEd9Lxu2UFalqL6xjiZrJNnQHjVjQrmjr1BH1nQYwcOGHPh3/2NcQLr0H6Zl5f/JlvWU
 PoY+KaePeIWKp2T+FtYXBFWEZlz3wWud5yyrs7cPw1J8XuTwHJXXkfPyU0TGkTa496eH8QZtx
 QHUF/bDoAEdMaiT19EBUFdTvVvkI4zL1VgL8uC5LSiILE51v7akzZNcZYcTrmG3pzbJU42IzC
 Am+YGAJnpnNf0reyQqxnn7WZWuKmzCX0vff8Tu1CNk4Zc4+PRXzqL4wan3IwQpnxKwg/8UH7U
 j0mvhebBv5mu6hS9HYRon3aA1oTXho4wklEYioWrIM3GoaSxpOlU7w/9Jbw/vuB8i8tr8wHRN
 mroiAiEB59QQkXYglyaH4qZxJAJbBRZFyVzLU/thihY5V9u0V0aaotB7vWxvBFuC+Bi74bTJs
 7AhGOrq6iFPfWo3yhAbvNIvMZYwuv1PSSEsN8PGmU/tp5P4RpQkyVXX+/s+aTeift0tU8EGtT
 CD3Z4j9Zfix4OpxfirbLI1nHpysPks9NKrTUIFlo2B8jtZyYRQgBc1kx4y1Dksn3HtEZ4uNht
 zfafgsISWG98Q/KCMk5n3rOfESqg0iVYwGea9B5DAKvp65Q+yRhVdVjP9/SkYojVq0tdBhhnO
 6BomVApjEXey2XIZ+ooT+kzOySQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that when the driver is built-in, the HID bus is
initialized after the driver is loaded, which whould cause
module_hid_driver() to fail.
Fix this by registering the driver after the HID bus using
late_initcall() in accordance with other hwmon HID drivers.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/corsair-psu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 904890598c11..2c7c92272fe3 100644
=2D-- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -899,7 +899,23 @@ static struct hid_driver corsairpsu_driver =3D {
 	.reset_resume	=3D corsairpsu_resume,
 #endif
 };
-module_hid_driver(corsairpsu_driver);
+
+static int __init corsair_init(void)
+{
+	return hid_register_driver(&corsairpsu_driver);
+}
+
+static void __exit corsair_exit(void)
+{
+	hid_unregister_driver(&corsairpsu_driver);
+}
+
+/*
+ * With module_init() the driver would load before the HID bus when
+ * built-in, so use late_initcall() instead.
+ */
+late_initcall(corsair_init);
+module_exit(corsair_exit);

 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
=2D-
2.39.2

