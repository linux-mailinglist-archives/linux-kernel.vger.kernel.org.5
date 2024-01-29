Return-Path: <linux-kernel+bounces-43242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39BC841158
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590531F29B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E876C99;
	Mon, 29 Jan 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VENJkoIN"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A93F9CD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550908; cv=none; b=W/rrf3taxBwnOVVA4LQZhw4IDulip//E1R7Qbnt7AAolS7vEGGZ0EZSplW7R/OdYZnpKZv/6i2RS2agpz2Ned7vK627C7Zpama0GfDf9hbkAt6ZI7S79uSKTI+uniqigCNA3EIJtUpFAd0igXXo8GwtahsqCebOWBmgrReR2Ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550908; c=relaxed/simple;
	bh=kRJzgUNYG78tqYjV4uFsGxS1v+z5PuURjbt6RULZG/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkkApGvZTO0GBFNgF1WIBtgS4S+Ab0/y/2JalaNL0AaQTvtcp7pg1sLnP10n24hNeEeiLitDO9rYUBFJISzkE3wvlbdDE7Ras1VFSWbYEHdWwFFnBfDLG1TSU/xHCSWi73/Eza8S9pble8sQYggIqr6Ge5WOavGBIZRj7yHYgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VENJkoIN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dde65d585bso1390592b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550906; x=1707155706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NOwwXIxywhgTYH3p3yq4nMufS2IRUoqO/tf1yKZ7qLU=;
        b=VENJkoIN49Q9ZKzdOX1XAvMgkE4nH6XNNqlBagT+sJpXW/qoohUJJVUjxCSwiWoZpy
         fcWPJYdPYPwRnP150KPhSRbNdnyv7BIWT1fWWG7NUVM2JJ2tb2xbaK29tO4Ae0g7IRl0
         m7TRpBxUJfLhJMqQsqj0iJxrHiuPZ8ao5wZ0nWF+NcSwSCeKJGMTQGjl6wsmoIySMFWM
         jgghHCMON330FO9+wjfRTyaoXBdMwqcfVn72l0sE3LdGLVHRaKO89xSjoDB7SVTLUvBL
         efBJtgurkzsdKncHKwpsUpBwTDXdSpxDwq2s4znuy7VK4OCt6fwbrX5iIoPhlNpXb64G
         f7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550906; x=1707155706;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOwwXIxywhgTYH3p3yq4nMufS2IRUoqO/tf1yKZ7qLU=;
        b=irjQFyLc63pSBSvx71SuAUBhCQqOPssvYE6CTS64kyHqiYt34nwk3pS5fDOBNbpeY0
         guaMCwQDLbMVaDmqv02R9z/Z1RkM+XeJetAwlcj10tD6WTjbE50DlyQWyvxwTvchFVao
         yS76uN8/CgXept8e1Fxp9sedznpnQsHWQUlZTT3lG6bPkHKSrvWkekDPXOUGeNL0/s4/
         MOcIMNGJygk6hvh5foCn9aQxYI69Y1yOl5zzrARMBCI1I4QBCCaxGrl59T4MCTsSEhif
         G6zsxjgfurUrPvEoZg23/i/uKy3MIGAZr5vmp+xEWy7vSI2Y7lCesLUrErP9Ta3E3Oc4
         LoKQ==
X-Gm-Message-State: AOJu0YwShPOS5nEmng3rjppmkdjhIXkzLIZDT1acsT/nqTBIBj7bGkM7
	kmHz9rXXq6mp0JVeCOcEGiaqmqkFl47y2uePkML7NL1aU3vU6NXD
X-Google-Smtp-Source: AGHT+IHcsxUcn8preTc9iTpcswRaxjzdS4S22LBey4Xk5lFq3gP76HzVu0IIMkVly7esBhMrp+Y1Kw==
X-Received: by 2002:aa7:8a13:0:b0:6db:e14f:3956 with SMTP id m19-20020aa78a13000000b006dbe14f3956mr2218904pfa.20.1706550906055;
        Mon, 29 Jan 2024 09:55:06 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm6116676pfr.29.2024.01.29.09.55.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jan 2024 09:55:05 -0800 (PST)
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
Subject: [PATCH v3 1/7] mm/swapfile.c: add back some comment
Date: Tue, 30 Jan 2024 01:54:16 +0800
Message-ID: <20240129175423.1987-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129175423.1987-1-ryncsn@gmail.com>
References: <20240129175423.1987-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Some useful comments were dropped in commit b56a2d8af914 ("mm: rid
swapoff of quadratic complexity"), add them back.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0008cd39af42..606d95b56304 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1881,6 +1881,17 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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


