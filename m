Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772D27C5686
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjJKORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjJKORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:17:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B993;
        Wed, 11 Oct 2023 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697033821; x=1728569821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c17UurypKKNWzJXvHu//qpZKgYSik3NedPr3yahsuWs=;
  b=X6GqtRBbnfM3JgLDy/vvXvMUZlzjOy6uVhgphc5F8MW9Vi0b63uv/MYn
   l2jKEo5CxEiqS8Bk1w4mABJyY/8Izy+U/JGZyqL5/kt2IsiM6bGC1h2iA
   0oBNf+bWZ0G3aponSGzU64+ERnu5xYLDxNcXIwzh0LhTH1IG3OEmKaGyJ
   E9b90f62z9gDKTS0w88PUUmOubngJRRNUDpTe91z4oGDcNLyKdjWOFUUv
   BzhD/1IjSZriUM96+iplAFq82AANBGjj9wpR+C4iZfb6X/7EnmDuGPlO3
   Q5nkAjW2G4yLU+10NwJM6uHsxvRJ4zY4q9iPfN6eGxBD7P/TrSJ6G0q2R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="451163293"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="451163293"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 07:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730516948"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="730516948"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga006.jf.intel.com with ESMTP; 11 Oct 2023 07:16:49 -0700
Message-ID: <a903222f-b501-13b4-94ce-efbcc2afd3b6@linux.intel.com>
Date:   Wed, 11 Oct 2023 17:18:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v1 04/10] xhci: dbc: Use ATTRIBUTE_GROUPS()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
 <20231002161610.2648818-4-andriy.shevchenko@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20231002161610.2648818-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Embrace ATTRIBUTE_GROUPS() to avoid boiler plate code.
> This should not introduce any functional changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/usb/host/xhci-dbgcap.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
> index 92869c67a430..3c90410e9cde 100644
> --- a/drivers/usb/host/xhci-dbgcap.c
> +++ b/drivers/usb/host/xhci-dbgcap.c
> @@ -1124,7 +1124,7 @@ static DEVICE_ATTR_RW(dbc_idProduct);
>   static DEVICE_ATTR_RW(dbc_bcdDevice);
>   static DEVICE_ATTR_RW(dbc_bInterfaceProtocol);
>   
> -static struct attribute *dbc_dev_attributes[] = {
> +static struct attribute *dbc_dev_attrs[] = {
>   	&dev_attr_dbc.attr,
>   	&dev_attr_dbc_idVendor.attr,
>   	&dev_attr_dbc_idProduct.attr,
> @@ -1132,10 +1132,7 @@ static struct attribute *dbc_dev_attributes[] = {
>   	&dev_attr_dbc_bInterfaceProtocol.attr,
>   	NULL
>   };
> -
> -static const struct attribute_group dbc_dev_attrib_grp = {
> -	.attrs = dbc_dev_attributes,
> -};
> +ATTRIBUTE_GROUPS(dbc_dev);
>   
>   struct xhci_dbc *
>   xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *driver)
> @@ -1161,7 +1158,7 @@ xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *
>   	INIT_DELAYED_WORK(&dbc->event_work, xhci_dbc_handle_events);
>   	spin_lock_init(&dbc->lock);
>   
> -	ret = sysfs_create_group(&dev->kobj, &dbc_dev_attrib_grp);
> +	ret = sysfs_create_groups(&dev->kobj, &dbc_dev_groups)  
Compiler warns:

drivers/usb/host/xhci-dbgcap.c:1186:40: error: passing argument 2 of ‘sysfs_create_groups’ from incompatible pointer type

should probably be:
sysfs_create_groups(&dev->kobj, dbc_dev_groups)

-Mathias


