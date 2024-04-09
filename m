Return-Path: <linux-kernel+bounces-137445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5589E244
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAB12880A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D820115697E;
	Tue,  9 Apr 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNHeecP4"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C015697F;
	Tue,  9 Apr 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686297; cv=none; b=ap6EUlBi1V6FnprRf3vv8Sc5JEtUeA3LMFUQE1G+N+4qiTwjIX+8duA1H+QP7HP5jvyBTTAlsTDU4FG7b/BlUqgWnyO8m/jLUORjpzS/pqr0Krsv4FI+s6h/qQkFsI4cAISUfABFyFHrK/p1thEILVc9ELAvYH8/LnX+++c68Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686297; c=relaxed/simple;
	bh=9KWTLb2GFpqdF3ql6I6u+kNUpw+pjCe7VUcpjHsi9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUiML1MnwCL1ECA+5hXtomq7s0D966LDjYfq8SOL1Rrb3M9N/1p9p9SSwv1Nn+CU5mSXPevrqeK4FplJv7CDw7A8r2Jn10aK7GAUfC/UOmKafopddBY08rn6Dvm5pl1Rs6nQpexTwDbc974W1EzqsMErFHVume5AkwndcXabuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNHeecP4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed0938cd1dso3780568b3a.2;
        Tue, 09 Apr 2024 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712686295; x=1713291095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GkJ97XaOIzqTQv4Ch+TrALRjE0+uTTo/4gkFSTSGB0U=;
        b=YNHeecP4ibHlpniBMLqp6u7Dc3GcN2sTcof/EPBGXpXwbu+qGEYAtwe4R1J2+heUkC
         ERjGtb6sobwYQZOW3FmH92L3hWjR+X+5SaDEPLOkkyRpZcgin9DgNMiyHl/gaWrw1EDg
         FqnZ1WTDVZD6Z78nHmrsZPWj/UhDNGScOJq8yqPYSaQvO/D5NDOnwCZk2PrzROMqlp5c
         tb0J542zvrYm0TFUO/fBSTvgP7EZAMNjKccS4Js5UytEDZFC5YBvNUbS4j6ufl56PYEx
         xyTW84Ou4VF3M8v7BU0kE38RzML5SvbsSy4WRUSxk8uXgEGDE85Q+XHz6PjT0o0SH3nV
         rIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712686295; x=1713291095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkJ97XaOIzqTQv4Ch+TrALRjE0+uTTo/4gkFSTSGB0U=;
        b=p7DKVwuWqP8dUxkRaupJGo5NgM1F/TLJ+n/5xbenZBIctFKB8ru/9vl4mEjNwLAU5Q
         Ltu7KLV48pMX7mWgYZik6ii2oaks0lmvxL7WeZoOZZ2qUI3ap3JeiKogc9MEOfcqeZhQ
         0n+X8Tu22/ArrxgjqlFywCvqNpeY8WgNJE/BmqgnPigjeyehetCh+UW63KxBSwhKkA+X
         hGQmGelmD2XRhKfHdCyUGAjdrX8Ms8AttNasAwFGYZkj2zrgLJhyoShGzim279kFX+el
         +d3/4EprVkiblNYYmx8zb+M7+5mE8HtnzeNFML1xstet9ijuXwby2yTBeuEjS/JUvvpY
         Lomw==
X-Forwarded-Encrypted: i=1; AJvYcCXzkRed17XKtnLqc4Rwfj66ErIIzkWU8FR6Legh35nArVARR0r1X8otBvcEthGFXFZpKCYZg3TiAG4QwONXtXk5pmXQMr0Q2Yhd6E59Nq8y7GE47jSoCdHIxQPYk79NkSg5e4L9jKoFHCPzUFngWfLrQgBE/OzUT00C9dRZbmVgGJe5mA==
X-Gm-Message-State: AOJu0YxmEwy33VN1z9JY4iO0wGdJlqUVo/CxOruqkqrp6S/poG5dc8cp
	LeAaxGfeQb4SKX4Fw0eLYd9S4iow1ewBEyDPgI+4z5z1Ou8Giu/j
