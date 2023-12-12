Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE73C80E788
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjLLJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjLLIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:41:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04881CD;
        Tue, 12 Dec 2023 00:41:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50c0478f970so5606681e87.3;
        Tue, 12 Dec 2023 00:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702370504; x=1702975304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPld8vpr14XTiVIBO9OqUWjltLKOYMI1v6JQhvMLahY=;
        b=HTf1RxFwlSjD4YK19k7c3zbDHQ1AjW3ba+pig2Mkg/8rAf5mwbevdbYVrF2SZIfOl1
         LG0kfhFtXXDKlYN7rlNDl822x7ynWVEnEYWnRRWtakJSn1pe6ByuZPhlq/+9Jc+nmMog
         ZUkOeNS849m5tWJ39Y4Uh99WSlFHS5tBlMNGA7XNKTRKKJNc6gBwbbfKuZlBjxR6YB33
         GI4VrWWSQBgfyWm46lzmiCbufAcwYfmbuXIUeTCM2rZPHJAfc4DG/j7g8ynvapurSugL
         V0Rjd4YL5Xo4JjPyistF/LmmOaanE08CTdG4aVHzsJFTlpRlHLilrHXoa5qZxCHrfv09
         wxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370504; x=1702975304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPld8vpr14XTiVIBO9OqUWjltLKOYMI1v6JQhvMLahY=;
        b=nbx7JqNIwXRLObmHuFR/XIh9gYG9xJoElNKb9ZzgLD2IeHNSvgA3/xBQap5pK2lN1P
         DXqNL80WHOWxjiMTtH798lvMVSDHeUOwt2ajGsGKbB2na5F8OdyjhSBIO0/3Z7cq8dfc
         6cb+xExxlgigDdtIE1y+OQMnxrDiByp8f1o4WgnjOXWY/b8unAJKaoEOCm+Ke7QZenOl
         grrbTAgdLazBKFCX6Jm67+boBC5mrsukXRAFOw4vZ5CuH1ZZgVkNmQn3k2Ij9tNjQnXj
         rPKXhZ/EUIWhWM92pgpwarBbRjmF4p2r3E9iU6bpYDZjg3mnWOLSdB310Sok6Xyrd1VJ
         MqFg==
X-Gm-Message-State: AOJu0Yy7FAnQHgIj66/RK9Wn3D23W9OpLMmQo6H9VdsUEesgBMuBawtQ
        p1m8qRLpb+5R/tUldxAjmPUrIkIdJYAtpy0fiqc=
X-Google-Smtp-Source: AGHT+IEnmLpJcpamygkwP+7KOsXkqETOpVob6/2P22G2CYhFSXy52IIq0Hg6V/NCKv/PygX9xNpkXY0DHWV/woCamb0=
X-Received: by 2002:a05:6512:2019:b0:50b:d764:8046 with SMTP id
 a25-20020a056512201900b0050bd7648046mr2243403lfb.121.1702370503834; Tue, 12
 Dec 2023 00:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20231212065147.3475413-1-jim.t90615@gmail.com>
 <20231212065147.3475413-2-jim.t90615@gmail.com> <72fe6f18-e3d7-4c74-9734-01a33dc8e100@molgen.mpg.de>
In-Reply-To: <72fe6f18-e3d7-4c74-9734-01a33dc8e100@molgen.mpg.de>
From:   Jim Liu <jim.t90615@gmail.com>
Date:   Tue, 12 Dec 2023 16:41:32 +0800
Message-ID: <CAKUZ0+Ekx=-G0V1OXXdQCraL+sAXvmZffT65iLsGJ2QHs=1cAg@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] dt-bindings: gpio: add NPCM sgpio driver bindings
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jim Liu <JJLIU0@nuvoton.com>, KWLIU@nuvoton.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Rob Herring <robh@kernel.org>,
        linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

Thanks for your review.
I will modify it in the next version.

Best regards,
Jim

On Tue, Dec 12, 2023 at 3:00=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Jim,
>
>
> Thank you for your patch.
>
> Am 12.12.23 um 07:51 schrieb Jim Liu:
> > Add dt-bindings document for the Nuvoton NPCM7xx sgpio driver
> >
> > Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> As you seem to be employed by Nuvoton, should your company/work email be
> listed somehow, and even be used for the author address?
>
> > ---
> > Changes for v9:
> >     - no changed
> > Changes for v8:
> >     - no changed
> > Changes for v7:
> >     - no changed
> > ---
> >   .../bindings/gpio/nuvoton,sgpio.yaml          | 86 ++++++++++++++++++=
+
> >   1 file changed, 86 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgp=
io.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml =
b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> > new file mode 100644
> > index 000000000000..84e0dbcb066c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton SGPIO controller
> > +
> > +maintainers:
> > +  - Jim LIU <JJLIU0@nuvoton.com>
> > +
> > +description: |
> > +  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
> > +  Nuvoton NPCM7xx SGPIO module is combine serial to parallel IC (HC595=
)
>
> s/is combine/combines a/
>
> > +  and parallel to serial IC (HC165), and use APB3 clock to control it.
>
> use*s*
>
> > +  This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
>
> Only one space before the (.
>
> > +  NPCM7xx/NPCM8xx have two sgpio module each module can support up
>
> =E2=80=A6 modules. Each module =E2=80=A6
>
> > +  to 64 output pins,and up to 64 input pin, the pin is only for gpi or=
 gpo.
>
> 1.  Space after the comma.
> 2.  64 input pin*s
>
> > +  GPIO pins have sequential, First half is gpo and second half is gpi.
>
> have sequential ?.
>
> > +  GPIO pins can be programmed to support the following options
> > +  - Support interrupt option for each input port and various interrupt
> > +    sensitivity option (level-high, level-low, edge-high, edge-low)
>
> option*s*
>
> > +  - ngpios is number of nuvoton,input-ngpios GPIO lines and nuvoton,ou=
tput-ngpios GPIO lines.
> > +    nuvoton,input-ngpios GPIO lines is only for gpi.
>
> s/is/are/
>
> > +    nuvoton,output-ngpios GPIO lines is only for gpo.
>
> s/is/are/
>
> It=E2=80=99d be great if you mentioned the datasheet name and revision in=
 the
> description.
>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,npcm750-sgpio
> > +      - nuvoton,npcm845-sgpio
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  nuvoton,input-ngpios:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      The numbers of GPIO's exposed. GPIO lines is only for gpi.
>
> s/is/are/
>
> > +    minimum: 0
> > +    maximum: 64
> > +
> > +  nuvoton,output-ngpios:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      The numbers of GPIO's exposed. GPIO lines is only for gpo.
>
> s/is/are/
>
> > +    minimum: 0
> > +    maximum: 64
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - gpio-controller
> > +  - '#gpio-cells'
> > +  - interrupts
> > +  - nuvoton,input-ngpios
> > +  - nuvoton,output-ngpios
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    gpio8: gpio@101000 {
> > +        compatible =3D "nuvoton,npcm750-sgpio";
> > +        reg =3D <0x101000 0x200>;
> > +        clocks =3D <&clk NPCM7XX_CLK_APB3>;
> > +        interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> > +        gpio-controller;
> > +        #gpio-cells =3D <2>;
> > +        nuvoton,input-ngpios =3D <64>;
> > +        nuvoton,output-ngpios =3D <64>;
> > +    };
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul Menzel
