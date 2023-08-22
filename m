Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C121783B79
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjHVINd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjHVINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:13:31 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAE110E;
        Tue, 22 Aug 2023 01:13:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58c92a2c52dso47263977b3.2;
        Tue, 22 Aug 2023 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692692008; x=1693296808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zW5Y8LaXGLER42IAGYB8LpUg+Xyn6q09HM2fWj9LCA=;
        b=Z3OGZL2wiDSe5NHPlCU7cuNR6emkVGyy4jZ/SsgrQS10FbOcU1IKuXhIX0Xjsrl0gF
         2IhZmFUEeZcY0cHN2oFHrMOcTB4/yW40ZhgYFg8/TU+VenLp8lf4u0gd8b2q6jzAomFr
         BQdvXg9/A5GQ0WUnxDecfUYqNx9KIW1Ds4Mn0TrDYdVjJmLICuJP8FMME2r52m/5B1Pi
         gCy+mCSZeWoZu7MS284XxHiGUq+MfMekWBN8bkNp4j2I4JlAr61+Y76sAgeZqrKWK11e
         an3g+NAfkjrn3UUaldR9SOK2aAImZS9N5Xs5BUc9QEQ+9uiD61yCwf9lFws8EZ9SYXR9
         O57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692008; x=1693296808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zW5Y8LaXGLER42IAGYB8LpUg+Xyn6q09HM2fWj9LCA=;
        b=gi0RBzA3K/Hx7weNmTBaWeyniVUv0X7nEdOvQx3A9Tksjc3fZOavKwgRmUMtFySzCL
         SQJJRmKvgyoRA/z7LVTha1K1+rtNcESgo1zZZrczXgdTgASbe8ezxN1WSwuXxhLBKH4H
         qYziMJtjqtwIXyyGMZrLbpRsbN7lbLyzGs/mKu64HNvdkeTPpG6bivviBLisC00ZtpQC
         TY+mV0ccE/cBP/4zlC4lVIupjnSFAhosyCkXA9u+us28J8Kqoa43BBtb/weXjGtxi9kN
         OKLdbaE4jr+j/zp1Q2xD+2ENKdDr++Jcqj9byjCgv1qyrnmjImttCG6j+tcOCvS8C8hK
         WbRQ==
X-Gm-Message-State: AOJu0Ywgz3R3uV9FGsqAaX7c57kM9xvicXEHbmjKbt1eDc34ogZIN67e
        FR/ry2XsAMCvDaCDhGAxJEtbrndzbLWvCF2pyGA=
X-Google-Smtp-Source: AGHT+IGzhoRe7kaDsYY+1xcJ1qTu6hq+dr2IGUoDyo75z2HkAVDWWdVVMQak0NsKFcKt4WjA43VlsIPaUJXWrm+zQ3c=
X-Received: by 2002:a0d:ca4c:0:b0:577:21ff:4d47 with SMTP id
 m73-20020a0dca4c000000b0057721ff4d47mr10517122ywd.7.1692692008134; Tue, 22
 Aug 2023 01:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn> <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org>
In-Reply-To: <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Tue, 22 Aug 2023 16:13:16 +0800
Message-ID: <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
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

Hi Krzysztof:

Thanks for your detailed reply.

On Tue, Aug 22, 2023 at 1:44=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/08/2023 08:13, Binbin Zhou wrote:
> > Since commit f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add
> > Loongson-2K1000 LIOINTC"), the loongson liointc supports configuring
> > routes for 64-bit interrupt sources.
> >
> > For liointc-2.0, we need to define two liointc nodes in dts, one for
> > "0-31" interrupt sources and the other for "32-63" interrupt sources.
> > This applies to mips Loongson-2K1000.
> >
> > Unfortunately, there are some warnings about "loongson,liointc-2.0":
> > 1. "interrupt-names" should be "required", the driver gets the parent
> > interrupts through it.
>
> No, why? Parent? This does not make sense.

This was noted in the v1 patch discussion. The liointc driver now gets
the parent interrupt via of_irq_get_byname(), so I think the
"interrupt-names" should be "required".

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/irqchip/irq-loongson-liointc.c?h=3Dv6.5-rc6#n345

static const char *const parent_names[] =3D {"int0", "int1", "int2", "int3"=
};

        for (i =3D 0; i < LIOINTC_NUM_PARENT; i++) {
                parent_irq[i] =3D of_irq_get_byname(node, parent_names[i]);
                if (parent_irq[i] > 0)
                        have_parent =3D TRUE;
        }
        if (!have_parent)
                return -ENODEV;

>
> >
> > 2. Since not all CPUs are multicore, e.g. Loongson-2K0500 is a
> > single-core CPU, there is no core1-related registers. So "reg" and
> > "reg-names" should be set to "minItems 2".
> >
> > 3. Routing interrupts from "int0" is a common solution in practice, but
> > theoretically there is no such requirement, as long as conflicts are
> > avoided. So "interrupt-names" should be defined by "pattern".
>
> Why? What the pattern has to do with anything in routing or not routing
> something?

First of all, interrupt routing is configurable and each intx handles
up to 32 interrupt sources. int0-int3 you can choose a single one or a
combination of multiple ones, as long as the intx chosen matches the
parent interrupt and is not duplicated:
Parent interrupt --> intx
2-->int0
3-->int1
4-->int2
5-->int3

As:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/mips/boot/dts/loongson/loongson64g-package.dtsi?h=3Dv6.5-rc6#n24

In addition, if there are 64 interrupt sources, such as the mips
Loongson-2K1000, and we need two dts nodes to describe the interrupt
routing, then there is bound to be a node without "int0".

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/mips/boot/dts/loongson/loongson64-2k1000.dtsi?h=3Dv6.5-rc6#n60

