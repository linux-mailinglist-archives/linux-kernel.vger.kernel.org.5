Return-Path: <linux-kernel+bounces-128360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB48959DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E31F23338
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956E159906;
	Tue,  2 Apr 2024 16:40:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE12AD1E;
	Tue,  2 Apr 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076010; cv=none; b=D4HKF/lsPKplN+uWD0iDOHiiNWyUt0UIYDKZiyA1AmtG4hq8TCiaviQT7pDfHI1djlykxHqWKZGk8J8IX86/j6MbmVIU3pdDPXw4A+t/u8UD/zOtLpJGuFru/PlJ2xxY/cmr0tNVxGTE7FapXLCKZ5+QRMkSJvCwBMch50BpkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076010; c=relaxed/simple;
	bh=c3bpaVDP2rETbrX6SdqFqxkgQdl9vOBqxKTJfbS8q4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYbtVhD5kRL9MGstqB3SzaYaaBsiejASHibCQ3HqwekzWHYXGiSMEihL0FjOGroXb1KY9Nj7B3y9IAGD+jzajSBw+tUSUVIMRSIxjqwL+TuibxbGFztUEn3niEZXych9gx/XTnK1aX2GmZ6Hxo4MNl6syFL1j1l/h6p7BPzb7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6375A1007;
	Tue,  2 Apr 2024 09:40:39 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D80C3F7B4;
	Tue,  2 Apr 2024 09:40:06 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:40:03 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v7 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <Zgw049KpBuQrJsnT@pluto>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-4-3ea519d12cf7@nxp.com>
 <ZgwGpZ6S13vjk8jh@smile.fi.intel.com>
 <c5bdf039-c43b-4611-9f0b-81585e296206@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5bdf039-c43b-4611-9f0b-81585e296206@moroto.mountain>

On Tue, Apr 02, 2024 at 05:09:34PM +0300, Dan Carpenter wrote:
> On Tue, Apr 02, 2024 at 04:22:45PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 02, 2024 at 10:22:24AM +0800, Peng Fan (OSS) wrote:
> > > +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> > > +				 struct pinctrl_desc *desc)
> > > +{
> > > +	struct pinctrl_pin_desc *pins;
> > > +	unsigned int npins;
> > > +	int ret, i;
> > > +
> > > +	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> > > +	/*
> > > +	 * npins will never be zero, the scmi pinctrl driver has bailed out
> > > +	 * if npins is zero.
> > > +	 */
> > 
> > This is fragile, but at least it is documented.
> > 
> 
> It was never clear to me where the crash would happen if npins was zero.
> Does some part of pinctrl internals assume we have at least one pin?

Dont think there were any possible crashes since at the protoocl layer
(not here) kcalloc returns ZERO_SIZE_PTR into pinfo->pins for a zero-bytes
allocation BUT it is indeed never accessed since any attempt to access a
pin will be considerd invalid (any u32 index >= (nr_pins=0))...

..but what is the point of loading protocol and drivers with zero pins ?
You can have zero grouos and zero functions, but zero pins ?

Thanks,
Cristian

