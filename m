Return-Path: <linux-kernel+bounces-148782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42528A8756
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EC72817B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C5146D78;
	Wed, 17 Apr 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBnZrAOy"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B6146D5D;
	Wed, 17 Apr 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367171; cv=none; b=HvsCSIFpk17O3hNKB+FUwwlMSmWrKssTsj85WBcfSXFvqDm7dKDJM8DMha9Wlk+PICo+k9rAuKtDGC6u5/jUgckT9SLojwBA2DqsGuuOILj0Wjgvhm70Fm1nHeNKmhb1BEUgEpi5q376f/WiZY+P1/cdQm8RLPYp8U4jvMeepIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367171; c=relaxed/simple;
	bh=9ieCxJYZGNBDD1LiuUPAloXHCCgXHM76uCwIyEXjUiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIrGVSPrd36Jn+GN0k8StRadAx4YI0/jhtPG6dmKps62hhZVEKP2NJg7Bl4QIg9c+S/Tj/qz9H70ZaL4GioPysQ/Rtk35s9ctUN7qb6tmo/HwZpYaMEcG45CNIiMTLwSWyhM1kaIpB8GZ8a5IBRp0oY30MvlyySiooT09z+9nK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBnZrAOy; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43716c1616dso16450181cf.2;
        Wed, 17 Apr 2024 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713367169; x=1713971969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsuMImG8y65tuxtEa3J0zOxc8q85jI16Vx7B/v7ER6c=;
        b=VBnZrAOyEn5VczX6uD1UkqvFGOvlhz3Gicaegyd8RAdEBVGDfV8FOOD5DP5Y8ZXUWd
         HSacl5Qo6DCPzjOwNjbyfSO8y+yvHLfTsnTptuoru9H7brGJHZnh12YueDPln4OLRSFk
         SsFAcxDz5oikKhitjPLju3KYGzBSOKHi90yRYtmOlT91AuiDeKTcI63PaCPRFmjqBbmf
         4L4qDlNoot8waIM/Wa+CVYou9HpRI+lgxgCbPmBLnWkh5wA8Z9nS/jUwtxGSexORNG8G
         yMIl4IHm0uxsUgt1h3GjmmYt0h6VsVaHkwzDAqUm2Rb4ItkSPiK3YGmvk7X1dKKOSOi9
         DvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367169; x=1713971969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsuMImG8y65tuxtEa3J0zOxc8q85jI16Vx7B/v7ER6c=;
        b=xQ/GlZWwWo2bqK3OLeE62DS1xFrFIKCCTNb5ZPJ6+zrx0vpXcFMom1wqiJFJL/bpA7
         TSloEfqGS7EAbWmSuL2PdyhTpSsBdcf8Zv0LLwjHqbQN+F7FWUd6IXVl84xnCFpT9K7H
         ZzK9kgRTqix2qopIqqa64s1RwYi0238DoMM6uvtP4H7YJcjtTBsL/BTocmFmVyMVO4ey
         QWsVfnWLzf2QygN2kj3xXy41aAdt30Z313e0pExwhTeDh/4SKhsk6FhVZ+7c/WPCUoCl
         /b2FCikjWt9JV0z/yzxL7q4m3r7Mx0Y7B8eAaBF3GfvbqstSYLdfnOzNyDDZbt9+1AcW
         Qb2w==
X-Forwarded-Encrypted: i=1; AJvYcCUBqD+GtitdXL1IXGGznlkhmfSOHdJvhpJslc5qyfVzzv3PFrTssQp2GAzgbomlJo+zwuhwWXp/YOuwVwwsRRAL17vRb4Xi+JBBp1oBgrrL/J/vOJrIwGBmhZI8TM3KmVPRkBU6MprpaDmOm/nuXkKubB0i9LsSU24UX0+vYUyXx8AatCAf5g==
X-Gm-Message-State: AOJu0YwGCbGn7bXvy0VmrJkuDuNYxBwJRRzkEACVwlbQjmXzNjXJeIas
	7K5fwn949Xf2kXgF+3JpgptZsbuE0qrUZQRt3E+2lMraD1tWT3S6Cy8P1sWO2okKTI6Jx0rFlpv
	lDJ6sCOVwNgX2Z24OgVwmxKiT++o=
