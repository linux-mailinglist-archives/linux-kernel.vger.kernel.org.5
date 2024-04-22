Return-Path: <linux-kernel+bounces-152925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601F18AC635
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F422E1F22097
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7B4EB24;
	Mon, 22 Apr 2024 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGUeDph1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB84D599;
	Mon, 22 Apr 2024 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772863; cv=none; b=f973rpx4xwogA71uwS67t2c7vJ+TeuaTZ+p5RHgmjooPwvDrrmPfb7KSlhPVXp8HccAGHQtYv600apIRwkPt9hPMcfEE/pE4We/lUMIdm/pUVu1MG2py0jeM6ZmcKG/T6eiivfe0yYtoxdxIkuFJwi+kGURwtiga/5sTNLsgvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772863; c=relaxed/simple;
	bh=HZm0PzCHoSvuw+jWCOS/YJhNQfOMgrNyQH4jtQUZEGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRnsybDO/Qq+TlzSbxwSmLZP289M4r8YmMEBp71O9jLpxdoFI1MqA6raCHLKzZGxmUfFeASQ4Do/JChY4aPxvcgN5X5ZEQt2CFsD/qontBm97yscs8mSsw+R9SQIcNlLfX3noC2sKV2gj9/UUD5XtjxGzVKoet4wjIQrMPnNqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGUeDph1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713772858; x=1745308858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZm0PzCHoSvuw+jWCOS/YJhNQfOMgrNyQH4jtQUZEGY=;
  b=BGUeDph1U23QkQTBnaPkuNl0v+JccalubRxbMLvemuGe66GaeIxjzHRn
   ayfWRg3jP7nPHt6ce9wSx5lVVbn4RzE6l/2Sk9Eb45ZsTwgVAcMxQut0J
   W/Mu5RNrNgbyfz/se4VFJZzJdDf4k+OPNFgaII4Y6axHOORkK1kos+8d3
   ar+YqJZYuq1h+kr7ZSpSqvf7IrfUaNLV9WSfMr6Av6f8ZsPR71CezckfO
   HqOeCw2TshwQHtbdbmanl9dlhpRGRdoy0phRqaoob6MKQsHuqrY2GDSuS
   6TJ6IwjGJvVA07Pdw/6y/WrleOT+JiNBUaytp0HyVV2TqmV2t1RB9xysU
   w==;
X-CSE-ConnectionGUID: Iek+8aIYRPevaOy0fnQpkA==
X-CSE-MsgGUID: b2NVAAeXQXaxbSCHm32TRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="31788097"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="31788097"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 01:00:55 -0700
X-CSE-ConnectionGUID: DsdRjitWTfWEEQUVozNKig==
X-CSE-MsgGUID: o4noeIXIRUyz9okae8OMSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28711709"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa005.jf.intel.com with SMTP; 22 Apr 2024 01:00:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 11:00:50 +0300
Date: Mon, 22 Apr 2024 11:00:50 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/8] usb: typec: Handle retimers in typec_set_mode()
Message-ID: <ZiYZMoZ7OYID32jj@kuha.fi.intel.com>
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-1-890db00877ac@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-ucsi-glink-altmode-v1-1-890db00877ac@linaro.org>

On Tue, Apr 16, 2024 at 05:20:50AM +0300, Dmitry Baryshkov wrote:
> Make typec_set_mode() also handle retimers in addition to muxes. Setting
> the USB mode requires retimers to be configured in addition to just
> switching the mux configuration.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9610e647a8d4..28d395535bd1 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -2095,14 +2095,21 @@ EXPORT_SYMBOL_GPL(typec_get_orientation);
>   * @mode: Accessory Mode, USB Operation or Safe State
>   *
>   * Configure @port for Accessory Mode @mode. This function will configure the
> - * muxes needed for @mode.
> + * muxes and retimeres needed for @mode.
>   */
>  int typec_set_mode(struct typec_port *port, int mode)
>  {
> +	struct typec_retimer_state retimer_state = { };
>  	struct typec_mux_state state = { };
> +	int ret;
>  
> +	retimer_state.mode = mode;
>  	state.mode = mode;
>  
> +	ret = typec_retimer_set(port->retimer, &retimer_state);
> +	if (ret)
> +		return ret;
> +
>  	return typec_mux_set(port->mux, &state);
>  }
>  EXPORT_SYMBOL_GPL(typec_set_mode);
> 
> -- 
> 2.39.2

-- 
heikki

