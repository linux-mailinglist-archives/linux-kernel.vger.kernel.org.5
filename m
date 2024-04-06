Return-Path: <linux-kernel+bounces-133965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765689AB8A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80A028219E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEC939FE4;
	Sat,  6 Apr 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCifKKj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299536AF2;
	Sat,  6 Apr 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416248; cv=none; b=ZIUz/KBBRB2DYOKCsRIKNiEGFHpJWR9bbYUXS1fbKS+jv8Eg7ahfooDvn7IJR7+jBMRrO6MH0Hw/yFwmAACk7jU/76bNRMWFYulmCnAvX/Vz7IQFnDyFJwx3qUs7YS2RS59hvVrNR3/Sh2VuHyZEQZuMB0ZODa1ClC1szh+mzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416248; c=relaxed/simple;
	bh=5emgxAYuL3Uh/wVc4IUoxs/1/ddCC16VTMbHABngszQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trxo4XN4dHbWvwLp6ZBbYkAz+toT7So1C3tBl1O/C3UY2+KdHpuhk+EBHfSUgB3nZ0UcqxGMVijwwOmaakEFdw+UzZtoSqnl40N2xv2bXgKGtfH0Y0YJahqpdcKUWJ94Tt9JGwnXga89Uh3zuOHIEXRe+wslEAnmW/wQIee7mgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCifKKj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBE9C43390;
	Sat,  6 Apr 2024 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712416247;
	bh=5emgxAYuL3Uh/wVc4IUoxs/1/ddCC16VTMbHABngszQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TCifKKj+aKJ/MmDeAFtT+mOorB2XyOAVUn3j7bmZgBiRjc+OluvfcmM2CPVYab28Y
	 0A6M7Y3Lc706CoI93wm6BtfNySz4nejDYPvbhBXly7vLzVpNyUwIH4WxoFgNX8uqAf
	 T/ahL9OyoFiEeDz1CApD9ckc/RpZiZvsfI6a9LYSOvdZXD0SBPyEQMVCJQDQyDKqAc
	 e5CECFuOdpy2SIOToJ31Mni/rFJ6RtPJMAc+6Rlkuebz0kM3ag0tyGo+riVVfJePes
	 n23jwl3ZOZwHvskRk4PDUvtV+wc5CNmHQ/CSbVPhbO7npmeKx1ELquCCTaobvm5q5f
	 Ly/OlQEwYm3/g==
Date: Sat, 6 Apr 2024 16:10:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
Message-ID: <20240406161031.6192f4f4@jic23-huawei>
In-Reply-To: <CAMknhBFZKKim4JyXLpHY=EoyW4ZPp03aHte5xy0ZkDnW16sfeA@mail.gmail.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-6-34618a9cc502@analog.com>
	<CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
	<c7c26d36-ab08-420c-b634-8eb6d9cee9b5@gmail.com>
	<CAMknhBFZKKim4JyXLpHY=EoyW4ZPp03aHte5xy0ZkDnW16sfeA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >  
> > >> +               case IIO_CURRENT:
> > >> +                       *val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
> > >> +                       *val /= AD4111_SHUNT_RESISTOR_OHM;
> > >> +                       *val2 = chan->scan_type.realbits - !!(ch->cfg.bipolar);  
> > >
> > > Static analysis tools like to complain about using bool as int.
> > > Probably more clear to write it as (ch->cfg.bipolar ? 1 : 0) anyway.
> > >  
> > Maybe it does not apply here, but i followed this advice:
> >
> > Andy Shevchenko V1 of AD7173 (named initially ad717x)
> > "  
> > > +     return (bool)(value & mask);  
> >
> > This is weird. You have int which you get from bool, wouldn't be better
> > to use
> > !!(...) as other GPIO drivers do?  
> 
> As long as the build bots don't complain, there isn't a reason to
> change it. It is just a matter of personal preference at that point.
> 
> I got a sparse warning for something like this recently [1], but maybe
> that case was just because it was inside of a FIELD_PREP() using it as
> bit logic instead of addition and we won't get any warnings here.
> 
> [1]: https://lore.kernel.org/linux-iio/20240129195611.701611-3-dlechner@baylibre.com/

It was common to use !! for a number of years, but then it got a
comment from Linus Torvalds making reasonable point that it isn't
easy to read, so slight preference these days is for a ternary.





