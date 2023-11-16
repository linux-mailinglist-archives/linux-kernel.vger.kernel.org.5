Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400F87EDA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbjKPD3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjKPD3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:29:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B5199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700105377; x=1731641377;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e7Vj3hzUi2owuqUml83r8SMkIgCZDOcihonf5G65bzo=;
  b=jxTa5LVAtU3/gIt6Vji4M2uaQSgab54eKzficy/vK1/gQ3aDJ39iJ7lA
   NP1snlI6ZsqdYtuXnCqxjUTEVEmgOgHgwEeczoYT5A0QO1fheJ1qMF0BS
   0BkhWm1cTKWayr6uLiJtbuMgzsUGg970ftiOo4XnMsEW+C6qfB2GUyJ+r
   1i7kfOjvmGzj3NA1bF2/zUWEjR/UZX79+VyRUFsg9vsLegY07c4VRsBKN
   5cyP5UOkgTMyrfp1aSi50PriEDheKGglyFDWocpG2PoXtd2nvGpKKpkPx
   yQQAgD//o03iDuBlIF9l6FfDhCuenPkkhL/G40G9Rx++CYz0I7gJuMrm3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4132795"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="4132795"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765180796"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="765180796"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2023 19:29:14 -0800
Message-ID: <d6e8fbaf-c49d-421f-ad05-7737060785ff@linux.intel.com>
Date:   Thu, 16 Nov 2023 11:25:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] iommu/vt-d: Remove unused vcmd interfaces
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762063ED9337AD624E62148CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762063ED9337AD624E62148CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 11:21 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 16, 2023 9:51 AM
>>
>> Commit 99b5726b4423 ("iommu: Remove ioasid infrastructure") has
>> removed
>> ioasid allocation interfaces from the iommu subsystem. As a result, these
>> vcmd interfaces have become obsolete. Remove them to avoid dead code.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> it's a surprise to see some remaining vcmd bits not removed.
> 
> with a grep actually there are more (mostly in the header files):
> 
> drivers/iommu/intel/debugfs.c:  IOMMU_REGSET_ENTRY(VCMD),
> drivers/iommu/intel/pasid.h:#define VCMD_CMD_ALLOC                      0x1
> drivers/iommu/intel/pasid.h:#define VCMD_CMD_FREE                       0x2
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_IP                        0x1
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC(e)                     (((e) & 0xff) >> 1)
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_SUCCESS                0
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_NO_PASID_AVAIL 16
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_INVALID_PASID  16
> drivers/iommu/intel/pasid.h:#define VCMD_VRSP_RESULT_PASID(e)   (((e) >> 16) & 0xfffff)
> drivers/iommu/intel/pasid.h:#define VCMD_CMD_OPERAND(e)         ((e) << 16)
> drivers/iommu/intel/iommu.h:#define DMAR_VCMD_REG               0xe00 /* Virtual command register */
> 
> 

Yeah! I will also remove these bits. Thanks!

Best regards,
baolu
