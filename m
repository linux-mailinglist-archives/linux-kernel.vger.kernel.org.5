Return-Path: <linux-kernel+bounces-146986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB48A6DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B6E1F21F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB85130A65;
	Tue, 16 Apr 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwsvbAzw"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825112F58A;
	Tue, 16 Apr 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277156; cv=none; b=ryKHgGRCrfIAmKP4EM7bdGcAM2dmcF7CWHAEa7ejxeJ6st0cWPmjl6vTfOpTTTrm20D+MvugT7elOtKnp/7yrjMcUSp3ytIRSlT8d8wTOlcinOWOiSoU3pwS44kqZS6PBVxBZ2FcGws4P0oZyMZJXIJ2wAw5oHdO9gHfEuTHLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277156; c=relaxed/simple;
	bh=AeWQU4CLyP//rGZTX/6elqJTYpv8NEiN+bbJsGd8pOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ib5dcX2+pfAQgNC0G9dKFibGS6tM8Gm84pnw3LnduQgwvONoxcixdSk3m+YWaPqXQjGzerWsMsRhip1ZdJGfyfvzqGYQz+zMyejJGSQqxy90lQRosjI6VjS8zD27lmQPIytXHiFb5yf3gR0xLN0lsrT9zA9d7SDXtotGObyb2NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwsvbAzw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4185e80adfbso11910795e9.1;
        Tue, 16 Apr 2024 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277153; x=1713881953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO5E9FFaQmEHN0MN8J8zJ1rF9ABCmvsemgJuR18aoBU=;
        b=DwsvbAzwri3IjTCAcRIBbtvMM204d3yO6MNIv96zuik4crcJQkubqb8oynXDUpwoFR
         KAPoQzlIpcBbcqhy0vCSsrFFrCR4Gv4bJEoLdtkW3fvbI7aHeW9MMXNQBOSTLYGmwnPp
         jtHMpbTJH7EkL9px/UfUOuDSQMzYu+bPDCrbBLKNAT424hlVy1RLRGS/vE3Ip/mD0HiU
         K5u+3AIsUOEPQToXrQmUM6WOIzWYfFzrHcCnJI5jIWdlzzs7yKLdUfag6ZcFBDEHFXA5
         VA9+IbYZ5pNI9nj0s7eAdwu53Q3hdbiNc8CnPqdFuMCqYAPr7MkAASNFvW1aLSGGsXlN
         qJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277153; x=1713881953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO5E9FFaQmEHN0MN8J8zJ1rF9ABCmvsemgJuR18aoBU=;
        b=KqDlOxk3MN+jMWUwPC4pQDZBDmHv5xqyG01Dmjvxe1Bfb/EFADQ5KW+FPURq+dHkfi
         j4Qsu1Arbn8WoMpLoZrrMJNtzCj+XxF6JbBt+woVWtbcUCuFoxiKrG41N8DC5oeYlsWo
         b1lmNotm5LPbmH8BZfMsaOpgpU2JkqoSp8aDxZjDnO47ombhihPe28i+Wf22ZsVK9rdx
         oMO7ARsRxtL8mrHW03YSTYZ9pHK6JhOFoiwuFsr125IKcCTE5/T2zOAHwGTBGPWQs/ro
         e6cbtnOMqlnuqFqqEkjjNbONCFtmfkHywf+4l+htulmjc3ZXvsRP1G4F4ZUpbQM2CCVM
         UyOA==
X-Forwarded-Encrypted: i=1; AJvYcCU0W0T+STneqDW5OArPDu5l41EuRo2YPZiUjzwFnhpA89EVGIJvH5116tqMHw3kHl63Vv3DP9A2WrK79YvoVPJbbtOy7Y737ITMmd6JsfEoEk1J28CZm6vcyfFwofBo1eX1ogthhti0hxE=
X-Gm-Message-State: AOJu0YzKBqse81/tt26cUpsZ8Ni4AuKQB/ZhikmR3sWs63Y/K+48pqUc
	B9Nc/wgAW1Y3BbgVUYeWwm1j7snkJaEQJI0gFv+YbHQpX4HHjEtT
