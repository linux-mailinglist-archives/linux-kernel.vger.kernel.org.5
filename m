Return-Path: <linux-kernel+bounces-132573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E598996BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6851F22F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41C13C818;
	Fri,  5 Apr 2024 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjE2CDQQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7813C833
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302819; cv=none; b=K4D5+XwBetCohf8TEr9Er9sgvmGHJQtbN0fSstgoQjv9ks3Td1bNTBwbxytWAepfG0NMPPscaYlnoBPLZENf8vXYTMaahG2oOP9uL+Vewrp6INAtrbs6rc2TNfHtYxGPLHzSMqm1ApfkYiRibqXrE+xa4e0JNwAPqqrwm7SRVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302819; c=relaxed/simple;
	bh=t9HJqxPdA5XNwvqxEEAAekCfSRdNt7vbuUaJ67rE5xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hnrf5EzcK9haDOGs4DWFv/gH0VhTu7DrSZQ4yE1oEXdovLD/tABtzuSQ1oQRLs4h21XX/B43bmimGmkno3M/f5LM+Sr55/pitZK7QwQ/mKxyj6rVeZ8amwWtlINihCmUX7zbQZ3A9n2rmVfp68O13Ri1R+LEggjrqhfcTdq/MeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjE2CDQQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4162c2109a5so7955015e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712302816; x=1712907616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfMYrnadCJ5fGBi6dgXMCcmaOaqurwY7DOo3APmaJ9E=;
        b=jjE2CDQQvd6y9QpNtFK1CWziP5n12JKYBkWdgeeqHlxjKkI56dZ1K8fFYloQVGl92D
         sJygoufJTRWRPj7pcHTOTtwYv9PHjZ6bSgLbQ72gAurphrUy+iKA1q6JeggJU/ORUWLw
         v2VGWO5jfjzkNfIdOJW2PRYgwEfinY56l8TLoxkrwb9h278QxnMhgOohO9peuC+bIfxI
         +R8gkH3zTpGW8Itg+NNHY5y0gKp+tIbb4VS9In2hnJMGmZ4D03+JO2PDA/NWUwT2Cjsv
         EHRttfSuHgEjHNL2BUV4xj8J4HL5aI/vPlknf6Npzkw0IjEz37vxETVQJD9CM5GYOzpa
         02PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302816; x=1712907616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfMYrnadCJ5fGBi6dgXMCcmaOaqurwY7DOo3APmaJ9E=;
        b=A3J4/+o9n4elmQ+C5faWYPFqPKUz/uemv2RZm/91vku4db4Ti5mSG9G+2syah+FSWM
         qM2umpmh454XSudo8F8siMhSAdKFP8nGenIKVEByr0iIjXZ+oxw2yyRDyhsm4L8UFYgb
         zR4ImN8VkrA5ZuBkndFRBkZl4sFims7QsL18vnNphjxxuSiNTC0bGKrkIhZ3uiLqTGVW
         gMz6jmxSBALSLioeuuIW7pEMZyYn60lwfmmpAtmL17gJCjnSas0cH3L+2godeu/uIKiN
         kQQO272YCgljhBt6C9KG2hGzmIZIJfwXC8OIfKCuuCX5YZtx4fQLrOj82YWlqedOKH7O
         RKOg==
X-Forwarded-Encrypted: i=1; AJvYcCWewZlFFvPGR0PPZ769XM05ESHLdf86QIP02spPJXTnjPjc6X9veCKNF1xWBUcNJXyZG28kahGv6pB3ayWZvWw4sHR+Z9v84fzS0dAv
X-Gm-Message-State: AOJu0YxtCr3ajpe9dyISK46V5D/xFyBwekijT3wg23baxickD0ZAa5pN
	do3ZRoOeejzhO4WSOX3q5CKyBOeLb6r5jeD2pJXSHveC2awxMONZ
X-Google-Smtp-Source: AGHT+IF1lzcGczrfopACd2bNaeA2KFZKHgaZLXDgXTnFS30ViuvSTtE/WdMepCeKM5nHgE7NKp1zzg==
X-Received: by 2002:a05:600c:19d1:b0:412:dcab:7c79 with SMTP id u17-20020a05600c19d100b00412dcab7c79mr519544wmq.10.1712302815994;
        Fri, 05 Apr 2024 00:40:15 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b003434f526cb5sm1311643wrm.95.2024.04.05.00.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:40:15 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] staging: pi433: Remove duplicated code using the "goto" error recovery scheme.
Date: Fri,  5 Apr 2024 10:39:58 +0300
Message-Id: <20240405074000.3481217-6-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405074000.3481217-1-ikobh7@gmail.com>
References: <20240405074000.3481217-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pi433_init had "unregister_chrdev" called twice.
Remove it using goto statements.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
v2->v1:
Followed by Dan Carpenter's <dan.carpenter@linaro.org> comments:
        - Remove empty "fail" goto tag.
        - Reorder pi433 init & exit calls so they have reverse order.
        - Add "unreg_spi_drv" goto tag.
        - Check "debugfs_create_dir" return value.
        - Update "if" statments for consistency.
v2->v3:
        - Undo pi433 init & exit calls reordering. Reorder exit calls in
          a seperate patch.
        - Remove "unreg_spi_drv" tag.
        - Undo return value checking for "debugfs_create_dir".
        - Undo "if" statements update.

 drivers/staging/pi433/pi433_if.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 62ce75b07bf0..b01ee145ff3c 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1403,21 +1403,21 @@ static int __init pi433_init(void)
 		return status;
 
 	status = class_register(&pi433_class);
-	if (status) {
-		unregister_chrdev(MAJOR(pi433_devt),
-				  pi433_spi_driver.driver.name);
-		return status;
-	}
+	if (status)
+		goto unreg_chrdev;
 
 	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	status = spi_register_driver(&pi433_spi_driver);
-	if (status < 0) {
-		class_unregister(&pi433_class);
-		unregister_chrdev(MAJOR(pi433_devt),
-				  pi433_spi_driver.driver.name);
-	}
+	if (status < 0)
+		goto unreg_class_and_remove_dbfs;
 
+	return 0;
+
+unreg_class_and_remove_dbfs:
+	class_unregister(&pi433_class);
+unreg_chrdev:
+	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
 	return status;
 }
 
-- 
2.34.1


