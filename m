Return-Path: <linux-kernel+bounces-144621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD28A4874
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B82283658
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A623770C;
	Mon, 15 Apr 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hzl8hqKD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3636120;
	Mon, 15 Apr 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164077; cv=none; b=pu4JlxWQTPnqF8obO46nw4ogyqKrKIw4Azx+wITGhMDh5McInCHyzJLN0cN9qD9qo5Dgez3w5qQ9GCBpkArgRg/oqqZLJTrmHjzvyB++uX21Grj0Nwu52onbilK123SX1r1p8K/K2fqr+lDsDe2WKcjTu3RRamJ8dJfagBgWiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164077; c=relaxed/simple;
	bh=1Y2sqyZrrntGvfXZvrHfiyT9cNnPgD9csPzAwIM8Qys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XStI02//BvLIefDz63rKMonGP5MvRBslH88+mZ3TQF8wbFJa1L5RX24jxfN+0ZoPVK63Azi9NJ4+W4uyOrEtfBcOTQ5m1ukbHqN/Hh2wNAKCrgoHxv0Pu3pNmdefjweIe0r7uFddRPTXnZExNUQlcr1lzYr4rXmtqrhLwgg6G7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hzl8hqKD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713164076; x=1744700076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Y2sqyZrrntGvfXZvrHfiyT9cNnPgD9csPzAwIM8Qys=;
  b=Hzl8hqKDfoRgwwbK6vNj91YclB55QLeJN2s+CDtKjCWphDTTE+gcJ1eH
   qYhUl5JMqndsyQ/BINqywTAIZX7m3D9qSVFfUZsrELOxHAQUDYBTbmWNP
   X6MGYgU0yddUNOAgDFJgxlfLDUd/SpiUcwYDkwQZThCe/rdSYj7up+PCO
   +yEDjOM/cUk3nnPul+hGTgyO0VZZeuTwYUQ0ZSn+2OJlJahNZN8d3PfwK
   fTOXD3Zcktf7f4nIwBWep0ke+qhOtjCujDYeO9fYl+RqaE9dlu8sazI8z
   gugeVuLbj5Vd21c5HpB8KYOwI9tyD2qPk+bTjaDQHdZUSEQXtUn2Ex1Jh
   g==;
X-CSE-ConnectionGUID: 975K0nIBTNuK3UqxL5na6g==
X-CSE-MsgGUID: 1TwRMeTMSumos3QYlyVtxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12325250"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="12325250"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:54:36 -0700
X-CSE-ConnectionGUID: EV4WjzvsS5+bhwPFmeE6yA==
X-CSE-MsgGUID: n6ACCBpxRZqzpNFzZWZCUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22238581"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 14 Apr 2024 23:54:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Apr 2024 09:54:31 +0300
Date: Mon, 15 Apr 2024 09:54:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v1] usb: typec: mux: gpio-sbu: Allow GPIO operations to
 sleep
Message-ID: <ZhzPJ/q0xl7FsBiG@kuha.fi.intel.com>
References: <20240409190910.4707-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409190910.4707-1-francesco@dolcini.it>

On Tue, Apr 09, 2024 at 09:09:10PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Use gpiod_set_value_cansleep() to support gpiochips which can
> sleep like, e.g. I2C GPIO expanders.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/gpio-sbu-mux.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
> index ad60fd4e8431..374168482d36 100644
> --- a/drivers/usb/typec/mux/gpio-sbu-mux.c
> +++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
> @@ -48,10 +48,10 @@ static int gpio_sbu_switch_set(struct typec_switch_dev *sw,
>  	}
>  
>  	if (enabled != sbu_mux->enabled)
> -		gpiod_set_value(sbu_mux->enable_gpio, enabled);
> +		gpiod_set_value_cansleep(sbu_mux->enable_gpio, enabled);
>  
>  	if (swapped != sbu_mux->swapped)
> -		gpiod_set_value(sbu_mux->select_gpio, swapped);
> +		gpiod_set_value_cansleep(sbu_mux->select_gpio, swapped);
>  
>  	sbu_mux->enabled = enabled;
>  	sbu_mux->swapped = swapped;
> @@ -82,7 +82,7 @@ static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
>  		break;
>  	}
>  
> -	gpiod_set_value(sbu_mux->enable_gpio, sbu_mux->enabled);
> +	gpiod_set_value_cansleep(sbu_mux->enable_gpio, sbu_mux->enabled);
>  
>  	mutex_unlock(&sbu_mux->lock);
>  
> @@ -141,7 +141,7 @@ static void gpio_sbu_mux_remove(struct platform_device *pdev)
>  {
>  	struct gpio_sbu_mux *sbu_mux = platform_get_drvdata(pdev);
>  
> -	gpiod_set_value(sbu_mux->enable_gpio, 0);
> +	gpiod_set_value_cansleep(sbu_mux->enable_gpio, 0);
>  
>  	typec_mux_unregister(sbu_mux->mux);
>  	typec_switch_unregister(sbu_mux->sw);
> -- 
> 2.39.2

-- 
heikki

