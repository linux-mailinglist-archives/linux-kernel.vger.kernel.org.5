Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141B37915E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352691AbjIDKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348666AbjIDKxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:53:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663A13E;
        Mon,  4 Sep 2023 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693824830; x=1725360830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4KxRMBRIV9+UB0WisLQgpxuAFxB3nVSMwhSdnQ1sLp0=;
  b=i0ew9g/9w31t8+n8BCAAy3ygedFfT/woWaRuIdk8Zwa4I8sn1p/G8flS
   G1u8evpufkPs+wJ/6wgskeOEFc4+DDyt7zPi7GQ8cIQjVeiGmaYsvsmXR
   8WC0RkZxBZKSEMTMOjBphIjVOSXg5VhlXfK4nVT2K3VebTkDAPuaK67oL
   kg/M198TFF5yakeBgPMZ+Rn+npJIPhsn9j6Wo0FLtPaAl/PXgtEkSbej0
   LSiQ8LauUl8zDUBOvipbq3hRWfYQBbxFECOBHDrS3GJgghMHD2uDd59eg
   Y5adH5SuxE+RL2Fxtaiixc71IgdBkoi+cqOnakx5KAXb4mM/ztEGU0bcN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="440540407"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440540407"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="806229194"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="806229194"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:53:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd7DB-006P8K-0c;
        Mon, 04 Sep 2023 13:53:41 +0300
Date:   Mon, 4 Sep 2023 13:53:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xingui Yang <yangxingui@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, damien.lemoal@opensource.wdc.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        himanshu.madhani@cavium.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, uma.shankar@intel.com,
        anshuman.gupta@intel.com, animesh.manna@intel.com,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        prime.zeng@hisilicon.com, kangfenglong@huawei.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v5 1/3] seq_file: Add helper macro to define attribute
 for rw file
Message-ID: <ZPW3NFT9av+AYwnL@smile.fi.intel.com>
References: <20230904084804.39564-1-yangxingui@huawei.com>
 <20230904084804.39564-2-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904084804.39564-2-yangxingui@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 08:48:02AM +0000, Xingui Yang wrote:
> We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
> for read-only file, but many of drivers want a helper macro for read-write
> file too.
> 
> So we add DEFINE_SHOW_STORE_ATTRIBUTE helper to reduce duplicated code.
> 
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>

I believe you need to preserve Luo's authorship.

Perhaps,
Co-developed-by: Xingui ...
(depending if you really do some job in the certain patch(es) or not).

> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

Code wise LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


