Return-Path: <linux-kernel+bounces-144631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E88A4897
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BFD1F23187
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DCE22612;
	Mon, 15 Apr 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZ3dPOn8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A72110F;
	Mon, 15 Apr 2024 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164393; cv=none; b=LmBIaBrtb5qZB9GFMUuNQQI6NNTRx4C2a2pz9P08T3QAjwqcZAVxH0pmVB9PAmIk7XOiMNGkQmc8O+Y5Z07Ue4Bvesy94fRKQl1Ke3svIlJBgy1CBUZmF1E5mPJNaneH0vCpvQVlQDUr3YEa1HM64FOa5i3I0PnCam8bZGytjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164393; c=relaxed/simple;
	bh=NCSWcMl4FzUtoQv8kYSRpYLCpVxJwO5V4c/PIkM/H5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZcIYd+HjrxyNlSAPF9v0kvsI7B9Onhcm251Akt6jbvLhVEFD8v9kiQvocw4qZ4DzSi7i3b/MhnrQSCn2WcivzpzCktSaSAIbC2bCOBq6XzJYtAwReKT5VIPltHOtQbSc7CCXoFd/1W1KR4eNwMK3WGFEYQfyjQjsVxcA/xJW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZ3dPOn8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713164393; x=1744700393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NCSWcMl4FzUtoQv8kYSRpYLCpVxJwO5V4c/PIkM/H5k=;
  b=CZ3dPOn801zp3asqSZPD0QliT6LxgysBo053Eba/TXZGAv8M8xG4/Uy7
   qS6+FQYv4RbSaqOgwFzMrw3RJ5gq1elCPryxT0HclCqeNKULXLRNk9Nao
   gDfT7/uolfN4GmCNvY7WebaIBuR5a0qR6NAgV6bncxyr6jYArfjsfGvnB
   AzLfxB2T+WiqPJ6k7PFweKnk2iG7EdSmLG8h1jEAWbr0+Y1bTPno8lBdf
   aC2it3pTwbaNUzgLIylmghQJRln893ByYC9+I1vVJoo+UztKT21NhyKNa
   3d/TNoqAP43NtsbQlXSVSEQ/2N6QfCifti6ACJCRNM3pVDNACnQAKZprh
   w==;
X-CSE-ConnectionGUID: F04C7IPkSxavgxRBgKa4/Q==
X-CSE-MsgGUID: wpE2wiE7T/2hlPC0a/HZiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8452886"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8452886"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:59:52 -0700
X-CSE-ConnectionGUID: V4v7JBRyT1+Xo7mAANy6uw==
X-CSE-MsgGUID: JfdIo8QCSzyoMJ30W1Gyrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22292475"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa007.jf.intel.com with SMTP; 14 Apr 2024 23:59:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Apr 2024 09:59:48 +0300
Date: Mon, 15 Apr 2024 09:59:48 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] usb: typec: ucsi: glink: use typec_set_orientation
Message-ID: <ZhzQZB3zxyTlwGad@kuha.fi.intel.com>
References: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
 <20240411-ucsi-orient-aware-v2-3-d4b1cb22a33f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-ucsi-orient-aware-v2-3-d4b1cb22a33f@linaro.org>

On Thu, Apr 11, 2024 at 07:49:55AM +0300, Dmitry Baryshkov wrote:
> Use typec_set_orientation() instead of calling typec_switch_set()
> manually. This way the rest of the typec framework and the userspace are
> notified about the orientation change.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index d21f8cd2fe35..d279e2cf9bba 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -58,7 +58,6 @@ struct pmic_glink_ucsi {
>  	struct device *dev;
>  
>  	struct gpio_desc *port_orientation[PMIC_GLINK_MAX_PORTS];
> -	struct typec_switch *port_switch[PMIC_GLINK_MAX_PORTS];
>  
>  	struct pmic_glink_client *client;
>  
> @@ -198,9 +197,10 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
>  
>  	orientation = gpiod_get_value(ucsi->port_orientation[con->num - 1]);
>  	if (orientation >= 0) {
> -		typec_switch_set(ucsi->port_switch[con->num - 1],
> -				 orientation ? TYPEC_ORIENTATION_REVERSE
> -				 : TYPEC_ORIENTATION_NORMAL);
> +		typec_set_orientation(con->port,
> +				      orientation ?
> +				      TYPEC_ORIENTATION_REVERSE :
> +				      TYPEC_ORIENTATION_NORMAL);
>  	}
>  }
>  
> @@ -378,11 +378,6 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  			return dev_err_probe(dev, PTR_ERR(desc),
>  					     "unable to acquire orientation gpio\n");
>  		ucsi->port_orientation[port] = desc;
> -
> -		ucsi->port_switch[port] = fwnode_typec_switch_get(fwnode);
> -		if (IS_ERR(ucsi->port_switch[port]))
> -			return dev_err_probe(dev, PTR_ERR(ucsi->port_switch[port]),
> -					"failed to acquire orientation-switch\n");
>  	}
>  
>  	ucsi->client = devm_pmic_glink_register_client(dev,
> 
> -- 
> 2.39.2

-- 
heikki

