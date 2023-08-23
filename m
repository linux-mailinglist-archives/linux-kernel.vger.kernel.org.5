Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B7A7850EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHWG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjHWG5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:57:05 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ED4C7;
        Tue, 22 Aug 2023 23:57:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76dbe1866ecso25685185a.0;
        Tue, 22 Aug 2023 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692773823; x=1693378623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU2P7dRQQgULo0zZUicyqjAPcRU7CHBoeG/KFxBvPnQ=;
        b=BuZpCsDOlAM+aE0fTt7Ucc7gTdMZlb5mOUWyF+6FjgFnAftjnH5Z0c/li7ci7qdlgn
         1AlFT35OzajBuWYkKoZGT0ZrivpGRegZTdX8+CRomLSch9aBgIgsig6Ckm6QpmcV/e7R
         a96RU9OZ1xr6CnsR6RXuiQEXIuxFWlEHi/+D/1AZqdycR+NcRzeQ8nJnikqej0pPqhwR
         dWHaRTuWR0hrWtjmoPtDxFjgOnyG39qMX9zGZI8XowC59mV8AxyQRXgvxW38C17rmBtU
         Lw/zFRz3vJAbKfQbAKaJ7BP679d5e9Dt3nxKwAHpRcZLEOGjegNFpSLvMPnciJUberZI
         eSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692773823; x=1693378623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qU2P7dRQQgULo0zZUicyqjAPcRU7CHBoeG/KFxBvPnQ=;
        b=CfHQf8AMP9yc1Hlt7nFWYvDY80b1ULVoQuHTu9nF1nObj4qFlGJYO847jK80L+wIVV
         TPbF3UfSB5ihDpLsySM7k3sLMmZcD0uOxH9LsxqS+xqa84TDDR61Lg45F3w15awtb6zU
         f/w6oEWJz6W3WE3WOVqiRTuxllsBK4ST22KVlUg9KpxQFIaVyv/w2QNse5zGjSXrFO8g
         gguptkhXi/k+u/9apG9XI9mFj40VKdosxmbbQ5n1rqgZvusaKiGQ/m7MsSwbpICIZioC
         UoSfST/TyGHqrWRT3KtPOf4KyXYTSd4Sb5X+4xLiR3Eb6jJy5iglFJD7lywhtbFa97Lt
         hAgg==
X-Gm-Message-State: AOJu0YzTPMAcsYfwqeBOThpU8u+Frszxe2lkYFH7XqA/KyAwJ9QbfDgQ
        +Szxs6F0WXTaLu6G+NzzW8jXrnOH0R7dENkJ6Q==
X-Google-Smtp-Source: AGHT+IF2q9OyYV9NokpELU//pPqZcjhwdA9Z63NepXCLXLHLtLKOm8Ykp1Yzc2qZP7WiwxItaA8Weintu1FaRM8d4rU=
X-Received: by 2002:a05:620a:25d1:b0:76c:e6b6:58d3 with SMTP id
 y17-20020a05620a25d100b0076ce6b658d3mr11713139qko.22.1692773822809; Tue, 22
 Aug 2023 23:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133238.741950-1-privatesub2@gmail.com>
 <20230814133238.741950-2-privatesub2@gmail.com> <20230822104854.1fa5f1aa@donnerap.manchester.arm.com>
In-Reply-To: <20230822104854.1fa5f1aa@donnerap.manchester.arm.com>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= 
        <privatesub2@gmail.com>
Date:   Wed, 23 Aug 2023 09:57:07 +0300
Message-ID: <CAF4idNneb1=40mQC=593Tmy8_OUAGiL4ROjK2XyL2BA35vM_WA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

=D0=B2=D1=82, 22 =D0=B0=D0=B2=D0=B3. 2023=E2=80=AF=D0=B3. =D0=B2 12:49, And=
re Przywara <andre.przywara@arm.com>:
>
> On Mon, 14 Aug 2023 16:32:16 +0300
> Aleksandr Shubin <privatesub2@gmail.com> wrote:
>
> Hi Aleksandr,
>
> > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > controller witch is different from the previous pwm-sun4i.
> >
> > The D1 and T113 are identical in terms of peripherals,
> > they differ only in the architecture of the CPU core, and
> > even share the majority of their DT. Because of that,
> > using the same compatible makes sense.
> > The R329 is a different SoC though, and should have
> > a different compatible string added, especially as there
> > is a difference in the number of channels.
> >
> > D1 and T113s SoCs have one PWM controller with 8 channels.
> > R329 SoC has two PWM controllers in both power domains, one of
> > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> >
> > Add a device tree binding for them.
> >
> > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > ---
> >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 85 +++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun=
20i-pwm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm=
.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > new file mode 100644
> > index 000000000000..9512d4bed322
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > @@ -0,0 +1,85 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner D1, T113-S3 and R329 PWM
> > +
> > +maintainers:
> > +  - Aleksandr Shubin <privatesub2@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: allwinner,sun20i-d1-pwm
> > +      - items:
> > +          - const: allwinner,sun20i-r329-pwm
> > +          - const: allwinner,sun20i-d1-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +  clocks:
> > +    items:
> > +      - description: 24 MHz oscillator
> > +      - description: Bus Clock
>
> The manual tells me that the new PWMs can also use APB0 as the
> input clock, which (finally!) allows PWM frequencies above 24 MHz.
> So we should have an explicit reference to that clock - even if the bus
> clock happens to be gated version of APB0.

Should I change it to something like this:
    pwm: pwm@2000c00 {
      compatible =3D "allwinner,sun20i-d1-pwm";
      reg =3D <0x02000c00 0x400>;
      clocks =3D <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
      clock-names =3D "bus", "hosc", "apb0";
      resets =3D <&ccu RST_BUS_PWM>;
      #pwm-cells =3D <0x3>;
    };

>
> Cheers,
> Andre
>
> > +
> > +  clock-names:
> > +    items:
> > +      - const: hosc
> > +      - const: bus
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  allwinner,pwm-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The number of PWM channels configured for this instan=
ce
> > +    enum: [6, 9]
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun20i-r329-pwm
> > +
> > +    then:
> > +      required:
> > +        - allwinner,pwm-channels
> > +
> > +    else:
> > +      properties:
> > +        allwinner,pwm-channels: false
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#pwm-cells"
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/sun20i-d1-ccu.h>
> > +    #include <dt-bindings/reset/sun20i-d1-ccu.h>
> > +
> > +    pwm: pwm@2000c00 {
> > +      compatible =3D "allwinner,sun20i-d1-pwm";
> > +      reg =3D <0x02000c00 0x400>;
> > +      clocks =3D <&dcxo>, <&ccu CLK_BUS_PWM>;
> > +      clock-names =3D "hosc", "bus";
> > +      resets =3D <&ccu RST_BUS_PWM>;
> > +      #pwm-cells =3D <0x3>;
> > +    };
> > +
> > +...
>

Cheers,
Aleksandr
