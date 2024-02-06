Return-Path: <linux-kernel+bounces-55684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F1B84BFEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9FC1F23F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031DA1BF3A;
	Tue,  6 Feb 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eDPGFkMh"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9851C69D;
	Tue,  6 Feb 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257817; cv=none; b=cK3Wftq3L+1OXWRCn17UDFiQj1cJkOIinTrQTbtiwGu8GvDA5LU7A//+MKvLx6X6OCMTeHFce/uJpxMBukDC4HmN47DT4c2owjvbturK+oB9UrxLNjrgsNsVxOn4Q4Ptb7e8AW5sWjhbUIgbA9mYBSmvL4dxqG1GlpFlkQGS75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257817; c=relaxed/simple;
	bh=6e1eWi0XVmAapbmVvkOieE4PlZ6Y5JmX2oQHiJNDA4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNXRpOloivLAlbUFPIhQy1K7s7E4bgvIXuUuOovTKd6UO1BL9zMx/3xUGNw/eBo/r3bHTKHDRWmQSueJQuyL97kRh0P7h0s60+KBUia12rnl906LazZieGowZxjE+uxNt68j5alUl8O5mBqc3VrO+sjXGRzAVRNe6skWnlAY0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eDPGFkMh; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7922DC0003;
	Tue,  6 Feb 2024 22:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707257806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CyGTWHQrBLjLWWo2xOLwLlHdJNVmydb/RrvwG6gICsE=;
	b=eDPGFkMhJtW98eEXH+8tczLIX6hPffiNAVnEoGkDgYDk9vHlaQyi0soDNIiGwJkMgpQLYs
	rnvxBi8rIQkDR6gv16wy5yqCJsGuGhBoDBah0an0S43gtuGE9aRjhNZK+tCUQVfaUBSgMu
	94h21on8yVIjkA3CXJUbNEYKRofl/+UwCJr8RXFh271DlCYIRPFv+4urO1WpP0zibi2L1g
	p5Hg6r3UEk/XtT1TGCSRNMddTgXZoqxoj/bL3Ag13Vp4AzcVCz5ldAcTKmx8Tc0lk92vze
	QvkXJrSFLzn7/+kNCa2h1IVfGtQ47rOtF3X5UA+GfHgPENq6tHT/Ps8gJe3jgQ==
Date: Tue, 6 Feb 2024 23:16:44 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
	"noname.nuno@gmail.com" <noname.nuno@gmail.com>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <20240206221644f524816e@mail.local>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
 <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
 <aecd80a3-a017-405f-b77d-6deda67ef704@linaro.org>
 <5d4b7fa1-5cc2-4a4a-8fa4-d2c7a8d070b7@alliedtelesis.co.nz>
 <20240206211237d9192660@mail.local>
 <e7a21789-9253-4185-98ed-e335d0167df4@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a21789-9253-4185-98ed-e335d0167df4@alliedtelesis.co.nz>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 06/02/2024 21:41:10+0000, Chris Packham wrote:
> 
> On 7/02/24 10:12, Alexandre Belloni wrote:
> > On 06/02/2024 20:19:20+0000, Chris Packham wrote:
> >> That is an incredibly good point. The max31335 binding covers one specific chip. This binding covers more and with that there are a few more properties that the max31335 on it's own doesn't have (e.g. the clock consumer, the ability to have different i2c addresses). Binding wise I could probably roll all of the max31335 into this max313xx binding.
> >>
> >> Driver wise things are a bit trickier. I've only got access to one of
> >> the variants so I am hoping to leverage the work Ibrahim had already
> >> done. I could attempt to incorporate max31335 support into the
> >> max313xx driver but I wouldn't really be able to test it properly and
> >> there is a reasonably high chance of regressing something.
> > But I won't take a separate driver. Everything would be better if Analog
> > was sharing the datasheets...
> 
> The datasheets are pretty accessible so I'd give Analog a pass on that 
> (they're certainly better than some vendors). I'll include some links on 
> the next update.
> 

The max31335 is not available

> I'll attempt to roll the max31335 into the max313xx driver.

I guess this would be the opposite. Renaming a driver breaks existing
kernel configurations.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

