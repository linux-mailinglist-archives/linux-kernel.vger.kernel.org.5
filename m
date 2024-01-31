Return-Path: <linux-kernel+bounces-45741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9EF8434D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E47E1C221A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F917BC8;
	Wed, 31 Jan 2024 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBkCTfS5"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71E20DDA;
	Wed, 31 Jan 2024 04:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706675120; cv=none; b=iqI7nvMTk7vRFJmaQ29X9/ZMxy3GdPWTx3lMhxbk/S40l78Aw5RG3sGZxRu6D+B+RcdKPsMIN0diAivaaPWgXfF9jTF0pWkKrHZjJDJZA/XA/guE/mbqesyDtNIIzNJzm+kl0B+PJqPAFHEx+Z1QaGaDrhDWppGhabHSN9VH21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706675120; c=relaxed/simple;
	bh=xMlVeUsFGxYNCpqcspWBNL05NuVM6y84tCrJBreSpAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R8gH72pPo4RtnnJqZvScASIMIwMW8KRi98/zW1jkWTAAz3Pkyl0OmPXNrunAoPEBWKk2HDx1p03dXKQyvH/kDO4fIcZ61xtP8WjK/bU+YNUYtdSqwaEO4elaYRJYx8Wavpvn2xjty2fXmrysi1mSGD7ktTes6qUhwUjL+qk+ogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBkCTfS5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1686073a12.0;
        Tue, 30 Jan 2024 20:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706675118; x=1707279918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zha8wYy8WlcwDCuU60s5IZGwiNRJ0LRFCCEU2An/LwY=;
        b=aBkCTfS5Bi959Su/buIrBA2WqVA8zgYLVxzY2m2bo0O+hg8gmW9mFaIt7tXqCkRc0G
         Rq/gF3WWx1ghPkD7Yy+fB+8uymQGB9EAAh6cwTwLtldScawlpW0OwEN1tgdyPCPOxWM+
         wfmFI0SBCRIuzanIj58sf39EdcSYfagRJDcF0KWKIFFbbgULMw/Ik8Q4FoLwGjoinC++
         bvSpxWFYJ8RFl6Ncvn4gx+wxlfw39X9hW7FpSOdzWPwgONmrqQqL+zI7BOgZzXmUicXX
         oSrOBl9Pbk6pXNVfSuDO5JF4WHjZH6vH5s2h4RZtqpP6ni77u0Il18us7kfIF9tbzOIQ
         bz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706675118; x=1707279918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zha8wYy8WlcwDCuU60s5IZGwiNRJ0LRFCCEU2An/LwY=;
        b=BjINOOgKh2DLXDChcN4jZR9mVOIpysPaLZ7N2/VIFZUl1EZ0jD9nbTY/ixf5Qz+SJ5
         p+9WlC6/w+E4KuFWafyrZg5SnFdLzOLy0MIDk4Ds70WSGdjlxl2e3qXqf9ckgkDt2iVQ
         e9fxzGbZV+8JqMQxM64K65ZSpbauWrF/JyXpux8oz2uQG0UValDz5bCNYxRizae7zQxk
         KlQljvZ2ezIx9g/ATl66g8oXfFinR+qFYrBHIjEaT02962mXQzGJYcOxnq1da0YfA6KQ
         RsftaynGE99yKLUO5BGZLAi8y1xty1ODbe+XJpjZPt7VMQdOkOxzfV/B0PC65O7uyV7x
         szaA==
X-Gm-Message-State: AOJu0YwIt4R3eISe76mMfcv18/hXb5RYxd+1rTb62BMm+KgAUva5FKIV
	4j2vIWbjmM/MVXsn7tUTSXsAABrkZOVmin1I8lyfAuXXUMNZ1GG9puh94LMr
X-Google-Smtp-Source: AGHT+IEmq7aTNHaFqy1c69LxAZz5ni4bK7qs2bTnVnqPfhDZ2izJVKzmAPF/fjB+bbhF5gd40db/wQ==
X-Received: by 2002:a05:6a20:1824:b0:19c:a2aa:67f8 with SMTP id bk36-20020a056a20182400b0019ca2aa67f8mr461436pzb.24.1706675117928;
        Tue, 30 Jan 2024 20:25:17 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ac20d00b00290ffbe5ca3sm274867pjt.55.2024.01.30.20.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 20:25:17 -0800 (PST)
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
Subject: [PATCH v2] kbuild: tools: drop overridden CFLAGS from MAKEOVERRIDES
Date: Tue, 30 Jan 2024 20:25:09 -0800
Message-Id: <20240131042509.4034723-1-jcmvbkbc@gmail.com>
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

This implementation tries to be precise in string processing and handle
variables with embedded spaces and backslashes correctly. To achieve
that it replaces every '\\' sequence with '\-' to make sure that every
'\' in the resulting string is an escape character. It then replaces
every '\ ' sequence with '\_' to turn string values with embedded spaces
into single words. After filtering the overridden variable definition
out of the resulting string these two transformations are reversed.

Cc: stable@vger.kernel.org
Fixes: 4ccc98a48958 ("tools gpio: Allow overriding CFLAGS")
Fixes: 572974610273 ("tools iio: Override CFLAGS assignments")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- make drop-var-from-overrides-code work correctly with arbitrary
  variables, including thoses ending with '\'.

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
index 6fba29f3222d..0f68b95cf55c 100644
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
+MAKEOVERRIDES := $(subst \-,\\,$(subst \_,\ ,$(filter-out $(1)=%,$(subst \ ,\_,$(subst \\,\-,$(MAKEOVERRIDES))))))
+endef
+
 ifneq ($(LLVM),)
 ifneq ($(filter %/,$(LLVM)),)
 LLVM_PREFIX := $(LLVM)
-- 
2.39.2


