Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405CD78B16B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjH1NN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjH1NNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:13:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62011C;
        Mon, 28 Aug 2023 06:13:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so4900437e87.1;
        Mon, 28 Aug 2023 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693228389; x=1693833189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPcs0sktiib0CVnQrsGDXOLxOsYaOoyJrgrvneL+iRI=;
        b=EEnmV2sMju/dqKLAuQnHnueTheowYjzwfKRXRixXky7c7ImDccINdT0pTl+/2ge+j+
         W1pQXboC6Ty5KaPQZKmUab5cR3/E3SPwFn9K5eeYl/qmeBKaQa0ZNEv0Ddn8XiMFJqQu
         qD/Z4VBRm4rRaM4vVz88+OFysYVXVgVRKBzET7RGwE1kO4apkcxPBMqGD+JJw6ak5oyb
         cbRNV3fTTE0nex1r7M5S7x16TkQYwiy8j7DXsPDziOQbK2rK4EsaWc8IHmA34JmackPg
         2L1uMD91hM5K9qVgvueZ9hdPljPNiLj8bD9B18OaT2HrcTATN4QQajG50QkT5f9Qkpyl
         2zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693228389; x=1693833189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPcs0sktiib0CVnQrsGDXOLxOsYaOoyJrgrvneL+iRI=;
        b=Mjod15cTPj1Qn7CYK650wj/1lKdh4L5AFMfFoirHxojvpFdWRf2aU4wZR5FIOxUik5
         BPBTDpQk6kzD2XF6iqA4dG8ImHn4WRmfUmTIY8AzfAwOUe1h9BIQ7gCKy2Ub6WqoeqGH
         QccvEvTiFSXseLREnERCge0sla7ho5ypdIvOcyFmgNB1hLNEooD8dSFHfOV7IrWjIUiF
         P2UnDSFqLQgTeOjG7tkpUDTnIj3azlO6gtMUj3dErMjxhsV3PMBfnYy9JRxpulNsH5Gl
         LD0N0nc0vSfd+az+7yGUCKttb58cmt7MYUTZ+oVoO1ANSrD5s14nPg6Ock2WCwXRCgk3
         fr7g==
X-Gm-Message-State: AOJu0YzGCYtev2oWLfmsXTmpI5mnivOoH00thKc3rwlqRRC2lKtGRV3P
        MDdEewkCV8sUkbB8mNwB74s=
X-Google-Smtp-Source: AGHT+IEm2nDKmysz9bZqzY/IjgJcyF6bL+NRMaFzEewPti0bqJYqOQn+cfpgmS2KGCGOxCmnPQWspQ==
X-Received: by 2002:a2e:99c4:0:b0:2bc:e856:6208 with SMTP id l4-20020a2e99c4000000b002bce8566208mr8664753ljj.33.1693228388708;
        Mon, 28 Aug 2023 06:13:08 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n23-20020a2e86d7000000b002b9e5fe86dasm1727253ljj.81.2023.08.28.06.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:13:08 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:13:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
        Coquelin@web.codeaurora.org,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: add T-HEAD dwmac
 support
Message-ID: <qc2nyqmuouig6qww2q7orlwzvcprjyruyeuyr5dqdpxysajjpv@6fzsgjgokry7>
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827091710.1483-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 05:17:09PM +0800, Jisheng Zhang wrote:
> Add documentation to describe T-HEAD dwmac.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>  .../devicetree/bindings/net/thead,dwmac.yaml  | 77 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index b196c5de2061..73821f86a609 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -96,6 +96,7 @@ properties:
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
>          - starfive,jh7110-dwmac
> +        - thead,th1520-dwmac
>  
>    reg:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/net/thead,dwmac.yaml b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
> new file mode 100644
> index 000000000000..bf8ec8ca2753
> --- /dev/null

> +++ b/Documentation/devicetree/bindings/net/thead,dwmac.yaml

see further regarding using dwmac in the names here.

> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +

> +title: T-HEAD DWMAC Ethernet controller

Additionally would be nice to have a brief controller "description:"
having the next info: the SoCs the controllers can be found on, the DW
(G)MAC IP-core version the ethernet controller is based on and some
data about the synthesize parameters: SMA (MDIO-bus), Tx/Rx COE, DMA
FIFOs size, perfect and hash MAC-filters size, L3L4 frame filters
availability, VLAN hash filter, SA/VLAN-tag insertion, ARP offload
engine, PHY interfaces (MII, RMII, RGMII, etc), EEE support, IEEE
1588(-2008) Timestamping support, PMT and Wake-up frame support, MAC
Management counters (MMC). In addition to that for DW QoS
ETH/XGMAC/XLGMAC the next info would be useful: number of MTL Queues
and DMA channels, MTL queues capabilities (QoS-related), TSO
availability, SPO availability.

Note DMA FIFO sizes can be also constrained in the properties
"rx-fifo-depth" and "tx-fifo-depth"; perfect and hash MAC-filter sizes -
in "snps,perfect-filter-entries" and "snps,multicast-filter-bins".

> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:

> +          - thead,th1520-dwmac

Referring to the DW IP-core in the compatible string isn't very
much useful especially seeing you have a generic fallback compatible.
Name like "thead,th1520-gmac" looks more informative indicating its
speed capability.

> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:

> +          - thead,th1520-dwmac

ditto.

-Serge(y)

> +      - const: snps,dwmac-3.70a
> +
> +  reg:
> +    maxItems: 1
> +
> +  thead,gmacapb:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle to the syscon node that control ethernet
> +      interface and timing delay.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - phy-mode
> +  - thead,gmacapb
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    gmac0: ethernet@e7070000 {
> +        compatible = "thead,th1520-dwmac", "snps,dwmac-3.70a";
> +        reg = <0xe7070000 0x2000>;
> +        clocks = <&clk 1>, <&clk 2>;
> +        clock-names = "stmmaceth", "pclk";
> +        interrupts = <66>;
> +        interrupt-names = "macirq";
> +        phy-mode = "rgmii-id";
> +        snps,fixed-burst;
> +        snps,axi-config = <&stmmac_axi_setup>;
> +        snps,pbl = <32>;
> +        thead,gmacapb = <&gmacapb_syscon>;
> +        phy-handle = <&phy0>;
> +
> +        mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "snps,dwmac-mdio";
> +
> +            phy0: ethernet-phy@0 {
> +                reg = <0>;
> +            };
> +        };
> +    };
> -- 
> 2.40.1
> 
> 
