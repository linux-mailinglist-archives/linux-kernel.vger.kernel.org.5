Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD97C7189
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379300AbjJLPcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjJLPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:32:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CBCB8;
        Thu, 12 Oct 2023 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697124736; x=1728660736;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dSAg/G//eulRtafvXGpn3Ky7PI8YMEg3RAQWM58aE8M=;
  b=mgw0JCwA3yQaFrZo5GK4X8pDFqeDdMTbaYwBT3+pt0bcnCn3lVYjbyfN
   XwqD/60XnWWRDJIUFcwS9uQbslOGK85cGDBMc/BWVzKMkdATMVBA2Dtt9
   AbayIhDVgx7xoGmYL5Zw38a2ly56vkWRoIBcNlDyjeavvhqATi+aOIM76
   p+ZFXhygc8D2LRZiKTKG7T6WjD77lfs9xnnIsiP9icmggrDK4iUyCSCjK
   0HZhx8F61shJ4WmIiccv8h0XG3NWIm6CzheOKX2lmHudduMnDPOrB/RaQ
   cpgsrUEgBbEMcmWU6ALeFO71jCSMmfz2tswaJsMstVQp8nepySy09Ec2z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365218665"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365218665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 08:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824648954"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="824648954"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 08:31:50 -0700
Date:   Thu, 12 Oct 2023 18:31:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V3 02/16] platform/x86/intel/vsec: remove platform_info
 from vsec device structure
In-Reply-To: <20231012023840.3845703-3-david.e.box@linux.intel.com>
Message-ID: <1c56cbb-5745-5d50-fdc0-ceb9a4f1dab0@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com> <20231012023840.3845703-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-925584748-1697124711=:1692"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-925584748-1697124711=:1692
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, David E. Box wrote:

> In preparation for exporting an API to register Intel Vendor Specific
> Extended Capabilities (VSEC) from other drivers, remove the pointer to
> platform_info from intel_vsec_device. This prevents a potential page fault
> when auxiliary drivers probe and attempt to dereference this pointer to
> access the needed quirks field. Instead, just add the quirks to
> intel_vsec_device.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> V3 - No change
> 
> V2 - New patch splitting previous PATCH 1
> 
>  drivers/platform/x86/intel/pmt/class.c | 2 +-
>  drivers/platform/x86/intel/vsec.c      | 2 +-
>  drivers/platform/x86/intel/vsec.h      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index f32a233470de..2ad91d2fd954 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -31,7 +31,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
>  	 * differences from the server platforms (which use the Out Of Band
>  	 * Management Services Module OOBMSM).
>  	 */
> -	return !!(ivdev->info->quirks & VSEC_QUIRK_EARLY_HW);
> +	return !!(ivdev->quirks & VSEC_QUIRK_EARLY_HW);
>  }
>  EXPORT_SYMBOL_NS_GPL(intel_pmt_is_early_client_hw, INTEL_PMT);
>  
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 6bb233a23414..15866b7d3117 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -201,7 +201,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  	intel_vsec_dev->pcidev = pdev;
>  	intel_vsec_dev->resource = res;
>  	intel_vsec_dev->num_resources = header->num_entries;
> -	intel_vsec_dev->info = info;
> +	intel_vsec_dev->quirks = info->quirks;
>  
>  	if (header->id == VSEC_ID_SDSI)
>  		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
> diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
> index c242c07ea69c..8b9fad170503 100644
> --- a/drivers/platform/x86/intel/vsec.h
> +++ b/drivers/platform/x86/intel/vsec.h
> @@ -79,11 +79,11 @@ struct intel_vsec_device {
>  	struct pci_dev *pcidev;
>  	struct resource *resource;
>  	struct ida *ida;
> -	struct intel_vsec_platform_info *info;
>  	int num_resources;
>  	int id; /* xa */

What is this based on??

Unfortunately, I couldn't review some of your later patches efficiently 
because this patch failed to apply.

-- 
 i.

--8323329-925584748-1697124711=:1692--
