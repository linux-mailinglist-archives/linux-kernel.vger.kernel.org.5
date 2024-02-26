Return-Path: <linux-kernel+bounces-82213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E6086809F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840381C28DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F6B130ADE;
	Mon, 26 Feb 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kbmp3DPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2812F586;
	Mon, 26 Feb 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974636; cv=none; b=L8vzsGz8UhpX5pciyGiCsRFpwOMFkGdlsctuHBcGyQqtVMJW0RGXnPRROgNYd1Gd27Q8KI/44kF6do6zAVGlbDaEjq8J+nviT79ZyjHWCc957+eT7RRnRZkX3rZguTIiLKfN2lUWozhyA6EazNd9FKuDKbi60eR8O80y2AkzRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974636; c=relaxed/simple;
	bh=r3WL10V8lVhng5mzweFxXOSYkzbeF/59JAqu8qYguho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1WrEGVA9hhUQpCo4S+syubBfYO82wPp8ZC7xP1+r9rItMith1n0okAl+yGzDvwRJqQnKTC1CJEZc5yDHFn7EviMv4AcgFJHxbNL2F3chEpZT8l5ZmqbX9eva0vc9L1vi4iJnQ2Blo+1T903eHulFLl7EFLry8wa9ofnPA8V6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kbmp3DPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA80C433C7;
	Mon, 26 Feb 2024 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708974635;
	bh=r3WL10V8lVhng5mzweFxXOSYkzbeF/59JAqu8qYguho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kbmp3DPLqo+WZBNwoJi38Lo9m2jIb6vXMqm8afS+SoNE0UO4WA/1H8gK5K1zFRQGv
	 NCCOXjof30mwCEdq26HCJy3+nAGG5W8xgUYxqgnOXSaIQJNn3UHDPaFkrDg8G6ouOC
	 Ci2puHvIBjXwNRvG/2FvvOoRgap67OhJnYpP5NqQcY0+Le6GRNJTwCaF89vSKO8+ZE
	 BIz7mBCL9ZNaF0WjDBS1UfK+AVK7xAXbchFLTKy95I+UO6jkDckIenEkodLewQAB1d
	 Ef6RkGiTFgvn8nuU1/UoMUD0YF+y2zPG/UHl2P5jEng0467mX61GoNLoiWF1olGFfB
	 qBjE8VTzKffyw==
Date: Mon, 26 Feb 2024 19:10:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Marek Vasut <marex@denx.de>,
 Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240226190953.1467da54@jic23-huawei>
In-Reply-To: <ZdycR6nr3rtrnuth@smile.fi.intel.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
	<20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
	<ZdycR6nr3rtrnuth@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 16:12:23 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 18, 2024 at 04:18:26PM +1030, Subhajit Ghosh wrote:
> > Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> > It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
> > channel approximates the response of the human-eye providing direct
> > read out where the output count is proportional to ambient light levels.
> > It is internally temperature compensated and rejects 50Hz and 60Hz flicker
> > caused by artificial light sources. Hardware interrupt configuration is
> > optional. It is a low power device with 20 bit resolution and has
> > configurable adaptive interrupt mode and interrupt persistence mode.
> > The device also features inbuilt hardware gain, multiple integration time
> > selection options and sampling frequency selection options.
> > 
> > This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
> > Scales, Gains and Integration time implementation.  
> 
> ...
> 
> > +/*
> > + * Available scales with gain 1x - 18x, timings 3.125, 25, 50, 100, 200, 400 mS  
> 
> "mS" --> "ms."
> 
> > + * Time impacts to gain: 1x, 8x, 16x, 32x, 64x, 128x
> > + */  
> 
> ...
> 
> > +	/*
> > +	 * If this function runs parallel with the interrupt handler, either
> > +	 * this reads and clears the status registers or the interrupt handler
> > +	 * does. The interrupt handler sets a flag for read data available
> > +	 * in our private structure which we read here.
> > +	 */
> > +	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
> > +				       status, data->read_data_available ||
> > +				       (status & (APDS9306_ALS_DATA_STAT_MASK |
> > +						  APDS9306_ALS_INT_STAT_MASK)),
> > +				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);  
> 
> > +  
> 
> Redundant blank line
> 
> > +	if (ret)
> > +		return ret;  
> 
> ...
> 
> > +static int apds9306_init_iio_gts(struct apds9306_data *data)
> > +{
> > +	int i, ret, part_id;
> > +
> > +	ret = regmap_read(data->regmap, APDS9306_PART_ID_REG, &part_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(apds9306_gts_mul); i++)
> > +		if (part_id == apds9306_gts_mul[i].part_id)
> > +			break;
> > +
> > +	if (i == ARRAY_SIZE(apds9306_gts_mul))
> > +		return -ENXIO;  
> 
> Strange choice of the error code, why not (one of) -ENOENT / -ENODATA ?
> 
> > +	return devm_iio_init_iio_gts(data->dev,
> > +				     apds9306_gts_mul[i].max_scale_int,
> > +				     apds9306_gts_mul[i].max_scale_nano,
> > +				     apds9306_gains, ARRAY_SIZE(apds9306_gains),
> > +				     apds9306_itimes, ARRAY_SIZE(apds9306_itimes),
> > +				     &data->gts);  
> 
> > +
> > +	return -ENXIO;  
> 
> Dead code.
> 
> > +}  
> 
> ...
> 
> Jonathan, are you going to apply this and addressing comments at the same time?
> Or should it be another version?
> 

The multibit field pretending to be a boolean was too complex for to want to modify
whilst applying. So yes, v8 with that tidied up and your comments sorted out

Jonathan


