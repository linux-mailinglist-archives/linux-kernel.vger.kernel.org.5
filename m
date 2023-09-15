Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29547A178A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjIOHd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjIOHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:33:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CCDB8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:33:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403012f27e3so20769955e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694763197; x=1695367997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hfitv4X6lwToXcy41tlreOifKHqkBiKe2Y188NSkf/E=;
        b=DRFs+qoTAtfypD5qI5Z2DRa2Q1cpzymtHLPLC5UOK/YOySkGliQwmQDyGc3NnkjZ28
         Ik7WX2/aLQ/Y+XMxkJ4/e0/F9Zn1uiedp3WOoYnMB7HFXAUDn15CPbNLqFHXNneL09zA
         bY/xW3d5EYcc5JZWg6RLqrGtT2HMyqN/94Ubc7Ux4oyxL1myPkmL9yec9Jq7gvmwbb5y
         1L0C8PRKAIWi/2V1pxxHf+XBkXD+xT5vhM7wEoePcX9Nt45ZnLmCPx/+8R2GZiGZXtgz
         +aE+RoZQBNOb8PMEjPF+6BKCyTgDyP69Wgq/+kWbAm8lhtOuAiSvOLwdGfntmOS7Q0xP
         Qm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763197; x=1695367997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hfitv4X6lwToXcy41tlreOifKHqkBiKe2Y188NSkf/E=;
        b=k2f9nY9ugtvyiMEcJAxjUQjnxEAOgKtOLh7X7PaBQU1ia+ZPJDuWBpqaf8DK/gaeK5
         PgKYwscZ3VbLYQlqsV+xexHc/gCgDsCR/qmXKo12eje2mxLIAQfuF3UYr5GgJVJ1guFj
         lgsJOtetDQx026adQJLj9BTmB7azfQgSiq2B/nWX3h6ZU106YyJqWh4Y7/cTYBRlK7Fj
         H/KwhQdowl4mhU9Ty2GB2vwMdDuxv9ikQtGGxKqafLMMU/suwoI8Ffxio2WgwhUlvLAg
         3NsD9JqYjlgPFPInMrVHeyqA9hVvk+nftHCR01Iat+MWzujOPVQSVX8I0abTMrBTq749
         rHsA==
X-Gm-Message-State: AOJu0YzCZKeK1YcKb5URiCbYVwyWIYu0FSYaQzlhiAcaMPRi9m5btB0y
        quEVQPsvrnJ/blA/qoeNfwN1ug==
X-Google-Smtp-Source: AGHT+IHX3L0cvYtW1rLjajL2hbQapX8lSDljHUYvbrbSihTE5UDsyi8Cdbldh20ED7vBOil/5s2bYQ==
X-Received: by 2002:adf:eccc:0:b0:316:efb9:ffa with SMTP id s12-20020adfeccc000000b00316efb90ffamr792560wro.35.1694763197069;
        Fri, 15 Sep 2023 00:33:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id f3-20020adff983000000b003143c6e09ccsm3663543wrr.16.2023.09.15.00.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:33:16 -0700 (PDT)
Message-ID: <803daa8f-f4bd-34b7-f826-89e1db5f24f6@linaro.org>
Date:   Fri, 15 Sep 2023 09:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 10/12] serial: 8250_dw: Add Sophgo SG2042 support
Content-Language: en-US
To:     Wang Chen <unicornxw@gmail.com>, linux-riscv@lists.infradead.org,
        conor@kernel.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20230915072558.118325-1-wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915072558.118325-1-wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:25, Wang Chen wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> 
> Add quirk to skip setting the input clock rate for the uarts on the
> Sophgo SG2042 SoC similar to the StarFive JH7100.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Missing SoB.

> ---
>  drivers/tty/serial/8250/8250_dw.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f4cafca1a7da..6c344877a07f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
>  	.quirks = DW_UART_QUIRK_IS_DMA_FC,
>  };
>  
> -static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
> +static const struct dw8250_platform_data dw8250_skip_set_rate_data = {

Why? What is wrong with old name?

>  	.usr_reg = DW_UART_USR,
>  	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
>  };
> @@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> -	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
> +	{ .compatible = "sophgo,sg2042-uart", .data = &dw8250_skip_set_rate_data },
> +	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },

So devices are fully compatible? Then use compatibility and drop this
patch entirely.


Best regards,
Krzysztof

