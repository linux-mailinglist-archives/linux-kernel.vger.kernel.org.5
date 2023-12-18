Return-Path: <linux-kernel+bounces-3795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B278171BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061B21C24B64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1604FF6F;
	Mon, 18 Dec 2023 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H74sE8dC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9B49896;
	Mon, 18 Dec 2023 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702908006; x=1734444006;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rwmzKpW5DiBN9LWuEc45wq/dlZAzsDx677yrehL0PUE=;
  b=H74sE8dCXpt+mUpDt37A7/VZwqQm5mho6xCUHZnoD6bjpDNJClj+0/fH
   08CzsNKNTSX9GQfB+t6VaggdWyLt6744R+YnK7nHQaIjeKj7Q6ysHHvCA
   3jtWjP4cR/Mz97JcI2+30EsgeZgj3lo+YoPImCVWdHTcqhoZrOuVhyfDD
   JjpGdFrvYeJHcbRqPmww+BvxYhCO201JscfTotlLJUaPWdD8cjxgoHzQ5
   yO2Na7m834jW4UL1X9VsXwa1BLAS+L3BHdwz5TuVc1/xFyQ1SLevxNz7x
   8sQnGyM+XzKuhcWmlt3HiKbcI3zoTdJQWwO+EphucRVGyfdML6zCxrS3S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8959500"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="8959500"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 06:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="845957060"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="845957060"
Received: from gmarin-mobl1.ger.corp.intel.com ([10.252.34.78])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:59:57 -0800
Date: Mon, 18 Dec 2023 15:59:54 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: rjingar <rajvi.jingar@linux.intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/vsec: Add support for Lunar Lake M
In-Reply-To: <20231216005146.1735455-1-rajvi.jingar@linux.intel.com>
Message-ID: <228972a5-3ee-fd25-2421-f42614d0179@linux.intel.com>
References: <20231216005146.1735455-1-rajvi.jingar@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1088228024-1702907998=:2348"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1088228024-1702907998=:2348
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Dec 2023, rjingar wrote:

> From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> 
> Add Lunar Lake M PMT telemetry support.
> 
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> ---
>  drivers/platform/x86/intel/vsec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index c1f9e4471b28..3567dba57781 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -421,6 +421,11 @@ static const struct intel_vsec_platform_info tgl_info = {
>  	.quirks = VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
>  };
>  
> +/* LNL info */
> +static const struct intel_vsec_platform_info lnl_info = {
> +	.caps = VSEC_CAP_TELEMETRY | VSEC_CAP_WATCHER,
> +};
> +
>  #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
>  #define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
>  #define PCI_DEVICE_ID_INTEL_VSEC_MTL_M		0x7d0d
> @@ -428,6 +433,7 @@ static const struct intel_vsec_platform_info tgl_info = {
>  #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
>  #define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
>  #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
> +#define PCI_DEVICE_ID_INTEL_VSEC_LNL_M		0x647d
>  static const struct pci_device_id intel_vsec_pci_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
> @@ -436,6 +442,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &oobmsm_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
> +	{ PCI_DEVICE_DATA(INTEL, VSEC_LNL_M, &lnl_info) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, intel_vsec_pci_ids);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1088228024-1702907998=:2348--

