Return-Path: <linux-kernel+bounces-23279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BF82AA1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1240B28612E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB6115AE2;
	Thu, 11 Jan 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ICPoVClO"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DBB15ADA;
	Thu, 11 Jan 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1704963604; x=1736499604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbzQZ8tnx/iwXB+XjV7lv4rMKxkvy0CEn1w0UhXKSOQ=;
  b=ICPoVClOckS42n36e6K6M6cmTuDqIyGCw/7j5veptUp964R9UQWOxhyy
   GWemP4PoN6GuCnW4HfQVz52apWejjbBlARG1H3bl5QPVZJIhlydtONiQO
   Ik3t72Nnkqw69fJbc8SjpIiyY6PoHOV3NXm/qRtbRrkS/xIVqSv9QxqDK
   zjT5n/I1Vjx3DEVwzcwqEWrPDRO0nhd6VsPWSkjwDj6ZHS5PHTQDbN6Dx
   F5Szlv44LycP3++Vrncp+sivc4BD46M+Q99zeZCVKL5vnN2LETPv2c/I4
   eBI6JfuDIhSl+Khzd0Q/I2kI6qyeCacSiPWiQjdtC0oqkuk3rqcHyau5/
   A==;
X-IronPort-AV: E=Sophos;i="6.04,185,1695679200"; 
   d="scan'208";a="34844570"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Jan 2024 09:59:55 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2D693280075;
	Thu, 11 Jan 2024 09:59:55 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: interrupt-controller: fsl, irqsteer: Add power-domains
Date: Thu, 11 Jan 2024 09:59:54 +0100
Message-ID: <9230083.CDJkKcVGEf@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240110-ignore-womanhood-a7ee7caa71f1@spud>
References: <20240110094338.472304-1-alexander.stein@ew.tq-group.com> <20240110-ignore-womanhood-a7ee7caa71f1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Conor,

Am Mittwoch, 10. Januar 2024, 17:09:07 CET schrieb Conor Dooley:
> On Wed, Jan 10, 2024 at 10:43:38AM +0100, Alexander Stein wrote:
> > Some SoC like i.MX8QXP use a power-domain for this IP add it to the
> > supported proerties. Fixes the dtbs_check warning:
> > freescale/imx8qxp-tqma8xqp-mba8xx.dtb: irqsteer@56000000: 'power-domain=
s'
> >=20
> >  does not match any of the regexes: 'pinctrl-[0-9]+'
> >=20
> > from schema $id:
> > http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >=20
> > Notes:
> >     Please note that both the board dts and the DT node for irqsteer be=
ing
> >     used, are still work-in-progress.
>=20
> The binding doesn't even support the imx8qxp's irqsteer yet, I think
> this should be added alongside support for that SoC. Am I missing
> something?

I'm not sure if any additional SoC support is actually needed. 'fsl,imx-
irqsteer' is available and that's what I use in my WiP. Also imx8mp also ju=
st=20
uses the generic compatible. Only imx8mq uses 'fsl,imx8m-irqsteer'.
AFAICS the bindings support the different amount of IRQs already.

Best regards,
Alexander

>=20
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.y=
am
> > l
> > b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.y=
am
> > l index 20ad4ad82ad64..cb4fcd23627f6 100644
> > ---
> > a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.y=
am
> > l +++
> > b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.y=
am
> > l>=20
> > @@ -42,6 +42,9 @@ properties:
> >    clock-names:
> >      const: ipg
> >=20
> > +  power-domains:
> > +    maxItems: 1
> > +
> >=20
> >    interrupt-controller: true
> >   =20
> >    "#interrupt-cells":


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



