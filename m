Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5E755DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGQIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjGQIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:00:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7A6B8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:00:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so593936366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689580839; x=1692172839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THHFMED/jbOMH1YRv1UObCpRHTU3JeymiO4m4VH30UI=;
        b=JVkc2lCRmJaOr1H3tOGjczXY4e7+wGGkwH424uoSMLfFGyuQwfYbf4VVztm+wtgQM0
         k1KtafwTOYyffgHZqwXgnXqmN/FS/nZoRG/s35hkxZhxG7kmcdaFzKRh8AaFyR/a1NuR
         k2F86TuPe/XBLIQCP4C9q5pNTZwGAbUXCxhp6qGgLgk6As+S4h0Dnn7Yj6/b7fKzZqFU
         X/6GxUUmkSa2tiVLlllntz4up8imTnP0JF2PT+gSW8419n/qIEoMN19TOD7ycyJPtznc
         BePOJ2L+o8VSMPAG/YkbLjdpoHKFvNwtllz8JMTEjJ+pLam/MhEs4jW2d+NcahMHyYMn
         1efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580839; x=1692172839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THHFMED/jbOMH1YRv1UObCpRHTU3JeymiO4m4VH30UI=;
        b=E7YEt/wOanT6oR4SyDb1+e3Nl0DZ+QyCAJ6TujmsjAYjpSKx1GdhjrDpbhqXM7/U5R
         k47iBFESQUhOnb/OvUcGwPHIJofCtQV5nP3luoXTJ7cUDlJz96OzSN02bK2A9ZOmzuk4
         cvq5DRTgXctQjGQXjFo5JGMwQFdLYr3ytSPFzKXPzOTXcGodNXZjBUr2ilUbvvTz88+b
         yxYiNgCe7bUU7wAl7rE9iAzT8ypULO+dDR5551Z1kdFgVAawxhu5rSwgZDyizhSzQjn5
         P8C0+K3EH15DI/bR90zVAp/NmHyxlmFjr7OSIE1TapvVg7MerzsWm4NOHFbSKCA6gnPr
         duhA==
X-Gm-Message-State: ABy/qLad3GnMkRQtDG//LdPqTPULQXSefnC4Up4eIjAuGAVw7CKL/S6t
        j1Qa27nOlKWEDvwJBj7u1PcP7w==
X-Google-Smtp-Source: APBJJlE6vsMf+xJHq0O08ELQG4D+gllwRFuPlzUBGX6jzdz35fNbMZ5xU3jC0NMYESeFySVfqn8/vw==
X-Received: by 2002:a17:907:8a11:b0:993:e691:6dd5 with SMTP id sc17-20020a1709078a1100b00993e6916dd5mr12922667ejc.7.1689580838733;
        Mon, 17 Jul 2023 01:00:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j8-20020a1709064b4800b009929c09abdfsm8914264ejv.70.2023.07.17.01.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:00:38 -0700 (PDT)
Message-ID: <6dbf7628-da4e-6be6-27ed-b0bafa15d8bb@linaro.org>
Date:   Mon, 17 Jul 2023 10:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 RESEND] dt-bindings: clock: ast2600: Add I3C and MAC
 reset definitions
Content-Language: en-US
To:     Dylan Hung <kobedylan@gmail.com>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, Dylan Hung <dylan_hung@aspeedtech.com>
References: <20230717075123.1597977-1-dylan_hung@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717075123.1597977-1-dylan_hung@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 09:51, Dylan Hung wrote:
> Add reset definitions of AST2600 I3C and MAC controllers.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---
> 
> Resend v2 patch through my gmail account as the aspeedtech.com domain is blocked by gmail.com

Where is the changelog?

> 
>  include/dt-bindings/clock/ast2600-clock.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index e149eee61588..712782177c90 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -90,7 +90,19 @@
>  /* Only list resets here that are not part of a clock gate + reset pair */
>  #define ASPEED_RESET_ADC		55
>  #define ASPEED_RESET_JTAG_MASTER2	54
> +
> +#define ASPEED_RESET_MAC4		53
> +#define ASPEED_RESET_MAC3		52
> +
> +#define ASPEED_RESET_I3C5		45
> +#define ASPEED_RESET_I3C4		44
> +#define ASPEED_RESET_I3C3		43
> +#define ASPEED_RESET_I3C2		42
> +#define ASPEED_RESET_I3C1		41
> +#define ASPEED_RESET_I3C0		40
> +#define ASPEED_RESET_I3C		39
>  #define ASPEED_RESET_I3C_DMA		39

Why adding duplicate ID? Your commit msg or a comment here should
explain this.

Best regards,
Krzysztof

