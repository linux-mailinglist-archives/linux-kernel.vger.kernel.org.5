Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A560766D92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjG1MrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjG1MrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:47:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB3135
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:47:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so4335510a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548435; x=1691153235;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUO+6VZwES9/POG88NUlgN3zynLJKqqzv5z4KtU3TU4=;
        b=NB7orXiQYYfBxznMaptJprRK7gCr43iDAtDBPj4GZQvWQBfpr/KuQ4hhMRaPUP+afZ
         Y84zxSBcgtmZ3Pou8qfXLalxVdK4tVojcnt1MHRM88IznnTPkWFERsrJrgRqlycGcCPI
         XMhfVQ48AWRIoSzP2EuIt4Qot50V+zwIL/yWKroXEEP5U7nJK46gQ3HiEV4j2wWK5H/f
         wJQqO+rvV7ifuM2vhbjfAVGwKZ6BFAmtBtzCOb83SSNmpfL9RpMjax3IVXH5HISi0PCD
         EF+o5p41/uNnCNPYolT45Fm5zzczES0rvZvuJuAted7j7SkDoLuVj4vCaDv0mYvDtbwi
         xw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548435; x=1691153235;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUO+6VZwES9/POG88NUlgN3zynLJKqqzv5z4KtU3TU4=;
        b=GQ6+OXIZb4gIJN6FEd4MXkI/1uy8p83+n4L/Tc9jMI+ks+P33wuvBZolQeojPnbHZU
         rxFvXGPN4s/UJVxhex7YFYn2tJpH6qlKKow3DHbRpTHMDWAUVrnqhzEtzTF4z3dQAXdr
         tv94p2SuomGfqdyNTsSkCuDut2/vbB3Ce5zfWX2kBcoAj+TQ3oOZzR+1A3kgNZRZ/Cnb
         T4mLjb1jCB8u86sTTQtXk0m3SvqQ0c6oQMOXed7iR8BneIvT8hjJ/9eeAbQMBephQJMG
         eHLxutiXeSUMfVynOF9mFp1leFIhNg7p8VqNiMO4Hw9MmWhtM6kccDH+hFBpV9HC3wNx
         06Gw==
X-Gm-Message-State: ABy/qLbYPNkMIeRUYqkWt1piaihenWkB+mfWSHqalafrs2PPBnYqBgz0
        9BW/pG/F4ybBXdFqKodF+RlvlA==
X-Google-Smtp-Source: APBJJlH5hsT80MkBM4VoKo5ggijfd4TH1+fPnA6VLusFaC0nrirMDJL3U1CR72Ew1STRWSQ8LiLbeg==
X-Received: by 2002:a05:6402:35cd:b0:522:4e49:4e45 with SMTP id z13-20020a05640235cd00b005224e494e45mr6056018edc.0.1690548434835;
        Fri, 28 Jul 2023 05:47:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402151900b005224ec27dd7sm1775178edw.66.2023.07.28.05.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:47:14 -0700 (PDT)
Message-ID: <a8964e5a-7b86-6f49-13e0-dfcff605fcc5@linaro.org>
Date:   Fri, 28 Jul 2023 14:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/50] dt-bindings: microchip: atmel,at91rm9200-tcb:
 add sam9x60, sam9x7 compatible
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux@roeck-us.net, sebastian.reichel@collabora.com,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102256.265291-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102256.265291-1-varshini.rajendran@microchip.com>
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

On 28/07/2023 12:22, Varshini Rajendran wrote:
> Add sam9x60, sam9x7 compatible string support in the schema file.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> index a46411149571..912aea5abcf0 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -15,13 +15,20 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - atmel,at91rm9200-tcb
> -          - atmel,at91sam9x5-tcb
> -          - atmel,sama5d2-tcb
> -      - const: simple-mfd
> -      - const: syscon
> +    oneOf:
> +      - items:
> +          - enum:
> +              - atmel,at91rm9200-tcb
> +              - atmel,at91sam9x5-tcb
> +              - atmel,sama5d2-tcb
> +              - microchip,sam9x60-tcb

That's not matching existing DTS.

Best regards,
Krzysztof

