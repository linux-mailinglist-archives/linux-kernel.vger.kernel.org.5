Return-Path: <linux-kernel+bounces-71021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D53859F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8BA2852E4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9825574;
	Mon, 19 Feb 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K9v2V8BG"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737424B2C;
	Mon, 19 Feb 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334557; cv=none; b=kSXXNztDq2mKbjlNnYdDiR1hT1CjApkCtoeF49eE4NeBKqKkggJjkEaUh8k9ERpzJP5ncZlUFqCXe56xyMVLblwVjRK7o/3XsuiNEFVamsVk0gLGxM3xHxbXmS4OrbH9WMzXHb1O2aP0CofKbMAmo3q5/1eDW/z8yazKV2+7CiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334557; c=relaxed/simple;
	bh=O7jFalGLVz0Usog+xV7IsPPtI8rqcp1f1KiCelh/c9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqEP3qvZANSHyp4IvsznAGTY1sIxJ2069MmR30ARCZrv+Ns4vy2QKceaoubwRV5kTDRYrrTQ0eTns7lk/5f8vgAxae0w3dKQiZ5bMEdu6sOy4KGMW1M5lyMJgo/qCl8fLhCMreXAoDC1Q+GlZnOqUAjBsiMhYomosOvRqp3vz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K9v2V8BG; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2556FF80E;
	Mon, 19 Feb 2024 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708334547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JJYLuBCOkfxTLbeT5DlIS6vVhI3AplaZr0S39SVoLc=;
	b=K9v2V8BG3QduFJ0e3Uw3dCtS9hM2bn/TYvENJcI7ht1ALNz0gLx5AxCXxWAKxhNj7hM5PO
	oFYsmddOq2qMVvTVgYIvnxHNxsy3I8G8OP+RaE337z4+ZbzrewUncvEBxjWUripbHcQplu
	Zxo5UAcb2it3IpFrK7mV1iIzT2BrobYtXzO9D51ygVCFDbLOzCAL4Tfx3SrYATP4AV0Cvi
	gvy4kDc/h6C3WMaasXvUsKtCG2EdgAe67CUs/dHViLh6G7azIWAy+wY9OsPQ8vwRoEPEMg
	vqbX3QBQLvmttqzE1lAmhOB48zl4Uc37NX6No0Z4ZXx0zTU7Op+IsZDS5TDCZA==
Date: Mon, 19 Feb 2024 10:22:24 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240219102224.50cf1010@kmaincent-XPS-13-7390>
In-Reply-To: <0d7b5549-f56b-4693-878f-e513fbf5ca16@linaro.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
	<0d7b5549-f56b-4693-878f-e513fbf5ca16@linaro.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 17 Feb 2024 15:01:55 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> > -required:
> > -  - "#pse-cells"
> > +  pse_pis: =20
>=20
> How did this appear here? Underscores are no allowed.

Didn't know that, sorry.
Indeed it is written in the dts-coding-style.rst, sorry for the error.

>=20
> > +    type: object =20
>=20
>=20
> Missing description.

Ah indeed.

> > +            items:
> > +              enum:
> > +                - "alternative-a"
> > +                - "alternative-b" =20
>=20
> No need for quotes.

Yes I saw that warning with yamllint up to date and have fixed it with for =
the
next version.

> I believe you did not test it, so I will skip reviewing the rest.

I tested it and did not face any error due to the underscore with
"make DT_CHECKER_FLAGS=3D-m dt_binding_check DT_SCHEMA_FILES=3Dpse-controll=
er.yaml"
Did I miss something in the test options?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

