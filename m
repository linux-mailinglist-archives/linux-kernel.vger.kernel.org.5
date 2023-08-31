Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29AF78E746
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbjHaHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjHaHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:39:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E21A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693467549; x=1725003549;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T69LnpBDtRT8UV80E0X2gwzvbl16M8WGW5icyevns9Y=;
  b=SNt9DwIAt6B+AMWRSAR9BHgv0NzbiL8Lyn7o2zpD5/6+x082ZOpgRpE6
   vk0oMZSDidInEwg/Gg2alCsQOoMDc3+uGkuabbc/oakWsjK8z9X9KTjVL
   J8qPiOyS3eh3SDLSJe3jWbdoMYzhrjhWLAN4aJCXIeKjsDBP7nKkllRhB
   L7zgb/QsoAgscnAGEZ1+BsC+1ZN9fK2XK96M6VN8sozDuqmRk+PdS15Ho
   4D4M0U4tzs89+z39egrG137IPEWaLGwRoPnllB8Iyz7ft+kMcqR0ckNJa
   Xdpe8isOfWfCjKlJs9Rn6egVkwMors+XKq3ilXPJ51HwkgguhCVa5qnh0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462224568"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="462224568"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="862924196"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="862924196"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:39:07 -0700
Message-ID: <bb408ce0-bb11-f2ca-840d-826a124f98ae@linux.intel.com>
Date:   Thu, 31 Aug 2023 15:39:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mm: Deprecate pasid field
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-6-tina.zhang@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-6-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/27 16:44, Tina Zhang wrote:
> Drop the pasid field, as all the information needed for sva domain
> management has been moved to the newly added iommu_mm field.
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   include/linux/mm_types.h | 1 -
>   mm/init-mm.c             | 3 ---
>   2 files changed, 4 deletions(-)

mm->pasid is dead code now. So remove it.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
