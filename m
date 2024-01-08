Return-Path: <linux-kernel+bounces-19360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03866826BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9243F282E47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7014003;
	Mon,  8 Jan 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brIYRnfj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BC13FFB;
	Mon,  8 Jan 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704711176; x=1736247176;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OAUhQ/TR7A7NytdPGBdRlhb9xG+z8S8msU7oGu6+pTQ=;
  b=brIYRnfjFGHRBP6DR+rK8Vwm0AP1eSUDxK5qI7rc2zDKjbcBBnZ158xm
   Y3C2WIc+KbiJd/P2+EWBW1v2adK4YUzFLIiCoyYWpj5H1Kz1uiWXjtkAo
   MRmenXGm7als0hTD0ApUy7BOeK0vdz+es02GLURcPjhZs5+JMh6JS8X9c
   qZ9ju6hcQu8gNYojneYMjIuMwNG8rUEAP9fvWZI87On+OhZu/LR9pIxv+
   wSp3529Y6wI5vDczxoG45dfa0PJzLdEbKU2VDXJxsg6/IxPPCKgNF3dpb
   mYYyfWdWdkdIGawfMCgIuqEzaZJl/ijMTTUs6AAdtmcGq722r64EwmH3U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="16449708"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="16449708"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028370659"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1028370659"
Received: from stinti-mobl.ger.corp.intel.com ([10.249.37.10])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:52:52 -0800
Date: Mon, 8 Jan 2024 12:52:47 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
cc: jithu.joseph@intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: intel-wmi-sbl-fw-update: Fix function name
 in error message
In-Reply-To: <20240106224126.13803-1-W_Armin@gmx.de>
Message-ID: <2e86d7b5-bdf4-71be-8296-77626f43891@linux.intel.com>
References: <20240106224126.13803-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-265098238-1704711173=:1762"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-265098238-1704711173=:1762
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 6 Jan 2024, Armin Wolf wrote:

> Since when the driver was converted to use the bus-based WMI
> interface, the old GUID-based WMI functions are not used anymore.
> Update the error message to avoid confusing users.
> 
> Compile-tested only.
> 
> Fixes: 75c487fcb69c ("platform/x86: intel-wmi-sbl-fw-update: Use bus-based WMI interface")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/intel/wmi/sbl-fw-update.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> index 9cf5ed0f8dc2..040153ad67c1 100644
> --- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> +++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> @@ -32,7 +32,7 @@ static int get_fwu_request(struct device *dev, u32 *out)
>  		return -ENODEV;
> 
>  	if (obj->type != ACPI_TYPE_INTEGER) {
> -		dev_warn(dev, "wmi_query_block returned invalid value\n");
> +		dev_warn(dev, "wmidev_block_query returned invalid value\n");
>  		kfree(obj);
>  		return -EINVAL;
>  	}
> @@ -55,7 +55,7 @@ static int set_fwu_request(struct device *dev, u32 in)
> 
>  	status = wmidev_block_set(to_wmi_device(dev), 0, &input);
>  	if (ACPI_FAILURE(status)) {
> -		dev_err(dev, "wmi_set_block failed\n");
> +		dev_err(dev, "wmidev_block_set failed\n");
>  		return -ENODEV;
>  	}

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-265098238-1704711173=:1762--

