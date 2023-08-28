Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2870A78B177
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjH1NRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjH1NQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:16:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C81E11C;
        Mon, 28 Aug 2023 06:16:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so47264261fa.1;
        Mon, 28 Aug 2023 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693228597; x=1693833397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFmS+lobOszZw6W/QjUfDnJ5/Wvc31my2B1+5jBa7/A=;
        b=OQDAjV8mL2PUcye54nJcr6yKcKc1uYXBEejW9G0o+zfSHAPiUae7LS2RRT+CdJav1d
         j8gXyy7HXBObI85M8fhu1vAyA086jT9dhzVbit+NxLf4dCvQXPbW+Wl8qFRUt13Iquka
         GLvsON1Oc3cdnxwHgpbYt0cweaWvqknrNFy/CQnp5RcalL0G+xeUzARgt5H4pWJ0sBfF
         8vpzXWXvpAkLSgOx28M2huZunrNYiRx+mnxzxEyaJbVdlP+aUscSjhVGZfs9lmwFl0B8
         0+NjXU5YXcuaIrUgPD4s+YKG060zx1NOgmPkMxO8C+oSag77EIejkjB5KsHjdQzw0+Pe
         46Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693228597; x=1693833397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFmS+lobOszZw6W/QjUfDnJ5/Wvc31my2B1+5jBa7/A=;
        b=Z3C6TShQfif/BxccEqyr7zskmuApr8VgIXQXxq+HNs8b4WQwHZHsBwfiDvF7wox9r+
         0ndgpHOctFzjv024C1QBbJzE8Q2SYteVG7ginnATG7JPMs+HXlMFbgw7TCjWFPf304D2
         nXaWO1UjDWdf4AfBBNd7naMfAjesHUFklG7bDtE7Y+U6G8GiQ6ouDZzKigWohets8eG4
         05SSwwSFqZCg+gjoTGW2ZF5CZel/m+zUnR0vMZ4KN7scfTFN/ugjEZFTVgGve38Xj9qQ
         vU9dyV7sXrChtYs6W2UH4CIPFZLiddbCqneBQPGxOcf7C8Hg8KQcJakUxjW1Z30YOHjQ
         aAjQ==
X-Gm-Message-State: AOJu0YybkRVNsuusFFPE+Zje1GQCcoIxUaLu/lJahEi3c/R/+oxLMyLi
        ka6Bho+MIjH8TO4RzXHVuKw=
X-Google-Smtp-Source: AGHT+IGSl1gon6Mw15MQYmfOY6/9wlPue4ynOnk1kyxKFHnkqnQl6GNsj4QdZfkhjBmEOXhmF7zt6A==
X-Received: by 2002:a2e:a201:0:b0:2b5:9d78:213e with SMTP id h1-20020a2ea201000000b002b59d78213emr18323279ljm.22.1693228597433;
        Mon, 28 Aug 2023 06:16:37 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l17-20020a2e7011000000b002b9f1214394sm1754206ljc.13.2023.08.28.06.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:16:36 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:16:34 +0300
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
Message-ID: <koiz2vlo3juah7kgvefjiyvxkh7k6tu3an3v7uewpmtdurkico@sazvvhpwvzg6>
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827091710.1483-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD DWMAC Ethernet controller
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
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - thead,th1520-dwmac
> +      - const: snps,dwmac-3.70a
> +
> +  reg:
> +    maxItems: 1
> +

> +  thead,gmacapb:

BTW what is a point in having the "apb" prefix in the name?
The property name like "thead,gmac-syscon" looks much more suitable
since it refers to the actual property content.

-Serge(y)

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
