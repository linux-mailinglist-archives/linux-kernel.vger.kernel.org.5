Return-Path: <linux-kernel+bounces-78927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F4861AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0971C25E48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B595614263A;
	Fri, 23 Feb 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQuQllPj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40761420D9;
	Fri, 23 Feb 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710809; cv=none; b=hEvt+n5H0dhUQZYVoJQOMxfA4BvA5w6crxjmmIG6jxEJN6k4Vl6IWILYJzB4m5tefQug8fO36Ts4eQAKyhHsMi1YGLk1Abjvlg9c1oCkbtBf0rgWuPpZhS3SsJGGhegZND0XPBnrWzoIgFv6x5SLz0zf/q1Q0BW81Xf3JhvcCVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710809; c=relaxed/simple;
	bh=WTOVfHwza5JDZNP0OnvJKCXt8zegJXyWV1Mnm2fCV1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc6IETakh36sf5Hhrd/1/PVPoz0hia6LBAV9+oQ2+toO+4XA5fjnS3ctgXdToFA5JK/rerzm7UUYS+e5kjXt2kbwBzVKIbVdSr2uumTmcI+kOWRxGyDxxsEE8fSSqfnAjImfyhjrAbJlm7LaL02RdKiBvZy4UKzzocNKM1m1SyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQuQllPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E9EC43609;
	Fri, 23 Feb 2024 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708710809;
	bh=WTOVfHwza5JDZNP0OnvJKCXt8zegJXyWV1Mnm2fCV1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kQuQllPjhL6JnqsGGniHZuQx+bbjCtqTe05hEGi5avlSJFJ7glc6bLdVSZoqgRfs6
	 Q7C91qeSrknXJE9GTlq0cRK56B6UQmSzw/G+PAXhciDsO5cbp1qZbMMeAHVFWexA++
	 S/h+h7zb2XWbSssyAooLhfSW4rbuDMyEy4ypvlY1XEBTN+21IPdyft7buecX7Y/PTy
	 jGdIOU1D8riSMXLR4leBE/55/mAfUU4Xg90DM43iGoThSYuxeztuBSP17CqE4XOF7g
	 jK3KLsD0u83qtnEzwS1jDha63fZ6XCsZX9q0pMyq0XVX2zC5NHG5ONnpz0OJIA5/Ni
	 yxM4SloxyH6JA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512e568607aso727480e87.1;
        Fri, 23 Feb 2024 09:53:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWauceGNl2Lr50MYqlxRHX+veyeqHBIO67KHzZq/xDift125SK6CPNy3OEmwTIRD//fRqiCM4xoyfj8O53auGPYQppF92Y3tGXHjOf60WHEtZ8AoLbTnHj6nQuLJtur4J1atJFZPk0kPk4RdOy1WkVnUJutRi2SVQhgT0EscgISmZ6RMg==
X-Gm-Message-State: AOJu0YzxqVCLZXNMnjBFfykifnQMvyy7LdX2zOzpza/ajWT0msitkNO+
	tHRlq4mVUKJ3VNt41uRp124AwkxRiqNEwArs+fyxTbX+jM3T2L28rSw1+uqR8rTL6gTghNfLoNK
	g1MR4XxZhCBtZp8Q63YoK3BPwAQ==
X-Google-Smtp-Source: AGHT+IHbqG0RqOBjOBsM00h1ydkL16ZhPv0Dk8ezh7fgoRnVQ3LvuIXX116VAry1mCVFHrgzVhf8IxNjpoMQWGm5HjM=
X-Received: by 2002:a05:6512:3b28:b0:512:a97e:daa6 with SMTP id
 f40-20020a0565123b2800b00512a97edaa6mr363184lfv.36.1708710807665; Fri, 23 Feb
 2024 09:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221145846.1611627-1-xu.yang_2@nxp.com> <20240221145846.1611627-4-xu.yang_2@nxp.com>
 <20240223140256.GA1768266-robh@kernel.org> <DU2PR04MB882234D1A9D5718D8355928B8C552@DU2PR04MB8822.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB882234D1A9D5718D8355928B8C552@DU2PR04MB8822.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 23 Feb 2024 10:53:14 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKXwL5sGkSikRO6CVSRwENbW1-b3Bn+oy1Acupt06=dRQ@mail.gmail.com>
Message-ID: <CAL_JsqKXwL5sGkSikRO6CVSRwENbW1-b3Bn+oy1Acupt06=dRQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2
 Controller schema
