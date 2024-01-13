Return-Path: <linux-kernel+bounces-25168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C378D82C8F2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DBD1F24A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D518E02;
	Sat, 13 Jan 2024 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3eiiwlN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A341A594;
	Sat, 13 Jan 2024 01:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8759C433B1;
	Sat, 13 Jan 2024 01:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705110842;
	bh=53lTNv4PeoQS9hGdvt7a6AGwPPIeogMIRbF8hzV8nkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S3eiiwlNzsctXVIF62MT+kIY1V/yTE6D1xnutGJ+7CZJ+qo/yuArq32XtsVgPQ3c/
	 755L1V3m3iltNsUdRdWj72MdVbaQQRmCszRc5pe/jPOmtQC0Wvay5mULriNeTtV2HQ
	 V99+NBoK3gbYNelt4c6xFJ6Fp4r+pWcSCAub6MiFYVtQjUDH0NiETsZ7Mnmo9ec76D
	 n3pv17ka8B446M9Yv3SPgHoDeRFEWOKoKIMRdDV+aSMyLpaYZwoEEDCB2LNINxeyID
	 hOnYgDAx3gtgyQZ1m3aoDkEJ+O4WXckBptjeGqzHB9PbLktxiEnbrNAoPKcZZvR67w
	 cYqEkHJpMAzww==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd64022164so72340501fa.3;
        Fri, 12 Jan 2024 17:54:02 -0800 (PST)
X-Gm-Message-State: AOJu0Yy916hd7U0OdGIb7tgynPcbl9qIAa1eD/+GfurlPO1RXjdBgK+L
	EKdjMmNI6260jHFr0mRT/57ykuN41nT6zJH4NQ==
X-Google-Smtp-Source: AGHT+IGLBs7HKlazVnBbtBDn3wYjGagxFmxJfGVSZIxV0OlBGYvLM3MWroGVHD/fsJpgnLQPzGBhX3YmqV5PfJGV/9c=
X-Received: by 2002:ac2:57cd:0:b0:50b:e713:574d with SMTP id
 k13-20020ac257cd000000b0050be713574dmr1044659lfo.75.1705110840895; Fri, 12
 Jan 2024 17:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <20231107105025.1480561-3-billy_tsai@aspeedtech.com> <20231108182135.GA2698015-robh@kernel.org>
 <SG2PR06MB33655734700697E8F6FD0D1B8BB2A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <CAL_JsqL=2-dD5yFWWDDHu1svcCF-EMZqcYz92Pr7L5ntppNQVA@mail.gmail.com> <SG2PR06MB3365CAEE9CE3F691DA1CA1E28BB9A@SG2PR06MB3365.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB3365CAEE9CE3F691DA1CA1E28BB9A@SG2PR06MB3365.apcprd06.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 12 Jan 2024 19:53:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJrqOZ9nYrWUkuRVyY0OkJG6m-YY45f1ZeYKNAyYv_tMQ@mail.gmail.com>
Message-ID: <CAL_JsqJrqOZ9nYrWUkuRVyY0OkJG6m-YY45f1ZeYKNAyYv_tMQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM
 TACH Control
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"andrew@aj.id.au" <andrew@aj.id.au>, "corbet@lwn.net" <corbet@lwn.net>, 
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, 
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"naresh.solanki@9elements.com" <naresh.solanki@9elements.com>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>, 
	"patrick@stwcx.xyz" <patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 11:45=E2=80=AFPM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:
>
> > > > > Document the compatible for aspeed,ast2600-pwm-tach device, which=
 can
