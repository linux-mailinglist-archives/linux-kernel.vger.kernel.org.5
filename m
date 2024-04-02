Return-Path: <linux-kernel+bounces-128022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458589550C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850731F253B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02F860279;
	Tue,  2 Apr 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNvqjAaL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E177F7D3;
	Tue,  2 Apr 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063680; cv=none; b=eeb1zP6iV6oQobFm/w2/g2toUxGubF0MMn5Jn7HxGE0oumjw2Y5b8KrX/joOlDPFDR0a/aRfI4zLr/rWacu0j96trq2hnetjZgLf8osA6KtBZdoqTl2esYRLItTi3igyyqWRG6ZkMwnft45itqkJGtxqRm01NNEopkTzAKeXUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063680; c=relaxed/simple;
	bh=dNhWs1tSERBEqpT1H1jI1gPA9tR9hFX3rMeei4wKg3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I134HRyrxsSzAy1HGBhTJfHT50fAtJzSYqdzO4v1QonQf1AONYVbrxQRtnf9rzI+vITmzwmlN2hVdWoldxGxCLVs6nNN44+CgclIf3MnWcAqMOK/voc+LfW307o9L4ZqMTc8Tym1dasHZQx5Vdr7ZiZXzUuFdGcHC/FEyDJM+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNvqjAaL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712063678; x=1743599678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNhWs1tSERBEqpT1H1jI1gPA9tR9hFX3rMeei4wKg3I=;
  b=hNvqjAaLYDpyPnV29zeS0RCRihuhJ4+iuBXIlRjln1/7L1Izt20oRT1x
   zfS4hQKklR4w/eDqQvPZUG2y1az0nFdk18TpPbo1ChFVNkGfwUcZWj+KJ
   FjMuGFNZbOomFEd48FHGJW1kahivd7doYoLiNqs98mHBHYqKH3W1QVtTT
   5UwWv4WkHQF+F3sqStjAA6v3WAH3auvVwptU5ew672nISWbe7wMsHyYzE
   WhdoNAMw2nMljMZnbKIYeT2TtqNg88BU9tMslcEgEMAC0i2dwsMUYiVkw
   2RJxsizkVIdALxc9l7jVrSlzZLUWykfI3UOixapWmu1yEDi+V0muR+gcO
   g==;
X-CSE-ConnectionGUID: 5FvuF+rFR/Wd59lPMsobUg==
X-CSE-MsgGUID: S5p3n9rESEi3PJiQadbSug==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="32630976"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="32630976"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 06:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="915140683"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915140683"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 06:14:33 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrdyB-00000000oc0-1Wc3;
	Tue, 02 Apr 2024 16:14:31 +0300
Date: Tue, 2 Apr 2024 16:14:31 +0300
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
Subject: Re: [PATCH v7 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZgwEtxj-qi6uy_m2@smile.fi.intel.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-3-3ea519d12cf7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-pinctrl-scmi-v7-3-3ea519d12cf7@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 10:22:23AM +0800, Peng Fan (OSS) wrote:

..

> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>

Please, follow IWYU principle, a lot of headers are missed.

> +#include "common.h"
> +#include "protocols.h"

..

> +		ret = scmi_pinctrl_get_pin_info(ph, selector,
> +						&pi->pins[selector]);

It's netter as a single line.

> +		if (ret)
> +			return ret;
> +	}

..

> +static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	int ret;
> +	u32 version;
> +	struct scmi_pinctrl_info *pinfo;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
> +		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> +	if (!pinfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_pinctrl_attributes_get(ph, pinfo);
> +	if (ret)
> +		return ret;
> +
> +	pinfo->pins = devm_kcalloc(ph->dev, pinfo->nr_pins,
> +				   sizeof(*pinfo->pins), GFP_KERNEL);
> +	if (!pinfo->pins)
> +		return -ENOMEM;
> +
> +	pinfo->groups = devm_kcalloc(ph->dev, pinfo->nr_groups,
> +				     sizeof(*pinfo->groups), GFP_KERNEL);
> +	if (!pinfo->groups)
> +		return -ENOMEM;
> +
> +	pinfo->functions = devm_kcalloc(ph->dev, pinfo->nr_functions,
> +					sizeof(*pinfo->functions), GFP_KERNEL);
> +	if (!pinfo->functions)
> +		return -ENOMEM;
> +
> +	pinfo->version = version;
> +
> +	return ph->set_priv(ph, pinfo, version);

Same comments as per previous version. devm_ here is simply wrong.
It breaks the order of freeing resources.

I.o.w. I see *no guarantee* that these init-deinit functions will be properly
called from the respective probe-remove. Moreover the latter one may also have
its own devm allocations (which are rightfully placed) and you get completely
out of control the resource management.

> +}

-- 
With Best Regards,
Andy Shevchenko



