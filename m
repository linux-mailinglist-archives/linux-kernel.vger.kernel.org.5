Return-Path: <linux-kernel+bounces-95769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241287524A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642811C22D87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E912CDB6;
	Thu,  7 Mar 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i8djEudV"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CC5B1FD;
	Thu,  7 Mar 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823026; cv=none; b=APvAgHFjlWyDNCU4ib8UEj2j9D4ysFBTxG/ed3OWRZIfGSNlJExM9cW7c17pnqGzJzvhfJ77Vi4RhXOCFamSqjPJW/6JwJoz1fC/6uyni30fbKAgsV2PDt5EEWDKb/L5V2XK6Ew3BNzHr/Qw6hAhvprDR8s4I2DjmjelguZnFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823026; c=relaxed/simple;
	bh=bMgcq8RI+0U/9suH2RY7GnPRGcioM+SwL8B1CFmqRKI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=WAVBL5r1Gf4hcMiZr/94v0v9dzBqN/WRox3NW0z7TYY84D3yQ7tp0yWNUnn1wEN7wyjlFFY0SqkUdQqskJhHBG0CwCmgF4K86fkbu1pLIJgtO9CLHsLOXQWiR0++fPs0SuHTY6SCpj3oVq7gSDO9GE1o1aorqb02pNHHyYhZLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i8djEudV; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80720E000E;
	Thu,  7 Mar 2024 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709823022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Np8Esugsr9ZGR7h4Wh+XY5vmJlU7fOGNOduAjb30l0=;
	b=i8djEudVbUI2ZCGYHvGBtxY00fhEPP/loSQiIlYzcojCGeisT56oYNXXRffq8XtzR/cMoB
	fPzYUv64iAnrQyLRhVWIpHHVq9nlmg/ubisuFkgTzmnbCm+xuRjPwrb+5Lnl+gV7gIP9Ne
	E7w7p0jqTFsxRna6XOm6NG0khpDFjY7ehRu7VgHIIy4CleCY652a0Z8n8GOouf7rfU0yKF
	uRfSaxBxrQKTnZfldzs3GTZM3jLFFC4mPXBgH970EYSifusoqpWTgiAZbI7aRlWhVTtx3o
	QCQZX0aCv7cCE3iv/Kq362a9icYAN1tIEXJAE+CVOfDwnZg0RYWDtkbsoknnRA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 15:50:21 +0100
Message-Id: <CZNLOCAIE6P7.1BJ23DWJPCSHS@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 2/9] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Roger Quadros" <rogerq@kernel.org>, "Peter Chen" <peter.chen@kernel.org>,
 "Pawel Laszczak" <pawell@cadence.com>, "Nishanth Menon" <nm@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Kevin
 Hilman" <khilman@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>,
 <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
To: "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-2-5ec7615431f3@bootlin.com>
 <20240307142159.GA2542409-robh@kernel.org>
In-Reply-To: <20240307142159.GA2542409-robh@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Rob,

On Thu Mar 7, 2024 at 3:21 PM CET, Rob Herring wrote:
> On Thu, Mar 07, 2024 at 10:55:03AM +0100, Th=C3=A9o Lebrun wrote:
> > On J7200, the controller & its wrapper are reset on resume. It has the
> > same behavior as ti,j721e-usb with a different SoC integration.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/=
Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > index 653a89586f4e..e8f7e7511483 100644
> > --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > @@ -16,6 +16,9 @@ properties:
> >        - items:
> >            - const: ti,am64-usb
> >            - const: ti,j721e-usb
> > +      - items:
> > +          - const: ti,j7200-usb
> > +          - const: ti,j721e-usb
>
> Combine this with the previous entry:
>
> items:
>   - enum:
>       - ti,am64-usb
>       - ti,j7200-usb
>   - const: ti,j721e-usb

Makes sense, will do. Full block will become:

	properties:
	  compatible:
	    oneOf:
	      - const: ti,j721e-usb
	      - items:
	          - enum:
	              - const: ti,am64-usb
	              - const: ti,j7200-usb
	          - const: ti,j721e-usb

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


