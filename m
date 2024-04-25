Return-Path: <linux-kernel+bounces-158316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0567C8B1E38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AD01C21964
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03384E19;
	Thu, 25 Apr 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkIVTPyL"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5784D2C;
	Thu, 25 Apr 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037989; cv=none; b=QS146jc+h3HglgzP0MoOYsZgiiIj0UHDh9Wdj/nYfPJK9yskK2AxnDRg3nDNDDQr4NLOJq+pdUPsmLrdy3FEvG/2oO1EXJ14rGvRdyVT0c3bg+0Hi+fM2h6hYyKv/HRs/KSOq9WpKaX01btwTjOGhcnDE/iEzDY+iOozBMRyO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037989; c=relaxed/simple;
	bh=qzN7MLLBq9f4CvPJfFmQCyWJNSAG003xU4q77TyJx2g=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Pr0HHvDX0VA8rQpqC9t+eY2FajLljenXJ7VYrTHn1TdKrIlwdqYU1CzIs+xeBzrXh3TkaOfd6fonv3rvFd1sKmn7Cm3aRLWkjZ5hJe2pT3jMI4GVuJkPD5cLDPRB2LWWJdE1eiZYD5cqcgZjfusmOwX/vuuT7HpXfK7YJ+xupis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkIVTPyL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5200202c1bso93479666b.0;
        Thu, 25 Apr 2024 02:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714037986; x=1714642786; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeoF2LD/FnGiNx/2NgLwbKv13uzKEYK6tBaU9lBoRUQ=;
        b=ZkIVTPyLB5Xqlc5TJI9csy0fYxvJPEnNovoWjBM4HWzDkn9mHQQRVe/4Sumc7kyw9L
         WZW2B8DBhPpqeUOCINdGyFDEqpmBHUU8Od5PDZln15FRa/IrRFYyCqOhQucNWnGqvZv8
         z1WsWjfgSWqpjlJb/NsSGe7mGzO3y4tB3X0qxQpJA5BJHv4XzISY2WfG6GNnYp4y1Ets
         qti4mCtArUZSsDAAsvm5j3pk5NuBfn8SE9sx7RnNSDtYWJA7SLEx0OC6nXHGTO1156+Q
         u/SaYsg7+W/e9OxCi5pjK6gIb48f8hLiilB3tOuJ0IQdpCONi7WgnW8mIyaJaqp8Dsrq
         u8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714037986; x=1714642786;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeoF2LD/FnGiNx/2NgLwbKv13uzKEYK6tBaU9lBoRUQ=;
        b=HuF+vGuIpIlCt2e589IKiigQ1dS7sKxm+iG78llph7aRRaH2DfV/QsJXBj2h8WKfif
         ecSHdqclMj4r4IFmYbIFzLQosZgpBK1L2dfTe2AutoJv2KzS6M2yWVtvmOD6UpjNHMsY
         OQcVclh2rbWQWt6WvzyHKyqpNiI3DE0M2S+6CoSGq3xwzgb7AVNJt/2Xdi7goCbBYOax
         HKyfNMidb/fB3xO3l2IaGPt1kbWPdiyI5MVL3/NRDx1lD3UxpT+R62poH7W6ly/05Cky
         6Z5j8BV/Z+LYP8AJQiERqmW5rp9kd14lKfs7iHQ5H8wJydsfV2fedFQvZRmjh3xngYYS
         Ljwg==
X-Forwarded-Encrypted: i=1; AJvYcCVLhXXdDomxOw5XuruEy8YetISsRr5OcYlpuryxkdIZq6dhx39+4Gq48NQBNvyaaOBPcLmJJ4RlzbJl9ULCmmiXnWssiWc6W6LT4TmmCW55d417fGJoNQ/FgvCTGsB8AT+LKMUUqgcie1Y=
X-Gm-Message-State: AOJu0YznaUCg0ThJb59ztAG5lpaHjHuDEvm6MquuJi2dYFIY+5q4ROJD
	sbYEQcsamz5uLWxiz68qvblOdFTZ44jK8vo7AJnA/2cq18Br9Jfp
X-Google-Smtp-Source: AGHT+IFc68idvTShi9eRcrAEx83sc450bQhgs6O8zQ7zAp7rnY3edp8EcAC8YYT2edBv37yqvEfJiA==
X-Received: by 2002:a17:907:2685:b0:a55:a1d4:84f5 with SMTP id bn5-20020a170907268500b00a55a1d484f5mr4896891ejc.43.1714037985945;
        Thu, 25 Apr 2024 02:39:45 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a5889ee66d6sm2289894ejb.45.2024.04.25.02.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:39:45 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=11bf7723ce2ee8c4dc9f5d8a9625e732e4266a15537986345fdef71c5bc5;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 25 Apr 2024 11:39:44 +0200
