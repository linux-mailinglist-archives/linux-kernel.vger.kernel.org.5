Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9148128AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443271AbjLNHBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjLNHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:01:20 -0500
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F314F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:01:26 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SrN5h6bP5z29g0v;
        Thu, 14 Dec 2023 14:40:40 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
        by mail.maildlp.com (Postfix) with ESMTPS id 26D4514038F;
        Thu, 14 Dec 2023 14:41:49 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm000003.china.huawei.com
 (7.193.23.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 14:41:48 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
        <akpm@linux-foundation.org>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 3/3] arm64: mm: Re-enable OPTIMIZE_HUGETLB_VMEMMAP
Date:   Thu, 14 Dec 2023 15:39:12 +0800
Message-ID: <20231214073912.1938330-4-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214073912.1938330-1-sunnanyong@huawei.com>
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now update of vmemmap page table can follow the rule of
break-before-make safely for arm64 architecture, re-enable
HVO on arm64.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
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

