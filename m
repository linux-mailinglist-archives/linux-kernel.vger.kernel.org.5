Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59747D4FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjJXMa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJXMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:30:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B83510D0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:30:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40806e40fccso32445365e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698150649; x=1698755449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mdCVirhLaj7utc9tDrYryE3Zvt1KPzYcMEaRPGjcb8=;
        b=DPCkYO2Ig/sEThYI6WdcwgbZ0Y0NexD2gknXZySl/Atd/7tS8lIuoqGsvb0ew8RICb
         IAh2JmL5+UqoN3vH6J3gJ+gvXASEIOF0JQ8QCMVzA6C+HON/L2eyc0jUpvalxNt/6+10
         NWniCuQanQB1IpgHXvBje2EJV3ErYE1au9qtpoUgZWnn1yIN0HX9AQcbUkxtJ19H3Hsq
         1+qAoOAKu0EWs5/axhAVh3lgLWfFaNM4QGAJQJNXciSxeYDg5fg9SMeoWznwmjEGV0fH
         uL4coO7GhvbsQv4W0Ub8orSoU1w6ap9oQ1stDSVCLgZ4CqtxFz4s2udRKhnvqus8Wxgy
         TtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150649; x=1698755449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mdCVirhLaj7utc9tDrYryE3Zvt1KPzYcMEaRPGjcb8=;
        b=T6Pb8XuTsqumgdTITg3jxfhRgawrjUJbXFBV30ikRHlA2Qd5+013ZTG76xGvWsqFBv
         SYMwej/B6WhRaPNgWzdQpxqbKz7Sn0LMYILOMSEcZO8qjjpzkA1C+2a5fT0NMYXfoSjp
         dBszTcVNz/DP0Vyrg20uIgQOWxcVXnCzqOHva4BkdvKHheeoAjDEALT/tO4sqSuytdD4
         vDobuZH+3aWuycN3mmmmGLcJyBlGgO6T7vNNQ8QSudvuNQD7hdETJBbz3TodfEwGPDP6
         U8O3RmsE4KrikAFKGltqYgXfG+KtxZLUpIRXjS4Dg8L5VG64w5ONm7MPXl5nqU6HvCLg
         x0Lg==
X-Gm-Message-State: AOJu0YzBxw6kwgrGAtnhaFBN8m3+GHQEfQqqyZ6HKAfTgG1cS1kYz13H
        2jOfiH1sMCuab6+thhUHQpMpGw==
X-Google-Smtp-Source: AGHT+IFnp+At+nxS2NnS+eEjoLejQO3kWO0TDUDuNNURJgUw7rE9TgEpE45LgJMcSSxtfNwvla80Ew==
X-Received: by 2002:a05:600c:3583:b0:408:4095:6f0c with SMTP id p3-20020a05600c358300b0040840956f0cmr10012487wmq.38.1698150648998;
        Tue, 24 Oct 2023 05:30:48 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600c3d0900b003feae747ff2sm16869390wmb.35.2023.10.24.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:30:48 -0700 (PDT)
