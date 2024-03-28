Return-Path: <linux-kernel+bounces-123617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D69890BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C71B22908
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9404313AA38;
	Thu, 28 Mar 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEIVrGPf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603013A250
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658759; cv=none; b=ex0Ez+5YP/2ByQHNrRPvKSPlJmEY8pg153gQbilRyx1THHy851y6HRg2QDJw80d3+oXv1zIqL6os0rjdVGotJvrWGiObAx90eMO62Cc7Qgsg/0nblwFROJ4M6MlhkgicTmDdFHM4Yus7gnU+AsjTVGbreJUSfwaPwvtZVkChUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658759; c=relaxed/simple;
	bh=8u2WDjTPHdiEZkQDrWw+W3Bt81pM6qe2dZqzxwZgkAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XF3cIY9h/efy4u8hFnj/K00Psl2yZGudFQKRgbiRVYB6QJgdfn5I61jbo0ncANBfMm5y9EPw0d0OYytEmE6jBvrm/Cjd0YhmrZXHb64R+D3LrVOLc2Lei8Z/hdEqXcbAc+cYSXsCNH/mLgKw2mvB+b8rXs1fXQTEooS8zg2besg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yEIVrGPf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4149529f410so13195235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658755; x=1712263555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnMf7iflmd0eRFCuZh+6Vo82Oor0YqJaFDCJo+pzSxI=;
        b=yEIVrGPflRB3hhBFIciS/Qb2zXJIzgNVLMHhcvBOPAuWJhvUuFscbVtxiSvoz5mbXl
         IO0AvCf3Gw8gFs533X6yQuoXuSwZCmUgZvLdprARXEM3Fdmq0atVAjcOY/cz6kulRFub
         h0iRUlXyvqpCOlCroTw1jV02WTXXohsDZ3PVU8VSYYCUDFVeaMDnZn9MQTgIsoNElDMB
         YSwWizO7gl6RoHo0t+fOjVGkofR/QLFV4Mx0ZemhCKOwwQb3BcsfEaUrhDmEfBpbUPOk
         P2s33m+o/rmqpOeWB4lHeN8RH6iajPVvciizYDtTYNOc/D2VzAadKf4z3rP6km6hDgQu
         DBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658755; x=1712263555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnMf7iflmd0eRFCuZh+6Vo82Oor0YqJaFDCJo+pzSxI=;
        b=s4BIsDGS6TzGKOv679gosBSf0d2P8UwvAEa5+T0gtHV1TfXBOc2EiQNViCUBqQ5FD2
         qk9KBIOtVOea9dfPYRCJk0fyXXkqcdrYIZHdWRejhmASRu9ZGm6WVS0HGGom2IKeyDSY
         9Jv4Fv+MIX+wbKhB665HDu5VGTkhuopDzlA9yaCsgg2AjYItgHLMQPJ8YYLbN/KGCQQZ
         m9yVtG7k6ZcG3vroeuOawup38bghxLpKFcXPoCdqmzD8tUI/cEgRD9X3kBjXbgWuZwmc
         hHga3i9ORBr27XShTNLswh7CUcCPPH4FA7f4xQnUYWKwjkwsx/AKVmSLoOZY+xaCq8TJ
         KT7A==
X-Forwarded-Encrypted: i=1; AJvYcCWaEQp7pTPaw+/Q8CgIyWGd2Eu4/NfUphclt9yvDFQ4AG0wcPYeKnNZNbYaMONb+hQLdxuAXHj8U8kfqn07atA/3Y77PZg4ArowLScI
X-Gm-Message-State: AOJu0YxR5WLCNImNzL061aWT/fSW5CVakZCeC5VjuHTAEhvIOy8iR2DS
	M0PLMzX2ET2s3A6llq8OspCde7khBsBMidWmN6rCFJMnxKyjiH1wulf9OQHbdaRYLjnylAWQTky
	p
