Return-Path: <linux-kernel+bounces-45010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF1842A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8908D284D50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935B1292D2;
	Tue, 30 Jan 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R895J5Nh"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27E86ADC;
	Tue, 30 Jan 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634346; cv=none; b=Ru2cwrc9rrb3S1PZwU7C+uzl30H/aW/OF1U+oJJRUP/uxHfrkk1iMxrZJTsSsDXXKolZqoXCN6JprVit00oSw4qs8qHxHbwPcdaDmtvY1FKKKbcSYPRq7bELEaswq+HQumI5mlFpWf0lbWnXtg2y0DISuqrfePvoAHa6SmJy0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634346; c=relaxed/simple;
	bh=QC4YtFfqL/ZkTH/AF/bNmRRbxvCTQxIQQ8bFBkTG4Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jplGLJ67nxHXKTztOmWM7Q+s8WM4IixcrCknMrXAMKA6Zc2yw8xZE8RReI41wDm9SDORzOTA3KvWAnNftXgEE9aJxN1jqZlk/w7HyhPn5grsjE5u45CzjNhzHVS5waMSw+9lPN79ct1D/BsUaeo9dUCIrMzfAGCOUmM5BqHBg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R895J5Nh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d50d0c98c3so42255105ad.1;
        Tue, 30 Jan 2024 09:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706634344; x=1707239144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5wjSHabQXmyjK9UW/hisACzWIzHTQrBleOJJYviNOg=;
        b=R895J5NhqqtkTKCuh5vxuddtlyYNRMnIImOS763RpVW7JltL7a33z0FVZqeXujxjYh
         +ybUqGoF2srG4xtT+ejfs1oI5g/9RlUc2BBVCQdGg98Bmb1AzoL1hhrwyyDHaD2TwIx5
         k8R2FiIKoo7A4YM1LYdIemkOO9kD0JsDaMk6kizQ3Kb6SV89Ee1NSrerBVSt7KW99XAB
         ibdOatWKeyf6CTA2BvuBNFu4mHWiscGoZpzm2V4+azPEjqNayHi0ClfY6ysuobq12Ktx
         H68lJVlyg9I7mY0wpmZCmxt1UeHp9m5aebS2JnBQdsbHxiS+0kQUJ56cpFNT+0bb0a39
         y7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706634344; x=1707239144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5wjSHabQXmyjK9UW/hisACzWIzHTQrBleOJJYviNOg=;
        b=MKxP2Se+zyyfJIl2kzji68GQ0OKH4dxrnHrzuD0erTQ8eSLCCrrUT6l8n7c17YnOoK
         KB8N0PIJRymaw0vQEtzAnsqjkbwaxN2TnZAYSwppGaXYcy74FjyjPCieJUoY0eaHkMJ5
         nXfVkGMlMDwISr/FwQDIATsdL3cy9LY5n/xOlfaIAsz2bcjmUJ9D3I8TNrvqXoC60w1L
         ULDEt0GLyaJIDruLZmEGmTqNsJ2vb8SRk38rdqgwueWYptuUP812IGajE98GIIAdI29O
         Zxjd0s/QuA2jUYr0M3yB+X9vnJejTznIkduk6YdIJAmytNviTFccQRBTHxQeDgpHtw0r
         tHaQ==
X-Gm-Message-State: AOJu0YwaSpv0ZOW8tsuvMoRllq1zOmIcDzkGFGVdmMLLupSb/v6Fja6T
	N527Fj6tIE6viBjowd117oaXsN5oL7hPiTyzyzVHxWANFk/1EHT/vC8rwdL8
X-Google-Smtp-Source: AGHT+IF9h+ec4hX7PMv0DjY0NyVgQDYcJA6eGnLrAl4kCBW5eaciz/3qQQgvP4gvxy8PF7LEKafZQA==
X-Received: by 2002:a17:90a:d80e:b0:28e:6dfd:ad6c with SMTP id a14-20020a17090ad80e00b0028e6dfdad6cmr2021565pjv.10.1706634343944;
        Tue, 30 Jan 2024 09:05:43 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
        by smtp.gmail.com with ESMTPSA id sm5-20020a17090b2e4500b0028ffea988a2sm8856830pjb.37.2024.01.30.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:05:43 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Max Filippov <jcmvbkbc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] kbuild: tools: drop overridden CFLAGS from MAKEOVERRIDES
Date: Tue, 30 Jan 2024 09:05:14 -0800
Message-Id: <20240130170514.3640723-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Makefiles under tools/ use the 'override CFLAGS += ...' construct
to add a few required options to CFLAGS passed by the user.
Unfortunately that only works when user passes CFLAGS as an environment
variable, i.e.
  CFLAGS=... make ...
and not in case when CFLAGS are passed as make command line arguments:
  make ... CFLAGS=...
It happens because in the latter case CFLAGS=... is recorded in the make
variable MAKEOVERRIDES and this variable is passed in its original form
to all $(MAKE) subcommands, taking precedence over modified CFLAGS value
passed in the environment variable. E.g. this causes build failure for
gpio and iio tools when the build is run with user CFLAGS because of
missing _GNU_SOURCE definition needed for the asprintf().

One way to fix it is by removing overridden variables from the
MAKEOVERRIDES. Add macro 'drop-var-from-overrides' that removes a
definition of a variable passed to it from the MAKEOVERRIDES and use it
to fix CFLAGS passing for tools/gpio and tools/iio.

Cc: stable@vger.kernel.org
Fixes: 4ccc98a48958 ("tools gpio: Allow overriding CFLAGS")
Fixes: 572974610273 ("tools iio: Override CFLAGS assignments")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tools/gpio/Makefile            | 1 +
 tools/iio/Makefile             | 1 +
 tools/scripts/Makefile.include | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index d29c9c49e251..46fc38d51639 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -24,6 +24,7 @@ ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 all: $(ALL_PROGRAMS)
 
 export srctree OUTPUT CC LD CFLAGS
+$(call drop-var-from-overrides,CFLAGS)
 include $(srctree)/tools/build/Makefile.include
 
 #
diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index fa720f062229..04307588dd3f 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -20,6 +20,7 @@ ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 all: $(ALL_PROGRAMS)
 
 export srctree OUTPUT CC LD CFLAGS
+$(call drop-var-from-overrides,CFLAGS)
 include $(srctree)/tools/build/Makefile.include
 
 #
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 6fba29f3222d..43e1fbb8329f 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -51,6 +51,15 @@ define allow-override
     $(eval $(1) = $(2)))
 endef
 
+# When a Makefile overrides a variable and exports it for the nested $(MAKE)
+# invocations to use its modified value, it must remove that variable definition
+# from the MAKEOVERRIDES variable, otherwise the original definition from the
+# MAKEOVERRIDES takes precedence over the exported value.
+drop-var-from-overrides = $(eval $(drop-var-from-overrides-code))
+define drop-var-from-overrides-code
+MAKEOVERRIDES := $(subst -escaped-space-,\ ,$(filter-out $(1)=%,$(subst \ ,-escaped-space-,$(MAKEOVERRIDES))))
+endef
+
 ifneq ($(LLVM),)
 ifneq ($(filter %/,$(LLVM)),)
 LLVM_PREFIX := $(LLVM)
-- 
2.39.2


