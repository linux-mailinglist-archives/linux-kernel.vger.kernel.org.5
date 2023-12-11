Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6033F80C87F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjLKLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjLKLvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:51:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17981F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:51:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 257B2FEC;
        Mon, 11 Dec 2023 03:52:04 -0800 (PST)
Received: from [10.57.73.30] (unknown [10.57.73.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5762E3F762;
        Mon, 11 Dec 2023 03:51:14 -0800 (PST)
Message-ID: <6cc1332d-6ad2-4642-84d1-6a2fcf70d534@arm.com>
Date:   Mon, 11 Dec 2023 11:51:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/10] Multi-size THP for anonymous memory
To:     Andrew Morton <akpm@linux-foundation.org>
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
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207140502.e7dff5d1cfb195b1644b61a5@linux-foundation.org>
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231207140502.e7dff5d1cfb195b1644b61a5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 22:05, Andrew Morton wrote:
> On Thu,  7 Dec 2023 16:12:01 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> Hi All,
>>
>> This is v9 (and hopefully the last) of a series to implement multi-size THP
>> (mTHP) for anonymous memory (previously called "small-sized THP" and "large
>> anonymous folios").
> 
> A general point on the [0/N] intro.  Bear in mind that this is
> (intended to be) for ever.  Five years hence, people won't be
> interested in knowing which version the patchset was, in seeing what
> changed from the previous iteration, etc.  This is all important and
> useful info, of course.  But it's best suited for being below the
> "^---$" separator.
> 
> Also, those five-years-from-now people won't want to have to go click
> on some link to find the performance testing results and suchlike. 
> It's better to paste such important info right into their faces.

Sorry about this, Andrew - you've given me feedback on this before, and I've
been trying to improve this. I'm obviously not there yet. Will fix for next time.

