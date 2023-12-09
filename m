Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5180B333
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjLIILH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjLIIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:10:58 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB7F1;
        Sat,  9 Dec 2023 00:11:04 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9efed2e6fso771622b6e.0;
        Sat, 09 Dec 2023 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702109464; x=1702714264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrk2lnfjeqDKI9HEdYdSbpPZmz7wWlvJV9mLFuHUtgI=;
        b=Tawg3oGtCSfcu61o1Bd5wTIEwmRxDztI97H/P0YN6Ykgf+yQo8tS17RKwdp3psrvzj
         BkG1+sX/lKkaLzdiZE4ejZd7Fj2IEbVFyeo3mgVTwJbpy9jyEWu1WORzDdGPpd0ZfmxV
         KdSKps1xBhj4F/WjCoBnuHMMvhRGnrQTwomt2zHR6FjhermFfaz3VGZPK55w4SYWzXrG
         IV+OSFJ1lo1YEeZRpSi5cjJYbvnH/le4V3+vyB5o1/oqTNMLoEn+npqLWNLjllxOviYS
         Lto4lY9RvE+E7HGVtoANFzf8zE3aFEhK3DiZ98uct3BcTZ7Nb/b8AOFpHgVSFdGOCeDv
         vmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702109464; x=1702714264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrk2lnfjeqDKI9HEdYdSbpPZmz7wWlvJV9mLFuHUtgI=;
        b=dTxBtM4V/Ze/ptYHjDku3mutUNnQf7sHbpk3nB6RAUVNj6Bus0YjFZjD2iFr72VNmB
         uNNJBl29WA2Zj2MRHetxE8zCT9NkWIM6ce7whuklEZ9PTDiW6MpbvjTerIbdNsRH7TKU
         C11W3v9pbf5KYjFVXHkoAUB7/1EdD5GqUVn20Xsm+EJ7JkMNmeuobZj5TUp74WN01VLV
         YS0NvtPnPgU4NJ6iYS6yDEM9z80nElGeIzIixxQFHk+kdj3DobG3uQbUY0cgDKXlswkw
         +fgUU3iKNcopImveSHBrU82rM901DIuN1TgTqE3c0b+AoTvxTl3T4je+QTvcS/hlKvnj
         XAdQ==
X-Gm-Message-State: AOJu0YyVLwXnSEciZGY8h3kjgGRoNDGQlFPtGS79scPVdzRcFpxiNfMZ
        MsfM6agtt977EoCSdje/XOyB+2UU+xWDXJ0J
X-Google-Smtp-Source: AGHT+IE/5byaXieDzfwj8AJ8O8aUHnLOZjHuaYVRXZRwtLR1S0cTByy6rcG68SQBXSmGoBKOSrXb6g==
X-Received: by 2002:a05:6808:2020:b0:3b8:b063:824a with SMTP id q32-20020a056808202000b003b8b063824amr1811581oiw.76.1702109463908;
        Sat, 09 Dec 2023 00:11:03 -0800 (PST)
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:a2b1:6894:2815:4471:20ab])
        by smtp.googlemail.com with ESMTPSA id t2-20020a62d142000000b00690c0cf97c9sm2873633pfl.73.2023.12.09.00.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 00:11:03 -0800 (PST)
From:   Vimal Kumar <vimal.kumar32@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
        mintupatel89@gmail.com, Vimal Kumar <vimal.kumar32@gmail.com>
Subject: [PATCH] PM / sleep: Mechanism to find source aborting kernel suspend transition
Date:   Sat,  9 Dec 2023 13:40:54 +0530
Message-Id: <20231209081056.1497-1-vimal.kumar32@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes kernel suspend transitions can be aborted unconditionally by
manipulating pm_abort_suspend value using "hard" wakeup triggers or
through "pm_system_wakeup()".

There is no way to trace the source path of module or subsystem which
aborted the suspend transitions. This change will create a list of
wakeup sources aborting suspend in progress through "hard" events as
well as subsytems aborting suspend using "pm_system_wakeup()".

Example: Existing suspend failure logs:
[  349.708359] PM: Some devices failed to suspend, or early wake event detected
[  350.327842] PM: suspend exit

Suspend failure logs with this change:
[  518.761835] PM: Some devices failed to suspend, or early wake event detected
[  519.486939] Abort: ws or subsystem uart_suspend_port aborted suspend
[  519.500594] PM: suspend exit

