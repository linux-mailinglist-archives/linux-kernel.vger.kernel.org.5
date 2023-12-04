Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095C7803E68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjLDTah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjLDTaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:30:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EAA124
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:30:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F924C433C7;
        Mon,  4 Dec 2023 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701718240;
        bh=ABgwQL+5ghGBCD4oPGGuo0S7770OKaEZZY6kOtE8ivo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=svZRqjv4U7Y0GbI1UXJ94YwKWDf6NRXm65nuJD1ewRrmsFbnWBVco2HlTUnCDhoHq
         Ghvy+PsJ0gh4BXJKnHX9yyH/+0RzCE2ZjxuNLZGDp+yeI/JC+h0zsDD/RJy5pBvdTU
         6SzgRyWAt1JC+I0enWSPOilqmOZXqDVSa4aB7wzI=
Date:   Mon, 4 Dec 2023 11:30:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
Message-Id: <20231204113039.42510c23455026e40c5e2a56@linux-foundation.org>
In-Reply-To: <20231204102027.57185-1-ryan.roberts@arm.com>
References: <20231204102027.57185-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Dec 2023 10:20:17 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Hi All,
> 
> 
> Prerequisites
> =============
> 
> Some work items identified as being prerequisites are listed on page 3 at [9].
> The summary is:
> 
> | item                          | status                  |
> |:------------------------------|:------------------------|
> | mlock                         | In mainline (v6.7)      |
> | madvise                       | In mainline (v6.6)      |
> | compaction                    | v1 posted [10]          |
> | numa balancing                | Investigated: see below |
> | user-triggered page migration | In mainline (v6.7)      |
> | khugepaged collapse           | In mainline (NOP)       |

What does "prerequisites" mean here?  Won't compile without?  Kernel
crashes without?  Nice-to-have-after?  Please expand on this.

I looked at [9], but access is denied.

> [9] https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view?usp=sharing&resourcekey=0-U1Mj3-RhLD1JV6EThpyPyA


