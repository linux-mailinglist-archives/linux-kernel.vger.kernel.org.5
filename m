Return-Path: <linux-kernel+bounces-76781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9485FC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1316F285640
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406414D447;
	Thu, 22 Feb 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSBc2oNL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E49482D4;
	Thu, 22 Feb 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616072; cv=none; b=tgHU+k/I7uLtmz3ABKW4E7dQiHp8ITyzkIgq/6zgqpBem6Ej1IHtuz73fsKhRR/dcU/mT93sSKoSFlMykcka9lQFVmccQQHclKM3GtT8NU4hKEGwXKXClbmlroC3zASx2KNfb0N6ZbESLauKZT2x/qwblqhY9m1BzlcJteNs+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616072; c=relaxed/simple;
	bh=hgxfsP2uprA1vuFpi6P+dbDSTCbhlaU5XxD8Li/ITTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Me9PvnIatWo0OZua1OLpBenWX4qTX52jzhsS6bjsvLTCiLw5j0EebaklRU0g0f8qgHnh1N3L81tXV3Off8/6dOQq8zuSTBbCty4x7jAiI/u25gZRGJvR8SD7kUwiVpP8tvXdZmsQTUsL/8Lbl2zhEbf3NhtoiQGp9d82n+u7kyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSBc2oNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABABDC433C7;
	Thu, 22 Feb 2024 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616071;
	bh=hgxfsP2uprA1vuFpi6P+dbDSTCbhlaU5XxD8Li/ITTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bSBc2oNLRFmbQIRlCpTLIsOFniG6X/9lQjpBl+sgZs1ftQRbrwubjgyBGC5BRmtk4
	 BTGMofh5DM7mLd4m+Xrf43sSqezKos2E7XJw/cGXTQd9g8/fAFSkfhDaBOnnnlPGSQ
	 QfC6dBNm2kfMNBVp8Bq9PcBEi4tgme20p8JhBwTD/tYAFFKvEG95FWd8Dr6iF13jcG
	 vV2kw3+eIrx08urnq8Qr9OMtxbnTvTnlZlpQvubrq88hAuBfNXTiznp5LJ4LYLzqHE
	 rqaEMSf3ScvZWmtLIFgwirVzQrtPCllp6Stt0e/+KpI7qsj2XP3aGhvSCargZJrwuK
	 DDM1q6La43olw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d09cf00214so92055051fa.0;
        Thu, 22 Feb 2024 07:34:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSQ+TXgBFrbe2p2Ki4aEm3I/is4DqLy6gEYsfI1jhfpMzrH00hnPzojX+k2bJobrWoTfY4KvMszNUTq36vQ2vbsZ8H1tyTqfTg2VotX6BB/lFGpJ6q5OxY6kLW+bjjD4MaM7lYNvwcaA==
X-Gm-Message-State: AOJu0YzLJ0zGK+8yT/UVwA3uSPzv/tz0cSjyBX/566e5N6ci1uLmi6re
	CY05wRC6qlMyws/Nmha+M4dezjQkb/4ZYGQOrt83Ddssub7DzFztZmzLgRY1mop7RMon5WHsT9d
	lW4xLVuUsrm6nUrUOLst30z0g0A==
X-Google-Smtp-Source: AGHT+IFgyNerjD3B8faWG/isyW+76U5eGaG3mxQGoiIVhZWC3fI6SK73bLHpCgSZuwiktVrJEUSjJo6fWh5RcbhYnFc=
X-Received: by 2002:a05:651c:9:b0:2d2:555f:b4ae with SMTP id
 n9-20020a05651c000900b002d2555fb4aemr3219787lja.51.1708616069766; Thu, 22 Feb
 2024 07:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com>
 <20240216-ad7944-mainline-v2-1-7eb69651e592@baylibre.com> <20240221152226.GA2868707-robh@kernel.org>
 <CAMknhBFytGYNo8FviHepoxLApoGyo0mVhL2BzVmm1vt8-Evn9Q@mail.gmail.com>
In-Reply-To: <CAMknhBFytGYNo8FviHepoxLApoGyo0mVhL2BzVmm1vt8-Evn9Q@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 22 Feb 2024 08:34:16 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+diFUEn=Tf99_FkXqLHuyLrZW_jaYoPjGhGjGbecgivg@mail.gmail.com>
Message-ID: <CAL_Jsq+diFUEn=Tf99_FkXqLHuyLrZW_jaYoPjGhGjGbecgivg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:44=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Wed, Feb 21, 2024 at 9:22=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Fri, Feb 16, 2024 at 01:46:18PM -0600, David Lechner wrote:
>
> ...
>
> > > +  adi,spi-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum: [ single, multi, chain ]
> > > +    default: multi
> > > +    description: |
> > > +      * single: The datasheet calls this "3-wire mode". It is often =
used when
> > > +        the ADC is the only device on the bus. In this mode, SDI is =
tied to VIO,
> > > +        and the CNV line can be connected to the CS line of the SPI =
controller
> > > +        or to a GPIO, in which case the CS line of the controller is=
 unused.
> >
> > We have a standard property for this.
>
> As discussed in v1 [1], the datasheet's definition of "3-wire mode" is
> _not_ the same as the standard spi-3wire property. I can add that to
> the description here to clarify (I hoped changing the enum name was
> enough, but perhaps not). Or is there a different property you are
> referring to?
>
> [1]: https://lore.kernel.org/all/20240216140826.58b3318d@jic23-huawei/
>
> >
> > > +      * multi: The datasheet calls this "4-wire mode". This is the c=
onvential

Also, typo.

> > > +        SPI mode used when there are multiple devices on the same bu=
s. In this
> > > +        mode, the CNV line is used to initiate the conversion and th=
e SDI line
> > > +        is connected to CS on the SPI controller.
> >
> > That's "normal" mode.
>
> That was my first choice, but the datasheet uses the term "normal
> mode" to mean not TURBO mode which is something else unrelated to the
> SPI mode.

What I mean is this should be conveyed by the absence of any property.
You don't need a property for "normal SPI mode".

> >
> > > +      * chain: The datasheet calls this "chain mode". This mode is u=
sed to save
> > > +        on wiring when multiple ADCs are used. In this mode, the SDI=
 line of
> > > +        one chip is tied to the SDO of the next chip in the chain an=
d the SDI of
> > > +        the last chip in the chain is tied to GND. Only the first ch=
ip in the
> > > +        chain is connected to the SPI bus. The CNV line of all chips=
 are tied
> > > +        together. The CS line of the SPI controller is unused.
> >
> > Don't you need to know how many chips are chained? In any case, you jus=
t
> > need a property for chain mode. There's some existing properties for
> > chained devices I think. Standard logic shift register based GPIO IIRC.
>
> Thanks, I see #daisy-chained-devices now. I missed that before.
>
> >
> > CNV are tied together, but must be driven by something? I suppose
> > cnv-gpios?
>
> Yes.
>
> > But wouldn't that be the same as the SPI controller GPIO CS?
> > Does a SPI controller CS line connected to CNV not work in this case?
>
> Maybe technically possible if CS is inverted on the bus since the line
> has to be high to trigger the conversion and during the xfer.

That's supported by the binding. Seems like it would simplify the
driver if you went that route and better support other devices on the
SPI bus. Also, we require 'reg', so I don't know what you'd put in it
in the no CS case. Though, we probably already have that case with CS
tied active. Shrug.

Rob

