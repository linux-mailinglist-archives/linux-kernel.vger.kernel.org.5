Return-Path: <linux-kernel+bounces-89819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60ED86F614
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A0285A0A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C926BB37;
	Sun,  3 Mar 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="FNkJAU6c"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB11E499;
	Sun,  3 Mar 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483457; cv=none; b=gdeuwQIkZ4Mcn/PbZBq7oqBII4akPZawQlAbz7k6DNvOX8rXjh3ZMjl3yZS2N9d/SELA3JesTaibLmAGwlGQXC+l4VAxc3jtcIQU7Jrh2Y5PbAi7mrGl6ba+e3tAmfoTnRdtF/MGyNujEYRgAh+5JCB3tN+c0nbLAZTBZnPfv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483457; c=relaxed/simple;
	bh=NKt+UkOLuWhi5aE3dgCRuciCjstns0KT4TDC+oezDI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V8itK3AvhTB6HO4FBm0QfcBtK58Sr9JX/jUOe4dGAejnXFO+isoU/Qz2laEq4pH8OCxfd23Q+t6CaWF/JoGit0//j1KmO9K9dBkDHFjYAcL5N4QHjXtNHn4YMZavFJZXVfTYlb6tjyPIGt+s6gN6NdEicNWqD1+LvyqEklEBrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=FNkJAU6c; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-299c11b250fso2390968a91.2;
        Sun, 03 Mar 2024 08:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709483455; x=1710088255;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FudLchqKx/rVDy9QMtMuyPGoJ1btkQ3n6JRM3X8NW0=;
        b=hGkTU9MW59ymPIkkcfmHw2+jiOdAn3r8HNLUuftpUJLVckKqmv6xC1K+bLfxIajksl
         6dVYcA5slnD3MczF0JtbpIGTD6fByLOOsaFtapgLjfSAPOrqZmtdqdROL4GAzxMXxbaJ
         iFv/fH3kWiKYKKW7eRjpGeSQYdyeURlQoR23Y7Y+JbxES0NyA9LURFy3Cr0vrnfZf1Z7
         oiIRPh2LDlgFBQbtFEO5seo2oSRN5EyuuJDW/FyQWlezGLgj47nqN22AwJYud2BKJG9r
         W204Hrs/fWyCcD68JkoJjChihvq1i5NrSeE4Mz/eAAhjjWKSHaeSboC41gkwN2095jvJ
         6fVg==
X-Forwarded-Encrypted: i=1; AJvYcCXOrjmXSspTxdeLf8gQ9CjOyJ/jCJxFIS6s2nwj0zLHsZSfhJW8QOIHH+QJ7J1ivCDV+pWaQODQ2d1nfZ5XVvsxEFt/aDGkvMDMUF8IsJ/O7ifJ1aXwi/WlhunbI3B9QiSmYe7lRHI=
X-Gm-Message-State: AOJu0YzW0pM8CY2Hth5HT+nPXsWWe/4m7POzOCK6Xv0mKCkWM3HL2qf7
	zR4BzHG69w17YJOG7nfWXnppOYANFhDmGZFdyKg0qD2YZiMeQChL43bGvsIYQ1E2Kw==
X-Google-Smtp-Source: AGHT+IFfsraSJiYxxD7h8AAkHiPbpRT5NV/8jX+OiHJ/GTJM1YgZ6YtWpyE7QtlkHbFBcvYX0CIiTQ==
X-Received: by 2002:a17:90a:ad43:b0:29a:b73c:4978 with SMTP id w3-20020a17090aad4300b0029ab73c4978mr4943322pjv.33.1709483455514;
        Sun, 03 Mar 2024 08:30:55 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id pw15-20020a17090b278f00b0029930881068sm8601230pjb.49.2024.03.03.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 08:30:55 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709483453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8FudLchqKx/rVDy9QMtMuyPGoJ1btkQ3n6JRM3X8NW0=;
	b=FNkJAU6cP6z0455cLJO8FRlwX16t77UKt6lEbD59tlHVl/YIwqhOqlf3YkaGgtf7oKIwdd
	5tzENCd0MOR5qB44XR7PH/QmIfgJVsdoJSaTlgwFNGW2N8oscpSjnN/g06t33+w+DvSyiE
	M0b+2lRG88sX1Z3CZs+Ad8+erylVO8d6bfFgSn1i97L4fjTpm2arEjG7wAKOS3QLGmq6qv
	ko5rxEKtnBjH2vIgi2L2wSvK4t2az44EHxtELgFuc48WCnoofRDgKPUSN3NMzB5M0M0A4R
	UAPXHQtGGcUkk5fWLhGEX9FYlRprgZl94JCjB5Apnz/GOfd4gJtIUm52St0giA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 03 Mar 2024 13:30:50 -0300
Subject: [PATCH v2] power: supply: move power_supply_attr_groups definition
 back to sysfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-class_cleanup-power-v2-1-e248b7128519@marliere.net>
