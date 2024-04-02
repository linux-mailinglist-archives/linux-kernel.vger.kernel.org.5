Return-Path: <linux-kernel+bounces-127723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C6C894FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8FD1C22876
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A925D903;
	Tue,  2 Apr 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jobmb5+9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAD5C5EE;
	Tue,  2 Apr 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053310; cv=none; b=cxTVYtA5A6CLQigKzsKdgWAigHKqVh5F3c2ui5TYFo4mGilYzdX4LPpwV/guHWnKAikJxR4cxHAUdEkFFUkTVP74w9+6Je/5xfOLOTr5lPX/5Lx4FyrAU7UCTMdXxvO6lvmIzQ4LuyafHraa66m4uCIsGEl7jT5SKQLa8yyVcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053310; c=relaxed/simple;
	bh=R64qvJFQe7WjxMIBnfkL6Bca9ch6pQNP37f/bnFA2+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uALxL+45/zCVXuAHv5GMEn8rkRlu36HtIiIn+JUElGstqFFiq8ERWRqgNzxIz3yoJer4gL31jlQWCoyr1sZdhmy4HIVPSSO5h6gqgEMqJZuic2HhgTuO0HNbts89LD+RE8nfNDwzuNO8y3nSv/HvJOSpr6oqK9ta9U0yPx5OB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jobmb5+9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712053310; x=1743589310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R64qvJFQe7WjxMIBnfkL6Bca9ch6pQNP37f/bnFA2+s=;
  b=Jobmb5+9LHtX3qbtqOXAOxOiHNH0iihpkCp+HceJ3iCqInjs/9Q1k+80
   qhuioOK8e36ZRwbCo+EY5gpFtcAPtZkFye4LmuQk/pCq7vkyM+ux6d3jY
   5UUy1XFjRITT2L3EL673sLFkIw69tKlcTn62JBZ7V0q0ISq8rYxXmYrR6
   3lbUuzysesTiThNxGJ4nWlXynrAZ3z39zMWuZ2z7wTo0Vpd70NGhdXky4
   hNEgkrVJhHEr9RdxJXZrUnnj7UvPESgjtNQmY7Rpb5t0phHTPKRqFjqIj
   ypM2GvFhVasRJs4IHPY7wURpf1c26iGk31B4W+5078nkR7LAhfMU8tc0t
   g==;
X-CSE-ConnectionGUID: H8XOdFSmQMus4b2X/F3mRA==
X-CSE-MsgGUID: bVqCvmRER1WliMBxk0U+sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24671017"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="24671017"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="937083290"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="937083290"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Apr 2024 03:21:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Apr 2024 13:21:45 +0300
Date: Tue, 2 Apr 2024 13:21:45 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] usb: typec: tipd: fix event checking for
 tps25750
Message-ID: <ZgvcOXtK15ggpKRE@kuha.fi.intel.com>
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
 <20240328-tps6598x_fix_event_handling-v1-1-502721ff705b@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-1-502721ff705b@wolfvision.net>

On Thu, Mar 28, 2024 at 05:55:51PM +0100, Javier Carrasco wrote:
> In its current form, the interrupt service routine of the tps25750
> checks the event flags in the lowest 64 bits of the interrupt event
> register (event[0]), but also in the upper part (event[1]).
> 
> Given that all flags are defined as BIT() or BIT_ULL(), they are
> restricted to the first 64 bits of the INT_EVENT1 register. Including
> the upper part of the register can lead to false positives e.g. if the
> event 64 bits above the one being checked is set, but the one being
> checked is not.
> 
> Restrict the flag checking to the first 64 bits of the INT_EVENT1
> register.
> 
> Fixes: 7e7a3c815d22 ("USB: typec: tps6598x: Add TPS25750 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 0717cfcd9f8c..7c2f01344860 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -604,11 +604,11 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
>  
> -	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
> +	if (event[0] & TPS_REG_INT_POWER_STATUS_UPDATE)
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_clear_ints;
>  
> -	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
> +	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
>  		if (!tps6598x_read_data_status(tps))
>  			goto err_clear_ints;
>  
> @@ -617,7 +617,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>  	 * a plug event. Therefore, we need to check
>  	 * for pr/dr status change to set TypeC dr/pr accordingly.
>  	 */
> -	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
> +	if (event[0] & TPS_REG_INT_PLUG_EVENT ||
>  	    tps6598x_has_role_changed(tps, status))
>  		tps6598x_handle_plug_event(tps, status);
>  
> 
> -- 
> 2.40.1

-- 
heikki

