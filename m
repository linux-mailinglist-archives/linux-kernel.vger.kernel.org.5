Return-Path: <linux-kernel+bounces-93457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A3873016
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5541F21242
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077D5D492;
	Wed,  6 Mar 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOkz57Wl"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A55D48E;
	Wed,  6 Mar 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711801; cv=none; b=jI/O0rjyRl/1p50L24UDPZKB5uzMGoEYnRPjKxHX9duEEXWcBQ8R03y7Ov0j0OWAIZH1zQPPmiEozoi3WGIU1WZy1Dbxzva5O2SzdoA5McwRlQm4EzpP7swI+BbSnIkNHAooSOdsDnoiulfbHOWRXTQLvNBa6vooLICNuAVjcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711801; c=relaxed/simple;
	bh=GYr7m8K6mxpIbzSAb4QoLozaKgrbAWOSyE7TrCOPgDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0cxps4GbDqRSuKRjcKjn0DmoI8dvtkReJNirFCYWCsgP1HHxO/bL/6TKRYqcCZHYChB8lXdmjZPfIpyc7pXrC45fepnGqpXn6bBqR+tw5AzvILCS8ml3Deam6OqwlcTLsQzJiW4NK/W6aiFiunavaZ59MC72ATdXs7g6ZnmF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOkz57Wl; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-365fec6644fso1999485ab.0;
        Tue, 05 Mar 2024 23:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709711799; x=1710316599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPhPQT45kHdyzdhpdUe+DVL+6CjOwhe9gLeuSsNNlCQ=;
        b=WOkz57Wl3JT/gYcOW3RcVs2kbhgGvu18c8CELUerRDYzjGRzp700DYbTWeBQed/6o7
         N+Oaz59ACfGkU28uep6wJ/oOAy9uRx7mXzVfREooBAWBxbtNADfHTe03LiN5Lxysx0lv
         EchL+r+hs2W6aPREDdaYpGyelFc1XufjVy6VgjCC6koBvc9HFz25pUwheiAeoRTnn2G9
         dujIKincWSTwWmU8ux7ivePdo6H+QfMsjaWAMTod785le/KwuAboAdiqQCl7J570Wkxj
         1IUolWZPRtfdeymLYv0DfS8CTAUty4Xpqpcv4J+FZsMADbD15CQNrngP1xQgQP6Ygl8U
         Ht2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709711799; x=1710316599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPhPQT45kHdyzdhpdUe+DVL+6CjOwhe9gLeuSsNNlCQ=;
        b=Czj8mktQriwxVIqBB6XVXq0ivzzihwTScNm9kCXZHLm9BBrRTAxMrpu7/B9/wMsoAH
         epy8OaplhUYHIuaNaIFwdOZ+vEoh5cvMVzr7QyXzHW0+ZENL94KRpvxtHnqeGTw8knfG
         M5lygMK7qeGRQJGh+rXgaiUFqIUy5A1dB23s/UBIe+o4xh/fAm70kIYUm4SlDzb2tEOF
         88bvIqCo7m5Eu+4RoyJGMnAC5pBpQI1FSxTEvloowjvCQWjT2gPNy9l4FuFPkMT7v9Lz
         WopKzoDNoD0pvcSORjkT/fhkmlLg2ybSdhJHG178FzZk3gjbRTQeLx2xBtC7T9QGXfD6
         OEkA==
X-Forwarded-Encrypted: i=1; AJvYcCUd9ppIQ7Nl0B0gBtQi/Pm+ugz3ChgpxWOvFKS+y66wB76t+tErKnGBBPy71utwzD2ooevQbLzDwDtVwZOXKPP0XFQxWHFAhZ33H5yYBJeNhFPHcxXvOug2XJvET/qhtvuSqO/moNd4aspeluVfTfBVWSFuYbAbBMfSUOiICKGrm2cR9wk8LsshS1IFieM1rLG/HYwxs86BVO7JLJ/LOA7J
X-Gm-Message-State: AOJu0YxPtWXK45ux+ZP+B42l9CinbChQ8YdhXT54+tIIAhw9hW8Q16MT
	XuYmseyZTvnGjbBME/pe+vDfZ1EXe+0GXAUU7dxXORRItmEJEWDbA/Nkpl2FbyDUFqSUKBGuX4a
	IcMLMIOXOFOqW0tK+c4upaIqv/Xk=