Here we can clearly identify the module triggerring abort suspend.

Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
---
 drivers/base/power/wakeup.c | 75 ++++++++++++++++++++++++++++++++++++-
 include/linux/suspend.h     |  2 +
 kernel/power/suspend.c      |  1 +
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a917219feea6..f640034cab6d 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -73,6 +73,13 @@ static struct wakeup_source deleted_ws = {
 
 static DEFINE_IDA(wakeup_ida);
 
+struct pm_abort_suspend_source {
+	struct list_head list;     //linux kernel list implementation
+	char *source_triggering_abort_suspend;
+};
+
+LIST_HEAD(pm_abort_suspend_list);
+
 /**
  * wakeup_source_create - Create a struct wakeup_source object.
  * @name: Name of the new wakeup source.
@@ -575,6 +582,53 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 	trace_wakeup_source_activate(ws->name, cec);
 }
 
+/**
+ * clear_abort_suspend_list: To clear the list containing sources which
+ * aborted suspend transitions.
+ * Functionality: The list will be cleared every time system PM exits as we
+ * can find sources which aborted suspend in the current suspend transisions.
+ */
+void clear_abort_suspend_list(void)
+{
+	struct pm_abort_suspend_source *info, *tmp;
+
+	if (!list_empty(&pm_abort_suspend_list))
+		list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
+			list_del(&info->list);
+			kfree(info);
+		}
+}
+EXPORT_SYMBOL_GPL(clear_abort_suspend_list);
+
+/**
+ * pm_add_abort_suspend_source: add sources who aborted system suspend transitions.
+ * @func_name: Name of the WS or subsystem which needs to added in the list
+ */
+void pm_add_abort_suspend_source(const char *source_name)
+{
+	struct pm_abort_suspend_source *info = NULL;
+
+	info = kmalloc(sizeof(struct pm_abort_suspend_source), GFP_KERNEL);
+	if (unlikely(!info)) {
+		pr_err("Failed to alloc memory for pm_abort_suspend_source info\n");
+		return;
+	}
+
+	/* Initialize the list within the struct if it's not already initialized */
+	if (list_empty(&info->list))
+		INIT_LIST_HEAD(&info->list);
+
+	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
+	if (unlikely(!info->source_triggering_abort_suspend)) {
+		pr_err("Failed to get abort_suspend source_name\n");
+		kfree(info);
+		return;
+	}
+
+	list_add_tail(&info->list, &pm_abort_suspend_list);
+}
+EXPORT_SYMBOL_GPL(pm_add_abort_suspend_source);
+
 /**
  * wakeup_source_report_event - Report wakeup event using the given source.
  * @ws: Wakeup source to report the event for.
@@ -590,8 +644,11 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
 	if (!ws->active)
 		wakeup_source_activate(ws);
 
-	if (hard)
+	if (hard) {
+		if (pm_suspend_target_state != PM_SUSPEND_ON)
+			pm_add_abort_suspend_source(ws->name);
 		pm_system_wakeup();
+	}
 }
 
 /**
@@ -893,12 +950,28 @@ bool pm_wakeup_pending(void)
 		pm_print_active_wakeup_sources();
 	}
 
+	if (atomic_read(&pm_abort_suspend) > 0) {
+		if (!list_empty(&pm_abort_suspend_list))
+			list_for_each_entry(info, &pm_abort_suspend_list, list) {
+				log_suspend_abort_reason("ws or subsystem %s aborted suspend\n",
+						info->source_triggering_abort_suspend);
+			}
+	}
+
 	return ret || atomic_read(&pm_abort_suspend) > 0;
 }
 EXPORT_SYMBOL_GPL(pm_wakeup_pending);
 
 void pm_system_wakeup(void)
 {
+	char buf[MAX_SUSPEND_ABORT_LEN];
+
+	if (pm_suspend_target_state != PM_SUSPEND_ON) {
+		sprintf(buf, "%ps", __builtin_return_address(0));
+		if (strcmp(buf, "pm_wakeup_ws_event"))
+			pm_add_abort_suspend_source(buf);
+	}
+
 	atomic_inc(&pm_abort_suspend);
 	s2idle_wake();
 }
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index ef503088942d..803071f664e7 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -528,6 +528,7 @@ extern void pm_print_active_wakeup_sources(void);
 
 extern unsigned int lock_system_sleep(void);
 extern void unlock_system_sleep(unsigned int);
+extern void clear_abort_suspend_list(void);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -556,6 +557,7 @@ static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
 
 static inline unsigned int lock_system_sleep(void) { return 0; }
 static inline void unlock_system_sleep(unsigned int flags) {}
+static inline void clear_abort_suspend_list(void) {}
 
 #endif /* !CONFIG_PM_SLEEP */
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..64a99f26bd51 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -623,6 +623,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	clear_abort_suspend_list();
 	pr_info("suspend exit\n");
 	return error;
 }
-- 
2.25.1

