Return-Path: <linux-kernel+bounces-151874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A28AB517
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9C71F21D95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5EDF9D9;
	Fri, 19 Apr 2024 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/+doOgA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE764F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551521; cv=none; b=cSLfH7/bMyCyXOvWCOUNNnK5xh5BTbAizeCGO10/NAxojJRWx0I+bKLy5XLe08bOcIC5wn46aUl4HrZ2JQYW6NvktHxKB2CntdkshbTy8z5QnWf7vEXxRUwH0+7JaKPCfaOQe4o376l/mYsAM6nJ/gB9cBaUEil+DMMNtq8O6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551521; c=relaxed/simple;
	bh=JRt4Lm5ijonc81uaOCYMEVQeoylykPHN4N8OAuA84c8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qSJhKm1ehaB9lIm5LcsgDBe48aiWMp/PTANAsGHdYr2XufMU2MVrZKeDMn8PM/0XEmQNJSNjNisYtdShAjCmJ0PIAaB+JUMV43YWN8HDcTnw9dJ6Qk9jKw5rOV+ImcjlAFombqrVdNTkOs5WyI7GrCoT9e5jbvV2vAT1h6vGTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dtokazaki.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/+doOgA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dtokazaki.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b13ce3daaso52473357b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713551519; x=1714156319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAJdb3eo33tTVB58hEyGtBn/dOgeujKwWfoeVeHgqQo=;
        b=n/+doOgAv0wagV3viCNegky/qsYg4haiWyNUv4m9GKxGaWhgta42RzKDXCo44FMzsv
         jXRRMeBTugphfLpTZs9+BcgkuvgnYffCoCTW+94hvOAKbS8ZMfLkg2qO3atD13fr1QyY
         l1Bq4lZU7Kh90q1ACU4ho9AdKYOo2HZtcFsUk/U2lGEABf8kqk9RKi9TDnsxna5NSzF9
         Lz7jTtPJI0ajutBLqm875ruvy+jMcMdRsBpjxGsXzRFOkKu6Bd2pUITgpyNkHUguRpN8
         jSlp2z8Zhjc5zV4zj0XvXvr78XOU2/2fgtYShJi4jfvlWUsCbmvVpTeRI60iBSpRua8B
         a+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713551519; x=1714156319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAJdb3eo33tTVB58hEyGtBn/dOgeujKwWfoeVeHgqQo=;
        b=ANBovv/eCslEg4DYCrpmLVOJ7yJvV/xqy/tOruKgsQ9IUjkWEP1/bNxAVlhXh1NY7o
         jfFDuHyYOmgjPedkKK8LOhdGvlhyyfy9S5/AqBJxR3qYKTPuh8HTCqV+IOaImCXlGJXG
         F46pgIjraLg79I8rjupB1DqTaaTp/8L+eP/SrcqhV3L4e36hOjMDuxDbnnqHtntyQJ0o
         xWAjl9wENxWfNwx72zBgdzTZqsrSx82xqU72VNubK3im/5358YJjRL/9mzVRxEQNMNhe
         TBO0rGUjp5kBFTlBWx4BnEhrx3Bf2Vxv945dg2bqO6XtY/VltX6mVZqz7yKOvPm9Giru
         +baA==
X-Forwarded-Encrypted: i=1; AJvYcCVINaMQGY2ArHELCcJc1t+HcuAJWPUw2pBeh/ws2aynKOw0nB4U6XUkJd2qMSwsxWR1oZ5p1qdtG7skSJ9OKeiqRFlyqD8J/TpliFkI
X-Gm-Message-State: AOJu0YzweAM8VlRWo57I6vqR2Qhh5iKehZ0c+cvU/2WUow/mNsMI4Ax8
	ErAm05UwLyMc9OZEOTZLF4mUVwi63mMD+iBncOLyTiCijBtqu3xT9+JT1hA6UwCbpkX7CM7nj5/
	J55JLl7TfWrIPmA==
X-Google-Smtp-Source: AGHT+IH5CvUvdzIhwaJXD/StoRkGTbe4OvjJqoxUYPbnzdoniCeR6wNeea2/WyC8WEAYTC9DbFYXBcOHLQnz1Vg=
X-Received: from dtokazaki-pixel.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1a03])
 (user=dtokazaki job=sendgmr) by 2002:a05:6902:2b88:b0:dd9:1db5:8348 with SMTP
 id fj8-20020a0569022b8800b00dd91db58348mr804205ybb.8.1713551519146; Fri, 19
 Apr 2024 11:31:59 -0700 (PDT)
Date: Fri, 19 Apr 2024 18:31:41 +0000
In-Reply-To: <CAMRc=Mcb0uAjUBOKraLaev_xU+3OObj9YJm1Yq2A2s2bZOViiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAMRc=Mcb0uAjUBOKraLaev_xU+3OObj9YJm1Yq2A2s2bZOViiQ@mail.gmail.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419183142.169963-1-dtokazaki@google.com>
Subject: [PATCH v2] eeprom: at24: fix memory corruption race condition
From: Daniel Okazaki <dtokazaki@google.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Okazaki <dtokazaki@google.com>, kernel-team@android.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the eeprom is not accessible, an nvmem device will be registered, the
read will fail, and the device will be torn down. If another driver
accesses the nvmem device after the teardown, it will reference
invalid memory.

Move the failure point before registering the nvmem device.

Signed-off-by: Daniel Okazaki <dtokazaki@google.com>
Fixes: b20eb4c1 ("eeprom: at24: drop unnecessary label")
---
 drivers/misc/eeprom/at24.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 572333ead5fb..4bd4f32bcdab 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -758,15 +758,6 @@ static int at24_probe(struct i2c_client *client)
 	}
 	pm_runtime_enable(dev);
 
-	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
-	if (IS_ERR(at24->nvmem)) {
-		pm_runtime_disable(dev);
-		if (!pm_runtime_status_suspended(dev))
-			regulator_disable(at24->vcc_reg);
-		return dev_err_probe(dev, PTR_ERR(at24->nvmem),
-				     "failed to register nvmem\n");
-	}
-
 	/*
 	 * Perform a one-byte test read to verify that the chip is functional,
 	 * unless powering on the device is to be avoided during probe (i.e.
@@ -782,6 +773,15 @@ static int at24_probe(struct i2c_client *client)
 		}
 	}
 
+	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
+	if (IS_ERR(at24->nvmem)) {
+		pm_runtime_disable(dev);
+		if (!pm_runtime_status_suspended(dev))
+			regulator_disable(at24->vcc_reg);
+		return dev_err_probe(dev, PTR_ERR(at24->nvmem),
+				     "failed to register nvmem\n");
+	}
+
 	/* If this a SPD EEPROM, probe for DDR3 thermal sensor */
 	if (cdata == &at24_data_spd)
 		at24_probe_temp_sensor(client);
-- 
2.44.0.769.g3c40516874-goog


