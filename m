Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9A764E90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjG0JGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjG0JGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:06:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569B9C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:47:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso918366a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690447641; x=1691052441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzKatOpTuOf7u3V1+Io5ntUtp+jfKhFzQY0d22Yamro=;
        b=rMUaou1GMHD/Ppm/ABaEvZk+9IPfdWuR6e/BqVMYRUMWGYjAUCvbQzTl2xUi+kgwuW
         Z3Othwr6+aAHS/Ty9q4QDxmb9OwNpdvJ591B4LDH6hSDG9Bpzzzu/nBLNOJxloVdNF/y
         g+QAX9iBoyE6VG5R+MjdqUa1NqA3Nvaj/ES7oy/ivcMvKYBYcWTD/vPLl1r+1ZCAWem/
         B0nxD1tBxxFkxCW62wO1CJk+0MqZRGIqdSEt5onYhar32PnNQ+MDMvc3I/LVjCCmOKOy
         Oc8NPq8Tuhg1bOJ+tzZIgFReBBwjiIMBFRu61TBSVkFyvzTls9cXEpoqSyetIez2MrSs
         beCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690447641; x=1691052441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzKatOpTuOf7u3V1+Io5ntUtp+jfKhFzQY0d22Yamro=;
        b=AVWWKpEU4BHEBzJrQitKm0J+A9RGHPKyAlTRoWnadJI+H3SA6Qrx4OM0aqvyaG/wii
         cT4A+3wb58mGp8Hoj9AGwqrHJ7ivafIpAZbwEpfvk6z5T6PhH6qZl7eM8S+I8ia+5lh4
         O3jpuPziX7YRO5MmzuczCbcixPzgIWDeEYAmevJZ+sjzrm/1RYTsrDeor/QzJ8TQeDg9
         Nhc6d6aDM8cs4ySap4Wwer+dhITIu7cCR5PpGe6FtOUdZ0+pUouKhHCqIeK064VuIA0t
         tGu6HhzC+X5AJUm1zmRWJq+X9oJ8OfIUitwBKTeYnF9BMam7uOIDH60474UXrXlgdJNg
         xYJg==
X-Gm-Message-State: ABy/qLa+MV5acHTl0xjiE+ti5lPsJq3dfPqcmL8YH+cDdGYVrg+Ykhpf
        adcpvPUYh/bPYd0j1SnduVyfuNWP6Swx5BMQrvo=
X-Google-Smtp-Source: APBJJlFXYKAmU8kgOJQ9A1L1krKXklKAx7nVxl3lbA6oBJ8lJHPiF5FiQMkJFq+bdVLrDODUxSM7bQ==
X-Received: by 2002:a50:ee01:0:b0:521:7ab6:b95d with SMTP id g1-20020a50ee01000000b005217ab6b95dmr1302613eds.29.1690447641270;
        Thu, 27 Jul 2023 01:47:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a18-20020aa7d752000000b0051dd16f7e50sm395972eds.44.2023.07.27.01.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 01:47:20 -0700 (PDT)
Message-ID: <10fdcad5-c61b-6721-8cd6-165882cf8c90@linaro.org>
Date:   Thu, 27 Jul 2023 10:47:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 18/42] clk: at91: at91rm9200: fix checkpatch.pl check
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com,
        sboyd@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
 <20230727053156.13587-19-claudiu.beznea@tuxon.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727053156.13587-19-claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 07:31, Claudiu Beznea wrote:
> Fix the following checkpatch.pl check:
> drivers/clk/at91/at91rm9200.c:216: CHECK: Please use a blank line after function/struct/union/enum declarations
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> ---
>  drivers/clk/at91/at91rm9200.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
> index a862a0a18972..e0418ab5d65c 100644
> --- a/drivers/clk/at91/at91rm9200.c
> +++ b/drivers/clk/at91/at91rm9200.c
> @@ -222,6 +222,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>  err_free:
>  	kfree(at91rm9200_pmc);
>  }
> +
>  /*

Again, one commit per one blank line added. This is just ridiculous.

Best regards,
Krzysztof

