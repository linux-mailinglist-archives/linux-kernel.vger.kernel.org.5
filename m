Return-Path: <linux-kernel+bounces-92818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7779872677
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2035C1F276A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA418C3B;
	Tue,  5 Mar 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="WCLK0IiB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7A182C3;
	Tue,  5 Mar 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662955; cv=none; b=Mgjqwg6yeg33rxICquDbOh4uu6akcJ9RtUlAVIUCVknV/1/yQezLDUHV1IpHi4rVN4e395d19R3qbPcr1RVfv3BKUfzPTHwdzRT2WUBOQSxB5X+dmhrQd3Kaiiv6/XxV7Cho8JkP1Cr0uilo/4TJskF43PhAcDYcxDo/0rEVzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662955; c=relaxed/simple;
	bh=/TaGQkNgv+WehsCdP1uUe99SU9J60OJW6NxPtZhftlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EPTa6lSbNqdxvg1TgZqtqFKhDUsFHMVzNZ6BwAfBNeF6M05FMFz7JoU5bi/ZPefGVUKBL6EbbEwhkpDF6FsETRIN2mrC8d/I3BHqOhJZeDwkc95FfFklOraXw0Xe75+fh7d+5hjIOo8JxAEWfhYmppOenFKUovfw9AHgD3oq1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=WCLK0IiB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc29f1956cso47243815ad.0;
        Tue, 05 Mar 2024 10:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709662954; x=1710267754;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJuRzX0DshA7DJQkMwc6c7MdI4/qFDvgYzp1zH77e+0=;
        b=KDfqfLUdAU2dOlJZjHhAddoUkL8nAtYkUrLuUlAcnrBWkDihaLekzKX9++IfQA9Zew
         E57yZqE8GWueIMlC1CDMiHf6gsqh8DRRJoHlupilC0D+P0nL+tqunKTNCMnUUVYVgPF2
         F7As2Gv5SVlW2RsLs4JEBj40i/GEKXz2S08sQ1AVR5GYxy46Qj70XJKpPuzfpizXLFjE
         nIxWLE9UIThdDYb27Cg51szSakgRFjoRJfjfYSDyr/NYjrM6xvdEeroWIJquD2XIHJML
         aEqkzng6G4yohXKZ/YZ8bPlbd80exluopD67xXzkFc7LhcwJ+uusJrFM72qca9rY5MTT
         Fdfw==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZdxUcd7qGPMlYe2Nk7Wso84wmfpGsLyANJ0N+HWnAlieWSWAf7AgmziFFTElKuqcbzpqZMGm4Pq9/CJkkMpFIwPznq2Fnj+I5dAnk5kRNqNUTW0VkBrBoseGFChJP/kLHXsxurw=
X-Gm-Message-State: AOJu0YyV5KlKRLx/s+xLyheiaFyBzdJMHraqgfYja9aayJgRhauNtn2z
	WRzzqGpddOGpBdUtiIf9InBidmMGxZsAv6NHApFGCe41xXHBvHTZ
X-Google-Smtp-Source: AGHT+IGgfqIGDyCN231Y3kIbmeRcbKPODC2viJDJiu0m93MdQzj/dVMU5PpG1kNzMOCiUgtVx7bYJg==
X-Received: by 2002:a17:902:e88f:b0:1dc:b73b:ec35 with SMTP id w15-20020a170902e88f00b001dcb73bec35mr2961813plg.4.1709662953655;
        Tue, 05 Mar 2024 10:22:33 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001d9edac54b1sm10912800plg.171.2024.03.05.10.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:22:33 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709662952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HJuRzX0DshA7DJQkMwc6c7MdI4/qFDvgYzp1zH77e+0=;
	b=WCLK0IiBBWlI1C7toSxPyZYdWcazsF85vHbRmFEP712FxV37u6MRvmXmoxRJCsZsxdHYsz
	oLQpbT8Rcg2Ds2ubvAI2rWAa+YaWukXA2fNzYlBlb/6w2zqUzBdte50SCJOsrYks5QMYuK
	3n2NQjMrKPv15iEDNgy+SRE4u7HxLRZfrtXp1RbGdFLxfGXO3OQQvDeWYVP/IjDtxO5dyU
	nYXU+9Thsjgilb7H5LsLMMUSedYmjrYMRXELY7EBabIc1xDFk7tBG7UGn2Nim0GqU+/GHS
	3KLy/IY52ept9HAKmqGp0/QIElr5X9713hC1kGkGDiIMKyvgghOKIEiybDq1WA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 15:22:28 -0300