To: Xu Yang <xu.yang_2@nxp.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, 
	"peter.chen@kernel.org" <peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:56=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Hi Rob,
>
> >
> > On Wed, Feb 21, 2024 at 10:58:41PM +0800, Xu Yang wrote:
> > > As more and more NXP i.MX chips come out, it becomes harder to mainta=
in
> > > ci-hdrc-usb2.yaml if more stuffs like property restrictions are added=
 to
> > > this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and=
 add
> > > a new schema for NXP ChipIdea USB2 Controller.
> > >
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > >
> > > ---
> > > Changes in v6:
> > >  - new patch
> > > ---
> > >  .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 75 +++++++++++++++++=
++
> > >  1 file changed, 75 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb=
2-imx.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.y=
aml b/Documentation/devicetree/bindings/usb/ci-
> > hdrc-usb2-imx.yaml
> > > new file mode 100644
> > > index 000000000000..2ec62f564bf5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> > > @@ -0,0 +1,75 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/usb/ci-hdrc-
> > usb2-
> > imx.yaml%23&data=3D05%7C02%7Cxu.yang_2%40nxp.com%7C4ac0c60cd4b4433f0f9f=
08dc34782572%7C686ea1d3bc2b4c6fa92c
> > d99c5c301635%7C0%7C0%7C638442937830606824%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> > LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D7p1DzvYmBsTgN44jypH=
7lc56z9hVBsFBYXUwsblk9z8%3D&reserv
> > ed=3D0
> > > +$schema: http://devicetree.org/meta-
> > schemas%2Fcore.yaml%23&data=3D05%7C02%7Cxu.yang_2%40nxp.com%7C4ac0c60cd=
4b4433f0f9f08dc34782572%7C686ea1d3
> > bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638442937830615622%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> > JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DfWWy9=
enbGK5yeKiovday7go3Gss5L%2F%2Fe%2F
> > OZcANny0QA%3D&reserved=3D0
> > > +
> > > +title: NXP USB2 ChipIdea USB controller
> > > +
> > > +maintainers:
> > > +  - Xu Yang <xu.yang_2@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - fsl,imx27-usb
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,imx23-usb
> > > +              - fsl,imx25-usb
> > > +              - fsl,imx28-usb
> > > +              - fsl,imx35-usb
> > > +              - fsl,imx50-usb
> > > +              - fsl,imx51-usb
> > > +              - fsl,imx53-usb
> > > +              - fsl,imx6q-usb
> > > +              - fsl,imx6sl-usb
> > > +              - fsl,imx6sx-usb
> > > +              - fsl,imx6ul-usb
> > > +              - fsl,imx7d-usb
> > > +              - fsl,vf610-usb
> > > +          - const: fsl,imx27-usb
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,imx8dxl-usb
> > > +              - fsl,imx8ulp-usb
> > > +          - const: fsl,imx7ulp-usb
> > > +          - const: fsl,imx6ul-usb
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,imx8mm-usb
> > > +              - fsl,imx8mn-usb
> > > +          - const: fsl,imx7d-usb
> > > +          - const: fsl,imx27-usb
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,imx6sll-usb
> > > +              - fsl,imx7ulp-usb
> > > +          - const: fsl,imx6ul-usb
> > > +          - const: fsl,imx27-usb
> >
> > Now you just duplicated all the compatibles, and now any new compatible=
s
> > have to be added in 2 places. For this to work, you have to split
> > ci-hdrc-usb2.yaml into 2 files. One with all the common properties and
> > one with compatibles (minus imx). This is also needed if imx has any
> > extra properties the other don't.
> >
> > Didn't I say this already?
> >
>
> Yes, I know.
>
> But according to your words, I need to split ci-hdrc-usb2.yaml into 1 com=
mon
> file and more than 1 vendor specific files (imx, nvidia, qcom, nuvoton an=
d
> others). In this patchset, I only focus on imx part and KK said he or som=
eone
> will take over other parts, therefore I just duplicated all the imx compa=
tibles.

This series is just wasting our time because it can't be applied without th=
at.

> If I only create imx specific yaml file and remove all compatilbles from =
common
> file, nvidia, qcom, nuvoton and others compatible info will be lost, is t=
his
> feasible? Or should I create mutiple vendor specific files at the same ti=
me?

You don't have to split each vendor to a separate vendor schema file.
Just move everything common to ci-hdrc-usb2-common.yaml and add a
reference to it. Then imx can reference the common file.

Rob

