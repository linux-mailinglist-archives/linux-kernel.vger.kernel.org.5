Return-Path: <linux-kernel+bounces-106126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D887E97D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD281F22F97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8EB364A4;
	Mon, 18 Mar 2024 12:41:12 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAF208CA;
	Mon, 18 Mar 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765672; cv=none; b=TlUNxmvS9dIvBW1oTZLgqjPZRe9ovjsM4coCj+/QjAwptOauSrG2lC3RDpIBrs/DPHkBsNiM7xUazHlUf8lnyJ5KoAAeVLWa4hRzGi47dQiuzhGizQs0rd2Aid239GCTc78/3q9OgpUA7VrU3nBKABzOsr1Z5ZBcWaMqvvy7RqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765672; c=relaxed/simple;
	bh=hbCWsyyyVc2IxKC9ULbhavy+FEcr/XWMY4tqRuI8NbM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeToIy0gel4O/fEEFX1CXs72QzPP3A5U8L0MUW2BJmLXHz+rKFmHr83L0I2p8Jo+E1NyC+qFQsVvP5LDwlImmfWjssQ2YGocpiuqmyQ1ereMcaclhuTQxi9xjRJIf4ytxHUV5mwBj2wTOW0woSAqfXz2Kqe1habkg/5M6hCYGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TyvbD1T1pz6K6ST;
	Mon, 18 Mar 2024 20:40:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D5A75141D1E;
	Mon, 18 Mar 2024 20:41:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 12:40:42 +0000
Date: Mon, 18 Mar 2024 12:40:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
Message-ID: <20240318124041.0000032d@Huawei.com>
In-Reply-To: <ZfX5jynjW4M9pvw1@surfacebook.localdomain>
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
	<ZfX5jynjW4M9pvw1@surfacebook.localdomain>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> 
> >  struct ad7944_adc {
> >  	struct spi_device *spi;
> > +	enum ad7944_spi_mode spi_mode;
> >  	/* Chip-specific timing specifications. */
> >  	const struct ad7944_timing_spec *timing_spec;
> >  	/* GPIO connected to CNV pin. */
> > @@ -58,6 +75,9 @@ struct ad7944_adc {
> >  	 } sample __aligned(IIO_DMA_MINALIGN);
> >  };  
> 
> Have you run `pahole` to see if there is a better place for a new member?

I know this matters for structures where we see lots of them, but do we actually
care for one offs?  Whilst it doesn't matter here I'd focus much more
on readability and like parameter grouping for cases like this than wasting
a few bytes.

Jonathan


