Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2737626C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjGYWak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjGYW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:29:13 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C9686B1;
        Tue, 25 Jul 2023 15:22:30 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9aadde448so5373371a34.0;
        Tue, 25 Jul 2023 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690323689; x=1690928489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoqBZACiffS3PvfY6uEqr+KMqSZjH648nxXLpj9jwZw=;
        b=eNciaTky3iP20Evx3ssQ9TOYRQbxiWbJDceVGk9sIoFkX1rjcRKA4rhamh0RoGCY9y
         JzmxJ3PXGKGGKRiBP1ClIHoT2YAT8eFqLkUZbCfQO40OtBPyR2ZDetuxwHXuHGhmjxbZ
         5WfPLMEJr0iLJB2eiHVTQxt73xdJF1DA0PKYzlhVWZXT/StiTigitF1fMzCtnEHYy3I2
         C4oO4Z2G3JpeCP+OWxRtg9hyZHWITECDMmP1dyK1wgtUvtdt2f/OE6u0bzO64TIOa9+t
         fxZI6skELUns5cibeWPXeAlG2JFktSb5wo/9b8IthT4e8qcafKXVgggJaQl3QiAYKwen
         S1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690323689; x=1690928489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoqBZACiffS3PvfY6uEqr+KMqSZjH648nxXLpj9jwZw=;
        b=XlqNDKqAviV40V+CDnSeCRDssNSKx4FNGhCmV0jUgCWKTZ1Xr3eZ3gtBBY+EapBdBT
         mmewJS1xs3+r2yARj8blyDPl5ODfp/+MGZynt9u8nH0V5YAMAFgY7MfxAH3A1nbc5fb0
         IrvPsbsuhRdBBa2Bdtq2fSooY1Ehmy7MHl4bcv0X7wvVPFP64RhbF/hba4vjld99jGtG
         uF0tTPDnRXc6Meq0eTw6JFAQ9YeWhyqJallpRT61W+NvlpZoK9YJ1o+rVqCZ2T2ywM7w
         dVU6WoDEpZ+sPSppOIpyfz0DOxFeveZ/ZX+iu/A+79qn/YifOzo2OmEblj8TTepanMg2
         7NeQ==
X-Gm-Message-State: ABy/qLYix/Em2NnBmYtPdmvRPyC82MndY8aVVDnQr/4AC19BKCXWNPXB
        b6wSB0BJxBg/+UJNxQShj5mOlQ9Y8DypFA==
X-Google-Smtp-Source: APBJJlEVHVNLZflSAeZoJdGcOzKK9N4lBZyokxE0WZfOygjpzE9RCEqcR90yDT8tR9Rcl2ZuAlDpnQ==
X-Received: by 2002:a05:6870:e74b:b0:1bb:68ce:382c with SMTP id t11-20020a056870e74b00b001bb68ce382cmr440167oak.8.1690323688770;
        Tue, 25 Jul 2023 15:21:28 -0700 (PDT)
Received: from localhost.localdomain ([97.115.139.81])
        by smtp.gmail.com with ESMTPSA id s22-20020a0568301e1600b006b9cbad68a8sm5312608otr.30.2023.07.25.15.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:21:28 -0700 (PDT)
From:   Aaron Armstrong Skomra <skomra@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com, jikos@kernel.org
Cc:     pinglinux@gmail.com, skomra@gmail.com, Joshua@Joshua-Dickens.com,
        jason.gerecke@wacom.com,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Subject: [PATCH Wacom EKR Battery Fixes 3/3] HID: wacom: struct name cleanup
Date:   Tue, 25 Jul 2023 15:21:25 -0700
Message-Id: <20230725222125.123887-1-skomra@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Help differentiate the two remote related "serial" struct variables by
renaming "wacom_remote_data" to "wacom_remote_work_data".

Signed-off-by: Aaron Skomra <skomra@gmail.com>
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 19 ++++++++++---------
 drivers/hid/wacom_wac.c |  4 ++--
 drivers/hid/wacom_wac.h |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 16862f97c46c..3f704b8072e8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1997,7 +1997,7 @@ static int wacom_initialize_remotes(struct wacom *wacom)
 	spin_lock_init(&remote->remote_lock);
 
 	error = kfifo_alloc(&remote->remote_fifo,
-			5 * sizeof(struct wacom_remote_data),
+			5 * sizeof(struct wacom_remote_work_data),
 			GFP_KERNEL);
 	if (error) {
 		hid_err(wacom->hdev, "failed allocating remote_fifo\n");
@@ -2660,17 +2660,18 @@ static void wacom_remote_work(struct work_struct *work)
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
 	struct wacom_remote *remote = wacom->remote;
 	ktime_t kt = ktime_get();
-	struct wacom_remote_data data;
+	struct wacom_remote_work_data remote_work_data;
 	unsigned long flags;
 	unsigned int count;
-	u32 serial;
+	u32 work_serial;
 	int i;
 
 	spin_lock_irqsave(&remote->remote_lock, flags);
 
-	count = kfifo_out(&remote->remote_fifo, &data, sizeof(data));
+	count = kfifo_out(&remote->remote_fifo, &remote_work_data,
+			  sizeof(remote_work_data));
 
-	if (count != sizeof(data)) {
+	if (count != sizeof(remote_work_data)) {
 		hid_err(wacom->hdev,
 			"workitem triggered without status available\n");
 		spin_unlock_irqrestore(&remote->remote_lock, flags);
@@ -2683,14 +2684,14 @@ static void wacom_remote_work(struct work_struct *work)
 	spin_unlock_irqrestore(&remote->remote_lock, flags);
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		serial = data.remote[i].serial;
-		if (serial) {
+		work_serial = remote_work_data.remote[i].serial;
+		if (work_serial) {
 
 			if (kt - remote->remotes[i].active_time > WACOM_REMOTE_BATTERY_TIMEOUT
 			    && remote->remotes[i].active_time != 0)
 				wacom_remote_destroy_battery(wacom, i);
 
-			if (remote->remotes[i].serial == serial) {
+			if (remote->remotes[i].serial == work_serial) {
 				wacom_remote_attach_battery(wacom, i);
 				continue;
 			}
@@ -2698,7 +2699,7 @@ static void wacom_remote_work(struct work_struct *work)
 			if (remote->remotes[i].serial)
 				wacom_remote_destroy_one(wacom, i);
 
-			wacom_remote_create_one(wacom, serial, i);
+			wacom_remote_create_one(wacom, work_serial, i);
 
 		} else if (remote->remotes[i].serial) {
 			wacom_remote_destroy_one(wacom, i);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c922c1c4c78f..471db78dbbf0 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1197,14 +1197,14 @@ static void wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	unsigned char *data = wacom_wac->data;
 	struct wacom_remote *remote = wacom->remote;
-	struct wacom_remote_data remote_data;
+	struct wacom_remote_work_data remote_data;
 	unsigned long flags;
 	int i, ret;
 
 	if (data[0] != WACOM_REPORT_DEVICE_LIST)
 		return;
 
-	memset(&remote_data, 0, sizeof(struct wacom_remote_data));
+	memset(&remote_data, 0, sizeof(struct wacom_remote_work_data));
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		int j = i * 6;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index a10b19669947..57e185f18d53 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -328,7 +328,7 @@ struct hid_data {
 	ktime_t time_delayed;
 };
 
-struct wacom_remote_data {
+struct wacom_remote_work_data {
 	struct {
 		u32 serial;
 	} remote[WACOM_MAX_REMOTES];
-- 
2.34.1

