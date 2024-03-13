Return-Path: <linux-kernel+bounces-102338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEBF87B0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295572911FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B96AF88;
	Wed, 13 Mar 2024 18:13:45 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED055605D2;
	Wed, 13 Mar 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353624; cv=none; b=BTI0yEydDZIlv3jYFkRz9DaB+Pb1kJY8WCybRHo9R135rOUug5mlZQe4VFyTXHv6G5GvCS8BJx7j+Rby+zA6mus1O4E8XG9v49cOkzGx8w/fVYmJAnTF4uPrTiD2ggJ3sxtt7sIWw1IYObdLB4yqsRQwMCcxN6VEeSzjvQnEaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353624; c=relaxed/simple;
	bh=XBZxd3/8sCA+mi0OAIV0bPCc+jlbGDc9ebO1Ccnfgsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkOCZMmJk5u/rdUTfCU4Ssc7IAtQVgZ1qyYVZFnZ3TR9eOwgRxNl5A25+HBmb9iy5l1wXGvfI96RQb3jFKhuriPayrKiPdy7Xoo2nQe4UmxEturFrJRO1BwvkMj/bmfsIy0SX+OUPVfpUjIKkxm2Ivy2Z5sXiZa8QseAZARipfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6c8823519so45366b3a.0;
        Wed, 13 Mar 2024 11:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710353622; x=1710958422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AhNbiGT3dBNYmyMqRR3v/dtfPCNBKZcqWH9p/BqTK+I=;
        b=CgUE4E2mCdRsTNba2m0nytc7ejXmuUspdpOei20LUT/VNZsPZC12fH3jgQiUPSRY82
         dvlnXCNp2xX1RXDjhpnvfiDCT4pYlX9phxsOKhKhfe53UjHrzqdperMTe8hzKp9ys4iA
         wTAzzHrD3zhX4whypLxDw8sU4Q4sXomXhuU6/v+n8kHg9JsU/42F6W13KaiVErtJid+r
         nxLuzps60BTC1HhfaOhnyb3Xrr/O9j/iFFb60Ao2URdTx5yPS3jFAdnoukyeFcY9wDao
         SBBIeK0ZxbWpNLUY3w3RtdqiQdM2b3TZB+/e3scyiDm+hfNVHmT3yrCq47Fxzd8N4B+T
         lZNg==
X-Forwarded-Encrypted: i=1; AJvYcCVw4ZjlQt2PGWMlPYuu+FYHI3LXcJ004S86LDNN+nqD0f2j47hTQkvnPM7D6aa1LEJ9cto7OvNybC5ov2a0wFpUoYmNFiF4SngLaLmoqsddb9bWckP+cc+/IIdWOe9zf09AGml1eiQV9w==
X-Gm-Message-State: AOJu0YwhfnE5fsRCnKo/fcvoI9jL4c34nOuDs5Z0vJmrtFj7fHaMxTk6
	rF/h4moOlz91kPaC5Rxf+0MGnRRpw8UNpSNt21ZEyACHN4AVS75AQJ9TpnA4pt0=
X-Google-Smtp-Source: AGHT+IELRo71VU1XOT1Wc01eMxnOnWmDp4USZDRpckfAyyYTsbwl9N94X2uNVwLPh9u+c6vCkgVFkA==
X-Received: by 2002:a62:d45b:0:b0:6e6:c61d:114c with SMTP id u27-20020a62d45b000000b006e6c61d114cmr597254pfl.0.1710353621740;
        Wed, 13 Mar 2024 11:13:41 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id c13-20020a63350d000000b0059b2316be86sm8045119pga.46.2024.03.13.11.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 11:13:41 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so94822a12.1;
        Wed, 13 Mar 2024 11:13:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAZC0Mtbe+USFdxyTR1a5fxX67AoBFUT5Rz2oZyp8r09qUNEufhHAm1UVvXdpn0QS0vm+qaspXBaomIQPamPi8nEqtukQvBPcOu7pltkCX0pc/mRi43JeyUIxxilPiBV+aqlV5mgFjrw==
X-Received: by 2002:a17:90a:9084:b0:29b:b854:db with SMTP id
 j4-20020a17090a908400b0029bb85400dbmr11208175pjo.27.1710353621055; Wed, 13
 Mar 2024 11:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240310010211.28653-3-andre.przywara@arm.com> <f203a0a3-9107-4290-a934-0f6736fe218a@sholland.org>
 <20240313173529.1f816404@donnerap.manchester.arm.com>
In-Reply-To: <20240313173529.1f816404@donnerap.manchester.arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 14 Mar 2024 02:13:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v65LgmYU_PZLU8KDSYhr76y=kPNboTsZ9mRkT=wBuYSdvA@mail.gmail.com>
Message-ID: <CAGb2v65LgmYU_PZLU8KDSYhr76y=kPNboTsZ9mRkT=wBuYSdvA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: document AXP717
To: Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 1:35=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Mon, 11 Mar 2024 17:20:50 -0500
> Samuel Holland <samuel@sholland.org> wrote:
>
> Hi Samuel,
>
> thanks for having a look!
>
> > On 3/9/24 19:02, Andre Przywara wrote:
> > > The X-Powers AXP717 is a PMIC used on some newer Allwinner devices.
> > > Among quite some regulators it features the usual ADC/IRQ/power key
> > > parts, plus a battery charger circuit, and some newly introduced USB
> > > type-C circuitry.
> >
> > Do you plan to put the Type-C logic under a subnode, or should the
> > Type-C connector node go directly under the PMIC node? Either way, the
> > binding probably needs to be updated for that.
>
> I haven't looked into this yet, so cannot say which way to go. I
> definitely consider this some non-trivial task, so indeed wanted to push
> this off to later.
> For now there is a device (Anbernic RG35XX) with that PMIC, so we need at
> least the regulators to unblock this. USB support is not critical for now=
.
>
> > > Like two other recent PMICs, it lacks the DC/DC converter PWM frequen=
cy
> > > control register, that rate is fixed here as well.
> > >
> > > Add the new compatible string, and add that to the list of PMICs with=
out
> > > the PWM frequency property.
> > >
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.ya=
ml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > > index 06f1779835a1e..b8e8db0d58e9c 100644
> > > --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > > @@ -83,6 +83,7 @@ allOf:
> > >              enum:
> > >                - x-powers,axp313a
> > >                - x-powers,axp15060
> > > +              - x-powers,axp717
> > >
> > >      then:
> > >        properties:
> > > @@ -99,6 +100,7 @@ properties:
> > >            - x-powers,axp221
> > >            - x-powers,axp223
> > >            - x-powers,axp313a
> > > +          - x-powers,axp717
> > >            - x-powers,axp803
> > >            - x-powers,axp806
> > >            - x-powers,axp809
> >
> > The regulators patternProperties needs to be updated for the new boost
> > regulator.
>
> Ah, I indeed missed this one. I think the former PMICs had this
> batter->VBUS boost regulator hidden, controlled entirely by the PMIC?
> I will need to check if exposing this will present any surprises. I
> guess this goes together with the USB-C support, to have role switching,
> unless this appears on some device with just USB-A or micro-B.
> I will check what it takes to add this one, the regulator itself looks
> easy.

I don't think there was such a boost regulator on previous PMICs. It was
just a passthrough, which is why on some boards such as the Cubietruck
there is an external boost converter to put out 5V when just the battery
is used.

ChenYu

