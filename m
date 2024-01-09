Return-Path: <linux-kernel+bounces-20874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3598286C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257701F26972
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81739AC6;
	Tue,  9 Jan 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBaFsXQ1"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBDE39AC4;
	Tue,  9 Jan 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6daf694b439so1206152b3a.1;
        Tue, 09 Jan 2024 05:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704805342; x=1705410142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuhhFni1DxuWgTEN59N+8hvE6Ffbfp/ZD5QN7H1ltAM=;
        b=hBaFsXQ1Dq2KRztdz/Zbts7oGcUMaG257NR4inovfKiE7YBoQCfLYtl66rxvHvOQpK
         NVR+DZcOi6oBhiAA3X8LjXM2CVRDWvJakPA3xwO4QdDHaQUVYihjUJWGmbQKU6NzuKIb
         9zS+TxynQiYdLBi7jiC+KJEfjoN+mowCdDJzw5dIOskyUdkDlm7SwXWpbZhldbdgP1C4
         6I4Y7bWmdWQZSmtKjL2FmH8gQuGf+CeiN1Bdu1D/dqUEddsQpeQldEPSHIq0vr1HLLHU
         o9R1ahu6JVqIahazWcLbt9Uu9KHI94qYBPEymUZB5XHS40epr9T8XYRhd+qYt5SS7enI
         IBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704805342; x=1705410142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuhhFni1DxuWgTEN59N+8hvE6Ffbfp/ZD5QN7H1ltAM=;
        b=JcuGp7eNWKS8HUARzXTb/Asbbl9DqjDInOGkx4CtVWzRo74htRl/Kgqm1fPhi1tuyn
         ABnoatoXE5d5Z/3Y5msYdMp9SvrX1maKRkRCpJTuHG4HXg1CAx45xOcxTurZja2dfTuI
         41ZA4Q5GlrCnRjQeICfyEmy/CdcY9QSV4MpeVX8G7E27B92YvxcYDaarW9UyXg7abSGl
         ZOzvl+usBQGMlhzBCfgYLwBvnLNve7qpyL/kYbRRFd2bOrqQNamryBC23jQCMz9H2zI5
         gfxdoE2QacriSDiiOltP6DyEqocQ3MqEpwu6y+PyfpnM6MEvCLnB3mKAG1YexYd5yq1J
         Jnww==
X-Gm-Message-State: AOJu0Yy59CnvpATtuXe56qbjgD2bUvFZuRsU73+ObQMyz9TyIVe0gvIj
	gJyDoh/59XKqDZOWRsx7iBE=
X-Google-Smtp-Source: AGHT+IEYYvv/yUF1MvPreOt8O2b9r9hwW+2EgARiOJ/Hwr+CcMP7Ndp1rDFcYIRf3P4EOfEQa7gX3w==
X-Received: by 2002:a17:90a:bf82:b0:28d:2204:c8aa with SMTP id d2-20020a17090abf8200b0028d2204c8aamr2186875pjs.63.1704805341631;
        Tue, 09 Jan 2024 05:02:21 -0800 (PST)
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:8f51:14b0:2941:6232:8d18])
        by smtp.googlemail.com with ESMTPSA id z61-20020a17090a6d4300b0028d08a472a0sm2068928pjj.57.2024.01.09.05.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:02:21 -0800 (PST)
From: Vimal Kumar <vimal.kumar32@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chinmoyghosh2001@gmail.com,
	badolevishal1116@gmail.com,
	mintupatel89@gmail.com,
	Vimal Kumar <vimal.kumar32@gmail.com>
Subject: [PATCH v3] PM / sleep: Mechanism to find source aborting kernel suspend transition
Date: Tue,  9 Jan 2024 18:32:08 +0530
Message-Id: <20240109130210.31938-1-vimal.kumar32@gmail.com>
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
Changes in v3:
 - Moved changes under PM_DEBUG config
 - Removed def for buffer size
 - Modified static buffer to dynamic allocation
 - Use mutex_lock instead of raw_spin_lock_irqsave
 - Clear the buffer after printing
---
 drivers/base/power/wakeup.c | 98 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a917219feea6..9bb32c21cfd1 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -73,6 +73,16 @@ static struct wakeup_source deleted_ws = {
 
 static DEFINE_IDA(wakeup_ida);
 
+#ifdef CONFIG_PM_DEBUG
+static DEFINE_MUTEX(pm_abort_suspend_list_lock);
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
@@ -575,6 +585,52 @@ static void wakeup_source_activate(struct wakeup_source *ws)
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
+	struct pm_abort_suspend_source *info, *tmp;
+
+	mutex_lock(&pm_abort_suspend_list_lock);
+	list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
+		list_del(&info->list);
+		kfree(info);
+	}
+	mutex_unlock(&pm_abort_suspend_list_lock);
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
+	struct pm_abort_suspend_source *info;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return;
+
+	INIT_LIST_HEAD(&info->list);
+	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
+	if (!info->source_triggering_abort_suspend) {
+		kfree(info);
+		return;
+	}
+
+	mutex_lock(&pm_abort_suspend_list_lock);
+	list_add_tail(&info->list, &pm_abort_suspend_list);
+	mutex_unlock(&pm_abort_suspend_list_lock);
+}
+#endif
+
 /**
  * wakeup_source_report_event - Report wakeup event using the given source.
  * @ws: Wakeup source to report the event for.
@@ -590,8 +646,13 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
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
@@ -893,12 +954,47 @@ bool pm_wakeup_pending(void)
 		pm_print_active_wakeup_sources();
 	}
 
+#ifdef CONFIG_PM_DEBUG
+	if (atomic_read(&pm_abort_suspend) > 0) {
+		struct pm_abort_suspend_source *info;
+
+		mutex_lock(&pm_abort_suspend_list_lock);
+		list_for_each_entry(info, &pm_abort_suspend_list, list) {
+			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
+					info->source_triggering_abort_suspend);
+		}
+		mutex_unlock(&pm_abort_suspend_list_lock);
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
+		char *source_name = kasprintf(GFP_KERNEL,
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


