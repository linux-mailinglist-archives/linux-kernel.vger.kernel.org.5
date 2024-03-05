Return-Path: <linux-kernel+bounces-92859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63BA87270B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C126287A96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6001B809;
	Tue,  5 Mar 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Xa23Tztb"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3B18EBB;
	Tue,  5 Mar 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664913; cv=none; b=kGrnTJXAqzYiEUdmeLpmAPR02jwJBERwR2D2bYSkCoSiA6Tegz+VQEhAaIhXlN/2/Nf5Oc2c1hh0Vk/gyH7Z/H2vjg1Xkgh2eRuOfvHGfz5NAgENVvMSrNFBYdbX7oCDrsXZqFeJZonuPXRcufTNdDNHq+JWzcCXtKglElUAORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664913; c=relaxed/simple;
	bh=U9spWfYXbrF6qhKvycvm9B6vOm/NHZv5QZUuD+8nWn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TqYPKHUOLZQzc+T7qgfcD6SLvzPf9slH8f1YZZN16vmPU9gv9p8qeD84DPPGCK/FpboM1Zw/LhgKYzFNi+8lyo1PQq42dA/2nAYfLVjZ/aSGIyUdEnL4pZFJOKopJ0EglLZi+eKOB2SDbiNKXyllz2Xqae+7t2jMNIz6OxreNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Xa23Tztb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd2c8f1204so7711565ad.1;
        Tue, 05 Mar 2024 10:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664910; x=1710269710;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKb7U6anf/OAuWseDxzXYRs1jCqsCKBlN3ms7c9H1EQ=;
        b=MCEDGSAEkmdFiKibQIjw7pG/DeGz3FAm+aUHc81qKI2nBPDzYK49DZMP7I+WyZdsQI
         XhRsrmE9w3zibkWXTS0Wu1Re8ek6irwe2KJnb/kbuVC2rNc5RIXbvteEZNd3qzb0n7Mc
         nV4dYQAbpyOj9xJ3KNXawEZw4eULGH/RbcD5rTD8xrCA/LIMroYDPKvL1VLt++pu0d4g
         LC4yLXP0nruUpOA8hbQ4SD4J6xTVaEdJQ4yBXdX7OyizpfI3JwNxeZDHMtodKxx1uEfb
         AO0LwLO8cFDUpvlqvm5LgbqCfgiBDY8RH/upYFAqbed+kbq7/iyTH4iAaELT1I8Sj+JN
         op1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/BOeRvBz1facr1gHP1wR7VRzick5TW9Lq295hgle29Yr1AAsxf4AHngTh6X+kUQYhvDNnbI6yG4SYAjbEAe885gjJLOf3GviysQ4y3M0VvZidFiJYXLWo/Zz+tOE1r/iqnK2a7rrmfNG3YncXI+qw1g==
X-Gm-Message-State: AOJu0YybNncCYHSKQ4EXikul1/XWIyeh3xwBRNThT1fZfGi8in7Nqm4h
	8Z/u5gYzpuh1rWHiLGcafAvhT2NTIbbleCbVfyoyG98KoQ/ktsxJ
X-Google-Smtp-Source: AGHT+IES5tNEvZAzbjj8Jv08Cf/wGdtZ/6BUeS1ponf4PO+HWz2wFRTqT1MtaHGQIGnjCvplCeb8bg==
X-Received: by 2002:a17:902:ecc4:b0:1dd:8f6:69ee with SMTP id a4-20020a170902ecc400b001dd08f669eemr3755991plh.20.1709664909936;
        Tue, 05 Mar 2024 10:55:09 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001d8e41b3f95sm10906254plg.51.2024.03.05.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:55:09 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709664907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KKb7U6anf/OAuWseDxzXYRs1jCqsCKBlN3ms7c9H1EQ=;
	b=Xa23TztbjjdvtZzWNQX1boNuRnFPxVX3VO3uJs2lwFp/I5Xwi/7lAXf15Jgy3tjv4ulaTq
	xE+D0CcdCxACE75ZifMrBO7UZ+A20RdmBaUd7UHCghSReRx5D2fNYHUVEzBYF1FcHftgy6
	ihEX7/aJJvC6LhwuMCcP67d9u/ZLuXGz0zapQbpsY6EaPU0Xc5F6tpt2Ed/sNOldyxWZLc
	pCwIj6gz/YPHgLTQJxkC1yRXOIfaw+3cdmIUJqs7QHF4SXScVQd1LfhG8seWBUWYF/AlJB
	LxEjbp+HAXi2FO4GD54IVdQZxpKoJYz1nnj8b9REy6TDAubx/GuiRs16DpVvgg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 15:55:04 -0300
Subject: [PATCH] platform/x86: make fw_attr_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-platform-v1-1-9085c97b9355@marliere.net>
X-B4-Tracking: v=1; b=H4sIAIdq52UC/x3MQQrDIBBA0avIrCuMpkLIVUoog500A8aIk5ZA8
 O6VLt/i/wuUq7DCZC6o/BWVPXe4m4G4Un6zlVc3ePR3HDDYmEj1GRNT/hRbEh3LXjc7okOOISB
 6Bz0ulRc5/+PH3NoPIVBCJWgAAAA=
