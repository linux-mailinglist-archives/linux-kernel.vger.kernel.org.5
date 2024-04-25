Return-Path: <linux-kernel+bounces-158844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEB8B25A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE7A1C20F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B49C14C590;
	Thu, 25 Apr 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPUXXgrb"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B751CF8A;
	Thu, 25 Apr 2024 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060301; cv=none; b=KIqOdBD6sEa/th9wVM52nRPaQYqYamRTIoQiHIV+OevJCDsSW9HhzF0iGC1j1s0L4qNJAbsELKBiHQq+vqq6RCDflMiWb9OMUt+OrPMgL76yNDK27IyCiCb+yBobmPRghPRRIncE2w+N+BW7gphRPMKu3xCCXi3Kiz6nxePp4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060301; c=relaxed/simple;
	bh=0hp5G6xvVwt4HMO1TbayyF14wkdfzrJZCm/E9T9Qa+U=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UUbICHHae+68BKEbatstGIsENTwKRX9L34MdyPtcTPWLGR61seDd5a3G4d+EzkcvGHqPvDWCY1b+YG4dG6d9IfsINh8XYlRJmqycvYvVH93cr8VM0bOYZaRwiy9QAEmURd+SVNPAb+qnrlG1z6iaRIwR0FRcOaEsZs4vNWnUj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPUXXgrb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51a7d4466bso134865166b.2;
        Thu, 25 Apr 2024 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714060297; x=1714665097; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/b2FB40gZ9UoXXDLBfYVwwH31j6Sd6I/xgWTrngSl9w=;
        b=nPUXXgrbJALT4N2ehVB6pJfun3W0ijzvDYMdoaIDvHvJQ0OE3Vx5F5OpnTdKT1nbdM
         nxZY3HL3Y3PQFEYmetL41dhvbA/C5o8T2bMBLm8ZICyfRSwwlCfYPYC0fUwUD2Pm31H8
         O4nRZ3V5h0XBSa6ZZiu8TrKraG4FGWgCdJUoTrVyTLgATq9rOEQIz1YH8BRnDNnkVExJ
         cMbmQzsmzDUOZhCSE/HJNzsFj/dOsjchE2kQ6QGcznLWdItFu8vNV6XXRl0mmJXm3jLT
         gPoR6duGx54i4lnHOPv2TfJKBeK5eOJb60iwRI41WZW39/l4RARgqX7vZGk7i1dGe1FY
         c4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714060297; x=1714665097;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/b2FB40gZ9UoXXDLBfYVwwH31j6Sd6I/xgWTrngSl9w=;
        b=jUrSoh+L8TuH98I1oltZaISmqJHQLKSEU7xQbs+NtpKMD5dGW43vRw6eo5tCsWg5Sn
         8oJTTzYU+fIwxoRyHttktdB0xEc7sK3IXLLXmPnvbzO+iqQNPC8PNn+fn3FDW2Ee7efK
         Jnxl4D2aZodajC2t10WeKkW20n1TasVz1WKNPSWcQsPC7YrpJ/r/T/hMZwHm+anCE2jm
         fYlb6R8OOKrW/u1foNr+MFPLLtrgMunYb4glqae3KkP2FS2syb4GorPNBweN4OoHhD4q
         LwiPqM1O763qZ76zJVrSAK4Qo8DGmUoYub2rsotnDGbOa/AjGHWwYxvTrQFvW3AhsZTb
         NYsw==
X-Forwarded-Encrypted: i=1; AJvYcCXZPUz3aGqhD//mW0uVHiyhuOAZrrgCB8PzQar2VagJYhH3F53sX+6iWO+egOocrpJnkIDNPsUMOebTLepO6yazydEPDnVrlVlA9oSDu2EnLA0Ep2145fb8pkRMbzIwv1rflpwULNDLI+k=
X-Gm-Message-State: AOJu0YyUusY1FPH0jLqQLUvhIqfrSRcojNGKelPs/ZojQnR/PNX/h0vJ
	M9/J9pS1K2MmOg4tpJpHSN/aoVKbxipQOMzTKNYbrNBFY7iwLNuD
X-Google-Smtp-Source: AGHT+IEYJrJQred8loXtagHHMGud/MFZQ9gboWZwwj4xgr+yhT/f2MALdDM+4qKz2vTqnHX5Rlr2GQ==
X-Received: by 2002:a17:906:3102:b0:a55:aeb0:cb22 with SMTP id 2-20020a170906310200b00a55aeb0cb22mr141437ejx.9.1714060297423;
        Thu, 25 Apr 2024 08:51:37 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m5-20020a170906720500b00a522e8740ecsm9669327ejk.139.2024.04.25.08.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:51:37 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=0ea61d6b7b2992eb523dbf2c82bf822553583784ab9214b2a3467d39dc22;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 25 Apr 2024 17:51:36 +0200
