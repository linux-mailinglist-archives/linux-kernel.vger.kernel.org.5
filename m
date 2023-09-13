Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0C79DE46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjIMC20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjIMC2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:28:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7BB1713
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694572101; x=1726108101;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ADJXPAGxhH/KIzMbrba+LZ+A/B+nI3RN78Cnn9H+UvU=;
  b=HlGVOA8HzfXnnFEFccthZd8uVd8ho4rzUs6Wl5BeB+RyBP85nT1lQaNL
   OElLuMupR9LRM6FB9JCG0WtnK82ECXo6HRyMBRP31liFjVEFZ8DYL2YtN
   k6YwtAeygbjh4KKGXb6rsxA5XGzyev3+HycUJ5e0n9U/6ozBgQgLxY/Xi
   37Umx9D9H/Vs4o8TPcmWD9sTE6B4G7FgXPwra+tsjW+JVZTyo8R1LaLI5
   aPXeExOur/4FPyFgIPB9wmfD+vZpBHKgnHrh8PqbIBYlIY8xlXoaA/3Tu
   Z9SSWgNt8TKwFXjH2Vw/aUHKnHSCRu1R4BeX8e5rl09f3xLDv7zTBDZma
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377454858"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="377454858"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 19:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693689531"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="693689531"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2023 19:28:17 -0700
Message-ID: <0f4fb712-28e3-8620-6a65-59c9b9d77740@linux.intel.com>
Date:   Wed, 13 Sep 2023 10:25:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iommu/vt-d: Remove mm->pasid in
 intel_sva_bind_mm()
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-3-tina.zhang@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230912125936.722348-3-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 8:59 PM, Tina Zhang wrote:
> The pasid is passed in as a parameter through .set_dev_pasid() callback.
> Thus, intel_sva_bind_mm() can directly use it instead of retrieving the
> pasid value from mm->pasid.
> 
> Suggested-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/svm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

The intel_svm_bind_mm() could be further merged into
intel_svm_set_dev_pasid(). It's fine if you keep it as is since we need
more cleanup and refactoring work after this series get merged.

So,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
