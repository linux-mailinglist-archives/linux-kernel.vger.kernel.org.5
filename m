Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA70178BF96
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjH2Hsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjH2HsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:48:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269B1AE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:48:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso5410723a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693295278; x=1693900078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lr2QlQGsThkpqySOQP1JURMlGurjhWC4k5coSOFoZCY=;
        b=hXcHXh31cYLpmtSFQ9xm1HHrJ2rE9xrHb0VwCatUv4qBwKMRNdOeGZZrnV0vpSfHUC
         HESHy3zyMDfDJhw/E0xY6DMuSt9Egej78/9q98JVUSCx1mHonokoHYqchIyai4JUzwd0
         uGNFZgo+WCKyzinGcOOXlc/4H0G1YkXtK1Lk9iTCjlvbE2pV97BYNxDsuYCBXo/Ijw2b
         6lwg6QXew5AOUZKmNeo0BUrGBvUjvf/nFsEQZtTC9zrO+yxcfiNdettP8Yp2Hr4GNqq2
         AXp8RKPhyUceqNEPeAb9MA14y5hNy0RuKdcYtZjK1eP+vENbezsg0rzhQbA7biQHqWOG
         eBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295278; x=1693900078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr2QlQGsThkpqySOQP1JURMlGurjhWC4k5coSOFoZCY=;
        b=Pp9yhNlNg57ezNZMoQLufveM980S3pnKa2U+sDkKiUB4Wotr5F++4bnOJLMD2cSOeU
         Q7+7K4PrOr1lTGcjFGxO4cIFNVP3hka92s/TnbvVFTja7ezW3YwOSU0ctQNTDPgzJYIX
         EHU+qYhZB/JRqyXhsx4oIp9zzeKnQBZrev95rnRDYHtTIR7wy5rWOJIokNwsphTihJji
         fXfBkRLOc5cbstfcqxhL0mXagcfKSnqep76mD4Qs5+wfoerjj8w2k+YqS2QtligoF8nU
         WSP5U9HQSD23sgaP5tPcUh/BU5YAjG2gYDlgBzpebb6GHqSBsf4sao9V0erQXFPqKE9l
         abkA==
X-Gm-Message-State: AOJu0YxK5ozUq37Uqui7y918o55yJUa22OMVTZoKenI/U7WMahBrzUrU
        rOA42QktKBpQ6WtB79aX0/CX3g==
X-Google-Smtp-Source: AGHT+IHviD+IWhGLXJyhOwpxkWtBXCdQ4ur7wNdxd42VPXli4BrUlpg0ttZhUsqEZUI3ntRlxCxzrg==
X-Received: by 2002:aa7:d995:0:b0:525:44c5:48e2 with SMTP id u21-20020aa7d995000000b0052544c548e2mr19344338eds.22.1693295278451;
        Tue, 29 Aug 2023 00:47:58 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id d8-20020a05640208c800b0052237dfa82fsm5358989edz.64.2023.08.29.00.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:47:57 -0700 (PDT)
Message-ID: <7c083976-81cc-96e3-af76-43944ce571ac@linaro.org>
Date:   Tue, 29 Aug 2023 09:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/3] dt-bindings: phy: Add i.MX8QM PCIe PHY binding
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de, a.fatoum@pengutronix.de,
        u.kleine-koenig@pengutronix.de
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1693291534-32092-1-git-send-email-hongxing.zhu@nxp.com>
 <1693291534-32092-2-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693291534-32092-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 08:45, Richard Zhu wrote:
> Add i.MX8QM PCIe PHY binding.
> 
> i.MX8QM HSIO(High Speed IO) module has three instances of single lane
> SERDES PHYs, an instance of two lanes PCIe GEN3 controller, an
> instance of single lane PCIe GEN3 controller, as well as an instance
> of SATA 3.0 controller.
> 
> The HSIO module can be configured as the following different usecases.
> 1 - A two lanes PCIea and a single lane SATA.
> 2 - A single lane PCIea, a single lane PCIeb and a single lane SATA.
> 3 - A two lanes PCIea, a single lane PCIeb.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 70 ++++++++++++++++++-
>  1 file changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> index 182a219387b0..764790f2b10b 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> @@ -17,16 +17,18 @@ properties:
>      enum:
>        - fsl,imx8mm-pcie-phy
>        - fsl,imx8mp-pcie-phy
> +      - fsl,imx8qm-pcie-phy
>  
>    reg:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
>  
>    clock-names:
> -    items:
> -      - const: ref
> +    minItems: 1
> +    maxItems: 5
>  
>    resets:
>      minItems: 1
> @@ -70,6 +72,36 @@ properties:
>      description: PCIe PHY  power domain (optional).
>      maxItems: 1
>  
> +  hsio-cfg:

Missing vendor prefix because it does not look like generic property.

> +    description: |
> +      Specifies the different usecases supported by the HSIO(High Speed IO)

I don't know what are the usecases...

> +      module. PCIEAX2SATA means two lanes PCIea and a single lane SATA.
> +      PCIEAX1PCIEBX1SATA represents a single lane PCIea, a single lane
> +      PCIeb and a single lane SATA. PCIEAX2PCIEBX1 on behalf of a two
> +      lanes PCIea, a single lane PCIeb.
> +      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants to
> +      be used (optional).

None of all this helped me to understand what part of hardware this is
responsible for. It seems you just want to program a register, but
instead you should use one of existing properties like phy-modes etc.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 3 ]
> +
> +  ctrl-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the ctrl-csr region containing the HSIO control and
> +      status registers for PCIe or SATA controller (optional).

Please try some internal review before posting to patches. Community is
not cheap reviewers taking this duty from NXP. I am pretty sure NXP can
afford someone looking at the code.

This misses vendor prefix, as explained many times for every syscon
phandle. Also optional is redundant.

But anyway status of PCIe or SATA controller is not a property of the
phy, so it looks to me you stuff here some properties belonging to some
other missing devices.

> +
> +  misc-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the misc-csr region containing the HSIO control and
> +      status registers for misc (optional).

Same problems.

> +
> +  phy-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the phy-csr region containing the HSIO control and
> +      status registers for phy (optional).

Same problems.


> +
>  required:
>    - "#phy-cells"
>    - compatible
> @@ -78,6 +110,38 @@ required:
>    - clock-names
>    - fsl,refclk-pad-mode
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx8qm-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 5
> +        clock-names:
> +          oneOf:
> +            - items:
> +                - const: pipe_pclk
> +                - const: ctrl_ips_clk
> +                - const: phy_ips_clk
> +                - const: misc_ips_clk

Drop clk everywhere.
> +            - items:
> +                - const: apb_pclk

No, optional clock goes to the end and please explain why APB is optional.



Best regards,
Krzysztof

