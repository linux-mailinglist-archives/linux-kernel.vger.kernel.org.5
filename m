Return-Path: <linux-kernel+bounces-134387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D621889B0E6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7742A1F217B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B22C183;
	Sun,  7 Apr 2024 12:49:41 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03E4C7B;
	Sun,  7 Apr 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712494180; cv=none; b=j62qt1VXQr8n+q/2P672WyalYKb8OHc5M6JJVE3VIQN0fnpkkxg5QygW3IHIYdAe6N1gfudifoUfGO1zRuZfOq9gR1k4vf1x7zn24CxwuQcITblVdy4mloo85YC8BHTuZxqG37D4QllKhOEuUkH3xeOu+HIquVPO9xWLLHV89UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712494180; c=relaxed/simple;
	bh=J1H/qX8SRFDlHJ/QBkm7cFTa1sYh0vN4k5jahtXiAaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMFyPKfVQso35X0c1TW6cQ5hMTV5uh4gxvHeky3pMzYHSb0OC+ILfQIObatVlJkYYLrPuTuCFj9Pm9G2E4o1fI/JQDgMLEmVERLGMVoQU5veCSTQ/ftKk+9xHo/+hR3WrChcntwquCBh1cqguHbkqaS/u2z/4HWdBhYTri16+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecee443c79so411687b3a.0;
        Sun, 07 Apr 2024 05:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712494178; x=1713098978;
        h=content-transfer-encoding:mime-version:list-id:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gH1KKOCelF2ThGU1cHU4FIyi0LwXgGcMVoj+JXuvN68=;
        b=MIJA0Wot1Qghh8EQLxxyyfbLrBYRKDYh7aNXOqdQNmN+CJsqDCipBR5eWRnI5x70mA
         05ThpeHeLEPSk6/XVVESA2RV4GWzaoHMel2tjwzV5syjTsJ2BwN372/5wZGIiAqGKZNd
         KOEQj1kF0io5iNGktVOjZ2+3e4fvLsI0NL5ReralF9Z7Pu5I304/F0+Kf1uuuYCmZv5Q
         2ZlumbaNpx+/rMqHYmU6zX1KXstrozYLXpsNSXFrTdivtIvQAzfBxZKxd6W4Sp0ozlch
         0OfRM6kGgQTZGxvVUc2CRGBFTIw0ypRD99rhEY8QzyRjk7ammTF+7PhoJvKBH4+8tb3h
         Rjow==
X-Forwarded-Encrypted: i=1; AJvYcCVhM7fTIZhDD8Qshqy0I1Kc+w+bKR6q8OPoXVvUfiT80bnhn7cjloNKQKeVCO8z9UihmhScWZomyQ7t6oEtiBuNbbVInSnLvJGIejYjn1+1ZZ1AY36HRJCcflcMJDtd5ptl4mtZSwOMzD3GmTgCNhyb0VyR8VBUlZedclQ9Q+uEKfsSDBV4FcMLrlqNd2m52tHKeGXWm+1p4hZQ6xW5EGTpMODLCktTwfLZNAIl6jExjFoBha2wYg5K2vYFtiCVjCQKJ/M=
X-Gm-Message-State: AOJu0YzZ+GU6xzTsuqvNvmEw68gC55YnLvWajrm9EvkASsqJwWIquiNj
	/LnTlCGxp9e+fasH2hrXUfs6HHq081bQJQYuC4hUCFfUKzcv+uh4
X-Google-Smtp-Source: AGHT+IGmwZEw1xm9D6NmAXuVXmOZeBYvUcoCH5DdguExSt3s8bitCu93PDdAZPDeUUAbx3SB5z+oag==
X-Received: by 2002:a05:6a20:2452:b0:1a7:17d:8863 with SMTP id t18-20020a056a20245200b001a7017d8863mr8555787pzc.4.1712494177572;
        Sun, 07 Apr 2024 05:49:37 -0700 (PDT)
Received: from tgsp-ThinkPad-X280.. ([223.153.78.230])
        by smtp.gmail.com with ESMTPSA id e7-20020a63aa07000000b005f09e966e8asm4495442pgf.60.2024.04.07.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 05:49:37 -0700 (PDT)
From: xiongxin <xiongxin@kylinos.cn>
To: mario.limonciello@amd.com,
	Rafael Wysocki <rafael@kernel.org>,
	hdegoede@redhat.com,
	linus.walleij@linaro.org
Cc: Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v4 1/4] include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume
Date: Sun,  7 Apr 2024 20:49:15 +0800
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

