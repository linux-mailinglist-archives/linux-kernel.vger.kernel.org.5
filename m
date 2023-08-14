Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E95777B1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjHNGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjHNGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:44:11 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D3E5D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:44:08 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48719e50231so2651128e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691995447; x=1692600247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/77JVQ6SRauXOW8b0KyMolSxYaNuLZkMQtli22d1Tk=;
        b=lOf/R5gG9ICXR5lHM0CHhvn74rBfCH3VtPDp1UDu8zT/i83ZbdnIjeB21MhFvJZwnZ
         Ep7GKqhxCjWZYJ/JVILibu/Z4tePMuhvC+EiU6LLBAcYmQ1qU4xPUIjNMopFUl+R235T
         WLq0dE2x1zZwEGdiCbjlprH8LvFza/C1tMJjvTX16mFCUnWMP4j5Ii8DbtGYxPAsW+6P
         yc2nAHOAEhyqu0FaF9gDC3FqRkRHK2CajbzMngC2C2GMGV9r4LRFG3y/iRg0yQ+80z2i
         ChriRLjOdRBCbgk1cs9TLo5LsA9IgkTQpRUkTK5jUFAnLl7SHhz5qHI1EFz9vtu6W5Tl
         wd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691995447; x=1692600247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/77JVQ6SRauXOW8b0KyMolSxYaNuLZkMQtli22d1Tk=;
        b=jxWcRjj1y2Zdyrwp/ylaZP5eJ+rqXHjpOKx8r/b39jTYVOYtQmG8R/VMbC9eRBNcCz
         gITNuH0CWUeVo4ab9tOsERrE+QZSFhLp2o3vcsryd56gcDdVIyWy7jZvMAE0R0QIzNkD
         KDbXXM5pWR9ITWU9DswkY+Rgf76Qbg8V3/6baojXZTR6lVAAm2xakCCXHwMgYZRyJfOi
         8LBpjJT8YFDjHiMav6JfPyLMY+3sk/3Xdu6wMojuVRW2AeOWKstIU9OTW01UWUEulRxH
         V9t9KuW9MmboT2sbCRAxMsweF1UKMZ322cs3oRZY+6ft2iPECsp8tSMTAwyvUW2hGJl5
         YPuA==
X-Gm-Message-State: AOJu0Yxy171aYN6Q3tBXDqBLlnaorpg5whygUzmZpLrumauyKvJNUCBt
        /8b1gz/N7IHkOwcOXVeE+6qanRHs4ps3zkhA8EEV6Q==
X-Google-Smtp-Source: AGHT+IGeZFw3yvN/ZZzQgYId/1HBbjRESIc+LROa0JgK9oRZxou7d68elsACR+EYY5dFLyvR5XbouQg1uPDX91KBIVc=
X-Received: by 2002:a1f:a7cc:0:b0:487:d927:38f0 with SMTP id
 q195-20020a1fa7cc000000b00487d92738f0mr4764608vke.5.1691995447315; Sun, 13
 Aug 2023 23:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230802150018.327079-1-apatel@ventanamicro.com>
 <20230802150018.327079-12-apatel@ventanamicro.com> <CABvJ_xi5r-NL=22tJWfyQQSti4XgUwsx94B8mQ3LJU29kiQC8w@mail.gmail.com>
 <CAK9=C2UPfwJ+JccE+7zTcrqdOZ8np0UkL6P8n-Zofbj5NZ=WXQ@mail.gmail.com>
 <CABvJ_xiZY5RGMXOq0bWKRdkzD=b4ar6cFiujmPbUYmHUzSW5Qw@mail.gmail.com> <CAK9=C2UxoSzboraCTtBfg9mx9iTQChhkrDuJcOOGFMgiWg9bBQ@mail.gmail.com>
