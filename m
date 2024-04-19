Return-Path: <linux-kernel+bounces-151001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242998AA7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF01C2247F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99578F4A;
	Fri, 19 Apr 2024 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rFUtTOkv"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB0441D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502454; cv=none; b=rw9eEWFFCDGoE+UwiQQ0txGEUNfByt22TVpGNll5RDq0LgSpE4zzLCYpGgpo9gVpnDtYS/hGQ6N5s6D/CuV6A9sk+eacNJXvLyvWbii43fMHgASQh57G14rV9nqP2SUnDecFIXLQVT7zhl2WB8E0NjI7eH/lmq69+BYe6usvN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502454; c=relaxed/simple;
	bh=SEqUKKHPqXeIzKXgaq6Myuoo6UguWp39lv/IOvnQ/aU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=FBikvKbqVRz0bCQDzpfJ1HHhDz1khQCFtrx3TOZT96WwBUKOer/BkbdfdAg2Ud9uv4F4Yhc5om5sY1SWwTlSfsUuY/UUI/ZlsvggqTi5LNTImATQxNc20cRCzke+kqSzXgc8vcO0lRodA4v+pA81xYyj0QgH7TCEOQwLCcC1bJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rFUtTOkv; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240419044417epoutp03b17b5017f165a924a1ed72a6bc301ebe~HlNxcwIAp0486004860epoutp03d
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:44:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240419044417epoutp03b17b5017f165a924a1ed72a6bc301ebe~HlNxcwIAp0486004860epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713501857;
	bh=Z25o43JCrYV9Z2WyXrctJEsjpL5tpjd53IPnfYhtPd4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rFUtTOkvh/Jn/WHDg9UKXcYd5lP7AlugfwBcKaZeljx6YojRkzOM9tVF/ZXyjwOwf
	 1XfoJ5CIRX9DtWbs71dFGAtJZ5xZcAhetncbIt0qXlnX0YqPur0nGVRgB9K6aZY/n/
	 li6jAXbxx94kXSVHZhbxGjAuPqBCILsu7Nfl1JXY=
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.42.80]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240419044416epcas5p1b4c56dce2b87c4cae8c007c810ceb3e9~HlNxAuWQ92300223002epcas5p1d;
	Fri, 19 Apr 2024 04:44:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.40.19431.0A6F1266; Fri, 19 Apr 2024 13:44:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240419044047epcas5p4a90ca734d73bc9a87cd1670beaa24d8e~HlKtmeK4u2796527965epcas5p4y;
	Fri, 19 Apr 2024 04:40:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240419044047epsmtrp2dfc97ad5f34c96fc1e9a44799cebc91c~HlKtkkO7O1545515455epsmtrp2a;
	Fri, 19 Apr 2024 04:40:47 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-71-6621f6a0e120
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	37.A1.08390.EC5F1266; Fri, 19 Apr 2024 13:40:46 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240419044044epsmtip1e89b19a67f09edbf58542b6956d1862d~HlKrhqEca0959809598epsmtip1h;
	Fri, 19 Apr 2024 04:40:44 +0000 (GMT)
From: Hariom Panthi <hariom1.p@samsung.com>
To: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	maninder1.s@samsung.com, r.thapliyal@samsung.com, Hariom Panthi
	<hariom1.p@samsung.com>
Subject: [PATCH 1/1] mm: vmalloc: dump page owner info if page is already
 mapped
