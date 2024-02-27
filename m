Return-Path: <linux-kernel+bounces-82610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85CF868717
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8431B28F72F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85A125B9;
	Tue, 27 Feb 2024 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SOXiHVhg"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F878836;
	Tue, 27 Feb 2024 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000966; cv=none; b=C9Aeglheb1WLX2xW/fmYurVzQqMGY0Elf6ZkT89e0QkC3zeWDUuJiaYggImJF2ueibasMqf0uJN98zBGqhY6fgDKGhbb58xbP509WG25z9akeK6n4TQdqAIMMovrAo8w5IXUSBYPlcdM24reFqtkkdXhiys+vzGLRZZfXCch0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000966; c=relaxed/simple;
	bh=CQcmSdTnqpd5Qmt10ywYmhJACCjuD+iFxTpjCNEa6hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxQhkqKwhDL7LSaNFZQVoNcbu+BrwE6P6+PyCCE7WGLJCzB3IquNfabtqA5WaexofV/kow88xW09XOxFjbrBq7SoDhYxkArII2cZXpbvoSNEWYYPkNELQSB1w9uVdENPTN0hUz7eJuJIJQmX1vA38vZTM2uKGPlqHqHYN3EtuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SOXiHVhg; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5331C0002;
	Tue, 27 Feb 2024 02:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709000961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZzMbQBkiSynWHTc4VGxbpzP64pxHR1xQp2R1cnNObQ=;
	b=SOXiHVhgdPkKz9IKFPA/936mLdWKmqPFcFgHeEDXrN+aYV+dNz5c7gGaS2fmyrsgfOayJb
	4bjdSkGGpXIVpbmk6f2WuLvPQ/2RSwIMEp+NxKH0upywF4XdLELYS3ZgdyboF0YuPSBBkG
	3oFZPexAAMbqZUKcNvmn3S0Xi8iZHztG8UbnnPwumT5vvvMT289TpAlHLHNwrUw4UWerhx
	YW7T4X1PC6lmdvNbwj3Dw4aRBh7OnVpdJBK8+xMN8kKLycvy94If0DZgBuUwzLEJ7J17DW
	n0yy5w8KWo11GDciU78Gg4cxj+0AkJn/acCPWKExizuKaMEv8Obs/vU9jisIHg==
Date: Tue, 27 Feb 2024 03:29:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: antoniu.miclaus@analog.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v8 1/2] rtc:  max31335: Add support for additional chips
Message-ID: <20240227022919856ffa1d@mail.local>
References: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
 <20240227010312.3305966-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227010312.3305966-2-chris.packham@alliedtelesis.co.nz>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 27/02/2024 14:03:09+1300, Chris Packham wrote:
> -	max31335->clkout.clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(max31335->clkout.clk))
> -		return dev_err_probe(dev, PTR_ERR(max31335->clkout.clk),
> -				     "cannot enable clkout\n");

This is so ugly and should have never passed. I went weak in front of
Antoniu's insistance but I'm very close from ripping out the whole
driver from the kernel now.

Seriously, read all the comments that have been made around the IRQ/clk
stuff and come back with a proper solution.

> +static int max31335_irq_init(struct device *dev, const char *devname)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	switch (max31335->id) {
> +	case ID_MAX31328:
> +		break;
> +	case ID_MAX31331:
> +	case ID_MAX31334:
> +		if (max31335->clkout.clk) {
> +			/*
> +			 * interrupt muxing depends on clkout so enable clkout
> +			 * if configured before requesting interrupt
> +			 */
> +			ret = clk_prepare_enable(max31335->clkout.clk);

Do I get this right that this is about enabling its own output clock?
Why would you need to do that? Something else must be the consumer, not
the provider itself.

> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "cannot enable clkout\n");
> +		}
> +		break;
> +	default:
> +		if (max31335->clkin) {
> +			if (max31335->clkout.clk && max31335->irq > 0)
> +				return dev_err_probe(dev, -EOPNOTSUPP,
> +						     "irq not possible when both clkin and clkout are configured\n");

This is not true, the RTC is always a clock provider. What is not
possible is muxing the clock on the pin in a few configurations.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

