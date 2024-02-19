Return-Path: <linux-kernel+bounces-71423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDA85A507
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2921F24CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91938364A8;
	Mon, 19 Feb 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="DBQK3xkq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8D1EB36
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350149; cv=none; b=q51gJ3nGjramk0XEwb8wYPyBXtewwZFQfhBXhi0u98hjKXe40CxU3HHpfHIY9Q94AT0COpmgKYuOTylTGAy6AZ8dbhlxwiEFi6QwY8WLH+FaA4+Lisw24EDWalg1AjSeg8pnco2RTjdhwW1TrR/crURnckSo+zrrsxlVeVy9hWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350149; c=relaxed/simple;
	bh=7FYwAIqJPOo+/GNhw9YDi/8XPC844pxmvctdg+9ta9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RzjI/GQwdB1Ij+IST5qE+EBiscXjl+F+RVYozSrl/hcJOcS3hW8yXBYnlwyMgace0AXCwDiParun5i349UpW/fQj58zkDKUt0VTEwB+t5R376IcvL21VmuUJ09oWCQ66V5bfMAI9ScaDZVJHbEVUMc+6gKfvCVaomGSDmHHqh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=DBQK3xkq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbd32cff0bso10865935ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350147; x=1708954947;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hCbb91LZg17Wp1703NTIdkEmdQ7ht4A59WAeQFYJjw=;
        b=OiZlqsjQFPOtiGTiIIAX2qmcwQTipiRIlsx9SxI1mN/rnOJfGe+iuogY9sHJ4ML+7f
         Goyji4wgS8KT72cyGk9pQ/W0lvIMV75UDzW24rDsxP3PR0C0XYrwrVrnVbeX2RBkY3xF
         Tqk5gJpOBpd+VPuL4L3y31Lx8e+WYbNK+df8ba7PU5Aovr04LcI59NXJX9fN6EnQm4Gj
         oc7SrDSzMV+sWsiFFwTXconi5p8FTF+VyEz5q7z5H6o6z84gEtLmG27EPT6hVLU78Jc+
         gWPbDRXcHyaF7vrvkkheIBD2Za+XMnN9IUUXmJN1rvIsxXVMWDqiJuUPxWyozEQkih4T
         cqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT6JQnI9ZR6ZpDBammIkIQsBJbRyrtVnxOdsKc6YwxbSRxHHhwnVI/aiTkHIic1mwAuUjwYefB2jbFU9ySKmkfJOp2/MQQcCr1xUEF
X-Gm-Message-State: AOJu0Yw7NwOlaSJB8fwEZKS/lkxn/wHZd6JtTCadNiZo2zBbP6x+3Lx3
	mCSiFUbk/Sts4JxpBBnGPcmH4uuTux7WgnBvCO0IWqCkB8fpkPmZ
X-Google-Smtp-Source: AGHT+IETQMzry/WVWGmMnp3rDo6bPrY5Z4T7nBf0pZtQU2YmMN5jrJNX09QeZHmsQv0p44qQMCJdcg==
X-Received: by 2002:a17:902:f688:b0:1dc:16:8ff7 with SMTP id l8-20020a170902f68800b001dc00168ff7mr1376236plg.34.1708350146586;
        Mon, 19 Feb 2024 05:42:26 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001da1ecb05f9sm4350695plt.240.2024.02.19.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:42:25 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708350143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5hCbb91LZg17Wp1703NTIdkEmdQ7ht4A59WAeQFYJjw=;
	b=DBQK3xkqpHMHWH491e9teIneAjCYZkjvYWOaubRQtHUt5cRqTn5bwLWyVGLQuybXGV+p2J
	C+kwPdkn0AYWQfaBoIbEnRYNB+51D/rCL2Yn0hZPE6UoAQHnF08V5ea5et4OJUpMeQjh9l
	9YPAFkAXeXyDIq2TnAWO+ZcMcJhBSz83p562C1fqWMkC2yhfVhzlpchwj/HlHMZmVfuWgI
	uIizBENwhqbbIzZJd5iN9Cw2Y82nSMpzFZSi+j6ewaVCbjf0EQvXjiumodHIPOrW8SdNi6
	aKTmzQRzlExTXCoeoGOYFMhYyro19erZoMP3R2KMIieH9fsxrvya5hbQBI5bhA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 10:43:05 -0300
