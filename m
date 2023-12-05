Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF0804D58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjLEJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjLEJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:14:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293CF188;
        Tue,  5 Dec 2023 01:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701767689; x=1733303689;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CA/po2UEZKXyste1mfpEbd51SPSYNHn4HvETMXvX/SU=;
  b=Smr6v6TKfVuq3yl4xw1gssOdnZ47e021ubxpp/C2GZPv//U4lRjQMMXp
   oncqU/rJeI0AvoEtQaFbvq7jafz+43z/yW2MEzN5ZIvMk+oMYA9vbr9xF
   +P9nWmM5xLSgeV+UM7bBoZ3Jth+koD/rbFs3nmdFVMxLEnFaMQiaJHTT/
   KPGbNdFYYrrG37kGyzPlQPK1j7JnBNuIXAMsoMfZyDT/rKZsln3kRN+du
   lUinTdlSBqqKYGInTDW/yRRE1r0tY2Fe6XyyiPXTi0uNRngJKSj4VeTO9
   jRa8ohQwYCoIwf6cx/SADYlvT6ylYgUX4RtNN2y8fBKfe/RHcW2MSRKff
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="945217"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="945217"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="18895366"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:14:44 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Cc:     Michal Hocko <mhocko@suse.com>, <aneesh.kumar@linux.ibm.com>,
        <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <dan.j.williams@intel.com>, <hannes@cmpxchg.org>,
        <hasanalmaruf@fb.com>, <haowang3@fb.com>,
        <gregory.price@memverge.com>, <tj@kernel.org>,
        <hezhongkun.hzk@bytedance.com>, <fvdl@google.com>,
        <john@jagalactic.com>, <emirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Subject: Re: [EXT] Re: [RFC PATCH 0/2] Node migration between memory tiers
In-Reply-To: <1db561a9-6984-418d-9305-a2a5ece93696@micron.com> (Srinivasulu
        Thanneeru's message of "Tue, 5 Dec 2023 01:26:07 +0530")
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
        <ZW3zl2Fke5FtQCv3@tiehlicka>
        <1db561a9-6984-418d-9305-a2a5ece93696@micron.com>
Date:   Tue, 05 Dec 2023 17:12:43 +0800
Message-ID: <87a5qp2et0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com> writes:

> On 12/4/2023 9:13 PM, Michal Hocko wrote:
>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments
>> unless you recognize the sender and were expecting this message.
>> On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:
>>> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>>>
>>> The memory tiers feature allows nodes with similar memory types
>>> or performance characteristics to be grouped together in a
>>> memory tier. However, there is currently no provision for
>>> moving a node from one tier to another on demand.
>> Could you expand on why this is really needed/necessary? What is the
>> actual usecase?
>
> Hi Michal Hock,
>
> Following two use-cases we have observed.
> 1. It is not accurate to group similar memory types in the same tier,
>    because even similar memory types may have different speed grades.
>
> 2. Some systems boots up with CXL devices and DRAM on the same
> memory-tier, we need a way to move the CXL nodes to the correct tier
> from the user space.

The case 2 reminds me a RFC before as follows,

https://lore.kernel.org/linux-mm/20221027065925.476955-1-ying.huang@intel.com/

The basic idea behind is that do we really need to put NUMA nodes with
different performance metrics in one memory tier?  Are there use cases?
Will we have a system with so many different types of memory?

As in your case, you don't want to put DRAM and CXL memory in one memory
tier.  Do you think we will need to put two types of memory in one
memory tier?

--
Best Regards,
Huang, Ying

