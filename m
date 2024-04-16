Return-Path: <linux-kernel+bounces-147503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05DA8A755E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F751F226EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1550C139D10;
	Tue, 16 Apr 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="fwuRdMJL"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BB11181;
	Tue, 16 Apr 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298751; cv=none; b=LjgAUwNvpj4sVPr+69R/pF8BMLrPCX9JrwqaPTb5QeHxqrpZ5uRFFmsfkrKZBTqcQ42vkFmpIg2A3yyhAAODS1+0zto3xVPJ/Lxylga1l/NmPw0nj0sQhGOOo7QTnvCslqsQfDbl/s3LUdQ0yTG1bWdVps0a23SqP8kWvE4+gVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298751; c=relaxed/simple;
	bh=cNvivALIidlyfECLsQcIW+1kvtPs6SNsHT1bcaTUOKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DjKIU0dlzSa1mReHGD4/swCWC054CKFI6oqRZFwUkTdsSYKQ9IOeK7COlDWVPZN0ODAadAB9Z6PQ7OTuqiTpY+DvcdieSflC/hJyVPzRWqWx/2PgfTHFio5WyFMPlycaKjOjO9GX0aCcTb7yGb4iaXEcqZ8s3To2X2Vst9lx8Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=fwuRdMJL; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 546F912000A;
	Tue, 16 Apr 2024 23:19:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 546F912000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713298743;
	bh=L9jXqS8fSzJ/1fhIJoEE9a+C/MWNnEorEAG3WBoMF9g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=fwuRdMJLIX4czjhX8zYYXSubkh3eTeX3o7Mpoxng9MaX79e0Cdtck8iZUoBAcoE5R
	 pn5kum8QLTvSOqNXf6dAvZULY3j3aBAlGrDczgOAq0k06dDQjkmKO5hqhUuEuLcoAi
	 5LxLKCis5oBAngf/WUSl/DT/J0HJmDdttp1BQusQtbglbpvrkY4V9/0dRnxM3GIwSP
	 ixnb9N2Sp8eB0by/v2NFMRWDl1Tm2luS40tpkyBaRH6zvUzhDKlh/SRzrMr6hOuv4x
	 YJ3vh71KggwVZSN54uSy8obpb7VIeOTomtCI7wmIEXAShQDk/Od6y+DTnxWOMVExIL
	 xsZa3yGoCVDmg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 16 Apr 2024 23:19:03 +0300 (MSK)
