Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9387A764093
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGZUf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGZUf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:35:56 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B912B2704
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:35:54 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3c78ede4bso219079b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1690403754; x=1691008554;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UbJeRzU7wigg3Cu4qDyeUEG2N0zmDly89LtEzqyMs4E=;
        b=TxGCtU4yiHilQLBjUikX0JH9p6bb2UNI26c3vHmd5RO8FYRkDvNulnhPJd3CKSq9Fo
         gOIC9PqsHWZlRyLBv3mi4bIOQDpNAYCYZlr81fsXoGFwE2cUSvufGtSEX0dw8bo7gqqP
         vd09xr+NRbEsFtKf5A8oTo1/4bZUznMU31ew4iJs9g3kOnfP6XqNJsyomSHnsRBJhQRF
         2si1a902AlFy8F5TkVpPzp9EA4/2bLGvXYGY8pAIvq+RYJueW8d5oxz/SNTEEIMBGhZy
         ye5hpxcBNZC2MQcUkJVCvw7mM/HP7xVL//qt4/c6EwBoG/qjLV9Wz/SDxuo19X3BtYi3
         TbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690403754; x=1691008554;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbJeRzU7wigg3Cu4qDyeUEG2N0zmDly89LtEzqyMs4E=;
        b=cLmXt18g2WyYdYgp5/DN6wDETT0yNNQjS+Z2sxSAnCij+fYiGxSeVnU7tdZ0wQhxml
         J0BLicWD/FS8TwaZCeeyrdK03En8BIooNvo0n5xnwAB+Wmrb7xcN4iKjptF9YDWHWe2S
         rnYWFv05BGYMd01L/D/NQP5tj7yANHnOW+j1NgoGfa2RO9HSFu0MtheVvQ+P69Ry1Waz
         zPb6njhY9FY4nb8eKqXzS24r54f3VQZvrGg23yPaEiuY19ZGZM/qbRufdFFnTVD0Chx8
         RzRM4cObP2Aiw5Q3vy6lgTgDsLccqxr7mgXNWsd80b1WKKb1VywYL6+rtfqm+qu2ws/F
         kRAA==
X-Gm-Message-State: ABy/qLb8383Y14MUB6SrVoVfLNmkbBambrThmLHsEQFNgf7K4ZFxZ/w1
        YJMRMg6FlW+ZXK0kFSzs8CAIHQ==
X-Google-Smtp-Source: APBJJlFMm0AI2+RVorQy6CQwizGZeLXoyZBFhxx7j6jzyKq1c1RJlExUWOEk9RJSbT6hVnqn+H4ZZA==
X-Received: by 2002:a05:6808:aac:b0:3a4:19fd:cd51 with SMTP id r12-20020a0568080aac00b003a419fdcd51mr588581oij.10.1690403754044;
        Wed, 26 Jul 2023 13:35:54 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:580::7a9])
        by smtp.gmail.com with ESMTPSA id k19-20020a0cf593000000b00634daee6ecbsm5390895qvm.113.2023.07.26.13.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 13:35:53 -0700 (PDT)
Message-ID: <3d26f0f719cd5f71c20e80599362cd52bcfe8dd4.camel@ndufresne.ca>
Subject: Re: [PATCH] dt-bindings: media: Add bindings for Imagination E5010
 JPEG Encoder driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com,
        p-mantena@ti.com, vijayp@ti.com
Date:   Wed, 26 Jul 2023 16:35:52 -0400
In-Reply-To: <b6bddd59-ac78-3f75-828e-cff54766fc72@linaro.org>
References: <20230726162615.1270075-1-devarsht@ti.com>
         <b6bddd59-ac78-3f75-828e-cff54766fc72@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 26 juillet 2023 =C3=A0 18:33 +0200, Krzysztof Kozlowski a =C3=
=A9crit=C2=A0:
> On 26/07/2023 18:26, Devarsh Thakkar wrote:
> > Add dt-bindings for Imagination E5010 JPEG Encoder driver which is
> > implemented as stateful V4L2 M2M driver.
> >=20
> > Co-developed-by: David Huang <d-huang@ti.com>
> > Signed-off-by: David Huang <d-huang@ti.com>
>=20
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
>=20
> Drop also "driver". Bindings are for hardware, not drivers.
>=20
> Prefix starts with media and then dt-bindings.

That being said, I haven't seen any submission for the driver using these, =
is it
common practice to upstream bindings for unsupported hardware ?

Nicolas

>=20
>=20
> > Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> > ---
> >  .../bindings/media/img,e5010-jpeg-enc.yaml    | 79 +++++++++++++++++++
> >  MAINTAINERS                                   |  5 ++
> >  2 files changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/img,e5010-j=
peg-enc.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc=
.yaml b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
> > new file mode 100644
> > index 000000000000..0060373eace7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Imagination E5010 JPEG Encoder
> > +
> > +maintainers:
> > +  - Devarsh Thakkar <devarsht@ti.com>
> > +
> > +description: |
> > +  The E5010 is a JPEG encoder from Imagination Technologies implemente=
d on
> > +  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YU=
V422
> > +  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
> > +  8Kx8K resolution.
> > +
> > +properties:
> > +  compatible:
> > +    const: img,e5010-jpeg-enc
>=20
> Your description suggests that this is part of TI SoC. Pretty often
> licensed blocks cannot be used on their own and need some
> customizations. Are you sure your block does not need any customization
> thus no dedicated compatible is needed?
>=20
> > +
> > +  reg:
> > +    items:
> > +      - description: The E5010 main register region
> > +      - description: The E5010 mmu register region
> > +
> > +  reg-names:
> > +    items:
> > +      - const: regjasper
> > +      - const: regmmu
> > +
>=20
> Drop reg from both
>=20
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
>=20
> You need to specify the items. Also, no variable number of clocks. Why
> would they vary if block is strictly defined?
>=20
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
>=20
> Instead list the names.
>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    cbass_main {
>=20
> That's some weird name. Probably you meant soc. Anyway, underscores are
> not allowed.
>=20
> > +      #address-cells =3D <2>;
> > +      #size-cells =3D <2>;
> > +      e5010: e5010@fd20000 {
>=20
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>=20
>=20
> Drop the label.
>=20
> > +          compatible =3D "img,e5010-jpeg-enc";
> > +          reg =3D <0x00 0xfd20000 0x00 0x100>,
> > +                <0x00 0xfd20200 0x00 0x200>;
> > +          reg-names =3D "regjasper", "regmmu";
> > +          clocks =3D <&k3_clks 201 0>;
> > +          clock-names =3D "core_clk";
> > +          power-domains =3D <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
> > +          interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> > +      };
> > +    };
>=20
>=20
> Best regards,
> Krzysztof
>=20

