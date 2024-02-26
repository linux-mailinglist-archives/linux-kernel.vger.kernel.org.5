Return-Path: <linux-kernel+bounces-81744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91388679A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FF929D769
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BEA1350F2;
	Mon, 26 Feb 2024 14:55:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F27FBAA;
	Mon, 26 Feb 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959307; cv=none; b=sbEQ+fc4adkbPGXCqCGQ51JEYs2N5T8mTRPaPi1dxUudGxDEAdJihn7aUQElz8YCBxYiKMMgjsp/wMvoi6JBqpnTzkqw6X2a3wBJLdF9o7ketUUo54MUz9TayGfEXolytVOH71031I4m0WdN60+dUQsjgEFK6WHEjdaP8cayOMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959307; c=relaxed/simple;
	bh=I0TdaHq2K6g+L+L8Q/Fh7u2BvRCJVW8ZB71K1N+w5bM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0K5dGxV1CeoGbhqsAoQGh2K4q5c7DTTHkymJVE7Op4vLVj74HALqtxSXJZK0c4KSkANjVwBI3SpizuM1GPwEtKu8AbVnUrlt52qiN5kzE5y4xhEmgtAcInMw9MtaDznuSJXxsVD92I+kSeHoa2Zehl7OX/75zbiNoY3YXsxNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk3Sz0Kg7z6K6hb;
	Mon, 26 Feb 2024 22:50:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D3BF0140D30;
	Mon, 26 Feb 2024 22:55:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 14:55:01 +0000
Date: Mon, 26 Feb 2024 14:55:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Dumitru Ceclan <mitrutzceclan@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
	<brgl@bgdev.pl>, <andy@kernel.org>, <linux-gpio@vger.kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
	<chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
	<mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, "Ceclan
 Dumitru" <dumitru.ceclan@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: Re: [PATCH v15 1/3] dt-bindings: adc: add AD7173
Message-ID: <20240226145500.00007783@Huawei.com>
In-Reply-To: <20240224173055.2b2e067c@jic23-huawei>
References: <20240223133758.9787-1-mitrutzceclan@gmail.com>
	<20240224173055.2b2e067c@jic23-huawei>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 24 Feb 2024 17:30:55 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 23 Feb 2024 15:37:28 +0200
> Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:
> 
> > The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> > which can be used in high precision, low noise single channel applications
> > or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> > primarily for measurement of signals close to DC but also delivers
> > outstanding performance with input bandwidths out to ~10kHz.
> > 
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>  
> 
> Ok, in the interests of perfect not being the enemy of good enough.
> I'll leave the supplies for now.  There are lots of existing drivers
> where we don't list them as required (because my understanding of this
> changed in more recent times).
> 
> It's been on my list of jobs for a really boring Friday afternoon
> to bring them all inline with the convention of if it needs power
> on the pin, it's required, so what's one more? :)
> 
> As Nuno pointed out, patch 2 clashed with work already upstream to
> allow firmware to have the final say on interrupt types. I think
> I've resolved that correctly.
> 
> I tidied up the docs ordering issue Andy noted.
> 
> Also, ad_sigma_delta is namespaced. So added
> MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA).
> 
> Make sure you test your patches with a modular build
> on a more recent tree - that change was early last in 2022!
> 
> A few lines in the driver were too long.
> I don't mind them going over 80 for readability reasons, but
> not over 100.
> 
> Anyhow, with those changes (and please check I didn't mess things up!)
> applied to the togreg branch of iio.git and pushed for now as testing
> for 0-day to get a look in.

Not good news.  There are 2 issues.
>> drivers/iio/adc/ad7173.c:854:3: warning: variable 'chan_arr' is uninitialized when used here [-Wuninitialized]  
     854 |                 chan_arr[chan_index] = ad7173_temp_iio_channel_template;
         |                 ^~~~~~~~
   drivers/iio/adc/ad7173.c:848:32: note: initialize the variable 'chan_arr' to silence this warning
     848 |         struct iio_chan_spec *chan_arr, *chan;
         |                                       ^
         |                                        = NULL
>> drivers/iio/adc/ad7173.c:855:19: warning: variable 'chans_st_arr' is uninitialized when used here [-Wuninitialized]  
     855 |                 chan_st_priv = &chans_st_arr[chan_index];
         |                                 ^~~~~~~~~~~~
   drivers/iio/adc/ad7173.c:845:37: note: initialize the variable 'chans_st_arr' to silence this warning
     845 |         struct ad7173_channel *chans_st_arr, *chan_st_priv;
         |                                            ^
         |                                             = NULL

+ if you build with !CONFIG_GPIOLIB

ad7173_gpio_init() isn't defined.  That needs a stub.

I'll back this driver out for now as fixing the first issue is a little fiddly because
indio_dev->channels is const so the code should allocate and fill the array via a local pointer
before assigning it to indio_dev.

Please send a new version with these resolved + make sure you run some build tests.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 


