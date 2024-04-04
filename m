Return-Path: <linux-kernel+bounces-130781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E99897D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD88E1C2776C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087128FA;
	Thu,  4 Apr 2024 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KMKihofe"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844A184D;
	Thu,  4 Apr 2024 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190436; cv=none; b=h5klxbAfaSpz0zndZiGa5BdKfaw8A92wbc0SP2nbjcI6JOXZyHIrEdtnY36XPlQveI+PszcSJXNLqblW/HtVOMDmlz/uAQesGmexkYtc06aDcrCwMcwwZGpRDGGqYs2xoz+Dzy8DyjAQTmGSlPrCRNnKaBaqB0f5NZLo3yQvGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190436; c=relaxed/simple;
	bh=v/vIa/rR8iRyMy4mIpAf1wWxqzwbq+JhVF4Y2ktEIAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YW5JHVlJ7866pl79e5/cnAcEQrcQPOskDkCnx989SOJNsPVUBpmc+bvnnbSvHZTtN8QBjSjK1Ldj8kFeKVhDpKFrz2gO9zfQ/rd/l5EoxxB1k0c8xB4b0/xZCNeLslxdPiRLaVDJ5KemHLxCS4tBOa+FX1XD4q7p1gPW9voDFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KMKihofe; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CD58320172;
	Thu,  4 Apr 2024 08:27:01 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712190426;
	bh=7XBJv5sXFllW6o2Z1qUfGGSmKeySAzOgxYx/fU65DDo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KMKihofeIwJ5nFzr9rQ6jaTGM8JkIsM88UxAya7N3V3td2wYInXkbxhN4x2bfPXnc
	 6bc4M7rVw0UfgL1YD1QunC9k4bPWoTwTPRMghNm9ELeJyAy5a9QMUgXIQ2NNuoTTpR
	 RNBzwmlKIwzeVisUPu/Sin/4XaD+G9S5+9UbnpBwldoxXicbThPk3FX/37bSTiHuMv
	 hTD+rMM5ubqiu0BIG/tRIQ08n34xFzDKtPOICO9DhZFFDQF6si5kqe9Fhbm15OJXYx
	 Jp1qcUoBGCJpXndHnXvBOnr3T5xX0ARuczw0DPLlZkYyEIKNlYNNqMZrrOiY9WGA7+
	 wtT+HTc+9+kEw==
Message-ID: <cfc735c787707298ef3e2e1f5aa6f3096326a26b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] dt-bindings: watchdog: aspeed,ast2400-wdt: Convert
 to DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
	zev@bewilderbeest.net, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Apr 2024 10:56:59 +1030
In-Reply-To: <20240403171321.GA3996007-robh@kernel.org>
References: <20240403020439.418788-1-andrew@codeconstruct.com.au>
	 <20240403171321.GA3996007-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-03 at 12:13 -0500, Rob Herring wrote:
> On Wed, Apr 03, 2024 at 12:34:39PM +1030, Andrew Jeffery wrote:
> > Squash warnings such as:
> >=20
> > ```
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e=
600000/watchdog@1e785000: failed to match any schema with compatible: ['asp=
eed,ast2400-wdt']
> > ```
> >=20
> > The schema binding additionally defines the clocks property over the
> > prose binding to align with use of the node in the DTS files.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > v2: Address feedback from Rob and Zev
> >=20
> >     - Rob: https://lore.kernel.org/linux-watchdog/20240402180718.GA3585=
05-robh@kernel.org/
> >     - Zev: https://lore.kernel.org/linux-watchdog/65722a59-2e94-4616-81=
e1-835615b0e600@hatter.bewilderbeest.net/
> >=20
> > v1: https://lore.kernel.org/linux-watchdog/20240402120118.282035-1-andr=
ew@codeconstruct.com.au/
> >=20
> >  .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 142 ++++++++++++++++++
> >  .../bindings/watchdog/aspeed-wdt.txt          |  73 ---------
> >  2 files changed, 142 insertions(+), 73 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,a=
st2400-wdt.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-w=
dt.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-=
wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.ya=
ml
> > new file mode 100644
> > index 000000000000..be78a9865584
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yam=
l
> > @@ -0,0 +1,142 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Aspeed watchdog timer controllers
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2400-wdt
> > +      - aspeed,ast2500-wdt
> > +      - aspeed,ast2600-wdt
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: >
>=20
> You don't need '>' either. I guess it is equivalent here as there are no=
=20
> double newlines. Drop these if you respin, otherwise:
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks. I've made a note for the future to avoid `>` if it's not
necessary, but at the time I figured it wasn't incorrect to include it.

Andrew

