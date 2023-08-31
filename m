Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686BF78E717
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjHaHRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjHaHRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:17:52 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Aug 2023 00:17:46 PDT
Received: from out-251.mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039E1A4;
        Thu, 31 Aug 2023 00:17:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693466264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFazo8t+x34pBbM7FhZAQZ14ar3Xb4GsuBZugiC8qbg=;
        b=TmoDr3ge1UyYX8ugRY7XZkb1xippW67sMxQbI3dFiX3Dbs/J/HBs2sO7VWfWEzPmxOfLQe
        irrOtXTt8xSQ97Xkijkm0FIC9OgQEr/Td6ezNmKG3h7hR9QGia9r5MoB5IEtbw4+D4m6uq
        CfCbsYqz98UwThxz+SvZ0LkR7PL5hUE=
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] use nth_page() in place of direct struct page
 manipulation.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230830182753.55367-3-zi.yan@sent.com>
Date:   Thu, 31 Aug 2023 15:17:15 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <50EF53C6-0CE2-4256-B8AB-AE9BF290419D@linux.dev>
References: <20230830182753.55367-1-zi.yan@sent.com>
 <20230830182753.55367-3-zi.yan@sent.com>
To:     Zi Yan <ziy@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 31, 2023, at 02:27, Zi Yan <zi.yan@sent.com> wrote:
> 
> From: Zi Yan <ziy@nvidia.com>
> 
> When dealing with hugetlb pages, struct page is not guaranteed to be
> contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle it
> properly.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com <mailto:ziy@nvidia.com>>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

It's better to add a Fixes tag to the commit 38c1ddbde6.

Thanks.