X-Google-Smtp-Source: AGHT+IE58vRHwDBTTuXKHgQFQ/UJSqdO7pnSZOi6XVe91c0PQI282+bUYNvb4IHteGaUW+HdSI/Vt7sBb1zhbo8GFCs=
X-Received: by 2002:a05:6e02:12ce:b0:365:102a:ee10 with SMTP id
 i14-20020a056e0212ce00b00365102aee10mr4294177ilm.6.1709711799054; Tue, 05 Mar
 2024 23:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com> <20240227005606.1107203-3-kcfeng0@nuvoton.com>
 <93d67381-34fc-423c-868a-565378c63e09@molgen.mpg.de>
In-Reply-To: <93d67381-34fc-423c-868a-565378c63e09@molgen.mpg.de>
From: Ban Feng <baneric926@gmail.com>
Date: Wed, 6 Mar 2024 15:56:28 +0800
Message-ID: <CALz278YF8FGz=JM83Q=6PeoQmGOJ4dfB8QTu1qbu9p4eSBHi8Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: hwmon: Add NCT7363Y documentation
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, kcfeng0@nuvoton.com, 
	kwliu@nuvoton.com, openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, Feb 28, 2024 at 3:30=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Ban,
>
>
> Thank you for your patch.
>
>
> Am 27.02.24 um 01:56 schrieb baneric926@gmail.com:
> > From: Ban Feng <kcfeng0@nuvoton.com>
> >
> > Adding bindings for the Nuvoton NCT7363Y Fan Controller
>
> s/Adding/Add/ or even Document bindings =E2=80=A6

ok, fix in v5

>
> Do you have an URL to the datasheet?

I'll add "Datasheet: Available from Nuvoton upon request" per Guenter
suggested in v5.

>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> > ---
> >   .../bindings/hwmon/nuvoton,nct7363.yaml       | 63 ++++++++++++++++++=
+
> >   MAINTAINERS                                   |  6 ++
> >   2 files changed, 69 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nc=
t7363.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.ya=
ml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> > new file mode 100644
> > index 000000000000..1a9d9a5d614e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NCT7363Y Hardware Monitoring IC
> > +
> > +maintainers:
> > +  - Ban Feng <kcfeng0@nuvoton.com>
> > +
> > +description: |
> > +  The NCT7363Y is a Fan controller which provides up to 16 independent
>
> lowecase: fan controller?

ok, fix in v5

>
> > +  FAN input monitors, and up to 16 independent PWM output with SMBus i=
nterface.
>
> output*s*?

ok, fix in v5

Thanks,
Ban

>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,nct7363
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#pwm-cells":
> > +    const: 2
> > +
> > +patternProperties:
> > +  "^fan-[0-9]+$":
> > +    $ref: fan-common.yaml#
> > +    unevaluatedProperties: false
> > +    required:
> > +      - pwms
> > +      - tach-ch
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#pwm-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        hwmon: hwmon@22 {
> > +            compatible =3D "nuvoton,nct7363";
> > +            reg =3D <0x22>;
> > +            #pwm-cells =3D <2>;
> > +
> > +            fan-0 {
> > +                pwms =3D <&hwmon 0 50000>;
> > +                tach-ch =3D /bits/ 8 <0x00>;
> > +            };
> > +            fan-1 {
> > +                pwms =3D <&hwmon 1 50000>;
> > +                tach-ch =3D /bits/ 8 <0x01>;
> > +            };
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2ecaaec6a6bf..7b1efefed7c4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15084,6 +15084,12 @@ S:   Maintained
> >   F:  Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> >   F:  drivers/hwmon/nct6775-i2c.c
> >
> > +NCT7363 HARDWARE MONITOR DRIVER
> > +M:   Ban Feng <kcfeng0@nuvoton.com>
> > +L:   linux-hwmon@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> > +
> >   NETDEVSIM
> >   M:  Jakub Kicinski <kuba@kernel.org>
> >   S:  Maintained
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

