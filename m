Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D52779CE1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjHLC72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjHLC70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:59:26 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575B30EB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:59:25 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1bbdddd3c94so2307685fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691809164; x=1692413964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My7+flDtowSpqC7h8M6tiJ9dx8GfV4dsSvBqrvte/EE=;
        b=kGF+1ZGltgPZW6fhi0+Wfd20feR5YBSKc7wSqJVtFekXPrBwCc6NYXQ1BAvade92g7
         7yuWgZRDANFrmjmesf6KzKDE3D+KI3SamfVaZEtb0tk5doAXjwwiSl2YOUE/21s09uaF
         FRRadYjGBptwKBIICcLf08igI+i8r7rEilnyEEq/Uj+0Vea+S9w++LZLMGLuNoVCxT0P
         Xv02QiyhzHZje+vydr0sUlvKClqFykeyETqHGwvp9QdPbaqVAjNWQSiWNgzNFjffxb+R
         xzyvvuSkHAEHUqkDI6t7Cl8uvvIgPtQqKEKicK2W8xjDLdopfpZR+rCUfTYg2SdgL+TK
         V74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691809164; x=1692413964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=My7+flDtowSpqC7h8M6tiJ9dx8GfV4dsSvBqrvte/EE=;
        b=CKnORZb0265Rmjeo8/psKltUhuIGSUpDW4uAB9EMl6lLgmhoK/HD8d4VN7JyghkII/
         Trzj8AD8adlcAyETrw0ZblZP+Vbh88gCs89TIYWXtGdy7DY0XGzuUwP5NYyUdXcuVFeH
         0KPhz0uRFoL4ZjTxAl0r196dwOIm93WThbY8kSxe3qZQtx1/coE1wAzHDAYVZys7AGtk
         1WVTc1Z5Q8OG3/Ftz8fk6BV9zoWFRM8AMSIE+ulq5mo1s/iLHUhwLCCclTjRjGKbXTwo
         NgM+sIN5Tu2GrR9xr05cmY28s6LmOgYvBk24BVzT0frMYpuBWL3J421SLw4uraqSgoat
         n5dA==
X-Gm-Message-State: AOJu0Yzs0HrNj0rQG6yH4+4WjeptwuFEhU1i5GACOagGtmnAdP5aBWkL
        BfqZQN8rD+VCdThih9gXmN1EWPAYqgmtcM7cdVRcsw==
X-Google-Smtp-Source: AGHT+IE3P6YJ6OE0W6qrCHXUE4K114ckPZbpV3v1t1QiQ3twaaf8TeTNc/jydYSQL+HxUoypo+RKcvwqxTWL0wtJHd4=
X-Received: by 2002:a05:6870:ac2b:b0:1b7:2edd:df6d with SMTP id
 kw43-20020a056870ac2b00b001b72edddf6dmr4347172oab.10.1691809164539; Fri, 11
 Aug 2023 19:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230802150018.327079-1-apatel@ventanamicro.com>
 <20230802150018.327079-12-apatel@ventanamicro.com> <CABvJ_xi5r-NL=22tJWfyQQSti4XgUwsx94B8mQ3LJU29kiQC8w@mail.gmail.com>
 <CAK9=C2UPfwJ+JccE+7zTcrqdOZ8np0UkL6P8n-Zofbj5NZ=WXQ@mail.gmail.com> <CABvJ_xiZY5RGMXOq0bWKRdkzD=b4ar6cFiujmPbUYmHUzSW5Qw@mail.gmail.com>