Message-Id: <D0TBNXK9EZWR.4CK7BXEFV2WI@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>
Subject: Re: [Patch v3 1/2] dt-bindings: make sid and broadcast reg optional
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Sumit Gupta"
 <sumitg@nvidia.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
 <maz@kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>,
 <jonathanh@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-2-sumitg@nvidia.com>
 <d26f9661-3e50-4a72-9097-fe63a27503f1@linaro.org>
 <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com>
 <D0SILCYU98EV.1XW7NZFC9013K@gmail.com>
 <9561dede-37d0-4183-8742-448058803f8e@linaro.org>
 <D0T3R7UPFO07.2VR2436TG4N8B@gmail.com>
 <d8eb6652-18b5-4ed6-9a44-7c2a0f3bc3bb@linaro.org>
 <D0TANBDMJHH2.5XTXRZ09K4OU@gmail.com>
 <524f0bd3-1912-4a06-8c68-fea7ca563d68@linaro.org>
In-Reply-To: <524f0bd3-1912-4a06-8c68-fea7ca563d68@linaro.org>

--0ea61d6b7b2992eb523dbf2c82bf822553583784ab9214b2a3467d39dc22
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Apr 25, 2024 at 5:16 PM CEST, Krzysztof Kozlowski wrote:
> On 25/04/2024 17:03, Thierry Reding wrote:
> > On Thu Apr 25, 2024 at 11:45 AM CEST, Krzysztof Kozlowski wrote:
> >> On 25/04/2024 11:39, Thierry Reding wrote:
> >>> On Thu Apr 25, 2024 at 9:52 AM CEST, Krzysztof Kozlowski wrote:
> >>>> On 24/04/2024 19:04, Thierry Reding wrote:
> >>>>> On Wed Apr 24, 2024 at 6:26 PM CEST, Thierry Reding wrote:
> >>>>>> On Mon Apr 22, 2024 at 9:02 AM CEST, Krzysztof Kozlowski wrote:
> >>>>>>> On 12/04/2024 15:05, Sumit Gupta wrote:
> >>>>>>>> MC SID and Broadbast channel register access is restricted for G=
uest VM.
> >>>>>>>
> >>>>>>> Broadcast
> >>>>>>>
> >>>>>>>> Make both the regions as optional for SoC's from Tegra186 onward=
s.
> >>>>>>>
> >>>>>>> onward?
> >>>>>>>
> >>>>>>>> Tegra MC driver will skip access to the restricted registers fro=
m Guest
> >>>>>>>> if the respective regions are not present in the memory-controll=
er node
> >>>>>>>> of Guest DT.
> >>>>>>>>
> >>>>>>>> Suggested-by: Thierry Reding <treding@nvidia.com>
> >>>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >>>>>>>> ---
> >>>>>>>>  .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++--=
-------
> >>>>>>>>  1 file changed, 49 insertions(+), 46 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/devicetree/bindings/memory-controller=
s/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-contro=
llers/nvidia,tegra186-mc.yaml
> >>>>>>>> index 935d63d181d9..e0bd013ecca3 100644
> >>>>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra186-mc.yaml
> >>>>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra186-mc.yaml
> >>>>>>>> @@ -34,11 +34,11 @@ properties:
> >>>>>>>>            - nvidia,tegra234-mc
> >>>>>>>> =20
> >>>>>>>>    reg:
> >>>>>>>> -    minItems: 6
> >>>>>>>> +    minItems: 4
> >>>>>>>>      maxItems: 18
> >>>>>>>> =20
> >>>>>>>>    reg-names:
> >>>>>>>> -    minItems: 6
> >>>>>>>> +    minItems: 4
> >>>>>>>>      maxItems: 18
> >>>>>>>> =20
> >>>>>>>>    interrupts:
> >>>>>>>> @@ -151,12 +151,13 @@ allOf:
> >>>>>>>> =20
> >>>>>>>>          reg-names:
> >>>>>>>>            items:
> >>>>>>>> -            - const: sid
> >>>>>>>> -            - const: broadcast
> >>>>>>>> -            - const: ch0
> >>>>>>>> -            - const: ch1
> >>>>>>>> -            - const: ch2
> >>>>>>>> -            - const: ch3
> >>>>>>>> +            enum:
> >>>>>>>> +              - sid
> >>>>>>>> +              - broadcast
> >>>>>>>> +              - ch0
> >>>>>>>> +              - ch1
> >>>>>>>> +              - ch2
> >>>>>>>> +              - ch3
> >>>>>>>
> >>>>>>> I understand why sid and broadcast are becoming optional, but why=
 order
