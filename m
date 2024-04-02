Return-Path: <linux-kernel+bounces-128036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D45895542
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A876AB27E39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2D823DD;
	Tue,  2 Apr 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kG6vC4hx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700685260;
	Tue,  2 Apr 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064174; cv=none; b=DvXh9nNjhAI9upN/GvgYiswiwZvF3ij0GJ2dgEyrPpVl7OenJuiKzAnA/WqtYh2CJ6fWr5YiqW83aoUqx2rpuN+ENAFSC1gMkM7SWYvfvQykqdx0lt3OkBBJf0YMzVldIcAx3CjEyWQzaYQW7vxGeAVq/AclHp6Y+pNYKyY/QyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064174; c=relaxed/simple;
	bh=5B4VAqRtah3hwR9aUAuF7xCrOB8pdBZXUCtToZA8hZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcBTMi62iTGZkSYNjFxOOQdT1vxNw9eq6slNkOlU0AHLCtZ0DxsMkaEq8H0G2a32xe4S8MRJ7bxnsRaqAuX+Ly7K1c5iJ9xv76oZOBeOJG6dVS6iX+dgXeKtjEMC7/88x7fpuQ4XYhFJv5gZ6Tcg6bWtgYjtkjnXZp2zwx4SobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kG6vC4hx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712064173; x=1743600173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5B4VAqRtah3hwR9aUAuF7xCrOB8pdBZXUCtToZA8hZ4=;
  b=kG6vC4hxcKz0LZjhKa1X31X/fhur5kpBoGxshV+8ElZ9DpvJitFKcME+
   WTbebnhvzwBiKHv8SJr43ES5XYYPLhPLwY4pI5qOvUMDxoi0hAcGYkfmy
   GYuwIUQvycTlwSV9oR/nm9MKQhmC3lWKZON7nrazp+RDQwK0a6MP7fz+6
   /8euDZKHPWLMrXva5x75d86M+CzQKSVbOzqCjliZWm1EhrXGWFkC9cszz
   6OApT44GJe/CHklpc6pJj6K5HaIZTBdvleYZVGd0bcbJRncZs7T5y6qau
   MYz1N3Jbq3XnctrSnU1tZeR7soef7npDZsw2KQjTEEuwTkCWYjFt9YLSO
   w==;
X-CSE-ConnectionGUID: dnMNQZqzTqqyNUirhK/XRQ==
X-CSE-MsgGUID: 8eUayibbSui69kbWr2wQEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17960339"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17960339"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 06:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="915140889"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915140889"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 06:22:48 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rre6A-00000000oj8-0Wz8;
	Tue, 02 Apr 2024 16:22:46 +0300
Date: Tue, 2 Apr 2024 16:22:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v7 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <ZgwGpZ6S13vjk8jh@smile.fi.intel.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-4-3ea519d12cf7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-pinctrl-scmi-v7-4-3ea519d12cf7@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 10:22:24AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.

..

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>

Missing headers.

..

> +	*p_groups = (const char * const *)func->groups;

Is this casting needed?

..

> +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin, unsigned long *config)

Why underscored parameter name?

..

> +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> +				 struct pinctrl_desc *desc)
> +{
> +	struct pinctrl_pin_desc *pins;
> +	unsigned int npins;
> +	int ret, i;
> +
> +	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> +	/*
> +	 * npins will never be zero, the scmi pinctrl driver has bailed out
> +	 * if npins is zero.
> +	 */

This is fragile, but at least it is documented.

> +	pins = devm_kmalloc_array(pmx->dev, npins, sizeof(*pins), GFP_KERNEL);
> +	if (!pins)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < npins; i++) {
> +		pins[i].number = i;
> +		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
> +		if (ret)

How does the cleanup work for the previously assigned pin names? Is it needed?
Maybe a comment?

> +			return dev_err_probe(pmx->dev, ret,
> +					     "Can't get name for pin %d", i);
> +	}
> +
> +	desc->npins = npins;
> +	desc->pins = pins;
> +	dev_dbg(pmx->dev, "got pins %u", npins);
> +
> +	return 0;
> +}

..

> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);

Move this closer to the user.

-- 
With Best Regards,
Andy Shevchenko



