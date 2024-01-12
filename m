Return-Path: <linux-kernel+bounces-24378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C83782BBC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB5B1F24A75
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B665D726;
	Fri, 12 Jan 2024 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwxYMJe2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C6381B7;
	Fri, 12 Jan 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50ea98440a7so6375929e87.1;
        Thu, 11 Jan 2024 23:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705044402; x=1705649202; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gneEqmMOyK7inkwh49BJcAK3SqDSE1D3WmwtdjW5DGM=;
        b=FwxYMJe2jvIjT5v2l40f5TAFUG8U+Ri2TSy/cryOS24jFtb5fWEBh7HIw4KbWbO75M
         a1rxMaDG5MIAlinMxO5JInRjSch4HZiOn15IsuwWEZUGem45zLiq2krRRY9F9nCT7m+A
         HIS3hg/qckJRH/lLm4iNgxi6jyM7vNDIEL9nVSesRzSVBQw9+NpCS4NLY5oBDSVRD6cj
         cmpF/ZQpVDpWEN2rO04GuFPlgpRMGWj6+CZpw/odL7TFgjSoYnGZM2kWE5BHu/bYcK/T
         kBZJ8Qgdcp7Zn6cXecYqx7ebybCwqLQX2sNQe4W0RZC0hASMkMqlH5vHEDvJ6Lbflo8a
         2DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705044402; x=1705649202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gneEqmMOyK7inkwh49BJcAK3SqDSE1D3WmwtdjW5DGM=;
        b=YHEluoI3kM9QAe8NqKPWcMXYhqivhY4BYhLu5bG5H05h3sXIKQZpDdMK3+socHtaOy
         n2Ja72aJZs5Obc1JpWVF+D49rXi7pza+i726oxUXPWyoMb2BhCL4bmzm71WmhIuTbOFE
         Fs84ftdw34Vt2Efhpk4Ead1aYugrdoI0XmRAJDH1xZGqrIm8LFaHbIPiwIgyoEbszEFO
         ynbuOA4toJaQnF2fS1k/MRw9wyxWIuNdGmqvrTRXDpYXnYzKysB/tjJVHdYmU98nVNe2
         qBlL3fdtH1YZ4ldLlMoL6xeom3d3DI9WdNihbptNd4IV2Bz+uzvQwPTNnGpQJYXdVSkx
         yM5g==
X-Gm-Message-State: AOJu0YwxxeN19Goxtubylf/cGL8k0h/rEpwDFxCOxsoaOVmRCn3Aql3p
	DuT0wdunKGACiFXtb+MjpSU=
X-Google-Smtp-Source: AGHT+IGy+3PkDT9BlN+tYjnahAUimYtM7/rxEeJyqJ+bvuIygrRVut+yaLiioJGco4zZFrsehQqsLw==
X-Received: by 2002:ac2:5921:0:b0:50e:a9f0:4a88 with SMTP id v1-20020ac25921000000b0050ea9f04a88mr204155lfi.91.1705044401301;
        Thu, 11 Jan 2024 23:26:41 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id cd6-20020a170906b34600b00a2c8e9918casm924387ejb.198.2024.01.11.23.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 23:26:40 -0800 (PST)
Message-ID: <fbe07c5f1d37febe0b89bf73816bc2e5d219547f.camel@gmail.com>
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
Date: Fri, 12 Jan 2024 08:26:40 +0100
In-Reply-To: <ee19aa9e-cb51-41fb-a980-e3df579b5d35@sirena.org.uk>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
	 <0c0b1954825dc174cab48060e96ddadadc18aefd.camel@gmail.com>
	 <aae36622-4e05-4f16-9460-d7614fd599aa@sirena.org.uk>
	 <5b62d742fa789e9860781b6f5f1fda4f583b0e5b.camel@gmail.com>
	 <ee19aa9e-cb51-41fb-a980-e3df579b5d35@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-11 at 15:41 +0000, Mark Brown wrote:
> On Thu, Jan 11, 2024 at 03:11:32PM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2024-01-11 at 13:33 +0000, Mark Brown wrote:
>=20
> > > I tend to agree that we shouldn't be exposing this to SPI device driv=
ers
> > > however we will want to keep track of if the unit is busy, and design=
ing
> > > it to cope with multiple offloads does seem like sensible future
> > > proofing.=C2=A0 There's also the possibility that one engine might be=
 able to
>=20
> > Fair enough. But wouldn't a simple DT integer property (handled by the =
spi core)
> > to identify the offload index be easier for SPI device drivers? We coul=
d still
> > have dedicated interfaces for checking if the unit is busy or not... Th=
e point
> > is that we would not need an explicit get() from SPI drivers.
>=20
> It feels like we'd need a get/release operation of some kind for mutual
> exclusion, it's not just the discovery it's also figuring out if the
> hardware is in use at a given moment.
>=20

Hmm did not thought about the busy case. Still, I could see this being easi=
ly done on
the controller driver (at least until we have a clear idea if this is usefu=
l or if it
will attract more users) or even at the spi core on the prepare + unprepare
interfaces. A flag could be enough to return EBUSY if someone is already in=
 the
process of preparing + enabling the engine.=C2=A0

Bah, anyways, it's just I'm really not thrilled about that kind of interfac=
e in here
but yeah, as long as you think it's worth it...
>=20

- Nuno S=C3=A1

