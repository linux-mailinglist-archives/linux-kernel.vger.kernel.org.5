Return-Path: <linux-kernel+bounces-157369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCC8B109E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0B21C208F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23316D317;
	Wed, 24 Apr 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuNHbrpv"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB413C672;
	Wed, 24 Apr 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978287; cv=none; b=NBF3zqG0gAKhM443YM70evpRC1+IDj71ifr8wbUWYQu304bAJQMBZPZjY7IRo8+mTkV5bF09lhsEX8MkL4qDZbKmTa50VZdVU1Vb/MkZgIPGiDiw6k+jrUKwSFbMjJwJqATgxyUGCKQlkKsVxOuuipS0wF+oO+daAgwoHv7LDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978287; c=relaxed/simple;
	bh=Id8sT4db2LqP80zZLECjY6g1FF24I7tMOws9iH4AJmI=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lJTyj+Gc1rKKsBuML19KWTGIEYxx0F2DbxYG/W0c9lF+xW0X8w5nPNpNCQ2RaaPFh3H/tVEqXxBpk7m8xgilZbgHXArDP5icGZjI/cRrm4gcAEdV2OfR5Neh9Bs1vQJ40jUBHZ306gZkdjyj2L+HnWXMmqWWOx3ExTU4isjbBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuNHbrpv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516ef30b16eso11443e87.3;
        Wed, 24 Apr 2024 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713978284; x=1714583084; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VF41tUPHy2HmLxlT+/t3X6Tlvi3X0iCS/E9nneLNb3w=;
        b=MuNHbrpvlAKfUTas4odfIoiAaImfvK3K8lvxVf4jgrcsPBlwjgendaZuEVcTH/YXTn
         Fkc0CwxgmS1z8gNwKmtLd7wDXyWb+kBADboilslCUwpAPJRSSLUzJ/qkVQkk8K3Zy4Pc
         MWNypB9jcAgBa3eyN+0UODUqD27olkEr+a7rRw3y/r33ARTvGZD0JtoGjSlpjNSxEdlf
         WUXDlkY396qqFEGMAsBtpkKK3nMpbvJvNnaBajUDsEi+sI/aExPm1hpw6PruBPGXqTwH
         sjkMvMFFIeg3FBMDwd4zyOpjCMDfTS/MMjb9POoX8xkAHmkGWnua5oyv48e4sRlagO5L
         5LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713978284; x=1714583084;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VF41tUPHy2HmLxlT+/t3X6Tlvi3X0iCS/E9nneLNb3w=;
        b=LWrtXeOpghXsC5X7LE3xphewyzM6Cz0Ka7KDU6AbnUYet1E9VosRWzJlho7o12pgmQ
         rcSMqY6Fsu5mXglzIro3AjZuHzCckqKwvwkaW9HSfjr/ITP9/ELG3PA6Vd/eyUvg72J8
         DCPrijcCiKf3Lbg4c0PhjaAXU2JesWW/y+y4CVF3eN7l/qP7WJ7IUTxo5ApaXfiUzx7a
         uhv0PlkMMfVl99mRxYoGvMwiia8HxHo87fsXKbrfuICzjIKRgy7cgMJsXjLTdOZsykB2
         r6FLq2b8kYXllWc7dlncAfJix0bm88PIxryrqSkS/uXlpAm6ib8zJp0c8RLEqEHNhGAN
         L9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfcjl7F9bXgZS50ymvudYxcKRqnk0WmHezdKfj8fEeVgfY4HDRWWQYq/oML+JWcL+X/1JsKg1enlDIfKLirGY0BnNcpUWPPhwrNK7fD0DHGowJBwnnc+6LNRdY9nhNU2FgtikeQ7RiW/0=
X-Gm-Message-State: AOJu0Yxh3e3SjzdZQ5WJNeJ8KgD6ngdi7M+wCQG640bfFMsbbLh0zkW7
	hpmZZOEP9ezKNxr5W3uygrOzxAxtJPxlTHqqHHwDhOLH4z9nYisi8PhWwg==
X-Google-Smtp-Source: AGHT+IEGFIQrJ0m7gp08VPzJVQ5ztjQE07sLPmXRGlTwAupJUsL6jTbDawnXZ4bWJnbrnXUpLvK+0w==
X-Received: by 2002:a19:f614:0:b0:51b:812:3c87 with SMTP id x20-20020a19f614000000b0051b08123c87mr2042515lfe.39.1713978283800;
        Wed, 24 Apr 2024 10:04:43 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bl20-20020a170906c25400b00a55358244ffsm8560064ejb.204.2024.04.24.10.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 10:04:43 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=27a536f2ded1841e1102a6eb72a0909ec5f63895e697412a751d7f830ae9;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 24 Apr 2024 19:04:42 +0200
