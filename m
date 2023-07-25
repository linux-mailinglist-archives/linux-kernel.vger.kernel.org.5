Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F87626F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjGYWjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjGYWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:39:26 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751992D50;
        Tue, 25 Jul 2023 15:32:45 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2680eee423aso1264959a91.2;
        Tue, 25 Jul 2023 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690324229; x=1690929029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gls0dGaLA0UDpfJAcGvNYCBWQvOuHanMjcOY6FAt6QE=;
        b=DPc25y3YABgHnz7POnk09Ir7LGBDng496s5QTBgBJgYrU0C8Q7m4GDJeQwTP5mAxn3
         suSdCNfYJ7VI5x1u96fBfGx3wFzqum5IKhlm0TrBPBx8RDLcr508e+FeRa5ypp1KXu2G
         Fnmn1j/Ch8lSNL/R7befU7oaZn6hzQfJgeMU419N2IkxkD/f+PSXea0ayuQn/np1kQ7E
         /zDNRevzs9n4NXudawLqvPysBr/NlUTbF6rc4KfjQwhNUlSd859bOhHaxTziba6eiaNu
         m5AC1OQiNyA3QCzqXbbnT7J1MsHx5nk3MeitHM/I5ZctxNU4anX1hnGOC97p2jp5fRc/
         Y3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324229; x=1690929029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gls0dGaLA0UDpfJAcGvNYCBWQvOuHanMjcOY6FAt6QE=;
        b=kFXEKa5YHAuQpqgx75sXGe6LL1QYIgGNsjZzcPxqx3AxT8UMwhzWUNoZvhSnbKBo5R
         ggnVY4g0cDh13Ad5FGERt5fih5ckiFxis+2oQwJ21zqCyY4lo+Lqw6r+qIxWj/8LYkYK
         Ct+fKdWkaAr9O+s3acI9VCCaMYFav1Kp8SZY6YLwKmwZJ+gM5q8ZRMyZI0V06zsgl17o
         ZNCqxZF09gsXx+MRleegLZ2pTcHRp/95B5urd0DJjgcVSVK0g/zG6LGboBhgHdfNiqFN
         QZXddJJaE5byvtVPruyUczok8a+RQyofRNR3nHdUG8/oeTRxkbima+zl5H67iTMZmAOs
         Gvpg==
X-Gm-Message-State: ABy/qLblGhflMijB7e+eVBXTLt1QIEmWUHY+wanZ7bixOJq+VVggEj/0
        BwBVJSib1X7i4PpFkx9HOjiaTsPGGeRYaw==
X-Google-Smtp-Source: APBJJlHuaxPzWJY7v5gQBpe3AjZ72pKtzAEHZAr3p1eoGEiTkam2lZNK6W31fFAq49UMZl1OLYfJ1A==
X-Received: by 2002:a4a:2401:0:b0:567:154:25dc with SMTP id m1-20020a4a2401000000b00567015425dcmr148297oof.7.1690323639224;
        Tue, 25 Jul 2023 15:20:39 -0700 (PDT)
Received: from localhost.localdomain ([97.115.139.81])
        by smtp.gmail.com with ESMTPSA id n19-20020a4ad633000000b00566250a04f6sm5411544oon.18.2023.07.25.15.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:20:38 -0700 (PDT)
From:   Aaron Armstrong Skomra <skomra@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com, jikos@kernel.org
Cc:     pinglinux@gmail.com, skomra@gmail.com, Joshua@Joshua-Dickens.com,
        jason.gerecke@wacom.com, stable@vger.kernel.org,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Subject: [PATCH Wacom EKR Battery Fixes 1/3] HID: wacom: remove the battery when the EKR is off
Date:   Tue, 25 Jul 2023 15:20:25 -0700
Message-Id: <20230725222025.123829-1-skomra@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Currently the EKR battery remains even after we stop getting information
from the device. This can lead to a stale battery persisting indefinitely
in userspace.

