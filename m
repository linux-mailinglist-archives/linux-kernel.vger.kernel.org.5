Return-Path: <linux-kernel+bounces-14680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7F88220A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BD9284056
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7A15ADD;
	Tue,  2 Jan 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwym94/+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2715ADF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d4ca2fd2fbso3820095ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218043; x=1704822843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5EuDdHpwOIkkgSSbClAkFkJceQknRHYQiFDZ/42t/cQ=;
        b=Mwym94/+NnPgR3YyIdv7Ey1kOkc9/3yDHaR2W6vWX+s1EKZI1Z2AYXrRLCMzCn0JSd
         IIL9s5/jUC/ADAPqSosCHvUUuprq5ipDFz3nZVjAv4n+lD5cz03daVSBV9+HkU41Z43v
         yWBQFSeK6o12OLy6CcLeySk6hRJVEH/NGktn024/uM8nwe1lYWVOPNU+r9e3yK0KYhmE
         vvMMPr/EaKG6XiuYz6grmRd7Wb0o1r2ePe5xtD/ZShMgggnYM/wDyF1/dDH37HA9R8ST
         X6qDW6nXAEq8QMA0bpfTi6dTCD7D4WxADp3GUks9Wu2dVmY7Ua+BdpXPvXE/0q+tvcK5
         Z2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218043; x=1704822843;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EuDdHpwOIkkgSSbClAkFkJceQknRHYQiFDZ/42t/cQ=;
        b=MlFZ4wxC2t8Uwcl2IhFYWrdOVEvfHCkd6am6s0NQDcdt2kTaBh0RMbYVX0CHebcZKO
         3nV+EZkqWsH9GdEQnFIa/T0j+zJCehey780kvVvsIOE1lDPhYuFEqAN4u8d+0fTNFFUp
         PNjU7dLQQpI/+5cWAcD1DBncj5hQJGFHDT8IDypmz9002HcZ3dzvyqVyYUMmBV2RfCDY
         Xzt6e6iyL9Tm9Z/kOzs/NeruNaeslkHALHE0nNKWzL7mtglSbZoyPxnqg43vQwkYVpQJ
         kP+wMS2Pukx3Rq9+aosVPyFDs80w++nUq+L2sdvZCnQEwsGTNscE67DafIGFiZujjqBw
         E1kQ==
X-Gm-Message-State: AOJu0YzfTFC16DGqNI90Ay7ZfPBF4qkVbK4dgAoQyf0xVNSWsuw1/fRL
	x0QIT/EH1kZ+CPiof3s1hWM=
X-Google-Smtp-Source: AGHT+IGfDUQj/99XwdeiZZ73lh5kEPQ3dWYF+KkQDfvXFyCLAaB8H9KSj/gNI32pWe4Z84HwpG1X3w==
X-Received: by 2002:a17:903:184:b0:1d0:c986:8ac9 with SMTP id z4-20020a170903018400b001d0c9868ac9mr9755498plg.22.1704218042880;
        Tue, 02 Jan 2024 09:54:02 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.53.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:54:02 -0800 (PST)
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
Subject: [PATCH v2 3/9] mm/swap: avoid doing extra unlock error checks for direct swapin
Date: Wed,  3 Jan 2024 01:53:32 +0800
Message-ID: <20240102175338.62012-4-ryncsn@gmail.com>
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

When swapping in a page, mem_cgroup_swapin_charge_folio is called for
new allocated folio, nothing else is referencing the folio so no need
to set the lock bit early. This avoided doing extra unlock checks
on the error path.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 24cb93ed5081..6130de8d5226 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -881,16 +881,15 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 				vma, vmf->address, false);
 	if (folio) {
-		__folio_set_locked(folio);
-		__folio_set_swapbacked(folio);
-
-		if (mem_cgroup_swapin_charge_folio(folio,
-					vma->vm_mm, GFP_KERNEL,
-					entry)) {
-			folio_unlock(folio);
+		if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
+						   GFP_KERNEL, entry)) {
 			folio_put(folio);
 			return NULL;
 		}
+
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
 		mem_cgroup_swapin_uncharge_swap(entry);
 
 		shadow = get_shadow_from_swap_cache(entry);
-- 
2.43.0