Message-Id: <D0SILCYU98EV.1XW7NZFC9013K@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>
Subject: Re: [Patch v3 1/2] dt-bindings: make sid and broadcast reg optional
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Thierry Reding" <thierry.reding@gmail.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Sumit Gupta" <sumitg@nvidia.com>,
 <robh@kernel.org>, <conor+dt@kernel.org>, <maz@kernel.org>,
 <mark.rutland@arm.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-2-sumitg@nvidia.com>
 <d26f9661-3e50-4a72-9097-fe63a27503f1@linaro.org>
 <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com>
In-Reply-To: <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com>

--27a536f2ded1841e1102a6eb72a0909ec5f63895e697412a751d7f830ae9
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Apr 24, 2024 at 6:26 PM CEST, Thierry Reding wrote:
> On Mon Apr 22, 2024 at 9:02 AM CEST, Krzysztof Kozlowski wrote:
> > On 12/04/2024 15:05, Sumit Gupta wrote:
> > > MC SID and Broadbast channel register access is restricted for Guest =
VM.
> >
> > Broadcast
> >
> > > Make both the regions as optional for SoC's from Tegra186 onwards.
> >
> > onward?
> >
> > > Tegra MC driver will skip access to the restricted registers from Gue=
st
> > > if the respective regions are not present in the memory-controller no=
de
> > > of Guest DT.
> > >=20
> > > Suggested-by: Thierry Reding <treding@nvidia.com>
> > > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > > ---
> > >  .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++-------=
--
> > >  1 file changed, 49 insertions(+), 46 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvi=
dia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers=
/nvidia,tegra186-mc.yaml
> > > index 935d63d181d9..e0bd013ecca3 100644
> > > --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,teg=
ra186-mc.yaml
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,teg=
ra186-mc.yaml
> > > @@ -34,11 +34,11 @@ properties:
> > >            - nvidia,tegra234-mc
> > > =20
> > >    reg:
> > > -    minItems: 6
> > > +    minItems: 4
> > >      maxItems: 18
> > > =20
> > >    reg-names:
> > > -    minItems: 6
> > > +    minItems: 4
> > >      maxItems: 18
> > > =20
> > >    interrupts:
> > > @@ -151,12 +151,13 @@ allOf:
> > > =20
> > >          reg-names:
> > >            items:
> > > -            - const: sid
> > > -            - const: broadcast
> > > -            - const: ch0
> > > -            - const: ch1
> > > -            - const: ch2
> > > -            - const: ch3
> > > +            enum:
> > > +              - sid
> > > +              - broadcast
> > > +              - ch0
> > > +              - ch1
> > > +              - ch2
> > > +              - ch3
> >
> > I understand why sid and broadcast are becoming optional, but why order
> > of the rest is now fully flexible?
>
> The reason why the order of the rest doesn't matter is because we have
> both reg and reg-names properties and so the order in which they appear
> in the list doesn't matter. The only thing that matters is that the
> entries of the reg and reg-names properties match.
>
> > This does not even make sid/broadcast optional, but ch0!
>
> Yeah, this ends up making all entries optional, which isn't what we
> want. I don't know of a way to accurately express this in json-schema,
> though. Do you?
>
> If not, then maybe we need to resort to something like this and also
> mention explicitly in some comment that it is sid and broadcast that are
> optional.

Actually, here's another variant that is a bit closer to what we want:

--- >8 ---
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,te=
gra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra186-mc.yaml
index 935d63d181d9..86f1475926e4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-=
mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-=
mc.yaml
@@ -34,11 +34,11 @@ properties:
           - nvidia,tegra234-mc
=20
   reg:
-    minItems: 6
+    minItems: 4
     maxItems: 18
=20
   reg-names:
-    minItems: 6
+    minItems: 4
     maxItems: 18
=20
   interrupts:
@@ -146,17 +146,21 @@ allOf:
     then:
       properties:
         reg:
+          minItems: 4
           maxItems: 6
           description: 5 memory controller channels and 1 for stream-id re=
gisters
=20
         reg-names:
-          items:
-            - const: sid
-            - const: broadcast
-            - const: ch0
-            - const: ch1
-            - const: ch2
-            - const: ch3
+          anyOf:
+            - items:
+                enum: [ sid, broadcast, ch0, ch1, ch2, ch3 ]
+              uniqueItems: true
+              minItems: 6
+
+            - items:
+                enum: [ ch0, ch1, ch2, ch3 ]
+              uniqueItems: true
+              minItems: 4
=20
   - if:
       properties:
