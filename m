Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EDF80BA0C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjLJKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjLJKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:03:07 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEF2E8;
        Sun, 10 Dec 2023 02:03:13 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ceba6c4b8dso2551317b3a.1;
        Sun, 10 Dec 2023 02:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702202593; x=1702807393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4NI28Unlug9c9lwE9sYY51sR0DoqR0JcRwCsMRj+TI=;
        b=dI6fqJvku0d4N546nCX+vu2G2TXFIlpyWzMMVkXiggq+NXXJhd9uD39DSr7kwxc29v
         8AI192bhBHM9A3CNdc9a4m5tM9F7flXqxd28Ck2iAXnVNAygCTv9G7M/SVARTVhUeMGD
         zHwxDWnxiaXVIm4Vc5dJPv134o/Hxjd0nJW9yu6N5e9HQ+sW9N3qMI9AOfK9q4j0XY6l
         fE1pYUg/Vbfkq1MiU6xKoCwLTj+yqNsilkPZL51LqruY1woU/ATgIztqWm/JXGHKslNL
         cgZf4rvIqYbHEYHAGHCdKW1uNyv5m+XCZ1BL/RO98Yw8yyVnTBMRvkxXpy7ofUflCoam
         +RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702202593; x=1702807393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4NI28Unlug9c9lwE9sYY51sR0DoqR0JcRwCsMRj+TI=;
        b=bEFN7jlAoWA0PkDNoZ+zkT7QwWrzrDiCdgsDxMmOA3GYkd7UxayJW5mQk1yy5pKOa2
         pydcMLb8DHjL67AV9oKwfP+j7TjDRp69PNbedvBlSL/TFzQnx301UusCcyHWNiLxkroA
         /H56xQUl4jHCycDGv24AFqLUbKgLWSDRAjoNpzZtOhlrAh2LXooJe6qFAF1umMw546PM
         5bHwus3lbXQXOPzIBImCsL5+V6SXTeGK32H4p+Tq4hR33q1dy0nZvl8FuwjrCPUXKz/z
         mHWiHMdUJ6VM7w76j+BSpI7qA2Vd0CniBsJ6KVWRvErUH/BHgmqMThzfmxiNKLWT2L7X
         dgNw==
X-Gm-Message-State: AOJu0Yw1STP/3jZJp/eg2wkI5HNkekp6cT4GlXj5c76x5eNprGjy9m8f
        gH+nLYLU8t9ylvd3LX+j3Pg=
X-Google-Smtp-Source: AGHT+IFoc3tfod4XdnOoBampFfnAVHyJX6VburBvuHDpqccncyBrNoWIb0t76yJ9aWMP2Um2AwexYg==
X-Received: by 2002:a05:6a00:21c1:b0:6ce:56da:62d3 with SMTP id t1-20020a056a0021c100b006ce56da62d3mr2804371pfj.25.1702202593327;
        Sun, 10 Dec 2023 02:03:13 -0800 (PST)
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:8c2:65fd:8c8e:798a:8b3c])
        by smtp.googlemail.com with ESMTPSA id x34-20020a056a0018a200b006ce3a48b6a2sm4364118pfh.160.2023.12.10.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 02:03:12 -0800 (PST)
From:   Vimal Kumar <vimal.kumar32@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
        mintupatel89@gmail.com, Vimal Kumar <vimal.kumar32@gmail.com>
Subject: [PATCH v2] PM / sleep: Mechanism to find source aborting kernel suspend transition
Date:   Sun, 10 Dec 2023 15:33:01 +0530
Message-Id: <20231210100303.491-1-vimal.kumar32@gmail.com>
X-Mailer: git-send-email 2.25.1
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
[  519.486939] PM: wakeup source or subsystem uart_suspend_port aborted suspend
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
 Changes in v2:
 - Make pm_abort_suspend_list static.
 - Added locks.
 - Removed list_empty check as not needed.
 - Fix Doc format.
 - Fix function name as per global functions.
 - Removed use of unlikely/likely.
 - Removed extra logging for kmalloc failure.
 - Use *info instead of struct name.
