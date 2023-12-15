Return-Path: <linux-kernel+bounces-537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B04081429A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFF41C21FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F9111AC;
	Fri, 15 Dec 2023 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCn6D14G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8B912E49
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5d10f5bf5d9so2224537b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702625967; x=1703230767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ew0yjzotVMz+DbsDGXsO7ZBvpe+EragVhaS0DRk4H8=;
        b=HCn6D14GDwVWkuY/LrrVskDkkUc9yj1KPyam/75XIX93f1zZa9Lz66yZUtY001wbTA
         kSyIzS9A1q2LY3AibGWWaExvrEtOy2XVAc8xLm73sNe0+/R9DTPLs5ZFnKW2MtVTf76D
         vxKEaGxl3urJKN8A1XZwEnK0OKJ/ZMu2muSOgTM26htxcMf34Go9GgDcfk1zA6BYWjgL
         Yn0b40ybIiDQ6W8R8G3PE3VVTVK+7ePcj3fsxbCS9JYXVLKfBwd7nQvDVJEFMUMb6SPH
         kVUjginkWgoqMAyr16CkoXvuekMsuYDXqAs3BGgRuvErG4z5D3NbAlhC/Ho74OIIy7UP
         61jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625967; x=1703230767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ew0yjzotVMz+DbsDGXsO7ZBvpe+EragVhaS0DRk4H8=;
        b=Qtr3G98kzYVv/8ml6Lbdq/GCtLzwPvLq1r2ya3aqRZ/nW3jkx9w7GA+BwlnMJSaRJG
         Fo4qFlko91xUcUojo4lYNBMUivAcS+AGArmpiflg0tNkDenz87+HfXgtVEdYG1EbFFRa
         5cy+yizrzFfNennC4iKVGJkOYkyKPTNSpAtjqSbYKl1DiPJwonN4YveM7aaHU+0lEPVE
         JNyv4SDgzljClUwpDUHkga3BEsSGavv0/UYl60E5HnSn4XLjOYNMAKSf4QfwdU2nZoF8
         ylPTDJllueXr82dfKVcMAP3Iym9v7pn1FVPOGFIrM0HfjppKnURFQpqYz92bMVU2KesX
         kBDQ==
X-Gm-Message-State: AOJu0YzCAl8Tm3qErmiMsJr2PBMwkOdxIbucwTAYNR/Y+67wHr7U6fch
	d1nnoOPIeC2pGEtI5F4tst1sQZTHvHr5rw==
X-Google-Smtp-Source: AGHT+IEdNCTRzTrVPHds1vKNLGSiHnYDt78/zYUDSFVgM1wliEJevL7Fy5dUxym2mGK1jqN4jajZwpgyejAjIw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:b91:b0:5d6:cb62:4793 with SMTP
 id ck17-20020a05690c0b9100b005d6cb624793mr130837ywb.0.1702625967709; Thu, 14
 Dec 2023 23:39:27 -0800 (PST)
Date: Fri, 15 Dec 2023 15:39:10 +0800
In-Reply-To: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231215-kunit_bus-v4-3-4f5160e2f95e@google.com>
Subject: [PATCH v4 3/5] overflow: Replace fake root_device with kunit_device
From: davidgow@google.com
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="utf-8"

Using struct root_device to create fake devices for tests is something
of a hack. The new struct kunit_device is meant for this purpose, so use
it instead.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/overflow_kunit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 34db0b3aa502..c527f6b75789 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -618,7 +619,7 @@ static void overflow_allocation_test(struct kunit *test)
 } while (0)
 
 	/* Create dummy device for devm_kmalloc()-family tests. */
-	dev = root_device_register(device_name);
+	dev = kunit_device_register(test, device_name);
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
 			       "Cannot register test device\n");
 
@@ -634,8 +635,6 @@ static void overflow_allocation_test(struct kunit *test)
 	check_allocation_overflow(devm_kmalloc);
 	check_allocation_overflow(devm_kzalloc);
 
-	device_unregister(dev);
-
 	kunit_info(test, "%d allocation overflow tests finished\n", count);
 #undef check_allocation_overflow
 }

-- 
2.43.0.472.g3155946c3a-goog


