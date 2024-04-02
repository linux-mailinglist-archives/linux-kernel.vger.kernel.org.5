Return-Path: <linux-kernel+bounces-127730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F8C895015
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DE5285B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F75D72B;
	Tue,  2 Apr 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTWzZDq0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F75B698;
	Tue,  2 Apr 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053793; cv=none; b=OA7WgTfOSM47UDG+CwHkMWmZZHp9QeaMG13D1vXPk21XqLjfbkRQ9mCCymr27S/mOLGc6FhHc/9CRjw0z2lTkKhDN/aU67NHEeangfakE/AiYtC7GJkTjsN5gy66bAoCyy5dMks2B/TG6s7UWPZVh3zrExdyqK2uzdT8sGQKYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053793; c=relaxed/simple;
	bh=oIiOFD4tOsDcXxfhOViTyo9H+o3zw8XySy+NN8JBh9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJkLgmr7JQVFiSFqc4cDmNSl7Miq9DPhbwJu+eQP1hIkfmW3nNow3WmPY2V0ecj+Ev2V4MY+mVArrmc3SJS1lL9KheXqRO2bvIktxFPmpQ35DBuvOlWylMdCGKekWs054QZVF2tPSFaTfzHZ/AgKdiRfwNj8fMkzYPerZOJ3/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTWzZDq0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712053792; x=1743589792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oIiOFD4tOsDcXxfhOViTyo9H+o3zw8XySy+NN8JBh9U=;
  b=kTWzZDq0K3SCWX9z9jt950SpCDLE/j36PRJkZncfuXzZhOwyPOuRQEUQ
   3PJYNAcoyiHZqORB5MAymM0RFrMIZkAfLsTsoxJcexmveh+VVQzceoNXi
   qCT4kHn4FcFJAqn/apD1wluUDG1KdoP891SHdmpINECFpcE949KUjg9lR
   udHM9Y5QJChGQ9kStExh04jlvUYchIwzmzY647CUyJlOKG4twCvADCXx/
   9e/O5OFDlRCrgAKGOQTL22kU4iw8VUofduIx5luzRH23yHKAU20vUaZW0
   /bmzIAmHfw7GkhG1DwVsdjNb7RcHwM2kUSXoTkZUso+iht33rmu1JhbOt
   w==;
X-CSE-ConnectionGUID: DP+Xt5nZRR6pcas6Wz3r5A==
X-CSE-MsgGUID: DBVrAvh+QruDidARgCZNZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7085043"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7085043"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="937083293"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="937083293"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Apr 2024 03:29:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Apr 2024 13:29:47 +0300
Date: Tue, 2 Apr 2024 13:29:47 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] usb: typec: tipd: fix event checking for
 tps6598x
Message-ID: <ZgveG5Ly3mw0O0eo@kuha.fi.intel.com>
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
 <20240328-tps6598x_fix_event_handling-v1-2-502721ff705b@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-2-502721ff705b@wolfvision.net>

On Thu, Mar 28, 2024 at 05:55:52PM +0100, Javier Carrasco wrote:
> The current interrupt service routine of the tps6598x only reads the
> first 64 bits of the INT_EVENT1 and INT_EVENT2 registers, which means
> that any event above that range will be ignored, leaving interrupts
> unattended. Moreover, those events will not be cleared, and the device
> will keep the interrupt enabled.
> 
> This issue has been observed while attempting to load patches, and the
> 'ReadyForPatch' field (bit 81) of INT_EVENT1 was set.
> 
> Read the complete INT_EVENT registers to handle all interrupts generated
> by the device in a similar fashion to what is already done for the
> tps25750.
> 
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/typec/tipd/core.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 7c2f01344860..308748d6cae6 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -637,48 +637,53 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> -	u64 event1 = 0;
> -	u64 event2 = 0;
> +	u64 event1[2] = { };
> +	u64 event2[2] = { };
>  	u32 status;
>  	int ret;
>  
>  	mutex_lock(&tps->lock);
>  
> -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
> -	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
> +	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, 11);

This is not going to work with the older TI PD controllers.

The lenght of these registers is 8 bytes on the older TI PD
controllers (TPS65981, TPS65982, etc.). I think we need to split this
function.

>  	if (ret) {
> -		dev_err(tps->dev, "%s: failed to read events\n", __func__);
> +		dev_err(tps->dev, "%s: failed to read event1\n", __func__);
>  		goto err_unlock;
>  	}
> -	trace_tps6598x_irq(event1, event2);
> +	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT2, event2, 11);
> +	if (ret) {
> +		dev_err(tps->dev, "%s: failed to read event2\n", __func__);
> +		goto err_unlock;
> +	}
> +	trace_tps6598x_irq(event1[0], event2[0]);
>  
> -	if (!(event1 | event2))
> +	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
>  		goto err_unlock;
>  
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
>  
> -	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
> +	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
>  
> -	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
> +	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
>  		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
>  
>  	/* Handle plug insert or removal */
> -	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
> +	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
>  		tps6598x_handle_plug_event(tps, status);
>  
>  err_clear_ints:
> -	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
> -	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
> +	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, 11);
> +	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, 11);
>  
>  err_unlock:
>  	mutex_unlock(&tps->lock);
>  
> -	if (event1 | event2)
> +	if (event1[0] | event1[1] | event2[0] | event2[1])
>  		return IRQ_HANDLED;
> +
>  	return IRQ_NONE;
>  }
>  
> 
> -- 
> 2.40.1

-- 
heikki

