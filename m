Return-Path: <linux-kernel+bounces-158758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CE8B248E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C38DB28B65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0714AD1E;
	Thu, 25 Apr 2024 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fot1aUMh"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FEF14A615;
	Thu, 25 Apr 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057432; cv=none; b=ECw84EoK63AjwtAaKl+gD8159Bf3A2J93nBkoZ/F32FXXtaKhtyYnWyzOiT+UBYaDgdx3yfvNwjCjBrXDa3x/cMe3+VuDE+uHYdCgDs06XjZUcil/vyeUEXI7MBUMbYyB4iiU9OcnJvFPNtKfCPA4k4c6lvhUz32PRtzd4zaR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057432; c=relaxed/simple;
	bh=GcRbdXl0rmPhjiuwrZGvFa957/csXHQflpxApSdTgCo=;
	h=Content-Type:Mime-Version:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ZYYkMCTnS0COp42Y3Q05oOkh5BO6yHgLpKFkuUoh1y5zkHxYNKdzs1WQSiz6HUMKdJnjMUN+U+0wWrnyGiT7xiRZxjW1yvz33dNtx2nxhPOG1Tiad2R9rKm9l+vsFwDDYZCrizuqxzo+1CnMcNSR3g1hJnaLDbLIrxZZj0+YLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fot1aUMh; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d895138d0eso9627911fa.1;
        Thu, 25 Apr 2024 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714057429; x=1714662229; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E5/1Zaj1KusKfv2rAekeWGYR5nnXdf4Irx4EgUVd/wk=;
        b=fot1aUMhKke8snN7SF6MyLuhqBWZrg+U6A/qTE8Uin9LhzGM0Js7g3Pl6KXhHopQqE
         w3ptMbNjq21HDaCnVnzsax2ZWE0lR0KeWP+CaByB2g1ENEFF2nOpVOPq16XDgeQ1Egey
         xOHPU4N7ESz9Vu8bWbQmawNLGoXMSQHW+n8Nxhvydw8J7EbeNJRA5pF5kfTJrOx5EcbP
         pxbN5ZQ934ssKGBsUr6BQFwOyGZMPkX0BVFGeMDb8nGQ3LK51GWgfCZw18PL/eObVkD7
         Hiog+Qmp3adgKo3uqQ+fXU5Jc/IBZ9r7LzvLwE7S4+lw9lV4dYv1czG5luNXFwWxXIg8
         1iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714057429; x=1714662229;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5/1Zaj1KusKfv2rAekeWGYR5nnXdf4Irx4EgUVd/wk=;
        b=Ocqnj/tu/q+z2Y5wFQjB9M+FzKrV4epDyDeB76xU31CwBPOc3PvDynb9b3f+f1QLG6
         bwUdJplHADHq/b2pOEElYx9uL+Cs3c6BQkwfHVlu1FXcDhjLVnjCAOIPnDWriWJsCm7p
         S9eWn311WVrXMuzq7HbtTUwPllo0YieCG8IfD3QJqpb9dWZVKfnxV4Tq4zgzKYioTp7a
         5XExFuPPC2L9wQxwjEBQRT11uWm/BdIVrdGGgJD95pdFgbutgZg6iYLMHKVscf0aosQ+
         K9Yall7EIcEpDIhLnv32iE0xqeVlN2NHq44hQUX5mGxELRxJh3eYVdIcHsAPdPK0X5jZ
         DKRg==
X-Forwarded-Encrypted: i=1; AJvYcCXdlrWdKuQczNE2mfUtRlTaVtW7CuhfSgH916QO5FPVzEYLGpGx5cIzxOlUYFz7XnNNfWZTtbRCuMuVZPLx5exbCbidKeVI3r8/g2DhI+UJLRKtIXGet5FtX902V2Sg2E2/b8FwT3/8yP4=
X-Gm-Message-State: AOJu0YwKdGhWfbwjYll33vnTWL0S3gHDgnnkmEHR3DvFZV9UALsI6kmT
	j1aQq464QheVaH1ajcEC+N6HyJv8TScoNZxq3b0mxTtQMopJy7eL
