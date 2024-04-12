Return-Path: <linux-kernel+bounces-142611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C682B8A2DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B371F23A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A656B9F;
	Fri, 12 Apr 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVsV8e3K"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE553FE55
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922577; cv=none; b=rfG/BFGWxGfcAu+RK1GVH2+oa+YPgeq0WcpwpKt5/J0XqBDH7EmgixYsJg6lfMhkAc7xLyt2Xr37Nupr9OjypHKzECbmCO7+E0z/QDjH+XZ00Sw4GpNiaCwQhh+gdzL9NFa577Rb1rdi+r+2CPLVg0VHz0RJdH5Hq8Hrw6LsSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922577; c=relaxed/simple;
	bh=+fRyfCSzpNT7RQu6k6IdskSk6S1/8EuA2BI6cr2KdHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTn5NDfGHluOnYYNpjYqSSokiWfB8bSp4Da/pUbewUhZor0rXOBU3RPHyv95AMPrN0cYLE09+cAceKSPmIwmb3wtA2zMfCmTCKlzQdYQQigTz2LNbFIEzqsbD9T/JFGrHobGPRDnkoM3MaNND7HvyZFuVlForiwOqG01eDO2Hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVsV8e3K; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa17c69cf7so570514eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712922575; x=1713527375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkmaL5dnbNToitX+dr2yruhYVAPZI2DFDH1TSVGRV7w=;
        b=gVsV8e3KdSMmsdTgBQ6ljgP/+/l1Qreppdw9qiYrpJDKZeFomparVunLxmk7JdrgkU
         P20QR7aIvlz9jGdJcwl3W8EeZWz2rk/PDO/yS7ONGFEy2jUGWp5xAYFo8nNa5ikypkuH
         VYVv6fgcq+PxOPCGbUJfidOXLFrT9nn/htDwnEe8KzDxkgs+78hxDu13Kbbaq/v9OA8e
         TEq+dlmalHQppv45uDT9KF0ePI3VLioWhK2VjsQkUtEGcU1rNhSXBzI3SAVFc6G4fFnp
         /pmZX4Rs+/+blphOVJKqWNAedVrz4t0QugFrTQ96UU7FF1eXFFfJfUFQaRbRULPCShrx
         a2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712922575; x=1713527375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkmaL5dnbNToitX+dr2yruhYVAPZI2DFDH1TSVGRV7w=;
        b=o+ZMekDwajH7VJu33jHKxRjN5+OsBjCmoQfdu5dBGq1WsQsCQfZ/XxfcdnwJyRczXV
         he7SIKrumhWj8rYovXLRT1A2YyJOQWKo7r8331SOVOK8Pgu6P+TTl6VUyZKLSBtHf7+D
         ibGsjnma0CovkFvR2sAspoiSjVCI8/a5cj/XkMJEHvwEw2aO63EcsxMriZ+ygs54JUET
         urgenF5biKcxxy/pLaZls4YV2Yzs9CTvxIWlAuZ+OrIPYZk9Y0vg0yHgxC4H/a5Pk1ha
         zcKUQ/29sqpy3Z3R+CPHCimtHIt6xjuX78BlEnGWOORx+hWYJfJfSOFbQj01QFPyGW1X
         jWuA==
X-Forwarded-Encrypted: i=1; AJvYcCXXTHGga6OYuhgiACERSdNqRQdxbbtzUhz/TgAOXGr3jVfUYmG64K05ouWUdspSWi4SL9j4wWBP9GsHrZUdq0ERILOfUFuVYVF5hmwW
X-Gm-Message-State: AOJu0YyTgTdkoVJCLxiaKyZ7N3ybhpclayjCXBYN2az+JgMP38Q3ObQU
	GMY7yRTCq6AUEbs6U+K06uSkPDKk7ppIzko5RU99vKDsSe66F9Oo
X-Google-Smtp-Source: AGHT+IELpsWoBmGsNvBBR/x1yJEqJQU0ioXXjh7/o28t3fv1i7+x6sXnF0k1SDCwzsvXK5vX3cvAmg==
X-Received: by 2002:a05:6871:b27:b0:22e:a204:9bb5 with SMTP id fq39-20020a0568710b2700b0022ea2049bb5mr2485122oab.53.1712922575076;
        Fri, 12 Apr 2024 04:49:35 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id q1-20020a634301000000b005e43cce33f8sm2541048pga.88.2024.04.12.04.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:49:34 -0700 (PDT)
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
Subject: [PATCH v6 4/4] mm: correct the docs for thp_fault_alloc and thp_fault_fallback
Date: Fri, 12 Apr 2024 23:48:58 +1200
Message-Id: <20240412114858.407208-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412114858.407208-1-21cnbao@gmail.com>
References: <20240412114858.407208-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The documentation does not align with the code. In
__do_huge_pmd_anonymous_page(), THP_FAULT_FALLBACK is incremented when
mem_cgroup_charge() fails, despite the allocation succeeding, whereas
THP_FAULT_ALLOC is only incremented after a successful charge.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
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
 Documentation/admin-guide/mm/transhuge.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index e0fe17affeb3..f82300b9193f 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -369,7 +369,7 @@ monitor how successfully the system is providing huge pages for use.
 
 thp_fault_alloc
 	is incremented every time a huge page is successfully
-	allocated to handle a page fault.
+	allocated and charged to handle a page fault.
 
 thp_collapse_alloc
 	is incremented by khugepaged when it has found
@@ -377,7 +377,7 @@ thp_collapse_alloc
 	successfully allocated a new huge page to store the data.
 
 thp_fault_fallback
-	is incremented if a page fault fails to allocate
+	is incremented if a page fault fails to allocate or charge
 	a huge page and instead falls back to using small pages.
 
 thp_fault_fallback_charge
-- 
2.34.1


