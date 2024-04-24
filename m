Return-Path: <linux-kernel+bounces-156792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CE78B083C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE7B2886C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7F15A4A1;
	Wed, 24 Apr 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WN7NKUcA"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB13142E62
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957745; cv=none; b=j/Ya9U28kdmFcYDEcJBmRTNaSJcqwt4u6Vl0toPkGJJS90N1h0hugp72CAPsPNU8Lj6eVjDb3io4D4+tibfziZ7mYhX23qJuPoq6zRZ1HxlJgMxIDwkyUD7d+fuYNg6yxWBOFduDAOdiybWJBrFnZ2/OuxbEdcejHX2jEGaDlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957745; c=relaxed/simple;
	bh=oUSIe+rlOM/t/CCJlU0Ym76lmYD25Y6Kke5UoxxUgkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=n3vYYZfNvXhw/ODBFqs2eG8sjXyMiOfc1W0XJczdiiBlSYVkpBObMBZoPM/zlSxnCpLU2wMjtFdBVR6MN7DxTmrKWqylrm8EoCyMWFVlTiXmvCYzK8sV75EdM1+TopEF+01WU2ipw6eFxJ0+32p52ZxB0hlZC3xCvi+7IJI20nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WN7NKUcA; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240424112219epoutp01bb148290d8793f9546e6b4f837d2c39a~JM3upy8kV2713827138epoutp01O
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:22:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240424112219epoutp01bb148290d8793f9546e6b4f837d2c39a~JM3upy8kV2713827138epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713957739;
	bh=cU2r+b0iFCg79T2AVm8rm8HYfOfRgHYMuBeICKhq1gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WN7NKUcAVVXmN27XQK6az8eFMob0fo9p6QVNlYeC7k5Pc4dgpmLU2j25HUW5TzusP
	 SxyQO/MtCiHT3eFwsevHsi6O9huCnXqKuuNqslEme/5F+A35b9u7C0pT0HoXnzhFKp
	 XDWoa2qzBicXqYjegKWdrDSPNi3rnhTfDuztoYu0=
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.42.80]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240424112218epcas5p18a50ea0a70e9b75caa2b0c874c1079a5~JM3uPJZYZ0465804658epcas5p1y;
	Wed, 24 Apr 2024 11:22:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.73.19431.A6BE8266; Wed, 24 Apr 2024 20:22:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240424112131epcas5p100ad84d676c861db5a0d84439fe5f718~JM3B_7lMl1983319833epcas5p12;
	Wed, 24 Apr 2024 11:21:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240424112131epsmtrp12308ff951d695acb65315130ec7fd50d~JM3B_NNJA3234132341epsmtrp1Q;
	Wed, 24 Apr 2024 11:21:31 +0000 (GMT)
X-AuditID: b6c32a50-f57ff70000004be7-4a-6628eb6a3a00
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.F6.08390.B3BE8266; Wed, 24 Apr 2024 20:21:31 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240424112129epsmtip2638c010e3b176843e22b9246d3060280~JM3AM29CF2227122271epsmtip2p;
	Wed, 24 Apr 2024 11:21:29 +0000 (GMT)
From: Hariom Panthi <hariom1.p@samsung.com>
To: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, vbabka@suse.cz, osalvador@suse.de
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	r.thapliyal@samsung.com, Hariom Panthi <hariom1.p@samsung.com>
Subject: [PATCH 2/2] mm: vmalloc: dump page owner info if page is already
 mapped
