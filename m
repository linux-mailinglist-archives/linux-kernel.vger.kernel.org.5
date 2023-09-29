Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C17B3651
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjI2PFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjI2PFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:05:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B9F7;
        Fri, 29 Sep 2023 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695999930; x=1727535930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Alu4w7xUcVkEoRxLRYWNXtzjFVTWUEum84adccvm2dQ=;
  b=bc8OZNdIQwyxZT0COAleoZaQN14SN1ctnCQieeQlx4afnCGlzlVIlxQT
   0Rp09lWGllZYAdCRa2/9AlO+TxE0/dkbojyD69HN38y1lDVEj1ENgXUbC
   veS54KwS9kGdd7jzho7Lc9VXjLAqxb6KzYD3w9/mTv8EA/T95It1OoSZm
   jtwsHDfgqnZOm3vN+2IbVN8O4d/yGrWev2hNIgFHk+mBmGHFx3hKoQXly
   iqnUrGB+ECPWjRuNCHacLaVDtg+0FZU1Dv0DpAp5Zqbm6MjNNd7Z32f56
   znIm/rYhZaZ1WTjo4OmX+47ym1JMrqMm5D+Ydm0ha8YnaKmkgXFbxPlDe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="362563198"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="362563198"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="820234208"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="820234208"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2023 08:05:19 -0700
Date:   Fri, 29 Sep 2023 23:04:41 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com,
        peter.colberg@intel.com
Subject: Re: [PATCH 2/3] fpga: m10bmc-sec: Change contact for secure update
 driver
Message-ID: <ZRbnidE8juld/fzW@yilunxu-OptiPlex-7050>
References: <20230928164753.278684-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928164753.278684-1-russell.h.weight@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 09:47:53AM -0700, Russ Weight wrote:
> Change the maintainer for the Intel MAX10 BMC Secure Update driver from
> Russ Weight to Peter Colberg. Update the ABI documentation contact
> information as well.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 +++++++-------
>  MAINTAINERS                                        |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> index 0a41afe0ab4c..9051695d2211 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> @@ -1,7 +1,7 @@
>  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
>  Date:		Sep 2022
>  KernelVersion:	5.20
> -Contact:	Russ Weight <russell.h.weight@intel.com>
> +Contact:	Peter Colberg <peter.colberg@intel.com>

I'm not sure if the ABI Contact change is necessary in this case, I tend
to just keep the snapshot for that moment.

[...]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b97ee6f50679..8006c35956bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10755,7 +10755,7 @@ F:	drivers/mfd/intel-m10-bmc*
>  F:	include/linux/mfd/intel-m10-bmc.h
>  
>  INTEL MAX10 BMC SECURE UPDATES
> -M:	Russ Weight <russell.h.weight@intel.com>
> +M:	Peter Colberg <peter.colberg@intel.com>

Hi Peter:

Please Ack if you accept the change.

Thanks,
Yilun

>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> -- 
> 2.25.1
> 
