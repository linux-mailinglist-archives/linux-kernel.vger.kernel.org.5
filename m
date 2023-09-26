Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233807AE3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjIZCUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjIZCU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:20:29 -0400
Received: from out-200.mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DEEBF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:20:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695694819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1b8hVoQId4csgamvTB2WShQmgG37CnT1dtlKwQaPO4=;
        b=xILITPFQAPSLd4ahspvL7fGpqJq7VOivtaJQ2kuFK6eFCyXtjuajupOfO7evf51EFxZmrQ
        wrhvm8eSmVLXpPYTDwMuLZl8pnESdJjURxxxGt7eOgtP7rTrpK0sI4vNMSUK2YsxzMkZyh
        enw4L+1faWVgHJs7EWWQmRdTyebvODc=
Mime-Version: 1.0
Subject: Re: [PATCH v6 8/8] hugetlb: batch TLB flushes when restoring vmemmap
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230925234837.86786-9-mike.kravetz@oracle.com>
Date:   Tue, 26 Sep 2023 10:20:09 +0800
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
Message-Id: <B3613427-85AF-4D06-9D39-4332E505F6F0@linux.dev>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
 <20230925234837.86786-9-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2023, at 07:48, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> Update the internal hugetlb restore vmemmap code path such that TLB
> flushing can be batched.  Use the existing mechanism of passing the
> VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
> performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
> is the only user of this new mechanism, and it will perform a global
> flush after all vmemmap is restored.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

