Return-Path: <linux-kernel+bounces-21446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3397828F30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C1B1C240FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1B3DB94;
	Tue,  9 Jan 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzuLYXpU"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA33E464;
	Tue,  9 Jan 2024 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so17289755ad.2;
        Tue, 09 Jan 2024 13:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836998; x=1705441798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnBPxEnXk7KjlkqXAC9IxPbYGia/n1Rz7kNemo9mTos=;
        b=OzuLYXpU6MDPhSKXnXt1NjtTOh40SWPUW27aN0ZSqWjv1sdsfe00FnTcc0yR7DTteR
         6OG3FCODfZdIKpGn4arcVmXizLHckzN5dHu839tJPumcKHWPjqoaSxm2B2OLt/otV+Ia
         nDi0pN+kC+sKSz69Sa3l5WUSor5E6nZxIGGtIdithUTH/Kc65c0m/N7v5r6PEe2PYK9I
         43Are2b90Lanvsid8LDBgo+KySMHlC0/c6mHaOc4bnqVGq1AoWh4FCu5N7KMg6yOdeVx
         gs4G71TvnH6cUEI5GLxCyfk14CqQLSqSayhRLXPnw5pxoIuGx/PjYnEC4Dh3d9SHhr0Y
         dZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836998; x=1705441798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnBPxEnXk7KjlkqXAC9IxPbYGia/n1Rz7kNemo9mTos=;
        b=ttAVTRXKYMiwu5b/OxiFEvY28bdeoQrz5gBCH0SD8oBuLtc7Ddmpf6wtbL4NquHCpc
         7ajQWCNjholz7UgMLhTIGc3HzMQ/X4WQXL1zRhaN5tWWqWgzrDoAy7iu92OIqwJtBuEX
         dZ41GrBxnDvk8Yejnuz6IvACZ+a0EcILGyHBRMy6ZSHBgYB3uHKUx5WSyqTBMjPyx/a6
         Mgh9xNSsz6xyUlNMsznuLBK0rtwso/P6xr/cEEWKI2KFuGbr/pO9FaTP+SMIK6snwbMM
         wM4SkFBQtGTRHDeslI/5/Z8j7DygD/nqPssWxB9E58z4iBU1bAbj+pMjEhz/KZM5uqC+
         c8iA==
X-Gm-Message-State: AOJu0YxmT4q3ajgHxNUehyLUwazEN+h2/c8G2UPF93Trtat1PIUXilD+
	ZycJQDOwTWrM7kRvE6F9REo=
X-Google-Smtp-Source: AGHT+IFY2Ld9moWymK/ytefZKpitqb9BBrNdq4JahB3/Dd7cexihzS/iRjzJ9kat+JUkyc//v6zpZQ==
X-Received: by 2002:a17:902:c949:b0:1d4:e36f:748f with SMTP id i9-20020a170902c94900b001d4e36f748fmr71428pla.41.1704836997726;
        Tue, 09 Jan 2024 13:49:57 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:b4e:5c78:a5b3:ef5b])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902bc4900b001d4b0ae7052sm2249146plz.135.2024.01.09.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:49:57 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Lieven Hey <lieven.hey@kdab.com>
Subject: [PATCH for-5.15] perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
Date: Tue,  9 Jan 2024 13:49:55 -0800
Message-ID: <20240109214955.451513-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <2024010711-skeletal-material-15e8@gregkh>
References: <2024010711-skeletal-material-15e8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

When a program header was added, it moved the text section but
GEN_ELF_TEXT_OFFSET was not updated.

Fix by adding the program header size and aligning.

Fixes: babd04386b1df8c3 ("perf jit: Include program header in ELF files")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Lieven Hey <lieven.hey@kdab.com>
Link: https://lore.kernel.org/r/20221014170905.64069-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[namhyung: use "linux/kernel.h" instead to avoid build failure]
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/genelf.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index b5c909546e3f..6af062d1c452 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -2,6 +2,8 @@
 #ifndef __GENELF_H__
 #define __GENELF_H__
 
+#include <linux/kernel.h>
+
 /* genelf.c */
 int jit_write_elf(int fd, uint64_t code_addr, const char *sym,
 		  const void *code, int csize, void *debug, int nr_debug_entries,
@@ -76,6 +78,6 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #endif
 
 /* The .text section is directly after the ELF header */
-#define GEN_ELF_TEXT_OFFSET sizeof(Elf_Ehdr)
+#define GEN_ELF_TEXT_OFFSET round_up(sizeof(Elf_Ehdr) + sizeof(Elf_Phdr), 16)
 
 #endif
-- 
2.43.0.472.g3155946c3a-goog


