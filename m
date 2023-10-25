Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0A7D6B63
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjJYMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjJYMZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:25:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4CC1;
        Wed, 25 Oct 2023 05:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698236725; x=1729772725;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+snF8WpLYOf3FfP6eAfIi+MSvoRrSzIJD5FHq+jNHXo=;
  b=eGcbO7cxAOs3DcvEzOCueAm+utSXfdr4iN+gUshWeUvdHKem3r6BfUTw
   AAr7MEs/vep365EsOnsxBV/LWorAEDraqqRcjkXRfHqZ0Ao9Tn2Io6e8X
   7odrPP8eVB/J1pMRKeOFbabJXCbMaKrcmijm7zikb0lOYCENz6+qs6iJH
   mhC6ZkA+7uNyH8VCjsRshJE+y2mPugtRX5VwRXzgl7Qndg15E1ug1O9ND
   5vMkiSXPI8TRN8rPNrRHqp0w5h95Ll64/j+18uxDW3kKPPnvfao/ksWAR
   EKCwJfR5nk81jgjxSl9O8vPdel3b+alElwwMHp7qpyMgBU5e1Xgk1v7bD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451521607"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="451521607"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 05:25:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1090189710"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1090189710"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.178]) ([10.254.211.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 05:25:21 -0700
Message-ID: <2dea40af-af71-4ea6-b3db-fd0db17c9846@linux.intel.com>
Date:   Wed, 25 Oct 2023 20:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Yi Liu <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20231025153455.283c5b12@canb.auug.org.au>
 <20231025121212.GB3952@nvidia.com>
 <617cc452-2d31-4fe0-a808-a980baa43056@linux.intel.com>
 <20231025121744.GD3952@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231025121744.GD3952@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/25 20:17, Jason Gunthorpe wrote:
> On Wed, Oct 25, 2023 at 08:16:16PM +0800, Baolu Lu wrote:
>> On 2023/10/25 20:12, Jason Gunthorpe wrote:
>>> On Wed, Oct 25, 2023 at 03:34:55PM +1100, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Today's linux-next merge of the iommufd tree got a conflict in:
>>>>
>>>>     drivers/iommu/intel/pasid.c
>>>>
>>>> between commit:
>>>>
>>>>     c61c255e114c ("iommu/vt-d: Remove unused function")
>>>>
>>>> from the iommu tree and commits:
>>>>
>>>>     f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
>>>>     cbf8b441ea08 ("iommu/vt-d: Add helper to setup pasid nested translation")
>>>>
>>>> from the iommufd tree.
>>>>
>>>> I fixed it up (the latter added a use of the function removed by
>>>> the former, so I just used the latter) and can carry the fix as
>>>> necessary. This is now fixed as far as linux-next is concerned, but any
>>>> non trivial
>>> Intel folks, this is not nice 🙁 Why was the first commit done at all
>>> if the nesting series needs this?
>> It's my fault. My apologies for not realizing that the helper would
>> still be used by the nesting translation series. I will be more careful
>> in the future.
> Can you send a revert of c61c255e114c ASAP to Joerg please?

Sure!

Best regards,
baolu
