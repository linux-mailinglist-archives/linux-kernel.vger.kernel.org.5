Return-Path: <linux-kernel+bounces-5111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB838186AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63E91F221D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ACF1640B;
	Tue, 19 Dec 2023 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYrGD+0x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8718E2F;
	Tue, 19 Dec 2023 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702986662; x=1734522662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fnK/Y9O3xSfWK7qWy8ICoXoJrkOhv0lVOPade4CcLM0=;
  b=SYrGD+0xVyypsVgyB2oYVGeDUs0eUVB9sxrgWMiNGUTKH0W3tFjH7X7B
   cE2jsSeHFAQS0BuSi69g1LBDe54T0W4k6eD9WvCV1eHTZbvN1DiXqODVX
   7O40pngjA5LNowz33+45dYeWldxAlyXcS6ig4mxhILek7V3QWpLCpV1GJ
   2iXny+5bF8/4e+wg3cLT6EGJTE9T4mD7elh4BAW11yPmoeseE2RnKPgUy
   8qXQHl8PWQuoqpM1bT8CEs6r9qt3HrEDJr/2IAfG0YHi9ABr7L3QcWe+K
   Xdm8poUpsS0RDdQPyyVu7YwzRl71WD+6yXFWJcnWBDluGrIOV6oHUFArM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394524569"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="394524569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="779458621"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="779458621"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 19 Dec 2023 03:50:59 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 13:50:58 +0200
Date: Tue, 19 Dec 2023 13:50:58 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] usb: typec: tipd: add function to request firmware
Message-ID: <ZYGDoi9rBvMnE+MX@kuha.fi.intel.com>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <20231207-tps6598x_update-v2-2-f3cfcde6d890@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-tps6598x_update-v2-2-f3cfcde6d890@wolfvision.net>

On Thu, Dec 14, 2023 at 05:29:10PM +0100, Javier Carrasco wrote:
> The firmware request process is device agnostic and can be used for
> other parts.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index f0c4cd571a37..83e5eeecdf5c 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -873,6 +873,30 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  	return 0;
>  }
>  
> +static int tps_request_firmware(struct tps6598x *tps, const struct firmware **fw)
> +{
> +	const char *firmware_name;
> +	int ret;
> +
> +	ret = device_property_read_string(tps->dev, "firmware-name",
> +					  &firmware_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = request_firmware(fw, firmware_name, tps->dev);
> +	if (ret) {
> +		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
> +		return ret;
> +	}
> +
> +	if ((*fw)->size == 0) {
> +		release_firmware(*fw);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static int
>  tps25750_write_firmware(struct tps6598x *tps,
>  			u8 bpms_addr, const u8 *data, size_t len)
> @@ -961,16 +985,9 @@ static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
>  	if (ret)
>  		return ret;
>  
> -	ret = request_firmware(&fw, firmware_name, tps->dev);
> -	if (ret) {
> -		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
> +	ret = tps_request_firmware(tps, &fw);
> +	if (ret)
>  		return ret;
> -	}
> -
> -	if (fw->size == 0) {
> -		ret = -EINVAL;
> -		goto release_fw;
> -	}
>  
>  	ret = of_property_match_string(np, "reg-names", "patch-address");
>  	if (ret < 0) {
> 
> -- 
> 2.39.2

-- 
heikki

