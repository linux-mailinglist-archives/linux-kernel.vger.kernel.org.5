Return-Path: <linux-kernel+bounces-142162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FD68A2859
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF726B225A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629A350286;
	Fri, 12 Apr 2024 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu75JMON"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B750241
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907497; cv=none; b=ivOXPs3Nm/o8cVHOjX0K62A6HUMASpJuxdR9ONdc8yI4Aoq9CwH7kTk9nnCEU5Ekjy5zWJdDhCulE3rhMFZb0w8ydaiP+AvShpwTPueOpyUN6LNVT9c/8PUkaD9to1cGAIdBYYb0CytHqvov8K5DqBKw+Yt2r8qgWmYGhLvWnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907497; c=relaxed/simple;
	bh=GkrF5NbnmDIO2PSdgna9PVGIA+4K9OmSE88/osARHDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBDmctRTDS+UaKk792L9SpMd5UY0Qi4z9wndHMPGunZPnHrPWYmnPrKpLS8onGWn11j0SJdAggiis3VKi+mduGgJbBMHp5Pv+VZ6gO4zed6VlEnS/cXoW/OP3LMQE3/xGIUhCwsStlJH4qqUXska/uDuWoxKz+8HI2c587XqnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu75JMON; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3c3aa8938so4360685ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712907495; x=1713512295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKv+dOKRCJhG1tenSkeU7/8yjqgzALDAmJSETtZIvnY=;
        b=Yu75JMONCiqln6iIbS0A7A446Q9rpPavKaVSHz+sRrkv2CiGWkmFC9ZSCb4cCUmD+T
         HoKS2afIx28uzsFE/NIbRvpAm6UvK7buCwX9UzalN2Pitlqd/c5PtMjpoBYJmNr4ZgRq
         nwKTusC88WYakmjQstmSrzVjCl7YayeLTj1EXVU/OkQMl56UyXjHatvkrE4ieBxfI+oq
         Wp9aWKwi8crKpoLqUd8ZdtPQoS9f7ulo8hSOOOyJXLE25VGTt1MGPs6EjBK+B80Vvu43
         xVAMOmgkaB2ZTpYx348k//FM//BXzF/2RBKZeYpd1mSvd+smj3E0CGJmX9xCp50cGOuh
         bExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907495; x=1713512295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKv+dOKRCJhG1tenSkeU7/8yjqgzALDAmJSETtZIvnY=;
        b=miTY+PKdYRnCrefMaWnlgB879n1f7b5FHMWym20XIfv44WktpQbGMMIfq3+gymuO32
         nAv09t4gcXmMlYE7zXRI10wpGmLVL4c+9xKft7Vej73oPK3CpAshXY5OwHew238RDei0
         HxugoolqKcCcYXAtWVRqBdk/VD5aY9n/zaqcFpgwtWRGSZDzLFEqzWJThplVrztnHur+
         ZtqItH12yR0IcFyKExlQkVSfCnyoI5C5le8SisYZhoVRqTerVjIGKCQkb1Lk9ZbmoLaW
         Aab6Hpys0B0ybl6eJePLx6272R0L0dKu0E/6OSgipu2vEJlp+V2sxhT7+9uzFheAROMe
         30ig==
X-Forwarded-Encrypted: i=1; AJvYcCVDzXLz1n7xq6grZSudlrJv2HmXGl2ru227Zqkwei9p+yFZUYgS3gOpmPFFU63TJKQaEx/rOr+DHzWkINxoyADmMTRxu7SeEBanyn7Q
X-Gm-Message-State: AOJu0Yyu++BS2QB2N9mn5JVli9GH5+v13kS5WQ+21cLvjlVGBT0eBldL
	yLjqruTBzdc0bNWoZBZ/6iRhYYeqvDkIzrM2cUXx+9QQIU4fNtAK
X-Google-Smtp-Source: AGHT+IEs8mtcjto8rOXz5YMEcwZFJOMI1fiWwDFq30NXF3pGJzIMZvBmCkp2JLPcrzhMVIiefWw4TQ==
X-Received: by 2002:a17:902:e950:b0:1e3:e0a7:3c9 with SMTP id b16-20020a170902e95000b001e3e0a703c9mr2171282pll.14.1712907495496;
        Fri, 12 Apr 2024 00:38:15 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001e478f359bdsm2344011plh.127.2024.04.12.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:38:15 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	corbet@lwn.net
Subject: [PATCH v5 3/4] mm: add docs for per-order mTHP counters and transhuge_page ABI
Date: Fri, 12 Apr 2024 19:37:39 +1200
Message-Id: <20240412073740.294272-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073740.294272-1-21cnbao@gmail.com>
References: <20240412073740.294272-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch includes documentation for mTHP counters and an ABI file
for sys-kernel-mm-transparent-hugepage, which appears to have been
missing for some time.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 .../sys-kernel-mm-transparent-hugepage        | 17 +++++++++++
 Documentation/admin-guide/mm/transhuge.rst    | 28 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage

diff --git a/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage b/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
new file mode 100644
index 000000000000..80dde0fd576c
--- /dev/null
+++ b/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
@@ -0,0 +1,17 @@
+What:		/sys/kernel/mm/hugepages/
+Date:		April 2024
+Contact:	Barry Song <baohua@kernel.org>
+Description:
+		/sys/kernel/mm/transparent_hugepage/ contains a number of files and
+		subdirectories,
+			- defrag
+			- enabled
+			- hpage_pmd_size
+			- khugepaged
+			- shmem_enabled
+			- use_zero_page
+			- subdirectories of the form hugepages-<size>kB, where <size>
+			  is the page size of the hugepages supported by the kernel/CPU
+			  combination.
+
+		See Documentation/admin-guide/mm/transhuge.rst for details.
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 04eb45a2f940..f436ff982f22 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -447,6 +447,34 @@ thp_swpout_fallback
 	Usually because failed to allocate some continuous swap space
 	for the huge page.
 
+In /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/stats, There are
+also individual counters for each huge page size, which can be utilized to
+monitor the system's effectiveness in providing huge pages for usage. Each
+counter has its own corresponding file.
+
+anon_fault_alloc
+	is incremented every time a huge page is successfully
+	allocated and charged to handle a page fault.
+
+anon_fault_fallback
+	is incremented if a page fault fails to allocate or charge
+	a huge page and instead falls back to using huge pages with
+	lower orders or small pages.
+
+anon_fault_fallback_charge
+	is incremented if a page fault fails to charge a huge page and
+	instead falls back to using huge pages with lower orders or
+	small pages even though the allocation was successful.
+
+anon_swpout
+	is incremented every time a huge page is swapout in one
+	piece without splitting.
+
+anon_swpout_fallback
+	is incremented if a huge page has to be split before swapout.
+	Usually because failed to allocate some continuous swap space
+	for the huge page.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
-- 
2.34.1


