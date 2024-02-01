Return-Path: <linux-kernel+bounces-48815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41EE8461F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4B21C2374F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4D85643;
	Thu,  1 Feb 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIJMkO1J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184741757;
	Thu,  1 Feb 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819286; cv=none; b=VyNoBmITVGcKfu7sO8ZNGr/Hv9uzPWZll6LT5YEbQmxq6CIKH8cmYuS715XJTEPk+eNgE/uCuNIpn//CWfLUcMcaRflyqmaneyJiC7hyTzT2UIVPMlvhz6vFYZAuw8YrLbpjHphw/ecUFNpbRZaKA/5jscCzWSwUyuVQJz1GNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819286; c=relaxed/simple;
	bh=6tQl1zhGsp0AgvX70rMJRGvBvIqwnJBiyuHx0oqxYaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igXqn8WA/Pwg/NN3vFYIUuNKRV+jz+yz4I/DD6l4eaDyok6oTSDOFbIpPm6f4xPI0ZacQmHYMIKJJmYdxjOOGkcnQujG1s9WbTRdW7FF8cHEom1xrn+9w8UO/4ypEaQkjZzOUfi6WZfj3gCBzgmh0DvNRIIflYcCYG89RvW42Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIJMkO1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2DAC43390;
	Thu,  1 Feb 2024 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706819286;
	bh=6tQl1zhGsp0AgvX70rMJRGvBvIqwnJBiyuHx0oqxYaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IIJMkO1J3qdAPjFhp9NFki9KSlBkApSyUSBg45R/fcuaWq73OzP1TH9B8K5FUawqf
	 Rkzv2wgOCzW3QvLifgZbRXygzzKOpSksvllb1VuIiRz7/QFL+R2yjPcrKsWJaENzaT
	 nHRtCzBCuEUwPKjaNzN1clTWw1SQE5Ae7GwK0YGjwaw+ehqdacgDw2Vmz6xWvKxdC6
	 lygVypeBrNqxw2bvfJdNcjQjW6lgS2d9TRP5x8sXrW4tK5pQ16wM+a55D9uBJE9f2d
	 mRztGU5U4Y5ccLcYw0NKuaNtRaMTkDe2aokda0J7tBPo8UaSzXm8scxRpsJgv2CiIT
	 T4KPV34zXQKYw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51032e62171so1833015e87.3;
        Thu, 01 Feb 2024 12:28:05 -0800 (PST)
X-Gm-Message-State: AOJu0YxsYbzpqZVxV5wIw+jLSXewPe0jJe3PwYEgNKA1pcB9BTrg/g2r
	t4hoZlvgbwp/IzN7YWy+d0N4JTFYL+dr82Kbiy8x845LzjSvSzxqjlexMmycxUjZPE83bSpaB5B
	4CTa10vEUmTFNGD2AYSpenm2BJw==
X-Google-Smtp-Source: AGHT+IGubbR1peMhLtT66Pzyv9QrdRtRk+md5AJfiADamBjLRFZ5ehOkkmE54chgLrptc6wpZNg4V4OLUaNoG8q4XTE=
X-Received: by 2002:a19:f81a:0:b0:511:2eba:fc5d with SMTP id
 a26-20020a19f81a000000b005112ebafc5dmr41863lff.34.1706819284230; Thu, 01 Feb
 2024 12:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706802756.git.geert+renesas@glider.be> <b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be>
 <170680870030.996964.6959185693674664805.robh@kernel.org> <CAMuHMdWfovGkvrk4coitFgDTuHS_fQcvFb8kJj-1AWtUgkAYgg@mail.gmail.com>
In-Reply-To: <CAMuHMdWfovGkvrk4coitFgDTuHS_fQcvFb8kJj-1AWtUgkAYgg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Feb 2024 14:27:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhoBE2fMcB37wsxtXa+BdbeTRDfD=jpRTgAJ8nBR1foQ@mail.gmail.com>
Message-ID: <CAL_JsqKhoBE2fMcB37wsxtXa+BdbeTRDfD=jpRTgAJ8nBR1foQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: gpio-regulator: Fix
 {gpios-,}states limits
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:06=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
org> wrote:
>
> Hi Rob The Robot ;-)

:)

> On Thu, Feb 1, 2024 at 6:31=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
> > On Thu, 01 Feb 2024 16:58:41 +0100, Geert Uytterhoeven wrote:
> > > make dtbs_check:
> > >
> > >     arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: regulator-v=
ccq-sdhi0: Unevaluated properties are not allowed ('gpios-states', 'states'=
 were unexpected)
> > >           from schema $id: http://devicetree.org/schemas/regulator/gp=
io-regulator.yaml#
> > >
> > > The number of items in "gpios-states" must match the number of items =
in
> > > "gpios", so their limits should be identical.
> > >
> > > The number of items in "states" must lie within the range from zero u=
p
> > > to 2^{number of gpios}.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > The second issue did not cause any dtbs_check errors?
> > > ---
> > >  .../devicetree/bindings/regulator/gpio-regulator.yaml         | 4 ++=
+-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/regulator/gpio-regulator.yaml: properties:states:minItems: 0 is less than =
the minimum of 1
> >         hint: An array property has at least 1 item or is not present
> >         from schema $id: http://devicetree.org/meta-schemas/keywords.ya=
ml#
>
> Oops, I changed this from 1 to 0 _after_ running dt_binding_check, so
> I'm totally to blame for this.
>
> The description says:
>
>     If there are no states in the "states" array, use a fixed regulator i=
nstead.
>
> which I misinterpreted as "states can be empty", especially as the
> driver does seem to support that?
>
> I guess 1 is the proper minimum?

Yes. While JSON can for example have "foo: []", that's not really
defined for DT given we store no type info. An empty property is a
boolean.

Rob

