Return-Path: <linux-kernel+bounces-88857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BB86E794
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47D228646A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D351118E;
	Fri,  1 Mar 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="IymlBTOu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04FC8E1;
	Fri,  1 Mar 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315185; cv=none; b=boLF6AlZ+pe0lXzQssZLI6n/OhxuFJKDIdJdZX+tM7PRhUG49YD+pHfhux+nv4r8PQj8wfhHy0AQApHeUC3Mr10qxpr7kZFMsctTArq6IROg+200jLO6Jna3SgQR3XBo85B4iifwMeygGtAiiILAnp25ABNR/OyHrGyR32EmtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315185; c=relaxed/simple;
	bh=3MvsTBvkhiyDac+XqcTV9/VlfklempOU222L0HuDUuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nlQGQWsUV6HJ4wsWAEFPZOdWm4RVDMnWaA7lZ+u0KL0q+udIT5AdnDhBf4x5pnpU8gbqS/WanlUSGLInUik0wNlp00TZITU3nrKBom1jAtPH7PWq+sBL7TENxOEcIDU+sw2Jk9fSkeCqvjfBeDgsjpZNibWp6glS8tTtDZDH3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=IymlBTOu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc418fa351so26617445ad.1;
        Fri, 01 Mar 2024 09:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315182; x=1709919982;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogPBLVpybTXcJp4Oam92GkbU9zB0BJ/NXq692FV4RGc=;
        b=bH9lF+ObiX8YkeYcoi2zgmMM/7yhb+3VH9MOP7pfu/9IG66FiMOOSkXPBUfPyhwqVp
         gtb9Mg0AWHMcs2I7qe34z72cy1I4K2TyuwIerF3ITo4ncNkBCvlWnIHqyR5+H7y7TzoO
         qUsXEm9FyCcgJm0o1uZRFaqiTNI3D93T5kunhmdgpYUlHa7QIbDC8aCjZvKsWb4/u81v
         kqJpf/X/YFyr6j5Bdirb5GwBB5KVG4cPQMP8teb2WnoWp0wAZctHH0CZvd9ggWP001sM
         9ybDgyAkzLlfZYbE6p1NBqT9N7BhohQdvrNjS1fsCe13P1GkE+FlZrrWjbaDOFkRSziB
         izEw==
X-Forwarded-Encrypted: i=1; AJvYcCVAbu14SRTU+gHooeckzOIzNT7+TJnjSO1G7+9e+u6jKFcSrjOrvr+BMQS4Xz8osXabom2qj/TV9j3884QfHWMceOnUCHUQ25k/VSIU
X-Gm-Message-State: AOJu0YwAdPi17i+VE+vtWLO4lQEGt27IEvfqlXJOeSWsc1RPvCF71TLd
	hjTQRIWkxct0/qkJiv0+7JQRpyH92xvFKG9Io4A233dRMOYzn6ks915tT5at
X-Google-Smtp-Source: AGHT+IGBj2hechP6fg4d+Hg7uttrizSJYzA7YZG4k73prtfNLV2Od5KDY+OprZ2A2nJnd4aDU+KwZA==
X-Received: by 2002:a17:902:e88d:b0:1d9:adc9:2962 with SMTP id w13-20020a170902e88d00b001d9adc92962mr3354922plg.20.1709315182151;
        Fri, 01 Mar 2024 09:46:22 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f55200b001dc0e5ad5desm3748550plf.114.2024.03.01.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:46:21 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709315179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ogPBLVpybTXcJp4Oam92GkbU9zB0BJ/NXq692FV4RGc=;
	b=IymlBTOuhlfiUhazRAUzFD0dWf9nXScCtKLpLnr5t/6HD4nSRzxYYaydXPvSCSU6JlxARm
	SOoN3G1wwE5GrDpTQhVp7gesvvVTPcr41F4B3AlfKOkDjAdajiYwVojVyWEyMXdrNvBTAJ
	+dwJRucTuDP2QWMI/OnPlzOI0CHQ8hSilgoDMMtvIaqxbZzHynR/qIBp2sRoDgt9oMr1Io
	Ioc4OVgbKsVMwWSp1BsBpP2Get2rKNFlC4NxdiX+1f90lcxpQp5NCVdKhFPKBWJlvWOuET
	FTcTHzoflIL00tYABXBF1FhAwTkjClHWUWC7OenPSYETtU1ID+Cl/Ok3aSHMWw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 01 Mar 2024 14:46:15 -0300
