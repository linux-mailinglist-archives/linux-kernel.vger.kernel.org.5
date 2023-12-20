Return-Path: <linux-kernel+bounces-6365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60458197B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DA2282083
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1226179BF;
	Wed, 20 Dec 2023 04:21:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20483156F9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Sw0jB30t1z29fmG;
	Wed, 20 Dec 2023 12:20:30 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C22CD140499;
	Wed, 20 Dec 2023 12:21:43 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm000003.china.huawei.com
 (7.193.23.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Dec
 2023 12:21:42 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>
CC: <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 3/3] arm64: mm: Re-enable OPTIMIZE_HUGETLB_VMEMMAP
Date: Wed, 20 Dec 2023 13:18:55 +0800
Message-ID: <20231220051855.47547-4-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220051855.47547-1-sunnanyong@huawei.com>
References: <20231220051855.47547-1-sunnanyong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000003.china.huawei.com (7.193.23.66)

Now update of vmemmap page table can follow the rule of
break-before-make safely for arm64 architecture, re-enable
HVO on arm64.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..43e3d5576fb2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -103,6 +103,7 @@ config ARM64
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
+	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
-- 
2.25.1


