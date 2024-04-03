Return-Path: <linux-kernel+bounces-130191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5543897530
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCA728A148
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23ED15099B;
	Wed,  3 Apr 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPY9OJwc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161914AD15;
	Wed,  3 Apr 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161557; cv=none; b=WYLossb/327z4wcdT4l4Ha0au6rkum0OeshwLLQhj31NmkUFSihK9Ih6M8ZjXA+o0Rw5UtcjT+/hUDRG68fwzTceWIxs8zpbr6Xpkr8cD9QteaWb1zTuyxlRsRf8FjLjeFbbag188tzDCvz7VvkgtTY20fVtQ5fL6RY85ADUuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161557; c=relaxed/simple;
	bh=JMCBB+N9+FM9hPmjmm5AAROCcok9dIVw6il7pADCYVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/fgh1Ovks8i3ujWdRWdaCHYO1lYyMIlCdY0DNzK3pACc/57Y2e2scCYRFyk8B4o37v5WrVQQsjRWjq1/ukXfq+GVRKi9sRxO5Xd94m3sRfh3l30HXzzaSTEvYGu6mIi7gkzvrcR6m3KemgFsxcSGS9OaDyUjMgWFJZLWTzo6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPY9OJwc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712161556; x=1743697556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JMCBB+N9+FM9hPmjmm5AAROCcok9dIVw6il7pADCYVc=;
  b=GPY9OJwcuDboXThs+GDaIJn5aHA/vw0CWvnSidAgfAU6FMxzNfSWCmsy
   ZgwpqSBnatVs6ppa4FLV1nYchXgiMnIurDOVKJwApQp47uGDXnm9XIR+7
   tmNXvT5C8z5cSlos1QFUcnRuyj1Bp8Z/Chf26+wekBcaaPFBphoVHyl03
   9txJLe89YwrTfJTjl3m8HEhMscw+cgTbyzsyNPI2rhLq1U36jC1IeKDHQ
   VhlRzD+6KiwnrT0WD2XPDbnw4gdY3vKe+cqknC52qz9i3/KE8VJXVp2kQ
   bJ4aCypsJZnl6BT/U5PbMIWoGCE4YJ3v97rgRRrXMfG0TMEZWsZV40Pjv
   A==;
X-CSE-ConnectionGUID: f42/TAckT9qoJnD8oxyNIA==
X-CSE-MsgGUID: GD7X2nxXQXGBgfjm0un5fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11184819"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="11184819"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:25:49 -0700
X-CSE-ConnectionGUID: 86lZB59dQ9SiXD5HsxZ5yw==
X-CSE-MsgGUID: 8XLS/jgPQ++ZeivpXNauUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18468376"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:25:45 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 96D8611F811;
	Wed,  3 Apr 2024 19:25:41 +0300 (EEST)
Date: Wed, 3 Apr 2024 16:25:41 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH v3 23/25] drivers: media: i2c: imx258: Add support for
 powerdown gpio
Message-ID: <Zg2DBasC501hMQSS@kekkonen.localdomain>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-24-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-24-git@luigi311.com>

Hi Luis, Ondrej,

On Wed, Apr 03, 2024 at 09:03:52AM -0600, git@luigi311.com wrote:
> From: Luis Garcia <git@luigi311.com>
> 
> On some boards powerdown signal needs to be deasserted for this
> sensor to be enabled.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> ---
>  drivers/media/i2c/imx258.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index 30352c33f63c..163f04f6f954 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> @@ -679,6 +679,8 @@ struct imx258 {
>  	unsigned int lane_mode_idx;
>  	unsigned int csi2_flags;
>  
> +	struct gpio_desc *powerdown_gpio;
> +
>  	/*
>  	 * Mutex for serialized access:
>  	 * Protect sensor module set pad format and start/stop streaming safely.
> @@ -1213,6 +1215,8 @@ static int imx258_power_on(struct device *dev)
>  	struct imx258 *imx258 = to_imx258(sd);
>  	int ret;
>  
> +	gpiod_set_value_cansleep(imx258->powerdown_gpio, 0);

What does the spec say? Should this really happen before switching on the
supplies below?

> +
>  	ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
>  				    imx258->supplies);
>  	if (ret) {
> @@ -1224,6 +1228,7 @@ static int imx258_power_on(struct device *dev)
>  	ret = clk_prepare_enable(imx258->clk);
>  	if (ret) {
>  		dev_err(dev, "failed to enable clock\n");
> +		gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>  		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>  	}
>  
> @@ -1238,6 +1243,8 @@ static int imx258_power_off(struct device *dev)
>  	clk_disable_unprepare(imx258->clk);
>  	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>  
> +	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
> +
>  	return 0;
>  }
>  
> @@ -1541,6 +1548,12 @@ static int imx258_probe(struct i2c_client *client)
>  	if (!imx258->variant_cfg)
>  		imx258->variant_cfg = &imx258_cfg;
>  
> +	/* request optional power down pin */
> +	imx258->powerdown_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(imx258->powerdown_gpio))
> +		return PTR_ERR(imx258->powerdown_gpio);
> +
>  	/* Initialize subdev */
>  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>  

-- 
Regards,

Sakari Ailus

