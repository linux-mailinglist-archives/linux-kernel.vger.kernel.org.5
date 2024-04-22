Return-Path: <linux-kernel+bounces-153295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E18ACC23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC7228509C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869F146A93;
	Mon, 22 Apr 2024 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXc8L1p3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A531465A2;
	Mon, 22 Apr 2024 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785889; cv=none; b=u6KUQSqC40A+odhSSZ78zzVm37wccRNQ9a6JsHhhPDPhSgjZWSPuhDB/QXqtkb7kBedgNPHtbe2f8ay3S+4liA6TC/Fh7DtKvqpmpsD4OWk6cyJPV3GY8ZJw4af5UXCDMFTLWKtElqIgkiMtwTQAuxG0+Y9Aazxj4PAagotwla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785889; c=relaxed/simple;
	bh=EZYhNhz96eKHn2cEDh2N0ULGq94X/lfU2OLdeurzxwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWeT+zlf6jn+zvyoWR0eVZm41ZeAxIdfnkbPScvQ3/UQMRpdLUCSBQDex5zoWuSaCMOk/5skZB+dfejwaT/qMkbwzuX9d8vLLkEVKd0E6uzHGBpRhNLrJ7FeJAHTvdNCW6jhdK49mfrK2aZJTKDjhnKsOyKxwntWbFc4RyUWsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXc8L1p3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713785888; x=1745321888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EZYhNhz96eKHn2cEDh2N0ULGq94X/lfU2OLdeurzxwg=;
  b=PXc8L1p3IVK9Sv5JkLWWLNJOAO0vAiF4D/w+xLBLOW3AVOL3jwlAy6Zq
   +JqVdXG/2+VE+Kc9RMy47DowBviHOowT7blYSh+m9HTcGU20jZwxDT+p4
   ++0LMWcd3JvkwrlL/EunD90nGuDgEtDtEQay8qvSDzlhvRWWFcY6LFnyR
   Ge4Rusazspa0/Sa2Pe/PN0sQhM3p4jQ8m+M9PTUjjXIHqDtHGI5WNvdXs
   YQGo45wPRLgZn472YlO/WEMTOJOmHLeF8X+jI4V2naW+i+3ry4Th5Pr2Q
   eLLtnLTlFuT7zw8AstPtYJvhJz6P21+bScYpF58ELYZfEIYDLU+aPkqni
   A==;
X-CSE-ConnectionGUID: /OOzS0u8R5yg+EfiHBxVCQ==
X-CSE-MsgGUID: NjBFy074R+GTf63hAc8a0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="13093187"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="13093187"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:38:07 -0700
X-CSE-ConnectionGUID: AzfJOScRSk+rvG5OBKfSNg==
X-CSE-MsgGUID: T/dk9JejQBuZbswcv6UCQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28665225"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 22 Apr 2024 04:38:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 14:38:01 +0300
Date: Mon, 22 Apr 2024 14:38:01 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] usb: typec: Update sysfs when setting ops
Message-ID: <ZiZMGZxqKDpWUSqk@kuha.fi.intel.com>
References: <20240419211650.2657096-1-jthies@google.com>
 <20240419211650.2657096-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419211650.2657096-3-jthies@google.com>

On Fri, Apr 19, 2024 at 09:16:48PM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> When adding altmode ops, update the sysfs group so that visibility is
> also recalculated.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c |  2 +-
>  drivers/usb/typec/class.c                | 18 +++++++++++++++++-
>  drivers/usb/typec/ucsi/displayport.c     |  2 +-
>  include/linux/usb/typec.h                |  3 +++
>  4 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 596cd4806018b..92cc1b1361208 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -746,7 +746,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	dp->alt = alt;
>  
>  	alt->desc = "DisplayPort";
> -	alt->ops = &dp_altmode_ops;
> +	typec_altmode_set_ops(alt, &dp_altmode_ops);
>  
>  	if (plug) {
>  		plug->desc = "Displayport";
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9610e647a8d48..9262fcd4144f8 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -467,6 +467,22 @@ static const struct attribute_group *typec_altmode_groups[] = {
>  	NULL
>  };
>  
> +/**
> + * typec_altmode_set_ops - Set ops for altmode
> + * @adev: Handle to the alternate mode
> + * @ops: Ops for the alternate mode
> + *
> + * After setting ops, attribute visiblity needs to be refreshed if the alternate
> + * mode can be activated.
> + */
> +void typec_altmode_set_ops(struct typec_altmode *adev,
> +			   const struct typec_altmode_ops *ops)
> +{
> +	adev->ops = ops;
> +	sysfs_update_group(&adev->dev.kobj, &typec_altmode_group);
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_set_ops);
> +
>  static int altmode_id_get(struct device *dev)
>  {
>  	struct ida *ids;
> @@ -2317,7 +2333,7 @@ void typec_port_register_altmodes(struct typec_port *port,
>  			continue;
>  		}
>  
> -		alt->ops = ops;
> +		typec_altmode_set_ops(alt, ops);
>  		typec_altmode_set_drvdata(alt, drvdata);
>  		altmodes[index] = alt;
>  		index++;
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index d9d3c91125ca8..eb7b8d6e47d00 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -337,7 +337,7 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
>  	dp->con = con;
>  	dp->alt = alt;
>  
> -	alt->ops = &ucsi_displayport_ops;
> +	typec_altmode_set_ops(alt, &ucsi_displayport_ops);
>  	typec_altmode_set_drvdata(alt, dp);
>  
>  	return alt;
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index b35b427561ab5..549275f8ac1b3 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -167,6 +167,9 @@ struct typec_port *typec_altmode2port(struct typec_altmode *alt);
>  
>  void typec_altmode_update_active(struct typec_altmode *alt, bool active);
>  
> +void typec_altmode_set_ops(struct typec_altmode *alt,
> +			   const struct typec_altmode_ops *ops);
> +
>  enum typec_plug_index {
>  	TYPEC_PLUG_SOP_P,
>  	TYPEC_PLUG_SOP_PP,
> -- 
> 2.44.0.769.g3c40516874-goog

-- 
heikki