X-Google-Smtp-Source: AGHT+IHtZyM5SIPVSZgn5CW1FvoL+u4dKsDjWNZ0XK+eO/w4fX3IwbRyEhCXI7kRkyf+BeGb5JTfPg==
X-Received: by 2002:a05:6a21:8804:b0:1a7:4b33:7c6f with SMTP id ta4-20020a056a21880400b001a74b337c6fmr756154pzc.43.1712686294809;
        Tue, 09 Apr 2024 11:11:34 -0700 (PDT)
Received: from localhost ([2804:30c:1618:ed00:d152:440c:102b:144e])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902e2d100b001dddcfca329sm9188461plc.148.2024.04.09.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:11:34 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:12:10 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for AD4000
Message-ID: <ZhWE-hQkRZ4JcJA6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
 <1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
 <CAMknhBEMDg3YF5pvoKJ-6y0Y5OJpmBthWfogCjy90B=F84SvzA@mail.gmail.com>
 <ZhVoTi2amNTOJ4eS@debian-BULLSEYE-live-builder-AMD64>
 <CAMknhBGVkv9sP0pjmmdFngKmGVu+G4Y3MUDG199az1wOUtwasw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBGVkv9sP0pjmmdFngKmGVu+G4Y3MUDG199az1wOUtwasw@mail.gmail.com>

On 04/09, David Lechner wrote:
> On Tue, Apr 9, 2024 at 11:09 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > On 04/08, David Lechner wrote:
> > > On Mon, Apr 8, 2024 at 9:32 AM Marcelo Schmitt
> > > <marcelo.schmitt@analog.com> wrote:
> > > >
> 
..
> 
> 
> > > > +static void ad4000_config(struct ad4000_state *st)
> > > > +{
> > > > +       unsigned int reg_val;
> > > > +       int ret;
> > > > +
> > > > +       reg_val = FIELD_PREP(AD4000_TURBO, 1);
> > >
> > > Since the driver in it's current state can get anywhere near the max
> > > sample rate of ~1MSPS, I don't think it makes sense to enable turbo at
> > > this point.
> > >
> >
> > This is just enabling turbo at start up. If not enabling turbo during probe,
> > we would want(need?) to provide some interface for that, which might not be
> > much desired.
> >
> 
> TURBO is only needed to achieve the max sample rate of 500k/1M/2MSPS
> on the various chips by skipping powering down some circuitry between
> samples. We can't get anywhere close to that in Linux without some
> sort of SPI offloading. So, for now, we might as well leave it
> disabled and save some power.
> 

Humm, ad4000 datasheets don't really mention power usage differences for turbo
mode like ad7944 datasheet do. Though, they should be similar.
Yeah, will leave turbo disabled until providing offload support.

> 
> > > > +
> > > > +       st->pin_gain = AD4000_1_GAIN;
> > > > +       if (device_property_present(&spi->dev, "adi,gain-milli")) {
> > > > +               u32 val;
> > >
> > > Should it be an error if adi,gain-milli is set on non-adaq chips?
> >
> > Maybe. We should not change the scale if it's a chip that don't have the
> > amplifier in front of the ADC. I think the best handling would be to just
> > ignore adi,gain-milli if it's not an ADAQ device. Maybe better add a DT
> > constraint,
> >   - if:
> >       properties:
> >         compatible:
> >           contains:
> >             enum:
> >               - adi,adaq4001
> >               - adi,adaq4003
> >     then:
> >       properties:
> >         adi,gain-milli: false
> > ?
> 
> I think this is missing a not:, but otherwise yes this should be in
> the DT bindings.

Oops, yeap, was missing the not:.

> 
> Even with that though, I would still be helpful to readers of the
> driver to at least have a comment here pointing out that this property
> and related gain scaling only applies to ADAQ chips.

ok, will add a comment.