Subject: [PATCH] power: supply: core: make power_supply_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-class_cleanup-power-v1-1-97e0b7bf9c94@marliere.net>
X-B4-Tracking: v=1; b=H4sIAGYU4mUC/x3MTQqAIBBA4avErBMmC4OuEhFqUw2EiUM/EN09a
 fkt3ntAKDEJdMUDiU4W3kNGVRbgVxsWUjxlg0bdYI2V8psVGf1GNhxRxf2ipKxvHTptDDoDuYy
 JZr7/az+87weeR7hpZQAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9528; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=3MvsTBvkhiyDac+XqcTV9/VlfklempOU222L0HuDUuk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl4hRni7hMFLOAFlNoNRIG9M0Z0HhYr79MeS5wM
 j3MhWQN4x+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeIUZwAKCRDJC4p8Y4ZY
 puzhD/4oRSXLAOtI7wBnN/hgKVZhcjYe7jq/hYH6A+GUDrShn1v58Bv421W4yNG2vdf5rcO/DQI
 4qXu5TGO7bmFC1Zt/MdkIw7z0L4DWjQAXAViBVYdHh3BMzr3KlD1tpG4MG+uKRmkMRo6J+4OWr4
 DV4D4zeNJSsXUBqYFb1NipLhBbTno2alWZ9axhc+IbJKhqr/71rhy5HOLE0Yz6g/uoVZc+hbM8i
 69sWRDvpsbPMYfmPMX5j4CAOq7LAUe5HlbuucP/l2GjR22jMqYfb4Wl5dKAikDH/DUL5AAkdMN6
 fTLVFLl8bxgt73ttuTpcrHrcAOdReoeNQNqJBpHARODZKz1hHdSopWWGGsjqxdqmWZx5l0igIX7
 ErcovouiVPdKw43mEzAkgigZktaxN47VE3wBtiVqeaq0X6L5IRpwrk3xBYzk0foq+ZeaDamAakB
 XOczGyHTMNlZVsRD912BRK9uhBLwqRVuHcIBhompnLg8WVMnOS64JoVDBqP+kW5He5vtNmA+u7N
 7ivJEgNAABH/tLpBMQ6zKJZZaBci60cxE3ZG1deYzj20BKMNM+biUsuYk+Pv0K1hqB20tl1uRVI
 tU4VNdEw0Lj0vnkBenZiLPTfm4o6ILIASo2hwPb2X3lKxdzqywtbKEpa+WHGO3pa1o0okE8Rz4c
 0Q05nxeAcC3WHDQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the power_supply_class structure to be declared at build
time placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/power/supply/ab8500_btemp.c      |  2 +-
 drivers/power/supply/ab8500_chargalg.c   |  2 +-
 drivers/power/supply/ab8500_charger.c    |  2 +-
 drivers/power/supply/ab8500_fg.c         |  2 +-
 drivers/power/supply/apm_power.c         |  2 +-
 drivers/power/supply/power_supply_core.c | 40 ++++++++++++++++++--------------
 include/linux/power_supply.h             |  2 +-
 7 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 7905eba93dea..41dba40fffdf 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -617,7 +617,7 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	class_for_each_device(power_supply_class, NULL, psy,
+	class_for_each_device(&power_supply_class, NULL, psy,
 			      ab8500_btemp_get_ext_psy_data);
 }
 
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index de912658facb..329ae784a72d 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1231,7 +1231,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 	int ret;
 
 	/* Collect data from all power_supply class devices */
