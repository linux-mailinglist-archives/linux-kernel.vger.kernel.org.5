Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3247511DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGLUgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGLUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:36:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670361FF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:36:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so9230986a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689194198; x=1691786198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTIfZiBXGeNx2LL2qDkANMIcRNuFQoGE8jZgmUEj/Bs=;
        b=y+sINyL0AJvDXbwpXs4l+ZyafLmlSiYHCSuzz3gsyTZQVlTGfA6Lz9uFnL2VFF48vy
         Vn1iVIMiOM8BeOdr+M51utyIo/cJtoKwpOK1R82IJ58PRdl/MGvHLQZHY2PQG6y/l/kp
         OKlGDzND4jIND6udhfdWG+W2n8X5RfzOIFCT6BzxfMbRuc9dvIpshRmluKdQkD4yaPhG
         HRyQDDXpxv5+PwrFqZ1MJ+1SscC82BMk7dqtOIT7XiRWlIVC0ZIfrRN0Pfu0B7WvESCF
         kiTQ2GW/Z89xvc4X+pKKUL3wYq7h0inozKAd2Gx89lUsRhSsuVAhzgClSdvY7uAyA0Fz
         OUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194198; x=1691786198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTIfZiBXGeNx2LL2qDkANMIcRNuFQoGE8jZgmUEj/Bs=;
        b=labmoAKKkwq+P9sjvG4kACH/o4QzWl9qZ6F5ZmnIESQZI7TO0lN3wVq5/4T0rO9V7W
         ZQAZWPEFtoFRiyRW2XqFVcYFnZZPSB4JW8vwk8F0bAbS8bhoLbmt6y5iVMBqv/sjsO8c
         6mQpewOkBFaa+2mJ9FXYDdsHPZcwJzOMoWN0VexR17bOCvP+mBHuNCxY4RoRsnAZw2UF
         jx5VtTmMjm/rvQgKE689J/G+/WPsdleHzZNtDGig2FdIpC6zw+0gnQlNJ3RWAVoOzqpY
         GT2cwhlOAvkB3nl1vf4jgK+ClkMqQ4j2wPIizLJbgSKmw1mKkv6TyeFwfMLI0x+m075T
         OPiQ==
X-Gm-Message-State: ABy/qLagyBos7oiwdm5ezZwcvIf82hWDcqbtK+xooSjFDrGTxvD8Y7DZ
        SQ8HQ0EQTmzBFOemIJGDbC8sWw==
X-Google-Smtp-Source: APBJJlHhCGGtmxYQDbv6iLN7rNp7N/lmAxjHx0hFv2Tn4xTdwchatR/400eMahUldDdsgzTE8wW+xg==
X-Received: by 2002:aa7:cd8b:0:b0:51e:1656:bb24 with SMTP id x11-20020aa7cd8b000000b0051e1656bb24mr15088788edv.26.1689194197823;
        Wed, 12 Jul 2023 13:36:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j20-20020aa7c0d4000000b0051d9ee1c9d3sm3254199edp.84.2023.07.12.13.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 13:36:37 -0700 (PDT)
Message-ID: <006f9599-6aa4-52ac-068a-831893ec6bf8@linaro.org>
Date:   Wed, 12 Jul 2023 22:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: net: fsl,fec: Add TX clock controls
Content-Language: en-US
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230711150808.18714-1-vesa.jaaskelainen@vaisala.com>
 <20230711150808.18714-2-vesa.jaaskelainen@vaisala.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230711150808.18714-2-vesa.jaaskelainen@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 17:08, Vesa Jääskeläinen wrote:
> With fsl,fec-tx-clock-output one can control if TX clock is routed outside
> of the chip.
> 
> With fsl,fec-tx-clk-as-ref-clock one can select if external TX clock is as
> reference clock.
> 
> Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
> ---
>  .../devicetree/bindings/net/fsl,fec.yaml          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
> index b494e009326e..c09105878bc6 100644
> --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
> @@ -166,6 +166,21 @@ properties:
>      description:
>        If present, indicates that the hardware supports waking up via magic packet.
>  
> +  fsl,fec-tx-clock-output:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, ENETx_TX_CLK output driver is enabled.
> +      If not present, ENETx_TX_CLK output driver is disabled.

Here...

> +
> +  fsl,fec-tx-clk-as-ref-clock:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, gets ENETx TX reference clk from the ENETx_TX_CLK pin. In
> +      this use case, an external OSC provides the clock for both the external
> +      PHY and the internal controller.
> +      If not present, ENETx TX reference clock is driven by ref_enetpllx. This
> +      clock is also output to pins via the IOMUX.ENET_REF_CLKx function.

and here:
In general, Common Clock Framework and its bindings should be used for
handling clock providers and consumers. Why it cannot be used for these
two cases?


Best regards,
Krzysztof

