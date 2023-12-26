Return-Path: <linux-kernel+bounces-11590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6FD81E8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262C61F21BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B54F896;
	Tue, 26 Dec 2023 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RbYhe3yu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5744F885
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbcd9f4396eso5348452276.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703610567; x=1704215367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Akd6RKlfKGQOIPRZpIDuO79/YYYSE6zhnL/JmbvL390=;
        b=RbYhe3yuFFVjYCDkoZBLzHI6XbbYonR8MZopzWSwxAfU0hGZ1bG7tmvaA0bKlRUUOq
         5AMsll2kWe+tddxuP3Cz3SpgTQAks1XYTlHYFSAkBq0Pj/zB5oRfWpqeLv+HlZukFSZl
         yOUMKRKBKd0PX4l+O0aRDHRKn/Wpku3cdRt6UTh+vcnMwEfQwA/qIski68veERO1IDuS
         v8lfM2eO+7tLBAtniBcvm4XvWteIPhGqnvNOB//DvNMFdxGlnsjOh14OVWMqmtbeLOv/
         daK857XkQtbsMxpO4g+onJ9P0IcZTQTQ4SkQUKLcmAEWzknwMkDjo3a2JWDzXcq3lgQ5
         GBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703610567; x=1704215367;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Akd6RKlfKGQOIPRZpIDuO79/YYYSE6zhnL/JmbvL390=;
        b=lJUKKTPVEaK/WLzYx9ajAcqehlw0pn8BKOa+UU+Agiwzt10TULmNDJZ+AEH+iIoepq
         TO4uoBnnom4BUJffdDfDphcDGqTdZ0Yy4yYKEsAKOZ9CuZu0tAIfbUwGJ5pXJ4m9WRcF
         qJ/i9SGU8YmwCgz64dNrsOEITCyI5DgYDw6vOV6xb+8aitKWSbrmpHRvNPErbiV+MJOu
         VbLa1+xbArRDpur0IpjSmdoKsuQtak23KNVQL32V4/HTt0G/vKHr6Mnv1GS+jEMnn1/L
         TEK7ZQTTSbVGTUlSQTS7yge04MEZQ6obVupWiWI2k7QONGXI4YXITXbQ2XLPiH31GAyB
         TPmA==
X-Gm-Message-State: AOJu0Yywv8F+EwyT2VVx4VlQQDNyWa5RKGstDnYNDC6cfDsHoV+jPD3Q
	CGBzp4ZYZsi7/9O5WEIV3iT90kb1ROo0HlTU1Bc=
X-Google-Smtp-Source: AGHT+IEkqwyUw5LE2pPuSVWdD9Ll8bjRJ1AiBxVJse8CYRnhUFTQJDKFIr+3DFypxTRbwCySdqtTAuj16CB3
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:1364:b0:dbc:1b7c:3467 with SMTP
 id bt4-20020a056902136400b00dbc1b7c3467mr2836861ybb.4.1703610567371; Tue, 26
 Dec 2023 09:09:27 -0800 (PST)
Date: Tue, 26 Dec 2023 17:09:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMIIi2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0ML3aTMvJTUorRi3URzU4tUQzOjVIOkRCWg8oKi1LTMCrBR0bG1tQA 4k033WgAAAA==
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703610566; l=967;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=zmGZX06tlXxioKf/BCyW6Up5k041hhvwaK7ZwpJbzrI=; b=vZUDK6X/6tZGD7CNgO/zUwDV2syFM/ib/Sj0Ja3eESj8Ux4jpiM/ov5IuGYvT3qOEKwEQy0pk
 6n14iurK7XkDUBY27DVA33K3ooj/H//4RBi7ytBuVGIS7YUJa9dL5gh
X-Mailer: b4 0.12.4
Message-ID: <20231226-binderfs-v1-1-66829e92b523@google.com>
Subject: [PATCH] android: removed asm-generic/errno-base.h
From: Tanzir Hasan <tanzirh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

asm-generic/errno-base.h can be replaced by linux/errno.h and the file
will still build correctly. It is an asm-generic file which should be
avoided if possible.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 drivers/android/binderfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 1224ab7aa070..d04ff6029480 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -29,7 +29,7 @@
 #include <linux/uaccess.h>
 #include <linux/user_namespace.h>
 #include <linux/xarray.h>
-#include <uapi/asm-generic/errno-base.h>
+#include <linux/errno.h>
 #include <uapi/linux/android/binder.h>
 #include <uapi/linux/android/binderfs.h>
 

---
base-commit: 606d9c29e71fbf52fcfd3fcc3ad92e444c8e1d47
change-id: 20231218-binderfs-a758e162e0ba

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


