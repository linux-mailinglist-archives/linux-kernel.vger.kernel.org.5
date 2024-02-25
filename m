Return-Path: <linux-kernel+bounces-80168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95544862B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA201C20AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197851759E;
	Sun, 25 Feb 2024 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9bZPlIM"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547C16427;
	Sun, 25 Feb 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876456; cv=none; b=JNS7TbU8O3+quslYnrAL8mB3RHa0eGYJPakMW2SP2tBAP03kjoelzOUHUEMlLPJzgVpxXJ5quC0bjWDeL4vGzMnFBriHhxzMtE+7d60R06q7RZlOL0m+bO68fWZT84U5X7PqdRV6Ny7gjwBiXBb3Hy0XsghIe71VXyRUBZaUZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876456; c=relaxed/simple;
	bh=z9nMvV8Br/f5lbsA6JG4GUMN22pmv5RVa5MEsG7AZxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FWzTfebLUdmeu594j8BLi432P1G3lMOedwgmoMsNaeZrsByYU8swJmia/gh2eUtMkwgukZ4AUazVWOrvcFJZWQBqE2F0cTbvAiIaraVGQsie/sI2Mlmr0qjAubZJghxhGmAjdtBC9BUv1qUJxJxQ0cof+kCOT1alPj47muXVbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9bZPlIM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d28051376eso12513781fa.0;
        Sun, 25 Feb 2024 07:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708876453; x=1709481253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+RTNbDlxLiVpFh7JBKRa3eX6T1fmXSslJ2kwaJm/ow=;
        b=T9bZPlIMILbo6I80T47MqvzvJtd1zLzKFAP63yaJ5Boxvo6aPMVUhRd1+hU5ADv4Qk
         oibkfdZboU9oNvOhghRgLFJutW/Xw+iLAnoBSHYbaxOURrK4LF6SQg3tRHKL0wcEdhph
         m/r4sAFYQQnp3jZTC+6chxq3SFEhFtDYkZ2CEykwlFUSyWqqDQy910Qtk8rKZKScHlrP
         O4Als3bbKKbV3Owe5LfRpJ09n/cfKtpB2OZwWPeYOxuPl5MCDVHV7rsF3ZQTJ7e+3kQH
         vHkuCV7jJOiL7TwjeFvPsj+/+ty9OkPgnaMHJ7W2SmJsXB1riXgoIwbApRk/Hu6I4jAC
         8xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708876453; x=1709481253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+RTNbDlxLiVpFh7JBKRa3eX6T1fmXSslJ2kwaJm/ow=;
        b=i12dnh5/sTi4zWjATwnNWNoqL6ets72lVR8SNz6kjJjGY2CkiceP+AUoz4OVifokIy
         5HApk/bTrn1HYNrZfWz7u0i2MBadgq3Jxg/mmDPDbGO8/n9cVik2ReC9rhahxF3/ZJnb
         eYibEG/FW5a5fXGbS1z3ygHz8pUj/ouOisaB219CfgyqkWdFg92pNvUaj8LRRweandez
         IDq1hGDYM/JlLX6sE4MpWyaAVVwXAAT5CawYZdI16R83T0pQTWrCgamS1O4puQHc/do+
         xqbYA32r3XCnCaGrqtazUBhjLgdswcblcpphLxFPQMoVjfKaQ27yVjRDcGjn7dZ4Xx7C
         CGOA==
X-Forwarded-Encrypted: i=1; AJvYcCWzlRuCQb7+FHfmpFesN3vm4iE/d8NvIGaon+dJ2T4pwGNYrs80hEk5eXOFDpLBznM5U8GRKwggeluh9nRHrgWr7QreMlD7zC2Ctq3nNvwvKPd3cGWzRj+05uLDx5EC5xB+rAuTitBxpDE=
X-Gm-Message-State: AOJu0YyFE96pOCRlfnFllcB+IlSRxe/W0zxlXskdwopkYZyKPtei68JU
	SYrYBFJpB1Pk0In7yFEEu96wn02EBRNv3bRN3zWhk/tUela3sQbh
X-Google-Smtp-Source: AGHT+IH8J4Ezb3RxlZuDNF6SENZAlokznIDvMIbMLfNGU+6SI4X4wE287gT8kWe01PNnQb8I60xGkw==
X-Received: by 2002:a05:651c:10d1:b0:2d2:2012:1fef with SMTP id l17-20020a05651c10d100b002d220121fefmr2281728ljn.47.1708876452671;
        Sun, 25 Feb 2024 07:54:12 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id p6-20020a2e93c6000000b002d221041b59sm585179ljh.51.2024.02.25.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:54:12 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: media: atomisp: Fix formatting issues and minor code issue
Date: Sun, 25 Feb 2024 16:53:59 +0100
Message-Id: <20240225155359.41435-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following code style and formatting issues:
 * Ensure multiline block comments are correctly formatted
 * Remove extra braces not required for single line conditional statements

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_drvfs.c         | 2 +-
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 7 +++----
 drivers/staging/media/atomisp/pci/atomisp_subdev.c        | 3 ++-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_drvfs.c b/drivers/staging/media/atomisp/pci/atomisp_drvfs.c
index 1df534bf54d3..8ef25d2f8b87 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_drvfs.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_drvfs.c
@@ -34,7 +34,7 @@
  *        bit 0: binary list
  *        bit 1: running binary
  *        bit 2: memory statistic
-*/
+ */
 struct _iunit_debug {
 	struct device_driver	*drv;
 	struct atomisp_device	*isp;
diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index 139ad7ad1dcf..804ffff245f3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1416,13 +1416,12 @@ static int gmin_get_config_var(struct device *maindev,
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		status = efi.get_variable(var16, &GMIN_CFG_VAR_EFI_GUID, NULL,
 					  (unsigned long *)out_len, out);
-	if (status == EFI_SUCCESS) {
+	if (status == EFI_SUCCESS)
 		dev_info(maindev, "found EFI entry for '%s'\n", var8);
-	} else if (is_gmin) {
+	else if (is_gmin)
 		dev_info(maindev, "Failed to find EFI gmin variable %s\n", var8);
-	} else {
+	else
 		dev_info(maindev, "Failed to find EFI variable %s\n", var8);
-	}
 
 	return ret;
 }
diff --git a/drivers/staging/media/atomisp/pci/atomisp_subdev.c b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
index a87fc74159e2..f8efaef2c055 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_subdev.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
@@ -394,7 +394,8 @@ int atomisp_subdev_set_selection(struct v4l2_subdev *sd,
 			 * (of the desired captured image before
 			 * scaling, or 1 / 6 of what we get from the
 			 * sensor) in both width and height. Remove
-			 * it. */
+			 * it.
+			 */
 			crop[pad]->width = roundup(crop[pad]->width * 5 / 6,
 						   ATOM_ISP_STEP_WIDTH);
 			crop[pad]->height = roundup(crop[pad]->height * 5 / 6,
-- 
2.40.1


