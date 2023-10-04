Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D8B7B8117
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjJDNgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJDNgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:36:41 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC2AB;
        Wed,  4 Oct 2023 06:36:37 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b07548b084so952152241.1;
        Wed, 04 Oct 2023 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696426597; x=1697031397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4Ks2PjBL4OJU3bHqNPd4WVt3w4kWj3L9isol3Hj0ew=;
        b=MW+4aBE4ax7VptULbKomIteOJTdzLk13y/IKaFcxRHsQ6woLSNA3pg+WzbljIZ2NMy
         Nr6jV4Bc3Tykslm9hqOkvITUOw0hgnTAqQ58V13AslKQgwp/tHr7rkG4KF1bJNVOw3An
         Ea6wVeAsJxM94oQgWi8ERMS6cgk7zwMIK4p/r3y/VdKzJDYPXAtC6m4e7Oi0P003KUzY
         fcfKwZpb1WAroWJ1CSMFEi2fQTrI1aQNKwEQqEKF/yqNdE5wzpMkr66QA34UsdLXRqDF
         BfKy900kFgqTzGWLhLhZTEhKvm07vWwj5QgkdJfycvR/+Osd27GvGX+ljBdWdVRgU16Z
         GG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696426597; x=1697031397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4Ks2PjBL4OJU3bHqNPd4WVt3w4kWj3L9isol3Hj0ew=;
        b=iqxoLJtbfZ77eRhPDm3NxDxAdLdQN+jTL7Lg0bIF7gp9cVZ0XjiuIdpdgksXMpsdD3
         ZvrQr0/OvFmzarVXyuYzpPTDA9+KbVqBV68AeqDYDELCkAnHAWPwRwotcHQ8tOojVIHU
         nETXpji/o9h0X8JXfpMvLLCNADS9PJ+OpqPwzqMzTBsOBUd0XAlglKUmHW1x4UxRmHut
         Y7fbPfYxfaVomHrC4pcRv3cR5dXQZ/dRmrVLxWg0Qta/cqYALFz1J3fsOZh88ShhI0p9
         LpNxA9gEtISCUjSaTKrmg94hOf6623Mz1GSEJSkzK5NukjnskSg9LQt13pQyjyHFIV4e
         3xvA==
X-Gm-Message-State: AOJu0YzHoY1+hf6V3bBOJSxqMkkiw/1qgSrRYgU0ooop5rKzHSCpxHrg
        V9I4r5GkCGY/7hzc4ZlGHa1ZHzwdSka82QFK1Jk=
X-Google-Smtp-Source: AGHT+IFHDPf+INRWuqoTwIsxfN/eEIHL3n2OW9WPmXvPKEvGbcbr5cg+410k/W3lyEWEnFqkcsQlP58hj9SD94LNaPw=
X-Received: by 2002:a1f:6d84:0:b0:496:1bc2:ddf with SMTP id
 i126-20020a1f6d84000000b004961bc20ddfmr2060602vkc.8.1696426596882; Wed, 04
 Oct 2023 06:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230102221815.273719-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102221815.273719-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 4 Oct 2023 14:35:42 +0100
