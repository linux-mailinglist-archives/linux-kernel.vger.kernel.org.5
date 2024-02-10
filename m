Return-Path: <linux-kernel+bounces-60289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB2B8502B0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3CB1F25516
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF512E5F;
	Sat, 10 Feb 2024 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWmsuegi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4171079B;
	Sat, 10 Feb 2024 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707544377; cv=none; b=sEuO4Gd9D/IKvqpdCGU/ZM0M1EkPClNQnjnnTEkxKgf5hcPsYmSaYqYS3/sHTCzXNU+aSC/k1RaiII1yYnrg22X56znX6WZUTx2fbfo/V8cA9wKsZCH8Yu3TczjYFufQCIFZWNvj6iwNRvsTeo505cqW6As1Tc5aPaw7x/NDdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707544377; c=relaxed/simple;
	bh=tNVV5xAQa/Ns4f4eY3Gv+4I22bHyCVvAM5GTe2Ptw3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tjqGQv1Jro64RwZUAPFWh6+Oab3Sy4japQVFpvFfzKufdGy1Er2am9634xVfTENJ9F8tr2J+pMfbmtJ8rT2UWS1LgmsNlA3C/5QxCOIqjfUJXcsc1yfPFI/ALwsc9W3oE5PreRUQ7PFUMNz5XlhbHd0gjZTQwdMXijQK2f6RUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWmsuegi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d73066880eso14917605ad.3;
        Fri, 09 Feb 2024 21:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707544375; x=1708149175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVOtuarcn9KyJ3H+TrbVlWuC2CD/F+8dBTZNDoFsAgc=;
        b=hWmsuegiYXNhfztKthAdyhLr4j1YyHnc3N0vmZmMBnCBrEgDh2ocqhV2RTt3nFKMxW
         Ek6SzdeSjad1fcxl92AQNlYPMhvtMj4kEJDakgZxJ+qnK+2vzp2kIcMIPE8EJ8FjU8ax
         EtVeZUJslehW0Q92WLtgdhcVDR6WjBhobvDL0lYva4fgn+SDfNZsU9YpUxNgngMANUHW
         jWLvsiyTXMO7wQyDeIsCQoT+AcSyGzETb+nM89WgLAN/W4KbwuAt7SM/Z9Al4DiuqiPr
         QRZkl2TUYmdzhXlU/9wGRFDox6oitku5zP0rJo8vm4emT3w51VffHZTrcDfKQz+SI9fy
         SToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707544375; x=1708149175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVOtuarcn9KyJ3H+TrbVlWuC2CD/F+8dBTZNDoFsAgc=;
        b=RB8zbd4u65/qfq3QoFInHKLv/cn/homc7jI+cUqdbYGhF0P7Ssh9Tz0HEuGT76EKru
         AZXTVzqxSvwjEt27ooUUzUHlFVni4s7+t09jwJ+KEAv81CUs/2nkV6EaG0Ok8bMIWo+e
         dhndAFgxIak6A48kB9IFYyrCq56Xh9mZ9OQ8087Esxm4UpA5I9XLCJFbHEyqNH8ePJZr
         1nj+xYIas/6jWKlzXTHhQ3LBlR/NPVKs0DHOWn9In8Rq/FO8gEqLz/Q4EAkriKKXjeE1
         OXLsMk1m6tf7XxFmuCCUO59vWQ7qw8VSn4Sz8YXAx72EFkri77aO5BppQerCRvTYznwF
         0vJg==
X-Gm-Message-State: AOJu0Yzk7dsEDzdjWZrlqrbqVELa2suFBpJ2CUrdyHHmu28ogFAMsrgC
	XmSPznf8z9vIAnR7yubRzrPmxqCFXiGPX5d+uaFClbnayMVdksnC
