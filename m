Return-Path: <linux-kernel+bounces-25965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5D82D8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B09F1F220EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BCA2C6A9;
	Mon, 15 Jan 2024 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixcdBepZ"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87142C68E;
	Mon, 15 Jan 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a2d348d213dso188305366b.0;
        Mon, 15 Jan 2024 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705321400; x=1705926200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LarulzgxcbwxwMwttJUnIYJyEcTaGKlC8Ey3INSXxHQ=;
        b=ixcdBepZq3a4yNBnHq3yPGlJeBMLugEEEbmgiavFBErslr85ET4OyfbHEDHYw1G/1x
         rc75+GJZyUJcItXIEa3gvpIedow/yFDd/8xpUq4WPkWdNBWhEgyM8JcOo8r2QsZF14pZ
         NMoKxyrLqRX3Rz5BNjoOqqC09ehN4leTFmTezopgvnLkbAkTBe231+r+BrFNdU9JA/aa
         kTILGwOXjX9CdxJcdj/PMUFX0HvJlQjDAxnlLp1GCrBscTwTHTAzju6uq7bxTfLLKIXE
         ydZRFYohPy13etIn6cX8Fg+QkJApswwEG5ln+EhpPOwQAaTMEpL99IV/WKV7Bjv1a88U
         jBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705321400; x=1705926200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LarulzgxcbwxwMwttJUnIYJyEcTaGKlC8Ey3INSXxHQ=;
        b=jXwCb4W+sf8JVVmPqoQqYKNyqzctL4v91OMikZt0LwGm7dOgglfL8LrxbLZi+D09rM
         ayqgpQsfFHOTBd/qpZ6W8zTD7YbB63UkCBwJStX7Apt6zr5a16RFDLdrm/ZFf22PBDyg
         XTT+xLK2bIbbhn7RUA4eiE2jSM6SVxF5jJ7hpovvYqSOFnBbcPWk+I7TWRjRYxf8Aftn
         7zp/p4NTd1+f/i/BEtfI1Y8IvGZf6g96ItYFyoJLv+NnUnYEaEc5UBz/0HLMkGPNjZbd
         2LUt3mFhQEae/j62BM/ExJlYm8UpTf98gWLrK7FmscStF8S/OyhkQ3oVlHy928MZokBk
         ACww==
X-Gm-Message-State: AOJu0YyQUu5xdnIvdxJFpz7DI74qkzYZC3vYwvUqEcF6X2iAPbuaPDPv
	mOBUOI8UP8NhTzsS3ez5u1w=
X-Google-Smtp-Source: AGHT+IHnFmjVSGdQH/6aGKNzNrldzt45MI0PLo4psjK+odaj0QL3QAgqsovGDwOvcpUew+6PTPcN2g==
X-Received: by 2002:a17:907:c00f:b0:a29:4267:acc with SMTP id ss15-20020a170907c00f00b00a2942670accmr3185133ejc.104.1705321399757;
        Mon, 15 Jan 2024 04:23:19 -0800 (PST)
Received: from localhost.localdomain (nat3-minsk-pool-46-53-181-207.telecom.by. [46.53.181.207])
        by smtp.gmail.com with ESMTPSA id st6-20020a170907c08600b00a2ce3230351sm3766988ejc.37.2024.01.15.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 04:23:19 -0800 (PST)
From: Andrei Sabalenka <mechakotik@gmail.com>
To: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	acpi4asus-user@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mechakotik@gmail.com
Subject: [PATCH] platform/x86: asus-wmi: Re-enable custom fan curves after setting throttle_thermal_policy
Date: Mon, 15 Jan 2024 15:22:17 +0300
Message-ID: <20240115122315.10250-1-mechakotik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When changing throttle_thermal_policy, all the custom fan curves are getting disabled. This patch re-enables all the custom fan curves that were enabled before changing throttle_thermal_policy.

I believe it makes asus-wmi sysfs interface more convenient, as it allows userspace to manage fan curves independently from platform_profile and throttle_thermal_policy. At the kernel level, custom fan curves should not be tied to "power profiles" scheme in any way, as it gives the user less freedom of controlling them.

Signed-off-by: Andrei Sabalenka <mechakotik@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 18be35fdb..c2e38f6d8 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3441,13 +3441,28 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 		return -EIO;
 	}
 
-	/* Must set to disabled if mode is toggled */
-	if (asus->cpu_fan_curve_available)
-		asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
-	if (asus->gpu_fan_curve_available)
-		asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
-	if (asus->mid_fan_curve_available)
-		asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled = false;
+	/* Re-enable fan curves after profile change */
+	if (asus->cpu_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled) {
+		err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_CPU]);
+		if (err) {
+			pr_warn("Failed to re-enable CPU fan curve: %d\n", err);
+			return err;
+		}
+	}
+	if (asus->gpu_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled) {
+		err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_GPU]);
+		if (err) {
+			pr_warn("Failed to re-enable GPU fan curve: %d\n", err);
+			return err;
+		}
+	}
+	if (asus->mid_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled) {
+		err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_MID]);
+		if (err) {
+			pr_warn("Failed to re-enable MID fan curve: %d\n", err);
+			return err;
+		}
+	}
 
 	return 0;
 }
-- 
2.43.0


