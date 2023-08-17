Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE44F77F535
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350305AbjHQL2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350314AbjHQL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:27:33 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31F30DC;
        Thu, 17 Aug 2023 04:27:03 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-586a684e85aso81427547b3.2;
        Thu, 17 Aug 2023 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692271618; x=1692876418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWtT4J/UvU2mn20j2V9lIhWo8J+pJELKqRIdHfBXPfM=;
        b=s22DM1cpLtsnIs6q0oETWlIoRH48d5wuNYKyJyH0fuTmx5i9/JKywCfFWZmaZ7MoY3
         FqOqzIbaFKoVIlLNLgUh861TToG2JB7+2xTG9aGc0JybDPvmizztxQgb4k2uHMTcN6Ql
         nFLKLkqN93Zw+yAmIDWgX+v6bZzYogY6AjTHB2wO8ASQ8q3mvzl6x5wEgr/bmICKt+dg
         XCagb5NYwoHiLNeJ2/EZ9M6qJTseq8dR2jN7Z3zw6xj5BkoXF+xdFsSKvdM99vRe8aLk
         uCwqJspxy9CJ/WwAM3egbJwEjh0JWYIqYiAH/d3Htlb9JRJKLZTmOLcU5x46PZP36Vsq
         KDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692271618; x=1692876418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWtT4J/UvU2mn20j2V9lIhWo8J+pJELKqRIdHfBXPfM=;
        b=O+IZZuD3koLxSmC046e9q5PN6fpbgf4Z/lbgQxGrzfdK+NDXahLnec+vNJ59o+S2YC
         2IQ1LQcCZsT0hBGib0wqJFU/GdR5mT8S1SVopuSIJ3gxQfltSgIjpcPZ1AcpXuEIwDBo
         /tRu3q2dgKEoy1M8VH+baLYBw70a9NtOG3DxT3jJdCUn9M62Gi1FzjKiNsrV9K7G3OmX
         TpP88rnwLiZ8+7h+34HodrliAWC4ebZKIy/zrNvwujzVZWzhW/RPF9tvLhuKSU+TsWss
         /dZSgQMwwpQjoG6I747/1luFANGe7jHLsyFQPOMo0tXOdaN06ycLaljb97Baklsu3N8y
         di0A==
X-Gm-Message-State: AOJu0Yy+utqQHiMfIDRBxQbwytghUYZG7zSqNe30MRtxpGlF0blqyGFO
        fYJ4oE9s0K/w5w+Z54GAg1+v1L3P1OT84I/Hj70tjlR9Jtfbpvsl5Jc=
X-Google-Smtp-Source: AGHT+IHO+D/5OQRsSAOd7+REd+X38EBECMRHb0qG3C9AnHXxvcDMmQgsJIJYaIRWyDVGke6p+gyvOBi+XuLyFh+iYj4=
X-Received: by 2002:a0d:ce86:0:b0:577:3561:8a81 with SMTP id
 q128-20020a0dce86000000b0057735618a81mr4616863ywd.22.1692271617961; Thu, 17
 Aug 2023 04:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230815084713.1627520-1-zhoubinbin@loongson.cn>
 <20230815-certainly-sprang-209024530924@spud> <CAMpQs4+68Ow4-rubj2ySiRiU7d0jc1F3GOsXqxaZdT27PZSuxg@mail.gmail.com>
 <20230817-relic-anyplace-4df08eb6b0a9@spud>
