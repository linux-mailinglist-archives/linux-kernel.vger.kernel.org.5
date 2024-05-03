Return-Path: <linux-kernel+bounces-167122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8C8BA4B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94B51F2507C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E5DDD7;
	Fri,  3 May 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYuvJsq0"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D4BE58
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697481; cv=none; b=mgXRl74wZZlPcVZjEOX7A4f/xvEvDUZApOQs/JdaqNyEVnXZHUfyqMeensyplcl165T6sH2bSJXmxjJvif8hm5XRq4yoE04WD9j38QojW4CBGzUBSlsunsNne6oYgIiHfw3rf2W3Aj005RfWq+vFqZ5G0rf4xj4Quxbl144K5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697481; c=relaxed/simple;
	bh=gJXAWzFv78CWKiMkFGxOs0FBDTmpFMkGrRWrHMYNEvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmNtQGyrmsU/i5srvx4Kdlg9Rw+IwKftu7IprYK1MIOf2zAb2EmCgUFTKx1JXDg+6Qpl/cZmIQbwIVD+uFTiHZfj7AvyVrjSVr0r+EWnt8BKk1yMoUNEyAUOBsx+AaDQC4XaNeLnDjn/JiMplGua9QF76R4TtGrIVNmdQns0eXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYuvJsq0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3c3aa8938so57656395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714697480; x=1715302280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y50dQl+upnub8ly1QPHs/qiP8XcDN3yKo0FUp2Qgag8=;
        b=MYuvJsq08lktuMOh041jlzvejjCgzdlJ3H4+EWA+3PuXfjRgnALz7y6PKWnP4+W2U/
         u8wRAXLSpEOV2livtIF285csmgnyRFP6bZm8NRG2mp/CatmDijhZojNFgH887ljPteSy
         Aw6aM5mOxnSq2PGPecd0w4t26S6ywNj1omgFPxTnu7e1FHJh2ouzRZ0SoML5/wIZTh3s
         sCE0+UUD7bSSj2orz0rQZN7ys0FjwWqRak6zFk3pCgc93N6tLT9XytMOpk5tUDJOxicg
         AUzlnJNskosgbEMSRJDqlv66tMSPWCvrcYp7Jqro6s2FSDUGaMCOAu7ruQooILSzeQGp
         7kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697480; x=1715302280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y50dQl+upnub8ly1QPHs/qiP8XcDN3yKo0FUp2Qgag8=;
        b=WeQFLwifBENjzHNL/ileqNEHbrVzicww4NNg5so2l3ontq3qboxBFn6i4MaC/BOUx8
         UZioVrK22IeIcbcVBeUA8FRfYB9IvD46ibY7HyqaQAxVswPuKgTjJOOvZTbLYXtmjQBc
         jUbZjv+K4fJzF5rKJDu9sMlgBUSqSFth2nEc/JDMl891lnAXNXSJ3uEDIhSXeEwYtzzm
         5nLO53jEuRbrJtfw+1bnX1s0u2FkDNmEfDT+UphMeFoSFmxGLAX3VpOi2QyLqkE6v3MN
         6LQ5a+cEjcYp20i5AO98Nxsm6wfv8k27PlJdg3XmBFIVpuAzYt4Ii/hVQT3l4AfQ1W+X
         LRMA==
X-Forwarded-Encrypted: i=1; AJvYcCWbL70W3Gg0XNP2VYLwKpvubYU+rLqwOKMSoFU4Mbm2eeGOfJiORenke5QJ1LJ3lUJODN+X6jq6iakRacBfYJRPjfjiR3MmqXnlA016
X-Gm-Message-State: AOJu0YxrWOVNisD6th+xNbHyvXKP159m590CqpNIjcoWGIj9VGGQSsrx
	2y6SpfgmUs+bREBPASwMus1gOOHiA19D2ACovmZF0yQF0N7K2Bn8
X-Google-Smtp-Source: AGHT+IF/YGckt6lCQLRiwu1+5wNzKcMLcZACnvpyDGbcY6XjGmdPdZXMo8MwxWmuAEpW19MZtkC8pA==
X-Received: by 2002:a17:902:ce8b:b0:1e4:362b:17d5 with SMTP id f11-20020a170902ce8b00b001e4362b17d5mr1757897plg.4.1714697479694;
        Thu, 02 May 2024 17:51:19 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001ec48e41d2esm1969175plh.212.2024.05.02.17.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:51:19 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v3 5/6] mm: swap: make should_try_to_free_swap() support large-folio
Date: Fri,  3 May 2024 12:50:22 +1200
Message-Id: <20240503005023.174597-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503005023.174597-1-21cnbao@gmail.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

The function should_try_to_free_swap() operates under the assumption
that swap-in always occurs at the normal page granularity,
i.e., folio_nr_pages() = 1. However, in reality, for large folios,
add_to_swap_cache() will invoke folio_ref_add(folio, nr).  To accommodate
large folio swap-in, this patch eliminates this assumption.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 74cdefd58f5f..22e7c33cc747 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3877,7 +3877,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * reference only in case it's likely that we'll be the exlusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
-		folio_ref_count(folio) == 2;
+		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
 }
 
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
-- 
2.34.1


