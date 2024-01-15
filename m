Return-Path: <linux-kernel+bounces-25570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F086582D2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC11C20A53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B041FDD;
	Mon, 15 Jan 2024 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkayhyQJ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B2468A;
	Mon, 15 Jan 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6db79e11596so330344b3a.0;
        Sun, 14 Jan 2024 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279800; x=1705884600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMlrrpyPoOkhOpyz7nMSzvwkhIZ9LzG5C/a8I1U5X7c=;
        b=MkayhyQJUuLS2gNgVDUugfb8o8BHKK8MsUK53rGui1nmMGUvykArZ5Ns5mSS315/mo
         9j9lOfiYhpJYP0SyBadB3ZSRZsjFNq302In5wdjP13LXwXl0W6osdqFLMspH/wMTMNyD
         qz04jMneoA2w5DWRukNEfXLF1VYL9rVYKuBXO+OQDlqjXKqASZED7gjn2FXblqzGNKoP
         tOEFcOJdbPz3O5VUR2O4l0PupHp3LM+jVgM+UY8Li8WVslMKv1QZ7nylf+JwFTSXaZvi
         cOHGZqzwHfftoQdVdkGgFLVwqNM8JXvq43hQanhsE3oFmhYQjRO3rIut+dsWm1CEcJzx
         SNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279800; x=1705884600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMlrrpyPoOkhOpyz7nMSzvwkhIZ9LzG5C/a8I1U5X7c=;
        b=JrLuGonoWx2+Exps3rovLsgIRI+SkUDzilOvIrIGiHcOzwguoqCj5zQS4TsSXRx8gg
         iFBYwb62aPUD8mltSyi2WvFzl0vrgKkw9YxBMn1ezjvd7dHhtz2NbJYBbZU8XqCogfNs
         P+uanvyTw8wS24EfVul6hOCd3HcQ4eMnk06LdtRHJy260IE9G17Y0JMNiyaO41FlYEt1
         VMNLam7zi8sf8ssgf5pdsx0WBxrKQUAOJVESpHFGWQP/fJWsZ+Q5lP5SzmugfHlMfXeB
         /C6LxYij06kWHmpFZ8iGfLDXfKNAb1vALVJ6QFoP3qlSHMDhTLdXmSlFEhjEJ1MUBKXs
         1x9w==
X-Gm-Message-State: AOJu0YwpOqb9F7h3CDtDEox+ZiJXcvxDVd7LNaSBpllcL8u8aSfmcyoA
	Kx1YOegpA0Mkh77BHXeITPP+V6XE0gcGlw==
X-Google-Smtp-Source: AGHT+IHh9rOasoaGaDcjxHn1QgIhNgNeRGrqWUGZj0E3PuJSDlqVm0UfZYrZFIHd85azXnU8th91wg==
X-Received: by 2002:a05:6a00:3988:b0:6d9:a856:eec2 with SMTP id fi8-20020a056a00398800b006d9a856eec2mr5967151pfb.14.1705279800116;
        Sun, 14 Jan 2024 16:50:00 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:49:59 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 5/9] Documentation: gpio: update sysfs documentation to reference new chardev doc
Date: Mon, 15 Jan 2024 08:48:43 +0800
Message-Id: <20240115004847.22369-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115004847.22369-1-warthog618@gmail.com>
References: <20240115004847.22369-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update GPIO sysfs interface documentation to reference the new
chardev document rather than gpio.h.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/userspace-api/gpio/sysfs.rst | 27 ++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/gpio/sysfs.rst b/Documentation/userspace-api/gpio/sysfs.rst
index 35171d15f78d..e12037a0f2b4 100644
--- a/Documentation/userspace-api/gpio/sysfs.rst
+++ b/Documentation/userspace-api/gpio/sysfs.rst
@@ -2,18 +2,18 @@ GPIO Sysfs Interface for Userspace
 ==================================
 
 .. warning::
+   This API is obsoleted by the chardev.rst and the ABI documentation has
+   been moved to Documentation/ABI/obsolete/sysfs-gpio.
 
-  THIS ABI IS DEPRECATED, THE ABI DOCUMENTATION HAS BEEN MOVED TO
-  Documentation/ABI/obsolete/sysfs-gpio AND NEW USERSPACE CONSUMERS
-  ARE SUPPOSED TO USE THE CHARACTER DEVICE ABI. THIS OLD SYSFS ABI WILL
-  NOT BE DEVELOPED (NO NEW FEATURES), IT WILL JUST BE MAINTAINED.
+   New developments should use the chardev.rst, and existing developments are
+   encouraged to migrate as soon as possible, as this API will be removed
+   in the future.
 
-Refer to the examples in tools/gpio/* for an introduction to the new
-character device ABI. Also see the userspace header in
-include/uapi/linux/gpio.h
+   This interface will continue to be maintained for the migration period,
+   but new features will only be added to the new API.
 
-The deprecated sysfs ABI
-------------------------
+The obsolete sysfs ABI
+----------------------
 Platforms which use the "gpiolib" implementors framework may choose to
 configure a sysfs user interface to GPIOs. This is different from the
 debugfs interface, since it provides control over GPIO direction and
@@ -33,9 +33,12 @@ userspace GPIO can be used to determine system configuration data that
 standard kernels won't know about. And for some tasks, simple userspace
 GPIO drivers could be all that the system really needs.
 
-DO NOT ABUSE SYSFS TO CONTROL HARDWARE THAT HAS PROPER KERNEL DRIVERS.
-PLEASE READ THE DOCUMENT AT Documentation/driver-api/gpio/drivers-on-gpio.rst
-TO AVOID REINVENTING KERNEL WHEELS IN USERSPACE. I MEAN IT. REALLY.
+.. note::
+   Do NOT abuse sysfs to control hardware that has proper kernel drivers.
+   Please read Documentation/driver-api/gpio/drivers-on-gpio.rst
+   to avoid reinventing kernel wheels in userspace.
+
+   I MEAN IT. REALLY.
 
 Paths in Sysfs
 --------------
-- 
2.39.2


