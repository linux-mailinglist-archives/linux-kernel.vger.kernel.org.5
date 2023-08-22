Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8627838E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 06:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjHVEpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 00:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjHVEpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 00:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72CE18B;
        Mon, 21 Aug 2023 21:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F1D463434;
        Tue, 22 Aug 2023 04:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A105CC433CA;
        Tue, 22 Aug 2023 04:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692679500;
        bh=yokCOAF46NkeXnzKzrkQWrUvo6uovD+L/nrinsM5GDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J3AGPuuzsU5xfxgGD0xeMXAlwtNdVrpFfG7ZMGJa8L9qwftiMLSNKnzFQSVkw8lmj
         /si9woX67hd97yLzt0m9i9ZjiIUWsyANaxTERK4xKK3Q8KNqpqoY4ZYCNyccYZBREL
         McVnpTVx3qwzNAxGAI9qZwkKHkwEXhBcnNRgduB/g7cRN2h3agD0J5Rik1q4fq+eSj
         AodcwiCKwhYbxE5NWRkPBsIf6ComhmA+3p+7AS1VHFlT2VXTDNjR4yVDY6paolyy7C
         CmA3z/o4QV6Q34S+oTnlqt9i/xHF+DIg5CLgdqGRIIGNnA+80SoXtnUZPrH39jdwnQ
         wEa3GJRM1OgCw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9a18a4136a9so278819166b.2;
        Mon, 21 Aug 2023 21:45:00 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy7ILn39UAFijGXVKGqUaROB8fSXxhtjCdleKfLPSWJsFjdsAOe
        uuGywWFVrY3m4SiKRq/TGkQ1/1VLKyq9qMFlg24=
X-Google-Smtp-Source: AGHT+IHxrXK8Uj/TaMDUDhOIN7KBjt+OV9ngc6YJG/wIHinia3KIX6pSFc0u9/62N945j9OjUXam6FhWhcCmwBijRu0=
X-Received: by 2002:a17:906:2215:b0:99b:d599:5085 with SMTP id
 s21-20020a170906221500b0099bd5995085mr6461631ejs.64.1692679498790; Mon, 21
 Aug 2023 21:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
In-Reply-To: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 22 Aug 2023 12:44:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5JpHwgcq7mPBOcAwy638VAQvNc2rkRNyWnBZ4sVdq8XQ@mail.gmail.com>
Message-ID: <CAAhV-H5JpHwgcq7mPBOcAwy638VAQvNc2rkRNyWnBZ4sVdq8XQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Mon, Aug 21, 2023 at 2:13=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Since commit f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add
> Loongson-2K1000 LIOINTC"), the loongson liointc supports configuring
> routes for 64-bit interrupt sources.
>
> For liointc-2.0, we need to define two liointc nodes in dts, one for
> "0-31" interrupt sources and the other for "32-63" interrupt sources.
> This applies to mips Loongson-2K1000.
>
> Unfortunately, there are some warnings about "loongson,liointc-2.0":
> 1. "interrupt-names" should be "required", the driver gets the parent
> interrupts through it.
>
> 2. Since not all CPUs are multicore, e.g. Loongson-2K0500 is a
> single-core CPU, there is no core1-related registers. So "reg" and
> "reg-names" should be set to "minItems 2".
>
> 3. Routing interrupts from "int0" is a common solution in practice, but
> theoretically there is no such requirement, as long as conflicts are
> avoided. So "interrupt-names" should be defined by "pattern".
>
> This fixes dtbs_check warning:
>
> DTC_CHK arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb
> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-contro=
ller@1fe11440: interrupt-names:0: 'int0' was expected
>       From schema: Documentation/devicetree/bindings/interrupt-controller=
/loongson,liointc.yaml
> arch/mips/boot/dts/loongson/loongson64_2core_2k1000.dtb: interrupt-contro=
ller@1fe11440: Unevaluated properties are not allowed ('interrupt-names' wa=
s unexpected)
>       From schema: Documentation/devicetree/bindings/interrupt-controller=
/loongson,liointc.yaml
>
> Fixes: f4dee5d8e1fa ("dt-bindings: interrupt-controller: Add Loongson-2K1=
000 LIOINTC")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
> V2:
> 1. Update commit message;
> 2. "interruprt-names" should be "required", the driver gets the parent
> interrupts through it;
> 3. Add more descriptions to explain the rationale for multiple nodes;
> 4. Rewrite if-else statements.
>
> Link to V1:
> https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongson.=
cn/
>
>  .../loongson,liointc.yaml                     | 74 +++++++++----------
>  1 file changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loong=
son,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/l=
oongson,liointc.yaml
> index 00b570c82903..f695d3a75ddf 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,lio=
intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,lio=
intc.yaml
> @@ -11,11 +11,11 @@ maintainers:
>
>  description: |
>    This interrupt controller is found in the Loongson-3 family of chips a=
nd
> -  Loongson-2K1000 chip, as the primary package interrupt controller whic=
h
> +  Loongson-2K series chips, as the primary package interrupt controller =
which
>    can route local I/O interrupt to interrupt lines of cores.
> -
> -allOf:
> -  - $ref: /schemas/interrupt-controller.yaml#
> +  In particular, the Loongson-2K1000/2K0500 has 64 interrupt sources tha=
t we
> +  need to describe with two dts nodes. One for interrupt sources "0-31" =
and
> +  the other for interrupt sources "32-63".
>
>  properties:
>    compatible:
> @@ -24,15 +24,9 @@ properties:
>        - loongson,liointc-1.0a
>        - loongson,liointc-2.0
>
> -  reg:
> -    minItems: 1
> -    maxItems: 3
> +  reg: true
>
> -  reg-names:
> -    items:
> -      - const: main
> -      - const: isr0
> -      - const: isr1
> +  reg-names: true
>
>    interrupt-controller: true
>
> @@ -45,11 +39,9 @@ properties:
>    interrupt-names:
>      description: List of names for the parent interrupts.
>      items:
> -      - const: int0
> -      - const: int1
> -      - const: int2
> -      - const: int3
> +      pattern: int[0-3]
>      minItems: 1
> +    maxItems: 4
>
>    '#interrupt-cells':
>      const: 2
> @@ -69,32 +61,41 @@ required:
>    - compatible
>    - reg
>    - interrupts
> +  - interrupt-names
>    - interrupt-controller
>    - '#interrupt-cells'
>    - loongson,parent_int_map
>
> -
>  unevaluatedProperties: false
>
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - loongson,liointc-2.0
> -
> -then:
> -  properties:
> -    reg:
> -      minItems: 3
> -
> -  required:
> -    - reg-names
> -
> -else:
> -  properties:
> -    reg:
> -      maxItems: 1
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - loongson,liointc-2.0
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          items:
> +            - description: Interrupt routing registers.
> +            - description: Low/high 32-bit interrupt status routed to co=
re0.
> +            - description: Low/high 32-bit interrupt status routed to co=
re1.
> +        reg-names:
> +          minItems: 2
> +          items:
> +            - const: main
> +            - const: isr0
> +            - const: isr1
> +      required:
> +        - reg-names
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
>
>  examples:
>    - |
> @@ -113,7 +114,6 @@ examples:
>                                  <0x0f000000>, /* int1 */
>                                  <0x00000000>, /* int2 */
>                                  <0x00000000>; /* int3 */
> -
>      };
>
>  ...
> --
> 2.39.3
>
