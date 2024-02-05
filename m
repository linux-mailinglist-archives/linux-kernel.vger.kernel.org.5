Return-Path: <linux-kernel+bounces-53063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C983984A035
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDDC1C21A55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB43FE54;
	Mon,  5 Feb 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV11RjE3"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F03FB37;
	Mon,  5 Feb 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152901; cv=none; b=hYX+aeqonosNQV9MzVpVdY/rBNXfiDtrhXuq4TJCN7PQKIx1jVtNtD4aaRGSPYaC3GUrI886wsOZjLEX1PM8xcrX63OHDRdGZEpU4aFl9cgdjm+fCEyPro9oVE/PYy8UxX5h8Yt2pJIbUI3iXCEoQwItaHWjLxT24qyN3d823o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152901; c=relaxed/simple;
	bh=reCj+r4VxIU6Y+cGYb9l8G/P6+gruLC060SkULyMf0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p610WiOStJG/BQPRCRqildPngpxkL2oU+zI8y95J7dRsVoD4/dhjlkJTpR3oUHU0S1KmvXHLrkIi9irgHbDyAuiSNUdPvBwQ0TG/L2sgVje9cBe+5dBoeX/akAIilPPYWSoYxHVwmOzp+45aWWXOYzIC+RVAKRraIwTj9zgU0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV11RjE3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so3133236a91.1;
        Mon, 05 Feb 2024 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707152899; x=1707757699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgMORd5WuhV/bci5sht7N7PthwPEl3wM3uOQ63QyyAM=;
        b=XV11RjE3y4eJMooxHHZZKpo/ftPLKk21EMTwu7Y+ohPi9nEt2U4SjM6U8HWvpP8JaI
         6FyQegfgkIH53zYAMK1fB/u+Q4vM9pqItbVHM9me/RHWR45EaUeiLoaT9tTKEM/R9FYQ
         rFUCWrN9ExZGYvY3vCAPkw4vmQtOMCDtCNWIrFhRDpqT8SAFq/L4xjbq7JIrctEvqBI/
         xqZ85ZK5MJrd9JbsO1AQajbix3rtHK6/YSECa7agaodM09sTM81zY3MjBF3SWMSkrRX8
         SBz80RPIryCHL/okwxYz8mvi3isIUV73UhWqg8A9ZDYp52ZADE1pu3oa9Ct4hmy1hF6m
         x7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152899; x=1707757699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgMORd5WuhV/bci5sht7N7PthwPEl3wM3uOQ63QyyAM=;
        b=xHvo/7V5sgimMFJaAtcIDV4HQ7pYcM+/dYtIIljDsTMqePm8dfKfChb4QtpSdBACYY
         rcoRjb8r/ILozix/t68VvhzSG0mBhz8K5sicPPZu3w4Iz5oaRBw/gaTXRo0554/DneoL
         8nLXvw0EeF9phZvqft0cJ+aPbivslY2rlMkbGJwQfF269Il+HiPYkIO735YeDoSPUHqj
         cyU0kv8MgV33IY5Hjm7k3hNa7fgCs19Li8qLGC9qQl1/yKO0jRR2ALmEtxzd5qS7rUEf
         7fZb97nTJCTgchkHSQBocRFHlSUwRF6JwN/RtxuGk76YEKjV8n2PT+5ALPidZ385kGJf
         up9w==
X-Gm-Message-State: AOJu0YxVMMhITdTaWyrXzsw7to4Y1CKnzSzTxeNviAeAT9D7d08mpF2l
	ppeLCXTUXZ7DcVi+gpRsPkpV3T4Dm4AWIFvNpQaFagQBqBjsmv/x
X-Google-Smtp-Source: AGHT+IEN8VwL5mUjtDptE3O+Q/E3w/eaXXOjhoayZExDIwTCa+t1EV/XRm5igfn3dGmCszytvJ8NiA==
X-Received: by 2002:a17:90a:d484:b0:296:1ddc:d46a with SMTP id s4-20020a17090ad48400b002961ddcd46amr7862pju.39.1707152898830;
        Mon, 05 Feb 2024 09:08:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUuPIQXEj6bW9heF/JBeXugHU6pLE90dQ73ui0SQmNvk0hrfegwKN57evn5rmEP/FiWO6SI2lfM14uaV9Vwz8M/+hLdc2ZKzam6rzBN/D/Eala2DW2U3vwdUMcUBwPOqRkX5vBPZ8JCGWW1LxlV8TbGL9oeKB399WKF6EeXE+08PGU2c2SQq9s3aw/GroA1Jhrs30z/dT+stcsV01qQ/xpAEE66ar+EPxiiQSTvtpTLe5C0y10yd6+F145uFq/8Tklfz0Kssmd9m+skOUVw03GU4Cyr8ROf1eUhv/W4oCu8Tc27GywMxpHemckP6+JsPmC3AQ==
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:bcee:c97d:bee2:a20a:e6d3])
        by smtp.googlemail.com with ESMTPSA id nr3-20020a17090b240300b002927a36b7a0sm222882pjb.23.2024.02.05.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:08:18 -0800 (PST)
