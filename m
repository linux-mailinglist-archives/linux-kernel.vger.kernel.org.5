Return-Path: <linux-kernel+bounces-30040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05441831838
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C166D283268
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF92575E;
	Thu, 18 Jan 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBAgfL1X"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972C25613
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576350; cv=none; b=is7Sq35kVnFslJVgmGs+6tyunjBsz9K0gLmkuyf+5fR3i5zOWqGwfsHrjivKeQX5sfoT2JfyYETv9WowLsNdj45cMb3dLIx+7cPd8sN2/K+TO4limQsRnF7arbdVTs9qijLnxrh+YPyNm1mzHXLcxjgmTk1l2afnqol13Cv3Ox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576350; c=relaxed/simple;
	bh=DwksO4pggIfrxQAN1+eTkGGLwNBL3ggzIFhofhqrICM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=ZYtbGxGi+rpwXR0WFKB5MP6n0l1fNXVbu+LvJVUD2qS/ZBBV5oxwHjp7wuJpGaqjChb3lMWPFoh/c9l+b3oZ8yfnnUhhImk82UoiN1B1Gq9Zusn3Xgta5Edj3Wnb6w7eCh1EAWFrfW/Sau7TYxEdZwXQZSfstNuYm66VJKIKqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBAgfL1X; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dac8955af0so7015750b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576348; x=1706181148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCBEGTZpNMmcOnq2Y92D+y0mof5icxn15UOhqT4EV4Y=;
        b=jBAgfL1X0U4H5TWVlcljiWvdoUKS51PKLX7xBDDKbJ6NUkfq3YK7kqOLNjZAjPanya
         vTBO5T5uZme5NrVLcSyrKuWYlu1gcsGq5cCC9gNXiCj/UNgy66MrdFKGRoi9VLijqYPn
         NcYHOthpSHctkNC64L7SKP++qwp5LppEn4ty25q35AcK0Bh+xnYo/xIhfL99eekPGEdN
         dLX3IZkNtg4S/1hQxRH62ujDJjznWuXPj0J2v/zG6lKp42M/LA/zpJSBQH3Ew/kNbY5i
         1AFVnnlmTWLJ5H5ZSjLpiV5zEE5jFeAwk+Kl2StCmPK/OeBEvrpTc+qL5sOXLqRsGjKz
         z17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576348; x=1706181148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCBEGTZpNMmcOnq2Y92D+y0mof5icxn15UOhqT4EV4Y=;
        b=JvIEloHdCx5+EsDGk0uB6I6iYa4/n0WDY9E1svKC2CZiM4mNFLYR+EzsYiYjreJeJi
         FSU32B9F+U8EVCmMiEGL/dsBRwbiXRQFhJ7kX1ybOKpqYOVcLleQ7mCJGvl0c/CUu9zc
         Z7MI76c+r4PSgeEQeUNTRDJZ70pXRi40wmM1PcOpJvwaIRZAFeKv/ET7KIlS0w//QxL1
         tUx3eXHnF8J6G/riv8bkKCDq3lz3Tck1IKATvyODM15vM9psn0WmGUaN+pzJ7L1u7MTh
         lr0WLEk862Y1yP4j8JTuPelpXR/wuU6EfKQ/8tIwjrcdOETJUwLmMsg+Ihnegtu1J3w8
         pvcw==
X-Gm-Message-State: AOJu0YxdA46+0GPJvCWb6FTA1A8Xjg7FM9wv0RX9yS9+GwWpvt4fYyCk
	YmCO058b5ya8AViI2a0cSrddW9mIe7mq44mRhBy5Llc5TKkWn4e9
X-Google-Smtp-Source: AGHT+IEJstXUsC4BpkRjY9scs4NUCR+YL22P3xRiQhsTqcfdW5F99LeuFxkMM1kuf1dvP6YKKu38lg==
X-Received: by 2002:a05:6a00:170c:b0:6db:6ed8:4e9f with SMTP id h12-20020a056a00170c00b006db6ed84e9fmr684987pfc.56.1705576348144;
        Thu, 18 Jan 2024 03:12:28 -0800 (PST)
Received: from barry-desktop.. (143.122.224.49.dyn.cust.vf.net.nz. [49.224.122.143])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm3039107pfj.108.2024.01.18.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:12:27 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	surenb@google.com,
	steven.price@arm.com,
	Barry Song <v-songbaohua@oppo.com>,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
Date: Fri, 19 Jan 2024 00:10:35 +1300
Message-Id: <20240118111036.72641-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118111036.72641-1-21cnbao@gmail.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

In do_swap_page(), while supporting large folio swap-in, we are using the helper
folio_add_anon_rmap_ptes. This is triggerring a WARN_ON in __folio_add_anon_rmap.
We can make the warning quiet by two ways
1. in do_swap_page, we call folio_add_new_anon_rmap() if we are sure the large
folio is new allocated one; we call folio_add_anon_rmap_ptes() if we find the
large folio in swapcache.
2. we always call folio_add_anon_rmap_ptes() in do_swap_page but weaken the
WARN_ON in __folio_add_anon_rmap() by letting the WARN_ON less sensitive.

Option 2 seems to be better for do_swap_page() as it can use unified code for
all cases.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chuanhua Han <hanchuanhua@oppo.com>
---
 mm/rmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index f5d43edad529..469fcfd32317 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1304,7 +1304,10 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		 * page.
 		 */
 		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
-				 level != RMAP_LEVEL_PMD, folio);
+				 level != RMAP_LEVEL_PMD &&
+				 (!IS_ALIGNED(address, nr_pages * PAGE_SIZE) ||
+				 (folio_test_swapcache(folio) && !IS_ALIGNED(folio->index, nr_pages)) ||
+				 page != &folio->page), folio);
 		__folio_set_anon(folio, vma, address,
 				 !!(flags & RMAP_EXCLUSIVE));
 	} else if (likely(!folio_test_ksm(folio))) {
-- 
2.34.1


