Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BEA7DC08C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjJ3Tco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3Tcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:32:42 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8283AC9;
        Mon, 30 Oct 2023 12:32:40 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a92782615dso48496947b3.2;
        Mon, 30 Oct 2023 12:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694359; x=1699299159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pByH2StVHoqPD6IH6IBloBGUwp09k45GfAx3mFKKEk=;
        b=rL8zZ6GphI4C+0FnU/jFnqzcrRaYPVU82NESFdqIU4+p77qiNQhS7HHXgCSqC+DmlI
         7qRUbZZwsSQc6ubWvHw1Ml0mN5ivvEeTi5F7gGexZxVWSW4wu6iVjYMM+NDjzSd6db0B
         G9hnd16SiiKGFgvhnG3xsS0bbGGBFzwIMxKOryey7vH/hW84OMklO5u2Yu0tHnQGSJw7
         O5cvSMoFq726g/VCWevDSK/CKcmpz/gtMuMDLxzOkdOYZUWR1/k+Vxq+z8zF2KV2/FDm
         9zxgMRs9tJjfQVMHrZ6sYpWd5OkpPc9p/w9cBARgi1CpoD35gspFrhhrQZMSBe1STxGX
         Qs3Q==
X-Gm-Message-State: AOJu0YxP3V4gld8V0tI9dTJrQuqtdIyeruKnPfw99maDzIHbmfuF/MLV
        2VquonG1rPeCrxvcKIJHLw==
X-Google-Smtp-Source: AGHT+IHK3wChZcWT3XRLoyn0yhbfVBF3GMz9Z0DMZB75PXL08vwUDIKlwJthVuKSpdwIy0fvpvHBbw==
X-Received: by 2002:a25:6605:0:b0:da3:743d:ea3e with SMTP id a5-20020a256605000000b00da3743dea3emr125254ybc.21.1698694359538;
        Mon, 30 Oct 2023 12:32:39 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id e131-20020a256989000000b00d9ab95777ecsm45311ybc.49.2023.10.30.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:32:38 -0700 (PDT)
Received: (nullmailer pid 2046098 invoked by uid 1000);
        Mon, 30 Oct 2023 19:32:36 -0000
Date:   Mon, 30 Oct 2023 14:32:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com, michael.riesch@wolfvision.net
Subject: Re: [PATCH v9 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Message-ID: <20231030193236.GA1995060-robh@kernel.org>
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
 <5f83d60031320c4c7b0f0727604903f50ee49058.1698666612.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f83d60031320c4c7b0f0727604903f50ee49058.1698666612.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 01:25:12PM +0100, Mehdi Djait wrote:
> Add a documentation for the Rockchip Camera Interface
> binding.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
> v8=>v9:
> dropped the "Reviewed-by: Rob Herring <robh@kernel.org>"
> because of the following changes:
> - changed the compatible to rk3066-cif: rk3066 is the earliest Rockchip SoC
>   that uses cif and it is the first model starting the RK30 lineup.

Is px30 compatible with rk3066? It's not clear because you didn't add 
rk3066 support. If not compatible, then add rk3066 when you have a user. 
If it is compatible, then you should have a fallback for px30.

> - adjusted the description
> - changed the node name to video-capture
> 
> 
>  .../bindings/media/rockchip,rk3066-cif.yaml   | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
> new file mode 100644
> index 000000000000..be69e474ed26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/rockchip,rk3066-cif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip CIF Camera Interface
> +
> +maintainers:
> +  - Mehdi Djait <mehdi.djait@bootlin.com>
> +
> +description: |

Don't need '|'

> +  CIF is a camera interface present on some rockchip SoCs. It
> +  receives the data from Camera sensor or CCIR656 encoder and
> +  transfers it into system main memory by AXI bus.

Wrap lines at 80.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3066-cif
> +      - rockchip,px30-vip
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: ACLK
> +      - description: HCLK
> +      - description: PCLK
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: pclk
> +
> +  resets:
> +    items:
> +      - description: AXI
> +      - description: AHB
> +      - description: PCLK IN
> +
> +  reset-names:
> +    items:
> +      - const: axi
> +      - const: ahb
> +      - const: pclkin
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: A connection to a sensor or decoder
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/power/px30-power.h>
> +
> +    parent {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        video-capture@ff490000 {
> +            compatible = "rockchip,px30-vip";
> +            reg = <0x0 0xff490000 0x0 0x200>;
> +            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
> +            clock-names = "aclk", "hclk", "pclk";
> +            resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
> +            reset-names = "axi", "ahb", "pclkin";
> +            power-domains = <&power PX30_PD_VI>;
> +
> +            port {
> +                endpoint {
> +                    remote-endpoint = <&tw9900_out>;
> +                };
> +            };
> +        };
> +    };
> +...
> -- 
> 2.41.0
> 
