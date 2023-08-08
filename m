Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36E7774F48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjHHX3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHHX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:29:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647441BC7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691537368; x=1723073368;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x+gN3DDRzWrdkL7SMDvYeuS3TzxbM/uvrWhTmfDevG0=;
  b=acs7weG1BM/S8I1T/44jainpbP3Wa3aq8QjKKxRSwJ9g5LVYJSyt/h5F
   z4xqqoJJzrK8nLRkOQKrPkkkArB3jCY/YD2PNc81AG1MCkz1todZmGpD7
   mAObU73xgRk65L72wwkUYTte9VQIYvjMNHEbd4CP0eVQcqe1rWla2Nk7l
   rorEqOyFf4dbEfVk7joNvvDkac83jeCAnQFcgxjgOLFaaAR50JMfTMnDf
   CEPuiVa/lsh+vqs0GaAISB8pgJ/6vG5KPQuQRevrlbM844q8uju6Q4K/G
   TtSfWgKxCYf6g7DjnNaLTimvm26zkNBg0d2NT/HHuoVR42DZsCk6JWXP6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457359186"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="457359186"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 16:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796909973"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="796909973"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.46]) ([10.249.169.46])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 16:29:24 -0700
Message-ID: <384b4d29-1eb5-3a23-6223-b6245398c1c5@linux.intel.com>
Date:   Wed, 9 Aug 2023 07:29:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Will Deacon <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v12 0/8] Re-enable IDXD kernel workqueue under DMA API
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
 <20230808095149.781e88a6@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230808095149.781e88a6@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 0:51, Jacob Pan wrote:
> Hi Baolu/Joerg/All,

Hi Jacob,

> Any other comments?

This series looks good to me now. I will add it in my next pull request
for Joerg.

Best regards,
baolu