X-Google-Smtp-Source: AGHT+IEv6yRW8mrcNmjWlWRPIOilkzMEDGER9GTMpOVn8B1Ym6bB4P1gDX0I5S3RGTxXr6jG+1oUpQ==
X-Received: by 2002:a5d:5886:0:b0:343:ef64:e0fd with SMTP id n6-20020a5d5886000000b00343ef64e0fdmr10168721wrf.52.1713277153579;
        Tue, 16 Apr 2024 07:19:13 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b0034625392416sm15055114wrj.104.2024.04.16.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:19:13 -0700 (PDT)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: martin.hecht@avnet.eu,
	michael.roeder@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] media: i2c: alvium: fix alvium_get_fw_version()
Date: Tue, 16 Apr 2024 16:19:01 +0200
Message-Id: <20240416141905.454253-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416141905.454253-1-tomm.merciai@gmail.com>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of reading device_fw reg as multiple regs let's read the entire
64bit reg using one i2c read and store this info into alvium_fw_version
union fixing the dev_info formatting output.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 20 ++++++++------------
 drivers/media/i2c/alvium-csi2.h | 15 +++++++++++----
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index e65702e3f73e..991b3bcc8b80 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -403,21 +403,17 @@ static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
 static int alvium_get_fw_version(struct alvium_dev *alvium)
 {
 	struct device *dev = &alvium->i2c_client->dev;
-	u64 spec, maj, min, pat;
+	union alvium_fw_version v;
 	int ret = 0;
 
-	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_SPEC_VERSION_R,
-			  &spec, &ret);
-	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MAJOR_VERSION_R,
-			  &maj, &ret);
-	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MINOR_VERSION_R,
-			  &min, &ret);
-	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_PATCH_VERSION_R,
-			  &pat, &ret);
-	if (ret)
-		return ret;
+	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW,
+			  &v.value, &ret);
 
-	dev_info(dev, "fw version: %llu.%llu.%llu.%llu\n", spec, maj, min, pat);
+	dev_info(dev, "fw version: %u.%u.%08x special: %u\n",
+		 (u32)v.alvium_fw_ver.major,
+		 (u32)v.alvium_fw_ver.minor,
+		 v.alvium_fw_ver.patch,
+		 (u32)v.alvium_fw_ver.special);
 
 	return 0;
 }
diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
index 9463f8604fbc..9c4cfb35de8e 100644
--- a/drivers/media/i2c/alvium-csi2.h
+++ b/drivers/media/i2c/alvium-csi2.h
@@ -31,10 +31,7 @@
 #define REG_BCRM_REG_ADDR_R				CCI_REG16(0x0014)
 
 #define REG_BCRM_FEATURE_INQUIRY_R			REG_BCRM_V4L2_64BIT(0x0008)
-#define REG_BCRM_DEVICE_FW_SPEC_VERSION_R		REG_BCRM_V4L2_8BIT(0x0010)
-#define REG_BCRM_DEVICE_FW_MAJOR_VERSION_R		REG_BCRM_V4L2_8BIT(0x0011)
-#define REG_BCRM_DEVICE_FW_MINOR_VERSION_R		REG_BCRM_V4L2_16BIT(0x0012)
-#define REG_BCRM_DEVICE_FW_PATCH_VERSION_R		REG_BCRM_V4L2_32BIT(0x0014)
+#define REG_BCRM_DEVICE_FW				REG_BCRM_V4L2_64BIT(0x0010)
 #define REG_BCRM_WRITE_HANDSHAKE_RW			REG_BCRM_V4L2_8BIT(0x0018)
 
 /* Streaming Control Registers */
@@ -276,6 +273,16 @@ enum alvium_av_mipi_bit {
 	ALVIUM_NUM_SUPP_MIPI_DATA_BIT
 };
 
+union alvium_fw_version {
+	struct {
+		u8 special;
+		u8 major;
+		u16 minor;
+		u32 patch;
+	} alvium_fw_ver;
+	u64 value;
+};
+
 struct alvium_avail_feat {
 	u64 rev_x:1;
 	u64 rev_y:1;
-- 
2.34.1


