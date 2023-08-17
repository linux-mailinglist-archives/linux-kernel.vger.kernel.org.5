Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA13777EF39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347712AbjHQC5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347759AbjHQC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:57:01 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB902D5E;
        Wed, 16 Aug 2023 19:56:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5862a6ae535so70618327b3.0;
        Wed, 16 Aug 2023 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692241009; x=1692845809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfnhS8cUb8GoNRJIvYqauF7SihQC0CPjejzZeRQgsAU=;
        b=Me7ULkhseFqx4TBsDIe127ajql9iF+PzyM6967hsSTRq2WCIxbhpxucYxPcgN5Qs3o
         6WZ58VeS+FQnTZUICO6uxzNqtbEUYIZLCJ4JujinwJeX6wI+zsaPPSag7dxgQmYaBzV6
         o3FBvXGNd6r0YRbAZzvwY8zxtCvYxmncyIPOialkogDuq4/vJnGnWagvbcc5iAmd1Wm2
         H7pLz4jk8HUXhcjY7hfz6ZujXCc2i0qZD2ELnPJlqbg8HQsWNKWXwF8RyinKDze7Pi0+
         cSTiAVCTsFKTdFRYBEZNEZ7uEwpnGnUpZ8XhnU8TKcsybDK0Fh4kkukV7S3O1x0RmT5i
         LVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692241009; x=1692845809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfnhS8cUb8GoNRJIvYqauF7SihQC0CPjejzZeRQgsAU=;
        b=QdfQlCUZvRLOJ9nZTuduSLkD0uKXw6DddfWXdzAB/uyP6/T2fcsl1aff83VEz7iebV
         J/816gYNKY7sPbrmIik/o+B9/j7bHWqZERZJi0IbTwgMoILzuHrk9ynSKCngKgnSFaM+
         bWpJ+NOsNMJH8rsY5ZsXo5SJU3ZzBYjuGv4PQ0NaZZA05UZE9k/EJ7cIvgmUqtIuqR2g
         zhb5wXJ3qPRChqgONAn8EzkFjrzezqqfFLnFWyVMMmxd+UXSpxHHgH8B3qKXEJuCW3K7
         cr3mFHI+nVcI3JJQW8fDyh0+WVoHxgdvVF2hU9lCLU4+sdKmvk7vspZhATS5U9NfIM8O
         94pw==
X-Gm-Message-State: AOJu0Yx1+rEsEQNZqoDgt4tOCfP3bRpNoXO8y7jkgVYOaUUiragaLYNi
        Sb4a7SZg4dzOEcOPYmd0EBHQpsOXKxKHAYT7xDBYlQ5UZk66eOqRwyU=
X-Google-Smtp-Source: AGHT+IH2+d+/Fe6gURluHyKSTJhQcU5e4YCRM3Qaq+Wb7O3ekCuK0/KbXx9ZDaC+TKvZaUx1X+cbkp0SXM/Wzuif4/c=
X-Received: by 2002:a0d:e253:0:b0:584:61df:45e8 with SMTP id
 l80-20020a0de253000000b0058461df45e8mr3531796ywe.13.1692241009393; Wed, 16
 Aug 2023 19:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230815084713.1627520-1-zhoubinbin@loongson.cn> <20230815-certainly-sprang-209024530924@spud>
In-Reply-To: <20230815-certainly-sprang-209024530924@spud>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Thu, 17 Aug 2023 10:56:37 +0800
Message-ID: <CAMpQs4+68Ow4-rubj2ySiRiU7d0jc1F3GOsXqxaZdT27PZSuxg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: loongson,liointc: Fix
 warnings about reg and interrupt description
To:     Conor Dooley <conor@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
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

Hi Conor:

Thanks for your reply.

On Tue, Aug 15, 2023 at 10:20=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey,
>
> On Tue, Aug 15, 2023 at 04:47:13PM +0800, Binbin Zhou wrote:
> > As we know, some Loongson-2K CPUs are single-core, e.g. Loongson-2K0500=
,
> > and the "isr1" means routing interrupts to core1, which should be
> > optional. So add maxItems/minItems limits to reg/reg-names.
> > Also, The interrupt-names attribute represents a list of parent
> > interrupt names that should change with interrupts.
>
> This should have been with the other series that introduces the users
> probably so that things make more sense to the reader.

I was under the impression that the mips Loongson-2K1000 was also
required for this patch, so I committed it separately.
Maybe my commit should still be described in more detail.

>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../interrupt-controller/loongson,liointc.yaml     | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loo=
ngson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/loongson,liointc.yaml
> > index 00b570c82903..adb428211a72 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > @@ -11,7 +11,7 @@ maintainers:
> >
> >  description: |
> >    This interrupt controller is found in the Loongson-3 family of chips=
 and