X-Google-Smtp-Source: AGHT+IHIisIJ4FJxDLwU+mOfGl94tChPUf7fwp+QgM5rMw7GH+ywYcGEpzukiulU6fkcyGUq246BiHzlmCV8563qhBg=
X-Received: by 2002:ac8:57cc:0:b0:436:ac83:42b8 with SMTP id
 w12-20020ac857cc000000b00436ac8342b8mr17228338qta.1.1713367169046; Wed, 17
 Apr 2024 08:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417135111.20375-1-pratik.farkase@wsisweden.com> <20240417-obscure-denial-ae7c53d0e321@spud>
In-Reply-To: <20240417-obscure-denial-ae7c53d0e321@spud>
From: Pratik Farkase <pratikfarkase94@gmail.com>
Date: Wed, 17 Apr 2024 17:19:18 +0200
Message-ID: <CACy_QWNpUtDz16RWOHf_-xBhtwt_66_4xCaSf+wzPKFz9c6D0A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: brcm,bcm2835-aux-uart: convert to dtschema
To: Conor Dooley <conor@kernel.org>
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:54=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Apr 17, 2024 at 03:51:10PM +0200, Pratik Farkase wrote:
> > Convert the Broadcom BCM2835 Auxiliary UART to newer DT schema.
> > Created DT schema based on the .txt file which had
> > `compatible`, `reg` `clocks` and `interrupts` as the
> > required properties. This binding is used by Broadcom BCM2835
> > SOC used in some Raspberry PI boards.
> > Changes from original file:
> > Implemented complete example which the original txt binding lacked.
> >
> > Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
> > ---
> > Changes in v2
> > - Updated Maintainers list according to feedback
> > - Fixed typo `Auxiliar` to `Auxiliary`
> > ---
> > ---
> >  .../bindings/serial/brcm,bcm2835-aux-uart.txt | 18 -------
> >  .../serial/brcm,bcm2835-aux-uart.yaml         | 48 +++++++++++++++++++
> >  2 files changed, 48 insertions(+), 18 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm28=
35-aux-uart.txt
> >  create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm28=
35-aux-uart.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-=
uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.t=
xt
> > deleted file mode 100644
> > index b5cc6297cd1b..000000000000
> > --- a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.tx=
t
> > +++ /dev/null
> > @@ -1,18 +0,0 @@
> > -* BCM2835 AUXILIAR UART
> > -
> > -Required properties:
> > -
> > -- compatible: "brcm,bcm2835-aux-uart"
> > -- reg: The base address of the UART register bank.
> > -- interrupts: A single interrupt specifier.
> > -- clocks: Clock driving the hardware; used to figure out the baud rate
> > -  divisor.
> > -
> > -Example:
> > -
> > -     uart1: serial@7e215040 {
> > -             compatible =3D "brcm,bcm2835-aux-uart";
> > -             reg =3D <0x7e215040 0x40>;
> > -             interrupts =3D <1 29>;
> > -             clocks =3D <&aux BCM2835_AUX_CLOCK_UART>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-=
uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.=
yaml
> > new file mode 100644
> > index 000000000000..5d4d37371d6b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.ya=
ml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/brcm,bcm2835-aux-uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: BCM2835 AUXILIARY UART
> > +
> > +maintainers:
> > +  - Pratik Farkase <pratikfarkase94@gmail.com>
> > +  - Florian Fainelli <florian.fainelli@broadcom.com>
> > +  - Stefan Wahren <wahrenst@gmx.net>
> > +
> > +allOf:
> > +  - $ref: serial.yaml
> > +
> > +properties:
> > +  compatible:
> > +    const: brcm,bcm2835-aux-uart
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/bcm2835.h>
> > +    #include <dt-bindings/clock/bcm2835-aux.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
>
> Only 1 of these headers seems used, there's only one define below.
>
> > +    uart1: serial@7e215040 {
>
> The label is unused and can be dropped.
I did not understand this part. What do you suggest i change it into?
I took the example from original dtsi file:
arch/arm/boot/dts/broadcom/bcm283x.dtsi
>
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
>
> > +        compatible =3D "brcm,bcm2835-aux-uart";
> > +        reg =3D <0x7e215040 0x40>;
> > +        interrupts =3D <1 29>;
> > +        clocks =3D <&aux BCM2835_AUX_CLOCK_UART>;
> > +    };
> > --
> > 2.34.1
> >



--=20
Best Regards
Pratik Farkase
Be Passionate Be Smart