In-Reply-To: <20230817-relic-anyplace-4df08eb6b0a9@spud>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Thu, 17 Aug 2023 19:26:45 +0800
Message-ID: <CAMpQs4+jdT5oANb0B-aRCL4JcsL6ufobK8siLdW3vS59K1MGkA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 4:51=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Aug 17, 2023 at 10:56:37AM +0800, Binbin Zhou wrote:
> > Hi Conor:
> >
> > Thanks for your reply.
> >
> > On Tue, Aug 15, 2023 at 10:20=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > Hey,
> > >
> > > On Tue, Aug 15, 2023 at 04:47:13PM +0800, Binbin Zhou wrote:
> > > > As we know, some Loongson-2K CPUs are single-core, e.g. Loongson-2K=
0500,
> > > > and the "isr1" means routing interrupts to core1, which should be
> > > > optional. So add maxItems/minItems limits to reg/reg-names.
> > > > Also, The interrupt-names attribute represents a list of parent
> > > > interrupt names that should change with interrupts.
> > >
> > > This should have been with the other series that introduces the users
> > > probably so that things make more sense to the reader.
> >
> > I was under the impression that the mips Loongson-2K1000 was also
> > required for this patch, so I committed it separately.
> > Maybe my commit should still be described in more detail.
>
> Ah, I just assumed, given the timing, that it was for the loongson
> stuff only.
>
> > > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > ---
> > > >  .../interrupt-controller/loongson,liointc.yaml     | 14 ++++++----=
----
> > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller=
/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> > > > index 00b570c82903..adb428211a72 100644
> > > > --- a/Documentation/devicetree/bindings/interrupt-controller/loongs=
on,liointc.yaml
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongs=
on,liointc.yaml
> > > > @@ -11,7 +11,7 @@ maintainers:
> > > >
> > > >  description: |
> > > >    This interrupt controller is found in the Loongson-3 family of c=
hips and
> > > > -  Loongson-2K1000 chip, as the primary package interrupt controlle=
r which
> > > > +  Loongson-2K series chips, as the primary package interrupt contr=
oller which
> > > >    can route local I/O interrupt to interrupt lines of cores.
> > > >
> > > >  allOf:
> > > > @@ -33,6 +33,7 @@ properties:
> > > >        - const: main
> > > >        - const: isr0
> > > >        - const: isr1
> > > > +    minItems: 2
> > > >
> > > >    interrupt-controller: true
> > > >
> > > > @@ -45,11 +46,9 @@ properties:
> > > >    interrupt-names:
> > > >      description: List of names for the parent interrupts.
> > > >      items:
> > > > -      - const: int0
> > > > -      - const: int1
> > > > -      - const: int2
> > > > -      - const: int3
> > > > +      pattern: int[0-3]
> > >
> > > From a quick look at the new devicetrees, I don't understand the
> > > ordering relaxation. Do you actually have a system that only has, for
> > > example, int3?
> >
> > For a better understanding, allow me to first explain the composition
> > of the interrupt routing register:
> > It is an 8 bit register that is divided into two parts:
> > 0-3 : The processor core vector number of the route, this part is
> > handled in the code.
> > 4-7 : The processor core interrupt pin vector number for routing, i.e.
> > int0-int3.
> > Each intx can handle 32 interrupt sources.
> >
> > For example, in Loongson-2K1000/Loongson-2K0500, there are a total of
> > 64 interrupt sources, and we need to route them to two intx.
> >
> > We don't mandate which interrupt vector number must be used, in our
> > practice the tendency is to start with int0.
> > It is worth noting that we must follow the following correspondence:
> > interrupt->interrupt-names
> > 2->int0
> > 3->int1
> > 4->int2
> > 5->int3
> >
> > >
> > > Also, as the interrupt-names are not required, changing the ordering
> > > here is not ABI compatible AFAICT. Does that have any fallout?
> >
> > Oh, this should be another point that needs to be modified, the
> > interrupt-names should be required. because in the driver code the
> > parent interrupts are fetched through of_irq_get_byname().
>
> Yeah, that should probably be made required so.
>
> > Also the way liointc-2.0 is written in the dts does not match the dt-bi=
nding.
> > The dts using loongson,liointc-2.0 are:
>
>
> > arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi (mips Loongson-2K100=
0)
> > arch/loongarch/boot/dts/loongson-2k0500.dtsi
> > arch/loongarch/boot/dts/loongson-2k1000.dtsi
> > arch/loongarch/boot/dts/loongson-2k2000.dtsi
> >
> >                liointc0: interrupt-controller@1fe01400 {
> > ......
> >                         interrupts =3D <2>;
> >                         interrupt-names =3D "int0";
> >                         loongson,parent_int_map =3D <0xffffffff>, /* in=
t0 */
> >                                                 <0x00000000>, /* int1 *=
/
> >                                                 <0x00000000>, /* int2 *=
/
> >                                                 <0x00000000>; /* int3 *=
/
> >                 };
> >
> >                 liointc1: interrupt-controller@1fe01440 {
> > ....
> >                        interrupts =3D <3>;
> >                         interrupt-names =3D "int1";
> >                         loongson,parent_int_map =3D <0x00000000>, /* in=
t0 */
> >                                                 <0xffffffff>, /* int1 *=
/
> >                                                 <0x00000000>, /* int2 *=
/
> >                                                 <0x00000000>; /* int3 *=
/
> >                 };
> >
> > We split the two intx into two nodes because of register definitions
> > etc. There is the following WARNING at liointc1:
>
> Did you split it in two because of register definitions, or because
> there are physically two controllers on the SoC? Your comments earlier
> sound like there are physically two interrupt controllers, which would
> be a valid reason to split the nodes.

Hi, Conor:

Whoops, it looks like my description is still not clear enough.

First of all, a chip has only one physical liointc.

Unlike other chips, Loongson-2K1000/2K0500 has 64 interrupt sources,
which requires two sets of registers to set the routing of all the
interrupts, and correspondingly two nodes to describe them in dts.
Concretely, in Loongson-2K1000/2K0500:
     liointc0: indicates the routing of interrupt sources 0-31;
     liointc1: indicates the routing of interrupt sources 32-63.

Others, such as Loongson-3A, have only 32 interrupt sources and need
only one liointc node.

For better understanding, I'll add a more detailed description, which
should especially point out the 2K1000/2K0500 differences.
For example, for reg-names description:
main: interrupt routing registers
isr0: low/high 32-bit interrupt status routed to CORE0.
isr1: low/high 32-bit interrupt status routed to CORE1.

Thanks.
Binbin

>
> Thanks,
> Conor.
>
> >       arch/loongarch/boot/dts/loongson-2k1000-ref.dtb:
> > interrupt-controller@1fe01440: interrupt-names:0: 'int0' was expected
> >             From schema:
> > Documentation/devicetree/bindings/interrupt-controller/loongson,liointc=
.yaml
> >       arch/loongarch/boot/dts/loongson-2k1000-ref.dtb:
> > interrupt-controller@1fe01440: Unevaluated properties are not allowed
> > ('interrupt-names' was unexpected)
> >             From schema:
> > Documentation/devicetree/bindings/interrupt-controller/loongson,liointc=
.yaml
> >
> > But actually, in liointc1, we only need int1.
> >
> > Thanks.
> > Binbin
> >
> > >
> > > Thanks,
> > > Conor.
> > >
> > > >      minItems: 1
> > > > +    maxItems: 4
> > > >
> > > >    '#interrupt-cells':
> > > >      const: 2
> > > > @@ -73,7 +72,6 @@ required:
> > > >    - '#interrupt-cells'
> > > >    - loongson,parent_int_map
> > > >
> > > > -
> > > >  unevaluatedProperties: false
> > > >
> > > >  if:
> > > > @@ -86,7 +84,8 @@ if:
> > > >  then:
> > > >    properties:
> > > >      reg:
> > > > -      minItems: 3
> > > > +      minItems: 2
> > > > +      maxItems: 3
> > > >
> > > >    required:
> > > >      - reg-names
> > > > @@ -113,7 +112,6 @@ examples:
> > > >                                  <0x0f000000>, /* int1 */
> > > >                                  <0x00000000>, /* int2 */
> > > >                                  <0x00000000>; /* int3 */
> > > > -
> > > >      };
> > > >
> > > >  ...
> > > > --
> > > > 2.39.3
> > > >
