Return-Path: <linux-kernel+bounces-9064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E181BFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5771C236D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359976915;
	Thu, 21 Dec 2023 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBV1VhVx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352365198
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so8819675ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703191831; x=1703796631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uOfPj2Q+q1GabvEBW4PAKeTZk6gTmtF2RR9hYTuA4J8=;
        b=SBV1VhVxPmsAUlOq2QZNx24UnYMKq/KRmPC3bBkRqYV5pV754N2PduuA+MSKlUm8uw
         jLyqMCUT3BtvDqwUCXHBmemDpU0zle2mBilhbEELob0RgLahMWDcQZpG7fEtZI1/NF+k
         JNKGzcKHPP29tjhMuIY2+5C6cxakoKOd7ow0LS0HN6rOpEaM5fBsLsa/R/zSsXU/Q/1U
         vM0h4iikr0mBVPjZQ7vUv4cVrmDa1VRzGst/Ey/0FSYn1JHdH3Sx/9CuA6BhkXzuiC45
         O8mFzmsSBTtDZRMfbeU0yLCq5nfjXjAN1p0Vbb8HK1NmAP5xh+rN2W9fuLDJ2DoloQ51
         YgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703191831; x=1703796631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOfPj2Q+q1GabvEBW4PAKeTZk6gTmtF2RR9hYTuA4J8=;
        b=Z6d1HTRPoFtoc8jrTW9jgVFLIFelO/Bu3b9B+qgxFD92jbwzDnYXwd/msLICidKVj2
         fR9hOMpcNjZWsIP1oFe+7olm7ZyIEBvnN5TctWV1wiqMR3NyL0o1pEVPxiWngs/sWJkX
         XsSftMucBSW0SyKb0tYfnwyXlFRv19HUueclguyZaKfBHQOvMOIT/wczTDAEnlGfeKKL
         QPiNS5eKMYK4UhOTwJC9fRYeH5GEgsWnuMnOWaC335Ls7CDt9bjtkk+GWfPA1YYGHyqu
         4g5urk8q2lgZmI0TEjtKqDaiSGw7noYu+1HlujUJhZJFGxPWMasdOAqUHDbuQKNONzNN
         zYHw==
X-Gm-Message-State: AOJu0YwxMt/LKhx83F0qTFLRTx1QaWOybuwVy1+P3KRd1zd0HTqpvFah
	S2nT14PejwUaobeEFlLKJqyK+jprMeeWHpCGLmwEASFyXSbUkg==
X-Google-Smtp-Source: AGHT+IHKZxWcvBlzV0V4OljK+4Tlcyto05jSa9J5gRhYLyHMyIxZUUwz7TUiMSriCf+Rjrem1VSHEg==
X-Received: by 2002:a17:902:ecce:b0:1d4:15ec:1c7b with SMTP id a14-20020a170902ecce00b001d415ec1c7bmr268745plh.40.1703191831403;
        Thu, 21 Dec 2023 12:50:31 -0800 (PST)
Received: from vps.terceiro.xyz (vps.terceiro.xyz. [191.101.235.31])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001d1d5fb96f9sm2116738pli.27.2023.12.21.12.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 12:50:30 -0800 (PST)
Received: from localhost (unknown [IPv6:2804:14d:7224:8745:26f4:3599:ce80:10])
	by vps.terceiro.xyz (Postfix) with ESMTPSA id 6AC5543EA0;
	Thu, 21 Dec 2023 17:50:28 -0300 (-03)
From: Antonio Terceiro <antonio.terceiro@linaro.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: uevent: use shared makefile library
Date: Thu, 21 Dec 2023 17:49:08 -0300
Message-ID: <20231221204908.341677-2-antonio.terceiro@linaro.org>
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

v2: drop spurious extra SPDX-License-Identifier

Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
---
 tools/testing/selftests/uevent/Makefile | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/uevent/Makefile b/tools/testing/selftests/uevent/Makefile
index f7baa9aa2932..872969f42694 100644
--- a/tools/testing/selftests/uevent/Makefile
+++ b/tools/testing/selftests/uevent/Makefile
@@ -1,17 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 all:
 
-include ../lib.mk
-
-.PHONY: all clean
-
-BINARIES := uevent_filtering
-CFLAGS += -Wl,-no-as-needed -Wall
+CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 
-uevent_filtering: uevent_filtering.c ../kselftest.h ../kselftest_harness.h
-	$(CC) $(CFLAGS) $< -o $@
+TEST_GEN_PROGS = uevent_filtering
 
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
-
-all: $(BINARIES)
+include ../lib.mk
-- 
2.43.0


