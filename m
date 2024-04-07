Return-Path: <linux-kernel+bounces-134376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F53B89B0D4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4070B1F21721
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D442BB0B;
	Sun,  7 Apr 2024 12:39:21 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5E2BAFD;
	Sun,  7 Apr 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493561; cv=none; b=VK1SVdIUG4QO0E4e/rfpaiWi91mCSaO18hnrqHN0BCqPsugRo748Pyf1/xqw/3/yf68OZ2SsVGrkm6btZjNPZVG2MXrC/h0W8JEjzfd0hntFxP3+rbjvYgP0D9Bw5ZivpIPrD1E9pErb8wzjrdG0OJkXFoyRHPn0kgVOtFlJx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493561; c=relaxed/simple;
	bh=J1H/qX8SRFDlHJ/QBkm7cFTa1sYh0vN4k5jahtXiAaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUQGVzu/ZwFNkvDqQ/iwJpy9vd3ORzaA8LgeUeVS4EkprUFwv+JKmSY6ghpX68m8mI7BdMSnmSk6/ugU+xyN/uWIWmLdpHkoLyWiwWWTFmn043vW/eHe7rQ7LSySCipA+eoTudEUbeylnWmhiOaeZs6IftuSpAHkKJvNOhPS5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2be2361efso6417585ad.0;
        Sun, 07 Apr 2024 05:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712493557; x=1713098357;
        h=content-transfer-encoding:mime-version:list-id:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gH1KKOCelF2ThGU1cHU4FIyi0LwXgGcMVoj+JXuvN68=;
        b=vg5GThUmBhLZLqR7YeFet6S30bYvAc28z8jKXY7XPcqSg6gNSYnp4u/3qLl5dxHEJR
         IwxIShFsQtbtUrAfGibJMyvwkENO7V+0AFQLx9DDY34PWZnplD1QHJSl5v6gncNrNhGu
         jwIF7px5xObWGtg1lOv+TP60jMQWFSq8pXy5VIec1n5McacCNqGuISWplOffjSO2h3A1
         xSr2NZBR5esF3sWhjXy2SwCFYnvYN+AALlu3S184fHN+yi8iglA9jaFLDgVG7l+oMuO7
         grS1OwU1HkDAzvsj3jk0k4GDLbxVztZ6D2F6j4Kxet9ZImZPi9/pCAKIVyaeyOJt4tzk
         exzg==
X-Forwarded-Encrypted: i=1; AJvYcCUJLW3Q4knEX5vy21AgGdd++yeBcbM7ii9wYTGIIxO3erWzoqiay54FyyXH6suuI0aBX1sn1vnofb8lR41nzuO19KxWhvf3se4x4N4d1jmuzVu7nYjyQcUI+zqqLE/nQcNkDYC9OO5pw06i+R631APetr+PaEDU2UwTqsdjg1QnikLwFyayeX8lA1kmrYEj4+tO9wcNWDuEJZ3kYn4TUBU6Kni6HW9Zl80aKEdDTJTqkAwkGsrarm7Qzd91hU+gJ/FLD24=
X-Gm-Message-State: AOJu0YxGLrNZMT3iBbQLyo9o7VeA0haQSuCGSaImLBrF/d9HPuQ/uiVV
	nOdpTWLQIDANd3wHQGPaRGseXfagr0ouDpBxXNMgIcVcKx0+m6uZ
X-Google-Smtp-Source: AGHT+IHyvAb+guuz0e00AaSmzIzllRxt4szwRJ66ajt1UGZg+b5metBcaJu7z1HTr0mFKQWF0c3bmQ==
X-Received: by 2002:a17:902:e5c1:b0:1dd:b883:3398 with SMTP id u1-20020a170902e5c100b001ddb8833398mr7436090plf.4.1712493557482;
        Sun, 07 Apr 2024 05:39:17 -0700 (PDT)
Received: from tgsp-ThinkPad-X280.. ([223.153.78.230])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001e27c7ecd24sm4828518plw.283.2024.04.07.05.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 05:39:17 -0700 (PDT)
From: xiongxin <xiongxin@kylinos.cn>
To: xiongxin@kylinos.cn,
	Rafael Wysocki <rafael@kernel.org>,
	hdegoede@redhat.com,
	linus.walleij@linaro.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com
Subject: [PATCH v4 1/4] include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume
Date: Sun,  7 Apr 2024 20:39:03 +0800
Message-Id: <20230602073025.22884-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602073025.22884-1-mario.limonciello@amd.com>
References: <20230602073025.22884-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

All uses in the kernel are currently already oriented around
suspend/resume. As some other parts of the kernel may also use these
messages in functions that could also be used outside of
suspend/resume, only enable in suspend/resume path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * add back do/while as it wasn't pointless.  It fixes a warning.
---
 include/linux/suspend.h | 8 +++++---
 kernel/power/main.c     | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 1a0426e6761c..74f406c53ac0 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -555,6 +555,7 @@ static inline void unlock_system_sleep(unsigned int flags) {}
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
 extern bool pm_debug_messages_on;
+extern bool pm_debug_messages_should_print(void);
 static inline int pm_dyn_debug_messages_on(void)
 {
 #ifdef CONFIG_DYNAMIC_DEBUG
@@ -568,14 +569,14 @@ static inline int pm_dyn_debug_messages_on(void)
 #endif
 #define __pm_pr_dbg(fmt, ...)					\
 	do {							\
-		if (pm_debug_messages_on)			\
+		if (pm_debug_messages_should_print())		\
 			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 		else if (pm_dyn_debug_messages_on())		\
 			pr_debug(fmt, ##__VA_ARGS__);	\
 	} while (0)
 #define __pm_deferred_pr_dbg(fmt, ...)				\
 	do {							\
-		if (pm_debug_messages_on)			\
+		if (pm_debug_messages_should_print())		\
 			printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 	} while (0)
 #else
@@ -593,7 +594,8 @@ static inline int pm_dyn_debug_messages_on(void)
 /**
  * pm_pr_dbg - print pm sleep debug messages
  *
- * If pm_debug_messages_on is enabled, print message.
+ * If pm_debug_messages_on is enabled and the system is entering/leaving
+ *      suspend, print message.
  * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
  *	print message only from instances explicitly enabled on dynamic debug's
  *	control.
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3113ec2f1db4..daa535012e51 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -556,6 +556,12 @@ power_attr_ro(pm_wakeup_irq);
 
 bool pm_debug_messages_on __read_mostly;
 
+bool pm_debug_messages_should_print(void)
+{
+	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;

> hibernate processes also mostly use the pm_pr_dbg() function, which
> results in hibernate processes only being able to output such logs
> through dynamic debug, which is unfriendly to kernels without
> CONFIG_DYNAMIC_DEBUG configuration.

+}
+EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
+
 static ssize_t pm_debug_messages_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {

-- 
2.34.1

