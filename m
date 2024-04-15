Return-Path: <linux-kernel+bounces-144625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7B8A4880
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7E6281495
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1E20317;
	Mon, 15 Apr 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhHWN/fS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A522339;
	Mon, 15 Apr 2024 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164267; cv=none; b=i43o8jlnNuPgxa1b52DrrtJ+9VA5HcGQZJL8OiPh883cXRGnHyjrEgMOgT85aEZNR0b1+mDlACExFswAIW6M2FZvSGQd1MBjUWlbA3TWsDbIFILHCSmaVGD/xNxXZpTCjZNrQdIjg3HRTNG1LtlVFhpXoxiicN3GZv6MSc63hgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164267; c=relaxed/simple;
	bh=l/5ikTUlCuGMYa+EP5RPrvI2YkQPp2fXN7lr6jPgAes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVdy3o+V/OG3Et/Gv/biAjDBv/KeyUcJgmP0BWsu3h4wqxHq4FRu0Hs88fA3+Il7WoswxmUwgMpmnM5o36rkKN86jC+Rh1CU3RMqcWktWcVPIsrA5xSu3Ji1UOeEtXmTMCy+MdsNw17mfeKa9L6Hxj62+4xqNN3UKz3U1ErNAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhHWN/fS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713164265; x=1744700265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l/5ikTUlCuGMYa+EP5RPrvI2YkQPp2fXN7lr6jPgAes=;
  b=UhHWN/fS1Wph3+xF/dRu1LuXvYZTpmla2p+4YGsjIM9q10WWu/Vlb1MT
   LlqtyLoQDO3fMt4CoMa2oe0g7b9oxbCnkfZfBT2kWT8Nz2htm+FvmWS8x
   UGCmyHhoWrbZj13SEX7AYDMkwNumBjJ2rxD3y+qgy41gI7Vlg9TqUvL3i
   8X05fsFe4ckPk04kQW/iZbNnrb0XJFzhnr8D0MXFAExOIps2MfJGbtPbb
   MXQ4WQ2X12+dFkubcPBlH2QqqV/JiIcfQqkbyJkVpFGOyOiGShXMMkoUm
   Ug+IYkRLNFcfwqPgti9JVF3N+WE9EiAU7QgS/46s8pnkAq5ybp6acFCEu
   w==;
X-CSE-ConnectionGUID: WkqBpKeSQb2kDd1salqHVw==
X-CSE-MsgGUID: ae+opybOTBenKN77ZgUrAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12314998"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="12314998"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:57:45 -0700
X-CSE-ConnectionGUID: X+lfE9tNT46Ge5WTo6sBHw==
X-CSE-MsgGUID: NUC9EHOjQ2GzK59pRUztmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21910448"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa007.fm.intel.com with SMTP; 14 Apr 2024 23:57:42 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Apr 2024 09:57:41 +0300
Date: Mon, 15 Apr 2024 09:57:41 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] usb: typec: ucsi: add callback for connector
 status updates
Message-ID: <ZhzP5bQe6zw1jmlu@kuha.fi.intel.com>
References: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
 <20240411-ucsi-orient-aware-v2-1-d4b1cb22a33f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-ucsi-orient-aware-v2-1-d4b1cb22a33f@linaro.org>

On Thu, Apr 11, 2024 at 07:49:53AM +0300, Dmitry Baryshkov wrote:
> Allow UCSI glue driver to perform addtional work to update connector
> status. For example, it might check the cable orientation.  This call is
> performed after reading new connector statatus, so the platform driver
> can peek at new connection status bits.
> 
> The callback is called both when registering the port and when the
> connector change event is being handled.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 6 ++++++
>  drivers/usb/typec/ucsi/ucsi.h | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 3106e69050cd..7ad544c968e4 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1199,6 +1199,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  
>  	trace_ucsi_connector_change(con->num, &con->status);
>  
> +	if (ucsi->ops->connector_status)
> +		ucsi->ops->connector_status(con);
> +
>  	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
>  
>  	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
> @@ -1588,6 +1591,9 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  	}
>  	ret = 0; /* ucsi_send_command() returns length on success */
>  
> +	if (ucsi->ops->connector_status)
> +		ucsi->ops->connector_status(con);
> +
>  	switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
>  	case UCSI_CONSTAT_PARTNER_TYPE_UFP:
>  	case UCSI_CONSTAT_PARTNER_TYPE_CABLE_AND_UFP:
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 2caf2969668c..3e1241e38f3c 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -16,6 +16,7 @@
>  
>  struct ucsi;
>  struct ucsi_altmode;
> +struct ucsi_connector;
>  struct dentry;
>  
>  /* UCSI offsets (Bytes) */
> @@ -59,6 +60,7 @@ struct dentry;
>   * @sync_write: Blocking write operation
>   * @async_write: Non-blocking write operation
>   * @update_altmodes: Squashes duplicate DP altmodes
> + * @connector_status: Updates connector status, called holding connector lock
>   *
>   * Read and write routines for UCSI interface. @sync_write must wait for the
>   * Command Completion Event from the PPM before returning, and @async_write must
> @@ -73,6 +75,7 @@ struct ucsi_operations {
>  			   const void *val, size_t val_len);
>  	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
>  				struct ucsi_altmode *updated);
> +	void (*connector_status)(struct ucsi_connector *con);
>  };
>  
>  struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops);
> 
> -- 
> 2.39.2

-- 
heikki

