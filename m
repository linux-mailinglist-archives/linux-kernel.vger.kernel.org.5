Return-Path: <linux-kernel+bounces-142163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC2E8A285A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8521C215C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6603502AE;
	Fri, 12 Apr 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXdsQzy0"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811450284
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907503; cv=none; b=Xiit6biFHUXSp6yaXiiDwgBTaueS0h51e5Krs6CK6RwOyRd/tg+Pqc5cNrI35+iSsVOuUHu1cKEMcP9kFAqC886LMrWq51sVBpw/UR4Fwq95MJGoC0vHuISfH19yDKjYoUzgG+LzC1U8cmoPbKlPPsQ4IAu4+N6XO7W6+F9DBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907503; c=relaxed/simple;
	bh=GdJ89Q45lpPvXsTdSxOkLG15s3X0yQKPT48wKzdZwts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQDWxlOPtYqjdG6gFW1WpzlFBxE/1sQnQLiUFnamB6dJReTXjOOjEqoaVlbuL7zMfeyrKoq74p66a4rJK885UXSQGo50guwV9x/J9aTewjfQha5akWhu6tUga96Vr1zX7RG8SJAV13fzci5FzVeC4aWzAp36ECAwGIDcBk9sHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXdsQzy0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e2232e30f4so6042765ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712907501; x=1713512301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLivAlSFWVO5qmFvXnJVwwxKOFwucVM2YU4CcxrDCQY=;
        b=MXdsQzy0+fhOR838TkLUoGxsbX9NU8a9ehJzao+0qm7XjJUh/OztgaPgXiZXhpzl1q
         FeQK7sQs77ZgpRW2IZj821FBswJceFHvfCIEC+oKIuUWs6b0TtuPqxE2I19owAN9bR81
         0l1qR7NuSkrSc3KfZTNddTC2B5EwuIWa0iGr+ruPZ6/SdYD8QpFhjHFB9veS4jaPo6uL
         9UFIvRK1nH2+AZArrZvN74wpXz+DNcUv57PjzKh38jeYxdDtz5Lkbpk9C85fqPfjcBH1
         aI5lUVPmy9qASpvnZtRqXLmrLL8T1TjgnInv523jevNEx5zZN9N9LdZFQrZDLyMFiW5d
         mkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907501; x=1713512301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLivAlSFWVO5qmFvXnJVwwxKOFwucVM2YU4CcxrDCQY=;
        b=P2yHj5CkvSKVy1KJBU4dZJdODUoea8bDHearuzIF2CEHUxM8rcYmHqnbIl+oxQlQ0B
         T6rtoh3ftUIm56ksD9cIuVdBvXCJ6jjN08KWebltK9OF+CjfqbVw7Wp6wgLYVdmJxbn/
         OvjzHKkmn+g4RyeSn60VWWpunh+ZtNwZ+m4w4PrKFtpvgvF6bYZHDb0qbFei21cwL60q
         NilgO9qOXn32yprJcdI5F/V9Ex4oVHqTVZnYgl/PgOinBsA2uY8QH6yXuSm4jk/3Xjp0
         1i+ZliLHqggrSsa7vrOcVQ3/YHBNjsyE6UjG8arAGnBLWxdreoeEGLEOVx7Rc2ALQwlr
         QOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Zhrd1EeI3jccLfRs5dELac9CMM57OUTlQqxKxZlnxkH4J+zp2BSkB+RHVEnFv4YY23Xehu5c0aokvdVCULnf6A2IKWiVIaTsn3Mu
X-Gm-Message-State: AOJu0Yz0Yt5rJp2yMLkfS0YzgbGhhCzZMhrgepj7ibe2eIK3OumGOXTc
	YrT9yH+11CoLGOkD2d9iOx9uMGMaTWEAKywRz+z5gN9AH5FWQXq7
X-Google-Smtp-Source: AGHT+IHgBpc7UAQvJAcCBWbdfiIookBgasRuDbzAV/jyU0fOVDPDt6/r0/rQy9bL8YhPtuipQpw50g==
X-Received: by 2002:a17:902:ec8e:b0:1e2:9ac2:4a03 with SMTP id x14-20020a170902ec8e00b001e29ac24a03mr1874586plg.28.1712907501110;
        Fri, 12 Apr 2024 00:38:21 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001e478f359bdsm2344011plh.127.2024.04.12.00.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:38:20 -0700 (PDT)
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
Subject: [PATCH v5 4/4] mm: correct the docs for thp_fault_alloc and thp_fault_fallback
Date: Fri, 12 Apr 2024 19:37:40 +1200
Message-Id: <20240412073740.294272-5-21cnbao@gmail.com>
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

The documentation does not align with the code. In
__do_huge_pmd_anonymous_page(), THP_FAULT_FALLBACK is incremented when
mem_cgroup_charge() fails, despite the allocation succeeding, whereas
THP_FAULT_ALLOC is only incremented after a successful charge.

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
 Documentation/admin-guide/mm/transhuge.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index f436ff982f22..98e3a99ea780 100644
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