According to the current dt-binding rule, if the node does not have
"int0", there will be a dts_check warning, which is not in line with
our original intention.

>
> >
> > This fixes dtbs_check warning:
> >
> > DTC_CHK arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb
> > arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-cont=
roller@1fe11440: interrupt-names:0: 'int0' was expected
> >       From schema: Documentation/devicetree/bindings/interrupt-controll=
er/loongson,liointc.yaml
> > arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-cont=
roller@1fe11440: Unevaluated properties are not allowed ('interrupt-names' =
was unexpected)
> >       From schema: Documentation/devicetree/bindings/interrupt-controll=
er/loongson,liointc.yaml
> >
> > Fixes: f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add Loongson-2=
K1000 LIOINTC")
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> > V2:
> > 1. Update commit message;
> > 2. "interruprt-names" should be "required", the driver gets the parent
> > interrupts through it;
> > 3. Add more descriptions to explain the rationale for multiple nodes;
> > 4. Rewrite if-else statements.
> >
> > Link to V1:
> > https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongso=
n.cn/
> >
> >  .../loongson,liointc.yaml                     | 74 +++++++++----------
> >  1 file changed, 37 insertions(+), 37 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loo=
ngson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/loongson,liointc.yaml
> > index 00b570c82903..f695d3a75ddf 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > @@ -11,11 +11,11 @@ maintainers:
> >
> >  description: |
> >    This interrupt controller is found in the Loongson-3 family of chips=
 and
> > -  Loongson-2K1000 chip, as the primary package interrupt controller wh=
ich
> > +  Loongson-2K series chips, as the primary package interrupt controlle=
r which
> >    can route local I/O interrupt to interrupt lines of cores.
> > -
> > -allOf:
> > -  - $ref: /schemas/interrupt-controller.yaml#
> > +  In particular, the Loongson-2K1000/2K0500 has 64 interrupt sources t=
hat we
> > +  need to describe with two dts nodes. One for interrupt sources "0-31=
" and
> > +  the other for interrupt sources "32-63".
> >
> >  properties:
> >    compatible:
> > @@ -24,15 +24,9 @@ properties:
> >        - loongson,liointc-1.0a
> >        - loongson,liointc-2.0
> >
> > -  reg:
> > -    minItems: 1
> > -    minItems: 3
> > +  reg: true
>
> No. Constraints must be here.

May I ask a question:
Since different compatibles require different minItems/minItems for
the attribute, this writeup of defining the attribute to be true first
and then defining the specific value in an if-else statement is not
recommended?
>
> >
> > -  reg-names:
> > -    items:
> > -      - const: main
> > -      - const: isr0
> > -      - const: isr1
> > +  reg-names: true
>
> No, keep at least min/maxItems here.
>
> >
> >    interrupt-controller: true
> >
> > @@ -45,11 +39,9 @@ properties:
> >    interrupt-names:
> >      description: List of names for the parent interrupts.
> >      items:
> > -      - const: int0
> > -      - const: int1
> > -      - const: int2
> > -      - const: int3
> > +      pattern: int[0-3]
> >      minItems: 1
> > +    maxItems: 4
>
> I don't see reason behind it.
>
> >
> >    '#interrupt-cells':
> >      const: 2
> > @@ -69,32 +61,41 @@ required:
> >    - compatible
> >    - reg
> >    - interrupts
> > +  - interrupt-names
>
> Why? You are doing multiple things at once, without proper explanation.

Maybe this patch does too many things...
There are actually 3 things here, as stated in the commit message, and
since they are all about liointc-2.0 dts-check warnings, I put them in
a patch.
>
> >    - interrupt-controller
> >    - '#interrupt-cells'
> >    - loongson,parent_int_map
> >
> > -
> >  unevaluatedProperties: false
> >
> > -if:
> > -  properties:
> > -    compatible:
> > -      contains:
> > -        enum:
> > -          - loongson,liointc-2.0
> > -
> > -then:
> > -  properties:
> > -    reg:
> > -      minItems: 3
> > -
> > -  required:
> > -    - reg-names
> > -
> > -else:
> > -  properties:
> > -    reg:
> > -      maxItems: 1
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - loongson,liointc-2.0
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 2
> > +          items:
> > +            - description: Interrupt routing registers.
> > +            - description: Low/high 32-bit interrupt status routed to =
core0.
> > +            - description: Low/high 32-bit interrupt status routed to =
core1.
> > +        reg-names:
> > +          minItems: 2
> > +          items:
> > +            - const: main
> > +            - const: isr0
> > +            - const: isr1
>
> Srsly, why this is moved here from the top? It does not make sense.

In liointc-2.0, we need to deal with two dts nodes, and the setting
and routing registers are not contiguous, so the driver needs
"reg-names" to get the corresponding register mapping. So I put all
this in the liointc-2.0 section.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/irqchip/irq-loongson-liointc.c?h=3Dv6.5-rc6#n225

        if (revision > 1) {
                for (i =3D 0; i < LIOINTC_NUM_CORES; i++) {
                        int index =3D of_property_match_string(node,
                                        "reg-names", core_reg_names[i]);

                        if (index < 0)
                                continue;

                        priv->core_isr[i] =3D of_iomap(node, index);
                }

                if (!priv->core_isr[0])
                        goto out_iounmap;
        }


I referenced other dt-binding writeups and thought this would be clearer.

Is this if-else style not recommended? Should I keep the v1 patch writeup?
https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongson.cn=
/

Thanks.
Binbin
>
> > +      required:
> > +        - reg-names
> > +    else:
> > +      properties:
> > +        reg:
> > +          maxItems: 1
>
> so reg-names can be "pink-pony"?
>
> Best regards,
> Krzysztof
>
