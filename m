Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2576A701
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjHACcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjHACct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:32:49 -0400
Received: from out-70.mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F8F1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:32:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690857166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0cAhHLbOronzuYBSPWgVkkNCyArz9oznjgWDy1pwrw=;
        b=oKo04UCvFkJNdKYY3bbMJn98gTT/k2iRFAg95VK/i58kJZMiSP/q30Zy9xbOJwLDV588Li
        lYNdMgXqWRA0sQlqtqj3mH8YIFXA/fk2T0QL8qQ+R0fOGxmMWLRyYlPfwbI9qCzDKGsXv9
        gRBYv7pi42wurgSmWzrQ6Yj+l9pKcXA=
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] arm64: hugetlb: enable
 __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230801023145.17026-3-wangkefeng.wang@huawei.com>
Date:   Tue, 1 Aug 2023 10:31:59 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org,
        William Kucharski <william.kucharski@oracle.com>,
        kaleshsingh@google.com, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <57B3651F-4BDC-4059-82AD-56070634D8CE@linux.dev>
References: <20230801023145.17026-1-wangkefeng.wang@huawei.com>
 <20230801023145.17026-3-wangkefeng.wang@huawei.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 1, 2023, at 10:31, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
> It is better to use huge page size instead of PAGE_SIZE
> for stride when flush hugepage, which reduces the loop
> in __flush_tlb_range().
> 
> Let's support arch's flush_hugetlb_tlb_range(), which is
> used in hugetlb_unshare_all_pmds(), move_hugetlb_page_tables()
> and hugetlb_change_protection() for now.
> 
> Note, for hugepages based on contiguous bit, it has to be
> invalidated individually since the contiguous PTE bit is
> just a hint, the hardware may or may not take it into account.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