X-Google-Smtp-Source: AGHT+IFY4RyIf3OHopmsRc7rXC6+GtWgSIZ9vG0woJBF9n/oHB9hlkRPyqMEggdm/LPuWdwx4l18PA==
X-Received: by 2002:a2e:b60a:0:b0:2da:38e:f809 with SMTP id r10-20020a2eb60a000000b002da038ef809mr3795766ljn.52.1714057428266;
        Thu, 25 Apr 2024 08:03:48 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b00414659ba8c2sm27910546wmq.37.2024.04.25.08.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:03:47 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=0a003b88e518e591a0130d80c72408215230c45ba769297ac394215a4c0d;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 25 Apr 2024 17:03:46 +0200
Message-Id: <D0TANBDMJHH2.5XTXRZ09K4OU@gmail.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Sumit Gupta"
 <sumitg@nvidia.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
 <maz@kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>,
 <jonathanh@nvidia.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>
Subject: Re: [Patch v3 1/2] dt-bindings: make sid and broadcast reg optional
From: "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-2-sumitg@nvidia.com>
 <d26f9661-3e50-4a72-9097-fe63a27503f1@linaro.org>
 <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com>
 <D0SILCYU98EV.1XW7NZFC9013K@gmail.com>
 <9561dede-37d0-4183-8742-448058803f8e@linaro.org>
 <D0T3R7UPFO07.2VR2436TG4N8B@gmail.com>
 <d8eb6652-18b5-4ed6-9a44-7c2a0f3bc3bb@linaro.org>
In-Reply-To: <d8eb6652-18b5-4ed6-9a44-7c2a0f3bc3bb@linaro.org>

--0a003b88e518e591a0130d80c72408215230c45ba769297ac394215a4c0d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Apr 25, 2024 at 11:45 AM CEST, Krzysztof Kozlowski wrote:
> On 25/04/2024 11:39, Thierry Reding wrote:
> > On Thu Apr 25, 2024 at 9:52 AM CEST, Krzysztof Kozlowski wrote:
> >> On 24/04/2024 19:04, Thierry Reding wrote:
> >>> On Wed Apr 24, 2024 at 6:26 PM CEST, Thierry Reding wrote:
> >>>> On Mon Apr 22, 2024 at 9:02 AM CEST, Krzysztof Kozlowski wrote:
> >>>>> On 12/04/2024 15:05, Sumit Gupta wrote:
> >>>>>> MC SID and Broadbast channel register access is restricted for Gue=
st VM.
> >>>>>
> >>>>> Broadcast
> >>>>>
> >>>>>> Make both the regions as optional for SoC's from Tegra186 onwards.
> >>>>>
> >>>>> onward?
> >>>>>
> >>>>>> Tegra MC driver will skip access to the restricted registers from =
Guest
> >>>>>> if the respective regions are not present in the memory-controller=
 node