Date: Wed, 24 Apr 2024 16:48:38 +0530
Message-Id: <20240424111838.3782931-2-hariom1.p@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424111838.3782931-1-hariom1.p@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7bCmum7Wa400g4OTzSzmrF/DZvGk7RCL
	xekJi5gsLu+aw2Zxb81/Vos73+axW5yZVmSx8V62xeqLLBazG/sYHbg8ds66y+6xeYWWx6ZP
	k9g9Tsz4zeLRt2UVo8eZBUeA4qerPT5vkgvgiOKySUnNySxLLdK3S+DKOPc4ruCDWMXmO5PY
	Gxj/CnUxcnBICJhIvH1u2cXIxSEksIdRYvXmKSwQzidGibM/vjNBON8YJY7taGftYuQE67j/
	5BVUYi+jxNf729kgnC+MEt1r/rCCzGUT0JY4/skKpEFEoFri1P7XLCA2s0CZxPueg8wgJcIC
	QRK/bsWDhFkEVCUunW9hB7F5BWwk/nybwwKxS15i5qXv7CDlnAK2EquvqUOUCEqcnPkEaqK8
	RPPW2cwgF0gI9HJITDl/iBXiMxeJ/pN1EGOEJV4d38IOYUtJvOxvg7LLJboXdEO91cAoMXe5
	D4RtL/Hk4kKwMcwCmhLrd+lDhGUlpp5axwSxlk+i9/cTJog4r8SOeTC2ssTcI5ugrpeU2DG/
	A8r2kFh26ys7JKAmMEr0TN7JNoFRYRaSd2YheWcWwuoFjMyrGKVSC4pz01OTTQsMdfNSy/WK
	E3OLS/PS9ZLzczcxgpOTVsAOxtUb/uodYmTiYDzEKMHBrCTC++uPSpoQb0piZVVqUX58UWlO
	avEhRmkOFiVx3tetc1OEBNITS1KzU1MLUotgskwcnFINTNkGc95+EX3dr/44es/ZGyXLHW/L
	rreck3O02nVfbc6P4gf3vnI/cTkU575cd8Pnf8J7nrAGb9undHyLv/s5q/gvf1TWWpc/VlX9
	dziksSMrg6vL3E3B9b2i5on4afONSr/9LQ0MbNCZdO9B2RQJj9JnP14rHRT99f70aeaGCNfN
	M47xnDqsFhZdJKG7nk1GwYtdRCP+zNwru8KdZUr52n82Xjg9e4fnnj0+LZtOtTVu1hCS9+KI
	kPf5+Nze0sJoivWa6RH2//PFVyc4Hiycvmjhl5MRrrv3dH7deOuZ0uuS6x5TxTRYXyck/b4n
	E1menDF9sbzn1O/lJvoNDr1a4t0Xv1WGqoc+9ZE01zH5osRSnJFoqMVcVJwIAGfHJp69AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSvK71a400g74ZohZz1q9hs3jSdojF
	4vSERUwWl3fNYbO4t+Y/q8Wdb/PYLc5MK7LYeC/bYvVFFovZjX2MDlweO2fdZffYvELLY9On
	SeweJ2b8ZvHo27KK0ePMgiNA8dPVHp83yQVwRHHZpKTmZJalFunbJXBlnHscV/BBrGLznUns
	DYx/hboYOTkkBEwk7j95xdTFyMUhJLCbUWL39vmMEAlJiXXzvzBD2MISK/89Z4co+sQo8fT3
	BpYuRg4ONgFtieOfrEDiIgLNjBJbZ+8Ba2YWqJI49n0hWLOwQIDEhnfXweIsAqoSl863sIPY
	vAI2En++zWGBWCAvMfPSd3aQmZwCthKrr6mDhIWASjbNbGCCKBeUODnzCQvEeHmJ5q2zmScw
	CsxCkpqFJLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwFGhp7WDcs+qD3iFG
	Jg7GQ4wSHMxKIry//qikCfGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1
	CCbLxMEp1cCkzn/ytKb8rgcmS12n/Prk955rW23LRqYQpdNK+ya3GifEzP4k9Fziw3eW+wcm
	HF4c+27uV3nPsIlVVd+y+Ts41305/3sNa6rpoZjzHh8nhq/VEjn+p0+1yN3mwLv5yz4LnfOP
	uaSiGxBfNeVS+e/QORHr7+WpW23m3Kr54uMknwerv8i53v45xb8vp/6x9NurlWs6eHNPKPPf
	rVDjWByz3lCsJ3rlo/WHlx5aHl7T5FR24/yRk54XsqpYGYQUxJLPPX+up1oVJvat03ifYbzJ
	n2oREVOPiicnTI5ac05/u19h9qyVLcK32eO67d9I1PfrG7X/C1r17nB7yuIWMY7WZJc3rEuX
	LJJNUCyzumuqxFKckWioxVxUnAgAi39wW/ECAAA=