-	class_for_each_device(power_supply_class, NULL,
+	class_for_each_device(&power_supply_class, NULL,
 		di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
 
 	ab8500_chargalg_end_of_charge(di);
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index d72f32c663bc..1c2b69bbed17 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1949,7 +1949,7 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 	struct ab8500_charger *di = container_of(work,
 		struct ab8500_charger, check_vbat_work.work);
 
-	class_for_each_device(power_supply_class, NULL,
+	class_for_each_device(&power_supply_class, NULL,
 			      &di->usb_chg, ab8500_charger_get_ext_psy_data);
 
 	/* First run old_vbat is 0. */
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 8c593fbdd45a..e49e704023e1 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2407,7 +2407,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	class_for_each_device(power_supply_class, NULL, psy,
+	class_for_each_device(&power_supply_class, NULL, psy,
 			      ab8500_fg_get_ext_psy_data);
 }
 
diff --git a/drivers/power/supply/apm_power.c b/drivers/power/supply/apm_power.c
index 9d1a7fbcaed4..034f28699977 100644
--- a/drivers/power/supply/apm_power.c
+++ b/drivers/power/supply/apm_power.c
@@ -79,7 +79,7 @@ static void find_main_battery(void)
 	main_battery = NULL;
 	bp.main = main_battery;
 
-	error = class_for_each_device(power_supply_class, NULL, &bp,
+	error = class_for_each_device(&power_supply_class, NULL, &bp,
 				      __find_main_battery);
 	if (error) {
 		main_battery = bp.main;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 37dac7669090..18232c562a98 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -26,7 +26,10 @@
 #include "samsung-sdi-battery.h"
 
 /* exported for the APM Power driver, APM emulation */
-struct class *power_supply_class;
+const struct class power_supply_class = {
+	.name = "power_supply",
+	.dev_uevent = power_supply_uevent,
+};
 EXPORT_SYMBOL_GPL(power_supply_class);
 
 static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
@@ -97,7 +100,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	if (likely(psy->changed)) {
 		psy->changed = false;
 		spin_unlock_irqrestore(&psy->changed_lock, flags);
-		class_for_each_device(power_supply_class, NULL, psy,
+		class_for_each_device(&power_supply_class, NULL, psy,
 				      __power_supply_changed_work);
 		power_supply_update_leds(psy);
 		blocking_notifier_call_chain(&power_supply_notifier,
@@ -191,7 +194,7 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
 {
 	int error;
 
-	error = class_for_each_device(power_supply_class, NULL, psy,
+	error = class_for_each_device(&power_supply_class, NULL, psy,
 				      __power_supply_populate_supplied_from);
 
 	dev_dbg(&psy->dev, "%s %d\n", __func__, error);
@@ -226,8 +229,8 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 	 * We return 0 if class_for_each_device() returned 1, -EPROBE_DEFER if
 	 * it returned 0, or error as returned by it.
 	 */
-	error = class_for_each_device(power_supply_class, NULL, supply_node,
-				       __power_supply_find_supply_from_node);
+	error = class_for_each_device(&power_supply_class, NULL, supply_node,
+				      __power_supply_find_supply_from_node);
 
 	return error ? (error == 1 ? 0 : error) : -EPROBE_DEFER;
 }
@@ -333,7 +336,7 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 	struct psy_am_i_supplied_data data = { psy, 0 };
 	int error;
 
-	error = class_for_each_device(power_supply_class, NULL, &data,
+	error = class_for_each_device(&power_supply_class, NULL, &data,
 				      __power_supply_am_i_supplied);
 
 	dev_dbg(&psy->dev, "%s count %u err %d\n", __func__, data.count, error);
@@ -369,7 +372,7 @@ int power_supply_is_system_supplied(void)
 	int error;
 	unsigned int count = 0;
 
-	error = class_for_each_device(power_supply_class, NULL, &count,
+	error = class_for_each_device(&power_supply_class, NULL, &count,
 				      __power_supply_is_system_supplied);
 
 	/*
@@ -416,7 +419,7 @@ int power_supply_get_property_from_supplier(struct power_supply *psy,
 	 * This function is not intended for use with a supply with multiple
 	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	ret = class_for_each_device(power_supply_class, NULL, &data,
+	ret = class_for_each_device(&power_supply_class, NULL, &data,
 				    __power_supply_get_supplier_property);
 	if (ret < 0)
 		return ret;
@@ -462,8 +465,8 @@ static int power_supply_match_device_by_name(struct device *dev, const void *dat
 struct power_supply *power_supply_get_by_name(const char *name)
 {
 	struct power_supply *psy = NULL;
-	struct device *dev = class_find_device(power_supply_class, NULL, name,
-					power_supply_match_device_by_name);
+	struct device *dev = class_find_device(&power_supply_class, NULL, name,
+					       power_supply_match_device_by_name);
 
 	if (dev) {
 		psy = dev_get_drvdata(dev);
@@ -519,8 +522,8 @@ struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 	if (!power_supply_np)
 		return ERR_PTR(-ENODEV);
 
-	dev = class_find_device(power_supply_class, NULL, power_supply_np,
-						power_supply_match_device_node);
+	dev = class_find_device(&power_supply_class, NULL, power_supply_np,
+				power_supply_match_device_node);
 
 	of_node_put(power_supply_np);
 
@@ -1373,7 +1376,7 @@ __power_supply_register(struct device *parent,
 
 	device_initialize(dev);
 
-	dev->class = power_supply_class;
+	dev->class = &power_supply_class;
 	dev->type = &power_supply_dev_type;
 	dev->parent = parent;
 	dev->release = power_supply_dev_release;
@@ -1621,12 +1624,13 @@ EXPORT_SYMBOL_GPL(power_supply_get_drvdata);
 
 static int __init power_supply_class_init(void)
 {
-	power_supply_class = class_create("power_supply");
+	int err;
 
-	if (IS_ERR(power_supply_class))
-		return PTR_ERR(power_supply_class);
+	err = class_register(&power_supply_class);
+
+	if (err)
+		return err;
 
-	power_supply_class->dev_uevent = power_supply_uevent;
 	power_supply_init_attrs();
 
 	return 0;
@@ -1634,7 +1638,7 @@ static int __init power_supply_class_init(void)
 
 static void __exit power_supply_class_exit(void)
 {
-	class_destroy(power_supply_class);
+	class_unregister(&power_supply_class);
 }
 
 subsys_initcall(power_supply_class_init);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c0992a77feea..514f652de64d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -895,7 +895,7 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);
 /* For APM emulation, think legacy userspace. */
-extern struct class *power_supply_class;
+extern const struct class power_supply_class;
 
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 {

---
base-commit: 9a451f1b028e116d037a93bf13eb8f8620994205
change-id: 20240301-class_cleanup-power-ac7b0b2660b6

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