From: Vimal Kumar <vimal.kumar32@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chinmoyghosh2001@gmail.com,
	badolevishal1116@gmail.com,
	mintupatel89@gmail.com,
	Vimal Kumar <vimal.kumar32@gmail.com>
Subject: [PATCH v4] PM / sleep: Mechanism to find source aborting kernel suspend transition
Date: Mon,  5 Feb 2024 22:37:45 +0530
Message-Id: <20240205170747.19748-1-vimal.kumar32@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Changes in v4:
- Changed GFP_KERNEL flag to GFP_ATOMIC
- Changed mutex_lock to raw_spin_lock
---
 drivers/base/power/wakeup.c | 100 +++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a917219feea6..b04794557eef 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -73,6 +73,16 @@ static struct wakeup_source deleted_ws = {

 static DEFINE_IDA(wakeup_ida);

+#ifdef CONFIG_PM_DEBUG
+static DEFINE_RAW_SPINLOCK(pm_abort_suspend_list_lock);
+
+struct pm_abort_suspend_source {
+	struct list_head list;
+	char *source_triggering_abort_suspend;
+};
+static LIST_HEAD(pm_abort_suspend_list);
+#endif
+
 /**
  * wakeup_source_create - Create a struct wakeup_source object.
  * @name: Name of the new wakeup source.
@@ -575,6 +585,54 @@ static void wakeup_source_activate(struct wakeup_source *ws)
	trace_wakeup_source_activate(ws->name, cec);
 }

+#ifdef CONFIG_PM_DEBUG
+/**
+ * pm_abort_suspend_list_clear - Clear pm_abort_suspend_list.
+ *
+ * The pm_abort_suspend_list will be cleared when system PM exits.
+ */
+static void pm_abort_suspend_list_clear(void)
+{
+	unsigned long flags;
+	struct pm_abort_suspend_source *info, *tmp;
+
+	raw_spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
+	list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
+		list_del(&info->list);
+		kfree(info);
+	}
+	raw_spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
+}
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
+	unsigned long flags;
+	struct pm_abort_suspend_source *info;
+
+	info = kmalloc(sizeof(*info), GFP_ATOMIC);
+	if (!info)
+		return;
+
+	INIT_LIST_HEAD(&info->list);
+	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_ATOMIC);
+	if (!info->source_triggering_abort_suspend) {
+		kfree(info);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
+	list_add_tail(&info->list, &pm_abort_suspend_list);
+	raw_spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
+}
+#endif
+
 /**
  * wakeup_source_report_event - Report wakeup event using the given source.
  * @ws: Wakeup source to report the event for.
@@ -590,8 +648,13 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
	if (!ws->active)
		wakeup_source_activate(ws);

-	if (hard)
+	if (hard) {
+#ifdef CONFIG_PM_DEBUG
+		if (pm_suspend_target_state != PM_SUSPEND_ON)
+			pm_abort_suspend_source_add(ws->name);
+#endif
		pm_system_wakeup();
+	}
 }

 /**
@@ -893,12 +956,47 @@ bool pm_wakeup_pending(void)
		pm_print_active_wakeup_sources();
	}

+#ifdef CONFIG_PM_DEBUG
+	if (atomic_read(&pm_abort_suspend) > 0) {
+		struct pm_abort_suspend_source *info;
+
+		raw_spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
+		list_for_each_entry(info, &pm_abort_suspend_list, list) {
+			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
+					info->source_triggering_abort_suspend);
+		}
+		raw_spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
+		pm_abort_suspend_list_clear();
+	}
+#endif
+
	return ret || atomic_read(&pm_abort_suspend) > 0;
 }
 EXPORT_SYMBOL_GPL(pm_wakeup_pending);

 void pm_system_wakeup(void)
 {
+
+#ifdef CONFIG_PM_DEBUG
+#ifdef CONFIG_DEBUG_INFO
+	if (pm_suspend_target_state != PM_SUSPEND_ON) {
+		char *source_name = kasprintf(GFP_ATOMIC,
+					"%ps",
+					__builtin_return_address(0));
+		if (!source_name)
+			goto exit;
+
+		if (strcmp(source_name, "pm_wakeup_ws_event"))
+			pm_abort_suspend_source_add(source_name);
+
+		kfree(source_name);
+	}
+exit:
+#else
+	if (pm_suspend_target_state != PM_SUSPEND_ON)
+		pm_pr_dbg("Some wakeup source or subsystem aborted suspend\n");
+#endif
+#endif
	atomic_inc(&pm_abort_suspend);
	s2idle_wake();
 }
--
2.25.1

