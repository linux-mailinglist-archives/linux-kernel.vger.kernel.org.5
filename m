Return-Path: <linux-kernel+bounces-123188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BC98903E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4219929051D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F7A130AF0;
	Thu, 28 Mar 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMo3tpdJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225E7E0E8;
	Thu, 28 Mar 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641224; cv=none; b=lf3r8+sR7Q08IeN9EUA2JjWxL+NToVeo8PFel4fxaFtiaZe7bTydXdzP4hlAqTAV32I9BT3yS4SJqf+b0BKLl5r5bLFxgxjPzyw5Bg5XOsGmDTkt/TXs9SIrGALq6VyE/VM3q0ehOdt52W89Hcej4uAirWRnBl2LrWAdBYLbiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641224; c=relaxed/simple;
	bh=UQ4ftE4d2wyJQXBRF16WggqiN2pIoTo1vBnMgKGTa20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/xnIOEKTx4hB3wnuKT84H2uJ9lJBM+GK61yfmQ0yssfhSJNz8bX8kVNFjQOW5z1udy6f9lXCyzHUMPmecInbZ0Fxw6y7uJyhrWb0KvtJ0XH7+xoCIRmVQXhJRxuUNd+/PmReg7+Iha88DvmfGSUOfsKeInApD6XbeC+Mn1iank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMo3tpdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC31C433C7;
	Thu, 28 Mar 2024 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711641224;
	bh=UQ4ftE4d2wyJQXBRF16WggqiN2pIoTo1vBnMgKGTa20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PMo3tpdJon9JSWvzLbi3LYD+vJR6aWdM1xxxv4uYiX9pi50ulIvqx9GdLVFmgf/eG
	 y54+FB3f2fVUN7lN24VF9ScRwGE5+nai38XVEFsEY5aGcu/OxmPMo0CRo66VMu641k
	 mdC0z045ZAiJJEfpRO0b9Dj95MNNkN2YcpCv9zrH81OgL69pfoKSG72rxoNnF+ixZE
	 EZKJHXNr8zOTso7/8FjpGQqDLUmz+ExjAsxs8zD+SWgEWTwVed6LVqHLEBYqoP4S62
	 SoOZq6bJ6d5B7Qr/JjEcmvh3KqQOjAPpY9weBmLgeiFegivskWRvQnn9afckV9PtMn
	 Pd9/b0WisbQDw==
Date: Thu, 28 Mar 2024 15:53:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jean
 Delvare <jdelvare@suse.com>, Support Opensource
 <support.opensource@diasemi.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] hwmon: (da9052) Use
 devm_regulator_get_enable_get_voltage()
Message-ID: <20240328155328.755708bf@jic23-huawei>
In-Reply-To: <13405bc9-3c97-4063-87b3-45a7e686fa50@roeck-us.net>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-3-5f4517faa059@baylibre.com>
	<20240328142038.33ad68bc@jic23-huawei>
	<13405bc9-3c97-4063-87b3-45a7e686fa50@roeck-us.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 08:20:00 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 3/28/24 07:20, Jonathan Cameron wrote:
> > On Wed, 27 Mar 2024 18:18:52 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> We can reduce boilerplate code by using
> >> devm_regulator_get_enable_get_voltage().
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> > 
> > A few comments inline, but nothing substantial.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> >> ---
> >>   drivers/hwmon/da9052-hwmon.c | 33 +++++++--------------------------
> >>   1 file changed, 7 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
> >> index 2bd7ae8100d7..70e7bc72e980 100644
> >> --- a/drivers/hwmon/da9052-hwmon.c
> >> +++ b/drivers/hwmon/da9052-hwmon.c
> >> @@ -26,7 +26,6 @@ struct da9052_hwmon {
> >>   	struct mutex		hwmon_lock;
> >>   	bool			tsi_as_adc;
> >>   	int			tsiref_mv;
> >> -	struct regulator	*tsiref;
> >>   	struct completion	tsidone;
> >>   };
> >>   
> >> @@ -414,32 +413,19 @@ static int da9052_hwmon_probe(struct platform_device *pdev)
> >>   		device_property_read_bool(pdev->dev.parent, "dlg,tsi-as-adc");
> >>   
> >>   	if (hwmon->tsi_as_adc) {
> >> -		hwmon->tsiref = devm_regulator_get(pdev->dev.parent, "tsiref");
> >> -		if (IS_ERR(hwmon->tsiref)) {
> >> -			err = PTR_ERR(hwmon->tsiref);
> >> -			dev_err(&pdev->dev, "failed to get tsiref: %d", err);
> >> +		err = devm_regulator_get_enable_get_voltage(pdev->dev.parent,
> >> +							    "tsiref");
> >> +		if (err < 0)
> >>   			return err;
> >> -		}
> >> -
> >> -		err = regulator_enable(hwmon->tsiref);
> >> -		if (err)
> >> -			return err;
> >> -
> >> -		hwmon->tsiref_mv = regulator_get_voltage(hwmon->tsiref);
> >> -		if (hwmon->tsiref_mv < 0) {
> >> -			err = hwmon->tsiref_mv;
> >> -			goto exit_regulator;
> >> -		}
> >>   
> >>   		/* convert from microvolt (DT) to millivolt (hwmon) */
> >> -		hwmon->tsiref_mv /= 1000;
> >> +		hwmon->tsiref_mv = err / 1000;
> >>  
> > 
> > Using a variable called err for a good value is a bit ugly but fair enough if that
> > is precedence in this driver.
> >   
> 
> It isn't. The existing code assigns the return value from regulator_get_voltage()
> to hwmon->tsiref_mv and then evaluates it. I would not oppose introducing a variable
> such as tsiref_uv, but not the misuse of 'err'. I am not going to accept the code
> as suggested. It is bad style, and it would invite others to use it as precedent
> when trying to introduce similar code.

I was too lazy to look and see if there were existing cases :) Local variable indeed
the right way to go.

> 
> >>   }
> >> @@ -483,10 +466,8 @@ static void da9052_hwmon_remove(struct platform_device *pdev)
> >>   {
> >>   	struct da9052_hwmon *hwmon = platform_get_drvdata(pdev);
> >>   
> >> -	if (hwmon->tsi_as_adc) {
> >> +	if (hwmon->tsi_as_adc)
> >>   		da9052_free_irq(hwmon->da9052, DA9052_IRQ_TSIREADY, hwmon);  
> > Superficially looks like devm_da9052_request_irq could be added that
> > uses devm_request_threaded_irq() to allow dropping this remaining handling.
> >   
> 
> That should be a separate series of patches. A local solution might be
> to use devm_add_action_or_reset(), but that should also be a separate patch.


Agreed.  Just a passing comment whilst the code was in front of me.

Jonathan

> 
> Thanks,
> Guenter
> 