Subject: [PATCH] coresight: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-coresight-v1-1-4a8a0b816183@marliere.net>
X-B4-Tracking: v=1; b=H4sIAOha02UC/x2MQQqAIBAAvxJ7TlilDvWViDBdcyE0tCII/550H
 JiZFzIlpgxj80KimzPHUEG2DRivw0aCbWVQqDpUchC2SoYWs5MO1yFMTJR586dAXDWis71TEmp
 +JHL8/OtpLuUD/L73BGoAAAA=
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=7FYwAIqJPOo+/GNhw9YDi/8XPC844pxmvctdg+9ta9o=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl01rrr/LNihLyLmdZDrxO9VAzIRzxhqLl2rU1f
 0m3suFT1aGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNa6wAKCRDJC4p8Y4ZY
 pgTrEACQ+fnhj9eXHtsFbJoctmcQ1nI849nNR6aoCcnMCYWuzFaw6RW4RN5tLni8089P37dN4Fm
 ekerCZTGfmRMIHW8+YD5ZvZ6Uexk85lcjKgHVLGKh6kLndFRIZaeGB2tvZ4jJzSLtmCP720o9bq
 qdcZorHzp4caoh1kMP/URzeDcKb0dXFZ52kT8TIrz5Z26YHc2k8oPu0En7IoESCnNhLF1o1lsqs
 OCzPIc2OaH49chTQy7SGCMSKRSrdUEsYkpQp7KrY+VSLgxFYDXq98ZBK4cAC2Cjh2qhxYY/9KXt
 jbySorO6j/ueLRg742VDIUjkAbkkkiuNm9uQ/oWki5K7ffzCQoNLa1vSDU3Im/m+L7eQy3AyWHy
 EPVwL5e68dIXXdbnkl/4J7SFfyCBThpskCkqha37uwSAcfJjqCpF2UPSAhwoorbAWxM6wmXLSHF
 ZDWY48Do6NVNNRPT+oTT4sFDbCYYgP+YsaheEL6DDwpju0/H8zH7+yjO+evesoQw5g2DRPhCoVl
 EFdYNw9QYEzbC4zq1pjTX65JuO7PZ67/G4gfkRXFGgnuUxFS0HmHRbix0AMYB108ODu8XD/NWN5
 JMCNZUP1vDXrzqIpV+fmVNSGs0SzYP2oK6tHmiS1PMFD1hDrq4SgnOTWtuADpa10QA9sL0xCJV7
 ej0bGj92VKzrQEQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
coresight_dev_type variable to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/hwtracing/coresight/coresight-priv.h  | 2 +-
 drivers/hwtracing/coresight/coresight-sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index eb365236f9a9..ca3362cbdb70 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -13,7 +13,7 @@
 #include <linux/pm_runtime.h>
 
 extern struct mutex coresight_mutex;
-extern struct device_type coresight_dev_type[];
+extern const struct device_type coresight_dev_type[];
 
 /*
  * Coresight management registers (0xf00-0xfcc)
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index f9444e2cb1d9..1e67cc7758d7 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -377,7 +377,7 @@ static struct attribute *coresight_source_attrs[] = {
 };
 ATTRIBUTE_GROUPS(coresight_source);
 
-struct device_type coresight_dev_type[] = {
+const struct device_type coresight_dev_type[] = {
 	[CORESIGHT_DEV_TYPE_SINK] = {
 		.name = "sink",
 		.groups = coresight_sink_groups,

---
base-commit: c099fdd218a0fedfe87e0b88d2ba0667eab3b3c8
change-id: 20240219-device_cleanup-coresight-00ba00fd5f21

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


