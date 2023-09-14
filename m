Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFF79FCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjINHJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjINHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:09:08 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAFCFA;
        Thu, 14 Sep 2023 00:09:04 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-44d426d0e05so321180137.0;
        Thu, 14 Sep 2023 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694675343; x=1695280143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSaG/LXIBUgueSj0zQWyWDs1ASmEFDDPeMdCeBBOALM=;
        b=jpg02TTe4gumVaAK8i4eKDZkVBJibJn6tRMkB0UifFwou/oTqG2zCVmax0LzpVbAd1
         efQYncK4HWXxx8yLOVe11TqllepkyrArt6enprUbp+a8QpUxHnW+gj7Jki/1Nc/4vPt5
         QDbX5m57suyWWR40sgdkOmcsUeuB3wQIVbTXNe6GbH2ZxRFU3kF6+ecJjSvhIYxofW1z
         aKmUtdsTPjsPkSdKlJrpH3pV6SkQZtut7cZ7lIsFX57GYQQweXJAY3VxKRphqay1/4Gt
         0j9eQcm9SD3yqpZCjbQ7kjUoUcxSBGqS7xP8sQp5P8seX0mhSGRvyJ/nPiWQTf/5UGHQ
         JYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675343; x=1695280143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSaG/LXIBUgueSj0zQWyWDs1ASmEFDDPeMdCeBBOALM=;
        b=N2eKqT4xX2ctYcCQ8jBk2Hq/Zf8xlx8c/A1bUpoDUoi6+LVdRpPQ7AvxYttMWtMuWP
         XCgbPfjcToLLMzGCn1/s0chKPgYncs+5bNfVhLcuAvl1FwZ6hiLnuOLRuSTX/DfFoT90
         /cQOPEZJA9Sh70MKmbhSkv0NujGsculfMFNKbsJrACJFoFi8LhJNzWnSr3eMt95dWD7X
         xiyNWUuLVV/CsM05fxe0LuXUS8bbxmvvmufkN8lfcW2P7OY3BKo4GwAdZveRmMoKM80f
         oBN/ALeGpllNUYa84AIRLiLKJGqWLW7uo31ksfs8btQ8CAoEO+IGJiAdG5zSSymeTn0n
         WFHg==
X-Gm-Message-State: AOJu0YwgEGs7EQiV0qqB5b2oP4UFVb+ELStfgDgSjM1Xjpn2WcDWpOB8
        PYJu5mevS7zDgFJubU6zBRS8cz2XVV1N7Yo+pfG7EVfHugs=
X-Google-Smtp-Source: AGHT+IGCS14Z6FMbrKeskOrdIgCVw+Vksufj/9LkVLiORgVUhji/+0z6isrK7A8qGvjTODmtqLF+2NeM43teJmb/Ldo=
X-Received: by 2002:a05:6102:15aa:b0:450:f9eb:f412 with SMTP id
 g42-20020a05610215aa00b00450f9ebf412mr2418236vsv.5.1694675343350; Thu, 14 Sep
 2023 00:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230913151606.69494-1-romain.perier@gmail.com>
 <20230913151606.69494-3-romain.perier@gmail.com> <20230913-depress-bootlace-6b88bfd83966@spud>
In-Reply-To: <20230913-depress-bootlace-6b88bfd83966@spud>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 14 Sep 2023 09:08:52 +0200
Message-ID: <CABgxDoK2T3xkKYDVeqRuDXMHfVEJcRkkBOBBkMJ5=XUv9Y5MsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: rtc: Add Mstar SSD202D RTC
To:     Conor Dooley <conor@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 13 sept. 2023 =C3=A0 20:30, Conor Dooley <conor@kernel.org> a =C3=
=A9crit :
>
> On Wed, Sep 13, 2023 at 05:16:05PM +0200, Romain Perier wrote:
> > Add YAML bindings for Mstar SSD202D RTC.
> >
> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > ---
> >  .../bindings/rtc/mstar,ssd202d-rtc.yaml       | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd202d=
-rtc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.ya=
ml b/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
> > new file mode 100644
> > index 000000000000..4c1f22ef5a2c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/mstar,ssd202d-rtc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mstar SSD202D Real Time Clock
> > +
> > +maintainers:
> > +  - Daniel Palmer <daniel@0x0f.com>
> > +  - Romain Perier <romain.perier@gmail.com>
> > +
> > +allOf:
> > +  - $ref: rtc.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mstar,ssd202d-rtc
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
>

Hi,

> So, this seems fine to me in isolation, but isn't this now the sort of
> thing that can be documented in trivial-rtc.yaml?
> Its only got compatible & reg, which seems to fit the bill for that.
>

With the current state, it might make sense. However, currently, the
RTC hw block is mostly
reverse-engineered, the driver is not complete yet, things like
external irq or wakeup irq might arrive later (once we know how it is
wired up and used).
So the content of the dt-bindings might change and differ from a
simple "compatible & reg" requirement.

What do you think ?

> Apologies if I am missing something,

No problem, I am open to suggestions :)

Thanks,
Regards,
Romain



> Conor.
>
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    rtc@6800 {
> > +        compatible =3D "mstar,ssd202d-rtc";
> > +        reg =3D <0x6800 0x200>;
> > +    };
> > +...
> > --
> > 2.39.2
> >