The remote sends a heartbeat every 10 seconds. Delete the battery if we
miss two heartbeats (after 21 seconds). Restore the battery once we see
a heartbeat again.

Signed-off-by: Aaron Skomra <skomra@gmail.com>
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
Fixes: 9f1015d45f62 ("HID: wacom: EKR: attach the power_supply on first connection")
CC: stable@vger.kernel.org
---
 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 25 +++++++++++++++++++++----
 drivers/hid/wacom_wac.c |  1 +
 drivers/hid/wacom_wac.h |  1 +
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 4da50e19808e..166a76c9bcad 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -150,6 +150,7 @@ struct wacom_remote {
 		struct input_dev *input;
 		bool registered;
 		struct wacom_battery battery;
+		ktime_t active_time;
 	} remotes[WACOM_MAX_REMOTES];
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 76e5353aca0c..eb833455abd5 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2523,6 +2523,18 @@ static void wacom_wireless_work(struct work_struct *work)
 	return;
 }
 
+static void wacom_remote_destroy_battery(struct wacom *wacom, int index)
+{
+	struct wacom_remote *remote = wacom->remote;
+
+	if (remote->remotes[index].battery.battery) {
+		devres_release_group(&wacom->hdev->dev,
+				     &remote->remotes[index].battery.bat_desc);
+		remote->remotes[index].battery.battery = NULL;
+		remote->remotes[index].active_time = 0;
+	}
+}
+
 static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 {
 	struct wacom_remote *remote = wacom->remote;
@@ -2537,9 +2549,7 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 			remote->remotes[i].registered = false;
 			spin_unlock_irqrestore(&remote->remote_lock, flags);
 
-			if (remote->remotes[i].battery.battery)
-				devres_release_group(&wacom->hdev->dev,
-						     &remote->remotes[i].battery.bat_desc);
+			wacom_remote_destroy_battery(wacom, i);
 
 			if (remote->remotes[i].group.name)
 				devres_release_group(&wacom->hdev->dev,
@@ -2547,7 +2557,6 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
-			remote->remotes[i].battery.battery = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -2632,6 +2641,9 @@ static int wacom_remote_attach_battery(struct wacom *wacom, int index)
 	if (remote->remotes[index].battery.battery)
 		return 0;
 
+	if (!remote->remotes[index].active_time)
+		return 0;
+
 	if (wacom->led.groups[index].select == WACOM_STATUS_UNKNOWN)
 		return 0;
 
@@ -2647,6 +2659,7 @@ static void wacom_remote_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
 	struct wacom_remote *remote = wacom->remote;
+	ktime_t kt = ktime_get();
 	struct wacom_remote_data data;
 	unsigned long flags;
 	unsigned int count;
@@ -2673,6 +2686,10 @@ static void wacom_remote_work(struct work_struct *work)
 		serial = data.remote[i].serial;
 		if (data.remote[i].connected) {
 
+			if (kt - remote->remotes[i].active_time > WACOM_REMOTE_BATTERY_TIMEOUT
+			    && remote->remotes[i].active_time != 0)
+				wacom_remote_destroy_battery(wacom, i);
+
 			if (remote->remotes[i].serial == serial) {
 				wacom_remote_attach_battery(wacom, i);
 				continue;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 174bf03908d7..6c056f8844e7 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1134,6 +1134,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	if (index < 0 || !remote->remotes[index].registered)
 		goto out;
 
+	remote->remotes[i].active_time = ktime_get();
 	input = remote->remotes[index].input;
 
 	input_report_key(input, BTN_0, (data[9] & 0x01));
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index ee21bb260f22..2e7cc5e7a0cb 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -13,6 +13,7 @@
 #define WACOM_NAME_MAX		64
 #define WACOM_MAX_REMOTES	5
 #define WACOM_STATUS_UNKNOWN	255
+#define WACOM_REMOTE_BATTERY_TIMEOUT	21000000000ll
 
 /* packet length for individual models */
 #define WACOM_PKGLEN_BBFUN	 9
-- 
2.34.1

