Return-Path: <linux-kernel+bounces-137059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2E589DBCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BA11F233D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD512F5BD;
	Tue,  9 Apr 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9IIJLfg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997577F7CB;
	Tue,  9 Apr 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671801; cv=none; b=NoOR/DSQYB/PGjVR/6rWl4hSlMHGI4nRs+hgnuz72tzxE+UcEfo9Sd95MAyJu2ghn9wUx8oiCmCoS2OLtfXXlxzbplr1jRGKpLJLqJh+g849Y0k3YCOaDWQno0s8eXP/m+B/Tt+yA/jR1LAUTzz8SqZ12l5CxyclUKcRwKmdHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671801; c=relaxed/simple;
	bh=W7xZiCGfrp/J2JNm0PesJiqxLHyBJYWMZRS4zrswi+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lga/4Df5ccM8Bm5V85yhXbcoitTWMOMocw8yRzCqUxoV7w3yktfWKnszhn/fX2d2rr8dOBJOR+WNPSY7qDKSkouRR99/+LmjpUYKjmhy06qj9HRIXWHHlG2btg2omEHpxLyUhmy1FVAh46gUZccO4V88PYwKzi7JjM74sKBkbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9IIJLfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E504C433C7;
	Tue,  9 Apr 2024 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671801;
	bh=W7xZiCGfrp/J2JNm0PesJiqxLHyBJYWMZRS4zrswi+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r9IIJLfgRWb9nAvzxeXzOfe7nfY0TmB1sc3aTOUhhOQKEaAJvYrTtSCOHTbVAGJZx
	 PcCrWBLEA2ejbMABRpXwQ4pFVpU2epobf0RFmlTM3ieHo3e1EgNFCittJ+XVaqoHjC
	 nvFZafPuVEJuXWnrvHh9HcfPUocf+KyegKc8UrJd4y1Pf7B3Om95xbuWzuo0hOVE3l
	 AeDGiKGdMsagGI672LOdQiPDvoSxSJlrQrIpdIC5bF7NdJ8lmJgnW1fC3gKpDZWin1
	 weKOssZimQ/mgZqNH2Nh5UieAX0DAyS+MbdNfIxDYYzoYSZioyhEgdRnOObX6Hlozt
	 VMtpTZIugUGBA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso6532687e87.2;
        Tue, 09 Apr 2024 07:10:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEPh2wrfz1ztSrKWsgx5gEZsLy30rr1TafKZaOKI+DeIKRr9GTkkU4E0TX0eOH9P/e7NkV4+fU7kA0qljUEnlVk45FLKm75w4S43lY6FbcIW16zyqm1USfuebhEXgiLdGaVXk0OFuqrg==
X-Gm-Message-State: AOJu0YysFmUEPGQ8OvJHHdRAZ/BJG1Yd77J7wgoQObZNeNucxLozU0Hc
	Z1AWVArd49bzyMMs9vzAr1F+hYwTPUlKzuu1btZwiaBrPC0y3v8+6mOcAfUz35o+DpqB5gUo+I1
	vNuNo24TI82zHOsut9HnoZ6s1Bw==
X-Google-Smtp-Source: AGHT+IGwS/iSR238geA9Q4DgRuWZYrHIvbz4wExMaJgQ3IxeWLrr3RC5Xkhhk27u0LOd9GWR1+cJyQdKUMtvbnmJDwo=
X-Received: by 2002:ac2:4257:0:b0:515:a360:1d92 with SMTP id
 m23-20020ac24257000000b00515a3601d92mr9156118lfl.67.1712671799543; Tue, 09
 Apr 2024 07:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DU0PR04MB9417932A6208128FBBB22C4188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <09f6b752-6b72-49d7-b248-6faba2fd13a7@kernel.org> <DU0PR04MB9417C5B9BDD9E0B47E7494C088012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <5b9e0e44-0b9c-44fc-9d18-21c47b46dc63@kernel.org> <DU0PR04MB9417839C42681F57366003EF88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ba4c9f20-0391-4ac2-a236-d6930285cd7e@kernel.org> <DU0PR04MB94176D02B90528913842B76A88002@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <e6333665-8051-43b1-9e98-f76262ddbc35@kernel.org> <DU0PR04MB9417C8C5013C72AB1F61F1C588002@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <AS1PR04MB9431BE4B2BFE05507A2D93F288072@AS1PR04MB9431.eurprd04.prod.outlook.com>
 <ZhUuKajQbce2AI9f@pluto>
