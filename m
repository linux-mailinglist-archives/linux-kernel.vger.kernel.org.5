Return-Path: <linux-kernel+bounces-94683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4387435D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08008B20B43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A61CA83;
	Wed,  6 Mar 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzGykI5t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0F1C6B7;
	Wed,  6 Mar 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766073; cv=none; b=qKntluW54J/S1L/iyxgaOlPfMbysz4EIuweWAcjbwmfjdiAH8EfX9G+3cmimgWN3kwgdgTw4ytDr5UE9YYjl3StpxFOQn4GtRZmKeK6pXmT9P+PiWzWxgCne7Qj5MwCvy96KoykwC3FutgdzPeAW63c5JJfgEtbRtLnvV/meX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766073; c=relaxed/simple;
	bh=1foeIlAL02HQ/9fWETjo+VPeQRpGEBkjUsRFchJX7d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7s0X0KyGwm9aOcW0Y2JfdRZA3TCIJWg4NEAugeZy/xEpHxi0N5ovzeWEwvW5An/bFX6oIm6YddOdFQkg2z6ZkzqU8EOXM4rsfdJr6GD2Za8sV5jH/+vGGJzFQhjVZc7BNC+KfzyPZMf6WzS9IhCzjfr/Thlf4Blbp7uTBOMTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzGykI5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61598C433A6;
	Wed,  6 Mar 2024 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766073;
	bh=1foeIlAL02HQ/9fWETjo+VPeQRpGEBkjUsRFchJX7d4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FzGykI5t1KZcrcNh3uIkXsI4mhxdAVRhHvFVRqEEeCR8jYOZBf7sIsQYsEmuoj7Cp
	 VJ6XN/kVz/j7ISNU6iJKQDCYUJmit3KyAdc//QwJiR2o5MN2ihF+ss0bY2FRwXOw8Y
	 16xCLbhfe6SOMgclhR+g9ttqkRAacHzIx+G26l4lFwWlcxDagL7vq1NClMiqfMZrLF
	 V3aL0pc75FJc0Fhi9frO5zcqRZAwskdM87VYHPQH+CUDT3xk8JSontUBbFSweZ3oS8
	 JNJxUi6okj8ACN6TKTIWyhVqSRg7/4sSKO41qB7DO6R3zCyv4rLzMKCu0wHoRzla0L
	 09TQtdiq5BF3Q==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51331634948so1430963e87.0;
        Wed, 06 Mar 2024 15:01:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX55ddvTi+1PL8+Fw8hmol8Drzqhd1Jk4Iq9GjqI+BYY0AmhJEFpErttfEiBIkfbKrYEMcKIt7EGNelZ/lqaeVFJtLLNDlshDu2GUgibRCkAwVp2UHe78wuRnpKsLW7v4hr6kRSp/wAmeENopzOhY+o+iZ4ZTVfzkNhGRO5SYwUUZmM51nv
X-Gm-Message-State: AOJu0YzPyrXfz5fPXnB28hWBbo6+R1725ikxRac/d3dnEffvkuxDZupO
	6lsE+Juz3dP08WI19IL6iuL83p/CaQsEUMUitlHRA252jpf5wcdIn769nTVP0Zrwm5EZW6jgofs
	LJdS2yXLWaFMiozW4ukwRzUWbKw==
X-Google-Smtp-Source: AGHT+IEe7ONAG3lrAgIWy+05ru/C7vwOPDlzVeORdLHPWUfWrnU47WOhZwb4SSMXu5BC5lZaDn1RllTR5GSnhrsxEUU=
X-Received: by 2002:ac2:5a0b:0:b0:513:3b3e:c361 with SMTP id
 q11-20020ac25a0b000000b005133b3ec361mr70664lfn.2.1709766071504; Wed, 06 Mar
 2024 15:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com> <20240305-asrc_8qxp-v4-2-c61b98046591@nxp.com>
 <20240306202537.GA587561-robh@kernel.org> <ZejX0/FA/z4wa7cY@lizhi-Precision-Tower-5810>
In-Reply-To: <ZejX0/FA/z4wa7cY@lizhi-Precision-Tower-5810>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Mar 2024 17:00:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6U2-EGeJgTuxBooEy=OEJ08wDNshWnfKooryAr6=QNg@mail.gmail.com>
Message-ID: <CAL_JsqJ6U2-EGeJgTuxBooEy=OEJ08wDNshWnfKooryAr6=QNg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
To: Frank Li <Frank.li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:53=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Mar 06, 2024 at 02:25:37PM -0600, Rob Herring wrote:
> > On Tue, Mar 05, 2024 at 12:33:03PM -0500, Frank Li wrote:
> > > fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platf=
orms
> > > have 1 interrupt.
> > >
> > > Increase max interrupt number to 2 and add restriction for platforms =
except
> > > i.MX8QXP and i.MX8QM.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 18 ++++++++=
+++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b=
/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > index 56f8c0c8afdea..7f6590708e1ec 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > @@ -31,7 +31,8 @@ properties:
> > >      maxItems: 1
> > >
> > >    interrupts:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> > >
> > >    dmas:
> > >      items:
> > > @@ -101,6 +102,21 @@ required:
> > >  additionalProperties: false
> > >
> > >  allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          enum:
> > > +            - fsl,imx8qm-spdif
> > > +            - fsl,imx8qxp-spdif
> > > +    then:
> > > +      properties:
> > > +        interrupts:
> > > +          minItems: 2
> >
> > Nowhere is it explained what the 2 interrupts are or what the order of
> > them is. Is the first interrupt the same as before, and there is a new
> > interrupt for something else? Or it's the same interrupts, but they've
> > just split up into 2?
>
> It is same one and split to tx and rx. Order doesn't matter.

Make that clear in the schema. Order does matter and you have to
define the order in the schema.

> They uses one
> irq handle.

What does that mean?

Rob

