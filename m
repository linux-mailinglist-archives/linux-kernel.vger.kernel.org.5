Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AE379DE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjIMCl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjIMCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:41:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8E1718
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694572913; x=1726108913;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pgc2D+3zfvkfmv8fkBy8k8iJeoSXz10wKKf+lnbUSZQ=;
  b=QcRBK0fzqhCBFxZXP1MCQkWqsw0UYsnnakkWTNQ2QAGz23TCLzjJ3rgw
   2hDaYZ/HhedZ6QaNu+CpwGJqwf2RMRMZ82ItSdDNelTiSAt0LOoYOA47R
   iZ6sFSY+ryYKID6Zo8/KhbXDlEeSpxPEMJyjMSwoVpwEKsRrKxhIiReDE
   A3/XS200m7VLRJLZCV+wJhamRt+orPipPs2XbSbFz7VUSb3IkOsbzGPJh
   pLMFy79Dto12Fu+ARNFYxvzO6NZS6BZc2xlamQoJZx6I4wnI5Y1AY2nHp
   zAQRB0CZvUbtdilTJAMsy7G6hfymK2dnU+jzQhtKSW5rCIC8V6WtKm9oW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464917149"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464917149"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 19:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="743946569"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="743946569"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2023 19:41:27 -0700
Message-ID: <e2eeda9e-2a9e-67ae-cd36-6e312346c0ba@linux.intel.com>
Date:   Wed, 13 Sep 2023 10:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm: Add structure to keep sva information
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-5-tina.zhang@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230912125936.722348-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 8:59 PM, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Reviewed-by: Vasant Hegde<vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   include/linux/iommu.h    | 5 +++++
>   include/linux/mm_types.h | 2 ++
>   2 files changed, 7 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
