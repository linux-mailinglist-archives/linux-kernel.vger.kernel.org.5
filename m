Return-Path: <linux-kernel+bounces-60973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09F0850BCC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CA31C21EAF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A321756E;
	Sun, 11 Feb 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8hgUpH4"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2F17562
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707691034; cv=none; b=ct9kPZGfZcP2TexYIniFRDS11Yd4osUTlXaCIHcWf/JDF2HjAtAE049ninE13hjYHefyJqsCMnzavJ+8G72333bQSj6LZ6E21ad/15XCV8LJ2tO5ypki+Eh/gaMBmlAdUMoOs6HjkRuD/0OOYtWX7PGxm7RWUylFbwX0IPX6iNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707691034; c=relaxed/simple;
	bh=6t9CwVYmdoKt02P//MW11oTFv8CYB0bod9mA2PMjpII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwebKRH9sR9Jg8cmgg5P5wuadmIJnBq3Azw7MejeK+rmNVI8Ktjll2qWiz6S7L79VJjmSEtR++QuSOLpr1jemACZbUyPT+MNV26OEQMmqbIXR1dNcORWl1KgYUcpdLunYW5vCjopTkyfckg9VUdKQL4gYWRpgFk85xQ8twt7L2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8hgUpH4; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bff4553fa7so1565391b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 14:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707691031; x=1708295831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwL2cPgCgo73JKWjoqj3p87QSfksLIJBW6ce7uIk2Us=;
        b=h8hgUpH4Jy2rXyNflbL6i2dcwSSFm2FEErtJlFra/ZM09Ff6EuURWTp1HyclYds0Xu
         EMOaMrBoDo4NMnHxmJHX5jPHio0Hd+GjHR/9tJXoGNJaFDtBpwkqoOrdLvwu8F64plBM
         Wdg99yV+0fXSM9iGWzqONkFsnuL+Rr2rjes8SGON6fekIqttkkbHUGUiAXjRuah2hgzp
         N2tJm9HDM4yt9B2WTdf0u+cIjkyhchWHhKDuAWJ0Lbf242cU9hz4RTr886oUe39fsVwh
         DD0NIwApNO8ctDZXeq6mtQFNehYbshnwns1QVvyEC2NTznrq9OTlerhKd8Odb5T6SC8n
         ej7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707691031; x=1708295831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwL2cPgCgo73JKWjoqj3p87QSfksLIJBW6ce7uIk2Us=;
        b=lutRESQayiLJXbvq7qvqHX54sbF1wwIoDFQ5ABKsTDZeZ6QDTY8d8jBGUpFkjLDR8Q
         T9L3SzCDBHE3rYOUgNivEOoxaZmlhb3ShiToU7hRa6M+Bu4DDT+3y4SNSU6JfV49VyXG
         Tlpoq6OUMsw5ItMkuHaZdM/VoYBnMxybd81mpxzFMvFu3QlQoWQbWLLI1Ao0AfKDBzrZ
         aTfZm+u1HkuAlTkBzpqLos2pgu9UVnCdvzQkq+hRg3nOMwYzfIi+vsrCaktAJdXekeA2
         1eiuMZ52HI/Xz2UBmNeTXYtQAysQ2677AyZPSVXYoo3CouiWeU9ZH0qJodqerJmCZLhg
         PmLg==
X-Gm-Message-State: AOJu0YxzQu0V608ZzG/HJ1Ynj8MYre7H2MphZEVV4jf4qwTWKl/PnEi+
	X3PRVTMK6dtr2c4vZ4eToPWD6+WHoQk5ZV9FbIJuNQF8I2QVZISF
X-Google-Smtp-Source: AGHT+IHRwOGpTWwJt9l7nBsfJ197kU9hkIhD8SWg5fFGEiqKoovXHd/UVr6i0qcVw6+Stb2d+VCp2w==
X-Received: by 2002:aca:130c:0:b0:3c0:3b3b:1745 with SMTP id e12-20020aca130c000000b003c03b3b1745mr157037oii.54.1707691031182;
        Sun, 11 Feb 2024 14:37:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSSTGYOye8W97pmZkft5mGS2lUrPc6vfsm12c3jsP9weo9admjDQH7e+U7TZmfQf/IeXu4xpIzWfZBlEgp7Kk51g==
Received: from opengear-rohan.test.bne.opengear.com (brisbane.opengear.com. [60.241.24.90])
        by smtp.googlemail.com with ESMTPSA id k70-20020a633d49000000b005cf450e91d2sm5558724pga.52.2024.02.11.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 14:37:10 -0800 (PST)
From: Rohan Kollambalath <rohankollambalath@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rohan Kollambalath <rkollamb@digi.com>
Subject: [PATCH] sysfs:Addresses documentation in sysfs_merge_group and sysfs_unmerge_group.
Date: Mon, 12 Feb 2024 08:36:34 +1000
Message-Id: <20240211223634.2103665-1-rohankollambalath@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rohan Kollambalath <rkollamb@digi.com>

These functions take a struct attribute_group as an input which has an
optional .name field. These functions rely on the .name field being
populated and do not check if its null. They pass this name into other
functions, eventually leading to a null pointer dereference.

This change simply updates the documentation of the function to make
this requirement clear.

Signed-off-by: Rohan Kollambalath <rkollamb@digi.com>
---
 fs/sysfs/group.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 138676463336..8a22444dd46a 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -318,13 +318,13 @@ void sysfs_remove_groups(struct kobject *kobj,
 EXPORT_SYMBOL_GPL(sysfs_remove_groups);
 
 /**
- * sysfs_merge_group - merge files into a pre-existing attribute group.
+ * sysfs_merge_group - merge files into a pre-existing named attribute group.
  * @kobj:	The kobject containing the group.
  * @grp:	The files to create and the attribute group they belong to.
  *
- * This function returns an error if the group doesn't exist or any of the
- * files already exist in that group, in which case none of the new files
- * are created.
+ * This function returns an error if the group doesn't exist, the .name field is
+ * NULL or any of the files already exist in that group, in which case none of
+ * the new files are created.
  */
 int sysfs_merge_group(struct kobject *kobj,
 		       const struct attribute_group *grp)
@@ -356,7 +356,7 @@ int sysfs_merge_group(struct kobject *kobj,
 EXPORT_SYMBOL_GPL(sysfs_merge_group);
 
 /**
- * sysfs_unmerge_group - remove files from a pre-existing attribute group.
+ * sysfs_unmerge_group - remove files from a pre-existing named attribute group.
  * @kobj:	The kobject containing the group.
  * @grp:	The files to remove and the attribute group they belong to.
  */
-- 
2.25.1


