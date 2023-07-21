Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0675C3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGUJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGUJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:59:36 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB562E75
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:59:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so25075221fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689933560; x=1690538360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7yu24f83h3XO4R/gmlxJ5urnXVfCEwnG3WcDoguI/o=;
        b=m+qRZTaHj2dp4H2ai+Vst3rWV+H85/YGMifhcV/tIdT1uyU82s4xgw66vYrh1C7d8E
         JR1oW8229Heqz9q5ZXtaf+47VxK+Soo4x1MoMr/CZO3JnLlCI32XGJvAtQW2RZbpVSL/
         u4j+PiW3KFRgIHINJZOjMdKmLzGbSdZmNNBYpsK+oK/mCpeNZAPV6XQ4APzim4yfQmgO
         MO+cgucMruFrpzyad6JR7qUBm2mJMjTit2gQ2ljg5jO+40Z/MWE6TaGABcE4rTkYcP30
         9ZGfCYrsEa1+49e786zyapnLqZ/Uh60bCvfXulZBxUxXEA+0oyOZhkdXhrREV/m5v+0z
         Gr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933560; x=1690538360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7yu24f83h3XO4R/gmlxJ5urnXVfCEwnG3WcDoguI/o=;
        b=gqI1OrC75xPqLBQoX8skqmaFfFqnv8b1swCBqymRIpLRW1cNJ7Vi7PpRa5PsetHOz9
         3jABiJijtXkfjcatNc5KNLgOzETSVGCPbzjCONgaF9j4JEMX8EH4ORObBDP5d5tWV7gz
         tBM6hV1v642KGywXos77rMuEI2bEaKGcPa+iaUUkXh4sVpcrHwOYRsTJjERdxa3hXyS5
         wL1QNVSs6haPnkybIQ9b8J7WsuSMkdEOAh5u3fxgA2hGqVWkEKUwJ3S73CR4iwQG/jmP
         e6Qb/Y7ED8jrD5N7XKJ25lyXNBKwM2nF1ExCezq2Grk4dAfuvvbCtC6rPejv3aByKyEZ
         Kfug==
X-Gm-Message-State: ABy/qLYwUjpLkzwomvvmNRWFuuBYxj6PA7e1uYJjGbeghJPCErSIY5Sa
        B8sqlf0yq81/DpyyeUDcabkjCg==
X-Google-Smtp-Source: APBJJlG0sx4g88gk/BmU8cUQfdN03382WaIYesbOyKymn1jBnRqcgzWB+YP2/FvjfcqOmj4mfZ5wNQ==
X-Received: by 2002:a2e:9b94:0:b0:2b9:344c:a214 with SMTP id z20-20020a2e9b94000000b002b9344ca214mr1084334lji.42.1689933559866;
        Fri, 21 Jul 2023 02:59:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id jj28-20020a170907985c00b0098d93142ce1sm1957040ejc.109.2023.07.21.02.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 02:59:19 -0700 (PDT)
Message-ID: <1a5fb6a5-10f0-7dc8-03db-f09ac487d7df@linaro.org>
Date:   Fri, 21 Jul 2023 11:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 Custom
 Board
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tim Harvey <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230721095003.3681484-1-james.hilliard1@gmail.com>
 <20230721095003.3681484-3-james.hilliard1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721095003.3681484-3-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 11:49, James Hilliard wrote:
> Add support for Variscite i.MX6Q VAR-SOM-MX6 Custom Board.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Drop the tag, patch differs significantly.

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index da486c4a4ecf..76bb098605e7 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -387,6 +387,7 @@ properties:
>  
>        - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
>          items:
> +          - const: variscite,mx6customboard

If previous patch was correct, you would now broke the compatible
list... which is a proof that previous commit does not make sense on its
own.

Best regards,
Krzysztof

