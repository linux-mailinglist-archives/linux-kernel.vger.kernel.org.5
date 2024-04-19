Return-Path: <linux-kernel+bounces-151596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58BF8AB0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6556B1F231FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D10212EBEA;
	Fri, 19 Apr 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLwY5B8e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF438562A;
	Fri, 19 Apr 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537790; cv=none; b=acUBjE+psyjp8WFkRGx0z1q9zZQEqNP+ftFob0MuoqXCVXw2S6Bm+Tc5RmfP0ZbzAo9CLuvvm5216XTbGlCTWtNRDhVTMShrBlkx7C3wgXUgMNf3FjqzzGOP7P5e/uVx19xie6reJeCQxBavCw5SZZeCiAeuxAe3qQjT2t1+N9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537790; c=relaxed/simple;
	bh=GzR8k/QVmr64Q3usu7GsrkbHHThh/zrClh8KEifcHkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e++uarVv4gRl0TtYKWQ1H03HmHBmZv+1qJGwoUVmgKpy6j5ToJ5teM9UKz4A92vtBSHOU+sFhw09EaK2gwx0fkh8ioQcSJpfYgdmT2Xi1KOSO/OeVizuo8mA52guUE9f9joTIi4nafddaYuK/2nVV39u5905BUSKQGm2Ay3PcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLwY5B8e; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713537789; x=1745073789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GzR8k/QVmr64Q3usu7GsrkbHHThh/zrClh8KEifcHkU=;
  b=HLwY5B8e7/oOHxC0/F3Dx5CiKHwSKLPZJHZUyY7EAiRz1YDP8NFrnrwT
   cqyYFSoaGaWWaIfdZuM7ByGqoipmwR+HJrE+jbnSDbZAohlQ8C52evY0S
   Qd+y3H6TPH9ui1w5+3JmR6OEvfyTClc9mxWV9WSpeh9DMJs7RkHbpx4Kr
   AjvPs2+Y7K3+LMeKukRMhG897UBxckj3PhsUkIhPu3LEXK6QKQTOLKY/3
   57yrM8VFLlUtQ6DD5I+qsroXvU9EzSaiQ0J/eP2P7h27MjVXG2DY5FpnM
   q83KCRFulmXMb8gbjZ17G+8E3v9mdPr6fQodV6VCts/uGkigFH/1iN2sd
   g==;
X-CSE-ConnectionGUID: gcK+xMpDRoaTYCMWqaKciw==
X-CSE-MsgGUID: cZhst/pmRdG/G59gLzMnJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20564028"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="20564028"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:43:08 -0700
X-CSE-ConnectionGUID: 4tlJWgHFT+myZN9cxJ/keQ==
X-CSE-MsgGUID: EF1ndmXPRoiZrEv7+m9KaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="54552844"
Received: from mpkangas-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:43:06 -0700
Date: Fri, 19 Apr 2024 17:42:59 +0300
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
Message-ID: <ljyjvdtzhgug7frkiwbrvobbusnzqu5gpn345n5bjsmbuw5gjd@xex3dznz5jov>
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
 <CACRpkdbSB+JTdhGXViWs-SmR3nUnm6dVXt3WzK-d4zFSz63XxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbSB+JTdhGXViWs-SmR3nUnm6dVXt3WzK-d4zFSz63XxQ@mail.gmail.com>

Hi Linus,

Thanks for the review!

On Fri, Apr 19, 2024 at 03:11:23PM GMT, Linus Walleij wrote:
> On Fri, Apr 19, 2024 at 10:07 AM Aapo Vienamo
> > +static int gnr_gpio_configure_pad(struct gpio_chip *gc, unsigned int gpio,
> > +                                 u32 clear_mask, u32 set_mask)
> > +{
> > +       struct gnr_gpio *priv = gpiochip_get_data(gc);
> > +       void __iomem *addr = gnr_gpio_get_padcfg_addr(priv, gpio);
> > +       u32 dw;
> > +
> > +       if (test_bit(gpio, priv->ro_bitmap))
> > +               return -EACCES;
> > +
> > +       guard(raw_spinlock_irqsave)(&priv->lock);
> > +
> > +       dw = readl(addr);
> > +       dw &= ~clear_mask;
> > +       dw |= set_mask;
> > +       writel(dw, addr);
> > +
> > +       return 0;
> > +}
> 
> Configure pad sounds like pin control so it's a bit of icky name.
> What it really does is configure the direction (in or out) for this
> GPIO pad. And it's not really the *pad* that is configured, right?
> It is the hardware *driver* for the pad, i.e. what is reflected in
> the GPIO line control register.
> 
> Can you rename this:
> gnr_gpio_configure_direction()?

I do agree that the pad part of the name maybe isn't the best, though
this function isn't just for direction control, since it's used for
setting the pin output state as well in gnr_gpio_set(). The idea is that
locking and masking of the register accesses is factored out of the gpio
callbacks and implemented in this function.

Maybe gnr_gpio_configure_pin()?

Best regards,
Aapo