X-CMS-MailID: 20240424112131epcas5p100ad84d676c861db5a0d84439fe5f718
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240424112131epcas5p100ad84d676c861db5a0d84439fe5f718
References: <20240424111838.3782931-1-hariom1.p@samsung.com>
	<CGME20240424112131epcas5p100ad84d676c861db5a0d84439fe5f718@epcas5p1.samsung.com>

In vmap_pte_range, BUG_ON is called when page is already mapped,
It doesn't give enough information to debug further.
Dumping page owner information alongwith BUG_ON will be more useful
in case of multiple page mapping.

Example:
[   14.552875] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10b923
[   14.553440] flags: 0xbffff0000000000(node=0|zone=2|lastcpupid=0x3ffff)
[   14.554001] page_type: 0xffffffff()
[   14.554783] raw: 0bffff0000000000 0000000000000000 dead000000000122 0000000000000000
[   14.555230] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   14.555768] page dumped because: remapping already mapped page
[   14.556172] page_owner tracks the page as allocated
[   14.556482] page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 80, tgid 80 (insmod), ts 14552004992, free_ts 0
[   14.557286]  prep_new_page+0xa8/0x10c
[   14.558052]  get_page_from_freelist+0x7f8/0x1248
[   14.558298]  __alloc_pages+0x164/0x2b4
[   14.558514]  alloc_pages_mpol+0x88/0x230
[   14.558904]  alloc_pages+0x4c/0x7c
[   14.559157]  load_module+0x74/0x1af4
[   14.559361]  __do_sys_init_module+0x190/0x1fc
[   14.559615]  __arm64_sys_init_module+0x1c/0x28
[   14.559883]  invoke_syscall+0x44/0x108
[   14.560109]  el0_svc_common.constprop.0+0x40/0xe0
[   14.560371]  do_el0_svc_compat+0x1c/0x34
[   14.560600]  el0_svc_compat+0x2c/0x80
[   14.560820]  el0t_32_sync_handler+0x90/0x140
[   14.561040]  el0t_32_sync+0x194/0x198
[   14.561329] page_owner free stack trace missing
[   14.562049] ------------[ cut here ]------------
[   14.562314] kernel BUG at mm/vmalloc.c:113!

Signed-off-by: Hariom Panthi <hariom1.p@samsung.com>
---
replaced dump_page_owner() with dump_page() as per Andrew's suggestion

 mm/vmalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 68fa001648cc..bc74eb406c0a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -42,6 +42,7 @@
 #include <linux/sched/mm.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
+#include <linux/page_owner.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmalloc.h>
@@ -96,6 +97,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 {
 	pte_t *pte;
 	u64 pfn;
+	struct page *page;
 	unsigned long size = PAGE_SIZE;
 
 	pfn = phys_addr >> PAGE_SHIFT;
@@ -103,7 +105,13 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (!pte)
 		return -ENOMEM;
 	do {
-		BUG_ON(!pte_none(ptep_get(pte)));
+		if (!pte_none(ptep_get(pte))) {
+			if (pfn_valid(pfn)) {
+				page = pfn_to_page(pfn);
+				dump_page(page, "remapping already mapped page");
+			}
+			BUG();
+		}
 
 #ifdef CONFIG_HUGETLB_PAGE
 		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
-- 
2.25.1


