Return-Path: <linux-kernel+bounces-3523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB9816D54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1297B22BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A33A200A7;
	Mon, 18 Dec 2023 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lf5Z7wsw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06031B27E;
	Mon, 18 Dec 2023 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702901140; x=1734437140;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zK0zifIjrsVfWQ7CRvZNOs/vbcIQjEXf2KxOVkZ+KlM=;
  b=Lf5Z7wswMUFBnbQ9KZy+BKM5R0IBRskdmvyArrAiXh8DgisA17EW16X2
   viHpg0SqI/846jWr4d+24Xt4nxLZWnJOGhEajvzVfhImGLKrQ3fo12UqS
   OWA/7pcTsvIb6QaGen5/vng1CgjJN13tKctSkH5rM9pu/kAyiNm7jceCZ
   52ajqHLrl6potCQnfOp08n5/nnj2fkhxjUAktdcyCMoqmw0GKLqzWr1MF
   NSbHdpdigQmdq0+gNNYf4HSG4gnfsVgqiSuDBcb4AAA3bSMy1cEZ0XOjL
   e0TwALeC/LpPmHLY/HDIVrYvg/vxDTYd1f9ybPiCIKCv/IS/roq8BwMUy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2323920"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="2323920"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 04:05:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="751718827"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="751718827"
Received: from gmarin-mobl1.ger.corp.intel.com ([10.252.34.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 04:05:32 -0800
Date: Mon, 18 Dec 2023 14:05:30 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] platform/x86: wmi: Remove unused variable in address
 space handler
In-Reply-To: <20231216015601.395118-2-W_Armin@gmx.de>
Message-ID: <b0c2cabb-873d-8858-5175-9d60dddca639@linux.intel.com>
References: <20231216015601.395118-1-W_Armin@gmx.de> <20231216015601.395118-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-670412325-1702901134=:2348"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-670412325-1702901134=:2348
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 16 Dec 2023, Armin Wolf wrote:

> The variable "i" is always zero and only used in shift operations.
> Remove it to make the code more readable.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 7303702290e5..906d3a2831ae 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1144,7 +1144,7 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  			  u32 bits, u64 *value,
>  			  void *handler_context, void *region_context)
>  {
> -	int result = 0, i = 0;
> +	int result = 0;
>  	u8 temp = 0;
> 
>  	if ((address > 0xFF) || !value)
> @@ -1158,9 +1158,9 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
> 
>  	if (function == ACPI_READ) {
>  		result = ec_read(address, &temp);
> -		(*value) |= ((u64)temp) << i;
> +		*value = temp;
>  	} else {
> -		temp = 0xff & ((*value) >> i);
> +		temp = 0xff & *value;
>  		result = ec_write(address, temp);
>  	}

Seems to have been like this already when it got introduced...

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-670412325-1702901134=:2348--