@@ -165,29 +169,22 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 18
+          minItems: 16
           description: 17 memory controller channels and 1 for stream-id r=
egisters
=20
         reg-names:
-          items:
-            - const: sid
-            - const: broadcast
-            - const: ch0
-            - const: ch1
-            - const: ch2
-            - const: ch3
-            - const: ch4
-            - const: ch5
-            - const: ch6
-            - const: ch7
-            - const: ch8
-            - const: ch9
-            - const: ch10
-            - const: ch11
-            - const: ch12
-            - const: ch13
-            - const: ch14
-            - const: ch15
+          anyOf:
+            - items:
+                enum: [ sid, broadcast, ch0, ch1, ch2, ch3, ch4, ch5, ch6,=
 ch7,
+                        ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15 ]
+              minItems: 18
+              uniqueItems: true
+
+            - items:
+                enum: [ ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, =
ch10,
+                        ch11, ch12, ch13, ch14, ch15 ]
+              minItems: 16
+              uniqueItems: true
=20
   - if:
       properties:
@@ -196,29 +193,22 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 18
+          minItems: 16
           description: 17 memory controller channels and 1 for stream-id r=
egisters
=20
         reg-names:
-          items:
-            - const: sid
-            - const: broadcast
-            - const: ch0
-            - const: ch1
-            - const: ch2
-            - const: ch3
-            - const: ch4
-            - const: ch5
-            - const: ch6
-            - const: ch7
-            - const: ch8
-            - const: ch9
-            - const: ch10
-            - const: ch11
-            - const: ch12
-            - const: ch13
-            - const: ch14
-            - const: ch15
+          anyOf:
+            - items:
+                enum: [ sid, broadcast, ch0, ch1, ch2, ch3, ch4, ch5, ch6,=
 ch7,
+                        ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15 ]
+              minItems: 18
+              uniqueItems: true
+
+            - items:
+                enum: [ ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, =
ch10,
+                        ch11, ch12, ch13, ch14, ch15 ]
+              minItems: 16
+              uniqueItems: true
=20
 additionalProperties: false
=20
--- >8 ---

The one restriction that it has is that "sid" and "broadcast" must be
optional together. So you can't have just "sid" or "broadcast", but they
either must both be there, or they must both not be there.

I suppose we could technically make that work by adding more
alternatives, but perhaps it can be avoided for sanity?

Thierry

--27a536f2ded1841e1102a6eb72a0909ec5f63895e697412a751d7f830ae9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYpO6sACgkQ3SOs138+
s6E9cRAAjCRwwdVpQJHJctBbfyUouIMgwaXBsvwGWIRhimQ/Fv2+aXm/Q7ZLTVB3
iomc+xyJtSaeb/NlUEkdnBqZh7VKbVTvyz96p1qRdBTg/JjsugulaLu/XK3tmkZ9
F30XWq2pgeDle33fH5SmE835RR4rQHT+C3+yrIUlk+psq8haNv7b7FT+eOI+O33z
p3Fmb2BluyHBW6I4AiuD06CbWjyX26X2N/OLKDNRJvpJQo0yt3Io9S5E6c+/kfcN
xyhsMma4s3f4VzRG3kLAWrm4keOitLRllN6IlILfWYI49fIusPYlIRR4O9OwUGxF
aGn+w2Nr7e795wCYPZkDI02brGoTS8kRaDw+x/bGRuWMAzglERF6yfuHsbvnveR6
mi8LNAWBzldS4//SetaICYbdvkVMCoqi86a1Zm2dKIQa5+tmDfvxzj6Ca9LFuiCm
Ehz3RmplCaMXp2Du77Plrhs2/GALnAUshXJFa6H/e5CpgASjC9eI6ca5iVlVkY0+
V3zCO/bVlFP1ulBEUpFz07ZtCbni6RPQLzMisCIYiNjD8lGv8iq8pWYY2gNzmSfJ
8MPqJ2EN9Kf1LKWqe5YGEG1jFOtjZ1GfsLfxyAlNe3SJN7FVIbJs73EpkdVBYJ21
TBcTyrjPsuQBi/wje26yYa7p9+uXDKtWO/571hRTCtmq4bRETD0=
=FoYA
-----END PGP SIGNATURE-----

--27a536f2ded1841e1102a6eb72a0909ec5f63895e697412a751d7f830ae9--