Date: Fri, 19 Apr 2024 10:09:10 +0530
Message-Id: <20240419043910.2156379-1-hariom1.p@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7bCmhu6Cb4ppBo23TCzmrF/DZvGk7RCL
	xekJi5gsLu+aw2Zxb81/Vos73+axWxye38ZisfFetsXqiywOnB47Z91l99i8Qstj06dJ7B4n
	Zvxm8ejbsorR4/MmuQC2KC6blNSczLLUIn27BK6MthnTmQqOC1UsnKvWwDiHv4uRk0NCwESi
	/89m1i5GLg4hgT2MEt+O9rJAOJ8YJfrb5rCBVAkJfGOUWNhqC9Nxdc9aRoj4XkaJxh+xEA1f
	GCV2f/vM3MXIwcEmoC1x/JMVSI2IQITExD0XmUBqmAUmMkr8bd/CDpIQFgiSeLJ9GtgCFgFV
	iRtrTrKA2LwCNhInX55lglgmLzHz0nd2iLigxMmZT8BqmIHizVtnM0PUPGKXmPXEG8J2kVi/
	+h4rhC0s8eo4xC4JASmJz+/2skHY5RLdC7qhahoYJeYu94Gw7SWeXFzICnI/s4CmxPpd+hBh
	WYmpp9YxQazlk+j9/QTqNF6JHfNgbGWJuUc2sUDYkhI75ndA2R4Sf+9OhYZVrMS/X32sExjl
	ZyH5ZhaSb2YhbF7AyLyKUSq1oDg3PTXZtMBQNy+1XK84Mbe4NC9dLzk/dxMjONloBexgXL3h
	r94hRiYOxkOMEhzMSiK8ZhyKaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5X7fOTRESSE8sSc1O
	TS1ILYLJMnFwSjUweWdxXTqYss5gbcynncv8DsftVvE79SNpfmxAdrHcUWehiuuCdyuu9IYw
	bNXJ71PaVfF/ntvD1lUy5ltz7BhYD+gt5u3307m6x+ERd7fo9lOOftkb1qd9VPv7soF9ggyL
	xXr9dx8+1Hommm5Pc1+VdT6HxanO1bhA4mYbs5Ypt8/i6n08b3IXLn16bEb1zUDpjjuPPC96
	G7K2u3Md9a7fwvjk4717AgKCB+4vmj3vxHW1667d2343SZ6ckvNCRiNC4MH66KhHt3ZUSIWV
	TvvMxtfiWRY985Jt6a9q89nWd6z+zd+RoSk55br9rvWmMi2twS5nb02psVQNiw0353f6G9v+
	p129weuuyL0n6ZxKLMUZiYZazEXFiQBa09PIpQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnO65r4ppBlfWWFnMWb+GzeJJ2yEW
	i9MTFjFZXN41h83i3pr/rBZ3vs1jtzg8v43FYuO9bIvVF1kcOD12zrrL7rF5hZbHpk+T2D1O
	zPjN4tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZbTOmMxUcF6pYOFetgXEOfxcjJ4eEgInE
	1T1rGbsYuTiEBHYzSvz/fZQVIiEpsW7+F2YIW1hi5b/n7BBFnxgl3r49BZTg4GAT0JY4/skK
	pEZEIEbixZwfbCA2s8BURokX8xxAbGGBQInW3Z1gM1kEVCVurDnJAmLzCthInHx5lglivrzE
	zEvf2SHighInZz5hgZgjL9G8dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMpLLdcrTswt
	Ls1L10vOz93ECA5dLa0djHtWfdA7xMjEwXiIUYKDWUmE14xDMU2INyWxsiq1KD++qDQntfgQ
	ozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGprWPbta8W+/l/f7Bo67F+loB6vHRM9KN
	Dlxe+P7m44nRfXtub49Ujd08L9rXaM/+Y1s8DeRz03lNVgg3T/L2edFx4M4GZasjwlcm/V2s
	p3N9WtuplQrrjGJ8bkmf1Ahd0ZzfWxx+++ri3gab+b5Pfh6aZlyUwDSP/03QrZXZq32Wbpl3
	u+musOPEAvU6vo1ZCe9l9j8KylGLPHm2dUlzpM7dplmHHjsuq1nW9mzZl72PzjDNLjzitzZU
	0e5u6tO1D5bEPI6M2q8R/OrJ390RfA2/ZWVuy927XxIQvzd4cnnfhHen84MNZ+Z1NrHlbS/i
	v7e/ubTu9/aQLdeFVH6E6k1a736OQfFm3oZr0gfK274psRRnJBpqMRcVJwIAhluRV8wCAAA=
X-CMS-MailID: 20240419044047epcas5p4a90ca734d73bc9a87cd1670beaa24d8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240419044047epcas5p4a90ca734d73bc9a87cd1670beaa24d8e
References: <CGME20240419044047epcas5p4a90ca734d73bc9a87cd1670beaa24d8e@epcas5p4.samsung.com>

In vmap_pte_range, BUG_ON is called when page is already mapped,
It doesn't give enough information to debug further.
Dumping page owner information alongwith BUG_ON will be more useful
in case of multiple page mapping.

Example:
[   18.258806] page_owner tracks the page as allocated
[   18.258970] page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 81, tgid 81 (insmod), ts 18257811008, free_ts 0
[   18.259327]  prep_new_page+0xa8/0x10c
[   18.259455]  get_page_from_freelist+0x7f8/0x1248
[   18.259591]  __alloc_pages+0x164/0x2b4
[   18.259703]  alloc_pages_mpol+0x88/0x230
[   18.259821]  alloc_pages+0x4c/0x7c
[   18.259923]  load_module+0x74/0x1af4
[   18.260031]  __do_sys_init_module+0x190/0x1fc
[   18.260154]  __arm64_sys_init_module+0x1c/0x28
[   18.260280]  invoke_syscall+0x44/0x108
[   18.260394]  el0_svc_common.constprop.0+0x40/0xe0
[   18.260530]  do_el0_svc_compat+0x1c/0x34
[   18.260647]  el0_svc_compat+0x2c/0x80
[   18.260761]  el0t_32_sync_handler+0x90/0x140
[   18.260887]  el0t_32_sync+0x194/0x198
[   18.260996] page_owner free stack trace missing
[   18.261143] ------------[ cut here ]------------
[   18.261272] kernel BUG at mm/vmalloc.c:113!

Signed-off-by: Hariom Panthi <hariom1.p@samsung.com>
---
 mm/vmalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 68fa001648cc..9c91091887de 100644
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
+				dump_page_owner(page);
+			}
+			BUG();
+		}
 
 #ifdef CONFIG_HUGETLB_PAGE
 		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
-- 
2.25.1


