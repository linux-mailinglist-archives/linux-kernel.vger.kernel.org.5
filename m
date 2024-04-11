Return-Path: <linux-kernel+bounces-140594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B58A16A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DE1C20C74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC8A14EC6C;
	Thu, 11 Apr 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dW6gxsCV"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556614EC6A;
	Thu, 11 Apr 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844282; cv=none; b=MBMbe5BD03nKMEsRxXFXUnW2cjAHvuMT0mvoOEOvbWKewVxmlW7d9Y4mbNUBxHEt7/UwY7r7RwMXiAREx0e/Puey0SYKD4soUvnc4rYDp8NA9aToSPmY6j6ZTD4gzOVJBXorkm34bfhv5Dj26Tx7AcRar/CpFY63h6zLbR2GWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844282; c=relaxed/simple;
	bh=ZrCt6oej6WWRtK9ajy4DESiiMvZN55Rd82Z7cAO61lE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=u+KgXPEieQ3WCmSiDLMfKLZFDyc7YYoqIWsr7VZAPgtJgFCv/CxS/YFnP7iT+j7nAxM/2pX9LOHqcY1jHnsdc6T4ev//9MmsN+AuaD7TJfyo+yJv4v2bfo/lUjjTS6oh0UR+CJKGPWGEOZ9BrhCe+JfJxifO7NGeSbZDR2U7Dz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dW6gxsCV; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 923E7C0008;
	Thu, 11 Apr 2024 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712844277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHMOCEThioFNBRb0/pbHA6siONYSvI8bftJSI3SDdxw=;
	b=dW6gxsCVgdghqn/IQbcGvOrg1mwarJk5nvxU2EHuog49c2PESSCXprtlxzegLMubTQWTll
	ob7G/iNruURS6u6995ukRb7IuuEDM+JwqApqib94ioelO8Q01YlC4cK+J1K9MOQolSPRRw
	3nBIHdL0PD0DQyx9r2Gckk9WbK+dX5wRN/h54M2U0K/V5BxtTqZzyzKXsOQbOmuC7Ezwr6
	xwpVw7nK3o/VUhABP2sr4Pb0b3DYlCqAXYwyWUDaSgAh4fHhEAZdfIuD5OqTAO/2TVdRGV
	8LO4Vqf2fDiQLDyx44laxhlTBWi7vcFAKRsxNMTdvEhwPcFDTIZVPLUNzael8g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 16:04:36 +0200
Message-Id: <D0HCMDMWTO61.1F860N5I5SKS3@bootlin.com>
Cc: <linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Linus
 Walleij" <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 03/11] dt-bindings: reset: mobileye,eyeq5-reset: add
 EyeQ6L and EyeQ6H
X-Mailer: aerc 0.15.2
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-3-335e496d7be3@bootlin.com>
 <975a8554-a299-4394-be15-c910cf9688ae@linaro.org>
In-Reply-To: <975a8554-a299-4394-be15-c910cf9688ae@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Apr 11, 2024 at 8:14 AM CEST, Krzysztof Kozlowski wrote:
> On 10/04/2024 19:12, Th=C3=A9o Lebrun wrote:
> > Add bindings for EyeQ6L and EyeQ6H reset controllers.
> >=20
> > Some controllers host a single domain, meaning a single cell is enough.
> > We do not enforce reg-names for such nodes.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/reset/mobileye,eyeq5-reset.yaml       | 88 ++++++++++++++=
++++----
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 74 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-res=
et.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
> > index 062b4518347b..799bcf15bed9 100644
> > --- a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
> > +++ b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
> > @@ -4,11 +4,13 @@
> >  $id: http://devicetree.org/schemas/reset/mobileye,eyeq5-reset.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > =20
> > -title: Mobileye EyeQ5 reset controller
> > +title: Mobileye EyeQ reset controller
> > =20
> >  description:
> > -  The EyeQ5 reset driver handles three reset domains. Its registers li=
ve in a
> > -  shared region called OLB.
> > +  EyeQ reset controller handles one or more reset domains. They live i=
n shared
> > +  regions called OLB. EyeQ5 and EyeQ6L host one OLB each, each with on=
e reset
> > +  instance. EyeQ6H hosts 7 OLB regions; three of those (west, east,
> > +  accelerator) host reset controllers. West and east are duplicates.
> > =20
> >  maintainers:
> >    - Gr=C3=A9gory Clement <gregory.clement@bootlin.com>
> > @@ -17,27 +19,83 @@ maintainers:
> > =20
> >  properties:
> >    compatible:
> > -    const: mobileye,eyeq5-reset
> > +    enum:
> > +      - mobileye,eyeq5-reset
> > +      - mobileye,eyeq6l-reset
> > +      - mobileye,eyeq6h-we-reset
> > +      - mobileye,eyeq6h-acc-reset
> > =20
> > -  reg:
> > -    maxItems: 3
> > +  reg: true
>
> Same mistakes. Please open existing bindings with multiple variants,
> e.g. some Qualcomm, and take a look how it is done there.

Thanks for the pointer to good example, that is useful! So if we take
one random binding matching
Documentation/devicetree/bindings/clock/qcom,*.yaml and that contains
the "reg-names" string, we see:

  reg:
    items:
      - description: LPASS qdsp6ss register
      - description: LPASS top-cc register

  reg-names:
    items:
      - const: qdsp6ss
      - const: top_cc

I don't understand one thing; this doesn't tell you:

   You can provide 2 MMIO blocks, which must be qdsp6ss and top_cc.

But it tells you:

   Block zero must be qdsp6ss.
   Block one must be top_cc.

If we do that I do not get the point of reg-names; we put more
information in our devicetree that is in any case imposed.

This is why I went with a different approach looking like:

  reg:
    minItems: 2
    maxItems: 2
  reg-names:
    minItems: 2
    maxItems: 2
    items:
      enum: [ d0, d1 ]

I know this is not perfect, but at least you don't enforce an order for
no reason. If "items: const..." approach should be taken, then I'll
remove reg-names which bring no benefit.

Thanks Krzysztof,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


