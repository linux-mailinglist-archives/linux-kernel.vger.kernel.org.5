Return-Path: <linux-kernel+bounces-142221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B38A2918
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678F4288408
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D0502A9;
	Fri, 12 Apr 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OstvQRFc"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5E50295
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909893; cv=none; b=A5qCsJziKTJWT7ILhBmyKX1O1C5SpENQzCo+BDQDabR1AKQkQ6NIydtnX8W3ZmvAzgkgMW1FXliGzY7DMGBxv+yghA5PhEgBFPHt9/NO4mEabyZ62NVqB553TRq47keLj2+QPdVpWpgSpV0eOdVMrp1+glI1315KrQgmzyj49ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909893; c=relaxed/simple;
	bh=KzPMVbana8TiSaA8thC4KMln8RTxG5ZLHoyqtLjW0S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oReDW+Diub6OJZoNMw5bm/1h/yYeuWaNJsN8oAglAjxEuJ8sdYprTsrhYvoAN1888GurIz9t/YXKmZDH7CUbXTwdVDh1Acx+FhMHVzvKMLKHrgpKvxRFZAQSdCDqs6OEJLQkBhMm098Gx5BD/bJK9/6O4ghQ6t0abiowvX7V6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OstvQRFc; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a1b0777b7so2842685ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712909891; x=1713514691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z/S0JXWjoRuuPKL2UssIL3hxd3XwZ37iy3A+3jdU90=;
        b=OstvQRFc96Vz1l+YOxxnLetTCfDnlz3Nz1UTNYtS78NoVLfBplLWJv0YaDHpYDB/l5
         +5chpF64fEGJe3FKyMoN+7CYSYDz5l4aaF0XOTi3Ma1rNn2tbS+zU3Q2ENeD4CGVe/6E
         3F4ajX7hg0n5EAyDRtE+joTgARTmCyRlIoavwfX/+98kXLR0MBVUMi3odwVFkdnROw6N
         y1KR0qq+GncCoEpCd8F0X386J9h0zhJPC8Q5luLl4MtoQqRJiZ7OHltVpQvDpdJN4hAI
         2w63FJbTyKbCBLXXMZI1C5j8dkzw5DseViMn8K2nWdzIGiJfXya4hHojdU0CSJRWW4rf
         Ws6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712909891; x=1713514691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z/S0JXWjoRuuPKL2UssIL3hxd3XwZ37iy3A+3jdU90=;
        b=C6nHbH3O/4im/sQY6xN2w4EK4pIp1lqRsPV7+1JTfhs+y2YhYBLJ6hoVfAZGzDNVfk
         FROFXQKW69V547qm0WA/IA2tx/2K+5Zn/NlgfOT4kLynFwSJ9wuvIf93OMIDu/bQs4SA
         REmQHb1JaWJvdLpyVY5zdFkZjWnBnHvaaupqWY6svv/1Co5XrSDKTcz4i06JGeIpS7Hw
         N6zutmiq5BTDOXve/CwRji+59yp1C/CfpAGDLWlHProibCvvkImVpklBPE/5k2Q0ikov
         tHdPFsI63XUboJsu34wqJgX+j8YKBqXHOpyg/TFcviNDEKZHmBcaMwyZ84l+XyB6X1HE
         MWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVlGvaAI/HH+7XXkn0O+16ozxXMpXs+15NxGF5XUMkEI+yPXRFp3Ay/LslAi6CJ4V6lT9dkJwtyC0UFsl5lLeGMbVLjKcrdilAFEY2
X-Gm-Message-State: AOJu0YxsfR5BxNVbQ7ORpGtV7ziq06qDoZu1NhojySQbgfY61wv68wj0
	cwxqeAM3tqNasw4BqLirSe++NODyIJry9mlxIr8DyPFwssMVoUGfrj3VAwaT
X-Google-Smtp-Source: AGHT+IE6QL9Yv+g5wF4U56xNiAikOCBXhmbZYntiL8DHeT5DVLjEOFHxr70nUK7WDsP5bNY++NoYWw==
X-Received: by 2002:a05:6e02:1c0d:b0:36a:3ee8:b9f6 with SMTP id l13-20020a056e021c0d00b0036a3ee8b9f6mr2107946ilh.12.1712909891600;
        Fri, 12 Apr 2024 01:18:11 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id i15-20020a63130f000000b005f43a5c4e7dsm2276393pgl.41.2024.04.12.01.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:18:11 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	christophe.leroy@csgroup.eu,
	geert@linux-m68k.org,
	jpoimboe@kernel.org,
	kjlx@templeofstupid.com,
	linux-kernel@vger.kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	rppt@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH v2 1/2] init/main.c: Fix potential static_command_line memory overflow
Date: Fri, 12 Apr 2024 16:17:32 +0800
Message-ID: <20240412081733.35925-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412081733.35925-1-ytcoode@gmail.com>
References: <20240412141536.3f59fde391a6d28181562dbe@kernel.org>
 <20240412081733.35925-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
static_command_line, but the strings copied into static_command_line are
extra_command_line and command_line, rather than extra_command_line and
boot_command_line.

When strlen(command_line) > strlen(boot_command_line), static_command_line
will overflow.

This patch just recovers strlen(command_line) which was miss-consolidated
with strlen(boot_command_line) in the commit f5c7310ac73e ("init/main: add
checks for the return value of memblock_alloc*()")

Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 init/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/main.c b/init/main.c
index 881f6230ee59..5dcf5274c09c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -636,6 +636,8 @@ static void __init setup_command_line(char *command_line)
 	if (!saved_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
 
+	len = xlen + strlen(command_line) + 1;
+
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
-- 
2.44.0


