Return-Path: <linux-kernel+bounces-159491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424BE8B2F56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE6CB21B21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51D824A1;
	Fri, 26 Apr 2024 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXvM49Xj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978AD82499;
	Fri, 26 Apr 2024 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714104949; cv=none; b=YauK7kuP7Jc5CojIzkPOBAL/td98DeWSpjOX5indeKFIJGfRvJC+z0A0wJsvltCSa/0cB/q1vvwe+saDtjU/GZkTeDCZa5FwH/rL8wM/gxNn78yVzawpOJ8XeH6cJRdkStg44m2JvvSRr7GAEodrwE3m4SA4hC1vFDTnSqHMfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714104949; c=relaxed/simple;
	bh=v7mnz/clg1OHc1VYa7IcfhROhQanCvHH2u9lI8vRb6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7TjDdKdkQzz8dQ95sgJ8fUbxElikMz7AscdzoDnK3ekzGcm6GmrEdmo0y0ya0CbGvemq/nC+mHIltTW9q4NnrE04vOdiPy301DyRWOxVV8E0ufJQ1qilJW95WpS7nxyBxm9VWIV2XdEGemxkXtZKyJK4HRjE/HZAeYPZ25X/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXvM49Xj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714104946; x=1745640946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v7mnz/clg1OHc1VYa7IcfhROhQanCvHH2u9lI8vRb6Y=;
  b=BXvM49XjIRdmaBhjYu7C3nGyq+H9ED7l2c28kDbyDIMiVvaGcETd1IQu
   Z7K/A5H5/18OtddabuVVJyOJ/Jido9BLyfM/IGy5R2Qr5u+02heFs9trA
   zrQb7/TikHcio3ZCUDKFNEsW226UJh81tJFOyzXlw+6Oe9h1bz6tVU4LT
   csdjadAlUzFh3LkOoncywRpZAIkrDLseO7zWSjwUMWxhXCm7hMswXitFm
   cqZzwytr8R+lLvhw1YYJaw8XR/tgVGdL3W0t6XkfdoCO0RKB/E1F2kIFI
   tEY+sQaX423bf2d+kF0eK/5Mh5O+fFJ4T9y1lOOzSWOHet+XQh3/nNLmA
   Q==;
X-CSE-ConnectionGUID: 0F7mEABcSYa3ctNbvhEIkQ==
X-CSE-MsgGUID: 6N8RjZGgR/+vhKfs8PApRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13612676"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="13612676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:15:46 -0700
X-CSE-ConnectionGUID: OUIWma01RGeHEEYnNhnerg==
X-CSE-MsgGUID: jBA13mM8Qy2SwJNhhXecQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="30096926"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 25 Apr 2024 21:15:43 -0700
Date: Fri, 26 Apr 2024 12:10:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH] fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card
Message-ID: <ZispK+l5kWCxtfns@yilunxu-OptiPlex-7050>
References: <20240422230257.1959-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422230257.1959-1-peter.colberg@intel.com>

On Mon, Apr 22, 2024 at 07:02:57PM -0400, Peter Colberg wrote:
> Add PCI subdevice ID for the Intel D5005 Stratix 10 FPGA card as
> used with the Open FPGA Stack (OFS) FPGA Interface Manager (FIM).
> 
> Unlike the Intel D5005 PAC FIM which exposed a separate PCI device ID,
> the OFS FIM reuses the same device ID for all DFL-based FPGA cards
> and differentiates on the subdevice ID. The subdevice ID values were
> chosen as the numeric part of the FPGA card names in hexadecimal.
> 
> Link: https://github.com/OFS/dfl-feature-id/pull/4

Any reason to put the Link in changelog. I didn't see it provide any
extra info.

> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Besides,

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> This patch was applied to Linux v6.9-rc5 and tested on an Intel D5005
> card flashed with the latest released OFS 2024.1-1 D5005 FIM.
> 
> # fpgainfo fme D8:00.0
> Intel FPGA Programmable Acceleration Card D5005
> Board Management Controller, MAX10 NIOS FW version: 2.0.12 
> Board Management Controller, MAX10 Build version: 2.0.8 
> //****** FME ******//
> Interface                        : DFL
> Object Id                        : 0xED00002
> PCIe s:b:d.f                     : 0000:D8:00.0
> Vendor Id                        : 0x8086
> Device Id                        : 0xBCCE
> SubVendor Id                     : 0x8086
> SubDevice Id                     : 0x138D
> Socket Id                        : 0x00
> Ports Num                        : 01
> Bitstream Id                     : 0x4010002183C88A9
> Bitstream Version                : 4.0.1
> Pr Interface Id                  : a195b6f7-cf23-5a2b-8ef9-1161e184ec4e
> Boot Page                        : user
> 
> Link: https://github.com/OFS/ofs-d5005/releases/tag/ofs-2024.1-1
> ---
> The missing subdevice ID 0x138d was noticed while testing the patch
> series "fpga: dfl: fix kernel warning on port release/assign for SRIOV"
> applied to v6.9-rc4 on an Intel D5005 card. The absence of the subdevice
> ID was shadowed by an internal patch in the downstream Linux DFL kernel
> ("fpga: dfl: Add wildcard sub-device ID for intel DFL devs").
> 
> Link: https://github.com/OFS/linux-dfl/commit/27d3d71824f086acae86e41a87b591838b7fa9d1
> ---
>  drivers/fpga/dfl-pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 98b8fd16183e..80cac3a5f976 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -78,6 +78,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
>  #define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
>  /* PCI Subdevice ID for PCIE_DEVICE_ID_INTEL_DFL */
> +#define PCIE_SUBDEVICE_ID_INTEL_D5005		0x138d
>  #define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
>  #define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
>  #define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
> @@ -101,6 +102,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_D5005),},
>  	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
>  			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
>  	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
> -- 
> 2.44.0
> 
> 