To: Prasanth Ksr <prasanth.ksr@dell.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jorge Lopez <jorge.lopez2@hp.com>, Mark Pearson <markpearson@lenovo.com>
Cc: Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=U9spWfYXbrF6qhKvycvm9B6vOm/NHZv5QZUuD+8nWn8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl52qIfgwGc5zl+D71Y1KRHzcY4hF1XLsY0mKfJ
 7r6Qh3iqUOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZedqiAAKCRDJC4p8Y4ZY
 pgLTD/9onT3181hI2GfFt5lRs795TgCa7AjyaSMBGAJPkSQH5FZ1aM/xxElD71aCmlIICTMi2Rm
 pwsoe4p675jLyFRDzDmwtMUMBRI1jEr5uYhAiR39EWJIpP3qKa++0fHXxEtbwef/+QYE/wYcGOo
 +kYFqvzQFXK4q5cCzFtEf24t9QE6SBNC05aHXzV9f7mI//zERcA9uzTSQHmb8gURkP86M/fzkv6
 zqAPzIRsgzON31Q1OuNqxpMYhivgJzmxdW2jczhRBDPP3bWFsJB2vzbPj6ypQPOUK7VpNLyRqBa
 U/HSuxiWyx9BuVW1kuXLfTnY9DAyo30LgDd2IpEV0LVI953MtJ1+6aTSLi0yDYMUm3PaP0+JS5H
 4k73CkirL4phbSxeVCCpH3+Na+c7i7815JS7Zbd0+EnyYORxLbhM312v7u/prRFHtrBQlbimrNw
 8TbLxqr/svI9m5IKeY6QRehXrvw+ljtmWluFcs3zh2p4efI9CtnxVVeLUzrdBvdxaSYwx+9yw/e
 dooSHN7RWPZJUjt0Xbgq2T35YNFAXM7WHxs1+43tI67A6RuKX0pq9/xioEsQKQDa/h1NZZZlJ5H
 1Lg+MLbP5EtdIDydOqhm6/UyXl/2LrsRxaT0l0pYNQuUPjP85Eo8qzwkhn3SXalQj4B+greYGzu
 kQxTmyt5XzeWQMg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the fw_attr_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
 drivers/platform/x86/firmware_attributes_class.c   | 4 ++--
 drivers/platform/x86/firmware_attributes_class.h   | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c       | 2 +-
 drivers/platform/x86/think-lmi.c                   | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index b929b4f82420..9def7983d7d6 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -25,7 +25,7 @@ struct wmi_sysman_priv wmi_priv = {
 /* reset bios to defaults */
 static const char * const reset_types[] = {"builtinsafe", "lastknowngood", "factory", "custom"};
 static int reset_option = -1;
-static struct class *fw_attr_class;
+static const struct class *fw_attr_class;
 
 
 /**
diff --git a/drivers/platform/x86/firmware_attributes_class.c b/drivers/platform/x86/firmware_attributes_class.c
index fafe8eaf6e3e..dd8240009565 100644
--- a/drivers/platform/x86/firmware_attributes_class.c
+++ b/drivers/platform/x86/firmware_attributes_class.c
@@ -10,11 +10,11 @@
 static DEFINE_MUTEX(fw_attr_lock);
 static int fw_attr_inuse;
 
-static struct class firmware_attributes_class = {
+static const struct class firmware_attributes_class = {
 	.name = "firmware-attributes",
 };
 
-int fw_attributes_class_get(struct class **fw_attr_class)
+int fw_attributes_class_get(const struct class **fw_attr_class)
 {
 	int err;
 
diff --git a/drivers/platform/x86/firmware_attributes_class.h b/drivers/platform/x86/firmware_attributes_class.h
index 486485cb1f54..363c75f1ac1b 100644
--- a/drivers/platform/x86/firmware_attributes_class.h
+++ b/drivers/platform/x86/firmware_attributes_class.h
@@ -5,7 +5,7 @@
 #ifndef FW_ATTR_CLASS_H
 #define FW_ATTR_CLASS_H
 
-int fw_attributes_class_get(struct class **fw_attr_class);
+int fw_attributes_class_get(const struct class **fw_attr_class);
 int fw_attributes_class_put(void);
 
 #endif /* FW_ATTR_CLASS_H */
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 8c9f4f3227fc..2dc50152158a 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -24,7 +24,7 @@ struct bioscfg_priv bioscfg_drv = {
 	.mutex = __MUTEX_INITIALIZER(bioscfg_drv.mutex),
 };
 
-static struct class *fw_attr_class;
+static const struct class *fw_attr_class;
 
 ssize_t display_name_language_code_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 3a396b763c49..9eeef356e308 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -195,7 +195,7 @@ static const char * const level_options[] = {
 	[TLMI_LEVEL_MASTER] = "master",
 };
 static struct think_lmi tlmi_priv;
-static struct class *fw_attr_class;
+static const struct class *fw_attr_class;
 static DEFINE_MUTEX(tlmi_mutex);
 
 /* Convert BIOS WMI error string to suitable error code */

---
base-commit: 36c45cfc5cb3762b60707be2667c13d9a2562b34
change-id: 20240305-class_cleanup-platform-8010ec550021

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