In-Reply-To: <CAK9=C2UxoSzboraCTtBfg9mx9iTQChhkrDuJcOOGFMgiWg9bBQ@mail.gmail.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Mon, 14 Aug 2023 14:43:56 +0800
Message-ID: <CABvJ_xi3e5nCHOFvCQ=W48BbM5780pmB0auR3yLLiCH4hC0mRA@mail.gmail.com>
Subject: Re: [PATCH v7 11/15] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 10:59=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> On Thu, Aug 10, 2023 at 4:59=E2=80=AFPM Vincent Chen <vincent.chen@sifive=
.com> wrote:
> >
> >
> >
> > On Thu, Aug 10, 2023 at 4:08=E2=80=AFPM Anup Patel <apatel@ventanamicro=
.com> wrote:
> >>
> >> On Thu, Aug 10, 2023 at 1:31=E2=80=AFPM Vincent Chen <vincent.chen@sif=
ive.com> wrote:
> >> >
> >> >
> >> >
> >> > On Wed, Aug 2, 2023 at 11:02=E2=80=AFPM Anup Patel <apatel@ventanami=
cro.com> wrote:
> >> >>
> >> >> We add DT bindings document for RISC-V advanced platform level inte=
rrupt
> >> >> controller (APLIC) defined by the RISC-V advanced interrupt archite=
cture
> >> >> (AIA) specification.
> >> >>
> >> >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >> >> ---
> >> >>  .../interrupt-controller/riscv,aplic.yaml     | 172 ++++++++++++++=
++++
> >> >>  1 file changed, 172 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/interrupt-con=
troller/riscv,aplic.yaml
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/interrupt-controller=
/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
riscv,aplic.yaml
> >> >> new file mode 100644
> >> >> index 000000000000..190a6499c932
> >> >> --- /dev/null
> >> >> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,=
aplic.yaml
> >> >> @@ -0,0 +1,172 @@
> >> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> >> +%YAML 1.2
> >> >> +---
> >> >> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,apli=
c.yaml#
> >> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> >> +
> >> >> +title: RISC-V Advanced Platform Level Interrupt Controller (APLIC)
> >> >> +
> >> >> +maintainers:
> >> >> +  - Anup Patel <anup@brainfault.org>
> >> >> +
> >> >> +description:
> >> >> +  The RISC-V advanced interrupt architecture (AIA) defines an adva=
nced
> >> >> +  platform level interrupt controller (APLIC) for handling wired i=
nterrupts
> >> >> +  in a RISC-V platform. The RISC-V AIA specification can be found =
at
> >> >> +  https://github.com/riscv/riscv-aia.
> >> >> +
> >> >> +  The RISC-V APLIC is implemented as hierarchical APLIC domains wh=
ere all
> >> >> +  interrupt sources connect to the root APLIC domain and a parent =
APLIC
> >> >> +  domain can delegate interrupt sources to it's child APLIC domain=
s. There
> >> >> +  is one device tree node for each APLIC domain.
> >> >> +
> >> >> +allOf:
> >> >> +  - $ref: /schemas/interrupt-controller.yaml#
> >> >> +
> >> >> +properties:
> >> >> +  compatible:
> >> >> +    items:
> >> >> +      - enum:
> >> >> +          - qemu,aplic
> >> >> +      - const: riscv,aplic
> >> >> +
> >> >> +  reg:
> >> >> +    maxItems: 1
> >> >> +
> >> >> +  interrupt-controller: true
> >> >> +
> >> >> +  "#interrupt-cells":
> >> >> +    const: 2
> >> >> +
> >> >> +  interrupts-extended:
> >> >> +    minItems: 1
> >> >> +    maxItems: 16384
> >> >> +    description:
> >> >> +      Given APLIC domain directly injects external interrupts to a=
 set of
> >> >> +      RISC-V HARTS (or CPUs). Each node pointed to should be a ris=
cv,cpu-intc
> >> >> +      node, which has a CPU node (i.e. RISC-V HART) as parent.
> >> >> +
> >> >> +  msi-parent:
> >> >> +    description:
> >> >> +      Given APLIC domain forwards wired interrupts as MSIs to a AI=
A incoming
> >> >> +      message signaled interrupt controller (IMSIC). If both "msi-=
parent" and
> >> >> +      "interrupts-extended" properties are present then it means t=
he APLIC
> >> >> +      domain supports both MSI mode and Direct mode in HW. In this=
 case, the
> >> >> +      APLIC driver has to choose between MSI mode or Direct mode.
> >> >> +
> >> >> +  riscv,num-sources:
> >> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> >> +    minimum: 1
> >> >> +    maximum: 1023
> >> >> +    description:
> >> >> +      Specifies the number of wired interrupt sources supported by=
 this
