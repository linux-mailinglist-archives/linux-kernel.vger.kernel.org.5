Return-Path: <linux-kernel+bounces-9057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD4081BFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA421C20D33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4DF65198;
	Thu, 21 Dec 2023 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlSSALkP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB9760B8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28bf27be6c4so543515a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703191206; x=1703796006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2n7W31aNWMIkIL9wLBmZYYyUB9rGbrcDxhFrQaq9TQ=;
        b=dlSSALkPwOidhgB447+auCT8KSl/M5ZtN6RnYY2yh0k+vPE1cLK+IbgGARvDV+y3OF
         yTPCCeavvymFh6BaOFPUOSv8gSdTVfs5lYZJX05L2cYR3fl+vrWxYMhS7G+6AJpuHNco
         Flb0kyvjzuqjXDYOsCS9+OEC2vPm9FbYVAN238DLWjv5rkdm8HmMXFxUjHLedgkkHtKX
         jNBomSrfoMdg7SLxUsSE7lFhp5jIDV8gjGCboJQ3FryOMykUfsJ2cmvAJ7WGT5SnNgBx
         fvtkYPlravxYRgims4imvfGGjpk6kUtoTwnfgSLqg1QYbugrnATzNTOe8uPZUxylwpZk
         gVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703191206; x=1703796006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2n7W31aNWMIkIL9wLBmZYYyUB9rGbrcDxhFrQaq9TQ=;
        b=mvX/RvInOBP0B7OJzay4gGeVUnyi5Hlbz5yDz5bQl4w4h6gcgaaktSg3L40iRU8OoN
         2zX8F9E4OiTCwCZat4fyS1bMoNdXKljUfQ5MPu+XBGckHBuyjaxpfC9kUlH+P5tocMnX
         DCQPS2GHBOoj1j1T4EJ7IebJ45lBM7OCxFLIz5K+mbyjLI3aS7cHrvIXP3CHtO6F60hX
         yzACa/c1f+/11CNbbciydWnZxAUAmNpUBbZGVaXiIJF6LKOi7yU7r7QYxi4eLidINY9x
         b02tUi4B/C6OTofcZjtvR+Xp3WePXhtLc8sd88xdCJvbfvclot8bGvhWtNBvfrUcMaYl
         ENuQ==
X-Gm-Message-State: AOJu0YxGZJdRXr7DhBieDELU44Lq0MxX0lFjItqbKm70CHMX89Lq2WZ+
	R40rPYKqGZNr3/8eItNnOx4JyFacsAz8aQ==
X-Google-Smtp-Source: AGHT+IHqBBi7MQB9335VyFpUAMC3Wig4NgFozmRCB+kcn2IAn4Xucox+CKjMVBCYYtR61k48BQTm7A==
X-Received: by 2002:a17:90a:7285:b0:28b:e0e9:4816 with SMTP id e5-20020a17090a728500b0028be0e94816mr313510pjg.65.1703191206378;
        Thu, 21 Dec 2023 12:40:06 -0800 (PST)
Received: from vps.terceiro.xyz (vps.terceiro.xyz. [2a02:4780:14:7710::1])
        by smtp.gmail.com with ESMTPSA id nh24-20020a17090b365800b00287731b0ceasm5842518pjb.13.2023.12.21.12.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 12:40:05 -0800 (PST)
Received: from localhost (unknown [IPv6:2804:14d:7224:8745:26f4:3599:ce80:10])
	by vps.terceiro.xyz (Postfix) with ESMTPSA id E4E5D43EA0;
	Thu, 21 Dec 2023 17:40:01 -0300 (-03)
From: Antonio Terceiro <antonio.terceiro@linaro.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: uevent: use shared makefile library
Date: Thu, 21 Dec 2023 17:38:47 -0300
Message-ID: <20231221203849.339025-1-antonio.terceiro@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the uevent selftests build not write to the source tree
unconditionally, as that breaks out of tree builds when the source tree
is read-only. It also avoids leaving a git repository in a dirty state
after a build.

Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
---
 tools/testing/selftests/uevent/Makefile | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/uevent/Makefile b/tools/testing/selftests/uevent/Makefile
index f7baa9aa2932..9d1ba09baa90 100644
--- a/tools/testing/selftests/uevent/Makefile
+++ b/tools/testing/selftests/uevent/Makefile
@@ -1,17 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 all:
 
-include ../lib.mk
-
-.PHONY: all clean
-
-BINARIES := uevent_filtering
-CFLAGS += -Wl,-no-as-needed -Wall
-
-uevent_filtering: uevent_filtering.c ../kselftest.h ../kselftest_harness.h
-	$(CC) $(CFLAGS) $< -o $@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
+TEST_GEN_PROGS = uevent_filtering
 
-all: $(BINARIES)
+include ../lib.mk
-- 
2.43.0


