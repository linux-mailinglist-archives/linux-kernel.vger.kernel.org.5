Return-Path: <linux-kernel+bounces-157313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACE08B0FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CE4281744
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E08159576;
	Wed, 24 Apr 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc4n6SoB"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B4915EFCC;
	Wed, 24 Apr 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975967; cv=none; b=rPe464n6V0UagO8JvQ5KNjUl17XFcd0fBTMBhk/HBwnkrUPStWeDWWVjl9w5rELpuxjccQU67Uq1IXxpLuBUa7AAxxkk0zXs8qLsYcMmIMAliv/ZNAXdtKsn6w9HOLj+zYNhf0UejqXbtMcGlI36NAi3eGt73glEStdUIFuKU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975967; c=relaxed/simple;
	bh=gP4mMntValkqDQMqIfmMFvbL8AE1ZP3kkKaH1beDZaI=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lunkZLeW0Fsp6e9JvN41FT8jdcM6BCRHWw0DyciKeNGftKj5ro/xzCe85rW7/VjlSJitoEmeDqC/bwQ3AYDerj+TtHSTl2UW3x7FE+pCv0YSRVcYWcAFeL5B9SN9SIkVGPmkx2US+gcDvLsaX8pgAw2asjHZjd9d+T0rXVWt+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc4n6SoB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so93296321fa.2;
        Wed, 24 Apr 2024 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975963; x=1714580763; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ISBo2m0d8ahl9D2i8C93sDQpbwRxzQ4Rapk/1JY7eWo=;
        b=Wc4n6SoBYhDpYmPO++ZDnLgMs7EiTT701+rNguDAExO58UWI4De+Cm2ZR9Ik7Ptukt
         1gGmKkg1B+yl+NFkBqC2WZbEpzBU7+v/ydp/62MgiFjcALzJmkI7B2vu9JRKGTtccKsg
         +63l41oW8Ze86RSK+4B/GVGfxYsiNY+0FEJytWo4Q3qadKUun12O16XhlqUSZeVFIL8S
         xfs2T01XwUXR5gtNNiGtDw2rilycC+RoLmL1xMNbCWcH+n8DuT+KZaF7wW5EY2lhqPkE
         QdkjqsgdMnUvNfKVNHvkQfCIg1d0rGG7Ro88AKqezxznVXEP7uBRhHlJDKVkXXo2g0At
         SvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975963; x=1714580763;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISBo2m0d8ahl9D2i8C93sDQpbwRxzQ4Rapk/1JY7eWo=;
        b=ElboJKxaynKMuWkwoI+vI+1b9MJxBetxIzenbra23aF+jRM4vMscLNilDTBDrfA4mI
         qsoUTYHvnE9hB8aSpW1zYHRkIcdoFFkRqR8whxpbAQAVNigrBlDz4iezkRPSCocCk+h0
         2vEcAj0apAG6Zm2kVJx+v0jrZPbuZyHbB+4q1PqdHpn5e1RBucve2fbBZQ7Pof/4vNlE
         MthpQBlOMmGpdI1E6Ux/pvhHGw/mkJnnAAl8WYoJ4uiZlb1joRKCOlpRl0CRiNCXcb7H
         jc9H8yCteaufpHrRXCMdBlXHfxgUQdcbfVGGv7fd9+Dba3ax2ncGEvTfVyBs/zMhj2hv
         TrOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhnIrFGgL53AFxO63oE5PTvSG9zwaSbEloIWJt6aWDDtumIlqJZTrnqe+UDqdp0G7SWvcTqXHHoPcrGHP27/j52WaiGAW/r5f/us5GWAw4dnMc2EzDdftJIXdvE9sgpaX7gd7acsddLUo=
X-Gm-Message-State: AOJu0YyAWSAGp1Yr04/6mtKytkrUPX8u+TwIvj86/Z3ja2oFmV1Z+pgu
	eBqV0xeK9nUIXt76vrSqp1/IN23WduyYG8UabVT6WSE37lsr9jwM
X-Google-Smtp-Source: AGHT+IFoIL3diMSNcpcMTpKoxE8rPj3sYBmtgBGxHORX/lJgCJCCKlRdukkxdb/H2Qn0QLKV8oSeug==
X-Received: by 2002:a2e:b5a6:0:b0:2dd:8eb5:dcd5 with SMTP id f6-20020a2eb5a6000000b002dd8eb5dcd5mr1714161ljn.14.1713975963164;
        Wed, 24 Apr 2024 09:26:03 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i19-20020a50fc13000000b0056fed8e7817sm7883063edr.20.2024.04.24.09.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:26:02 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=6ba2911ab0d9061d591e2d0178dd10ab327ff50a605e39dd9da24fd42a86;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 24 Apr 2024 18:26:01 +0200
