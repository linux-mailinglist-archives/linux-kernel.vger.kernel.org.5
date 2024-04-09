Return-Path: <linux-kernel+bounces-136457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9BC89D436
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF552837AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD98005E;
	Tue,  9 Apr 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag3lGwdW"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE277E777
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651225; cv=none; b=LZR95tm7RrqdVfmah885tOXptSjW4HYznXSNqCDIrSMbImqdsh/ePmMdZOKd/EmdTtgei51J4ztLowmr+lW1nIoy5U70Va9xZtvWF4vtrKvmPzDSSW9w0zDmsjp1/hep2pBI4vd5PTjK97aDlHa/LqNqnyNCHO0NJy/kVfNy5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651225; c=relaxed/simple;
	bh=ETs94iqJVrHJRgz2q3MMrYy7MrAw5n0uJJNve7xN6Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVW3jNxaYSjOgtLsEk0hIzBwrVQSSjl5aJZBNwzoXAZpXSGpQ3aQCDIe3SDm8X9/9FqBFBXGPhf3t5EOZ7PLXRdWNoKfPCoqlv3WGwbikNIQ6AUR3ax4LFAjwzFrA3CY5szTyjmsJcI3+PstF1ChEvAwhpKBG7+xUoNxVMpXiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag3lGwdW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed267f2936so1561892b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712651223; x=1713256023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpjEhAQtgqO+DLm71KCeo2y5Y8KyQFcwcH3a5IWajwE=;
        b=ag3lGwdWc6YYsw/CUW1Xsv/oHfwC0QSSFCwZ0fsAp7v4g2TnbtaNOhnAjYCtILTtzm
         sZ+5c6ysXbZEJhHX1aq+npXHk+UqBGFiUT/v3b+KZ+OvHQGXx/4dCzhMAuLs5NVNtgRM
         YyV+Jogoof1E4Xa98XrHehxaGOeY+58OzcPIVr5vm9o3+NikxHU4Qdpjng4A8ow3sAdW
         mxsH61jkY3sYTxPflfJ1BTrrfcuOnGOoeEZsWKiqmpIPtCeef2IBSHb1ugK9ik0X4Qb4
         TMjcu23agxAs1Cz4YPysXsWOVL58epyurVduXWLFf6ZLrL2CHdb+vbRn7VugobyuUz26
         uKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651223; x=1713256023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpjEhAQtgqO+DLm71KCeo2y5Y8KyQFcwcH3a5IWajwE=;
        b=BNBiT1PZQmeQ7yHikUBMyUiDVEEyRQ6nAVdGtfBOVHfRlpxCMEsA7AJi3JiHqrtHuL
         JVEkHZwwULZiZHaoFQNjyedu9apAMEOZQ41XMq8kHALcmS3T3OuTNvMFQZhLsmrwqpiy
         uaZYyuNPiGyLhsBIJgkjWL00C+DIJ/WqRR80fWHcBjXPWY8D34okda1VPa6VhOcQf/6G
         650bdn3T7woNk1clUtHOAygWBKD7EpfHhV/nMmo0gDYYa1yCNWQNTSVQVNK3u3hLkj9g
         bHUtXpHLGfqxHQlab6LC7YeEV+tvRQ4s3/XnHXbybqIi0qphBqmNXGDEwO1F523pBaLH
         BsrA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+ls24MdE6j0h2yZhNbamZciPc3pr3E2bpBXjeYs+jr4jX/h4DEn39LpviDnSLfE2jtC46xZInEC4rhDb6E7HWvVDgQsmkv33jTwK
X-Gm-Message-State: AOJu0YxED2dEeL0Ee5+j1RheI3F9FaZlZZmAf0dltUJfjE/VgxY8ww9/
	DXUn/FBvaY8mKKFhgKOT2aKBXJ5k2s+KYUEnGt0Qb+u1jDdjzQ/u
X-Google-Smtp-Source: AGHT+IGLXAZ+gunF7hyCXzEaTPUaO18uUbecCeYC/lMFr9OrqEyLkgxoorBwDY+pMLEp+CyQ1vQJpw==
X-Received: by 2002:a05:6a00:4f84:b0:6ea:afd1:90e6 with SMTP id ld4-20020a056a004f8400b006eaafd190e6mr11705280pfb.6.1712651223528;
        Tue, 09 Apr 2024 01:27:03 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id r16-20020a632050000000b005f05c88c149sm7594238pgm.71.2024.04.09.01.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:27:02 -0700 (PDT)
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
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] mm: swap: make should_try_to_free_swap() support large-folio
Date: Tue,  9 Apr 2024 20:26:28 +1200
Message-Id: <20240409082631.187483-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409082631.187483-1-21cnbao@gmail.com>
References: <20240409082631.187483-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

The function should_try_to_free_swap() operates under the assumption that
swap-in always occurs at the normal page granularity, i.e., folio_nr_pages
= 1. However, in reality, for large folios, add_to_swap_cache() will
invoke folio_ref_add(folio, nr). To accommodate large folio swap-in,
this patch eliminates this assumption.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 78422d1c7381..2702d449880e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3856,7 +3856,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * reference only in case it's likely that we'll be the exlusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
-		folio_ref_count(folio) == 2;
+		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
 }
 
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
-- 
2.34.1


