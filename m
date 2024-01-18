Return-Path: <linux-kernel+bounces-30461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C460831EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11662839FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C502D618;
	Thu, 18 Jan 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODUITBD4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4472D603
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601710; cv=none; b=Rn+8fgYjAoes4MhTbbk+jMw6GnNp6JzY6FAL93p4zbsAEeEe4r+a9/HP/WNZBqZZHHmA0Tp0q5quBo/YWzJxL65vmJuBFcHYC3hm7GeuEYTQ1VohpriPDIptyBg2IHyByLGBTl53qdZX5D45FABt/mfX0j/udS3Zc45IMEjrEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601710; c=relaxed/simple;
	bh=z3+zDE7dBqyiPOw5K9AEIGBz+aR0ScJgqXYS/VIvbHo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=enx4Sx/bphogIQtSF2uhYbx/+8IBz5mbNFFQdrr8PUtst+1i8r08kfgqW7izUuEsnjAFA3Nxz9WYj2ARdoYtuF5lxV+fbz+nGR3yCFpfyiGLlzAV/o1nQTriZNn02o0KXLdMjTg04GX9ax3YMSt2niO7lEPi8D0d6xxiI7NeFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODUITBD4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc21c5538c5so1289043276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705601707; x=1706206507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GZ3m88KYLdsVsL1UU9Grf8EFt+HgtmMQu+Kzgd6Ds64=;
        b=ODUITBD4Xrlzzs5f01/nIHf4wO0umxOhsbltvtKq/7zxdbaetrbYv0EenH4bSJJQOq
         CresQ68fWyc2CE5hMYOljSXlLrcN2GT1JmNMvoP5lSDLip1jDHO6DErzJAty3DYwE9ZI
         v1/8v0WiaxrQIsF3bvWUOCL3YUPEBOeWQnpOEhZNj5PUg5FF1/90iPiZpn4vq7pa0uj4
         dEolSr5HVfKPVaRk8p44nBQzeje3mesnS1JlE1b5S9eeO0nL8hrw9wTqJ9ivUCXPExZB
         GQhs7Ai1cpeDUvJYTCT5E7zSGlWt1Z1Dmrnzjiml4OUjQmJihX9f4u526dLs6dQaGySv
         gF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601707; x=1706206507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZ3m88KYLdsVsL1UU9Grf8EFt+HgtmMQu+Kzgd6Ds64=;
        b=VexjriZZRyM3f5o01xp+FxrZeM7YbDJSmdPHyIQ9p7BcEAJi0RdKdIC5z8i+2zS2wU
         e1U5Uwe5NR94wZtCckjO/0NljjpafzGdAfTCx68+eYWLycogcRNEcjCNA4/YLeJcobYR
         3wFKZpdoPIJBstLu8aySDCUD1dU/29fm/1CIk1Hb16tKao/5v+U6mR0UqmnPGJEYn4Bx
         lKBFkUAzr9+bAJe+iwK803wY37jVytYL++3ZgQos6oPVITIfQ62OhxLZxWa0MntTR3Oo
         +eXsPArcE7VnAd6sS34BMxhu4w7ZfyIeKNrxznywFDbM/brz6ffbMv5RnoEnUPJ3F6I8
         M4nQ==
X-Gm-Message-State: AOJu0YxBrBqqKdDwcpO0wDTuQHfskPhSIJ52fy4x5UQsGkQ06TP7mL4a
	WHjlRKgVa50pCjP24MvS57a+P1kEjlDT09XzaK5NBr/MBZ+aGsb9k3/XjRO5Rcz06t9gvSehPYo
	UjfiGYCtKRg==
X-Google-Smtp-Source: AGHT+IHBIYtPF6DjaIWfKSs4LMOMypZd4qtVgevFsn7KT4B/3vTEP9xQw30QeqTPTJdMRH8u7VoLwlHJAhM9gg==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a05:6902:230f:b0:dc2:2e5c:a21d with SMTP
 id do15-20020a056902230f00b00dc22e5ca21dmr577706ybb.6.1705601707714; Thu, 18
 Jan 2024 10:15:07 -0800 (PST)