Message-Id: <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com>
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
In-Reply-To: <d26f9661-3e50-4a72-9097-fe63a27503f1@linaro.org>

--6ba2911ab0d9061d591e2d0178dd10ab327ff50a605e39dd9da24fd42a86
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Apr 22, 2024 at 9:02 AM CEST, Krzysztof Kozlowski wrote:
> On 12/04/2024 15:05, Sumit Gupta wrote:
> > MC SID and Broadbast channel register access is restricted for Guest VM=
.
>
> Broadcast
>
> > Make both the regions as optional for SoC's from Tegra186 onwards.
>
> onward?
>
> > Tegra MC driver will skip access to the restricted registers from Guest
> > if the respective regions are not present in the memory-controller node
> > of Guest DT.
> >=20
> > Suggested-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
> >  .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++---------
> >  1 file changed, 49 insertions(+), 46 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/n=
vidia,tegra186-mc.yaml
> > index 935d63d181d9..e0bd013ecca3 100644
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
> > @@ -151,12 +151,13 @@ allOf:
> > =20
> >          reg-names:
> >            items:
> > -            - const: sid
> > -            - const: broadcast
> > -            - const: ch0
> > -            - const: ch1
> > -            - const: ch2
> > -            - const: ch3
> > +            enum:
> > +              - sid
> > +              - broadcast
> > +              - ch0
> > +              - ch1
> > +              - ch2
> > +              - ch3
>
> I understand why sid and broadcast are becoming optional, but why order
> of the rest is now fully flexible?

The reason why the order of the rest doesn't matter is because we have
both reg and reg-names properties and so the order in which they appear
in the list doesn't matter. The only thing that matters is that the
entries of the reg and reg-names properties match.

> This does not even make sid/broadcast optional, but ch0!

Yeah, this ends up making all entries optional, which isn't what we
want. I don't know of a way to accurately express this in json-schema,
though. Do you?

If not, then maybe we need to resort to something like this and also
mention explicitly in some comment that it is sid and broadcast that are
optional.

Thierry

--6ba2911ab0d9061d591e2d0178dd10ab327ff50a605e39dd9da24fd42a86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYpMpoACgkQ3SOs138+
s6GyxxAAoN6Z69DQJQGqGUJCL6invi972MVm5AggYBlXmwj+NYR7dqdKsYmMBrG5
7o2ODlJotzRPauv3NHWwOPg0RwFZw8yMvgVtNnY2bAUzGJphP7tTO7pN+EzS9V9e
CX9tMg+8eUjO2ArnothckaFH4VFus1MAVOdcy0jm9HiE/9mj0L3sJ4Z+0PY6F29I
31X1nkWersqcSuPEc3fO7xCMge8hWBSIpl1DHFwZYcgfW1RvjzQ99VDC3fsW0zS1
9VTu0pDeWnh4LBpwk6NxD7mGjEhcbMH7Dh3vo11uqIF9eyXE3cLSEZjuWxbfea/a
HwOZpTQYq7yH3fsbxAQHPvKW85ZOvgpzdJiHEd2DdPrFjNY06+/xx0tSoHNS1bCN
T4AhOYLDMCyu7eh5uHqmLG9K7f6OpIZYkcgtAR+55z/IR2r6PLUKMXZcGtNK+L25
G736aaFvywp9xxpnWNAzmQZPMwTfGtiWVhJcVNG9tw0bjNhar6sJlfag0TQIeSOr
DDt7kNUuiypkyyfhTxXaeIpV2FU1hu8Xh0AmvpI/8xuSB4H6lm1ZW0hCE4zF0dyA
QSqG3aMEPTQ4BadPJvJ4rK6dlk9AHT9dEHdDeaG7AFGFMxmhXVpGaG+TmFNn+78x
x0RILdoILw1iKzZMhW2emocJXqfXBan7530waOFbXI3UT8RwIbQ=
=wRVU
-----END PGP SIGNATURE-----

--6ba2911ab0d9061d591e2d0178dd10ab327ff50a605e39dd9da24fd42a86--

