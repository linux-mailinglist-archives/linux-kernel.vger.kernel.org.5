Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE07BFF9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjJJOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjJJOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:50:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44472C6;
        Tue, 10 Oct 2023 07:50:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C18FC433C9;
        Tue, 10 Oct 2023 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696949417;
        bh=JhuQXBSPj6aFMuffNqgpC/hPfXH0KhfFsBRMiiFK1go=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ExMTOBAlCjDHwV1o41MulJQH3Uo0HoyZQ+8rQ0siqRitFLCVCY/Im8GUZ7ZQbrmUB
         NrZKOZCyTkGnhNgmm0YhnRyxQ2xIQmB83+bBoZfZhOs4Z2yOyRZ2Y5GqTNlYGJnvac
         o75MFHwEPpekK8GESRLiX0BOcKlly9rc36svv+D+IpHUl1ejMvGqUirRW9exqsunOX
         h43r5xJ08xA1ewNQhEu2V8MEJiCA2nmdjEKwmziLTRLQqTXEsSZ8IkHBq50O0HRMFn
         e5fRg5173sgDZEsEquTd+j0VbWXQI+ZD8hCDC4iPXEEdw3nRG0/SDSctoi1HcKW7qR
         4qAXTcoONi+qQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50308217223so7216909e87.3;
        Tue, 10 Oct 2023 07:50:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YzDO9Ut1cH9Q6L6BmbHnxXjptGDI175QTIdjqYL46JoJBdUiFEv
        AyrgLAxaLPvoEdTib8fOrp/+jEFzT/5HfWOa1Q==
X-Google-Smtp-Source: AGHT+IGoRh0JfkTjF6Rgd+yngHQANrwoY5g/RAu+mkpwCwhIs43wUG5v2Wv6X2UpqlhBgbTJEqSp9iqWFCSxal6azAg=
X-Received: by 2002:a05:6512:3e01:b0:503:3453:ea7a with SMTP id
 i1-20020a0565123e0100b005033453ea7amr19326327lfv.66.1696949415802; Tue, 10
 Oct 2023 07:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231004063712.3348978-1-alvin@pqrs.dk> <20231004063712.3348978-2-alvin@pqrs.dk>
 <20231004143937.GA3091822-robh@kernel.org> <mkeegnnfuxmutdkun7tprz27miyeisvhppsdp5mxmeq4kykecy@b576w45hwcbd>
In-Reply-To: <mkeegnnfuxmutdkun7tprz27miyeisvhppsdp5mxmeq4kykecy@b576w45hwcbd>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 10 Oct 2023 09:50:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKrGM1KFPxECXM49KZ-CYxhBShODk0TQeEMx8r-ztSh6Q@mail.gmail.com>
Message-ID: <CAL_JsqKrGM1KFPxECXM49KZ-CYxhBShODk0TQeEMx8r-ztSh6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: si5351: convert to yaml
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 4:40=E2=80=AFPM Alvin =C5=A0ipraga <ALSI@bang-olufse=
n.dk> wrote:
>
> On Wed, Oct 04, 2023 at 09:39:37AM -0500, Rob Herring wrote:
> > > +      silabs,multisynth-source:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        enum: [ 0, 1 ]
> > > +        description: |
> >
> > Don't need '|' if no formatting to preserve.
>
> I thought the line would be too long otherwise.
> Column width is 80 in dt-schema as well, right?

Yes, and up to 100 is fine as an exception.

> >
> > > +          Source PLL A (0) or B (1) for the corresponding multisynth=
 divider.

But this doesn't look like it is over 80. Maybe if you put after
'description:' on the same line, but that's not what I said. It can
still be on the next line. No '|' just means the line endings aren't
fixed. Not important now, but if we were to generate pretty
documentation from the schemas, then it would matter.

>
> [...]
>
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - silabs,si5351a
> > > +              - silabs,si5351a-msop
> > > +              - silabs,si5351b
> >
> > Isn't this just the 'else' for the next one? Or more parts are coming?
>
> Not sure if more parts are coming - these are the only ones I am aware of=
. But I
> have not checked thoroughly. I thought it better to be explicit, but I wi=
ll
> change the next one to an else: in v3 unless you change your mind.
>
> >
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          minItems: 1
> > > +          maxItems: 1
> > > +        clock-names:
> > > +          items:
> > > +            - const: xtal
> > > +
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: silabs,si5351c
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          minItems: 1
> > > +          maxItems: 2
> > > +        clock-names:
> > > +          minItems: 1
> > > +          items:
> > > +            - const: xtal
> > > +            - const: clkin
> >
> > Define clocks and clock-names at the top level and just use
> > minItems/maxItems in the if/then schemas.
>
> I was trying to imply here that it is invalid to specify clkin for the fo=
rmer
> three part types - only for the si5351c. If I specify both in the top-lev=
el
> clock-names:items then it would allow something like this:
>
>   clk {
>     compatible =3D "silabs,si5351a-msop";
>     clocks =3D <&ref25>;
>     clock-names =3D "clkin"; /* not OK - Si5351A-MSOP only supports XTAL =
*/
>   };

What I'm saying will work. There are lots of examples in the tree. The
top-level defines the full array and then the if/then schema just sets
the max size to 1 so that the clkin entry is not allowed.

properties:
  clock-names:
    minItems: 1
    items:
      - const: xtal
      - const: clkin

if:
  properties:
    compatible:
      contains:
        const: silabs,si5351a-msop
then:
  properties:
    clock-names:
      maxItems: 1

(and then "minItems: 2" for the cases with 2 clocks)

Rob