Message-ID: <CA+V-a8u5DY49cetvjgLttGsj7OyYvn_rj3PToGZvVB=BE37A9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Jan 2, 2023 at 10:18=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL So=
C
> is almost identical to one found on the RZ/G2L SoC the only difference
> being it can support BUS_ERR_INT for which it has additional registers.
> Hence new generic compatible string "renesas,r9a07g043u-irqc" is added
> for RZ/G2UL SoC.
>
> Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
> interrupt-names property is added so that we can parse them based on
> names.
>
> While at it updated the example node to four spaces and added
> interrupt-names property.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> * Dropped RZ/G2UL specific string
>
> v1- > v2
> * Dropped RB tags
> * Added generic compatible string for rzg2ul
> * Added interrupt-names
> * Added checks for RZ/G2UL to make sure interrupts are 42 and interrupt-n=
ames
> * Updated example node with interrupt-names
> * Used 4 spaces for example node
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 225 +++++++++++++-----
>  1 file changed, 170 insertions(+), 55 deletions(-)
>
Looks like this patch got missed. Could you pick this one up or shall
I just resend this patch.

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renes=
as,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/renesas,rzg2l-irqc.yaml
> index 33b90e975e33..fc900ce2fe0a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> @@ -19,13 +19,11 @@ description: |
>      - NMI edge select (NMI is not treated as NMI exception and supports =
fall edge and
>        stand-up edge detection interrupts)
>
> -allOf:
> -  - $ref: /schemas/interrupt-controller.yaml#
> -
>  properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r9a07g043u-irqc   # RZ/G2UL
>            - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
>            - renesas,r9a07g054-irqc    # RZ/V2L
>        - const: renesas,rzg2l-irqc
> @@ -44,7 +42,96 @@ properties:
>      maxItems: 1
>
>    interrupts:
> -    maxItems: 41
> +    minItems: 41
> +    items:
> +      - description: NMI interrupt
> +      - description: IRQ0 interrupt
> +      - description: IRQ1 interrupt
> +      - description: IRQ2 interrupt
> +      - description: IRQ3 interrupt
> +      - description: IRQ4 interrupt
> +      - description: IRQ5 interrupt
> +      - description: IRQ6 interrupt
> +      - description: IRQ7 interrupt
> +      - description: GPIO interrupt, TINT0
> +      - description: GPIO interrupt, TINT1
> +      - description: GPIO interrupt, TINT2
> +      - description: GPIO interrupt, TINT3
> +      - description: GPIO interrupt, TINT4
> +      - description: GPIO interrupt, TINT5
> +      - description: GPIO interrupt, TINT6
> +      - description: GPIO interrupt, TINT7
> +      - description: GPIO interrupt, TINT8
> +      - description: GPIO interrupt, TINT9
> +      - description: GPIO interrupt, TINT10
> +      - description: GPIO interrupt, TINT11
> +      - description: GPIO interrupt, TINT12
> +      - description: GPIO interrupt, TINT13
> +      - description: GPIO interrupt, TINT14
> +      - description: GPIO interrupt, TINT15
> +      - description: GPIO interrupt, TINT16
> +      - description: GPIO interrupt, TINT17
> +      - description: GPIO interrupt, TINT18
> +      - description: GPIO interrupt, TINT19
> +      - description: GPIO interrupt, TINT20
> +      - description: GPIO interrupt, TINT21
> +      - description: GPIO interrupt, TINT22
> +      - description: GPIO interrupt, TINT23
> +      - description: GPIO interrupt, TINT24
> +      - description: GPIO interrupt, TINT25
> +      - description: GPIO interrupt, TINT26
> +      - description: GPIO interrupt, TINT27
> +      - description: GPIO interrupt, TINT28
> +      - description: GPIO interrupt, TINT29
> +      - description: GPIO interrupt, TINT30
> +      - description: GPIO interrupt, TINT31
> +      - description: Bus error interrupt
> +
> +  interrupt-names:
> +    minItems: 41
> +    items:
> +      - const: nmi
> +      - const: irq0
> +      - const: irq1
> +      - const: irq2
> +      - const: irq3
> +      - const: irq4
> +      - const: irq5
> +      - const: irq6
> +      - const: irq7
> +      - const: tint0
> +      - const: tint1
> +      - const: tint2
> +      - const: tint3
> +      - const: tint4
> +      - const: tint5
> +      - const: tint6
> +      - const: tint7
> +      - const: tint8
> +      - const: tint9
> +      - const: tint10
> +      - const: tint11
> +      - const: tint12
> +      - const: tint13
> +      - const: tint14
> +      - const: tint15
> +      - const: tint16
> +      - const: tint17
> +      - const: tint18
> +      - const: tint19
> +      - const: tint20
> +      - const: tint21
> +      - const: tint22
> +      - const: tint23
> +      - const: tint24
> +      - const: tint25
> +      - const: tint26
> +      - const: tint27
> +      - const: tint28
> +      - const: tint29
> +      - const: tint30
> +      - const: tint31
> +      - const: bus-err
>
>    clocks:
>      maxItems: 2
> @@ -72,6 +159,23 @@ required:
>    - power-domains
>    - resets
>
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a07g043u-irqc
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 42
> +        interrupt-names:
> +          minItems: 42
> +      required:
> +        - interrupt-names
> +
>  unevaluatedProperties: false
>
>  examples:
> @@ -80,55 +184,66 @@ examples:
>      #include <dt-bindings/clock/r9a07g044-cpg.h>
>
>      irqc: interrupt-controller@110a0000 {
> -            compatible =3D "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc=
";
> -            reg =3D <0x110a0000 0x10000>;
> -            #interrupt-cells =3D <2>;
> -            #address-cells =3D <0>;
> -            interrupt-controller;
> -            interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
> -            clocks =3D <&cpg CPG_MOD R9A07G044_IA55_CLK>,
> -                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
> -            clock-names =3D "clk", "pclk";
> -            power-domains =3D <&cpg>;
> -            resets =3D <&cpg R9A07G044_IA55_RESETN>;
> +        compatible =3D "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
> +        reg =3D <0x110a0000 0x10000>;
> +        #interrupt-cells =3D <2>;
> +        #address-cells =3D <0>;
> +        interrupt-controller;
> +        interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "nmi",
> +                          "irq0", "irq1", "irq2", "irq3",
> +                          "irq4", "irq5", "irq6", "irq7",
> +                          "tint0", "tint1", "tint2", "tint3",
> +                          "tint4", "tint5", "tint6", "tint7",
> +                          "tint8", "tint9", "tint10", "tint11",
> +                          "tint12", "tint13", "tint14", "tint15",
> +                          "tint16", "tint17", "tint18", "tint19",
> +                          "tint20", "tint21", "tint22", "tint23",
> +                          "tint24", "tint25", "tint26", "tint27",
> +                          "tint28", "tint29", "tint30", "tint31";
> +        clocks =3D <&cpg CPG_MOD R9A07G044_IA55_CLK>,
> +                 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
> +        clock-names =3D "clk", "pclk";
> +        power-domains =3D <&cpg>;
> +        resets =3D <&cpg R9A07G044_IA55_RESETN>;
>      };
> --
> 2.25.1
>