In-Reply-To: <ZhUuKajQbce2AI9f@pluto>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Apr 2024 09:09:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+aVEOPzqddu-X8GLJPex+J6V+_T1qaGHAXgp94+_-ptg@mail.gmail.com>
Message-ID: <CAL_Jsq+aVEOPzqddu-X8GLJPex+J6V+_T1qaGHAXgp94+_-ptg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 7:01=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> On Tue, Apr 09, 2024 at 09:25:10AM +0000, Peng Fan wrote:
> > Hi Krzysztof,
> >
> > > Subject: RE: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
> > > additionalProperties to true
> > >
> > > > Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
> > > > additionalProperties to true
> > > >
> > > > On 08/04/2024 08:08, Peng Fan wrote:
> > > > >> Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
> > > > >> additionalProperties to true
> > > > >>
> > > > >> On 08/04/2024 01:50, Peng Fan wrote:
> > > > >>>> Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: s=
et
> > > > >>>> additionalProperties to true
> > > > >>>>
> > > > >>>> On 07/04/2024 12:04, Peng Fan wrote:
> > > > >>>>>> Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi:
> > > > >>>>>> set additionalProperties to true
> > > > >>>>>>
> > > > >>>>>> On 07/04/2024 02:37, Peng Fan wrote:
> > > > >>>>>>>> Subject: Re: [PATCH v2 1/6] dt-bindings: firmware: arm,scm=
i:
> > > > >>>>>>>> set additionalProperties to true
> > > > >>>>>>>>
> > > > >>>>>>>> On 05/04/2024 14:39, Peng Fan (OSS) wrote:
> > > > >>>>>>>>> From: Peng Fan <peng.fan@nxp.com>
> > > > >>>>>>>>>
> > > > >>>>>>>>> When adding vendor extension protocols, there is dt-schem=
a
> > > > >> warning:
> > > > >>>>>>>>> "
> > > > >>>>>>>>> imx,scmi.example.dtb: scmi: 'protocol@81', 'protocol@84' =
do
> > > > >>>>>>>>> not match any of the regexes: 'pinctrl-[0-9]+'
> > > > >>>>>>>>> "
> > > > >>>>>>>>>
> > > > >>>>>>>>> Set additionalProperties to true to address the issue.
> > > > >>>>>>>>
> > > > >>>>>>>> I do not see anything addressed here, except making the
> > > > >>>>>>>> binding accepting anything anywhere...
> > > > >>>>>>>
> > > > >>>>>>> I not wanna add vendor protocols in arm,scmi.yaml, so will
> > > > >>>>>>> introduce a new yaml imx.scmi.yaml which add i.MX SCMI
> > > > >>>>>>> protocol
> > > > >> extension.
> > > > >>>>>>>
> > > > >>>>>>> With additionalProperties set to false, I not know how, ple=
ase
> > > > suggest.
> > > > >>>>>>
> > > > >>>>>> First of all, you cannot affect negatively existing devices
> > > > >>>>>> (their
> > > > >>>>>> bindings) and your patch does exactly that. This should make
> > > > >>>>>> you thing what is the correct approach...
> > > > >>>>>>
> > > > >>>>>> Rob gave you the comment about missing compatible - you stil=
l
> > > > >>>>>> did not address that.
> > > > >>>>>
> > > > >>>>> I added the compatible in patch 2/6 in the examples "compatib=
le
> > > > >>>>> =3D
> > > > >>>> "arm,scmi";"
> > > > >>>>
> > > > >>>> So you claim that your vendor extensions are the same or fully
> > > > >>>> compatible with arm,scmi and you add nothing... Are your
> > > > >>>> extensions/protocol valid for arm,scmi?
> > > > >>>
> > > > >>> Yes. They are valid for arm,scmi.
> > > > >>>
> > > > >>>  If yes, why is this in separate binding. If no, why you use
> > > > >>> someone
> > > > >>>> else's compatible?
> > > > >>>
> > > > >>> Per SCMI Spec
> > > > >>> 0x80-0xFF: Reserved for vendor or platform-specific extensions =
to
> > > > >>> this interface
> > > > >>>
> > > > >>> i.MX use 0x81 for BBM, 0x84 for MISC. But other vendors will us=
e
> > > > >>> the id for their own protocol.
> > > > >>
> > > > >> So how are they valid for arm,scmi? I don't understand.
> > > > >
> > > > > arm,scmi is a firmware compatible string. The protocol node is a =
sub-node.
> > > > > I think the arm,scmi is that saying the firmware following SCMI s=
pec
> > > > > to implement the protocols.
> > > > >
> > > > > For vendor reserved ID, firmware also follow the SCMI spec to
> > > > > implement their own usage, so from firmware level, it is ARM SCMI
> > > > > spec
> > > > compatible.
> > > >
> > > > That's not the point. It is obvious that your firmware is compatibl=
e
> > > > with arm,scmi, but what you try to say in this and revised patch is
> > > > that every arm,scmi is compatible with your implementation. What yo=
u
> > > > are saying is that 0x84 is MISC protocol for every firmware, Qualco=
mm,
> > > > NXP, Samsung, TI, Mediatek etc.
> > > >
> > > > I claim it is not true. 0x84 is not MISC for Qualcomm, for example.
> > >
> > > You are right. I am lost now on how to add vendor ID support, using
> > > arm,scmi.yaml or adding a new imx,scmi.yaml or else.
> >
>
> Hi Peng,
>
> I dont think in the following you will find the solution to the problem,
> it is just to recap the situation and constraints around vendor protocol
> bindings.
>
> Describing SCMI vendors protocols is tricky because while on one side
> the protocol node has to be rooted under the main scmi fw DT node (like
> all the standard protocols) and be 'derived' from the arm,scmi.yaml
> protocol-node definition, the optional additional properties of the a spe=
cific
> vendor protocol nodes can be customized by each single vendor, and since,
> as you said, you can have multiple protocols from different vendors shari=
ng the
> same protocol number, you could have multiple disjoint sets of valid prop=
erties
> allowed under that same protocol node number; so on one side you have to =
stick
> to some basic protocol-node defs and be rooted under the SCMI node, while=
 on