X-Google-Smtp-Source: AGHT+IHX8dkhxy+KLMF2mKTQbUgIqs5VBRngtLE1PyFZfF8keCYuLSvcPQLZgj8Kj9ueR6bizS5sSw==
X-Received: by 2002:a05:600c:4fc3:b0:413:ff13:cd8e with SMTP id o3-20020a05600c4fc300b00413ff13cd8emr465013wmq.5.1711658755444;
        Thu, 28 Mar 2024 13:45:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm4762697wmq.12.2024.03.28.13.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:45:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 21:45:45 +0100
Subject: [PATCH 1/6] scsi: store owner from modules with
 scsi_register_driver()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-scsi-v1-1-c86cb4f6e91c@linaro.org>
References: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
In-Reply-To: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8u2WDjTPHdiEZkQDrWw+W3Bt81pM6qe2dZqzxwZgkAQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBdb7RfbHlZVhD4z3IoRhL0zEc1KJddr3qXf1f
 2BE9AgbUwKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXW+wAKCRDBN2bmhouD
 13gWD/9ibeYZZ3UG9aQJBbeXDB4qGQWLd2z9xYCBUfU4PVF4Hgf6308iUR1Su97JeKT6QcYoQ8i
 W/Ea7vRm9SF7O/fAh2r2ScTc3Y5Pkc554JYmThKxhAZGP8OFPG1VnZXjFAhMeJ5ZhUTRNNwOOi0
 12JTxk9lBstd+u7ePKorWdcffKZ/uioEor6ts/Pw4qP2wVztvHgX0XlxJn50qWK2NP50Ptd3c4P
 LzwRzcn2q2cCPhAHAidEPgmmnRsJh83UeueIScgDQkVr5VFEn5Y75ely/ZyZjvjJ/5vAmVKiJUA
 PRG/D4ljdHrTAuxPZbptRlwcphDjBZ3Pws6Exe8mxMbCw34dBcWcCIatjaShNw0coCoal2bWpz+
 0Yf+jKr8tPZjBGuqskTJRXxyiLPkCkKeYE83FAzEBTjBYG0V+INlvFYwEoUuOmyBDMyW+Vo9ME6
 hy3PEVfMaYeHL/TS6ig5p63eOCXVvnXOUos7yiNeVqDkLq5Tqes6Vji3URNMSiwRjnp/yYtILv9
 T/UA15GDlkrRyVfyQDMrpiqtOJ5lWttmEQD0uaK/JdyXrdCO0MnEgU1yq0KINFF5zVp3vCHSfQJ
 C9haXIhLSov+9HN5esOfuyxODIkBlDGBGuRfQvrBIX+6LtV1j1lzV1WjlVwwYOZH6L+DU81ZVxD
 nGyL6JlZylX+/qQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with scsi_driver_register() might forget to
set .owner field.  The field is used by some of other kernel parts for
reference counting (try_module_get()), so it is expected that drivers
will set it.

Solve the problem by moving this task away from the drivers to the core
scsi code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/scsi_sysfs.c  | 5 +++--
 include/scsi/scsi_driver.h | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 775df00021e4..b5aae4e8ae33 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1609,13 +1609,14 @@ void scsi_remove_target(struct device *dev)
 }
 EXPORT_SYMBOL(scsi_remove_target);
 
-int scsi_register_driver(struct device_driver *drv)
+int __scsi_register_driver(struct device_driver *drv, struct module *owner)
 {
 	drv->bus = &scsi_bus_type;
+	drv->owner = owner;
 
 	return driver_register(drv);
 }
-EXPORT_SYMBOL(scsi_register_driver);
+EXPORT_SYMBOL(__scsi_register_driver);
 
 int scsi_register_interface(struct class_interface *intf)
 {
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 4ce1988b2ba0..5c6724322112 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -22,7 +22,9 @@ struct scsi_driver {
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)
 
-extern int scsi_register_driver(struct device_driver *);
+#define scsi_register_driver(drv) \
+	__scsi_register_driver(drv, THIS_MODULE)
+int __scsi_register_driver(struct device_driver *, struct module *);
 #define scsi_unregister_driver(drv) \
 	driver_unregister(drv);
 

-- 
2.34.1


