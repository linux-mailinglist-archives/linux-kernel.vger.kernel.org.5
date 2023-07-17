Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497917569C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjGQQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjGQQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:59:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72617101
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:59:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b703a0453fso76024921fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689613161; x=1692205161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maPQHM1CFdZjddcyI2Mi729XdJZCqrzZE+2R5kAVyOA=;
        b=PYqIGwENJg5G2cxqdiC57KddeldIZoWlUQOp2ZGpCslSCBAiKZPXNRMJx8vuDN4iuh
         v2TB6QHvbxRhVBDfRN88edq2KSVgeYXEfkHLvPSgXs2sz2QBz/kFTfBjrL6mL5PwaFR4
         Azp5Rhv3Sz/MZlTPkB40eEyQQlvqsZs5YVy8qbyxaG6egIrFfCqFkn6ZgxFNjmbO9fUR
         F6Nr9KYcsRevZbxh2/34AwhfSXAelop2yFWVpoj1Z1HRssIsO0J7qNj3LjX794J6lyBe
         TbKY9bsGR29VOgG1Lwhxu1Q6Q6LHK8dbmCVAap5ImJxKLVK9lKvxGi2hRa5ZchHq2gOl
         TycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689613161; x=1692205161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maPQHM1CFdZjddcyI2Mi729XdJZCqrzZE+2R5kAVyOA=;
        b=UCFRfAwC1Bqngp2yDaOYHRZI68H/kBEOJdTBAVNG/fANRAX9bRJnO7mbT//K/cbbkh
         paV0Lc4BWNuOe4D5nnG7h08Hm5mMGJONPF9eVTZNoqHC4wabuIQPr0y9J+t/Jt0CDIS6
         IRFaf9uOrsnBmKchZv4ZKGgZtCLQsb6c5FgU9ehnadviFilCi8njeFa1cspCz5HESUdo
         18e07nKkT+hgRQNwps0R0geJUnU3VRxWLosaCdTH62bTMKA7B5lgtmUmnHkZzCMYMQC+
         gNzCdOrdNd1jixWkbivLEtBfjUHhrw1GJsbg3LH5Uz4O4GieATpZ5tVVb+jqs3bu40wN
         IQmQ==
X-Gm-Message-State: ABy/qLb9ZjOmqtf+X1V+vFHERtIb93z1BRDJ7JNTPGveQi3Uac/OsZht
        NRMrHg7viAyAus7WYa1zFzIrog==
X-Google-Smtp-Source: APBJJlGCzEe3t3Q/MifWDEdbJEqoR1Ae9ID0e45R099ySZpH1Qqoy23w6RdzUQZoVarrwKejHW2TbA==
X-Received: by 2002:a2e:3814:0:b0:2b9:4336:262e with SMTP id f20-20020a2e3814000000b002b94336262emr2248576lja.27.1689613161642;
        Mon, 17 Jul 2023 09:59:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906151a00b00997b6696072sm2749735ejd.206.2023.07.17.09.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 09:59:21 -0700 (PDT)
Message-ID: <22d68e14-5198-59ce-44cc-37e9ff5e367c@linaro.org>
Date:   Mon, 17 Jul 2023 18:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: fsl: fix DEBIX binding
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        dan.scally@ideasonboard.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-2-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717165127.2882535-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 18:51, Marco Felsch wrote:
> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
> corresponding bindings by adding an own entry for it. Mark
> polyhex,imx8mp-debix as deprecated but keep it within the dts file since
> we already have a user for it [1].
> 
> [1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/ \
>     boards/polyhex-debix/board.c#L38
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Subject: fix is too generic and binding is redundant. You already state
this is binding in your prefix. Describe more precise what you are doing.

> ---
> Changelog:
> 
> v2:
> - deprecate polyhex,imx8mp-debix
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 15d4110840654..b29974e3c30b3 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1019,8 +1019,6 @@ properties:
>                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
>                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
> -              - polyhex,imx8mp-debix      # Polyhex Debix boards
> -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
>                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
>                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
> @@ -1054,6 +1052,14 @@ properties:
>            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
>            - const: fsl,imx8mp
>  
> +      - description: Polyhex DEBIX i.MX8MP based SBCs
> +        items:
> +          - enum:
> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
> +            deprecated: true
> +          - const: fsl,imx8mp

That's not how it works and it does not look like you tested the DTS
against bindings. Please run `make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Don't deprecate some piece of entire compatible list, but entire list.

The commit which deprecates compatible should bring a proper one.
Otherwise at this point we have kernel only with deprecated compatibles.


Best regards,
Krzysztof