> the other side you will have multiple possibly allowed sets of additional
> properties to check against, so IOW you cannot anyway just set
> additionalProperties to false since that will result in no checks at all.
>
> As a consequence, at runtime, in the final DTB shipped with a specific
> platform you should have only one of the possible vendor nodes for each
> of these overlapping protocols, and the SCMI core at probe time will
> pick the proper protocol implementation based on the vendor/sub_vendor
> IDs gathered from the running SCMI fw platform at init: this way you
> can just build the usual "all-inclusive" defconfig without worrying
> about vendor protocol clashes since the SCMI core can pick the right
> protocol implementation, you should just had taken care to provide the
> proper DTB for your protocol; BUT this also means that it is not possible
> to add multiple DT bindings based on a 'if vendor' condition since the
> vendor itself is NOT defined and not needed in the bindings since it is
> discoverable at runtime.
>
> So, after all of this blabbing of mine about this, I am wondering if it
> is not possible that the solution is to handle each and every vendor
> protocol node that appears with a block of addtional properties that
> are picked via a oneOf statement from some external vendor specific
> yaml.
> (...in a similar way to how pinctrl additional properties are added...)
>
>
> NOTE THAT the following is just an example of what I mean, it is certainl=
y
> wrong, incomplete annd maybe just not acceptable (and could cause DT
> maintainers eyes to bleed :P)...
>
> ...so it is just fr the sake of explaining what I mean...
>
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/D=
ocumentation/devicetree/bindings/firmware/arm,scmi.yaml
> index e9d3f043c4ed..3c38a1e3ffed 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -278,6 +278,22 @@ properties:
>      required:
>        - reg
>
> +  protocol@81:
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x81
> +
> +    patternProperties:
> +      '$':
> +        type: object

Did you mean to have child nodes under the protocol node rather than in it?

> +        oneOf:
> +          - $ref: /schemas/vendor-A/scmi-protos.yaml#
> +          - $ref: /schemas/vendor-B/protos.yaml#

Moved up one level, this would work, but it would have to be an
'anyOf' because it is possible that 2 vendors have the exact same set
of properties.

I can think of 2 other ways to structure this.

First, is a specific vendor protocol discoverable? Not that is 0x81
protocol present, but that 0x81 is vendor Foo's extra special
value-add protocol? If not, I think we should require a compatible
string on vendor protocols. Then the base SCMI schema can require just
that, and each vendor protocol defines its node with a $ref to
'#/$defs/protocol-node'.

The 2nd way is just a variation of the oneOf above, but do we do 1
file per vendor protocol or 1 file per vendor. Either should be
doable, just a matter of where 'protocol@81', etc. are defined.

Rob

