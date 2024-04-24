Return-Path: <linux-kernel+bounces-157011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756738B0B89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005DC286557
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3D15DBD3;
	Wed, 24 Apr 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8mc1DXR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7415D5C8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966779; cv=none; b=G+6wQxmaet4VOgDZhgMWTjmbjHhCmn5fsbVT5kpeakaGMUD7AlLHj9qDZg7FjcXIRaw0pSpfSBKZYfH6QofAhWRPBe2LN5eCw98G61T2pIpT63sAiaG7JQCFuaqBBKU4W4tmHQh+lAPNCJFpy407oE3236kq7V/TMXSqEOErZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966779; c=relaxed/simple;
	bh=+xKrOCV1NG7eBg2fbHAfofVmu/gykOvs2nTXsXXhO0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MohwDN9kcN95cDfuWeIc3fIABFjhKf8CjwG2eDJPBkFvTwNgUEyqXUW2EgAWBYSRaO/dptY4awJqNzSObz3qKhdjGmY545IuZBb1FX4RjArikGG1zoqx+1tsHrTAyfyCbBdj4kJzh7YvuivZjHge/RgNnkxil0Ttl7dmRQ1Qpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8mc1DXR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e455b630acso40084505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966778; x=1714571578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsoxQhAv5AuN2yRGgG+xM3faRIluQo8URp1tUZQwKu0=;
        b=Z8mc1DXR1cde3AI1j2ZFRDrfAkAtPGKzIw59Z8eMlaP3fv1IrM3/xUCTsvc9LlaXKW
         +8UO21agWC6idAA49/zvx8kcgNhfi4EUVrzuhidFmOFElM205IwW6BW52YPCoNoXITsX
         nE1Q2hvMpk0O1mGuD187EpdPFlXz4m6arXiCXlViEwRsXmdo/7sroha9ScH8UsduIky8
         iLSc83PJSmF+4JlH+m6yHK1jaP89JaB5dWWyhgDhDkXy+LQilX3o057KWTq3pB+HRal4
         hHHTChVLV/p7cTuNkNI8nlFebH0VJ7SbZ8p8Ssm3jBeN1B/1ZxdZi4vwlS6vEDRYzKxO
         WTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966778; x=1714571578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsoxQhAv5AuN2yRGgG+xM3faRIluQo8URp1tUZQwKu0=;
        b=qZ7Anaht8tC95h1ghceTDneeTt09B9fq2N32mGMSdHBUguZ/h1RIpOPYk+/NBB6jdw
         hnnAivPiWdFsHuSQEcFjNlONHO/3J4LVVw5S1dTqNl+jg32G7EO5cTtLDnYKSkooFv0l
         Zt13rzpjj6EYyteoZ9oE+DmGMg1f+sGVO4uCuNTTDV6tRSytggzujzJqsAQqYuyyYFu4
         sGKSlzOGKjQtHqVq8rFymrTJt8U1k2E8BlaIA9uaqS8SaoiMBA0iH7Kna2VYHzM3ulRv
         FE+vZI/xb/D1A49fBeFgHA5Fc+v6rFPoIy/doFn4C/AKDnmBFWPRMHZgjoIhG4cFcFFQ
         xH4A==
X-Forwarded-Encrypted: i=1; AJvYcCWZKZk6K1p1iXX5thNeZ11sUw8mJZau8/9yzm0kY4FwgpuoyaxKwmw6A5k5t7SXuDRf/e9jOYkexxqju9bF4Fm/Ko+B5FgxLR2yz1L8
X-Gm-Message-State: AOJu0YyLO0k4I0p9YQNifRgpEwldDTSG8PMiHsRYOSwrh91pMKl7hBnk
	UW75V0jPEJvV+z4HQ0BTCOI/TVREfoFVZ1MMAcOJRwDRChwhLWCp
X-Google-Smtp-Source: AGHT+IHx08m/+g1QPinEVulyhxIIRDK2yi5NXjlI92ZLNvIp+cKZpaef84hTpV7qm1gN58ET7kSVlA==
X-Received: by 2002:a17:902:d34d:b0:1e8:674b:d10f with SMTP id l13-20020a170902d34d00b001e8674bd10fmr2677214plk.41.1713966777772;
        Wed, 24 Apr 2024 06:52:57 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.240.252])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b001e89c729843sm11140235plg.228.2024.04.24.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:52:57 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: 21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/2] mm: add per-order mTHP split counters
Date: Wed, 24 Apr 2024 21:51:47 +0800
Message-Id: <20240424135148.30422-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240424135148.30422-1-ioworker0@gmail.com>
References: <20240424135148.30422-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At present, the split counters in THP statistics no longer include
PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP split
counters to monitor the frequency of mTHP splits. This will assist
developers in better analyzing and optimizing system performance.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
        split_page
        split_page_failed
        deferred_split_page

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  3 +++
 mm/huge_memory.c        | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 56c7ea73090b..7b9c6590e1f7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -272,6 +272,9 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_ANON_SWPOUT,
 	MTHP_STAT_ANON_SWPOUT_FALLBACK,
+	MTHP_STAT_SPLIT_PAGE,
+	MTHP_STAT_SPLIT_PAGE_FAILED,
+	MTHP_STAT_DEFERRED_SPLIT_PAGE,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 055df5aac7c3..52db888e47a6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
+DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED);
+DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_PAGE);
 
 static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] = {
 	&anon_fault_fallback_charge_attr.attr,
 	&anon_swpout_attr.attr,
 	&anon_swpout_fallback_attr.attr,
+	&split_page_attr.attr,
+	&split_page_failed_attr.attr,
+	&deferred_split_page_attr.attr,
 	NULL,
 };
 
@@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
-	bool is_thp = folio_test_pmd_mappable(folio);
+	int order = folio_order(folio);
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
@@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		i_mmap_unlock_read(mapping);
 out:
 	xas_destroy(&xas);
-	if (is_thp)
+	if (order >= HPAGE_PMD_ORDER)
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
+	count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
+				      MTHP_STAT_SPLIT_PAGE_FAILED);
 	return ret;
 }
 
@@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
 	if (list_empty(&folio->_deferred_list)) {
 		if (folio_test_pmd_mappable(folio))
 			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+		count_mthp_stat(folio_order(folio),
+				MTHP_STAT_DEFERRED_SPLIT_PAGE);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
-- 
2.33.1