> >>>>>> of Guest DT.
> >>>>>>
> >>>>>> Suggested-by: Thierry Reding <treding@nvidia.com>
> >>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >>>>>> ---
> >>>>>>  .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++----=
-----
> >>>>>>  1 file changed, 49 insertions(+), 46 deletions(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/=
nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controll=
ers/nvidia,tegra186-mc.yaml
> >>>>>> index 935d63d181d9..e0bd013ecca3 100644
> >>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,=
tegra186-mc.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,=
tegra186-mc.yaml
> >>>>>> @@ -34,11 +34,11 @@ properties:
> >>>>>>            - nvidia,tegra234-mc
> >>>>>> =20
> >>>>>>    reg:
> >>>>>> -    minItems: 6
> >>>>>> +    minItems: 4
> >>>>>>      maxItems: 18
> >>>>>> =20
> >>>>>>    reg-names:
> >>>>>> -    minItems: 6
> >>>>>> +    minItems: 4
> >>>>>>      maxItems: 18
> >>>>>> =20
> >>>>>>    interrupts:
> >>>>>> @@ -151,12 +151,13 @@ allOf:
> >>>>>> =20
> >>>>>>          reg-names:
> >>>>>>            items:
> >>>>>> -            - const: sid
> >>>>>> -            - const: broadcast
> >>>>>> -            - const: ch0
> >>>>>> -            - const: ch1
> >>>>>> -            - const: ch2
> >>>>>> -            - const: ch3
> >>>>>> +            enum:
> >>>>>> +              - sid
> >>>>>> +              - broadcast
> >>>>>> +              - ch0
> >>>>>> +              - ch1
> >>>>>> +              - ch2
> >>>>>> +              - ch3
> >>>>>
> >>>>> I understand why sid and broadcast are becoming optional, but why o=
rder
> >>>>> of the rest is now fully flexible?
> >>>>
> >>>> The reason why the order of the rest doesn't matter is because we ha=
ve
> >>>> both reg and reg-names properties and so the order in which they app=
ear
> >>>> in the list doesn't matter. The only thing that matters is that the
> >>>> entries of the reg and reg-names properties match.
> >>>>
> >>>>> This does not even make sid/broadcast optional, but ch0!
> >>>>
> >>>> Yeah, this ends up making all entries optional, which isn't what we
> >>>> want. I don't know of a way to accurately express this in json-schem=
a,
> >>>> though. Do you?
> >>>>
> >>>> If not, then maybe we need to resort to something like this and also
> >>>> mention explicitly in some comment that it is sid and broadcast that=
 are
> >>>> optional.
> >>>
> >>> Actually, here's another variant that is a bit closer to what we want=
:
> >>>
> >>> --- >8 ---
> >>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvi=
dia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers=
/nvidia,tegra186-mc.yaml
> >>> index 935d63d181d9..86f1475926e4 100644
> >>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,teg=
ra186-mc.yaml
> >>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,teg=
ra186-mc.yaml
> >>> @@ -34,11 +34,11 @@ properties:
> >>>            - nvidia,tegra234-mc
> >>> =20
> >>>    reg:
> >>> -    minItems: 6
> >>> +    minItems: 4
> >>>      maxItems: 18
> >>> =20
> >>>    reg-names:
> >>> -    minItems: 6
> >>> +    minItems: 4
> >>>      maxItems: 18
> >>> =20
> >>>    interrupts:
> >>> @@ -146,17 +146,21 @@ allOf:
> >>>      then:
> >>>        properties:
> >>>          reg:
> >>> +          minItems: 4
> >>>            maxItems: 6
> >>>            description: 5 memory controller channels and 1 for stream=
-id registers
> >>> =20
> >>>          reg-names:
> >>> -          items:
> >>> -            - const: sid
> >>> -            - const: broadcast
> >>> -            - const: ch0
> >>> -            - const: ch1
> >>> -            - const: ch2
> >>> -            - const: ch3
> >>> +          anyOf:
> >>> +            - items:
> >>> +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3 ]
> >>> +              uniqueItems: true
> >>> +              minItems: 6
> >>> +
> >>> +            - items:
> >>> +                enum: [ ch0, ch1, ch2, ch3 ]
> >>> +              uniqueItems: true
> >>> +              minItems: 4
> >>> =20
> >>>    - if:
> >>>        properties:
> >>> @@ -165,29 +169,22 @@ allOf:
> >>>      then:
> >>>        properties:
> >>>          reg:
> >>> -          minItems: 18
> >>> +          minItems: 16
> >>>            description: 17 memory controller channels and 1 for strea=
m-id registers
> >>> =20
> >>>          reg-names:
> >>> -          items:
> >>> -            - const: sid
> >>> -            - const: broadcast
> >>> -            - const: ch0
> >>> -            - const: ch1
> >>> -            - const: ch2
> >>> -            - const: ch3
> >>> -            - const: ch4
> >>> -            - const: ch5
> >>> -            - const: ch6
> >>> -            - const: ch7
> >>> -            - const: ch8
> >>> -            - const: ch9
> >>> -            - const: ch10
> >>> -            - const: ch11
> >>> -            - const: ch12
> >>> -            - const: ch13
> >>> -            - const: ch14
> >>> -            - const: ch15
> >>> +          anyOf:
> >>> +            - items:
> >>> +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3, ch4, ch5=
, ch6, ch7,
> >>> +                        ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15=
 ]
