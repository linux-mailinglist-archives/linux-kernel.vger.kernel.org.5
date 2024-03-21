Return-Path: <linux-kernel+bounces-110174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B2E885B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE6A1C21727
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9048624E;
	Thu, 21 Mar 2024 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqezg+lF"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA258528F;
	Thu, 21 Mar 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032365; cv=none; b=tLvNXTxAQHzNmPKUCQoKEoPLs/2ejx3uzzghQ2MNKw0SIVU0WZYAqdUTot/8e+v0bIqeoxhQgJ+mZTU4rqK7h2oFxwfkdwwrsDL6E7LaDo9Z0+X937QDHhODZTScxaO7M7c8pyqFTOLdLAm/STfi7G20wSYjYUfBZt2qs4ISwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032365; c=relaxed/simple;
	bh=aGM/BjIMhOpdAbKdAUNV6UdCyMRiKpIXa6CNByFD57w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGntbWYqz7kcaApg8pltxvAALYmOHyXLO3pPD87oc15rhSufBF99JTGQPSHHdQnLuOhH2KmnPXvZ9jRymyDKrit7x28AzGlwYSBF+SUluspRQRq52peJjXOWs/QvQTDRbVCBNGeek5pbOtYwNZkg/OEqctievMuUKb3Xfj7+Ceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqezg+lF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41477211086so3520505e9.1;
        Thu, 21 Mar 2024 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711032362; x=1711637162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kmM1IqHsbIpNzWg9iW5UOYS59eD3JNfeSOGpqW3Bng=;
        b=lqezg+lFWft8mW0zITtCGmSPjwi5XEJ8JHupQXSBePMM2iRY/PjhLCDVoAttSbdwUS
         BfiEJ2zOL36usDjd+NtJ0vhnRV9d1DH/4djVJHlr40zg3n3ZEa1B+WhWth21E5ZxsJAG
         wWLa5weTNnEOq2ZnIAmIbPbR7boDVy3ZV+IADyE9VRHgUTSG04DmRMSPK1lilcWgtRg9
         p+PUHDirjU5wNcRbLh4ursIV6APhC2sjRf/H7rFz19SDQgatSYODbk7HJtPaUnuKIvAT
         FPj7iLtNfORDzbab5Z7IMo6PgE9/is17mZ32KrImqhiWrUF8E/ZyBsrBgnZzSusVn8WN
         FNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032362; x=1711637162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kmM1IqHsbIpNzWg9iW5UOYS59eD3JNfeSOGpqW3Bng=;
        b=YG2T/Bk6X7z/XSOSLFqwoqRR9ZtWDTV0aZRCdleY4txJVzqYVGhwGQAfSEFki+LyaH
         kxqb5KQbTe881S5yVzu3K2Ngt7ZnyA7rkM6JMrguVyOwhFnOuMBBsLJ5WqflqFVWoAH+
         IAMYIYslfOL6Jli5tbskdq3O9A7rH6n7yZgvf0DqP8J06dUw+7hAV6lwgiJSezumlAc/
         NSfBf17YnO3EZB2ZQ7KILhD9qmU4FovuptmL9Y3Qs/tSnHZjyczQRQMz1MstucDCyPVG
         6YdXL9u20V+rJYUoFpGKsOwbWUdhK5GRMha+zIxZYIW2/JiDM1+qLWKe7Lr2xip4zPvB
         MtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnRDJKbN+wT2b6ULT6p0Mk+C+miLLiJm9yB4g6qRoNfKIgaTYTBjS3K0ZfylBDbTPsEKKiQVO4pGV3zR2mo6gd0CFqlsM13FDw0PeUu6kIlvq6Nsdr1QBhqxo7cap7LroacsSWZvuvGDU=
X-Gm-Message-State: AOJu0YxBv3YvHgs7sODn/mc7UPAnZbc4Hx9Z0kUmxBBMgUp53cskdqr5
	WrcyUpXRznxgZZgpqsuXbNUrlS++YYnF/zuWSRpgy7jV3AG3PYPgU6/hMfUj
X-Google-Smtp-Source: AGHT+IGPx/PP/oaB4TGS5GkIshYADiFWEg06SznTyDFb9IQ3swToDyMfqMoNnAzvfiAJhGPTDTfIGQ==
X-Received: by 2002:a05:600c:19d2:b0:413:ee55:8bba with SMTP id u18-20020a05600c19d200b00413ee558bbamr2135209wmq.4.1711032362170;
        Thu, 21 Mar 2024 07:46:02 -0700 (PDT)
Received: from fedora.. ([94.73.33.46])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm5253378wmo.36.2024.03.21.07.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:46:00 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 2/2] HID: uclogic: Expose firmware name via sysfs
Date: Thu, 21 Mar 2024 15:38:05 +0100
Message-ID: <20240321144553.262409-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321144553.262409-1-jose.exposito89@gmail.com>
References: <20240321144553.262409-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some vendors reuse the same product ID for different tablets, making it
difficult for userspace to figure out which table is connected.
While matching the device name has been used in the past by userspace to
workaround this limitation, some devices have shown that this is not
always a valid approach [1].

However, if userspace could access the firmware version name, it would
be possible to know which tablet is actually connected by matching it
against a list of known firmware names [2].

This patch exposes the firmware version name via sysfs attribute.

Link: https://github.com/linuxwacom/libwacom/issues/609  [1]
Link: https://github.com/linuxwacom/libwacom/issues/610  [2]
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index ad74cbc9a0aa..1862ca5805a7 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -50,6 +50,17 @@ static void uclogic_inrange_timeout(struct timer_list *t)
 	input_sync(input);
 }
 
+static ssize_t fw_name_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	return sysfs_emit(buf, "%s\n", drvdata->params.fw_name);
+}
+
+static DEVICE_ATTR_RO(fw_name);
+
 static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 					unsigned int *rsize)
 {
@@ -217,6 +228,10 @@ static int uclogic_probe(struct hid_device *hdev,
 		goto failure;
 	}
 
+	rc = device_create_file(&hdev->dev, &dev_attr_fw_name);
+	if (rc)
+		hid_warn(hdev, "Unable to create sysfs attribute \"fw_name\", errno %d\n", rc);
+
 	return 0;
 failure:
 	/* Assume "remove" might not be called if "probe" failed */
@@ -477,6 +492,7 @@ static void uclogic_remove(struct hid_device *hdev)
 	del_timer_sync(&drvdata->inrange_timer);
 	hid_hw_stop(hdev);
 	kfree(drvdata->desc_ptr);
+	device_remove_file(&hdev->dev, &dev_attr_fw_name);
 	uclogic_params_cleanup(&drvdata->params);
 }
 
-- 
2.44.0


