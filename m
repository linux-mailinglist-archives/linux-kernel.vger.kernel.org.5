Return-Path: <linux-kernel+bounces-144632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF6A8A489D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104031F23261
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E95208CE;
	Mon, 15 Apr 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRqh85a6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE21EEE0;
	Mon, 15 Apr 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164623; cv=none; b=SRnzKovXGZQzvZCTulISWDaHGgRmEIIAOHlKeCGr7rQAA2Zzcq4eRBcm/3lJ6MipAEH5NRn7feyFDIcSyb8n1wcxuQYR4Tkxw1psW8FGTNZZY7boFTkt1IaWEWl0X9qNO77qk+kmlPcOoMhHuMsGl3jMP6Hrsp7VvZv9yJihwvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164623; c=relaxed/simple;
	bh=KC35dCKpRK62iLfVMAKtkgEhq5jZFRZj3hQ5vv+ZEnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrgNHNde+XM2ieSYfhWxafNGZK1enphEPmsw2URHqeMvNBJvRoyjgVfXiAt1u1wQqSq9Z4+r5yf4VE5h71B0SGn/q6SGgEy4ww+JJF4mg8d4YsPTYTixJDYNWPk0+M3G/ili3aK3hGk8ynr2SREiZE94s3smsw2g7BHk9uY3Vg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRqh85a6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713164618; x=1744700618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KC35dCKpRK62iLfVMAKtkgEhq5jZFRZj3hQ5vv+ZEnA=;
  b=HRqh85a6NmXEJDfPm+q34h/VNrSxm5/cU6iYyLXS0H14+GktftPT5d3j
   drwuBpxiV8W1PkGjw7+9aITGxOAWey6h6RkYrJqlx7DbjL25QZfvXJYrJ
   rHyFueR4dl4brI72VdcMH5BHVu69aHhWRZ36OK7X4ns0CA+1pKhiZFxRm
   NDwAA4j8b2rU9WME+ADzdFw0WOIT5UnLFZv3ht+h1HY/o0CCsvHUJByW7
   a/+KxstPTKllFHRB45woNcWvI8xTGDnrLO2+ZP4rHSV/eE6rxvpFy5xlD
   AA89Uagc8pzPor83Fq3kqFc69mQrQ6U+9HxkdyVV+Wq4cf3mi0f42RaoO
   w==;
X-CSE-ConnectionGUID: o5FqpNTESH+IB0xMfWq2AA==
X-CSE-MsgGUID: kgciskv5Tbil6rwMIIhz5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8756701"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8756701"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:03:37 -0700
X-CSE-ConnectionGUID: djRIw1aXRlGtMm58iYC+eg==
X-CSE-MsgGUID: AHrMH6nETnOo7RKOav5w0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22240866"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 15 Apr 2024 00:03:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Apr 2024 10:03:34 +0300
Date: Mon, 15 Apr 2024 10:03:34 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] usb: typec: ucsi: add update_connector callback
Message-ID: <ZhzRRhjWhyjR07Tg@kuha.fi.intel.com>
References: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
 <20240411-ucsi-orient-aware-v2-4-d4b1cb22a33f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-ucsi-orient-aware-v2-4-d4b1cb22a33f@linaro.org>

On Thu, Apr 11, 2024 at 07:49:56AM +0300, Dmitry Baryshkov wrote:
> Add a callback to allow glue drivers to update the connector before
> registering corresponding power supply and Type-C port. In particular
> this is useful if glue drivers want to touch the connector's Type-C
> capabilities structure.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 +++
>  drivers/usb/typec/ucsi/ucsi.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 7ad544c968e4..57e73b823a4c 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1559,6 +1559,9 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  	cap->driver_data = con;
>  	cap->ops = &ucsi_ops;
>  
> +	if (ucsi->ops->update_connector)
> +		ucsi->ops->update_connector(con);
> +
>  	ret = ucsi_register_port_psy(con);
>  	if (ret)
>  		goto out;
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 3e1241e38f3c..c4d103db9d0f 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -60,6 +60,7 @@ struct dentry;
>   * @sync_write: Blocking write operation
>   * @async_write: Non-blocking write operation
>   * @update_altmodes: Squashes duplicate DP altmodes
> + * @update_connector: Update connector capabilities before registering
>   * @connector_status: Updates connector status, called holding connector lock
>   *
>   * Read and write routines for UCSI interface. @sync_write must wait for the
> @@ -75,6 +76,7 @@ struct ucsi_operations {
>  			   const void *val, size_t val_len);
>  	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
>  				struct ucsi_altmode *updated);
> +	void (*update_connector)(struct ucsi_connector *con);
>  	void (*connector_status)(struct ucsi_connector *con);
>  };
>  
> 
> -- 
> 2.39.2

-- 
heikki

