Return-Path: <linux-kernel+bounces-82666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818368687FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E231C21BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2324D9E0;
	Tue, 27 Feb 2024 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="SLojqN+/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53368364AA;
	Tue, 27 Feb 2024 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005627; cv=none; b=BulhQAqe8HaoaM8elVDs015WiYng8O82hUq/pfqe0aOkuitZyI/fUSCSZkl9QcuRm2E6UpK6anLPBzK3bi2JpeAgi+AfNnqb3DoBW6znVscVuW5OuBQ5dPVq5MFClXB9/Z6o7JxSJmpQMDQ55VAR3teVmgvxO2q+eCsDoL/gijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005627; c=relaxed/simple;
	bh=9PDAW0eupiQTDhxoCgq59t3bx65eDmuHAmAkY3TSYHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvy24Mxk+98O0ofuJtO9Iu+fSunv6hv7b3g64Pg2wOlQfyenFKXgGwLIJQPbRBC1l/7BpNs+qdDIczhaMQ1n5zkYdrEvkq6uQJT/lw4QJoAZ7GdTf5l3F5FknPmS/MlmZksKuOmMkdkALuxnLyWlNS8lJqF/DRJhq6a6hEGL0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=SLojqN+/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-70-176.adl-apt-pir-bras31.tpg.internode.on.net [14.2.70.176])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1F7E620127;
	Tue, 27 Feb 2024 11:46:54 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1709005617;
	bh=Yx/R5fkt8EGERdv8FabE1EE9SthXf954n/R2MAjuQug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SLojqN+/JevAlu0Fbb/O2ZDM2UC6gVtUYhFOtFS50KZ55S2YJvcZ3Fyu5JIMEMNAt
	 krhAMKqpde2iCUr93+zS/rotpd+iATzMCeiMkNUniNpEABmz19L8a75JF1xVdVOrwI
	 4irKXA2cA6oky5Ae82dPvP1bNRH/cx4El7tWU/BAWwQHKoCoMJ476xP4sW0B4oPGhw
	 ehHH7S5FX2xaqKODU/bZwV1scCiz/nD2N4EgKrX6ahrvje8KB1oG8M92V8wmqs18Ok
	 w8NHtk/60S1wXPhpYB73yBtsiTdAv4d+WNW1J/6AkcYLG6pgRdWaclHqnJIZKIxuwQ
	 KVOH2REL0/CDw==
Message-ID: <b69298f73d4d51546402410b45963f137d3e3c98.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
	linux-aspeed@lists.ozlabs.org, brgl@bgdev.pl, 
	linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, conor+dt@kernel.org
Date: Tue, 27 Feb 2024 14:16:52 +1030
In-Reply-To: <20240227034047.GA2644802-robh@kernel.org>
References: <20240227004414.841391-1-andrew@codeconstruct.com.au>
	 <170900020204.2360855.790404478830111761.robh@kernel.org>
	 <20240227034047.GA2644802-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-26 at 21:40 -0600, Rob Herring wrote:
> On Mon, Feb 26, 2024 at 08:16:43PM -0600, Rob Herring wrote:
> >=20
> > On Tue, 27 Feb 2024 11:14:14 +1030, Andrew Jeffery wrote:
> > > Squash warnings such as:
> > >=20
> > > ```
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@=
1e600000/gpio@1e780000: failed to match any schema with compatible: ['aspee=
d,ast2400-gpio']
> > > ```
> > >=20
> > > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > ---
> > > v4: Add constraints for gpio-line-names, ngpios as requested by Krzys=
ztof:
> > >     https://lore.kernel.org/all/458becdb-fb1e-4808-87b6-3037ec945647@=
linaro.org/
> > >=20
> > >     Add more examples to exercise constraints.
> > >=20
> > > v3: https://lore.kernel.org/all/20240226051645.414935-1-andrew@codeco=
nstruct.com.au/
> > >=20
> > >     Base on v6.8-rc6, fix yamllint warning
> > >=20
> > >     Rob's bot picked the missing `#interrupt-cells` in the example on=
 v2[1]. The
> > >     patch was based on v6.8-rc1, and going back over my shell history=
 I missed
> > >     the following output from `make dt_binding_check`:
> > >=20
> > >     ```
> > >     ...
> > >       LINT    Documentation/devicetree/bindings
> > >       usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--l=
ist-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings=
] [-v] [FILE_OR_DIR ...]
> > >       yamllint: error: one of the arguments FILE_OR_DIR - is required
> > >     ...
> > >     ```
> > >=20
> > >     I've rebased on v6.8-rc6 and no-longer see the issue with the inv=
ocation
> > >     of `yamllint`.
> > >=20
> > > [1]: https://lore.kernel.org/all/170892197611.2260479.153435625635539=
59436.robh@kernel.org/
> > >=20
> > > v2: https://lore.kernel.org/all/20240226031951.284847-1-andrew@codeco=
nstruct.com.au/
> > >=20
> > >     Address feedback from Krzysztof:
> > >     https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@=
linaro.org/
> > >=20
> > > v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeco=
nstruct.com.au/
> > >=20
> > >  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 149 ++++++++++++++++=
++
> > >  .../devicetree/bindings/gpio/gpio-aspeed.txt  |  39 -----
> > >  2 files changed, 149 insertions(+), 39 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast=
2400-gpio.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspee=
d.txt
> > >=20
> >=20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > In file included from Documentation/devicetree/bindings/gpio/aspeed,ast=
2400-gpio.example.dts:91:
> > ./scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:14: wa=
rning: "ASPEED_CLK_GATE_LCLK" redefined
> >    14 | #define ASPEED_CLK_GATE_LCLK            6
>=20
> The examples aren't isolated from each other, so you can't have=20
> conflicting includes. You'll have to drop some of the examples or drop=
=20
> their use of the conflicting include.

Thanks. I've reworked the patch to avoid use of the conflicting
includes. I'm also sorting myself out to avoid repeating the process
flaw of failing to run `make dt_binding_check` on the patch I ended up
sending.

Andrew


