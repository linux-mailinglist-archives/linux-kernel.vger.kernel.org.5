Return-Path: <linux-kernel+bounces-88902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6386E82B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE41F1C24896
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2A3C46B;
	Fri,  1 Mar 2024 18:18:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC823BB4E;
	Fri,  1 Mar 2024 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317127; cv=none; b=hfQvhmSVvTIuW2a5ZWgUdG1ajjuHywuYj9bp8gMlyZf1Ceb31akImaGNqVZe6dIi0s9ImOmHt8vDbm3S1pZS5M85bZl7FAd78rTH0RsPapk2I8KJvfGeRdJAROrcp9PKVSwg4Xb6hZ2e29sCZlejshTRcYoXNcZCZAZrgGAn7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317127; c=relaxed/simple;
	bh=q/ftgULoZU14gjYyOUW8zk8XyZYRKnHrhnJsjauO4KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnH55WU1GteO1+2xrhkc3RhWSsFi+wVcUChit9jVfILIPPWH0iv8wIOefutlhugMRWkNJrY1kNT7sIsmsbzi/ilplrrN1HTFzLbAmAsPQgwjm3qCaey6IS+bLoADV2dvGS8rcYZwlHLNGlHrBPK9115cN7CnDBEqwYfIQmFk/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14571913"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14571913"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914022095"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914022095"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:18:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rg7Sw-000000091jN-07sS;
	Fri, 01 Mar 2024 20:18:38 +0200
Date: Fri, 1 Mar 2024 20:18:37 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: geert@linux-m68k.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, pavel@ucw.cz, lee@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] auxdisplay: Add 7-segment LED display driver
Message-ID: <ZeIb_TaKK1DE6l6U@smile.fi.intel.com>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301014203.2033844-2-chris.packham@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 02:42:00PM +1300, Chris Packham wrote:
> Add a driver for a 7-segment LED display. At the moment only one
> character is supported but it should be possible to expand this to
> support more characters and/or 14-segment displays in the future.

..

> + * Driver for a 7 segment LED display

7-segment

..

> + * The GPIOs are wired to the 7 segments in a clockwise fashion starting from
> + * the top.

Not exactly. They can wire them as they wish, we just need to agree on the
sequence of the segments in DT to be mapped to the 7-segment diagram.

..

> + *      -a-
> + *     |   |
> + *     f   b
> + *     |   |
> + *      -g-
> + *     |   |
> + *     e   c
> + *     |   |
> + *      -d-

I would drop this as it's available in UAPI header...

..

> +#include <linux/bitmap.h>
> +#include <linux/container_of.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>

..which you forgot to include here.

..

> +static void seg_led_update(struct work_struct *work)
> +{
> +	struct seg_led_priv *priv = container_of(work, struct seg_led_priv, work.work);
> +	struct linedisp *linedisp = &priv->linedisp;
> +	struct linedisp_map *map = linedisp->map;
> +	DECLARE_BITMAP(values, 8);

> +	bitmap_zero(values, 8);

Why do you need this zeroing?

> +	bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->buf[0]), 0);
> +
> +	gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv->segment_gpios->desc,
> +				       priv->segment_gpios->info, values);
> +}

-- 
With Best Regards,
Andy Shevchenko



