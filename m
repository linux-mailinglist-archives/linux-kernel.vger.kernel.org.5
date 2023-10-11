Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6607C569B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjJKOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjJKOTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:19:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6171494;
        Wed, 11 Oct 2023 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697033950; x=1728569950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nwCeJNHIIRZPGycCs5gkVuh7s3d3VBXGtgJ02EDRMNo=;
  b=KsoucaIj7aBEs41Qj9npVFB+HFmqSGJvak5BdQhxZOQ/HNY9zesYMFUg
   cPNC9/FlwV5+aPpnA8D1JFg47ArWv+40kyl/pB73sR6uhx8Ws79ClZSiD
   OMOrdGpa9cQLZRZynIlz0pisoEyqclL56Uuq6carU+Zc+JKs823etHMl/
   jnVjv9t6VE+p9g45ZBC0uS40OqxmyEsj96gJlLzjUJr3pImADeh40rCXp
   lQgB02NEmxdWRezV+57DrtMKKuq8zmUYk2cms2kguNEJfAXwoc9ADggo6
   TQAXOOPG05O4QFMPhsnmSc5ausNVwzO9Saot+X39UQINPAUANvfOTMKzF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388537752"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="388537752"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 07:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870161304"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="870161304"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2023 07:19:07 -0700
Message-ID: <541d23eb-8dad-2c96-e0ab-76146d0acfdc@linux.intel.com>
Date:   Wed, 11 Oct 2023 17:20:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v1 10/10] xhci: dbc: Add missing headers
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
 <20231002161610.2648818-10-andriy.shevchenko@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20231002161610.2648818-10-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.10.2023 19.16, Andy Shevchenko wrote:
> Don't inherit headers "by chances" from asm/bug.h, asm/io.h,
> etc... Include the needed headers explicitly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/usb/host/xhci-dbgcap.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
> index 366ce3146a93..eb2e89bf31be 100644
> --- a/drivers/usb/host/xhci-dbgcap.c
> +++ b/drivers/usb/host/xhci-dbgcap.c
> @@ -6,9 +6,24 @@
>    *
>    * Author: Lu Baolu <baolu.lu@linux.intel.com>
>    */
> +#include <linux/device.h>
>   #include <linux/dma-mapping.h>
> -#include <linux/slab.h>
> +#include <linux/errno.h>
> +#include <linux/kstrtox.h>
> +#include <linux/list.h>
>   #include <linux/nls.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +
> +#include <asm/bug.h>
> +#include <asm/byteorder.h>

Checkpatch complains about this:

WARNING: Use #include <linux/bug.h> instead of <asm/bug.h>

-Mathias
