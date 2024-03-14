Return-Path: <linux-kernel+bounces-103437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C199787BF52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8767284CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A100D6FE1D;
	Thu, 14 Mar 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO0LR9Gf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B76FE3D;
	Thu, 14 Mar 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427886; cv=none; b=NMzgA3nWL5a/tAW53YuIzJyzyG4zPzZ+0dE5LDO4GfsWSUIXtPso6aBbayy03nk+eb18RAk1Ok3DZS7Kx7fQoL+vFmjX8e01bksVVKbHLEPzAHxQPH3+IWSvecm8RuZpxsQobBkinr4CzSvWFLGJiWZkcfTg/HUEOqj9e/bmk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427886; c=relaxed/simple;
	bh=a6BsX952dU3UtrN1MaRvQHUha3lFnaN4sTX2EnQLhFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/MbtrPgoqB/OzcSg/ksG3FfC0wRgZa3SRaFocgPJS4z3v6qh+8MzoCCDPVtNgSiPiVq3/5mws1WD/MQloiRXCFFnJmQZ9d+kRXXDt0ulddAT/kZgdCiPDna36lK2R/UY8CICcM9smRgx+n4O8CCjniOiQYw8Pk+tLszrzKKcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO0LR9Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED38C433F1;
	Thu, 14 Mar 2024 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427885;
	bh=a6BsX952dU3UtrN1MaRvQHUha3lFnaN4sTX2EnQLhFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JO0LR9GfMEhkMHh6KNx4/Gghs4Li8lTMLYVO9kFRcPKMaVNGCfiy6t0ZQkWOLqP9V
	 6ufO89sfq0Rhtx0Abj/Io1pVISiFjozQ3PaZEhBEG9bgmRReBW1fTm9EqQc45wA3Fd
	 D6zSrfS998HjW/TdM6hZld7kjkhAS+ghRmtBVUNpSqyKyNWEzcJkTYBqBocnoUcWvU
	 MoHlBiSCKWFPQL9ELCjFJIbbRlbMLSDFv7mXFtUKJvvwcomrpYlcBjpdAQwXPwMh5l
	 1Ov0+yLbMlkVuUcW2tQTi2BoTL6QyYo4erOSutxeFcJvOQDc5bmoWFcLE+mD9jpW13
	 DJbkbsIiTyZ/w==
Date: Thu, 14 Mar 2024 14:51:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: pressure: Simplify and make more clear
 temperature readings
Message-ID: <20240314145109.232f6d05@jic23-huawei>
In-Reply-To: <ZfH4znQ2FK6j5LWK@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-5-vassilisamir@gmail.com>
	<ZfH4znQ2FK6j5LWK@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 21:04:46 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 13, 2024 at 06:40:05PM +0100, Vasileios Amoiridis wrote:
> > The read_press/read_humid functions need the updated t_fine value  
> 
> read_press()/read_humid()
> 
> 
> > in order to calculate the current pressure/humidity. Temperature
> > reads should be removed from the read_press/read_humid functions  
> 
> read_press()/read_humid()
> 
> > and should be placed in the oneshot captures before the pressure
> > and humidity reads. This makes the code more intuitive.  
> 
> ...
> 
> > +			if (strcmp(indio_dev->name, "bmp580"))
> > +				data->chip_info->read_temp(data);
> > +  
> 
> > +			if (strcmp(indio_dev->name, "bmp580"))
> > +				data->chip_info->read_temp(data);  
> 
> Yeah, not a fan of the strcmp().
> 
Yes - that's a non starter.  Add a flag to say it is necessary to
chip_info that doesn't rely on name matching.  If you do it the way
you have here, you have to add another strcmp for each new device
supported that needs this code to run.  Add a flag and you just
set that in the chip_info structure.  Much more flexible and extensible.
Usual description of this is "when you can do things with data rather than
code, do it with data".

Jonathan


