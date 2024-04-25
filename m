Return-Path: <linux-kernel+bounces-158042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8D8B1A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775A81C2109B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C743A3CF63;
	Thu, 25 Apr 2024 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShEoqoQw"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68A39FD3;
	Thu, 25 Apr 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024972; cv=none; b=RjOhsFWK1dKEK1rbsJDFXqDgeeAzklJx4eJveFjhYusyb1RfWnBOnS5uAcdrVkcrEEWykhuNmM/Wng7iZf0boZxZljM/2EbS2T+qdh6yQAxYzHZhmsohrAEQhbBuC/rMX0tU+76Pj2nFF8s0qYUgwAJwYTs0dRcNiEGB3NdyRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024972; c=relaxed/simple;
	bh=sC0IelbYeJYIu+qeRy7j6jZ4kH6RMzf84bLgmSYcag8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KckBvXCYjEwFA1pCHHFfEXIsIPzWTXjXY+M1H00lSSWZZlzBogxDcR4ALWaGj4xdMsTVgDCjzQMqoaUM7E9tmb6fCyJW2Z5Ok5zRUiGb93veMEDauAd1OLsq/L+SXDDSnee1muAhcEBQXKWlpGWkGJ5JN1f32Fuem+uE896p2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShEoqoQw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso597926b3a.0;
        Wed, 24 Apr 2024 23:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714024970; x=1714629770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTdEUJ7NZqvAT2gBeyJUpJaQhE398XmsjxeM6PTnkZY=;
        b=ShEoqoQwRsDoWo7RGR2u7BoU8fvfABg26zldwvoEJib5xsm7JlnAIc/jAN1cJK6V6g
         wF6QC8JwT0jgkFzzK8YvHf3ffATFinhr7KlKwOsgSBnR67/DvwyqT09hp8hEQcpXdcmc
         aJkvHcm7dns/MiUJamnbrUOTDhypvPfpCqPfa+jxkohzZzAKFkTlrbmsRRJZofXdy/jj
         56mN8gg0c4z04Xb9FvBpXbG5fbHmxEol4LrPrcXPPX68vn07b+xlSKHVd+kq6XBKnUei
         GcVCIdsvtxtxHsaz3or9OayR25OepA4DsQ9CFcfoLNlEegFpWPY0qMyrhp2YZ+o/sxY7
         QZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714024970; x=1714629770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTdEUJ7NZqvAT2gBeyJUpJaQhE398XmsjxeM6PTnkZY=;
        b=ayLCfkI3YJmqAaHT9FznjEJj/jnfFgCBKDc1sfL/FVrjAXZiFqULLV65kNutq1iTs1
         bH52GBC8u43lEKRG6Hsfj436pT1F2QLhYsKnmOze3aB8rafDvRY5UbkI+yGoAjA/qQgy
         r/zUI2Y0bHLALsAMqSpjWTw1VPLjeJ3fRGAbp296gJ1Ci4OGOwWJHr/mMe0Tv4kyfL0G
         NnwQsB2/Y7GmMAi5nkeGRZ8jV35yrKqYgIYtm15o6ju+0oPnE5LO2LvGv3iiCig9X4jK
         kI7t38w9T8Q2JbCrThnQ5vdKowagFjvM9wBFk2lbmm/KOtvPA9lzrwebld/aKwMCOkwR
         Jr5g==
X-Forwarded-Encrypted: i=1; AJvYcCWhjZHLgFSlRapXkcPBY36Lsth2tMhmfLgKgL2TU+axFQFrprvIBgtoJflF4+mHMumBZ1l7HB+Qq7fTikINE2PYbRlgg4Ynlb3HCH0zvIpD1lQczaSitk3f0svbYIapkLUie62ElXhPGIGGLmqN/Q==
X-Gm-Message-State: AOJu0Yx878qumeuZqjb0gKWRx7UbKGn/n7MXOckbUa0qE9sTX6xKQIUB
	T4uXD/vjh7kvAPlKOlEsbe9UsjxOJH4AZmXz8sgTnC+UyPuuolgd
X-Google-Smtp-Source: AGHT+IE48rYcpwlz/npjcqGt64GIbI+VrEHs0XfecIpjAneEsL1ZMzBFdQZjZgdcdIoy+FiXSKJJog==
X-Received: by 2002:a05:6a20:3c87:b0:1ad:7be1:a4a9 with SMTP id b7-20020a056a203c8700b001ad7be1a4a9mr5657957pzj.34.1714024970152;
        Wed, 24 Apr 2024 23:02:50 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.143])
        by smtp.gmail.com with ESMTPSA id o6-20020a1709026b0600b001eab1ea2165sm598760plk.201.2024.04.24.23.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 23:02:49 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org
Subject: [PATCH] perf record: Fix comment misspellings
Date: Thu, 25 Apr 2024 14:04:27 +0800
Message-ID: <20240425060427.1800663-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix comment misspellings

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/lib/perf/mmap.c       | 2 +-
 tools/perf/builtin-record.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 0c903c2372c9..c1a51d925e0e 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -279,7 +279,7 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
 	if (!refcount_read(&map->refcnt))
 		return NULL;
 
-	/* non-overwirte doesn't pause the ringbuffer */
+	/* non-overwrite doesn't pause the ringbuffer */
 	if (!map->overwrite)
 		map->end = perf_mmap__read_head(map);
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3994adaf4607..34d103f4af57 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -332,7 +332,7 @@ static int record__aio_complete(struct mmap *md, struct aiocb *cblock)
 	} else {
 		/*
 		 * aio write request may require restart with the
-		 * reminder if the kernel didn't write whole
+		 * remainder if the kernel didn't write whole
 		 * chunk at once.
 		 */
 		rem_off = cblock->aio_offset + written;
@@ -402,7 +402,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	 *
 	 * Coping can be done in two steps in case the chunk of profiling data
 	 * crosses the upper bound of the kernel buffer. In this case we first move
-	 * part of data from map->start till the upper bound and then the reminder
+	 * part of data from map->start till the upper bound and then the remainder
 	 * from the beginning of the kernel buffer till the end of the data chunk.
 	 */
 
-- 
2.44.0