> > > > > support up to 16 PWM outputs and 16 fan tach input.
> > > > >
> > > > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > > > > ---
> > > > >  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++=
++++++
> > > > >  1 file changed, 69 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspee=
d,g6-pwm-tach.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pw=
m-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.ya=
ml
> > > > > new file mode 100644
> > > > > index 000000000000..c615fb10705c
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.=
yaml
> > > > > @@ -0,0 +1,69 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +# Copyright (C) 2023 Aspeed, Inc.
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml=
#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: ASPEED G6 PWM and Fan Tach controller
> > > > > +
> > > > > +maintainers:
> > > > > +  - Billy Tsai <billy_tsai@aspeedtech.com>
> > > > > +
> > > > > +description: |
> > > > > +  The ASPEED PWM controller can support up to 16 PWM outputs.
> > > > > +  The ASPEED Fan Tacho controller can support up to 16 fan tach =
input.
> > > > > +  They are independent hardware blocks, which are different from=
 the
> > > > > +  previous version of the ASPEED chip.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - aspeed,ast2600-pwm-tach
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  resets:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  "#pwm-cells":
> > > > > +    const: 3
> > > > > +
> > > > > +patternProperties:
> > > > > +  "^fan-[0-9]+$":
> > > > > +    $ref: fan-common.yaml#
> > > > > +    unevaluatedProperties: false
> > > > > +    required:
> > > > > +      - tach-ch
> > > > > +
> > > > > +required:
> > > > > +  - reg
> > > > > +  - clocks
> > > > > +  - resets
> > > > > +  - "#pwm-cells"
> > > > > +  - compatible
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > > > +    pwm_tach: pwm-tach-controller@1e610000 {
> > > > > +      compatible =3D "aspeed,ast2600-pwm-tach";
> > > > > +      reg =3D <0x1e610000 0x100>;
> > > > > +      clocks =3D <&syscon ASPEED_CLK_AHB>;
> > > > > +      resets =3D <&syscon ASPEED_RESET_PWM>;
> > > > > +      #pwm-cells =3D <3>;
> > > > > +
> > > > > +      fan-0 {
> > >
> > > > I assume there's a PWM connection here? How do you know which PWM? =
You
> > > > said the tach channel is independent, so it is not that.
> > >
> > > > It should not be 0 from 'fan-0' because that's just a meaningless i=
ndex.
> > >
> > > > You either need 'pwms' here or you can use 'reg' and the reg value =
is
> > > > the PWM channel.
> > >
> > > Hi Rob, this binding is used to export the PWM provider and the Fan m=
onitor (i.e., Tach).
> > > If the user wants to add the PWM connection for the fan, it can be do=
ne as follows:
> > >
> > > fan0: pwm-fan0 {
> > >         compatible =3D "pwm-fan";
> > >         pwms =3D <&pwm_tach 0 40000 0>;
> > >         cooling-min-state =3D <0>;
> > >         cooling-max-state =3D <3>;
> > >         #cooling-cells =3D <2>;
> > >         cooling-levels =3D <0 15 128 255>;
> > > };
> > >
> > > This will reuse the existing PWM fan driver (e.g., pwm-fan.c).
>
> > I'm confused now. So what are the child nodes you have? You are
> > defining the fan in 2 places? The "pwm-fan" driver supports a tach via
> > an interrupt, so how would this work in your case?
>
> Hi Rob,
>
> The tach interrupt for the pwm-fan is option. In our case, the dts just r=
euse the pwm control function
> of the pwm-fan, and the part of the tach monitor will be created by our f=
an child nodes.
> So the dts will like followings:
>
> // Use to declare the tach monitor for fan.
> &pwm_tach {
>         fan-0 {
>                 tach-ch =3D /bits/ 8 <0x0>;
>         };
>         fan-1 {
>                 tach-ch =3D /bits/ 8 <0x1>;
>         };
>         ...
> }
>
> // Reuse the pwm-fan.c to control the behavior of the PWM for fan.
> fan0: pwm-fan0 {
>         compatible =3D "pwm-fan";
>         pwms =3D <&pwm_tach 0 40000 0>;   /* Target freq:25 kHz */
>         cooling-min-state =3D <0>;
>         cooling-max-state =3D <3>;
>         #cooling-cells =3D <2>;
>         cooling-levels =3D <0 15 128 255>;
> };

No, you can't have a fan described by 2 different nodes. Can't you
just merge everything from the pwm-fan0 node into the fan-0 node?

Rob