> >> >> +      APLIC domain.
> >> >> +
> >> >> +  riscv,children:
> >> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> >> +    minItems: 1
> >> >> +    maxItems: 1024
> >> >> +    items:
> >> >> +      maxItems: 1
> >> >> +    description:
> >> >> +      A list of child APLIC domains for the given APLIC domain. Ea=
ch child
> >> >> +      APLIC domain is assigned a child index in increasing order, =
with the
> >> >> +      first child APLIC domain assigned child index 0. The APLIC d=
omain child
> >> >> +      index is used by firmware to delegate interrupts from the gi=
ven APLIC
> >> >> +      domain to a particular child APLIC domain.
> >> >> +
> >> >> +  riscv,delegation:
> >> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> >> +    minItems: 1
> >> >> +    maxItems: 1024
> >> >> +    items:
> >> >> +      items:
> >> >> +        - description: child APLIC domain phandle
> >> >> +        - description: first interrupt number of the parent APLIC =
domain (inclusive)
> >> >> +        - description: last interrupt number of the parent APLIC d=
omain (inclusive)
> >> >> +    description:
> >> >> +      A interrupt delegation list where each entry is a triple con=
sisting
> >> >> +      of child APLIC domain phandle, first interrupt number of the=
 parent
> >> >> +      APLIC domain, and last interrupt number of the parent APLIC =
domain.
> >> >> +      Firmware must configure interrupt delegation registers based=
 on
> >> >> +      interrupt delegation list.
> >> >> +
> >> >> +dependencies:
> >> >> +  riscv,delegation: [ "riscv,children" ]
> >> >> +
> >> >> +required:
> >> >> +  - compatible
> >> >> +  - reg
> >> >> +  - interrupt-controller
> >> >> +  - "#interrupt-cells"
> >> >> +  - riscv,num-sources
> >> >> +
> >> >> +anyOf:
> >> >> +  - required:
> >> >> +      - interrupts-extended
> >> >> +  - required:
> >> >> +      - msi-parent
> >> >> +
> >> >> +unevaluatedProperties: false
> >> >> +
> >> >> +examples:
> >> >> +  - |
> >> >> +    // Example 1 (APLIC domains directly injecting interrupt to HA=
RTs):
> >> >> +
> >> >> +    interrupt-controller@c000000 {
> >> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
> >> >> +      interrupts-extended =3D <&cpu1_intc 11>,
> >> >> +                            <&cpu2_intc 11>,
> >> >> +                            <&cpu3_intc 11>,
> >> >> +                            <&cpu4_intc 11>;
> >> >> +      reg =3D <0xc000000 0x4080>;
> >> >> +      interrupt-controller;
> >> >> +      #interrupt-cells =3D <2>;
> >> >> +      riscv,num-sources =3D <63>;
> >> >> +      riscv,children =3D <&aplic1>, <&aplic2>;
> >> >> +      riscv,delegation =3D <&aplic1 1 63>;
> >> >> +    };
> >> >> +
> >> >> +    aplic1: interrupt-controller@d000000 {
> >> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
> >> >> +      interrupts-extended =3D <&cpu1_intc 9>,
> >> >> +                            <&cpu2_intc 9>;
> >> >> +      reg =3D <0xd000000 0x4080>;
> >> >> +      interrupt-controller;
> >> >> +      #interrupt-cells =3D <2>;
> >> >> +      riscv,num-sources =3D <63>;
> >> >> +    };
> >> >> +
> >> >> +    aplic2: interrupt-controller@e000000 {
> >> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
> >> >> +      interrupts-extended =3D <&cpu3_intc 9>,
> >> >> +                            <&cpu4_intc 9>;
> >> >> +      reg =3D <0xe000000 0x4080>;
> >> >> +      interrupt-controller;
> >> >> +      #interrupt-cells =3D <2>;
> >> >> +      riscv,num-sources =3D <63>;
> >> >> +    };
> >> >> +
> >> >
> >> >
> >> > Hi Anup,
> >> > I have some thoughts regarding the APLIC DTS node. While I understan=
d that it might be a bit late to discuss this matter within the v7 patch (s=
orry for this), I hope you could still consider the following idea.
> >> >
> >> > For example 1, my understanding is that each APLIC DTS node represen=
ts an interrupt domain. IIUC, in physical, these tree Interrupt domains sho=
uld belong to an APLIC device so the M-mode IRQ domain can delegate interru=
pts to the child domain. Given this perspective, wrapping all interrupt dom=
ain DTS nodes with another DTS node seems to present the real scene more cl=
early. Maybe we can add "simple-bus" to the compatible property of this wra=
pped DTS node, so it still can be compatible with your driver implementatio=
ns. Therefore, example 1 may become the following.
> >> >
> >> > interrupt-controller {
> >> >         compatible =3D "riscv,aplics", "simple-bus";
> >> >         ranges;
> >> >         aplic0: interrupt-domain@c000000 {
> >> >                 compatible =3D "qemu,aplic", "riscv,aplic";
> >> >                 interrupts-extended =3D <&cpu1_intc 11>,
> >> >                                       <&cpu2_intc 11>,
> >> >                                       <&cpu3_intc 11>,
> >> >                                       <&cpu4_intc 11>;
> >> >                 reg =3D <0xc000000 0x4080>;
> >> >                 interrupt-controller;
> >> >                 #interrupt-cells =3D <2>;
> >> >                 riscv,num-sources =3D <63>;
> >> >                 riscv,children =3D <&aplic1>, <&aplic2>;
> >> >                 riscv,delegation =3D <&aplic1 1 63>;
> >> >         };
> >> >
> >> >         aplic1: interrupt-domain@d000000 {
> >> >                 compatible =3D "qemu,aplic", "riscv,aplic";
> >> >                 interrupts-extended =3D <&cpu1_intc 9>,
> >> >                                       <&cpu2_intc 9>;
> >> >                 reg =3D <0xd000000 0x4080>;
> >> >                 interrupt-controller;
> >> >                 #interrupt-cells =3D <2>;
> >> >                 riscv,num-sources =3D <63>;
> >> >         };
> >> >
> >> >         aplic2: interrupt-domain@e000000 {
> >> >                 compatible =3D "qemu,aplic", "riscv,aplic";
> >> >                 interrupts-extended =3D <&cpu3_intc 9>,
> >> >                                       <&cpu4_intc 9>;
> >> >                 reg =3D <0xe000000 0x4080>;
> >> >                 interrupt-controller;
> >> >                 #interrupt-cells =3D <2>;
> >> >                 riscv,num-sources =3D <63>;
> >> >         };
> >> > };
> >> > Is it feasible for you?
> >>
> >> This clubbing of APLIC domains and placing them close to each
> >> other is a platform implementation choice. On multi-die or multi-socke=
t
> >> systems the APIC domains can be really far apart on different physical
> >> dies so the clubbing you suggest is not always true.
> >>
> >> Regards,
> >> Anup
> >>
> > IIUC, I think my suggestion might be able to apply to this scenario if =
these interrupt domains belong to the same APLIC device. For this scenario,=
 one thing I am concerned about is that the MMIO region of other devices lo=
