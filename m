Return-Path: <linux-kernel+bounces-14681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640578220A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11225280E96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C915E9F;
	Tue,  2 Jan 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ3XAnIW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2115AE5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4a2526a7eso14040995ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218046; x=1704822846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HKSeSe6aIz/giM2hLWohMCNrft/gPTDUxVx5SpP3Eg8=;
        b=iQ3XAnIWnjar2ZYyLhDTvoTQGD86vhuTspFjEfkZ2LS8is25EqtlIlVqY1uNrARYhv
         4njSVNDX7VvqQykfK3TMI3LuF5aQ1VyidjoTlxv9QIvoz/SqTk9hI3AnUeIQHY7hsi6H
         Oqx5fTw5nTQpZaCE4OwLNXIjRr1gek9ss6yx2t3z7HGrkv9xiudu/Url5mbG/Q2b/9P4
         iPrpU9rmarBnVV2LHpAcXuQw4sbwPCYSVx63I9X+8I3q14VOWhryxEp+dEjwxwIC+ju7
         urazwrtNUwpiFvSQulSKKlxiUJ2cHXugOX2FgvGizKkdzeOCNDBKbH7EOZ8TbLpSXubF
         9UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218046; x=1704822846;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKSeSe6aIz/giM2hLWohMCNrft/gPTDUxVx5SpP3Eg8=;
        b=rOoF/bfwkbAjfGKvATd3rCj3YSrko5CjzTXBQy7q4tEnnxiV/FB3iGgxTAbsfGxbI2
         8LM/ojOc+gnTtmIDSCCf5zrUKFyAC1SyVQLlPRp4BgaEx3cA7aNKUeojptBKKtRRwDo0
         3n/9y+/Kp0dITyk9obdUK0erlW9+a7sOrAyXGJWBuRIjeUAUpSBjXbCkYndxHLOj09oc
         Zi6Qhg6t1V3RY5vsjMWT5QNlEMCkyyzhXuEK87+Crscucjtlmpb5fha9x5omgrwajnML
         07qMWQA8hWvtRh6lquD/W7E1sLGGZk9hVudd5TnD7SimEHOejZrVBJMwvza9GVDHUTf0
         2hiA==
X-Gm-Message-State: AOJu0Yxwcwo+m/0duzLe0bXyP7mPiHQtc8qpQxFcX1w1jInKCVTOTmIt
	eDnWvhpbtQsQDJa57QsH2jw=
X-Google-Smtp-Source: AGHT+IGjD60IJ5O934G0uk9U2RzbZjBO7ugPyT2rW4oxx9bLV6dvHfHyD2MlY2xhFWamcsU7Iv7RfQ==
X-Received: by 2002:a17:903:1251:b0:1d3:529a:83b6 with SMTP id u17-20020a170903125100b001d3529a83b6mr8433403plh.17.1704218046394;
        Tue, 02 Jan 2024 09:54:06 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.54.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:54:05 -0800 (PST)
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
Subject: [PATCH v2 4/9] mm/swap: always account swapped in page into current memcg
Date: Wed,  3 Jan 2024 01:53:33 +0800
Message-ID: <20240102175338.62012-5-ryncsn@gmail.com>
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

Currently, mem_cgroup_swapin_charge_folio is always called with
mm argument as NULL, except in swapin_direct.

swapin_direct is used when swapin should skip readahead and
swapcache (SWP_SYNCHRONOUS_IO). Other caller paths of
mem_cgroup_swapin_charge_folio are for swapin that should
not skip readahead and cache.

This could cause swapin charging to behave differently depending
on swap device. This currently didn't happen because the only call
path of swapin_direct is the direct anon page fault path, where mm
equals to current->mm, but will no longer be true if swapin_direct
is shared and have other callers (eg, swapoff).

So make swapin_direct also passes NULL for mm, no feature change.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 6130de8d5226..d39c5369da21 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -881,7 +881,7 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 				vma, vmf->address, false);
 	if (folio) {
-		if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
+		if (mem_cgroup_swapin_charge_folio(folio, NULL,
 						   GFP_KERNEL, entry)) {
 			folio_put(folio);
 			return NULL;
-- 
2.43.0