In-Reply-To: <CABvJ_xiZY5RGMXOq0bWKRdkzD=b4ar6cFiujmPbUYmHUzSW5Qw@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 12 Aug 2023 08:29:12 +0530
Message-ID: <CAK9=C2UxoSzboraCTtBfg9mx9iTQChhkrDuJcOOGFMgiWg9bBQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/15] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
To:     Vincent Chen <vincent.chen@sifive.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:59=E2=80=AFPM Vincent Chen <vincent.chen@sifive.c=
om> wrote:
>
>
>
> On Thu, Aug 10, 2023 at 4:08=E2=80=AFPM Anup Patel <apatel@ventanamicro.c=
om> wrote:
>>
>> On Thu, Aug 10, 2023 at 1:31=E2=80=AFPM Vincent Chen <vincent.chen@sifiv=
e.com> wrote:
>> >
>> >
>> >
>> > On Wed, Aug 2, 2023 at 11:02=E2=80=AFPM Anup Patel <apatel@ventanamicr=
o.com> wrote:
>> >>
>> >> We add DT bindings document for RISC-V advanced platform level interr=
upt
>> >> controller (APLIC) defined by the RISC-V advanced interrupt architect=
ure
>> >> (AIA) specification.
>> >>
>> >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> >> ---
>> >>  .../interrupt-controller/riscv,aplic.yaml     | 172 ++++++++++++++++=
++
>> >>  1 file changed, 172 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/interrupt-contr=
oller/riscv,aplic.yaml
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/interrupt-controller/r=
iscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/ri=
scv,aplic.yaml
>> >> new file mode 100644
>> >> index 000000000000..190a6499c932
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,ap=
lic.yaml
>> >> @@ -0,0 +1,172 @@
>> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.=
yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: RISC-V Advanced Platform Level Interrupt Controller (APLIC)
>> >> +
>> >> +maintainers:
>> >> +  - Anup Patel <anup@brainfault.org>
>> >> +
>> >> +description:
>> >> +  The RISC-V advanced interrupt architecture (AIA) defines an advanc=
ed
>> >> +  platform level interrupt controller (APLIC) for handling wired int=
errupts
>> >> +  in a RISC-V platform. The RISC-V AIA specification can be found at
>> >> +  https://github.com/riscv/riscv-aia.
>> >> +
>> >> +  The RISC-V APLIC is implemented as hierarchical APLIC domains wher=
e all
>> >> +  interrupt sources connect to the root APLIC domain and a parent AP=
LIC
>> >> +  domain can delegate interrupt sources to it's child APLIC domains.=
 There
>> >> +  is one device tree node for each APLIC domain.
>> >> +
>> >> +allOf:
>> >> +  - $ref: /schemas/interrupt-controller.yaml#
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    items:
>> >> +      - enum:
>> >> +          - qemu,aplic
>> >> +      - const: riscv,aplic
>> >> +
>> >> +  reg:
>> >> +    maxItems: 1
>> >> +
>> >> +  interrupt-controller: true
>> >> +
>> >> +  "#interrupt-cells":
>> >> +    const: 2
>> >> +
>> >> +  interrupts-extended:
>> >> +    minItems: 1
>> >> +    maxItems: 16384
>> >> +    description:
>> >> +      Given APLIC domain directly injects external interrupts to a s=
et of
>> >> +      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv=
,cpu-intc
>> >> +      node, which has a CPU node (i.e. RISC-V HART) as parent.
>> >> +
>> >> +  msi-parent:
>> >> +    description:
>> >> +      Given APLIC domain forwards wired interrupts as MSIs to a AIA =
incoming
>> >> +      message signaled interrupt controller (IMSIC). If both "msi-pa=
rent" and
>> >> +      "interrupts-extended" properties are present then it means the=
 APLIC
>> >> +      domain supports both MSI mode and Direct mode in HW. In this c=
ase, the
>> >> +      APLIC driver has to choose between MSI mode or Direct mode.
>> >> +
>> >> +  riscv,num-sources:
>> >> +    $ref: /schemas/types.yaml#/definitions/uint32
>> >> +    minimum: 1
>> >> +    maximum: 1023
>> >> +    description:
>> >> +      Specifies the number of wired interrupt sources supported by t=
his
>> >> +      APLIC domain.
>> >> +
>> >> +  riscv,children:
>> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> >> +    minItems: 1
>> >> +    maxItems: 1024
>> >> +    items:
>> >> +      maxItems: 1
>> >> +    description:
>> >> +      A list of child APLIC domains for the given APLIC domain. Each=
 child
