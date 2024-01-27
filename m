Return-Path: <linux-kernel+bounces-41256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648483EE13
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386771C214CD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49B29417;
	Sat, 27 Jan 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb3K8Ov/"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141F2C183;
	Sat, 27 Jan 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706370551; cv=none; b=Y7Lz9VK+ZQ9KV1tne8xY2Ya3ppIllBm6Ej1nxFnbDMJ/46Fr2MLAYZLaFuxIQAENbWfLasYBM5ct7uUmZL20XL/NtAG77no7O+xP1Bq5k+OAFwvaxLbsHibXzyAS99bvLXD+/WmSwI55fdf0SlTyrn2VSW1hH3f7gwUseEP1HSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706370551; c=relaxed/simple;
	bh=fVSLrHEcAwLSUJFQHCdF395pr/EGK0fBJgLTSHcGQ+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GoGk88xdDw2U/fYzgWJZP7o9sWKDZ6feH8vKl04IW6S3nngjmkRn1PZ1yHSfxCTTJGSOr3ceLGe4N9UEFw8Qm89IE+w/rD38R/9tlhx2PSmSh6IMs32rz1VkmklIP02lD1X/APT/EKwQpPir1ouyIJlobV5tsNcOqGhw1hJag/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb3K8Ov/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf593af2ebso2185331fa.1;
        Sat, 27 Jan 2024 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706370547; x=1706975347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9AldL2o9eKpU5JteuqfZb2W1sW+pj8HObs9uzsbe54=;
        b=bb3K8Ov/nxcJpLb/l0D5A4yVZQ0BbK61v8sIKpmmLJjjHlUJPZ/gAsxWVlNrIbGKpG
         9tQN4VvTvk3KI3QQZIJdPrxad3ZlmrJ7UFsAvuEC3Usx+xVIHR/hg5jkVV1UGpYuPPFx
         WBCnPVHjdc67OAbyEMVf+RBPurKHrOQRGhXlHLWd2oYrjgeEx2aHMtFx+EMioYBUtJXH
         utQVbxqLRLJEjON8/acmWJuFYclwJ6vcKSSo3M05tYyqQELxegqtTJ6JdCbECpgNCla3
         sqcETM0pLlqQQEvhdpPa8Qity6hH26rZWWQzpYinoHWuQxsYDJbeLUeHmHMIjPybc+OL
         79zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706370547; x=1706975347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9AldL2o9eKpU5JteuqfZb2W1sW+pj8HObs9uzsbe54=;
        b=ihIeGFbkl+KGmq7769T4tgJ+HtN0Aq3VwuZcqiDE4UzFONI+hbcymN2cVbgvo/cl2s
         wv1Fw5Muob2IdOIN6b3XU1UgLTaszjyUN6zd55KN1H8BbD+9QnhHlG9jOOznwRG+GCQV
         3K1tCoYOOYI750vU31lONvESF/9vvlh/yY8MM1ZyxgRGUZNER2QbCK158FpLr/yYArqX
         /lo/clvJHA9onqaxg7v6D6qsaXpy6lUOLdxUkBFGx6cRpJyUrKxiDH6NbvNCJPYYvvRg
         Xp0vSPdZHlmHDLKXx2O4k+kNOgAIxF3G5bE0DNXDFGVFJQLAJXUgKFSAxLMrFRrldOya
         B0fg==
X-Gm-Message-State: AOJu0YylGIsBvbibJANCUi7gxp411ejZ7Eu28fgBF3F+2ZgR2Q6lL7xG
	eMuP7lQ8Glc2CQ+yGj9g/FVnFa4badQ1N+Hi+VJ6Bmj4v/JEpKv3dNoqGHuFlvxZfw==
X-Google-Smtp-Source: AGHT+IGkl2ywSAGmktZZI4GcL+jTO67wm5FNXkVT328mPYu/EC+8xKiHHe5eZ8Ihxq5xL2m8yHSl9g==
X-Received: by 2002:a2e:7a17:0:b0:2cd:4164:5d68 with SMTP id v23-20020a2e7a17000000b002cd41645d68mr1341856ljc.13.1706370547288;
        Sat, 27 Jan 2024 07:49:07 -0800 (PST)
Received: from localhost.localdomain (broadband-46-242-13-133.ip.moscow.rt.ru. [46.242.13.133])
        by smtp.googlemail.com with ESMTPSA id p8-20020a2e7408000000b002cdfbbb4f8asm498657ljc.74.2024.01.27.07.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 07:49:06 -0800 (PST)
From: Konstantin Aladyshev <aladyshev22@gmail.com>
To: 
Cc: Konstantin Aladyshev <aladyshev22@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (pmbus/mp2975) Correct comment inside 'mp2975_read_byte_data'
Date: Sat, 27 Jan 2024 18:48:44 +0300
Message-Id: <20240127154844.989-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current driver code no longer perfrom internal conversion from
VID to direct. Instead it configures READ_VOUT using MFR_DC_LOOP_CTRL.
Correct the comment message inside the 'mp2975_read_byte_data'
function to comply with the driver logic.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 drivers/hwmon/pmbus/mp2975.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 5bbfdacb61a7..e5fa10b3b8bc 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -131,10 +131,9 @@ static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
 	switch (reg) {
 	case PMBUS_VOUT_MODE:
 		/*
-		 * Enforce VOUT direct format, since device allows to set the
-		 * different formats for the different rails. Conversion from
-		 * VID to direct provided by driver internally, in case it is
-		 * necessary.
+		 * Report direct format as configured by MFR_DC_LOOP_CTRL.
+		 * Unlike on MP2971/MP2973 the reported VOUT_MODE isn't automatically
+		 * internally updated, but always reads as PB_VOUT_MODE_VID.
 		 */
 		return PB_VOUT_MODE_DIRECT;
 	default:
-- 
2.34.1


