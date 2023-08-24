Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102C1786DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbjHXLdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbjHXLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:32:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770B10FC;
        Thu, 24 Aug 2023 04:32:49 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d650a22abd7so6478702276.3;
        Thu, 24 Aug 2023 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876768; x=1693481568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFzuk6LjNd6O3SJJcDHZwMhSOEnjaTo2LUY1fJylIvY=;
        b=iQNdyhF+GnMTD3X9aPCAsEjySzRqLMQmpDyKFky61tmbtE8s29lGC+bqlrRnHvHzo2
         L1bQj5qTAkug8xnWRnQoCzQNEMtHaCnt22LlnFe+FxCKe8d+lSlMUa2oHKvwUdJC1eVv
         W2pYkt8q2W9BiKuZBzNcfPFI/eCoaAh0jZBzch3FWtuFV4cyKVeIB8Ss7jrg39rWU6o/
         k+T1DjpG296DMhtF+hnbzWKbXb3bEqlpg2SWsZuNhnFO9aFkc9KEQztlRO8orkAS9uon
         rdhHV9T2l5UoGayO9R+o4ZPmuxDPVWJs+wakBZ8b/BMMgy2XjeU2CdfaZ99t0qb7uwm8
         iavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876768; x=1693481568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFzuk6LjNd6O3SJJcDHZwMhSOEnjaTo2LUY1fJylIvY=;
        b=EixIA9XfaaULLxcZUXFxJMjhH+n2A+ld4xuvDP0QMs3zEYUPG+525kayCJHWE5w/lQ
         JjIwlsrGmuT5BMTEKWfnJzix85PpJyjxkXxMWtY8N6tGxBPhgaBHbQOE12tFD7Fia7d2
         PyfnVqORHmktGtvAuQ53fykoOpy2FP4BXPbQPWOJtxoAomvzgxSo6qhTkKyoelmNR2XO
         hdeqgzK1LOdqFgKtPHfsXhUyZxfkLdAbwFnvPALXysygQFhFrALPQ0tj3lAxTr4PGbZC
         nOsZs/za1vVx+8p6owex+u9TNljl4G90JL88b8AnNRzWU7d95rkOW/Lpltmp6JvyO7SE
         qeKA==
X-Gm-Message-State: AOJu0YykSlHUD366WTxB/VkfMx+2ZsGe+oVf3sN2sak1ID8QbVsjRXHA
        nEIcsg2bpx2jA4Jl64MFbqWqDS884N96dZ48zng=
X-Google-Smtp-Source: AGHT+IEn8aX0Ghqxzi2g8EaeBYAiNIRZKT80Gmb0Nz9tRlI2YyrtbNPuIBXaV4jh4+DIBUvVEDYqBkMyUujAPQqm/Tg=
X-Received: by 2002:a81:8882:0:b0:55a:3ce9:dc3d with SMTP id
 y124-20020a818882000000b0055a3ce9dc3dmr15016049ywf.13.1692876768535; Thu, 24
 Aug 2023 04:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org>
In-Reply-To: <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Thu, 24 Aug 2023 19:32:36 +0800
Message-ID: <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof:

Thanks for your detailed reply.