>> >> +      APLIC domain is assigned a child index in increasing order, wi=
th the
>> >> +      first child APLIC domain assigned child index 0. The APLIC dom=
ain child
>> >> +      index is used by firmware to delegate interrupts from the give=
n APLIC
>> >> +      domain to a particular child APLIC domain.
>> >> +
>> >> +  riscv,delegation:
>> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> >> +    minItems: 1
>> >> +    maxItems: 1024
>> >> +    items:
>> >> +      items:
>> >> +        - description: child APLIC domain phandle
>> >> +        - description: first interrupt number of the parent APLIC do=
main (inclusive)
>> >> +        - description: last interrupt number of the parent APLIC dom=
ain (inclusive)
>> >> +    description:
>> >> +      A interrupt delegation list where each entry is a triple consi=
sting
>> >> +      of child APLIC domain phandle, first interrupt number of the p=
arent
>> >> +      APLIC domain, and last interrupt number of the parent APLIC do=
main.
>> >> +      Firmware must configure interrupt delegation registers based o=
n
>> >> +      interrupt delegation list.
>> >> +
>> >> +dependencies:
>> >> +  riscv,delegation: [ "riscv,children" ]
>> >> +
>> >> +required:
>> >> +  - compatible
>> >> +  - reg
>> >> +  - interrupt-controller
>> >> +  - "#interrupt-cells"
>> >> +  - riscv,num-sources
>> >> +
>> >> +anyOf:
>> >> +  - required:
>> >> +      - interrupts-extended
>> >> +  - required:
>> >> +      - msi-parent
>> >> +
>> >> +unevaluatedProperties: false
>> >> +
>> >> +examples:
>> >> +  - |
>> >> +    // Example 1 (APLIC domains directly injecting interrupt to HART=
s):
>> >> +
>> >> +    interrupt-controller@c000000 {
>> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
>> >> +      interrupts-extended =3D <&cpu1_intc 11>,
>> >> +                            <&cpu2_intc 11>,
>> >> +                            <&cpu3_intc 11>,
>> >> +                            <&cpu4_intc 11>;
>> >> +      reg =3D <0xc000000 0x4080>;
>> >> +      interrupt-controller;
>> >> +      #interrupt-cells =3D <2>;
>> >> +      riscv,num-sources =3D <63>;
>> >> +      riscv,children =3D <&aplic1>, <&aplic2>;
>> >> +      riscv,delegation =3D <&aplic1 1 63>;
>> >> +    };
>> >> +
>> >> +    aplic1: interrupt-controller@d000000 {
>> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
>> >> +      interrupts-extended =3D <&cpu1_intc 9>,
>> >> +                            <&cpu2_intc 9>;
>> >> +      reg =3D <0xd000000 0x4080>;
>> >> +      interrupt-controller;
>> >> +      #interrupt-cells =3D <2>;
>> >> +      riscv,num-sources =3D <63>;
>> >> +    };
>> >> +
>> >> +    aplic2: interrupt-controller@e000000 {
>> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
>> >> +      interrupts-extended =3D <&cpu3_intc 9>,
>> >> +                            <&cpu4_intc 9>;
>> >> +      reg =3D <0xe000000 0x4080>;
>> >> +      interrupt-controller;
>> >> +      #interrupt-cells =3D <2>;
>> >> +      riscv,num-sources =3D <63>;
>> >> +    };
>> >> +
>> >
>> >
>> > Hi Anup,
>> > I have some thoughts regarding the APLIC DTS node. While I understand =
that it might be a bit late to discuss this matter within the v7 patch (sor=
ry for this), I hope you could still consider the following idea.
>> >
>> > For example 1, my understanding is that each APLIC DTS node represents=
 an interrupt domain. IIUC, in physical, these tree Interrupt domains shoul=