Date: Thu, 18 Jan 2024 18:14:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118181459.1663313-1-pranavpp@google.com>
Subject: [PATCH] alarmtimer: Expose information about next alarm to userspace
 via sysfs
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, Pranav Prasad <pranavpp@google.com>, 
	Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"

The alarmtimer driver currently fails suspend attempts when there is an
alarm pending within the next 2 seconds, since the system is expected to wake
up soon anyway. The entire suspend process is initiated even though the
system will immediately awaken. This process includes substantial work before
the suspend fails and additional work afterwards to undo the failed suspend
that was attempted. Therefore on battery-powered devices that initiate suspend
attempts from userspace, it may be advantageous to be able to skip the entire
suspend attempt to avoid power consumption instead of unnecessarily trying and
failing. As one data point, an analysis of a subset of Android devices showed that
imminent alarms account for roughly 40% of all suspend failures on average leading
to unnecessary power wastage.

To facilitate this, create a sysfs node for the alarmtimer subsystem to
provide information about the next coming alarm to userspace. When userspace code
reads the sysfs node, the same code flow already used in suspend will run to
provide a value for the time until the next alarm. Userspace code may then opt to
avoid suspend attempts if the next alarm pending is considered "too soon" for
the suspend to be worthwhile.

This mechanism has some limitations that the value readers must take into
account. First, due to any latencies between the calculation of the value and the
reader actually acting upon it (copying the data out to userspace, scheduling
delays, etc), the value will already be "obsolete" by the time the reader can act
upon it. Second, since alarms can be scheduled and canceled at any time, there
is no guarantee that the specific alarm that was "next" during the read
still exists, or that an earlier alarm hasn't been scheduled since the read.
Since no guarantee is provided about the value that was read remaining correct
by the time the reader uses it, consumers should only treat this value as a
hint to influence power optimization decisions rather than as a reliable
prediction of future events.

Signed-off-by: Pranav Prasad <pranavpp@google.com>
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
---
 kernel/time/alarmtimer.c | 131 +++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 26 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4657cb8e8b1f..80d576b8c2d7 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -27,12 +27,15 @@
 #include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/time_namespace.h>
+#include <linux/sysfs.h>
 
 #include "posix-timers.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/alarmtimer.h>
 
