Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292167576CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjGRIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjGRIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:40:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AECA12D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:40:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b946602d64so23815881fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689669602; x=1690274402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woIb3SjHXD99MqsCp0i8NLJW/epsC4Wb4octK3c74H8=;
        b=CyPEb8cUR13YpK+EGscbjkqWOOcir6/Stq/pc/Gk4qj30CPyvIwDeob9p9VIBi7i9L
         c/LBwxL94QikRpPDzurawrSuIgaO3nGKiQk/dHaye+8Rbv/1Ey0GCFCL35x4YDSUNqKj
         AkWKAUTKukjyVUJqhGHYNdDh+KUyux9DI/EiBqcnmA8QyAQQuGlDCqXSAO0Q8iBx21L2
         CRBdmuyBwSvWl4hEtZAzThC84JoGN95JvIDeGlGdSqwBCMBM5fcZFaP2TiaLJJ28ByQU
         5DFenuqQp7J2fQ2WEdd4BelTkrFNA/Q0p1u+OVqJDVus9uUPbfX4nhZLTd7sYUztGQoe
         Dhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669602; x=1690274402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woIb3SjHXD99MqsCp0i8NLJW/epsC4Wb4octK3c74H8=;
        b=BKGFi2LLqEI7CaNpOmQuJybSVyfV08gyhHaXu19/C8VZgxqYYMr1ByBNkEtX19KDn2
         S0pLOPRqeW9SFyUUfbwjb+cLLxCCFGVovUOmPJioC8WrsBgaL+cufOOyTH0iSmcoLSty
         1R2bTARGqHE4NDXVey9IlEz/LwaqlAC8+MPnYsWla/f9w3MG0HgtRThRIvXLmlV9imVf
         kSQhJTcoro8gIaCozrZFDSZ+zz4+B5TnhRa5lVGX/IOsIa7uRmaxnlrU5MiXPRwKnTUX
         Ca51l99MeLcx3wdGIsgmvKqF/SGYhrQ3DvxhnF5UQxD84uFdIcOqfItcCv/0pY2I9Mxk
         7cJw==
X-Gm-Message-State: ABy/qLZmoMz/GFO0cmkj2jrL2AjXG/a0hi0d51rVTU9wF6ymxGAqGw04
        8fJteSOJCpnBRr655I4O/viKaA==
X-Google-Smtp-Source: APBJJlEXMa6a/aCnbA/M/4W2DhmsQJGnLpxBUTBmwq6Wr4WMSsGoZSD9nmG2ddD54+XPSSm7jCv99w==
X-Received: by 2002:a2e:980a:0:b0:2b6:dd85:1206 with SMTP id a10-20020a2e980a000000b002b6dd851206mr9880471ljj.49.1689669602433;
        Tue, 18 Jul 2023 01:40:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q17-20020a2e9691000000b002b6ee1e8893sm359746lji.95.2023.07.18.01.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:40:02 -0700 (PDT)
Message-ID: <02cc38f9-d742-9695-eb0f-0a5fca096c3a@linaro.org>
Date:   Tue, 18 Jul 2023 11:40:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty: serial: add missing clk_put()
Content-Language: en-GB
To:     sunran001@208suo.com, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230718075401.16668-1-xujianghui@cdjrlc.com>
 <047273ae4e4c25eb7b81fd69d761161e@208suo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <047273ae4e4c25eb7b81fd69d761161e@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 10:55, sunran001@208suo.com wrote:
> This patch fixes the following Coccinelle error:
> 
> ./drivers/tty/serial/bcm63xx_uart.c:854:2-8: ERROR: missing clk_put;
> clk_get on line 849 and execution via conditional on line 853
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/tty/serial/bcm63xx_uart.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/bcm63xx_uart.c 
> b/drivers/tty/serial/bcm63xx_uart.c
> index 55e82d0bf92d..7353b683952d 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -851,6 +851,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
>           clk = of_clk_get(pdev->dev.of_node, 0);
> 
>       if (IS_ERR(clk))
> +        clk_put(clk);

No!

First, calling clk_put() on the error pointer is incorrect. This will 
throw a warning in __clk_put(), but generally passing an error pointer 
to another function can cause different kinds of breakage.

Second, you have added the line, but this also moved the return 
statement out of the if condition. This way all bcm_uart_probe() calls 
will end up with -ENODEV return value.

Please stop blindly fixing the coccinelle warnings. Take care to read 
and understand the code.

>           return -ENODEV;
> 
>       port->iotype = UPIO_MEM;

-- 
With best wishes
Dmitry

