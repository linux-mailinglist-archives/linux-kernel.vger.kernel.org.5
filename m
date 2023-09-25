Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2180A7AD5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjIYKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:25:34 -0400
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9838E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:25:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695637526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxFAw7nLddeOwtmNKD8bf5RBQDwgBmyQvveBR6J5fJc=;
        b=QrV5dHooV0sNdc21vKmdxXgl33U78NkIKXuflqcD0/5sodkrFghgo3HrHr/RYT4sYAQrN9
        QZst+umX1KRxopPYytR1SFUzAQvoDxvIT6dcxH0OuyJOByZNSVAQ9DA4P2WhgWZtm8CS1O
        IoxDLv+av824/6TvRxNpcQSBen82elM=
Mime-Version: 1.0
Subject: Re: [PATCH v5 3/8] hugetlb: perform vmemmap optimization on a list of
 pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230925003953.142620-4-mike.kravetz@oracle.com>
Date:   Mon, 25 Sep 2023 18:24:39 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <B97FCB21-8290-4FE5-B204-FCDA6687507B@linux.dev>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
 <20230925003953.142620-4-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 25, 2023, at 08:39, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> When adding hugetlb pages to the pool, we first create a list of the
> allocated pages before adding to the pool.  Pass this list of pages to a
> new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.
> 
> Due to significant differences in vmemmmap initialization for bootmem
> allocated hugetlb pages, a new routine prep_and_add_bootmem_folios
> is created.
> 
> We also modify the routine vmemmap_should_optimize() to check for pages
> that are already optimized.  There are code paths that might request
> vmemmap optimization twice and we want to make sure this is not
> attempted.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

