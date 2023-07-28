Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972EB766D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjG1MlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjG1MlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:41:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02602723
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:41:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99454855de1so280894766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548079; x=1691152879;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xo2og0QJb/G30uSyJ9EzW0kydcJXwF/IwfACaibNr2g=;
        b=mBlh/TNWP8m8EOOx5zzap1GV6ZblAo/WE8/cLZKhSQx4U6fzZeOU1q1MJDy1EJABTe
         CF8KVLQS+ibC3xgVz43cWif5qO+mHBn/vp5ZupJFFgC0bbLBu5asJc7Iwis7cDnr3fnH
         w6yhrokc7CYzxcugIlPAw1QP0k3FNh0GYJwdVsvk/c4xdva6tq4zHmTlfqUrI4ofZCEf
         oDVyalxT0qLxxxp4Vh6DjiAs5+5bmnkihLz4vZv/5pyVVhKaLvNGbWdajkzJztKLrWBO
         VBtybPjysL1UL4+rzPlvzhH3bUfSSAyP4CPeBF4mlNgijxVY+/7iVXLQwUwZC5rgKXM8
         2fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548079; x=1691152879;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xo2og0QJb/G30uSyJ9EzW0kydcJXwF/IwfACaibNr2g=;
        b=UNtTghDuwbC1B1K4psRDYPzMygp4wxRvAQe93w8jBOj3yX3M4fMGUvf5j7zT8xwC3l
         C8vSx6+Y24BwNXwpvro3fmH8vxkEkd0/Sl2z3yFc1XUVFaOn8D5CBs5WVxIgSEgN7ZPO
         G/YCeJRoYMwuBPHabp8YCXA+/A1J7lMYtylLft5W/5J3aEp/FY2MUtpUamOHe97ecTuT
         Lf6pNP0QEY6nfSjch6gippXRgmNot6PIz6YkMycoBHEBw7EJ3Ph3k1h8Rn/qc02Lo4qD
         L4qKmDWUzyUOgCtwrDLaE8cNnTqWtA1208iuHz2XihmRJqew+TDdlVJFjSOlJsYVZsBz
         xEfw==
X-Gm-Message-State: ABy/qLb9Al+dYhGq6hsTTtvmyJVmZDpLRi+hBX2xPB3KKU7D7Yd3sS+I
        M7QvokuZG+6BcQC8Lcj0mp7Pc6cFjIXqxh4LvkAIyQ==
X-Google-Smtp-Source: APBJJlGyXuBfYhmUbZjo56H4AfCzbcQEUiH9Ut+dw389WYsEfgvWEN2vD5e9nSj5tB73bk4UWL18Vg==
X-Received: by 2002:a17:906:cc4b:b0:992:33ba:2eb4 with SMTP id mm11-20020a170906cc4b00b0099233ba2eb4mr1818557ejb.71.1690548079288;
        Fri, 28 Jul 2023 05:41:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h19-20020a17090634d300b0098e422d6758sm2004585ejb.219.2023.07.28.05.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:41:18 -0700 (PDT)
Message-ID: <404dbbd8-f665-8b8f-9175-b5c48287bb6f@linaro.org>
Date:   Fri, 28 Jul 2023 14:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 24/50] dt-bindings: rtt: at91rm9260: add sam9x7
 compatible
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102718.266507-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102718.266507-1-varshini.rajendran@microchip.com>
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
> Add compatible for SAM9X7 RTT.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> index b80b85c394ac..8426810518e1 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> @@ -21,6 +21,9 @@ properties:
>        - items:
>            - const: microchip,sam9x60-rtt
>            - const: atmel,at91sam9260-rtt
> +      - items:
> +          - const: microchip,sam9x7-rtt

Make it part of a enum with sam9x60.

> +          - const: atmel,at91sam9260-rtt
>        - items:
>            - const: microchip,sama7g5-rtt
>            - const: microchip,sam9x60-rtt

Best regards,
Krzysztof

