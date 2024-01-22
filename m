Return-Path: <linux-kernel+bounces-32870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D9836129
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B8D1F21E32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B533D577;
	Mon, 22 Jan 2024 11:09:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB53D555;
	Mon, 22 Jan 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921749; cv=none; b=nvxORgkV0VBKatS26GFx20zPECbI2sDw+hQVfn9zqeQ9ffW9rrkZgxvt+u4GNadu5tQJ08JhlSZMjvMow/yrBd1ENXzO/c+mEZeAvyJ1HD8NZI8WwKjDcjDDEen61BWwOBVH8N0KZaF20vdrgC3xlHumzVPCBjMGloVqOQRIq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921749; c=relaxed/simple;
	bh=RAHCPa5LLeS2+X/yJSngT097aqPs0WTNZ+ONX6kPsPg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHLd/qNB6I7OBy6wqbTFqnzJF4C9XfV1T1Q7Mw9SdcOMm06ffNf/NHMFA1O3eifRQeediWN9VZ72fzD+LPxvZTfgiUoNUlNMmJC59CHZXmz7A2zjBnblzRYpBKSx4NCw6z7tTBNwzKFuWpUYqF3xhnc1rIDT9lzqD4yOhRzTnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TJS815ZyBz6J9gC;
	Mon, 22 Jan 2024 19:06:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D1921140A90;
	Mon, 22 Jan 2024 19:09:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 11:09:03 +0000
Date: Mon, 22 Jan 2024 11:09:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linus.walleij@linaro.org>,
	<brgl@bgdev.pl>, <andy@kernel.org>, <linux-gpio@vger.kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
	<chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
	<mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, "Ceclan
 Dumitru" <dumitru.ceclan@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20240122110902.00004357@Huawei.com>
In-Reply-To: <57ea42b3-106b-4361-8d07-4e1656bf6e58@gmail.com>
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
	<20240118125001.12809-2-mitrutzceclan@gmail.com>
	<20240121155041.3fc1a85d@jic23-huawei>
	<57ea42b3-106b-4361-8d07-4e1656bf6e58@gmail.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jan 2024 12:02:35 +0200
Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:

> On 1/21/24 17:50, Jonathan Cameron wrote:
> >> +	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);  
> > If the error interrupt is provided either first, or as the only interrupt
> > this is going to use the wrong one.
> > 
> > Probably need to have a variant of that which takes an explicit irq so that
> > figuring out which irq is relevant becomes a driver problem rather than the
> > library having a go based on spi->irq.  
> 
> Would it be acceptable to check if spi->irq interrupt number is equal to
> fwnode_irq_get_byname(dev_fwnode(dev), "rdy")?

That would be a good start and probably cover most cases.
> 
> If not, a message could be passed that specifies either that "rdy" is
> needed or that it must be placed first.

If you are mandating the order, that should possibly be reflected in the binding.
If this was hard to fix, I'd be fine with leaving for when someone runs into
a case where they have it ordered the other way around, but given it seems simple
to fix up probably better to just do it and avoid having to remember anything
about it later.

> 
> 
> Another alternative would be adding irq to ad_sigma_delta_info so a
> driver could specify the desired interrupt to be used for conversions.
> 

That works.  Make it optional so if value is 0 use spi->irq as before so
that you don't need to modify the other drivers.


Jonathan