Message-Id: <D0T3R7UPFO07.2VR2436TG4N8B@gmail.com>
Subject: Re: [Patch v3 1/2] dt-bindings: make sid and broadcast reg optional
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Sumit Gupta"
 <sumitg@nvidia.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
 <maz@kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>,
 <jonathanh@nvidia.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-2-sumitg@nvidia.com>
 <d26f9661-3e50-4a72-9097-fe63a27503f1@linaro.org>
 <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com>
 <D0SILCYU98EV.1XW7NZFC9013K@gmail.com>
 <9561dede-37d0-4183-8742-448058803f8e@linaro.org>
In-Reply-To: <9561dede-37d0-4183-8742-448058803f8e@linaro.org>

--11bf7723ce2ee8c4dc9f5d8a9625e732e4266a15537986345fdef71c5bc5
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Apr 25, 2024 at 9:52 AM CEST, Krzysztof Kozlowski wrote:
> On 24/04/2024 19:04, Thierry Reding wrote:
> > On Wed Apr 24, 2024 at 6:26 PM CEST, Thierry Reding wrote:
> >> On Mon Apr 22, 2024 at 9:02 AM CEST, Krzysztof Kozlowski wrote:
> >>> On 12/04/2024 15:05, Sumit Gupta wrote:
> >>>> MC SID and Broadbast channel register access is restricted for Guest=
 VM.
> >>>
> >>> Broadcast
> >>>
> >>>> Make both the regions as optional for SoC's from Tegra186 onwards.
> >>>
> >>> onward?
> >>>
> >>>> Tegra MC driver will skip access to the restricted registers from Gu=
est
> >>>> if the respective regions are not present in the memory-controller n=
ode
> >>>> of Guest DT.
> >>>>
> >>>> Suggested-by: Thierry Reding <treding@nvidia.com>
> >>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >>>> ---
> >>>>  .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++------=
---
> >>>>  1 file changed, 49 insertions(+), 46 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nv=
idia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controller=
s/nvidia,tegra186-mc.yaml
> >>>> index 935d63d181d9..e0bd013ecca3 100644
> >>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,te=
gra186-mc.yaml
> >>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,te=
gra186-mc.yaml
> >>>> @@ -34,11 +34,11 @@ properties:
> >>>>            - nvidia,tegra234-mc
> >>>> =20
> >>>>    reg:
> >>>> -    minItems: 6
> >>>> +    minItems: 4
> >>>>      maxItems: 18
> >>>> =20
> >>>>    reg-names:
> >>>> -    minItems: 6
> >>>> +    minItems: 4
> >>>>      maxItems: 18
> >>>> =20
> >>>>    interrupts:
> >>>> @@ -151,12 +151,13 @@ allOf:
> >>>> =20
> >>>>          reg-names:
> >>>>            items:
> >>>> -            - const: sid
> >>>> -            - const: broadcast
> >>>> -            - const: ch0
> >>>> -            - const: ch1
> >>>> -            - const: ch2
> >>>> -            - const: ch3
> >>>> +            enum:
> >>>> +              - sid
> >>>> +              - broadcast
> >>>> +              - ch0
> >>>> +              - ch1
> >>>> +              - ch2
> >>>> +              - ch3
> >>>
> >>> I understand why sid and broadcast are becoming optional, but why ord=
er
> >>> of the rest is now fully flexible?
> >>
> >> The reason why the order of the rest doesn't matter is because we have
> >> both reg and reg-names properties and so the order in which they appea=
r
> >> in the list doesn't matter. The only thing that matters is that the
> >> entries of the reg and reg-names properties match.
> >>
> >>> This does not even make sid/broadcast optional, but ch0!
> >>
> >> Yeah, this ends up making all entries optional, which isn't what we
> >> want. I don't know of a way to accurately express this in json-schema,
> >> though. Do you?
> >>
> >> If not, then maybe we need to resort to something like this and also
> >> mention explicitly in some comment that it is sid and broadcast that a=
re
> >> optional.
> >=20
> > Actually, here's another variant that is a bit closer to what we want:
> >=20
> > --- >8 ---
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/n=
vidia,tegra186-mc.yaml
> > index 935d63d181d9..86f1475926e4 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra=
186-mc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra=
186-mc.yaml
> > @@ -34,11 +34,11 @@ properties:
> >            - nvidia,tegra234-mc
> > =20
> >    reg:
> > -    minItems: 6
> > +    minItems: 4
> >      maxItems: 18
> > =20
> >    reg-names:
> > -    minItems: 6
> > +    minItems: 4
> >      maxItems: 18
> > =20
> >    interrupts:
> > @@ -146,17 +146,21 @@ allOf:
> >      then:
> >        properties:
> >          reg:
> > +          minItems: 4
> >            maxItems: 6
> >            description: 5 memory controller channels and 1 for stream-i=
d registers
> > =20
> >          reg-names:
> > -          items:
> > -            - const: sid
> > -            - const: broadcast
> > -            - const: ch0
> > -            - const: ch1
> > -            - const: ch2
> > -            - const: ch3
> > +          anyOf:
> > +            - items:
> > +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3 ]
> > +              uniqueItems: true
> > +              minItems: 6
> > +
> > +            - items:
> > +                enum: [ ch0, ch1, ch2, ch3 ]
> > +              uniqueItems: true
> > +              minItems: 4
> > =20
> >    - if:
> >        properties:
> > @@ -165,29 +169,22 @@ allOf:
> >      then:
> >        properties:
> >          reg:
> > -          minItems: 18
> > +          minItems: 16
> >            description: 17 memory controller channels and 1 for stream-=
id registers
> > =20
> >          reg-names:
> > -          items:
> > -            - const: sid
> > -            - const: broadcast
> > -            - const: ch0
> > -            - const: ch1
> > -            - const: ch2
> > -            - const: ch3
> > -            - const: ch4
> > -            - const: ch5
> > -            - const: ch6
> > -            - const: ch7
> > -            - const: ch8
> > -            - const: ch9
> > -            - const: ch10
> > -            - const: ch11
> > -            - const: ch12
> > -            - const: ch13
> > -            - const: ch14
> > -            - const: ch15
> > +          anyOf:
> > +            - items:
> > +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3, ch4, ch5, =
ch6, ch7,
> > +                        ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15 ]
> > +              minItems: 18
> > +              uniqueItems: true
> > +
> > +            - items:
> > +                enum: [ ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, c=
h9, ch10,
> > +                        ch11, ch12, ch13, ch14, ch15 ]
> > +              minItems: 16
> > +              uniqueItems: true
>
> No, because order is strict.

