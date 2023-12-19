Return-Path: <linux-kernel+bounces-5402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C1818A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354CFB249B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A71C28A;
	Tue, 19 Dec 2023 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isRyZUPq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271131BDDE;
	Tue, 19 Dec 2023 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so51231065e9.0;
        Tue, 19 Dec 2023 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702996878; x=1703601678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGTvv5cpxM+jtyC8aw4dFZd8mhCWgM/Dn37jyMs9saM=;
        b=isRyZUPqvR9lgtFhiy3ORNuEtnkKAa4UJO9LwkRwRdvMWpK2+dlZ5JLxNFRYINjhwW
         7rbQa2I0clJPNOw8OkYsCEgd3F5P5cPwq/BjPnFIegZjJj+LHezkuNh8PzjSDfKXGXGC
         MBzbX23bkAnvg92xy/kdqcR8ZKIb+7y0wbq8HcSN7IvCSapkuodDHMpJXBbOaRh6MdM/
         pw1PhC81lRvykguzMdGiY0v7nIdbLPJFVztbQ66HalmLEgrsVRPEgXYkbFbphW6hmwSx
         vHK0CfDzT1d3Mev0jNCkpiCSX07ep3aeYj+ugPI8HqT1BGiBLyBAVuk96h7vPosT+PU9
         0y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996878; x=1703601678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGTvv5cpxM+jtyC8aw4dFZd8mhCWgM/Dn37jyMs9saM=;
        b=vVm0SP2sSfRrQw6U8m/T0iXznPSOmJoqK4mSTw/GOoqSRbDj5b120AFXVUfY1mdG0N
         /WZ3bOugjvm/IEU4ScoJbyCSKUUD102iuRJFQhFVpifk4m2q1w7OdQaYVy12JbJH13fq
         6RHMlOyTPk62SrEqV5W3J6Pb6Ec+m9/G3IbxrY/Gspz0+9OpKZxsCHah8YJFOM4N949O
         NPTAFhPmJTnAbYJvO0iu5WEz34mwuD/lBZ2pS1v10UXZbjCArO2zR78TqjNWwnQBErIk
         l8fKC0zEFgwXIZkX2n0VLf5z785L4naD6KnC6Xl7Ctyr59MNCS90FHDFXvTMsQreNkt5
         KFiw==
X-Gm-Message-State: AOJu0YxZ2O4oY87PZtbEk6YVzzkca3pt16NDUYbdmQ37CYPGSWbaRB6+
	V7TSPoKEzS0qMv8GKfTr2ZZRKGhwIvI=
X-Google-Smtp-Source: AGHT+IGR+h/gTSXJexePpuLg4d1Sm4hAFYi6IJODbx0EA3QM1U3RhRpipneSrE+uDNHKAUExo3G6ng==
X-Received: by 2002:a7b:ca54:0:b0:40b:5e59:b7b6 with SMTP id m20-20020a7bca54000000b0040b5e59b7b6mr9304466wml.147.1702996877973;
        Tue, 19 Dec 2023 06:41:17 -0800 (PST)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0040c57e4ea28sm3189788wmq.17.2023.12.19.06.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:41:17 -0800 (PST)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (gigabyte_waterforce) Mark status report as received under a spinlock
Date: Tue, 19 Dec 2023 15:36:19 +0100
Message-ID: <20231219143620.22179-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through hidraw, userspace can cause a status report to be sent
from the device. The parsing in waterforce_raw_event() may happen in
parallel to a waterforce_get_status() call (which resets the completion
for tracking the report) if it's running on a different CPU where
bottom half interrupts are not disabled.

Add a spinlock around the complete_all() call in waterforce_raw_event()
to prevent race issues.

Fixes: d5939a793693 ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Does the above make sense? The raw event parsing is a softirq AFAIK and
presumably could run on a different CPU in parallel to a waterforce_get_status()
call.

Appreciate thoughts on this.
---
 drivers/hwmon/gigabyte_waterforce.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
index 1799377fc2f1..85e523775714 100644
--- a/drivers/hwmon/gigabyte_waterforce.c
+++ b/drivers/hwmon/gigabyte_waterforce.c
@@ -276,8 +276,10 @@ static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *repo
 	priv->duty_input[0] = data[WATERFORCE_FAN_DUTY];
 	priv->duty_input[1] = data[WATERFORCE_PUMP_DUTY];
 
+	spin_lock(&priv->status_report_request_lock);
 	if (!completion_done(&priv->status_report_received))
 		complete_all(&priv->status_report_received);
+	spin_unlock(&priv->status_report_request_lock);
 
 	priv->updated = jiffies;
 
-- 
2.43.0