Subject: [PATCH] rtc: class: make rtc_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-abelloni-v1-1-944c026137c8@marliere.net>
X-B4-Tracking: v=1; b=H4sIAONi52UC/x3MQQqEMAxA0auUrC1ER3H0KiJDbKMTKLU0KAPi3
 ae4fIv/L1DOwgqjuSDzKSp7LKgrA+5LcWMrvhgabFp8YWddINWPC0zxSJYWDmGPYv2wvMmvPQ4
 tQolT5lV+z3ia7/sPhh0glmgAAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4311; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=/TaGQkNgv+WehsCdP1uUe99SU9J60OJW6NxPtZhftlA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl52LliPDiee8Qvtmvb4+HA8gqOufoGzHNRq/st
 lcOSofQXyaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZedi5QAKCRDJC4p8Y4ZY
 pubdEACi9HK1bzFnE49fGZ+B2s245YLjtqLPVFsAjn2zEOPaNgl4ceqFpcnu2uGVJ0PHNZcNh8+
 A5eiR/A//xXBN+A9Z/hF9i4BJRvy69TiJgn36ST1PiUo5kLv4dHvMpGuXwSIe4ZGUkzPmJ+fg+Z
 Urg2z8t7Gn4SArsAe4YbRLTEDxrK3wEDm1dYHtm/4ng0Nj7IG6IloHWNH1EKtogrXn1YFQhAYU+
 ZuUgEKpEd4AyFgSrumVtmiFf+wQbBGhQLQ+1dd4OW2ECccKJzS9hM+g947exVxdxNN3UKMN0Ovx
 LlR/0K5WmsYXM3l5EZeivrisLcWz3P6ejDW5HGHJ4gbWLveU3/+tKRWnkUvKZoUbwV27lnJGB1h
 rIfuolQSoC5ma5zCy2AiuLg3PbHDWZFf8Cv/Qhi7Oc1ThkaekrP1FuIbwEyq+Cl8RYDbHUl2sVX
 i2cIgc0kwlFWRmfcSMrNPF3p3R9Vcr6hKocMZnm4ZDgthuypvTknnB3llX078Uk9HEc0lFtcynr
 GJ3VsgIEHRxss4Ei7RFa46lX+uTt+HJ+gPO4isK7DgugYVhdjCtFys+Ee11G/8YO0nJfCtDk7T+
 GP7I90LMqLBKXBiIc09eVs8IA/SlhGCuA5DnGVLS9iRUmQq12Pr4ERit6yyVvb89nXePTMwGekC
 ZciQCNc+YYoRlnA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the rtc_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/rtc/class.c         | 21 +++++++++++++--------
 drivers/rtc/interface.c     |  2 +-
 include/linux/rtc.h         |  2 +-
 kernel/power/suspend_test.c |  2 +-
 kernel/time/alarmtimer.c    |  2 +-
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 921ee1827974..e31fa0ad127e 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -21,7 +21,6 @@
 #include "rtc-core.h"
 
 static DEFINE_IDA(rtc_ida);
-struct class *rtc_class;
 
 static void rtc_device_release(struct device *dev)
 {
@@ -199,6 +198,11 @@ static SIMPLE_DEV_PM_OPS(rtc_class_dev_pm_ops, rtc_suspend, rtc_resume);
 #define RTC_CLASS_DEV_PM_OPS	NULL
 #endif
 
+const struct class rtc_class = {
+	.name = "rtc",
+	.pm = RTC_CLASS_DEV_PM_OPS,
+};
+
 /* Ensure the caller will set the id before releasing the device */
 static struct rtc_device *rtc_allocate_device(void)
 {
@@ -220,7 +224,7 @@ static struct rtc_device *rtc_allocate_device(void)
 
 	rtc->irq_freq = 1;
 	rtc->max_user_freq = 64;
-	rtc->dev.class = rtc_class;
+	rtc->dev.class = &rtc_class;
 	rtc->dev.groups = rtc_get_dev_attribute_groups();
 	rtc->dev.release = rtc_device_release;
 
@@ -475,13 +479,14 @@ EXPORT_SYMBOL_GPL(devm_rtc_device_register);
 
 static int __init rtc_init(void)
 {
-	rtc_class = class_create("rtc");
-	if (IS_ERR(rtc_class)) {
-		pr_err("couldn't create class\n");
-		return PTR_ERR(rtc_class);
-	}
-	rtc_class->pm = RTC_CLASS_DEV_PM_OPS;
+	int err;
+
+	err = class_register(&rtc_class);
+	if (err)
+		return err;
+
 	rtc_dev_init();
+
 	return 0;
 }
 subsys_initcall(rtc_init);
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 1b63111cdda2..5faafb4aa55c 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -696,7 +696,7 @@ struct rtc_device *rtc_class_open(const char *name)
 	struct device *dev;
 	struct rtc_device *rtc = NULL;
 
-	dev = class_find_device_by_name(rtc_class, name);
+	dev = class_find_device_by_name(&rtc_class, name);
 	if (dev)
 		rtc = to_rtc_device(dev);
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 5f8e438a0312..3f4d315aaec9 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -42,7 +42,7 @@ static inline time64_t rtc_tm_sub(struct rtc_time *lhs, struct rtc_time *rhs)
 #include <linux/timerqueue.h>
 #include <linux/workqueue.h>
 
-extern struct class *rtc_class;
+extern const struct class rtc_class;
 
 /*
  * For these RTC methods the device parameter is the physical device
diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index b663a97f5867..d4856ec61570 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -201,7 +201,7 @@ static int __init test_suspend(void)
 	}
 
 	/* RTCs have initialized by now too ... can we use one? */
-	dev = class_find_device(rtc_class, NULL, NULL, has_wakealarm);
+	dev = class_find_device(&rtc_class, NULL, NULL, has_wakealarm);
 	if (dev) {
 		rtc = rtc_class_open(dev_name(dev));
 		put_device(dev);
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4657cb8e8b1f..5abfa4390673 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -134,7 +134,7 @@ static struct class_interface alarmtimer_rtc_interface = {
 
 static int alarmtimer_rtc_interface_setup(void)
 {
-	alarmtimer_rtc_interface.class = rtc_class;
+	alarmtimer_rtc_interface.class = &rtc_class;
 	return class_interface_register(&alarmtimer_rtc_interface);
 }
 static void alarmtimer_rtc_interface_remove(void)

---
base-commit: c12e67e076cbcb86fd9c3cb003a344ec684138a6
change-id: 20240305-class_cleanup-abelloni-d9b8adf70940

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


