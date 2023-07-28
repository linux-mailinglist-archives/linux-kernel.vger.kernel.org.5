Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232C7766C18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjG1LwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjG1LwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:52:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C735B5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:52:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5221f193817so2627930a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690545121; x=1691149921;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvHmDWI+Z1sZthByOc6xsTAB3PUIVD4/Hl2iZRstsXk=;
        b=WMx/k6Y0UO+xP947DsS3nk2e3uQ2WO0K6wGnfok03aZO00u8Rrt9H2YJhy3SyBGcvn
         3mNYi8S1NDkM8nh0QvfiguxNsdMLFq7dxp3M/LQ94KjEuWyvb8u4MJvDrt3giY+mIjVz
         JlbDi0jVE3xt5lCo3FGaRXUdoPTHhXqxXifGbM/QB/wtM9cTHFY2FlRBmkXpQ00ArYz4
         spXCVwnSBmAIJaw8gmunzeO6LO8zEVgbg50R6xc8+7tPscOn4LxTmyzSC5X2Hb+obMf7
         09iewzervfaJZstxUf31Zvtqv+pKknzp0EwPunp+uiU2WoAXjLcwqaWhpsJMhKEnBHko
         9wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545121; x=1691149921;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvHmDWI+Z1sZthByOc6xsTAB3PUIVD4/Hl2iZRstsXk=;
        b=TWPqHCOCdeZwzqTpL+GamNttU4jux2xwk+EQlcto3YQH2ee1i+UGr1J6RBCeUvnaca
         rxiMUMHbvYIuM1O42IK0gIKJ2jL2r07LC7q/Hgvg4zXXvBcJj5PgWVHdV1S/fknSLipz
         vPW9KIkr/8SuKg9ZAaAWFmZ3kC80doeYr1WMQ3EoxYoaWY5gMevgqOdmBcG0NF3fcZCp
         K3mFf9ozNEBWLGlpkXiEj2H0jlpn6quTD4KPkccdS6bCF16yHuglU9EdOT4R1ZHQ8MAh
         XbY8JTOPXWJRUO4fop8YIfY7ATKVXBASNgKe219MmMlxFOi710uawugUTHW8tIH3otkk
         K1gA==
X-Gm-Message-State: ABy/qLaj0+2u6Ck3zEBvryNUb5NCXEjO0C0ZuXndY46+2BhgeuVAa2T6
        091ZOBEB477+iNjDLFoZxwFHmw==
X-Google-Smtp-Source: APBJJlH9qI7jXlv52GPyqy9+/LW6P7b3oJDxWS42A/a851ZkhtJdyACEZFuQUlrRP1Krxg9TlTYfQg==
X-Received: by 2002:a17:907:7633:b0:99b:c038:fdac with SMTP id jy19-20020a170907763300b0099bc038fdacmr1839010ejc.20.1690545120813;
        Fri, 28 Jul 2023 04:52:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id mf25-20020a170906cb9900b0099251a40184sm1972601ejb.99.2023.07.28.04.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:52:00 -0700 (PDT)
Message-ID: <1d1ec200-1d76-1485-4eac-19601aa3e67b@linaro.org>
Date:   Fri, 28 Jul 2023 13:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 26/50] dt-bindings: atmel-classd: add sam9x7 compatible
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        claudiu.beznea@microchip.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102740.266612-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102740.266612-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:27, Varshini Rajendran wrote:
> Add sam9x7 compatible to DT bindings documentation.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/sound/atmel,sama5d2-classd.yaml    | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> index 43d04702ac2d..ae3162fcfe02 100644
> --- a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> +++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> @@ -18,7 +18,12 @@ description:
>  
>  properties:
>    compatible:
> -    const: atmel,sama5d2-classd
> +    oneOf:
> +      - items:

No need for items here.

> +          - const: atmel,sama5d2-classd
> +      - items:
> +          - const: microchip,sam9x7-classd
> +          - const: atmel,sama5d2-classd

Best regards,
Krzysztof

