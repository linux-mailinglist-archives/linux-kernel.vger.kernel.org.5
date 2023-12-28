Return-Path: <linux-kernel+bounces-12719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E94AD81F94B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343801F242F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97ED521;
	Thu, 28 Dec 2023 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KRQ/NFR5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867ADDB2;
	Thu, 28 Dec 2023 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5156BE0007;
	Thu, 28 Dec 2023 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703775590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdwCvRsG4FixCkCZpu5yjHO2BXpFje5WX4wGXSWETNo=;
	b=KRQ/NFR5fnv3tyC0OOxzVzia9A3F0wOtj9cdDJRfsAE7k0gWkTQlRBCdiodFisKqMQzaHY
	QV4IYPaNekaX8jRI1OxjkkZknrVumkFacDma18Pf9tLOPicDW83RA9AoQmu5D1zBCahzkz
	dDmk3MEgdgqECAHOExvjKTPaqBqypopcLdIgNQr3iZr8l489ij+v8A12MF9vQn+J+mQLQC
	wiR5TpEOrmeUxBKxe1j9IbpeYgNWrO8Ij8zDiXifOj/4HUlUCibKUBoW+YzkXeW9xHjlxQ
	To+1ztjLLzN3sphXYe+KAY40Zz/L8dTUYbE7kguALuCAkzrNaZUBqnrKlqad7Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Dec 2023 15:59:48 +0100
Message-Id: <CY021G48QZPW.1PAP84HUGG3AF@bootlin.com>
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
X-Mailer: aerc 0.15.2
References: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com>
 <20231227-mbly-clk-v2-3-a05db63c380f@bootlin.com>
 <bf77bd32-b618-4409-ab8b-93e4439ee6bf@linaro.org>
In-Reply-To: <bf77bd32-b618-4409-ab8b-93e4439ee6bf@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Dec 28, 2023 at 8:21 AM CET, Krzysztof Kozlowski wrote:
> On 27/12/2023 17:23, Th=C3=A9o Lebrun wrote:
> > Add documentation to describe the "Other Logic Block" syscon.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 44 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 45 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,ey=
eq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq=
5-olb.yaml
> > new file mode 100644
> > index 000000000000..b148a49b08f1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb=
.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mobileye EyeQ5 SoC system controller
> > +
> > +maintainers:
> > +  - Gr=C3=A9gory Clement <gregory.clement@bootlin.com>
> > +  - Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > +
> > +description:
> > +  OLB ("Other Logic Block") is a hardware block grouping smaller block=
s. Clocks,
> > +  resets, pinctrl are being handled from here.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: mobileye,eyeq5-olb
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reg-io-width:
> > +    const: 4
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-io-width
>
> It's still wrong order of the patches. Binding should be complete, so
> you miss clock-controller in this patch. If you ordered them hoping
> there is no dependency between patches, it will not work. You still have
> dependency! Your next patch still depends on this, which should be
> clearly expressed either in cover letter or next patch.

Ah you read me right, I did indeed expect ordering to be enough. I'll
squash all changes to mobileye,eyeq5-olb.yaml into a single commit to
avoid any dependency.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

