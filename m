Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28CB793646
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjIFHbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjIFHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:31:11 -0400
Received: from out-217.mta1.migadu.com (out-217.mta1.migadu.com [95.215.58.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E594
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:31:08 -0700 (PDT)
Message-ID: <15aeb29a-1201-f86c-2cc5-cc583120fe4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693985466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3ppfk56efEHNQGtV1sgKxnNQuIzA3XOagl7ZL/qaVE=;
        b=N1Wxqjk/C0HAV7YtzNKEK7+UYUneBo5JOIPKVEqRDPDAOu0Pflq5G6U6UgqldDbXme1df9
        fSojoaocrgtojVLfXJ9RZBqxsmry7PIz4YMd50br8wcous9pqPuq15XMR37TRCbqLPIpRA
        yZEcdWaE0irdJ28tgXqR/mgkaciiaVs=
Date:   Wed, 6 Sep 2023 15:30:41 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 06/11] hugetlb: perform vmemmap optimization on a list
 of pages
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-7-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230905214412.89152-7-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/6 05:44, Mike Kravetz wrote:
> When adding hugetlb pages to the pool, we first create a list of the
> allocated pages before adding to the pool.  Pass this list of pages to a
> new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.
>
> We also modify the routine vmemmap_should_optimize() to check for pages
> that are already optimized.  There are code paths that might request
> vmemmap optimization twice and we want to make sure this is not
> attempted.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
