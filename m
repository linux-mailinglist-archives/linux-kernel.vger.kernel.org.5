Return-Path: <linux-kernel+bounces-2216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDD88159BD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D10C1C2179A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447932D7A9;
	Sat, 16 Dec 2023 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMt6dNjo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B82E3E4;
	Sat, 16 Dec 2023 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so15596335e9.3;
        Sat, 16 Dec 2023 06:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702735691; x=1703340491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boz+TP1F4hq71dR77EFZhUrU1ZssTFg6OVTkWtZ1m1I=;
        b=eMt6dNjo5MC1r8v+s88Jv3QxjmVSrwkO1H83b+s3KCGZkVC7YpaF77/5GkeCLATqiB
         bOZuofx2zslFoTuKayCecF0WxvCRZFTi7lngrBIeotaVNAoY3/jXZspZE0ZzDZshQ2+J
         tLDSh6cvmZXo75+Rj0XIgnR/e+aHbMowNXchZ7OocYp9O5zwYwZ1jz/d8niJzG2naqt0
         wrIi80prR+S73elwgmloRFdORRtjMWAMtqLGBpP5WhHdDnM43/Hqf/CVuE2L5RGJEdQ2
         BWDsYClYwBijRnA5Vt2K+l7Jl0RvSZjucsnqkfIda56SdQUZuJ4SWIEMRjozy9eCnz22
         zqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702735691; x=1703340491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boz+TP1F4hq71dR77EFZhUrU1ZssTFg6OVTkWtZ1m1I=;
        b=vnCIV8Ni2KFs8m6o6paiQJPWghj/2jDMfEOrjbTzNlS1UOqd7NyWNsOJKn6jONcyh3
         zRZIDNgurQ3rLxOa7XFpFjBkFTFFTQyAIkPF1TOlRVtwEaYgFijkh4rGXkaEiyn0iaU/
         ZOZJ7ibXHtabZeHqKd5uHt7LbA9orlxrvJ9My6diRQoVgfwjvW3QLqQiLPwtLu2b+U43
         /8zZdCQJiXNbkIhN/ASNZgXm4BFNt8ButA7rrsLKNRdlp8t+N1zjb57GmMQdkTLFAw4r
         W9MDWVaMIXXJUOjlshs41ciKhT+o9Sm2oenzeu+QqCVnYsYB0/9kIT2mPBm9v9EUpWj6
         3k0g==
X-Gm-Message-State: AOJu0YyHRiTem5/L/nIGmp9V3tCgthrq2jfIvBs/uZGCxr5/Pwi2HT1P
	g+elci/dWRj4/ToapBJ/lKl24++XJCVBEg==
X-Google-Smtp-Source: AGHT+IFQlbS1IM80kd0gYkG8mvQ+gd+mF9wTnUM++N96cQjTV3F3rNw+SHf13se66azAJJ5/SHK/jw==
X-Received: by 2002:a05:600c:6028:b0:40b:41c8:f414 with SMTP id az40-20020a05600c602800b0040b41c8f414mr8740011wmb.31.1702735690995;
        Sat, 16 Dec 2023 06:08:10 -0800 (PST)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040c57e4ea28sm16923087wmq.17.2023.12.16.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 06:08:10 -0800 (PST)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Remove unneeded CONFIG_DEBUG_FS #ifdef
Date: Sat, 16 Dec 2023 15:07:54 +0100
Message-ID: <20231216140754.336775-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the #ifdef check for CONFIG_DEBUG_FS and the empty variant
of aqc_debugfs_init(), because the debugfs functions already do nothing
if debugfs isn't enabled.

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 4fdd2e12427b..2efe97f8d003 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1476,8 +1476,6 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	return 0;
 }
 
-#ifdef CONFIG_DEBUG_FS
-
 static int serial_number_show(struct seq_file *seqf, void *unused)
 {
 	struct aqc_data *priv = seqf->private;
@@ -1527,14 +1525,6 @@ static void aqc_debugfs_init(struct aqc_data *priv)
 		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
 }
 
-#else
-
-static void aqc_debugfs_init(struct aqc_data *priv)
-{
-}
-
-#endif
-
 static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct aqc_data *priv;
-- 
2.43.0