+static const char alarmtimer_group_name[] = "alarmtimer";
+
 /**
  * struct alarm_base - Alarm timer bases
  * @lock:		Lock for syncrhonized access to the base
@@ -63,6 +66,99 @@ static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
 static DEFINE_SPINLOCK(rtcdev_lock);
 
+/**
+ * alarmtimer_init_soonest - Initializes parameters to find soonest alarm.
+ * @min: ptr to relative time to the soonest alarm to expire
+ * @expires: ptr to absolute time of the soonest alarm to expire
+ * @type: ptr to alarm type
+ * @reset_freezer_delta: boolean to indicate if freezer_delta should be reset to 0
+ *
+ */
+static void alarmtimer_init_soonest(ktime_t *min, ktime_t *expires, int *type,
+			bool reset_freezer_delta)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&freezer_delta_lock, flags);
+	*min = freezer_delta;
+	*expires = freezer_expires;
+	*type = freezer_alarmtype;
+	if (reset_freezer_delta)
+		freezer_delta = 0;
+	spin_unlock_irqrestore(&freezer_delta_lock, flags);
+}
+
+/**
+ * alarmtimer_get_soonest - Finds the soonest alarm to expire among the alarm bases.
+ * @min: ptr to relative time to the soonest alarm to expire
+ * @expires: ptr to absolute time of the soonest alarm to expire
+ * @type: ptr to alarm type
+ *
+ */
+static void alarmtimer_get_soonest(ktime_t *min, ktime_t *expires, int *type)
+{
+	int i;
+	unsigned long flags;
+
+	/* Find the soonest timer to expire */
+	for (i = 0; i < ALARM_NUMTYPE; i++) {
+		struct alarm_base *base = &alarm_bases[i];
+		struct timerqueue_node *next;
+		ktime_t delta;
+
+		spin_lock_irqsave(&base->lock, flags);
+		next = timerqueue_getnext(&base->timerqueue);
+		spin_unlock_irqrestore(&base->lock, flags);
+		if (!next)
+			continue;
+		delta = ktime_sub(next->expires, base->get_ktime());
+		if (!(*min) || (delta < *min)) {
+			*expires = next->expires;
+			*min = delta;
+			*type = i;
+		}
+	}
+}
+
+static ssize_t next_alarm_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	ktime_t min, expires;
+	int type;
+
+	/* Init and find the soonest timer to expire */
+	alarmtimer_init_soonest(&min, &expires, &type, false);
+	alarmtimer_get_soonest(&min, &expires, &type);
+
+	return sysfs_emit(buf, "%lld\n", ktime_to_ns(min));
+}
+static struct kobj_attribute next_alarm = __ATTR_RO(next_alarm);
+
+static struct attribute *alarmtimer_attrs[] = {
+	&next_alarm.attr,
+	NULL,
+};
+
+static const struct attribute_group alarmtimer_attr_group = {
+	.name	= alarmtimer_group_name,
+	.attrs	= alarmtimer_attrs,
+};
+
+/**
+ * alarmtimer_sysfs_add - Adds sysfs attributes for alarmtimer
+ *
+ * Returns 0 if successful, non-zero value for error.
+ */
+static int alarmtimer_sysfs_add(void)
+{
+	int ret = sysfs_create_group(kernel_kobj, &alarmtimer_attr_group);
+
+	if (ret)
+		pr_warn("[%s] failed to create a sysfs group\n", __func__);
+
+	return ret;
+}
+
 /**
  * alarmtimer_get_rtcdev - Return selected rtcdevice
  *
@@ -98,8 +194,11 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 
 	pdev = platform_device_register_data(dev, "alarmtimer",
 					     PLATFORM_DEVID_AUTO, NULL, 0);
-	if (!IS_ERR(pdev))
+	if (!IS_ERR(pdev)) {
 		device_init_wakeup(&pdev->dev, true);
+		if (alarmtimer_sysfs_add())
+			pr_warn("[%s] failed to add alarmtimer sysfs attributes\n", __func__);
+	}
 
 	spin_lock_irqsave(&rtcdev_lock, flags);
 	if (!IS_ERR(pdev) && !rtcdev) {
@@ -241,41 +340,21 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 static int alarmtimer_suspend(struct device *dev)
 {
 	ktime_t min, now, expires;
-	int i, ret, type;
+	int ret, type;
 	struct rtc_device *rtc;
-	unsigned long flags;
 	struct rtc_time tm;
 
-	spin_lock_irqsave(&freezer_delta_lock, flags);
-	min = freezer_delta;
-	expires = freezer_expires;
-	type = freezer_alarmtype;
-	freezer_delta = 0;
-	spin_unlock_irqrestore(&freezer_delta_lock, flags);
+	/* Initialize parameters to find soonest timer */
+	alarmtimer_init_soonest(&min, &expires, &type, true);
 
 	rtc = alarmtimer_get_rtcdev();
 	/* If we have no rtcdev, just return */
 	if (!rtc)
 		return 0;
 
-	/* Find the soonest timer to expire*/
-	for (i = 0; i < ALARM_NUMTYPE; i++) {
-		struct alarm_base *base = &alarm_bases[i];
-		struct timerqueue_node *next;
-		ktime_t delta;
+	/* Find the soonest timer to expire */
+	alarmtimer_get_soonest(&min, &expires, &type);
 
-		spin_lock_irqsave(&base->lock, flags);
-		next = timerqueue_getnext(&base->timerqueue);
-		spin_unlock_irqrestore(&base->lock, flags);
-		if (!next)
-			continue;
-		delta = ktime_sub(next->expires, base->get_ktime());
-		if (!min || (delta < min)) {
-			expires = next->expires;
-			min = delta;
-			type = i;
-		}
-	}
 	if (min == 0)
 		return 0;
 
-- 
2.43.0.381.gb435a96ce8-goog