X-B4-Tracking: v=1; b=H4sIALml5GUC/32NWw6CMBBFt0Lm25o+ABO/3IchZiiDTIKlmSJqC
 Hu3sgA/z0nuuSskEqYE52IFoYUTTyGDPRTgBwx3UtxlBqttqZ12yo+Y0s2PhOEZVZxeJOpEttJ
 lXVvXe8jLKNTze69em8wDp3mSz36ymJ/931uMMqpGh21btabC7vJAGZmEjoFmaLZt+wItcmoSu
 QAAAA==
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=NKt+UkOLuWhi5aE3dgCRuciCjstns0KT4TDC+oezDI4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5KW6AuKCP9OO95O9JKXM0jbTw9DDlZgi/jBkT
 c5XdnVsKveJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeSlugAKCRDJC4p8Y4ZY
 pqlUD/9UsTNQUj+XrgDjY0aF+/Yl0B+eq0VtRXym6azmv9ZfCA07H2x3D5wf3iAzZlq6sKYsuNM
 87MFrLpggeH005gVV3m2jX6iROOwcvjVITE4/pAQK4fkVEaUoSaPCHOoNVn9rv45h+50sGDryc9
 e7cBXlK2rAuUgGSkhTOSlzjFaIXmLjSmFh7vVMoaKB9hMPndg6QVEhWnXx6hUfrzr7Gpa9Z0GbF
 JmrR1yfWQujtV3iydhtoORdfLowjbKu7R/HTLpGXFdCczaucfUuuviDe12n544nVbt/zcsSh1wl
 1VckqgXALiGISwdM83AlLV5BtMW8D5ilATDZr334CQYGk6khsdlt/em3ELCUwHXTTQ91w18wn+c
 Mhd50XmEooV3YJkfE9IePfc2mWU4KEAEGx/cCNytCrlRy7SztqVLi8qXjaA1WLYNdy9qq84MK8I
 i2GnmARB1nLbfOyS3DEv89C5Dt6roNBt/FEfImLPTNVpoAGwj+8YzB27WfaNmrfutSfZLwlaGdG
 FtQMExajnY6Nwiv+1aQ8cpJq3fhIkckwSGrTEJcwAfSDUyOKmObo444W2CPKxkNUrXHeixLQy35
 R7BWSb2VmpYQtE9X59KRhBeHPgI7EYbpzcBBcFq/RJYJYNxX/llVrH0NTwvYjqzoPsfCOmzMCsk
 ncHLAnGfi3/iQAA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

As reported by the kernel test robot, 'power_supply_attr_group' is defined
but not used when CONFIG_SYSFS is not set. Sebastian suggested that the
correct fix implemented by this patch, instead of my attempt in commit
ea4367c40c79 ("power: supply: core: move power_supply_attr_group into #ifdef
block"), is to define power_supply_attr_groups in power_supply_sysfs.c and
expose it in the power_supply.h header. For the case where CONFIG_SYSFS=n,
define it as NULL.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Fixes: ea4367c40c79 ("power: supply: core: move power_supply_attr_group into #ifdef block")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403021518.SUQzk3oA-lkp@intel.com/
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Changes in v2:
- Fixed typo in commit title
- Link to v1: https://lore.kernel.org/r/20240303-class_cleanup-power-v1-1-6a3abb5b15ad@marliere.net
---
 drivers/power/supply/power_supply.h       | 4 ++--
 drivers/power/supply/power_supply_core.c  | 1 -
 drivers/power/supply/power_supply_sysfs.c | 7 ++++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 06749a534db4..3cbafc58bdad 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -17,12 +17,12 @@ struct power_supply;
 
 extern void power_supply_init_attrs(void);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
-extern const struct attribute_group power_supply_attr_group;
+extern const struct attribute_group *power_supply_attr_groups[];
 
 #else
 
 static inline void power_supply_init_attrs(void) {}
-static const struct attribute_group power_supply_attr_group;
+#define power_supply_attr_groups NULL
 #define power_supply_uevent NULL
 
 #endif /* CONFIG_SYSFS */
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 4f27f17f8741..0a716cc0f164 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -34,7 +34,6 @@ EXPORT_SYMBOL_GPL(power_supply_class);
 
 static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
 
-__ATTRIBUTE_GROUPS(power_supply_attr);
 static const struct device_type power_supply_dev_type = {
 	.name = "power_supply",
 	.groups = power_supply_attr_groups,
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index edb240450e38..bf725cbb0d86 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -389,11 +389,16 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	return 0;
 }
 
-const struct attribute_group power_supply_attr_group = {
+static const struct attribute_group power_supply_attr_group = {
 	.attrs = __power_supply_attrs,
 	.is_visible = power_supply_attr_is_visible,
 };
 
+const struct attribute_group *power_supply_attr_groups[] = {
+	&power_supply_attr_group,
+	NULL
+};
+
 void power_supply_init_attrs(void)
 {
 	int i;

---
base-commit: 71c2cc5cbf686c2397f43cbcb51a31589bdcee7b
change-id: 20240303-class_cleanup-power-7e25046623fc

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


