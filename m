Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2C7AEEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjIZOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbjIZOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:40:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35997116;
        Tue, 26 Sep 2023 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695739224; x=1727275224;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Jen9ha9xT0w23LjaD3ERw+ge364NHsqJ9xinSyMoAO8=;
  b=TFERWyZztWlB9XPyuqvRLwJIAi0ISxTeD8ic2FJMbCkdQlhaSBqTK+XK
   ScBUMZ+ZFbqAKILSfblMy89a6pzyblwqQDtLaYtAPM76Rd1Qs7VTNRgJP
   wvPy+0nafR3XlhDA+djoAtMrnwq4upPhORJ9VYuzWMwJGePPUOIwnoj3z
   h3okRnP0Fd9w+ttp3YfVXwx+TZboIeFlHiDF7jm36KdD0d7J+MjcPkkHN
   3WgLaBkRSnGOQP0/a2+OnZBrUjiCZHH05/ymNoOxvbru/Ww+l353BdTM4
   mLOfw9cuu8Tag4UheHxEdhOCNJanVoLLKlUAsIZ6dbBFKCRaOF0DX3Fxq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="467870972"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="467870972"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="783967680"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="783967680"
Received: from hhalmen-mobl.ger.corp.intel.com ([10.251.219.207])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:39:55 -0700
Date:   Tue, 26 Sep 2023 17:39:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH 02/11] platform/x86/intel/vsec: Add base address field
In-Reply-To: <20230922213032.1770590-3-david.e.box@linux.intel.com>
Message-ID: <25fec2f6-b01f-1488-fcdc-8986ab452a78@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com> <20230922213032.1770590-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1181111632-1695739197=:1894"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1181111632-1695739197=:1894
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2023, David E. Box wrote:

> Some devices may emulate PCI VSEC capabilities in MMIO. In such cases the
> BAR is not readable from a config space. Provide a field for drivers to
> indicate the base address to be used.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c | 14 +++++++++++---
>  drivers/platform/x86/intel/vsec.c      | 10 ++++++++--
>  drivers/platform/x86/intel/vsec.h      |  2 ++
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index 2ad91d2fd954..32608baaa56c 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -160,10 +160,11 @@ static struct class intel_pmt_class = {
>  
>  static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
>  				    struct intel_pmt_header *header,
> -				    struct device *dev,
> +				    struct intel_vsec_device *ivdev,
>  				    struct resource *disc_res)
>  {
> -	struct pci_dev *pci_dev = to_pci_dev(dev->parent);
> +	struct pci_dev *pci_dev = ivdev->pcidev;
> +	struct device *dev = &ivdev->auxdev.dev;
>  	u8 bir;
>  
>  	/*
> @@ -215,6 +216,13 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
>  
>  		break;
>  	case ACCESS_BARID:
> +		/* Use the provided base address if it exists */
> +		if (ivdev->base_addr) {
> +			entry->base_addr = ivdev->base_addr +
> +				   GET_ADDRESS(header->base_offset);
> +			break;
> +		}
> +
>  		/*
>  		 * If another BAR was specified then the base offset
>  		 * represents the offset within that BAR. SO retrieve the
> @@ -319,7 +327,7 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
>  	if (ret)
>  		return ret;
>  
> -	ret = intel_pmt_populate_entry(entry, &header, dev, disc_res);
> +	ret = intel_pmt_populate_entry(entry, &header, intel_vsec_dev, disc_res);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index c5d0202068cf..e0dd64dec9eb 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -150,6 +150,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  	struct intel_vsec_device *intel_vsec_dev;
>  	struct resource *res, *tmp;
>  	unsigned long quirks = info->quirks;
> +	u64 base_addr;
>  	int i;
>  
>  	if (!intel_vsec_supported(header->id, info->caps))
> @@ -178,14 +179,18 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
>  		header->offset >>= TABLE_OFFSET_SHIFT;
>  
> +	if (info->base_addr)
> +		base_addr = info->base_addr;
> +	else
> +		base_addr = pdev->resource[header->tbir].start;
> +
>  	/*
>  	 * The DVSEC/VSEC contains the starting offset and count for a block of
>  	 * discovery tables. Create a resource array of these tables to the
>  	 * auxiliary device driver.
>  	 */
>  	for (i = 0, tmp = res; i < header->num_entries; i++, tmp++) {
> -		tmp->start = pdev->resource[header->tbir].start +
> -			     header->offset + i * (header->entry_size * sizeof(u32));
> +		tmp->start = base_addr + header->offset + i * (header->entry_size * sizeof(u32));
>  		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
>  		tmp->flags = IORESOURCE_MEM;
>  
> @@ -203,6 +208,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  	intel_vsec_dev->resource = res;
>  	intel_vsec_dev->num_resources = header->num_entries;
>  	intel_vsec_dev->quirks = info->quirks;
> +	intel_vsec_dev->base_addr = info->base_addr;
>  
>  	if (header->id == VSEC_ID_SDSI)
>  		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
> diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
> index ab0f161f86c5..bddd33e1c17e 100644
> --- a/drivers/platform/x86/intel/vsec.h
> +++ b/drivers/platform/x86/intel/vsec.h
> @@ -73,6 +73,7 @@ struct intel_vsec_platform_info {
>  	struct intel_vsec_header **headers;
>  	unsigned long caps;
>  	unsigned long quirks;
> +	u64 base_addr;
>  };
>  
>  struct intel_vsec_device {
> @@ -84,6 +85,7 @@ struct intel_vsec_device {
>  	void *priv_data;
>  	size_t priv_data_size;
>  	unsigned long quirks;
> +	u64 base_addr;
>  };
>  
>  int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1181111632-1695739197=:1894--
