Return-Path: <linux-kernel+bounces-69059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0B8583F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315C7B20A20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D55131E22;
	Fri, 16 Feb 2024 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0LjRmmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9A130E2E;
	Fri, 16 Feb 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103976; cv=none; b=OQqyLtfaSCkNKTnAnTvHMyvaJi+2Bgtaco5FD8ov+2dC6+LpQszxJT2oX/4istq8d95873TjmQtpmWic+hWUnWCxyDi3xdwuzeuZPocqohPybztTR91qJXC6PWDyuS737/ZmZMB4t3mbCuhrq/9c0xddyflO23onETLdQsbs//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103976; c=relaxed/simple;
	bh=jajtT3fYHh89nUBt1oc4FBYREo5Q6SP3UVEpUB3mdy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgwyLfiWiJpQeoyXwy5rBUMfGWkUCwG/uVx8AEQ6nu1tAwJJDIiivDLv0Y2x03wGw+uloayFHkq+a46ENVPnGCzJzh8ntPNOW557hweugCHoCMe41u6/sGD9v86AJQfylI6sZ0Lp/gYBIEks8JurHPR1ITNsHQXaI2IHRuYMSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0LjRmmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46519C433F1;
	Fri, 16 Feb 2024 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708103975;
	bh=jajtT3fYHh89nUBt1oc4FBYREo5Q6SP3UVEpUB3mdy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n0LjRmmrxZpNVzyFYsGwbD2p2LVFKzK/EygU0fH5X81lxXU83MhmJtw7YY11T+2B8
	 w+VDan533UAdx4NDrW7mkty+fbRZxfLmmS0QdpY3lcDpDnaJfKM/dtk/HKlu+wqUTU
	 nJGYtVNdtePqCm5Sk1K8Lv6AhXjZFnoxAvLUuwTdGEAECQtquMC0AVmdXtWvnt92xh
	 s5g9MWKeoVymdPNgdozymbdVy+i+VPygj5fgTbh0Kz7Eu6iiseEdh3zp3peKzTfZ43
	 v2SzrAbPVxyASWWglWdBtB7tD3GgxC62grBFCHGKQSKvyiHR0EluWK29qTXj4CghR3
	 IQQRHnrI5QJ6A==
Date: Fri, 16 Feb 2024 17:19:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Beguin
 <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev
 <bigunclemax@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>, Mark Brown
 <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>, Okan Sahin
 <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20240216171921.5a6b6b20@jic23-huawei>
In-Reply-To: <fb7d41fc-328a-4ce1-88ad-5ce22ee158e4@topic.nl>
References: <Zc-E3-MNe9dG9tdW@smile.fi.intel.com>
	<fb7d41fc-328a-4ce1-88ad-5ce22ee158e4@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 17:07:49 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 16-02-2024 16:53, Andy Shevchenko wrote:
> 
> ...
> 
> +       if (reset_gpio) {
> +               /*
> +                * Deassert reset now that clock and power are active.
> +                * Minimum reset pulsewidth is 2 clock cycles.
> +                */
> +               udelay(ADS1298_CLOCKS_TO_USECS(2));
> 
> This is sleeping context and you are calling unsleeping function. I haven't
> checked the macro implementation and I have no idea what is the maximum it may
> give, but making code robust just use fsleep() call.
> 
> It'll actually delay for 1 us (the "clock" is ~2MHz). So fsleep will compile to udelay anyway, which is fine, fsleep might get smarter in future and this would then profit.
> 
> 
> 
> +               gpiod_set_value_cansleep(reset_gpio, 0);
> +       } else {
> +               ret = ads1298_write_cmd(priv, ADS1298_CMD_RESET);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "RESET failed\n");
> +       }
> +       /* Wait 18 clock cycles for reset command to complete */
> +       udelay(ADS1298_CLOCKS_TO_USECS(18));
> 
> Ditto.
> 
> ...
> 
> 
> If it's the only issue I think Jonathan can modify when applying
> (no new patch version would be needed).
> 
> That'd be nice.

ok.  As this is still the top of my tree I'll just tweak it.

Does anyone else read fsleep as femtosecond sleep every time? :)
Maybe computers will go that fast one day.

Jonathan


> 
> 
> --
> Mike Looijmans
> System Expert
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topic.nl<mailto:mike.looijmans@topic.nl>
> W: www.topic.nl<http://www.topic.nl>
> 
> 


