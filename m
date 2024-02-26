Return-Path: <linux-kernel+bounces-81171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37A86719D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CA7292A00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F361CF8F;
	Mon, 26 Feb 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L8Qg7vKY"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693D1CD06;
	Mon, 26 Feb 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943599; cv=none; b=fksTuQDrmwC+INNemKi+n/aIXZqlrQODoFioWeDwqL9cNZIlh+KpuBZuVpMZIFo67ftauUXyBI1+QduW10IyBIbvrE4ZxLYlJxGRPXhXr5e7CwRBInu+Ia79CRSge588IjJhTb3zuRpubFGy81rjwNJd/+WdvLPczY6KPjK+CXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943599; c=relaxed/simple;
	bh=F/cLez4JXgUdWT5m3qWh2VmCrp6cfEmcDY4ObW2JlEw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eTDgZKUd6k73yoHSTHkhQlhvahPffvDHDbebkZ+ZBxHyAFKOyLfxdeZu2ZJU7VQdWesnZaoas8UsaszsN27AC0ELhFXE48n4HERxpcrh6U3mGqvexB401DU4sUL2BBX4vSYKCsYCSmHgywOO89cfHuWlcerrygdce8dDbGqRQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L8Qg7vKY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DA034000D;
	Mon, 26 Feb 2024 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708943589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQWF/v8UaHMVeCJSORx5ewLgHgdWb31Nrz6wHZlKbZw=;
	b=L8Qg7vKYuv8tZQcHZjGL5dJirEmkocAgwKqSbZ+IqNDqnGu9Ah/1AFt6WNHvDSuORtxRSt
	cQZIjUtFVlDWH3jOpiCG4wUl3NlrM0X7ppgRYpRLSgTfDskGH5ZZL16SBWU5pjs7Amznoy
	WdWD/2CXJPMHLgmWXo9IBUtoNGugU2rcIxyNtk8nvCuB8wtM5fqEdUvseFrmqD3pzhK8kk
	LCZ0RDBqKSIOmP6Q4OpvtAd+ZSMENvAEEO6qHPHYixwhZiRciUP81Ftqgf7uYJjLTZqZko
	W5WOQpELf5dp3WH7U/UCawAPOWwtswhUcpfbSw9QIsyAFQTLihGI727GXFXX+w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 11:33:06 +0100
Message-Id: <CZEXXXQDZZWB.1M5CTZAFVO4YP@bootlin.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: usb: ti,j721e-usb: drop useless
 compatible list
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Roger Quadros" <rogerq@kernel.org>, "Peter Chen" <peter.chen@kernel.org>,
 "Pawel Laszczak" <pawell@cadence.com>, "Nishanth Menon" <nm@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Kevin
 Hilman" <khilman@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>,
 <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
To: "Conor Dooley" <conor@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com>
 <20240223-clarity-variably-206b01b7276a@spud>
In-Reply-To: <20240223-clarity-variably-206b01b7276a@spud>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Conor,

On Fri Feb 23, 2024 at 7:12 PM CET, Conor Dooley wrote:
> On Fri, Feb 23, 2024 at 05:05:25PM +0100, Th=C3=A9o Lebrun wrote:
> > Compatible can be A or B, not A or B or A+B. Remove last option.
> > A=3Dti,j721e-usb and B=3Dti,am64-usb.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/=
Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > index 95ff9791baea..949f45eb45c2 100644
> > --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > @@ -11,12 +11,9 @@ maintainers:
> > =20
> >  properties:
> >    compatible:
> > -    oneOf:
> > -      - const: ti,j721e-usb
> > -      - const: ti,am64-usb
> > -      - items:
> > -          - const: ti,j721e-usb
> > -          - const: ti,am64-usb
>
> Correct, this makes no sense. The devices seem to be compatible though,
> so I would expect this to actually be:
> oneOf:
>   - const: ti,j721e-usb
>   - items:
>       - const: ti,am64-usb
>       - const: ti,j721e-usb

I need your help to grasp what that change is supposed to express? Would
you mind turning it into english sentences?

A=3Dti,j721e-usb and B=3Dti,am64-usb. My understanding of your proposal is
that a device can either be compat with A or B. But B is compatible
with A so you express it as a list of items. If B is compat with A then
A is compat with B. Does the order of items matter?

I've not applied your proposal to check for dtbs_check but I'd guess it
would throw warnings for the single existing upstream DTSI (as of
v6.8-rc6) that uses "ti,am64-usb"? See:
arch/arm64/boot/dts/ti/k3-am64-main.dtsi.

Thanks Conor!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