> >>> +              minItems: 18
> >>> +              uniqueItems: true
> >>> +
> >>> +            - items:
> >>> +                enum: [ ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8,=
 ch9, ch10,
> >>> +                        ch11, ch12, ch13, ch14, ch15 ]
> >>> +              minItems: 16
> >>> +              uniqueItems: true
> >>
> >> No, because order is strict.
> >=20
> > Why? I realize that prior to this the order was indeed strict and it's
>
> That's the policy for entire Devicetree. I said why in other email:
> because any bindings consumer can take it via indices.
>
> > common to have these listed in strict order in the DTS files. However,
> > this is an arbitrary restriction that was introduced in the patch that
> > added reg-names. However, */*-names properties have always assumed the
> > ordering to be non-strict because each entry from the * property gets
> > matched up with the corresponding entry in the *-names property, so the
> > ordering is completely irrelevant.
>
> This was raised so many times... reg-names is just a helper. It does not
> change the fact that order should be strict and if binding defined the
> order, it is an ABI.

Sorry, but that's not how we've dealt with this in the past. Even though
this was now ten or more years ago, I distinctly recall that when we
started adding these *-names properties and at the time it was very much
implied that the order didn't matter.

The only use-case that I know of where order was always meant to matter
is backwards-compatibility for devices that used to have a single entry
(hence drivers couldn't rely on *-names to resolve the index) and then
had additional entries added. The *-names entry for that previously
single entry would now obviously have to always be first in the list to
preserve backwards-compatibility.

Besides, if reg-names was really only a helper, then it would also be
completely redundant. Many device tree bindings have *-names properties
marked as "required" precisely because of the role that they serve.

Thierry

--0a003b88e518e591a0130d80c72408215230c45ba769297ac394215a4c0d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYqcNMACgkQ3SOs138+
s6FoSg//Wac2hlyCg8ZwVjTvYTsFfjus5REQ8iUcO81kHtEwiC884J27E5ufC9zu
Uadobj7eb4YC646DkI/qDwgYMLylrzQAfTTJcRvV+y/BRxH8P5cl3/SJh6gAf2cH
ER6pspuOwGmmkEGS4Q8JmlgQzZlg4y+SzGDT7YQRUKWa9B4xhRIeerVnZCpu3rmW
kvGNe0/cvkgYUwbyr1If/hJQN+QtEKIr+wxzRtPourIffXBLaXpJ2mxKltkU2DyO
hPusV7UJwdF3Mhlpp/G94XdiUDU5hPrZubcSV+iP+LtxZp+pth0HUGdAVypT7HKw
aaaJ7G7pf0jmgc9UR0WccqkT831B/ambW2LJW63Uy4l0oxcjEfXoFmLo5K4EixCt
vjxjvYK08T3kTgU0sXg1BBRhZfF3iryPFJQGqlvF4lszUOWQNxOgRZBmI8dn4wud
PYzz1orsFlOssa6tdhJ11M17cXPJ0xiH7XH3GUhWZZkUFoexqci9xsFYY4LH/n9U
GADqq3nVsY2hDZDDW8EFZKn82lTb+JWAoD+W9ItunRhzp71CmlzWA59lLd8ba/+n
NLFaWlt7fw0R2lmNDP/v0De/swQC/Sd3q1nVO9uI4Ymf03Gm1EfuaWD75oDEpbsn
qJy1EUqvwkh8cHJJDHnzP7i2jWhcEDahUNUwzJ8DZnU4rSKNKns=
=L5Ll
-----END PGP SIGNATURE-----

--0a003b88e518e591a0130d80c72408215230c45ba769297ac394215a4c0d--

