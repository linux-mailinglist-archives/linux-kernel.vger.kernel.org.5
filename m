Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249FA7AEF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjIZOoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjIZOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:44:17 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 07:44:10 PDT
Received: from mgamail.intel.com (unknown [192.198.163.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54870E6;
        Tue, 26 Sep 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695739450; x=1727275450;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=coFPVS3IwCW4LMVf38mdpTFnzhd1Ni1jp/jusMYzufQ=;
  b=f3oxVBZriVqZcWUmUT9ahCnqfou6FmXp8yYl13W5Dj9QFZMwCYC8iGr6
   bwys1NOLgHrTrozdsifThYCkZhsyjfL1ONSozC/OW6vFfrihEa4DFN9Nd
   fHJPSl9bDBRdVMzAbuvun6MTsnqtjmRiztQkdBHR/0qjWQfkxSSBRTEDF
   FKd3AmvFinphPxyZABivQdXefxDK25Ujq508YQqlOF5+b8dMt4RSdOPoC
   N+c8tk0zZlD7ONjnAcdlksstwxC2xsDykmsdy8fZKJJOx5EfFvUumQ3/d
   F1m1b36hih9rs0gF2WkacqiY+MCSaIL3XWEw7EE1fQ9MWWbd2CEVGDkko
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="3163823"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="3163823"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="748835766"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="748835766"
Received: from hhalmen-mobl.ger.corp.intel.com ([10.251.219.207])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:43:06 -0700
Date:   Tue, 26 Sep 2023 17:43:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH 03/11] platform/x86/intel/pmt: Add header to struct
 intel_pmt_entry
In-Reply-To: <20230922213032.1770590-4-david.e.box@linux.intel.com>
Message-ID: <fb605dba-f3d3-dff2-95d5-a2b4e92ab0c5@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com> <20230922213032.1770590-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-681903352-1695739387=:1894"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-681903352-1695739387=:1894
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2023, David E. Box wrote:

> The PMT header is passed to several functions. Instead, store the header in
> struct intel_pmt_entry which is also passed to these functions and shorten
> the argument list. This simplifies the calls in preparation for later
> changes.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-681903352-1695739387=:1894--
