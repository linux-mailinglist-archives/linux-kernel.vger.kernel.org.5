Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058C97D0FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377290AbjJTMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377266AbjJTMdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:33:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03EAED52
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:33:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A2EB2F4;
        Fri, 20 Oct 2023 05:34:23 -0700 (PDT)
Received: from [10.1.30.154] (XHFQ2J9959.cambridge.arm.com [10.1.30.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CAA03F5A1;
        Fri, 20 Oct 2023 05:33:40 -0700 (PDT)
Message-ID: <a7781f13-21ca-48c7-99c4-22beef0400f9@arm.com>
Date:   Fri, 20 Oct 2023 13:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
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
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 21:06, David Hildenbrand wrote:
> On 29.09.23 13:44, Ryan Roberts wrote:
>> Hi All,
> 

[...]

>> NOTE: These changes should not be merged until the prerequisites are complete.
>> These are in progress and tracked at [7].
> 
> We should probably list them here, and classify which one we see as strict a
> requirement, which ones might be an optimization.
> 

Bringing back the discussion of prerequistes to this thread following the
discussion at the mm-alignment meeting on Wednesday.

Slides, updated following discussion to reflect all the agreed items that are
prerequisites and enhancements, are at [1].

I've taken a closer look at the situation with khugepaged, and can confirm that
it does correctly collapse anon small-sized THP into PMD-sized THP. I did notice
though, that one of the khugepaged selftests (collapse_max_ptes_none) fails when
small-sized THP is enabled+always. So I've fixed that test up and will add the
patch to the next version of my series.

So I believe the khugepaged prerequisite can be marked as done.

[1]
https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view?usp=sharing&resourcekey=0-U1Mj3-RhLD1JV6EThpyPyA

Thanks,
Ryan

