Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F357D3A79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJWPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjJWPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:14:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0777103;
        Mon, 23 Oct 2023 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698074061; x=1729610061;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F/80+LA8DAgnb+BIYCO0swzOrWOKhwnOaiRx/CzCCd0=;
  b=YzE4paJGmidFKGpNYoZEXsqf7/7EsaUMj+JLWF01NYDd9Nj6kx1BJ30t
   geScA6XOZz2lpzmy6J9a+D/Um9HZp4yj+b5/Jjmqz/lH5iWXP5lKFJ2m/
   8DQCHV59gXVDuEP8skszEdk2oK+MO6NjSzOR/HcPpowX3ZIv51PBdkD4g
   2OJjfrUsmLkFmlK4By1vFIVuvq0MhiqG02OI8fWTBnuUK7p6bgrTgh7WC
   Y5QXozRxbz0vx5IF75HEO/7kQN81qCltQ+dlq+9AzSe0YwC7gCb4bOG7p
   SX8vTolIHhy0PeyVw6gJx1e1tgCRWr1XHVCIOT0q0NQy6NyhMuQogkh77
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384061542"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="384061542"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="6113537"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:14:13 -0700
Date:   Mon, 23 Oct 2023 18:14:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 06/17] platform/x86/intel/pmt: Add header to struct
 intel_pmt_entry
In-Reply-To: <20231018231624.1044633-7-david.e.box@linux.intel.com>
Message-ID: <51e480e7-f3e7-f4bd-294e-532639fe6da6@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-7-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1047910326-1698074059=:1721"
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

--8323329-1047910326-1698074059=:1721
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 18 Oct 2023, David E. Box wrote:

> The PMT header is passed to several functions. Instead, store the header in
> struct intel_pmt_entry which is also passed to these functions and shorten
> the argument list. This simplifies the calls in preparation for later
> changes.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> V4 - No change
> 
> V3 - No change
> 
> V2 - No change
> 
>  drivers/platform/x86/intel/pmt/class.c     |  8 +++-----
>  drivers/platform/x86/intel/pmt/class.h     | 16 ++++++++--------
>  drivers/platform/x86/intel/pmt/crashlog.c  |  2 +-
>  drivers/platform/x86/intel/pmt/telemetry.c |  2 +-
>  4 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index 32608baaa56c..142a24e3727d 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -159,12 +159,12 @@ static struct class intel_pmt_class = {
>  };
>  
>  static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
> -				    struct intel_pmt_header *header,
>  				    struct intel_vsec_device *ivdev,
>  				    struct resource *disc_res)
>  {
>  	struct pci_dev *pci_dev = ivdev->pcidev;
>  	struct device *dev = &ivdev->auxdev.dev;
> +	struct intel_pmt_header *header = &entry->header;
>  	u8 bir;
>  
>  	/*
> @@ -313,7 +313,6 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
>  			 struct intel_vsec_device *intel_vsec_dev, int idx)
>  {
>  	struct device *dev = &intel_vsec_dev->auxdev.dev;
> -	struct intel_pmt_header header;
>  	struct resource	*disc_res;
>  	int ret;
>  
> @@ -323,16 +322,15 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
>  	if (IS_ERR(entry->disc_table))
>  		return PTR_ERR(entry->disc_table);
>  
> -	ret = ns->pmt_header_decode(entry, &header, dev);
> +	ret = ns->pmt_header_decode(entry, dev);
>  	if (ret)
>  		return ret;
>  
> -	ret = intel_pmt_populate_entry(entry, &header, intel_vsec_dev, disc_res);
> +	ret = intel_pmt_populate_entry(entry, intel_vsec_dev, disc_res);
>  	if (ret)
>  		return ret;
>  
>  	return intel_pmt_dev_register(entry, ns, dev);
> -

Newline change that doesn't belong to this patch.

-- 
 i.


>  }
>  EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, INTEL_PMT);
>  
> diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
> index db11d58867ce..e477a19f6700 100644
> --- a/drivers/platform/x86/intel/pmt/class.h
> +++ b/drivers/platform/x86/intel/pmt/class.h
> @@ -18,7 +18,15 @@
>  #define GET_BIR(v)		((v) & GENMASK(2, 0))
>  #define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
>  
> +struct intel_pmt_header {
> +	u32	base_offset;
> +	u32	size;
> +	u32	guid;
> +	u8	access_type;
> +};
> +
>  struct intel_pmt_entry {
> +	struct intel_pmt_header	header;
>  	struct bin_attribute	pmt_bin_attr;
>  	struct kobject		*kobj;
>  	void __iomem		*disc_table;
> @@ -29,19 +37,11 @@ struct intel_pmt_entry {
>  	int			devid;
>  };
>  
> -struct intel_pmt_header {
> -	u32	base_offset;
> -	u32	size;
> -	u32	guid;
> -	u8	access_type;
> -};
> -
>  struct intel_pmt_namespace {
>  	const char *name;
>  	struct xarray *xa;
>  	const struct attribute_group *attr_grp;
>  	int (*pmt_header_decode)(struct intel_pmt_entry *entry,
> -				 struct intel_pmt_header *header,
>  				 struct device *dev);
>  };
>  
> diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
> index bbb3d61d09f4..4014c02cafdb 100644
> --- a/drivers/platform/x86/intel/pmt/crashlog.c
> +++ b/drivers/platform/x86/intel/pmt/crashlog.c
> @@ -223,10 +223,10 @@ static const struct attribute_group pmt_crashlog_group = {
>  };
>  
>  static int pmt_crashlog_header_decode(struct intel_pmt_entry *entry,
> -				      struct intel_pmt_header *header,
>  				      struct device *dev)
>  {
>  	void __iomem *disc_table = entry->disc_table;
> +	struct intel_pmt_header *header = &entry->header;
>  	struct crashlog_entry *crashlog;
>  
>  	if (!pmt_crashlog_supported(entry))
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
> index 39cbc87cc28a..f86080e8bebd 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -58,10 +58,10 @@ static bool pmt_telem_region_overlaps(struct intel_pmt_entry *entry,
>  }
>  
>  static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
> -				   struct intel_pmt_header *header,
>  				   struct device *dev)
>  {
>  	void __iomem *disc_table = entry->disc_table;
> +	struct intel_pmt_header *header = &entry->header;
>  
>  	if (pmt_telem_region_overlaps(entry, dev))
>  		return 1;
> 
--8323329-1047910326-1698074059=:1721--