Why? I realize that prior to this the order was indeed strict and it's
common to have these listed in strict order in the DTS files. However,
this is an arbitrary restriction that was introduced in the patch that
added reg-names. However, */*-names properties have always assumed the
ordering to be non-strict because each entry from the * property gets
matched up with the corresponding entry in the *-names property, so the
ordering is completely irrelevant.

Thierry

--11bf7723ce2ee8c4dc9f5d8a9625e732e4266a15537986345fdef71c5bc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYqJOEACgkQ3SOs138+
s6Eqtg/7BN1yeZ9CIf1/eTU5EZ9NIerk1mQmCpM/rWLIzVMx25rIypFiE5T5uWOS
gposhJ8vBKKFwLg94bpJm0+M5zOWxt1B6lZbUXZFQO8WDzPUgGXW0wr63PS0vOfY
x5fYrNS8XXS1b6UuYofnVIPzSxBoyDMIscN0+Ihejrt5ax9pJLM+6UMIgz9VDAXa
/JhPUfcq9JMyEQN3VAMddS72pJMkLEEFjKAPYgBxpKQFyS08op+mgdQzBjJ+oouB
2tx9U1a5bjtcMxvF0wfuCqBhGUz3s1n3SiFkmkjBfh5qc2q9GG9D64g1kKxiFdHI
HHGcpic7pHUNz4Ym8B1w62PlnK7SLC9J4shF/z/MD0whu5YLyuFspdFeBxcW/Axg
rMFB8xsFQo5RvsvMrU6WiPSJj4NlMZKqEdCakXjevLvHu7x7Mgsjko96HW/qXCjV
S51OyulhmqM04emY1t3kqHmO/6F+QcPNvovMP+FrLN2MH1qSY91hamSI0NRVanZB
TFiK3q1UfeY7fgf+hzXlNhePcisunYo46CzItzZZMD7HhkxamwEEc6olAmO37vFh
M5igQu/+0pAR3UfWpmAiiG5cjG9diiKibgWYWTlhnTBhc28Zrc/vOP+7aZPlWuOw
Mv7X2FoZkHr9kYD1vpQ+i/Wl18FIeNMEzAlv33YAZnuoNmJgvnM=
=gP+z
-----END PGP SIGNATURE-----

--11bf7723ce2ee8c4dc9f5d8a9625e732e4266a15537986345fdef71c5bc5--

