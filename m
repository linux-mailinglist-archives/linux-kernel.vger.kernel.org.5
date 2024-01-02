Return-Path: <linux-kernel+bounces-14678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A80E8220A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3331C22718
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DEA156F3;
	Tue,  2 Jan 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9rQWTuA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEF156E1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3e6c86868so74364385ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218035; x=1704822835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HOgiTUumllZGmGcBS/5D1WFbQ4vDZwA6J8hbWSvm0VQ=;
        b=l9rQWTuAYOHW1SY3DaHjJM3p678/xk22CAGmbYIuDCHW715aNOAEdQtYNuSfBS0eeS
         1czU7uHLYHXgHX0Ns6oxGuqogOEmozRbms7VS3Sx2moesyoVUtc85Aauk+QYmB/HwfhN
         tojv/J+tDgckjwktqZznps9hO+t6pssvACfVTbbx7JFoGDtNkhnMlt19rGWhl+lOFnMl
         AuMYw4pLFsLa5CMZtwgEPBaFKB/8A7qQz65IEUIeDtvqnxffBeSFwNCBLvUawTcgTleD
         JPbxn23/h22LtJ5mXAIIlKdHZLnGV2OdwQYNqVXSFq17+tUkxDiLLXRPIneyI+NinLrm
         3MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218035; x=1704822835;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOgiTUumllZGmGcBS/5D1WFbQ4vDZwA6J8hbWSvm0VQ=;
        b=hSKvsN/iUswKnBpff6DplYfhd5pb9foCKVROCCKL2keurXj46C5cYakGTXAuADaDzK
         CIlyjnDFTv/Mp/4Q1SQTmpHdWiqPU2HOzT7hQZb2DwGhR0uHkscnsuJ64DeN7u37MDw+
         W0xXcW5uEELAOmlz4IG9eCb0vW5l/UNgK3sAoKFHTYtrshevpip5BSSAGOxn0cj4owqp
         gUQ+xfcBi7Ia9jWIMwvgiYSRwoJ3yuII0TB1K4QwPkeOcJsS4vAdP7ipeKjtipiLzrqw
         Fn0kLI0b8gkMEpBbAqrILouzz/FlQEFnZ2QMTK7vKLgVzi3D1U5gYDIYaRm3TauwUf3q
         jjYg==
X-Gm-Message-State: AOJu0Ywtjg5c2/v9aug7hZHJBHNL2HmCGs3ObeY7fm8vBFsoE6bP9Opu
	u0ix7hqSfVjHUIGNmGyqBv0=
X-Google-Smtp-Source: AGHT+IE9UyXqSDCkq4STavfMkchWm/4gFSM+hqb3udvJPylkrwaXHIW+zWlXliWIUXub6vHeHy9JRA==
X-Received: by 2002:a17:902:c409:b0:1d4:cca4:7e81 with SMTP id k9-20020a170902c40900b001d4cca47e81mr724379plk.64.1704218035614;
        Tue, 02 Jan 2024 09:53:55 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.53.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:53:55 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 1/9] mm/swapfile.c: add back some comment
Date: Wed,  3 Jan 2024 01:53:30 +0800
Message-ID: <20240102175338.62012-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102175338.62012-1-ryncsn@gmail.com>
References: <20240102175338.62012-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Some useful comments were dropped in commit b56a2d8af914 ('mm: rid
swapoff of quadratic complexity'), add them back.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3eec686484ef..f7271504aa0a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1880,6 +1880,17 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				folio = page_folio(page);
 		}
 		if (!folio) {
+			/*
+			 * The entry could have been freed, and will not
+			 * be reused since swapoff() already disabled
+			 * allocation from here, or alloc_page() failed.
+			 *
+			 * We don't hold lock here, so the swap entry could be
+			 * SWAP_MAP_BAD (when the cluster is discarding).
+			 * Instead of fail out, We can just skip the swap
+			 * entry because swapoff will wait for discarding
+			 * finish anyway.
+			 */
 			swp_count = READ_ONCE(si->swap_map[offset]);
 			if (swp_count == 0 || swp_count == SWAP_MAP_BAD)
 				continue;
-- 
2.43.0


