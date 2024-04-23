Return-Path: <linux-kernel+bounces-154550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB68ADD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D05A28162E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A787422F17;
	Tue, 23 Apr 2024 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZGJmTFvF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UAkiHRNj"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E81C2AD;
	Tue, 23 Apr 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853638; cv=none; b=HlIs2JN6xjSrs0UA2v5i1fe7spfkpVafGRsboBiKj7sHuqqN37v7PLjr90HElxQFBkOob0+78JiXOsON9Y4ogiRlDW9kX3AWRNJvCXmMZtYWC12PzNuYKrh+LCXqZ1DeeuRUfMJaiPRt0EDIIwsQo+HXfsym90LmTdAG+q291oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853638; c=relaxed/simple;
	bh=BOTVxgdLvwkUKUp/KbDf4z2lDM2qZC92BYAnfam74oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8LCc5LCd9nbFNnDFwTZ1eW9A4v38AmiKmrHe7JGC1NNGZdTo+j5YeyrjhY2xSGhpMUX5hmHby3Sv1oEGv0D8tftwTN/WKTUJs2lXdwq3B6JSBncVB6lBcHHslifbpxv9jy/G/T5CIOe+TjXRtcEQ6ncZBLOl0KMqDDCkb4vjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZGJmTFvF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=UAkiHRNj reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713853626; x=1745389626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s7RKTtO04TwlxnfzFc9siRRe1sN43bdKokqcoMESYdY=;
  b=ZGJmTFvFnmT4AtORZSsLKN9lKxlxcHDDnT4V9BhNseCP++N3ya1ZpiWA
   l9R0jBewbATt/TwDr6333snkOYqv8vOZh7tLzpr0qrErcdTb4gunG+MXI
   za+lIUSinpnlbDmy5g8uw15BboFTag0Cxm1k7NGLwM5CSzuNL4lHoEdyJ
   VnPE/rQ42JfCnhg8cJbJmaguGW3CUi1IIifi7On8bFZ5xizzJDemBrXGG
   I59DSaeVTvPMLhRo5eEvTNu8BTKue/VuOGmGzxIlnlsbq7PAcVhRiJsw9
   aPyh3ucG1A3rcwZQcTSJn4X6pCA31OAoizSgbXuMEeITrqljXEkcl8fxD
   w==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36554964"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 08:26:58 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C86B3173F3F;
	Tue, 23 Apr 2024 08:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713853614;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=s7RKTtO04TwlxnfzFc9siRRe1sN43bdKokqcoMESYdY=;
	b=UAkiHRNjMPPyc0aoxi7sCbNJkWN4dzPCT/TtD2d4Ca+L9Cf2CMqH/q2MCpIyGF9RFQntm7
	3EfpEN1GTF0ig6txR+/ictIsHJHX7yZETNMph2MzyROkh82Jw27lDG5Kiham8mfDw3Fmzs
	7h1bveDOteAgmtqP/o2JBAgNcPth6yqNxCc4Dk3iHpDT8AdjuWasnadJn9OmUd/x5Y/XAJ
	OTRC1/Xi04FXakyTnKeXE4Tt0eQhiaXaAI2TVsYVXFGVyoFKm8LMPTH1ZJg8RWgqcjqpi1
	9SLI7W1Ms2kKYyEwBPb/+Ph6Z/48ydp+ZGB0tnFqr0C1jGHZEnBpfvix5mIVOw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: interrupt-controller: fsl, irqsteer: Add imx8qxp support
Date: Tue, 23 Apr 2024 08:26:55 +0200
Message-ID: <6041240.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240422-channel-emission-d485dee6ae48@spud>
References: <20240422064949.70778-1-alexander.stein@ew.tq-group.com> <20240422-channel-emission-d485dee6ae48@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Conor,

cc'ed imx@lists.linux.dev

Am Montag, 22. April 2024, 17:48:20 CEST schrieb Conor Dooley:
> On Mon, Apr 22, 2024 at 08:49:49AM +0200, Alexander Stein wrote:
> > Some SoC like i.MX8QXP use a power-domain for this IP. Add a SoC-specif=
ic
> > compatible, which also requires a power-domain.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Thanks for the feedback.
> >=20
> > Changes in v3:
> > * Move 'allOf' before 'additionalProperties'
> > * Remove superfluous 'minItems: 1'
> >=20
> >  .../interrupt-controller/fsl,irqsteer.yaml      | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl=
,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl=
,irqsteer.yaml
> > index 20ad4ad82ad64..3d33b75d6ecfa 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqste=
er.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqste=
er.yaml
> > @@ -14,7 +14,9 @@ properties:
> >      oneOf:
> >        - const: fsl,imx-irqsteer
> >        - items:
> > -          - const: fsl,imx8m-irqsteer
> > +          - enum:
> > +              - fsl,imx8m-irqsteer
> > +              - fsl,imx8qxp-irqsteer
> >            - const: fsl,imx-irqsteer
> > =20
> >    reg:
> > @@ -42,6 +44,9 @@ properties:
> >    clock-names:
> >      const: ipg
> > =20
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    interrupt-controller: true
> > =20
> >    "#interrupt-cells":
> > @@ -70,6 +75,16 @@ required:
> >    - fsl,channel
> >    - fsl,num-irqs
> > =20
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8qxp-irqsteer
> > +    then:
> > +      required:
> > +        - power-domains
>=20
> Provided the power domains are optional on the existing platforms,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> otherwise,
> else:
>   properties:
>     power-domains: false

A power-domain is used on imx8mp, but imx8mq does not.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