> >>>>>>> of the rest is now fully flexible?
> >>>>>>
> >>>>>> The reason why the order of the rest doesn't matter is because we =
have
> >>>>>> both reg and reg-names properties and so the order in which they a=
ppear
> >>>>>> in the list doesn't matter. The only thing that matters is that th=
e
> >>>>>> entries of the reg and reg-names properties match.
> >>>>>>
> >>>>>>> This does not even make sid/broadcast optional, but ch0!
> >>>>>>
> >>>>>> Yeah, this ends up making all entries optional, which isn't what w=
e
> >>>>>> want. I don't know of a way to accurately express this in json-sch=
ema,
> >>>>>> though. Do you?
> >>>>>>
> >>>>>> If not, then maybe we need to resort to something like this and al=
so
> >>>>>> mention explicitly in some comment that it is sid and broadcast th=
at are
> >>>>>> optional.
> >>>>>
> >>>>> Actually, here's another variant that is a bit closer to what we wa=
nt:
> >>>>>
> >>>>> --- >8 ---
> >>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/n=
vidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controlle=
rs/nvidia,tegra186-mc.yaml
> >>>>> index 935d63d181d9..86f1475926e4 100644
> >>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,t=
egra186-mc.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,t=
egra186-mc.yaml
> >>>>> @@ -34,11 +34,11 @@ properties:
> >>>>>            - nvidia,tegra234-mc
> >>>>> =20
> >>>>>    reg:
> >>>>> -    minItems: 6
> >>>>> +    minItems: 4
> >>>>>      maxItems: 18
> >>>>> =20
> >>>>>    reg-names:
> >>>>> -    minItems: 6
> >>>>> +    minItems: 4
> >>>>>      maxItems: 18
> >>>>> =20
> >>>>>    interrupts:
> >>>>> @@ -146,17 +146,21 @@ allOf:
> >>>>>      then:
> >>>>>        properties:
> >>>>>          reg:
> >>>>> +          minItems: 4
> >>>>>            maxItems: 6
> >>>>>            description: 5 memory controller channels and 1 for stre=
am-id registers
> >>>>> =20
> >>>>>          reg-names:
> >>>>> -          items:
> >>>>> -            - const: sid
> >>>>> -            - const: broadcast
> >>>>> -            - const: ch0
> >>>>> -            - const: ch1
> >>>>> -            - const: ch2
> >>>>> -            - const: ch3
> >>>>> +          anyOf:
> >>>>> +            - items:
> >>>>> +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3 ]
> >>>>> +              uniqueItems: true
> >>>>> +              minItems: 6
> >>>>> +
> >>>>> +            - items:
> >>>>> +                enum: [ ch0, ch1, ch2, ch3 ]
> >>>>> +              uniqueItems: true
> >>>>> +              minItems: 4
> >>>>> =20
> >>>>>    - if:
> >>>>>        properties:
> >>>>> @@ -165,29 +169,22 @@ allOf:
> >>>>>      then:
> >>>>>        properties:
> >>>>>          reg:
> >>>>> -          minItems: 18
> >>>>> +          minItems: 16
> >>>>>            description: 17 memory controller channels and 1 for str=
eam-id registers
> >>>>> =20
> >>>>>          reg-names:
> >>>>> -          items:
> >>>>> -            - const: sid
> >>>>> -            - const: broadcast
> >>>>> -            - const: ch0
> >>>>> -            - const: ch1
> >>>>> -            - const: ch2
> >>>>> -            - const: ch3
> >>>>> -            - const: ch4
> >>>>> -            - const: ch5
> >>>>> -            - const: ch6
> >>>>> -            - const: ch7
> >>>>> -            - const: ch8
> >>>>> -            - const: ch9
> >>>>> -            - const: ch10
> >>>>> -            - const: ch11
> >>>>> -            - const: ch12
> >>>>> -            - const: ch13
> >>>>> -            - const: ch14
> >>>>> -            - const: ch15
> >>>>> +          anyOf:
> >>>>> +            - items:
> >>>>> +                enum: [ sid, broadcast, ch0, ch1, ch2, ch3, ch4, c=
h5, ch6, ch7,
> >>>>> +                        ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch=
15 ]
> >>>>> +              minItems: 18
> >>>>> +              uniqueItems: true
> >>>>> +
> >>>>> +            - items:
> >>>>> +                enum: [ ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch=
8, ch9, ch10,
> >>>>> +                        ch11, ch12, ch13, ch14, ch15 ]
> >>>>> +              minItems: 16
> >>>>> +              uniqueItems: true
> >>>>
> >>>> No, because order is strict.
> >>>
> >>> Why? I realize that prior to this the order was indeed strict and it'=
s
> >>
> >> That's the policy for entire Devicetree. I said why in other email:
> >> because any bindings consumer can take it via indices.
> >>
> >>> common to have these listed in strict order in the DTS files. However=
,
> >>> this is an arbitrary restriction that was introduced in the patch tha=
t
> >>> added reg-names. However, */*-names properties have always assumed th=
e
> >>> ordering to be non-strict because each entry from the * property gets
> >>> matched up with the corresponding entry in the *-names property, so t=
he
> >>> ordering is completely irrelevant.
> >>
> >> This was raised so many times... reg-names is just a helper. It does n=
ot
> >> change the fact that order should be strict and if binding defined the
> >> order, it is an ABI.
> >=20
> > Sorry, but that's not how we've dealt with this in the past. Even thoug=
h
> > this was now ten or more years ago, I distinctly recall that when we
> > started adding these *-names properties and at the time it was very muc=
h
> > implied that the order didn't matter.
>
> Then you added it wrong and Rob was expressing the purpose of names
> multiple times. The names were for cases when you could not determine
> the order.
>
> The strict order was repeated so many times in the mailing list, I lost
> track.

Sorry, but this isn't true. Perhaps the device tree maintainers' stance
on this has changed over the years, but don't go around telling people
that they did things wrongly when all they were doing was follow what
was considered best practice at the time.

> > The only use-case that I know of where order was always meant to matter
> > is backwards-compatibility for devices that used to have a single entry
> > (hence drivers couldn't rely on *-names to resolve the index) and then
> > had additional entries added. The *-names entry for that previously
> > single entry would now obviously have to always be first in the list to
> > preserve backwards-compatibility.
> >=20
> > Besides, if reg-names was really only a helper, then it would also be
> > completely redundant. Many device tree bindings have *-names properties
> > marked as "required" precisely because of the role that they serve.
>
> For most of the cases, so ones which do not have flexible order, it is
> redundant and for that reason Qualcomm has been switching away from
> xxx-names in several drivers.
>
> However it is not entirely redundant, because it allows bindings
> consumers to choose either index or name. Both are ABI, when documented
> in the binding with strict order.
>
> https://lore.kernel.org/all/CAL_JsqJSYAsotjzvOUy_f7ZRfsSrfZyuEzq7eRwwKk12=
FBgxYg@mail.gmail.com/

You do realize that "flexible order" is entirely defined by the
bindings, right? There's nothing inherently strict in any of this. The
bindings define any order (or lack thereof) that entries should be
listed in and the drivers that implement the bindings need to respect
whatever the bindings specify.

Thierry

--0ea61d6b7b2992eb523dbf2c82bf822553583784ab9214b2a3467d39dc22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYqfAkACgkQ3SOs138+
s6FXqxAAkJDvAcIbZaZUF/25AXaBMdBdWASugLpb3JOpICjERq7RYP3GujmPiA3y
gw7/2AV/7fJTo39YRchh5E94VGOtaRYO1tME09szp5N/wooIlKzjBuOpmTQJzgSW
+8T7j4/YR8EhTYPDFsu87e7kaH0A1mdGPeLptNE6ODkKvulOPMWiIqc+WjoNeIae
5Rl2bHKfGmQIL56MxqPCgVJI2KKUJYVdWa379pyJUgc2XwLrVzHbgrcZnFRHWEmO
L8rKmDoUpOgI/Qf7NqOOg/4sPudgyKaCgyXIQOL0Cq4ZAw8LuBnyvfJ8Ne00Z5tZ
NVY3fDOCgbcb1rH+zAaas/rn8J3wJ3nLlEnhuvAse7w2wRU70BiDPHErLM1zFzTr
N7nJYdGUQCHi93+wEvS8HiZVgm73M60bXr5uMxopupFBrXnWMV24G/dUlU/UFFVu
Jrj/CwAFVDBJpM5MdXYLefq+vFgNUgT3/lqr4eTm80YDkfXtdCoG9AwSJEow8E40
ywJCQmThBd4zpq3sMOP/PRevXra1JmzvOc3UM5qxU4a4F6v15/NCL7OnUkWbBOGf
hsZujIFzzUlz4zlzQDt0yD9yaKu1FA4L/OQqTt8tH8XmV2QMWBs/F8eLJRoMWHKr
jErRD3honmD57rZu014UL4Wrfb8ZZ0xc8PkcwlmVkygxXrtKcuI=
=KUEz
-----END PGP SIGNATURE-----

--0ea61d6b7b2992eb523dbf2c82bf822553583784ab9214b2a3467d39dc22--