X-Google-Smtp-Source: AGHT+IF6yohNKF0CwuZjooly/e4Yty8jgqVSTGrtRaieM/dwkr3YKNWCsM/JSAThMgecpz0cc05H9w==
X-Received: by 2002:a17:903:2b0e:b0:1d9:b0fc:6e52 with SMTP id mc14-20020a1709032b0e00b001d9b0fc6e52mr2266434plb.59.1707544374677;
        Fri, 09 Feb 2024 21:52:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8PlnR3hhu4+ClCL7iVFO5GDqAB0B4UrtvtpaTzUTvcSmybXl7/x1roIEw3ChOYI202SiO1zhuYakzvF8E5hs5YbN0v+WC7eiSymzXDBkakgoXaa9FrpP4WA9IM3Ij5kSz4HUSvcvRWM06c6lsXlBC7N5nU0XjkGo4j3O3sItZrh08IKB/lDlqwB5NJOB86t4NYSEWR3t9N/+uTdZj/2jZPnhr5VMKrXKgvrkJK1AVrFJS7ysG6VagaU2oC6gCnHDNpFQ/iA7EB3F1gbEXS3rmy+9XxYbN3HjAYDHpBFuJ4MujYJRLcjXsPr7bEERdjc4+mA==
Received: from DESKTOP-KA7F9LU.localdomain ([103.184.71.167])
        by smtp.googlemail.com with ESMTPSA id mi12-20020a170902fccc00b001d74502d261sm2370887plb.115.2024.02.09.21.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 21:52:54 -0800 (PST)
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
Subject: [PATCH v5] PM / sleep: Mechanism to find source aborting kernel suspend transition
Date: Sat, 10 Feb 2024 11:22:41 +0530
Message-Id: <20240210055243.8508-1-vimal.kumar32@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Changes in v5:
- Removed CONFIG_PM_DEBUG
- Moved conditional directives to .h file
- Used spin_lock instead of raw_spin_lock
---
 drivers/base/power/power.h  | 14 ++++++
 drivers/base/power/wakeup.c | 86 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 922ed457db19..ace190358eb3 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -168,3 +168,17 @@ static inline void device_pm_init(struct device *dev)
	device_pm_sleep_init(dev);
	pm_runtime_init(dev);
 }
+
+#ifdef CONFIG_DEBUG_INFO
+
+static inline char *pm_abort_suspend_source_name(void)
+{
+	char *source_name = kasprintf(GFP_ATOMIC, "%pS", __builtin_return_address(0));
+	return source_name;
+}
+
+#else
+
+	static inline char *pm_abort_suspend_source_name(void) { return NULL; }
+
+#endif /* CONFIG_DEBUG_INFO */
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a917219feea6..aae9a5329bcb 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -73,6 +73,14 @@ static struct wakeup_source deleted_ws = {

 static DEFINE_IDA(wakeup_ida);

+static DEFINE_SPINLOCK(pm_abort_suspend_list_lock);
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
@@ -575,6 +583,52 @@ static void wakeup_source_activate(struct wakeup_source *ws)
	trace_wakeup_source_activate(ws->name, cec);
 }

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
+	spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
+	list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
+		list_del(&info->list);
+		kfree(info);
+	}
+	spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
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
+	spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
+	list_add_tail(&info->list, &pm_abort_suspend_list);
+	spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
+}
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
+			pm_abort_suspend_source_add(ws->name);
		pm_system_wakeup();
+	}
 }

 /**
@@ -893,12 +950,39 @@ bool pm_wakeup_pending(void)
		pm_print_active_wakeup_sources();
	}

+	if (atomic_read(&pm_abort_suspend) > 0) {
+		struct pm_abort_suspend_source *info;
+
+		spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
+		list_for_each_entry(info, &pm_abort_suspend_list, list) {
+			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
+					info->source_triggering_abort_suspend);
+		}
+		spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
+		pm_abort_suspend_list_clear();
+	}
+
	return ret || atomic_read(&pm_abort_suspend) > 0;
 }
 EXPORT_SYMBOL_GPL(pm_wakeup_pending);

 void pm_system_wakeup(void)
 {
+
+	if (pm_suspend_target_state != PM_SUSPEND_ON) {
+		char *source_name = pm_abort_suspend_source_name();
+
+		if (!source_name) {
+			pm_pr_dbg("Some wakeup source or subsystem aborted suspend\n");
+			goto exit;
+		}
+
+		if (strcmp(source_name, "pm_wakeup_ws_event"))
+			pm_abort_suspend_source_add(source_name);
+
+		kfree(source_name);
+	}
+exit:
	atomic_inc(&pm_abort_suspend);
	s2idle_wake();
 }
--
2.25.1

