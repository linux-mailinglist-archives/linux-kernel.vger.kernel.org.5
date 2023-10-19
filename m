Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6B7CEE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJSDMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJSDMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:12:14 -0400
Received: from out-206.mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F189F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:12:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697685130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdRbdmTqIVWIQiBunchnjyRkLxfYXVSBe4eJv/kibxw=;
        b=vHR5GN7t5FJjTs1VvuImp+7zOdtNGQlU0ySVTFZU+yxOoUt2DxLABScqPbYIkzj11DuKZw
        /gyc2aFR1pFTiC5SteAxlrtBAXD5B945anS0l4FWU0q8MLKEqnHuWgkjei8yr3z0wuncdS
        B3bWZtfRqaOVgKY+Oys9gr5mtqFt/TM=
Mime-Version: 1.0
Subject: Re: [PATCH v8 2/8] hugetlb: restructure pool allocations
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231019023113.345257-3-mike.kravetz@oracle.com>
Date:   Thu, 19 Oct 2023 11:11:06 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <367C3465-B07D-402A-9647-9E0890130107@linux.dev>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
 <20231019023113.345257-3-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 19, 2023, at 10:31, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> Allocation of a hugetlb page for the hugetlb pool is done by the routine
> alloc_pool_huge_page.  This routine will allocate contiguous pages from
> a low level allocator, prep the pages for usage as a hugetlb page and
> then add the resulting hugetlb page to the pool.
> 
> In the 'prep' stage, optional vmemmap optimization is done.  For
> performance reasons we want to perform vmemmap optimization on multiple
> hugetlb pages at once.  To do this, restructure the hugetlb pool
> allocation code such that vmemmap optimization can be isolated and later
> batched.
> 
> The code to allocate hugetlb pages from bootmem was also modified to
> allow batching.
> 
> No functional changes, only code restructure.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

The difference is small compared with v7. So

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

