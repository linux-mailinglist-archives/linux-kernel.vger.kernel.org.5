Return-Path: <linux-kernel+bounces-73519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB485C3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC92B20E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B74D12BE85;
	Tue, 20 Feb 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="TdHKfil9"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F376049;
	Tue, 20 Feb 2024 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454367; cv=none; b=IfFb2YDm/ISEcdvX4M3f+PoeKBUsadzTZjj1cE73V99fcKO3EKtfzPwGK+wYWACl/m7Uri41qyeRlmPoflW5EnMpcq5Qckzk2VPkYuI4Wm3hqPC4hemC+v2jI+2HWuSQEFDbXJxY89+N7p8fMR5LSu5APAMJ51xiIZT6+E650cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454367; c=relaxed/simple;
	bh=RLMGiWwHO3wu/d8qyryVub6v27yu2bfWSyVW8TUtiX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e5H9DaX8g2HGAeJRVLcoSzVL6yL0aIzI/iNhNOzWdhpVJHQhvIUsqCymeFSOtMOkda1fGLD0S1jfg7L5tqcBHZX8mqNP0JW8Vd9AVjYXB4jNKt1L/0KYztsgKJ2IsN7Vy3NVWW0Gne+e5EE7HzqJN5rIHc3Zh0QxhlOQMuguiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=TdHKfil9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e3ffafa708so2736609b3a.1;
        Tue, 20 Feb 2024 10:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708454365; x=1709059165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE+/W9O0z0Se+agZSQ5edJ7WLn5M+Kf6aszL/I8gUdM=;
        b=oog1HqygCFWNNzFVhru6BGhbY70Ct22TMp8bCE2cFeZnWNDVWsA3HOD1boNLl9lFdf
         DEi+Nct1cd6bzCaJ2hDnQd24aH/p1IjfHLuoRoHXf5aPRA49+8kL/dJgnVoq/GU3oOCQ
         sTnOEfRNPlsvRySBED+yqit/p5u0l/7CtxbW47cGuckxS3azbT6qUXbPlEaba+cPVKxC
         eJNg6ZK6lxIX18PswyyyzOQWnJo9dF0fi5Bua1hjEWpcFtP6bNOQGZwS/v87T7eG3bNC
         EZF9V6Uu5PCVy1L/q25DDLUpwHabm0wfAE7vAdZInSNYUZrTE+jUAUKEL152wu0saB3o
         xdKA==
X-Forwarded-Encrypted: i=1; AJvYcCU8V/or59mltuf4U/lvCPzjinhyekM8+rDqEOgQGnlLLxi6KHX73w8HYuLMhamvB4kRBCS//G6q1/5ukro11Gx4TPrnbLEs5tIbsheU
X-Gm-Message-State: AOJu0YztYgMcPlmIsu9LtJXWDMcsNYdUQQu1UJL/q4yo/heUvUiM7fAA
	tzzyBYMLfMYcpBf8VmiSss/j8I14wt0JjLyOFJ6xXdItUUK8WAuiTI/m+zscwmuWIg==
X-Google-Smtp-Source: AGHT+IEqTlDv7o2qtWX3Uzih5W9hnWyS/hJkNg9+LTeH3IqK3bclya5cceU19RTa4UZc4qpQ1SzGNA==
X-Received: by 2002:a05:6a00:13a2:b0:6e4:79af:78dd with SMTP id t34-20020a056a0013a200b006e479af78ddmr3685083pfg.10.1708454364525;
        Tue, 20 Feb 2024 10:39:24 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm3951370pfv.132.2024.02.20.10.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:39:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708454362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FE+/W9O0z0Se+agZSQ5edJ7WLn5M+Kf6aszL/I8gUdM=;
	b=TdHKfil9rRmNE+dAusoHFKjfpzN3rXJeRMWQw9q1i+MBujn0GEoLySbzY8/8ljh2X0KvRg
	UDCMUAfwKcnOCnE+ugkKBGxKJfR/DDIHg1/CiIBeAWhcp6OlCo6kiJc5b+aSgA4hBL7uLq
	xXFQZeGs+1ocBFV7YktdAL+7pqM/z8cB51ucHBPDiE0cddRrzjxZJ0++6tKVgZdOOYbwYP
	vTmMz3qjSnYBd71Ndv6/JLi+QPs1K0rhIfLW3h2eC0caZrG0+70FZIFV57iAgscKQBNqL+
	UpM8n2e6lIVzZyFouYHCT/cdMJckN5KtsVaz/DKebYcgAEFFiNhL2rSbaMdNgw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 20 Feb 2024 15:40:06 -0300