---
 drivers/base/power/wakeup.c | 82 ++++++++++++++++++++++++++++++++++++-
 include/linux/suspend.h     |  2 +
 kernel/power/suspend.c      |  1 +
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a917219feea6..fa1e3369b0f6 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -73,6 +73,15 @@ static struct wakeup_source deleted_ws = {
 
 static DEFINE_IDA(wakeup_ida);
 
+#define MAX_SUSPEND_ABORT_LEN 256
+static DEFINE_RAW_SPINLOCK(abort_suspend_lock);
+
+struct pm_abort_suspend_source {
+	struct list_head list;
+	char *source_triggering_abort_suspend;
+};
+static LIST_HEAD(pm_abort_suspend_list);
+
 /**
  * wakeup_source_create - Create a struct wakeup_source object.
  * @name: Name of the new wakeup source.
@@ -575,6 +584,56 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 	trace_wakeup_source_activate(ws->name, cec);
 }
 
+/**
+ * abort_suspend_list_clear - Clear pm_abort_suspend_list.
+ *
+ * The pm_abort_suspend_list will be cleared when system PM exits.
+ */
+void abort_suspend_list_clear(void)
+{
+	struct pm_abort_suspend_source *info, *tmp;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&abort_suspend_lock, flags);
+	list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
+		list_del(&info->list);
+		kfree(info);
+	}
+	raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
+}
+EXPORT_SYMBOL_GPL(abort_suspend_list_clear);
+
+/**
+ * pm_abort_suspend_source_add - Update pm_abort_suspend_list
+ * @source_name: Wakeup_source or function aborting suspend transitions.
+ *
+ * Add the source name responsible for updating the abort_suspend flag in the
+ * pm_abort_suspend_list.
+ */
+static void pm_abort_suspend_source_add(const char *source_name)
+{
+	struct pm_abort_suspend_source *info;
+	unsigned long flags;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return;
+
+	/* Initialize the list within the struct if it's not already initialized */
+	if (list_empty(&info->list))
+		INIT_LIST_HEAD(&info->list);
+
+	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
+	if (!info->source_triggering_abort_suspend) {
+		kfree(info);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&abort_suspend_lock, flags);
+	list_add_tail(&info->list, &pm_abort_suspend_list);
+	raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
+}
+
 /**
  * wakeup_source_report_event - Report wakeup event using the given source.
  * @ws: Wakeup source to report the event for.
@@ -590,8 +649,11 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
 	if (!ws->active)
 		wakeup_source_activate(ws);
 
-	if (hard)
+	if (hard) {
+		if (pm_suspend_target_state != PM_SUSPEND_ON)
+			pm_abort_suspend_source_add(ws->name);
 		pm_system_wakeup();
+	}
 }
 
 /**
@@ -877,6 +939,7 @@ bool pm_wakeup_pending(void)
 {
 	unsigned long flags;
 	bool ret = false;
+	struct pm_abort_suspend_source *info;
 
 	raw_spin_lock_irqsave(&events_lock, flags);
 	if (events_check_enabled) {
@@ -893,12 +956,29 @@ bool pm_wakeup_pending(void)
 		pm_print_active_wakeup_sources();
 	}
 
+	if (atomic_read(&pm_abort_suspend) > 0) {
+		raw_spin_lock_irqsave(&abort_suspend_lock, flags);
+		list_for_each_entry(info, &pm_abort_suspend_list, list) {
+			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
+					info->source_triggering_abort_suspend);
+		}
+		raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
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
+			pm_abort_suspend_source_add(buf);
+	}
+
 	atomic_inc(&pm_abort_suspend);
 	s2idle_wake();
 }
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index ef503088942d..2eef5817b825 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -528,6 +528,7 @@ extern void pm_print_active_wakeup_sources(void);
 
 extern unsigned int lock_system_sleep(void);
 extern void unlock_system_sleep(unsigned int);
+extern void abort_suspend_list_clear(void);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -556,6 +557,7 @@ static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
 
 static inline unsigned int lock_system_sleep(void) { return 0; }
 static inline void unlock_system_sleep(unsigned int flags) {}
+static inline void abort_suspend_list_clear(void) {}
 
 #endif /* !CONFIG_PM_SLEEP */
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..49c830246930 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -623,6 +623,7 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+	abort_suspend_list_clear();
 	pr_info("suspend exit\n");
 	return error;
 }
-- 
2.25.1

