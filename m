Return-Path: <linux-kernel+bounces-23698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4817C82B051
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA1D28490E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647473C48D;
	Thu, 11 Jan 2024 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+oqQ9qM"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FE3B187;
	Thu, 11 Jan 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a29a4f610b1so579799966b.3;
        Thu, 11 Jan 2024 06:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704982101; x=1705586901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WoJC8tdnDZuFg5WsFgtASovnc1Tl99lnT/+ICbRlVwA=;
        b=G+oqQ9qMsSnvIG2xsqqlMDBNGN7bdvOXAudCaiFcF3RpwRSoxNq57VZbT679SZpcwR
         mQv+YkKVIUqDbVaE8jtHv9n/4PHgC41jMsf0wCoGVMeo2ct2W0n2vjr9EM009tMmnIwx
         +h+Z9FEu4BTwuGnUfHtsNPL+ZED5QhH+44yoTObj9tw2ypKQnAS5upt0OInlEbqwPEqP
         GE3NR1H8yVgVwcw0MCG+XlPOGHD6FyenNZe91OPM9dWIXA6nkf+rSTAd6VuSu2y+ntjG
         W98YktW1L4PcwcX0nk0Afl/n8IShAeeR2RHALiMAKMnCS0vsFTHCRIooIgSzN+xcLwf+
         gsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704982101; x=1705586901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoJC8tdnDZuFg5WsFgtASovnc1Tl99lnT/+ICbRlVwA=;
        b=Kqjem/diqyHz2gSf7TRvAoAgbs4eJ7uNtxqT0l9oNpFXtppZe+VlRAoDc1r9iVAgRw
         gpm95X8PPacIUTN87MwhVOS/fo/9qTFrM1BAbePd9YRw5j7ECZXujNVJim2nDLh5EN/G
         BSwsTXQ/qOVCFJK319bAq4IasgGki+kQrmeB2GjPhPlLzQ79zelNwHt3dWNLACDzTK9y
         dJ07MHiRHWlwZ4kCWSRX87BR4nnglBG5V+a4JecAAN+U5R5WBnmNF0L+OPptiuA/lioy
         T5Bt5k4BQcMay9I8c8aVV+EFYdA+Yy++swWnSx7b4P0+VkioXRSaK/TVjXGygIMuBsZ+
         89Uw==
X-Gm-Message-State: AOJu0Yyq8Y0FQmdpv6HcL7dVxzS1aC39CnmABkeykkLUzB3QA4IeAmvf
	u1Z260p8U4dnZ6m/7hwbpb0=
X-Google-Smtp-Source: AGHT+IEFa0SyyLPtJIEyD1MDs+PWNcn+s3GPOMBXhDIA1k2L4TV8ak6uzCy/6bBxHMPtd2QnR9l+OQ==
X-Received: by 2002:a17:906:c08c:b0:a28:bf58:756d with SMTP id f12-20020a170906c08c00b00a28bf58756dmr554052ejz.128.1704982101155;
        Thu, 11 Jan 2024 06:08:21 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id ov18-20020a170906fc1200b00a2a184687dasm618425ejb.31.2024.01.11.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:08:20 -0800 (PST)
Message-ID: <5b62d742fa789e9860781b6f5f1fda4f583b0e5b.camel@gmail.com>
Subject: Re: [PATCH 01/13] spi: add core support for controllers with
 offload capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,  Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand
 <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>,  linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2024 15:11:32 +0100
In-Reply-To: <aae36622-4e05-4f16-9460-d7614fd599aa@sirena.org.uk>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
	 <0c0b1954825dc174cab48060e96ddadadc18aefd.camel@gmail.com>
	 <aae36622-4e05-4f16-9460-d7614fd599aa@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-11 at 13:33 +0000, Mark Brown wrote:
> On Thu, Jan 11, 2024 at 09:49:08AM +0100, Nuno S=C3=A1 wrote:
> > On Wed, 2024-01-10 at 13:49 -0600, David Lechner wrote:
>=20
> > > =C2=A0=C2=A0=C2=A0 /* in probe() */
> > > =C2=A0=C2=A0=C2=A0 offload =3D spi_offload_get(spi, 0);
>=20
> > On top of what Mark already stated, and as we already discussed offline=
, I
> > personally don't like this provider - consumer interface for the offloa=
d.
> > The
> > first thing is that this is taking into account the possibility of havi=
ng
> > multiple offload cores. While the FGPA core was designed with that in m=
ind,
> > we
> > don't really have any design using multiple offloads in one spi engine
> > (always
> > one). Hence this is all pretty much untested.
>=20
> I tend to agree that we shouldn't be exposing this to SPI device drivers
> however we will want to keep track of if the unit is busy, and designing
> it to cope with multiple offloads does seem like sensible future
> proofing.=C2=A0 There's also the possibility that one engine might be abl=
e to

Fair enough. But wouldn't a simple DT integer property (handled by the spi =
core)
to identify the offload index be easier for SPI device drivers? We could st=
ill
have dedicated interfaces for checking if the unit is busy or not... The po=
int
is that we would not need an explicit get() from SPI drivers.

I'm of course assuming that one spi device can only be connected to one eng=
ine
which seems reasonable to me.

- Nuno S=C3=A1