On Tue, Aug 22, 2023 at 4:30=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/08/2023 10:13, Binbin Zhou wrote:
> > Hi Krzysztof:
> >
> > Thanks for your detailed reply.
> >
> > On Tue, Aug 22, 2023 at 1:44=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 21/08/2023 08:13, Binbin Zhou wrote:
> >>> Since commit f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add
> >>> Loongson-2K1000 LIOINTC"), the loongson liointc supports configuring
> >>> routes for 64-bit interrupt sources.
> >>>
> >>> For liointc-2.0, we need to define two liointc nodes in dts, one for
> >>> "0-31" interrupt sources and the other for "32-63" interrupt sources.
> >>> This applies to mips Loongson-2K1000.
> >>>
> >>> Unfortunately, there are some warnings about "loongson,liointc-2.0":
> >>> 1. "interrupt-names" should be "required", the driver gets the parent
> >>> interrupts through it.
> >>
> >> No, why? Parent? This does not make sense.
> >
> > This was noted in the v1 patch discussion. The liointc driver now gets
> > the parent interrupt via of_irq_get_byname(), so I think the
> > "interrupt-names" should be "required".
>
> of_irq_get_byname() does not give you parent interrupt, but the
> interrupt. Why do you need parent interrupt and what is it?
>
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/irqchip/irq-loongson-liointc.c?h=3Dv6.5-rc6#n345
> >
> > static const char *const parent_names[] =3D {"int0", "int1", "int2", "i=
nt3"};
> >
> >         for (i =3D 0; i < LIOINTC_NUM_PARENT; i++) {
> >                 parent_irq[i] =3D of_irq_get_byname(node, parent_names[=
i]);
> >                 if (parent_irq[i] > 0)
> >                         have_parent =3D TRUE;
> >         }
> >         if (!have_parent)
> >                 return -ENODEV;
>
> How requiring parents interrupt is related to other changes in this
> file? One logical change, one patch.

Yes, that was my mistake, whether or not the interrupt-names need to
be "required" is another issue. It does not cause a check warning.
I'll think about it some more.
>
> Anyway why did you do it and take it by names? Names here are basically
> useless if they match indices, so just get interrupt by indices.

There is a match between interrupts, interrupt names and interrupt maps:

interrupt->interrupt name->interrupt map
2->int0->int_map[0]
3->int1->int_map[1]
4->int2->int_map[2]
5->int3->int_map[3]

As part of the 2k1000 liointc1 node:

                liointc1: interrupt-controller@1fe11440 {
....
                        interrupt-parent =3D <&cpuintc>;
                        interrupts =3D <3>;
                        interrupt-names =3D "int1";

                        loongson,parent_int_map =3D <0x00000000>, /* int0 *=
/
                                                <0xffffffff>, /* int1 */
                                                <0x00000000>, /* int2 */
                                                <0x00000000>; /* int3 */
                };

To ensure this mapping relationship, the interrupt name becomes the
intermediate bridge.

>
> >
> >>
> >>>
> >>> 2. Since not all CPUs are multicore, e.g. Loongson-2K0500 is a
> >>> single-core CPU, there is no core1-related registers. So "reg" and
> >>> "reg-names" should be set to "minItems 2".
> >>>
> >>> 3. Routing interrupts from "int0" is a common solution in practice, b=
ut
> >>> theoretically there is no such requirement, as long as conflicts are
> >>> avoided. So "interrupt-names" should be defined by "pattern".
> >>
> >> Why? What the pattern has to do with anything in routing or not routin=
g
> >> something?
> >
> > First of all, interrupt routing is configurable and each intx handles
> > up to 32 interrupt sources. int0-int3 you can choose a single one or a
> > combination of multiple ones, as long as the intx chosen matches the
> > parent interrupt and is not duplicated:
> > Parent interrupt --> intx
> > 2-->int0
> > 3-->int1
> > 4-->int2
> > 5-->int3
> >
> > As:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/mips/boot/dts/loongson/loongson64g-package.dtsi?h=3Dv6.5-rc6#n24
> >
> > In addition, if there are 64 interrupt sources, such as the mips
> > Loongson-2K1000, and we need two dts nodes to describe the interrupt
> > routing, then there is bound to be a node without "int0".
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi?h=3Dv6.5-rc6#n60
>
> All of them start from 0, so why do you want to allow here starting from =
3?

Actually now we are all starting at int0.
Since the 2K1000 has 64 interrupt sources, we need two nodes to route
the interrupts. Usually liointc0 (handle 0-31 interrupts sources )uses
int0 and liointc1 (handle 32-63 interrupts sources ) uses int1.
As follows:

                liointc0: interrupt-controller@1fe11400 {
.....
                        interrupt-parent =3D <&cpuintc>;
                        interrupts =3D <2>;
                        interrupt-names =3D "int0";

                        loongson,parent_int_map =3D <0xffffffff>, /* int0 *=
/
                                                <0x00000000>, /* int1 */
                                                <0x00000000>, /* int2 */
                                                <0x00000000>; /* int3 */
                };

                liointc1: interrupt-controller@1fe11440 {
....
                        interrupt-parent =3D <&cpuintc>;
                        interrupts =3D <3>;
                        interrupt-names =3D "int1";

                        loongson,parent_int_map =3D <0x00000000>, /* int0 *=
/
                                                <0xffffffff>, /* int1 */
                                                <0x00000000>, /* int2 */
                                                <0x00000000>; /* int3 */
                };

At this point, liointc1 will be warned that it is not starting from
int0, and that int0 is actually being used by liointc0.

>
> >
> > According to the current dt-binding rule, if the node does not have
> > "int0", there will be a dts_check warning, which is not in line with
> > our original intention.
>
> Why DT node would not have int0? Provide proper upstreamed Linux kernel
> source proving this, not some imaginary code.
>
> >
> >>
> >>>
> >>> This fixes dtbs_check warning:
> >>>
> >>> DTC_CHK arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb
> >>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-co=
ntroller@1fe11440: interrupt-names:0: 'int0' was expected
> >>>       From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> >>> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-co=
ntroller@1fe11440: Unevaluated properties are not allowed ('interrupt-names=
' was unexpected)
> >>>       From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> >>>
> >>> Fixes: f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add Loongson=
-2K1000 LIOINTC")
> >>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>> ---
> >>> V2:
> >>> 1. Update commit message;
> >>> 2. "interruprt-names" should be "required", the driver gets the paren=
t
> >>> interrupts through it;
> >>> 3. Add more descriptions to explain the rationale for multiple nodes;
> >>> 4. Rewrite if-else statements.
> >>>
> >>> Link to V1:
> >>> https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loong=
son.cn/
> >>>
> >>>  .../loongson,liointc.yaml                     | 74 +++++++++--------=
--
> >>>  1 file changed, 37 insertions(+), 37 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/l=
oongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controll=
er/loongson,liointc.yaml
> >>> index 00b570c82903..f695d3a75ddf 100644
> >>> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson=
,liointc.yaml
> >>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson=
,liointc.yaml
> >>> @@ -11,11 +11,11 @@ maintainers:
> >>>
> >>>  description: |
> >>>    This interrupt controller is found in the Loongson-3 family of chi=
ps and
> >>> -  Loongson-2K1000 chip, as the primary package interrupt controller =
which
> >>> +  Loongson-2K series chips, as the primary package interrupt control=
ler which
> >>>    can route local I/O interrupt to interrupt lines of cores.
> >>> -
> >>> -allOf:
> >>> -  - $ref: /schemas/interrupt-controller.yaml#
> >>> +  In particular, the Loongson-2K1000/2K0500 has 64 interrupt sources=
 that we
> >>> +  need to describe with two dts nodes. One for interrupt sources "0-=
31" and
> >>> +  the other for interrupt sources "32-63".
> >>>
> >>>  properties:
> >>>    compatible:
> >>> @@ -24,15 +24,9 @@ properties:
> >>>        - loongson,liointc-1.0a
> >>>        - loongson,liointc-2.0
> >>>
> >>> -  reg:
> >>> -    minItems: 1
> >>> -    minItems: 3
> >>> +  reg: true
> >>
> >> No. Constraints must be here.
> >
> > May I ask a question:
> > Since different compatibles require different minItems/minItems for
>
> You don't have this case here. I don't see any device asking for 4 regs.
>
> > the attribute, this writeup of defining the attribute to be true first
> > and then defining the specific value in an if-else statement is not
> > recommended?
>
> The top-level defines widest constraints and if:else: narrows them per
> each variant.
>
> ...
>
> >>> +        reg-names:
> >>> +          minItems: 2
> >>> +          items:
> >>> +            - const: main
> >>> +            - const: isr0
> >>> +            - const: isr1
> >>
> >> Srsly, why this is moved here from the top? It does not make sense.
> >
> > In liointc-2.0, we need to deal with two dts nodes, and the setting
> > and routing registers are not contiguous, so the driver needs
> > "reg-names" to get the corresponding register mapping. So I put all
> > this in the liointc-2.0 section.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/irqchip/irq-loongson-liointc.c?h=3Dv6.5-rc6#n225
>
> This is driver. You need to show the DTS, not driver.
>
> >
> >         if (revision > 1) {
> >                 for (i =3D 0; i < LIOINTC_NUM_CORES; i++) {
> >                         int index =3D of_property_match_string(node,
> >                                         "reg-names", core_reg_names[i])=
;
> >
> >                         if (index < 0)
> >                                 continue;
> >
> >                         priv->core_isr[i] =3D of_iomap(node, index);
> >                 }
> >
> >                 if (!priv->core_isr[0])
> >                         goto out_iounmap;
> >         }
> >
> >
> > I referenced other dt-binding writeups and thought this would be cleare=
r.
> >
> > Is this if-else style not recommended? Should I keep the v1 patch write=
up?
> > https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongso=
n.cn/
>
> if:else: is recommended, we do not discuss it. Your v1 was making
> everything totally loose, so incorrect. Explain - why the reg-names are
> not correct for the other variant? We expect just to have maxItems for
> the other variant... unless reg-names are not correct, then they can be
> made false - which you didn't.
>
This is mainly due to discontinuities in register definitions.

Interrupt routing configuration involves two aspects of registers (32 bits)=
:
1. interrupt configuration registers: including interrupt enable,
interrupt status, etc;
2. the CORE routing register: indicating which CORE to route to.

First of all, for liointc-1.0, e.g. Loongson-3A, they are contiguous
and we only need a set of register definitions, so reg-names are not
needed.

                liointc: interrupt-controller@3ff01400 {
                        compatible =3D "loongson,liointc-1.0";
                        reg =3D <0 0x3ff01400 0x64>;
...........
                };

However, for liointc-2.0, e.g. Loongson-2K1000, they are not
contiguous and we can only define them separately (main/isr0/isr1).

                liointc0: interrupt-controller@1fe11400 {
                        compatible =3D "loongson,liointc-2.0";
                        reg =3D <0 0x1fe11400 0 0x40>,
                                <0 0x1fe11040 0 0x8>,
                                <0 0x1fe11140 0 0x8>;
                        reg-names =3D "main", "isr0", "isr1";
..........
                };


Unfortunately, the Loongson-2K0500 is again special in that it is a
single-core CPU. therefore the core1 routing register (isr1) does not
exist.

                liointc0: interrupt-controller@1fe11400 {
                        compatible =3D "loongson,liointc-2.0";
                        reg =3D <0x0 0x1fe11400 0x0 0x40>,
                              <0x0 0x1fe11040 0x0 0x8>;
                        reg-names =3D "main", "isr0";
......
                };

So I would like to set the minItems of reg-names to 2 (main/isr0).

Thanks.
Binbin

>
> Best regards,
> Krzysztof
>
