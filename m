Return-Path: <linux-kernel+bounces-146407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20528A64DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F375B1C214CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528461598F3;
	Tue, 16 Apr 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKHvZH05"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03115921E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251872; cv=none; b=bN/p15nYxCSlWzrImLe2x8frJm1Wq6gs3wrUJQvvucmScpTaN3ZToa9N3kQKZnjgET4sWxEfxah9LcDs3op3h7/i+R2bs6UVhTDISZ+gGMK/d/fyGQ2f53xlT4a9t0fccv6UJVGsWmoS6yH8W9Q/PMmuW4fanKtj+QsU0G+DgME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251872; c=relaxed/simple;
	bh=kzdlZqYQWNrIXSnJqwtpoqwSYY1qBtvI2I8Lo4LwsCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOYu1V30DdzorjsvGTPgDZI9+zGsTNHEyrS4rZfG8zz119S4aGkD95IYK25zxfasym2F7jDqa+3C6BC65Vow0UIFcAagnWCSxlOnznYLv41AfowZlkqtIm7JVb/l7SfRVFoO1jkLJMtPhb9UnQYU4/008UHYqn8BmcoNlUF13EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKHvZH05; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22ed72b0082so2724213fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713251870; x=1713856670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F+Z2hNJP+z3T6EfHmF6/rzbCctrFBIWGBJWrf7iP/Ig=;
        b=PKHvZH05CSHHTCzGQYcpfewmlVPCHavBPJwc/OXAqABmm33u7/c9R4JBABsQYpms2J
         Pbl8rMEt+IeFkdTVVfaJ7ojwp0VIOQgoDg8awiXEQLa6lNzCDnBvijExqGgRUw5TpQEy
         7jBtcaKUtK3NM/M/0R7JVFe6R/GFTixPV+L3j4XZkvaduuFDWiTDgcfXsbE3568c1wuu
         KGI7b8j6cQSBkT8vdC84wWzSFzfCIVUxxWgQKn2l+yBEreSFFu93nJa4h50jlNpsqtTm
         qy98gkus5GAaAuSbWvfSKA+9jze6OmrMozhbDgYo6tabb3W/e89kzll9KwLqPJUr6tHE
         QuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713251870; x=1713856670;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+Z2hNJP+z3T6EfHmF6/rzbCctrFBIWGBJWrf7iP/Ig=;
        b=VcKsjignJmjyNcx5vEvTarynMCmMMT13AnVpjDJ8U7sBc0rnVfvjy6dLLc6uZU88ao
         9JSDOF4mibWi3F3kMPcYl7aw/1aJmkN4SY9RCy5o6/HPR7QYHUr8oDKrvw41z7pj8nlv
         hrlR6gR8KyiF/Kq+aboWGhMTjG0ojgksMFXH3mjWo/Il5OOZhkarSb6e8ReJjNF5IZSd
         FgXFNJDlMnNA7sBFrzvxed/n2HGdCuZ6LxecByy5Atv0LHOHx3Lxc6zQvvoqZ5qBQk+W
         mHRZcsJodlxsSlmDUQbe5msxCTneODTa4KdpVBiHhoEQlnaMKoRu/LvA76mY69xfhfJE
         UCnA==
X-Forwarded-Encrypted: i=1; AJvYcCW/PL8MTaWtIymfPf+/fMzHXuTpe9DvgWdlKmoD7hc99/hd/3b2knfNL1fwpAUvh6ZbuphWUELiREjoDqpl0bnIMtCHLKXcp78D2s3e
X-Gm-Message-State: AOJu0YyGF8JVbNf67mdNHZjmw2KG9/bqmSuPFLmFYwqzNY+2i/WEskSm
	VlK8XRGM1BLjnUeRXh5doc9rLL9Mx1XJk3t4xQjd4I2ogirRlbJ4
X-Google-Smtp-Source: AGHT+IGTlCysBm/YOmaGrEGYXumxXfgrNAPvhr2uKFZUXitXWelGd6XrYs4GaN3Yt1Z5t4vLHkZtFQ==
X-Received: by 2002:a05:6870:7312:b0:22e:e0c5:c729 with SMTP id q18-20020a056870731200b0022ee0c5c729mr15807231oal.3.1713251870398;
        Tue, 16 Apr 2024 00:17:50 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id lr48-20020a056a0073b000b006e724ccdc3esm8340029pfb.55.2024.04.16.00.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Apr 2024 00:17:50 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4 2/4] mm/filemap: clean up hugetlb exclusion code
Date: Tue, 16 Apr 2024 15:17:20 +0800
Message-ID: <20240416071722.45997-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416071722.45997-1-ryncsn@gmail.com>
References: <20240416071722.45997-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

__filemap_add_folio only has two callers, one never passes hugetlb folio
and one always passes in hugetlb folio. So move the hugetlb related
cgroup charging out of it to make the code cleaner.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d447b36ffd41..7f734b7ad273 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -853,20 +853,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	bool huge = folio_test_hugetlb(folio);
-	bool charged = false;
-	long nr = 1;
+	long nr;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
 	mapping_set_update(&xas, mapping);
 
-	if (!huge) {
-		int error = mem_cgroup_charge(folio, NULL, gfp);
-		if (error)
-			return error;
-		charged = true;
-	}
-
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 	xas_set_order(&xas, index, folio_order(folio));
 	nr = folio_nr_pages(folio);
@@ -931,8 +923,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	trace_mm_filemap_add_to_page_cache(folio);
 	return 0;
 error:
-	if (charged)
-		mem_cgroup_uncharge(folio);
 	folio->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
 	folio_put_refs(folio, nr);
@@ -946,11 +936,16 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	void *shadow = NULL;
 	int ret;
 
+	ret = mem_cgroup_charge(folio, NULL, gfp);
+	if (ret)
+		return ret;
+
 	__folio_set_locked(folio);
 	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		mem_cgroup_uncharge(folio);
 		__folio_clear_locked(folio);
-	else {
+	} else {
 		/*
 		 * The folio might have been evicted from cache only
 		 * recently, in which case it should be activated like
-- 
2.44.0


