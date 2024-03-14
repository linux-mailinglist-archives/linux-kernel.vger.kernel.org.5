Return-Path: <linux-kernel+bounces-103461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392E87BFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F6B1F2398D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AFE71751;
	Thu, 14 Mar 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJvdN6A4"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788BDDD9;
	Thu, 14 Mar 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429125; cv=none; b=YJB0PW1QqOPIRLfdJJp06tzzen0g6sKN89fQeTl7bzMstep2VkwyKpfOGf0+jrgsxNmUCQQZTrORBM/fY+SWgEv+V0xMkfWbCuzh64F61yoQ6AmlwuDMbR4ADxrrF6MDV+QnxbFRU1DL4yCyCMXvVc6QQwPE+BXImzQ8Ly7KieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429125; c=relaxed/simple;
	bh=nDsvYD5yEk/gy9N+HJ0QOM2iZUP4AcamRw/unfpE3no=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EwdvDNEOzbnT6b3vJBq0C/J7F2odDL4Dwez19sa68XXcg8eSWYA/0JLUKQmRUMCo5KigpRk5GIvnrDrXQBrnnOM+LQVr9OyyV3OUwEhmMSVm3q+j8n/en5o+Fxf9k1oalkeC5qk5mRGN6EOrTsxwHx8fiz7E5dOdz8fSp4IfVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJvdN6A4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso664187b3a.1;
        Thu, 14 Mar 2024 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710429123; x=1711033923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fxoX3q50e92OYO+T5SP4tCKLkh072V2ITmpE4k5g1Zw=;
        b=GJvdN6A4xq0odly/PFFmpEQ3OirDyswOVJSS+cD4Mp/fLV8FrGZyLENVZ/BQN8wZwa
         qe+58QDua+o0REjJwX0Hk1g9yIwuh9xHb7BmXfBYQlPrv5rYNKtfmKYOIuvLFww1ZrDZ
         JA9mw4RReIN8Eekvg/UpSxp0B1Mqqq3kRvvrAjpu8kKQpCpizjjuAGn9VbgFliqToR8g
         TTDnzirVaWagyRKIu78dLKWbr3ZvoxUi3xzP0oPCn3fkDMjjdHppU1S54h699GjaQRlK
         RHOWxIynRFSWnvXuCjomDTQZdUmlI+wTnHGPeh6+cnK+P/U6ZzgB+GEhHMJGqVkHUCn2
         s80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429123; x=1711033923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxoX3q50e92OYO+T5SP4tCKLkh072V2ITmpE4k5g1Zw=;
        b=jzXPKzYz04pXxj/kEQoKWHTFqoAiWyW87/tW+vCmShZyCi9QpWa+u5LM6uLwqeDeza
         9w5tvULJPH6GOUkZNKXDDOoaAAlFM2MH7SREzGqAr6Rn8WuqjUyFmNtBZaUzZbUWRmP3
         7WrFT9YPeQM7tnWEjEgatld4tj7eUVXHxKnPJXskWucRmk0rCYWOQi4zzzLI7fOPP49L
         aeDErsLZAZ45MGvP0ryuY7VNIs+J8ioXHDIgZA0HioPqY1ZvKmbQmLWfn6qzjmFNLy8+
         EOMnHj3jkqZZkOA4oDP4F/HMfm89y2pyuIM0twYWyRVFUHA0SI1JQPpXtuXFF0tEShP0
         OlFA==
X-Forwarded-Encrypted: i=1; AJvYcCW2qYGewciAA7sAArgqOltcu8uBx6uCHpZ8Uc/gPohzIUpiQQBK67Cjd9qb8nf5ggCq5vRSQY/GB1k/o1gUPf9Vq8NliPFNsV/js0hetw4uTn1iJMrPuXv5q+t4Yqh+z5IQXpeNw+qzjyd+i3N+
X-Gm-Message-State: AOJu0YwqboBg7fUAtBxZqYgaizZnSwg7pj8n2uNjhT3VLTvmh9jwkP3v
	LPvrZsuRSi7VFJyYXFnwlC8XVFLksLnzRYa2pHsWFxoyUN8SdbNdJodi7o/e
X-Google-Smtp-Source: AGHT+IHZjJprxxmVQW8SpPTgG8HyHqVBV86iFSh3yVuG9QvKGx2x29469/lU/aouW0JA0j/YriRUnw==
X-Received: by 2002:a05:6a00:2d91:b0:6e6:9ff1:31b7 with SMTP id fb17-20020a056a002d9100b006e69ff131b7mr2344954pfb.16.1710429123351;
        Thu, 14 Mar 2024 08:12:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i20-20020aa787d4000000b006e57247f4e5sm1593768pfo.8.2024.03.14.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:12:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	David Gow <davidgow@google.com>
Subject: [PATCH] Revert "kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST"
Date: Thu, 14 Mar 2024 08:12:00 -0700
Message-Id: <20240314151200.2285314-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4acf1de35f41549e60c3c02a8defa7cb95eabdf2.

Commit d055c6a2cc16 ("kunit: memcpy: Mark tests as slow using test
attributes") marks slow memcpy unit tests as slow. Since this commit,
the tests can be disabled with a module parameter, and the configuration
option to skip the slow tests is no longer needed. Revert the patch
introducing it.

Cc: David Gow <davidgow@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/Kconfig.debug  | 12 ------------
 lib/memcpy_kunit.c |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2164f066e7b6..eccbc4764f3d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2703,18 +2703,6 @@ config MEMCPY_KUNIT_TEST
 
 	  If unsure, say N.
 
-config MEMCPY_SLOW_KUNIT_TEST
-	bool "Include exhaustive memcpy tests"
-	depends on MEMCPY_KUNIT_TEST
-	default y
-	help
-	  Some memcpy tests are quite exhaustive in checking for overlaps
-	  and bit ranges. These can be very slow, so they are split out
-	  as a separate config, in case they need to be disabled.
-
-	  Note this config option will be replaced by the use of KUnit test
-	  attributes.
-
 config IS_SIGNED_TYPE_KUNIT_TEST
 	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 30e00ef0bf2e..fd16e6ce53d1 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -309,9 +309,6 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
 
 static void init_large(struct kunit *test)
 {
-	if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST))
-		kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
-
 	/* Get many bit patterns. */
 	get_random_bytes(large_src, ARRAY_SIZE(large_src));
 
-- 
2.39.2


