Return-Path: <linux-kernel+bounces-82416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D08683E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12336289605
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7911F135415;
	Mon, 26 Feb 2024 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IqyDBwGf"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8F1E878;
	Mon, 26 Feb 2024 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987339; cv=none; b=Z0xTRkgyJJZER1ha4ZYqjDFxscI/ycVK0cnvX1gWE6386YA/uA6Xw6sDm1SFnTMEZ99EQ9sOAjpSLCwWtziKubEI1TgVw5P6at3JL7vQSfilgxW4Ym3trY/+zjaG/T3lM1cJiY5JdA2vwxHM4TozxHpM13rZKxXsp/DoeD7x9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987339; c=relaxed/simple;
	bh=V6ouCeVitevxOHsKiWCOL79474b7/h1XP8STN7igoe4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EeSeJnKfbyZawo095VE5DUpekTGPUjn1EVZiEuOrpD1mLfzSOQK+lwoIgjqRG7xuDyJTlydJFf92yNrt9cc4AG3X1Qza50LdHblOnrBQ/LNZcaIAbSn+nOM/OcS9rAZ+gUMVTiaoxvsrobRaaIVgkJbLqopjy7y1+2pADaSYaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IqyDBwGf; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-168-240.adl-adc-lon-bras34.tpg.internode.on.net [118.210.168.240])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C4A1320127;
	Tue, 27 Feb 2024 06:42:14 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708987335;
	bh=/qvMBMrVFDTYVqfc8l6H/h1iuLNhCL0RUCd1VIFMYVM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IqyDBwGfwh2HZob3GYo5SUtNf44rqoQBZVTxs3qvSfCXE6SELc4Y7oUddjXEyIRhG
	 uid4MOhriFaEXq+ig+lDlMtlbRVk0+mH/Hy1aW/xOgigMlQZS1tbcUqxMaPDMjtqoq
	 mCH7e3Pk++aa18POkxcjzVS8cFKWrEt7O3eV8h5mxe775BVVuRCDgHmIACJSqmuYa+
	 uMJ/OYGY8fGwHCMSF9BfRKxPiNDJMpSrNmalISJZGAyzKiUbwv0Id41IEXE9hidPdR
	 NWKL+CSAmH4jbaxJQWrzDWqOtui4RBoJOJgA0z9xJ2JAhBl28gb5j9Btu+eF0ok2vO
	 o7qEemSchbX/g==
Message-ID: <cd7806bf4ae8818697b1eba47b380c82a919ecc5.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linus.walleij@linaro.org, brgl@bgdev.pl, krzysztof.kozlowski+dt@linaro.org
Cc: robh+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 27 Feb 2024 09:12:10 +1030
In-Reply-To: <458becdb-fb1e-4808-87b6-3037ec945647@linaro.org>
References: <20240226051645.414935-1-andrew@codeconstruct.com.au>
	 <458becdb-fb1e-4808-87b6-3037ec945647@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-26 at 08:08 +0100, Krzysztof Kozlowski wrote:
> On 26/02/2024 06:16, Andrew Jeffery wrote:
> > Squash warnings such as:
> >=20
> > ```
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e=
600000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,=
ast2400-gpio']
> > ```
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> ...
>=20
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: The clock to use for debounce timings
> > +
> > +  gpio-controller: true
> > +  gpio-line-names: true
>=20
> min/maxItems

Ack.

>=20
> > +  gpio-ranges: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 2
> > +
> > +  ngpios: true
>=20
> Where are the constraints I asked? minimum, maximum.

Sorry. Thanks for clarifying. I'll address that in v4.

Andrew


