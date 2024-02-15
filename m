Return-Path: <linux-kernel+bounces-66574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC313855E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485A91F236EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B058ACA;
	Thu, 15 Feb 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EyCrZ3C/"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716619A;
	Thu, 15 Feb 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990491; cv=none; b=AXgDO9lrz15bpC4MKQ84wIZHZ5/FLQyVwFg0dqLuysRGdo9DF06jS2WmRi+ymcqUEJ2gohYHQdU0xroDr6otNKVVts66uqWfoOt8YI+0AsT/X7BhaIrCw0a2DAJT1i5MiYoiJG05PJ3nGEfvGFSCHtijvDSBq8fSTAyEEnyU0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990491; c=relaxed/simple;
	bh=894k4IzvGLYefCsuMhi8wTRsrPN6gQFCK5uRv8DuonI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Hw7QhZxurtZCi0mW+U0u+lND6w4P2A02z3HM1L8PrL5vMMPFx7WnEjnFlBmM1mKI+LLLGF+ZP86WUEiE5k+NUfwIq//XJX9vuJ4jKtDkbKA2Zs8ytiw1KfKy/35eG6K9augsWqvr49gK6jRN45hBZGgQQOpf/s90D8xds1Tar7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EyCrZ3C/; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1F8940009;
	Thu, 15 Feb 2024 09:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707990481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEPfuFO02YfxxxeARiYG01SUArT6dy339HuFMRs5QuM=;
	b=EyCrZ3C/CpQ8eHec55JqJ4Om3m0T2B/VGep2yP3RprFfMeTf0cBAgywAozB3tc2DmsaN3D
	9EqtQ7yyMcN4uA02Xb/OVOHIwX9G/BiInJX527Q9RtHMznsIs8jPjEBwNljIX2q8V/X21F
	lqs4Do1z0DZjuRJopQAWvhtjJv0UNlOFlc6dkxqd9dshCDCZ0FnHJ1ZlOiEMNneOqK9lak
	zlidkhipQ5DPTZ3oHyKNJ76KXgiKDjpOkG/plvcmGsqfG/Ad7XH8wPqYqkJVG/IHf1PAD/
	9bXdPkLavVjKnIXQn5IsbLq6Q56VLf/Fn0vEREaDaNSON0RIgXiLjxNB4D7tKA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Feb 2024 10:47:58 +0100
Message-Id: <CZ5K3DSVZTAI.2TCVJ2LHGVBPC@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 01/23] dt-bindings: gpio: nomadik: convert into yaml
 format
Cc: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mips@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob
 Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-1-f88c0ccf372b@bootlin.com>
 <be4e6ded-6596-472b-a988-0909a5451a72@linaro.org>
In-Reply-To: <be4e6ded-6596-472b-a988-0909a5451a72@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 15, 2024 at 10:11 AM CET, Krzysztof Kozlowski wrote:
> On 14/02/2024 17:23, Th=C3=A9o Lebrun wrote:
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  gpio-controller: true
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 2
> > +
> > +  gpio-bank:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Missing description, unless it is a common property (but then where do I
> find it?).

Missing indeed. Will become:

  gpio-bank:
    description: System-wide GPIO bank index.
    $ref: /schemas/types.yaml#/definitions/uint32

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

