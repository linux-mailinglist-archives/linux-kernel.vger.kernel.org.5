Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A47CEE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjJSDNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJSDNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:13:08 -0400
Received: from out-205.mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD229F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:13:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697685181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCELsRGpQtBTf7R2azG7q2KcnWrjo9t9BqbdwSm/g60=;
        b=YLXmnfCzsdB37AnUhu39i9fq1hffTF8aKBp5TUuQzCcLmHLlQoSbHChZVnRrQImtvJQKWt
        FG2yCQn+t+x/uNRXXNWv4lh8WJ0QTfQ2I0WfCVbKGJt+tOvOsqtXuQ0o0jOtUdZ6CN5bAO
        8eGR/6vfX3H9ExeRv6nGekhBIEKeOM0=
Mime-Version: 1.0
Subject: Re: [PATCH v8 3/8] hugetlb: perform vmemmap optimization on a list of
 pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231019023113.345257-4-mike.kravetz@oracle.com>
Date:   Thu, 19 Oct 2023 11:12:24 +0800
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
Message-Id: <B59EBDE7-0369-4AA1-90AC-DB930A04F92E@linux.dev>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
 <20231019023113.345257-4-mike.kravetz@oracle.com>
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

