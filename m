Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB71A7A7747
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjITJYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjITJYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:24:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35547EA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:24:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A5031FB;
        Wed, 20 Sep 2023 02:24:44 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131FA3F5A1;
        Wed, 20 Sep 2023 02:24:04 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:24:02 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 02/10] cacheinfo: calculate per-CPU data cache size
Message-ID: <20230920092402.pvqju4knnqkzqfiq@bogus>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920061856.257597-3-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:18:48PM +0800, Huang Ying wrote:
> Per-CPU data cache size is useful information.  For example, it can be
> used to determine per-CPU cache size.  So, in this patch, the data
> cache size for each CPU is calculated via data_cache_size /
> shared_cpu_weight.
>
> A brute-force algorithm to iterate all online CPUs is used to avoid
> to allocate an extra cpumask, especially in offline callback.
>

You have not mentioned who will use this information ? Looking at the
change, it is not exposed to the user-space. Also I see this is actually
part of the series [1]. Is this info used in any of those patches ? Can you
point me to the same ?

Not all architecture use cacheinfo yet. How will the mm changes affect those
platforms ?

--
Regards,
Sudeep

[1] https://lore.kernel.org/all/20230920061856.257597-1-ying.huang@intel.com/