Subject: [PATCH] power: supply: sysfs: constify the struct device_type
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-device_cleanup-power-v1-1-e2b9e0cea072@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAXy1GUC/x2M2wqAIBAFfyX2OUGtiPqViDDbaiFUlC4g/nvW4
 3DmTISAnjBAX0TweFEgazKIsgC9K7MhoyUzSC5rLiVnS5Y0TvpAZU7HnL3RM161TfftehaQr87
 jSs+fHcaUXp14iX1mAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2865; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=RLMGiWwHO3wu/d8qyryVub6v27yu2bfWSyVW8TUtiX4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl1PIH8wC8dNgBQ8wGo+ymYdpnemsRFJ+kshlDL
 OB1mg3zKkCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdTyBwAKCRDJC4p8Y4ZY
 psSSEACmiBWM5y1nQ1hSMVEZgiU1WcFUzmciOnfOgHhEWV6W6xvxnpwlEpFSbObG5O/zWiuA785
 bbvLkA9S22fTLRWztRy4trsWKFznqJrrFXVIdkqd7/iS9zjSkk1iv/dpUyJk+ZbZqnhQ62pBNYW
 Us9zDOWS7kDUaVoA+T694obh9r5gvWYT3SP96mDNdDy6qj198OwCqFDNenRUWSRwbb44bWaqXN/
 hwXwqCLdmp68utTuHgK9jKaf9y28URMikZ6JI1QIj013tIDr5O6sn0cbChcIF+Ww2BoNx1yHqcJ
 fWbifk1cVLTx5FeApvwWKNbbchCOuS1SjKdGXc31btklUDXQzmOZOzStOABFQazLGYLjIpPfaFH
 JEA1HODuxgoAwt/xi073pY3ncYR5X2frz/UgVciVz8B/j2Noks+elVTS0XH7S1soL6BAqSXlCMt
 6oPXBQxKOpcRQ9TIRxNAqp1LV4xbAzJiAJZzfwjY1NkaMmboAYbh9wllFDt8kV7iUUZ+E8om9KU
 ttsZ6TXBcq3rPQQ5kIt7AJ61paXvT5X8ncd0GHZrAZ+eH7DxU68cyTNentUH0e+sYyLOiswmGwP
 aZLOcsAt1Y9dXUCU0IlIY79uqJA+MRmtIJiJFZhT57WipVL8btnTug8ica4LSqagSqOXdEsCi1A
 L6QjQCxHCsBThkQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
power_supply_dev_type variable to be a constant structure as well, placing
it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/power/supply/power_supply.h       | 4 ++--
 drivers/power/supply/power_supply_core.c  | 2 +-
 drivers/power/supply/power_supply_sysfs.c | 9 ++++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 645eee4d6b6a..d547dbe5676f 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -15,12 +15,12 @@ struct power_supply;
 
 #ifdef CONFIG_SYSFS
 
-extern void power_supply_init_attrs(struct device_type *dev_type);
+extern void power_supply_init_attrs(const struct device_type *dev_type);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
 
 #else
 
-static inline void power_supply_init_attrs(struct device_type *dev_type) {}
+static inline void power_supply_init_attrs(const struct device_type *dev_type) {}
 #define power_supply_uevent NULL
 
 #endif /* CONFIG_SYSFS */
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ecef35ac3b7e..fda21cf4111c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(power_supply_class);
 
 static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
 
-static struct device_type power_supply_dev_type;
+static const struct device_type power_supply_dev_type;
 
 #define POWER_SUPPLY_DEFERRED_REGISTER_TIME	msecs_to_jiffies(10)
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 977611e16373..ed365ca54c90 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -399,12 +399,15 @@ static const struct attribute_group *power_supply_attr_groups[] = {
 	NULL,
 };
 
-void power_supply_init_attrs(struct device_type *dev_type)
+static const struct device_type power_supply_dev_type = {
+	.name = "power_supply",
+	.groups = power_supply_attr_groups,
+};
+
+void power_supply_init_attrs(const struct device_type *dev_type)
 {
 	int i;
 
-	dev_type->groups = power_supply_attr_groups;
-
 	for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
 		struct device_attribute *attr;
 

---
base-commit: a9b254892ce1a447b06c5019cbf0e9caeb48c138
change-id: 20240220-device_cleanup-power-037594022cb1

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


