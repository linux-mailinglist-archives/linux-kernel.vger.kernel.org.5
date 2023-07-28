Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3BA766B58
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjG1LGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjG1LGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:06:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B61D2703
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:06:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so21895965e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690542398; x=1691147198;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CU70Eh2OqmXn/mXGJvsy6fLIYE8In/MkQR/tQEWkQOM=;
        b=qc+LVsKsC9fZ7c+Rtm+B2SsFYCOiBYG5PWTpso7gwBhW+WfgE5FpsPvkjpvfFHSgFP
         StwtdmRslvH+8jrCQN8cxve8M3slE8/gQzVRrvDpdDe6+Opb1KHGXSeyCqVcK6BRsDcr
         l7X586fVfKFo2JKJeIGJIiiWduAhFhfe5vIY2ubTBAKrjg9BxrtNe7T5sxSfYWHg/UrV
         kgEmRQB3wj5p66rxdWRvFmSMk0KrbHQyK7QPSSAamjhP6m1Snkh6Hi2upAHmaGuOZ5gq
         /XhqobN4OCxcEPbfQSWZkLnmkGrMq01Ov+1q9i2Yl+zYniaL/2EjPgfP+2LUe+2J8IcY
         +qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690542398; x=1691147198;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU70Eh2OqmXn/mXGJvsy6fLIYE8In/MkQR/tQEWkQOM=;
        b=IaY8lb8nvM/SapDNRUAa6xtABYlzDBHx6/Mh8AMgOfewav5H6WQpeX1Bwj9CtAotpH
         Hluu4M6Pm5IjoFVutKenhwdvPXd/dLzlAMNN0NU8HZ7MTLfF21Xj7tkJ0E1Dk5kA6jkk
         tASC32ZFrVI0NhyjB3i9kUVHHciI7fQCumeeSia+PaNGKEyXjOv8eXo1wLBUSyo9LMpL
         Q8QSNqGUAhOq7UbgeFvPjHQn4dLjcj8ImePU5cZZAjmmj796Jksj8NPhvBFw5CtyjNYI
         M7ahaIYUgfU287cUacWMdbHbN+TIi0LvEG1qxvx3pzBmKBO35DcUqNklpD4RWmwOqQmF
         uPpg==
X-Gm-Message-State: ABy/qLZ8ZOfK1TyC5LACH38dIfU4M0icwSw1RPo+5BYomn3Gxd44xEpG
        E+jDt67ByOCqtvGZK1Z+x+vvRQ==
X-Google-Smtp-Source: APBJJlHjVByBvBfppyeBdQWe2dS7fGbuNTvvMqTHXVJ0Cu9SAu5uwxXYOY65e950xrmaJkwlvIO39A==
X-Received: by 2002:a05:600c:20c4:b0:3fb:e643:1225 with SMTP id y4-20020a05600c20c400b003fbe6431225mr1636663wmm.13.1690542397797;
        Fri, 28 Jul 2023 04:06:37 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id n5-20020a7bc5c5000000b003fbe4cecc3bsm6831870wmk.16.2023.07.28.04.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:06:37 -0700 (PDT)
Message-ID: <b5c44fc5-005d-6268-af68-85eda9c330ba@linaro.org>
Date:   Fri, 28 Jul 2023 12:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 20/50] dt-bindings: atmel-nand: add
 microchip,sam9x7-pmecc
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102636.266309-1-varshini.rajendran@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230728102636.266309-1-varshini.rajendran@microchip.com>
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



On 7/28/23 11:26, Varshini Rajendran wrote:
> Add microchip,sam9x7-pmecc to DT bindings documentation.
> 

Why? What's the underlying problem that motivated you do this patch?

> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> index 50645828ac20..4598930851d9 100644
> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> @@ -56,6 +56,7 @@ Required properties:
>  	"atmel,sama5d4-pmecc"
>  	"atmel,sama5d2-pmecc"
>  	"microchip,sam9x60-pmecc"
> +	"microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc"
>  - reg: should contain 2 register ranges. The first one is pointing to the PMECC
>         block, and the second one to the PMECC_ERRLOC block.
>  