cates between interrupt domains. However, currently, I have not found that =
the DTS specification explicitly prohibits it. Do you have the same concern=
?
>
> One APLIC device implementing multiple APLIC domains is perfectly fine
> and there is nothing in this DT bindings which prevents that.
>
> We can always group multiple APLIC domain DT nodes under another DT
> node but we don't need any special DT bindings for such grouping and
> the APLIC driver does not need to be aware of this grouping. Further,
> the AIA spec does not mandate grouping of APLIC domains under one
> APLIC device.
>
> Like I said previously, the grouping of APLIC domains under one DT
> node is implementation/platform specific.
>

I understood. Thanks for your reply.

Thanks,
Vincent

> Regards,
> Anup
>
> >
> > Thanks,
> > Vincent
> >>
> >> >
> >> > Thanks,
> >> > Vincent
> >> >
> >> >>
> >> >> +  - |
> >> >> +    // Example 2 (APLIC domains forwarding interrupts as MSIs):
> >> >> +
> >> >> +    interrupt-controller@c000000 {
> >> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
> >> >> +      msi-parent =3D <&imsic_mlevel>;
> >> >> +      reg =3D <0xc000000 0x4000>;
> >> >> +      interrupt-controller;
> >> >> +      #interrupt-cells =3D <2>;
> >> >> +      riscv,num-sources =3D <63>;
> >> >> +      riscv,children =3D <&aplic3>;
> >> >> +      riscv,delegation =3D <&aplic3 1 63>;
> >> >> +    };
> >> >> +
> >> >> +    aplic3: interrupt-controller@d000000 {
> >> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
> >> >> +      msi-parent =3D <&imsic_slevel>;
> >> >> +      reg =3D <0xd000000 0x4000>;
> >> >> +      interrupt-controller;
> >> >> +      #interrupt-cells =3D <2>;
> >> >> +      riscv,num-sources =3D <63>;
> >> >> +    };
> >> >> +...
> >> >> --
> >> >> 2.34.1
> >> >>
> >> >>
> >> >> _______________________________________________
> >> >> linux-riscv mailing list
> >> >> linux-riscv@lists.infradead.org
> >> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