d belong to an APLIC device so the M-mode IRQ domain can delegate interrupt=
s to the child domain. Given this perspective, wrapping all interrupt domai=
n DTS nodes with another DTS node seems to present the real scene more clea=
rly. Maybe we can add "simple-bus" to the compatible property of this wrapp=
ed DTS node, so it still can be compatible with your driver implementations=
. Therefore, example 1 may become the following.
>> >
>> > interrupt-controller {
>> >         compatible =3D "riscv,aplics", "simple-bus";
>> >         ranges;
>> >         aplic0: interrupt-domain@c000000 {
>> >                 compatible =3D "qemu,aplic", "riscv,aplic";
>> >                 interrupts-extended =3D <&cpu1_intc 11>,
>> >                                       <&cpu2_intc 11>,
>> >                                       <&cpu3_intc 11>,
>> >                                       <&cpu4_intc 11>;
>> >                 reg =3D <0xc000000 0x4080>;
>> >                 interrupt-controller;
>> >                 #interrupt-cells =3D <2>;
>> >                 riscv,num-sources =3D <63>;
>> >                 riscv,children =3D <&aplic1>, <&aplic2>;
>> >                 riscv,delegation =3D <&aplic1 1 63>;
>> >         };
>> >
>> >         aplic1: interrupt-domain@d000000 {
>> >                 compatible =3D "qemu,aplic", "riscv,aplic";
>> >                 interrupts-extended =3D <&cpu1_intc 9>,
>> >                                       <&cpu2_intc 9>;
>> >                 reg =3D <0xd000000 0x4080>;
>> >                 interrupt-controller;
>> >                 #interrupt-cells =3D <2>;
>> >                 riscv,num-sources =3D <63>;
>> >         };
>> >
>> >         aplic2: interrupt-domain@e000000 {
>> >                 compatible =3D "qemu,aplic", "riscv,aplic";
>> >                 interrupts-extended =3D <&cpu3_intc 9>,
>> >                                       <&cpu4_intc 9>;
>> >                 reg =3D <0xe000000 0x4080>;
>> >                 interrupt-controller;
>> >                 #interrupt-cells =3D <2>;
>> >                 riscv,num-sources =3D <63>;
>> >         };
>> > };
>> > Is it feasible for you?
>>
>> This clubbing of APLIC domains and placing them close to each
>> other is a platform implementation choice. On multi-die or multi-socket
>> systems the APIC domains can be really far apart on different physical
>> dies so the clubbing you suggest is not always true.
>>
>> Regards,
>> Anup
>>
> IIUC, I think my suggestion might be able to apply to this scenario if th=
ese interrupt domains belong to the same APLIC device. For this scenario, o=
ne thing I am concerned about is that the MMIO region of other devices loca=
tes between interrupt domains. However, currently, I have not found that th=
e DTS specification explicitly prohibits it. Do you have the same concern?

One APLIC device implementing multiple APLIC domains is perfectly fine
and there is nothing in this DT bindings which prevents that.

We can always group multiple APLIC domain DT nodes under another DT
node but we don't need any special DT bindings for such grouping and
the APLIC driver does not need to be aware of this grouping. Further,
the AIA spec does not mandate grouping of APLIC domains under one
APLIC device.

Like I said previously, the grouping of APLIC domains under one DT
node is implementation/platform specific.

Regards,
Anup

>
> Thanks,
> Vincent
>>
>> >
>> > Thanks,
>> > Vincent
>> >
>> >>
>> >> +  - |
>> >> +    // Example 2 (APLIC domains forwarding interrupts as MSIs):
>> >> +
>> >> +    interrupt-controller@c000000 {
>> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
>> >> +      msi-parent =3D <&imsic_mlevel>;
>> >> +      reg =3D <0xc000000 0x4000>;
>> >> +      interrupt-controller;
>> >> +      #interrupt-cells =3D <2>;
>> >> +      riscv,num-sources =3D <63>;
>> >> +      riscv,children =3D <&aplic3>;
>> >> +      riscv,delegation =3D <&aplic3 1 63>;
>> >> +    };
>> >> +
>> >> +    aplic3: interrupt-controller@d000000 {
>> >> +      compatible =3D "qemu,aplic", "riscv,aplic";
>> >> +      msi-parent =3D <&imsic_slevel>;
>> >> +      reg =3D <0xd000000 0x4000>;
>> >> +      interrupt-controller;
>> >> +      #interrupt-cells =3D <2>;
>> >> +      riscv,num-sources =3D <63>;
>> >> +    };
>> >> +...
>> >> --
>> >> 2.34.1
>> >>
>> >>
>> >> _______________________________________________
>> >> linux-riscv mailing list
>> >> linux-riscv@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