> > -  Loongson-2K1000 chip, as the primary package interrupt controller wh=
ich
> > +  Loongson-2K series chips, as the primary package interrupt controlle=
r which
> >    can route local I/O interrupt to interrupt lines of cores.
> >
> >  allOf:
> > @@ -33,6 +33,7 @@ properties:
> >        - const: main
> >        - const: isr0
> >        - const: isr1
> > +    minItems: 2
> >
> >    interrupt-controller: true
> >
> > @@ -45,11 +46,9 @@ properties:
> >    interrupt-names:
> >      description: List of names for the parent interrupts.
> >      items:
> > -      - const: int0
> > -      - const: int1
> > -      - const: int2
> > -      - const: int3
> > +      pattern: int[0-3]
>
> From a quick look at the new devicetrees, I don't understand the
> ordering relaxation. Do you actually have a system that only has, for
> example, int3?

For a better understanding, allow me to first explain the composition
of the interrupt routing register:
It is an 8 bit register that is divided into two parts:
0-3 : The processor core vector number of the route, this part is
handled in the code.
4-7 : The processor core interrupt pin vector number for routing, i.e.
int0-int3.
Each intx can handle 32 interrupt sources.

For example, in Loongson-2K1000/Loongson-2K0500, there are a total of
64 interrupt sources, and we need to route them to two intx.

We don't mandate which interrupt vector number must be used, in our
practice the tendency is to start with int0.
It is worth noting that we must follow the following correspondence:
interrupt->interrupt-names
2->int0
3->int1
4->int2
5->int3

>
> Also, as the interrupt-names are not required, changing the ordering
> here is not ABI compatible AFAICT. Does that have any fallout?

Oh, this should be another point that needs to be modified, the
interrupt-names should be required. because in the driver code the
parent interrupts are fetched through of_irq_get_byname().

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/irqchip/irq-loongson-liointc.c?h=3Dv6.5-rc6#n345

        for (i =3D 0; i < LIOINTC_NUM_PARENT; i++) {
                parent_irq[i] =3D of_irq_get_byname(node, parent_names[i]);
                if (parent_irq[i] > 0)
                        have_parent =3D TRUE;
        }
        if (!have_parent)
                return -ENODEV;

Also the way liointc-2.0 is written in the dts does not match the dt-bindin=
g.
The dts using loongson,liointc-2.0 are:
arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi (mips Loongson-2K1000)
arch/loongarch/boot/dts/loongson-2k0500.dtsi
arch/loongarch/boot/dts/loongson-2k1000.dtsi
arch/loongarch/boot/dts/loongson-2k2000.dtsi

               liointc0: interrupt-controller@1fe01400 {
......
                        interrupts =3D <2>;
                        interrupt-names =3D "int0";
                        loongson,parent_int_map =3D <0xffffffff>, /* int0 *=
/
                                                <0x00000000>, /* int1 */
                                                <0x00000000>, /* int2 */
                                                <0x00000000>; /* int3 */
                };

                liointc1: interrupt-controller@1fe01440 {
....
                       interrupts =3D <3>;
                        interrupt-names =3D "int1";
                        loongson,parent_int_map =3D <0x00000000>, /* int0 *=
/
                                                <0xffffffff>, /* int1 */
                                                <0x00000000>, /* int2 */
                                                <0x00000000>; /* int3 */
                };

We split the two intx into two nodes because of register definitions
etc. There is the following WARNING at liointc1:

      arch/loongarch/boot/dts/loongson-2k1000-ref.dtb:
interrupt-controller@1fe01440: interrupt-names:0: 'int0' was expected
            From schema:
Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yam=
l
      arch/loongarch/boot/dts/loongson-2k1000-ref.dtb:
interrupt-controller@1fe01440: Unevaluated properties are not allowed
('interrupt-names' was unexpected)
            From schema:
Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yam=
l

But actually, in liointc1, we only need int1.

Thanks.
Binbin

>
> Thanks,
> Conor.
>
> >      minItems: 1
> > +    maxItems: 4
> >
> >    '#interrupt-cells':
> >      const: 2
> > @@ -73,7 +72,6 @@ required:
> >    - '#interrupt-cells'
> >    - loongson,parent_int_map
> >
> > -
> >  unevaluatedProperties: false
> >
> >  if:
> > @@ -86,7 +84,8 @@ if:
> >  then:
> >    properties:
> >      reg:
> > -      minItems: 3
> > +      minItems: 2
> > +      maxItems: 3
> >
> >    required:
> >      - reg-names
> > @@ -113,7 +112,6 @@ examples:
> >                                  <0x0f000000>, /* int1 */
> >                                  <0x00000000>, /* int2 */
> >                                  <0x00000000>; /* int3 */
> > -
> >      };
> >
> >  ...
> > --
> > 2.39.3
> >