Received: from CAB-WSD-0004828.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Apr 2024 23:19:02 +0300
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<kernel@salutedevices.com>, Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v2 RESEND] leds: trigger: pattern: add support for hrtimer
Date: Tue, 16 Apr 2024 23:18:05 +0300
Message-ID: <20240416201847.357099-1-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184745 [Apr 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 17 0.3.17 f2153f38d75b12894d9cf445f96cd15c9ef63a9d, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/16 19:14:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/16 20:10:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/16 18:45:00 #24828684
X-KSMG-AntiVirus-Status: Clean, skipped

Currently, led pattern trigger uses timer_list to schedule brightness
changing. As we know from timer_list API [1], it's not accurate to
milliseconds and depends on HZ granularity.

Example:
"0 10 0 0 50 10 50 0 100 10 100 0 150 10 150 0 200 10 200 0 250 10 250 0",
we expect it to be 60ms long, but it can actually be up to ~120ms
(add ~10ms for each pattern when HZ == 100).

But sometimes, userspace needs time accurate led patterns to make sure
that pattern will be executed during expected time slot.
To achieve this goal the patch introduces optional hrtimer usage for
led trigger pattern, because hrtimer is microseconds accurate timer.

[1]: kernel/time/timer.c#L104

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
Changes v2 since v1 at [1]:
  - Fix build warning reported by kernel test robot [2]

Links:
  [1] https://lore.kernel.org/all/20230522190412.374474-1-mmkurbanov@sberdevices.ru/
  [2] https://lore.kernel.org/oe-kbuild-all/202305230549.ekneaQ89-lkp@intel.com/

 .../testing/sysfs-class-led-trigger-pattern   |  10 ++
 drivers/leds/trigger/ledtrig-pattern.c        | 126 ++++++++++++++----
 2 files changed, 113 insertions(+), 23 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
index 8c57d2780554e..22f28f2e9ac49 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -12,6 +12,16 @@ Description:
 		The exact format is described in:
 		Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
 
+What:		/sys/class/leds/<led>/hr_pattern
+Date:		April 2024
+Description:
+		Specify a software pattern for the LED, that supports altering
+		the brightness for the specified duration with one software
+		timer. It can do gradual dimming and step change of brightness.
+
+		Unlike the /sys/class/leds/<led>/pattern, this attribute runs
+		a pattern on high-resolution timer (hrtimer).
+
 What:		/sys/class/leds/<led>/hw_pattern
 Date:		September 2018
 KernelVersion:	4.20
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index fadd87dbe9930..aad48c2540fc8 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
+#include <linux/hrtimer.h>
 
 #define MAX_PATTERNS		1024
 /*
@@ -21,6 +22,12 @@
  */
 #define UPDATE_INTERVAL		50
 
+enum pattern_type {
+	PATTERN_TYPE_SW, /* Use standard timer for software pattern */
+	PATTERN_TYPE_HR, /* Use hrtimer for software pattern */
+	PATTERN_TYPE_HW, /* Hardware pattern */
+};
+
 struct pattern_trig_data {
 	struct led_classdev *led_cdev;
 	struct led_pattern patterns[MAX_PATTERNS];
@@ -32,8 +39,9 @@ struct pattern_trig_data {
 	int last_repeat;
 	int delta_t;
 	bool is_indefinite;
-	bool is_hw_pattern;
+	enum pattern_type type;
 	struct timer_list timer;
+	struct hrtimer hrtimer;
 };
 
 static void pattern_trig_update_patterns(struct pattern_trig_data *data)
@@ -71,10 +79,35 @@ static int pattern_trig_compute_brightness(struct pattern_trig_data *data)
 		return data->curr->brightness - step_brightness;
 }
 
-static void pattern_trig_timer_function(struct timer_list *t)
+static void pattern_trig_timer_start(struct pattern_trig_data *data)
 {
-	struct pattern_trig_data *data = from_timer(data, t, timer);
+	if (data->type == PATTERN_TYPE_HR) {
+		hrtimer_start(&data->hrtimer, ns_to_ktime(0), HRTIMER_MODE_REL);
+	} else {
+		data->timer.expires = jiffies;
+		add_timer(&data->timer);
+	}
+}
 
+static void pattern_trig_timer_cancel(struct pattern_trig_data *data)
+{
+	if (data->type == PATTERN_TYPE_HR)
+		hrtimer_cancel(&data->hrtimer);
+	else
+		del_timer_sync(&data->timer);
+}
+
+static void pattern_trig_timer_restart(struct pattern_trig_data *data,
+				       unsigned long interval)
+{
+	if (data->type == PATTERN_TYPE_HR)
+		hrtimer_forward_now(&data->hrtimer, ms_to_ktime(interval));
+	else
+		mod_timer(&data->timer, jiffies + msecs_to_jiffies(interval));
+}
+
+static void pattern_trig_timer_common_function(struct pattern_trig_data *data)
+{
 	for (;;) {
 		if (!data->is_indefinite && !data->repeat)
 			break;
@@ -83,8 +116,7 @@ static void pattern_trig_timer_function(struct timer_list *t)
 			/* Step change of brightness */
 			led_set_brightness(data->led_cdev,
 					   data->curr->brightness);
-			mod_timer(&data->timer,
-				  jiffies + msecs_to_jiffies(data->curr->delta_t));
+			pattern_trig_timer_restart(data, data->curr->delta_t);
 			if (!data->next->delta_t) {
 				/* Skip the tuple with zero duration */
 				pattern_trig_update_patterns(data);
@@ -106,8 +138,7 @@ static void pattern_trig_timer_function(struct timer_list *t)
 
 			led_set_brightness(data->led_cdev,
 					   pattern_trig_compute_brightness(data));
-			mod_timer(&data->timer,
-				  jiffies + msecs_to_jiffies(UPDATE_INTERVAL));
+			pattern_trig_timer_restart(data, UPDATE_INTERVAL);
 
 			/* Accumulate the gradual dimming time */
 			data->delta_t += UPDATE_INTERVAL;
@@ -117,6 +148,25 @@ static void pattern_trig_timer_function(struct timer_list *t)
 	}
 }
 
+static void pattern_trig_timer_function(struct timer_list *t)
+{
+	struct pattern_trig_data *data = from_timer(data, t, timer);
+
+	return pattern_trig_timer_common_function(data);
+}
+
+static enum hrtimer_restart pattern_trig_hrtimer_function(struct hrtimer *t)
+{
+	struct pattern_trig_data *data =
+		container_of(t, struct pattern_trig_data, hrtimer);
+
+	pattern_trig_timer_common_function(data);
+	if (!data->is_indefinite && !data->repeat)
+		return HRTIMER_NORESTART;
+
+	return HRTIMER_RESTART;
+}
+
 static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
 {
 	struct pattern_trig_data *data = led_cdev->trigger_data;
@@ -124,7 +174,7 @@ static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
 	if (!data->npatterns)
 		return 0;
 
-	if (data->is_hw_pattern) {
+	if (data->type == PATTERN_TYPE_HW) {
 		return led_cdev->pattern_set(led_cdev, data->patterns,
 					     data->npatterns, data->repeat);
 	}
@@ -136,8 +186,7 @@ static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
 	data->delta_t = 0;
 	data->curr = data->patterns;
 	data->next = data->patterns + 1;
-	data->timer.expires = jiffies;
-	add_timer(&data->timer);
+	pattern_trig_timer_start(data);
 
 	return 0;
 }
@@ -175,9 +224,9 @@ static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->lock);
 
-	del_timer_sync(&data->timer);
+	pattern_trig_timer_cancel(data);
 
-	if (data->is_hw_pattern)
+	if (data->type == PATTERN_TYPE_HW)
 		led_cdev->pattern_clear(led_cdev);
 
 	data->last_repeat = data->repeat = res;
@@ -196,14 +245,14 @@ static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RW(repeat);
 
 static ssize_t pattern_trig_show_patterns(struct pattern_trig_data *data,
-					  char *buf, bool hw_pattern)
+					  char *buf, enum pattern_type type)
 {
 	ssize_t count = 0;
 	int i;
 
 	mutex_lock(&data->lock);
 
-	if (!data->npatterns || (data->is_hw_pattern ^ hw_pattern))
+	if (!data->npatterns || data->type != type)
 		goto out;
 
 	for (i = 0; i < data->npatterns; i++) {
@@ -260,19 +309,19 @@ static int pattern_trig_store_patterns_int(struct pattern_trig_data *data,
 
 static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
 					   const char *buf, const u32 *buf_int,
-					   size_t count, bool hw_pattern)
+					   size_t count, enum pattern_type type)
 {
 	struct pattern_trig_data *data = led_cdev->trigger_data;
 	int err = 0;
 
 	mutex_lock(&data->lock);
 
-	del_timer_sync(&data->timer);
+	pattern_trig_timer_cancel(data);
 
-	if (data->is_hw_pattern)
+	if (data->type == PATTERN_TYPE_HW)
 		led_cdev->pattern_clear(led_cdev);
 
-	data->is_hw_pattern = hw_pattern;
+	data->type = type;
 	data->npatterns = 0;
 
 	if (buf)
@@ -297,7 +346,7 @@ static ssize_t pattern_show(struct device *dev, struct device_attribute *attr,
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct pattern_trig_data *data = led_cdev->trigger_data;
 
-	return pattern_trig_show_patterns(data, buf, false);
+	return pattern_trig_show_patterns(data, buf, PATTERN_TYPE_SW);
 }
 
 static ssize_t pattern_store(struct device *dev, struct device_attribute *attr,
@@ -305,7 +354,8 @@ static ssize_t pattern_store(struct device *dev, struct device_attribute *attr,
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 
-	return pattern_trig_store_patterns(led_cdev, buf, NULL, count, false);
+	return pattern_trig_store_patterns(led_cdev, buf, NULL, count,
+					   PATTERN_TYPE_SW);
 }
 
 static DEVICE_ATTR_RW(pattern);
@@ -316,7 +366,7 @@ static ssize_t hw_pattern_show(struct device *dev,
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct pattern_trig_data *data = led_cdev->trigger_data;
 
-	return pattern_trig_show_patterns(data, buf, true);
+	return pattern_trig_show_patterns(data, buf, PATTERN_TYPE_HW);
 }
 
 static ssize_t hw_pattern_store(struct device *dev,
@@ -325,11 +375,33 @@ static ssize_t hw_pattern_store(struct device *dev,
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 
-	return pattern_trig_store_patterns(led_cdev, buf, NULL, count, true);
+	return pattern_trig_store_patterns(led_cdev, buf, NULL, count,
+					   PATTERN_TYPE_HW);
 }
 
 static DEVICE_ATTR_RW(hw_pattern);
 
+static ssize_t hr_pattern_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+
+	return pattern_trig_show_patterns(data, buf, PATTERN_TYPE_HR);
+}
+
+static ssize_t hr_pattern_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+
+	return pattern_trig_store_patterns(led_cdev, buf, NULL, count,
+					   PATTERN_TYPE_HR);
+}
+
+static DEVICE_ATTR_RW(hr_pattern);
+
 static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
 				       struct attribute *attr, int index)
 {
@@ -338,6 +410,8 @@ static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
 
 	if (attr == &dev_attr_repeat.attr || attr == &dev_attr_pattern.attr)
 		return attr->mode;
+	else if (attr == &dev_attr_hr_pattern.attr)
+		return attr->mode;
 	else if (attr == &dev_attr_hw_pattern.attr && led_cdev->pattern_set)
 		return attr->mode;
 
@@ -347,6 +421,7 @@ static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
 static struct attribute *pattern_trig_attrs[] = {
 	&dev_attr_pattern.attr,
 	&dev_attr_hw_pattern.attr,
+	&dev_attr_hr_pattern.attr,
 	&dev_attr_repeat.attr,
 	NULL
 };
@@ -376,7 +451,8 @@ static void pattern_init(struct led_classdev *led_cdev)
 		goto out;
 	}
 
-	err = pattern_trig_store_patterns(led_cdev, NULL, pattern, size, false);
+	err = pattern_trig_store_patterns(led_cdev, NULL, pattern, size,
+					  PATTERN_TYPE_SW);
 	if (err < 0)
 		dev_warn(led_cdev->dev,
 			 "Pattern initialization failed with error %d\n", err);
@@ -400,12 +476,15 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
 		led_cdev->pattern_clear = NULL;
 	}
 
+	data->type = PATTERN_TYPE_SW;
 	data->is_indefinite = true;
 	data->last_repeat = -1;
 	mutex_init(&data->lock);
 	data->led_cdev = led_cdev;
 	led_set_trigger_data(led_cdev, data);
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
+	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	data->hrtimer.function = pattern_trig_hrtimer_function;
 	led_cdev->activated = true;
 
 	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
@@ -431,6 +510,7 @@ static void pattern_trig_deactivate(struct led_classdev *led_cdev)
 		led_cdev->pattern_clear(led_cdev);
 
 	timer_shutdown_sync(&data->timer);
+	hrtimer_cancel(&data->hrtimer);
 
 	led_set_brightness(led_cdev, LED_OFF);
 	kfree(data);
-- 
2.43.2