Date:   Tue, 24 Oct 2023 14:30:42 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 06/14] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
Message-ID: <20231024-c57e7349131ee8c81bea9c07@orel>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-7-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023172800.315343-7-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:57:52PM +0530, Anup Patel wrote:
> We add DT bindings document for the RISC-V incoming MSI controller
> (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../interrupt-controller/riscv,imsics.yaml    | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> new file mode 100644
> index 000000000000..84976f17a4a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> @@ -0,0 +1,172 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V Incoming MSI Controller (IMSIC)
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description: |
> +  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
> +  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
> +  AIA specification can be found at https://github.com/riscv/riscv-aia.
> +
> +  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
> +  for each privilege level (machine or supervisor). The configuration of
> +  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO

an IMSIC

> +  space to receive MSIs from devices. Each IMSIC interrupt file supports a
> +  fixed number of interrupt identities (to distinguish MSIs from devices)
> +  which is same for given privilege level across CPUs (or HARTs).

which is the same for a given

> +
> +  The device tree of a RISC-V platform will have one IMSIC device tree node
> +  for each privilege level (machine or supervisor) which collectively describe
> +  IMSIC interrupt files at that privilege level across CPUs (or HARTs).

s/at that privilege level/for their respective privilege levels/

> +
> +  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
> +  follows a particular scheme defined by the RISC-V AIA specification. A IMSIC

An IMSIC

> +  group is a set of IMSIC interrupt files co-located in MMIO space and we can
> +  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
> +  RISC-V platform. The MSI target address of a IMSIC interrupt file at given

an IMSIC interrupt file at a given

> +  privilege level (machine or supervisor) encodes group index, HART index,
> +  and guest index (shown below).
> +
> +  XLEN-1            > (HART Index MSB)                  12    0
> +  |                  |                                  |     |
> +  -------------------------------------------------------------
> +  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
> +  -------------------------------------------------------------
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qemu,imsics
> +      - const: riscv,imsics
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 16384
> +    description:
> +      Base address of each IMSIC group.
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 0
> +
> +  msi-controller: true
> +
> +  "#msi-cells":
> +    const: 0
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 16384
> +    description:
> +      This property represents the set of CPUs (or HARTs) for which given

which a given

> +      device tree node describes the IMSIC interrupt files. Each node pointed
> +      to should be a riscv,cpu-intc node, which has a CPU node (i.e. RISC-V
> +      HART) as parent.

as its parent

> +
> +  riscv,num-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 63
> +    maximum: 2047
> +    description:
> +      Number of interrupt identities supported by IMSIC interrupt file.

by an IMSIC interrupt file

> +
> +  riscv,num-guest-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 63
> +    maximum: 2047
> +    description:
> +      Number of interrupt identities are supported by IMSIC guest interrupt

which are supported by an IMSIC guest interrupt file

> +      file. When not specified it is assumed to be same as specified by the

the same

> +      riscv,num-ids property.
> +
> +  riscv,guest-index-bits:
> +    minimum: 0
> +    maximum: 7
> +    default: 0
> +    description:
> +      Number of guest index bits in the MSI target address.
> +
> +  riscv,hart-index-bits:
> +    minimum: 0
> +    maximum: 15
> +    description:
> +      Number of HART index bits in the MSI target address. When not
> +      specified it is calculated based on the interrupts-extended property.
> +
> +  riscv,group-index-bits:
> +    minimum: 0
> +    maximum: 7
> +    default: 0
> +    description:
> +      Number of group index bits in the MSI target address.
> +
> +  riscv,group-index-shift:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 55
> +    default: 24
> +    description:
> +      The least significant bit position of the group index bits in the
> +      MSI target address.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - msi-controller
> +  - "#msi-cells"
> +  - interrupts-extended
> +  - riscv,num-ids
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example 1 (Machine-level IMSIC files with just one group):
> +
> +    interrupt-controller@24000000 {
> +      compatible = "qemu,imsics", "riscv,imsics";
> +      interrupts-extended = <&cpu1_intc 11>,
> +                            <&cpu2_intc 11>,
> +                            <&cpu3_intc 11>,
> +                            <&cpu4_intc 11>;
> +      reg = <0x28000000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <0>;
> +      msi-controller;
> +      #msi-cells = <0>;
> +      riscv,num-ids = <127>;
> +    };
> +
> +  - |
> +    // Example 2 (Supervisor-level IMSIC files with two groups):
> +
> +    interrupt-controller@28000000 {
> +      compatible = "qemu,imsics", "riscv,imsics";
> +      interrupts-extended = <&cpu1_intc 9>,
> +                            <&cpu2_intc 9>,
> +                            <&cpu3_intc 9>,
> +                            <&cpu4_intc 9>;
> +      reg = <0x28000000 0x2000>, /* Group0 IMSICs */
> +            <0x29000000 0x2000>; /* Group1 IMSICs */
> +      interrupt-controller;
> +      #interrupt-cells = <0>;
> +      msi-controller;
> +      #msi-cells = <0>;
> +      riscv,num-ids = <127>;
> +      riscv,group-index-bits = <1>;
> +      riscv,group-index-shift = <24>;
> +    };
> +...
> -- 
> 2.34.1
>

Thanks,
drew
