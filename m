Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818F7F2591
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjKUF6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjKUF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:58:03 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73E5CA;
        Mon, 20 Nov 2023 21:57:59 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40b26d700a1so4025425e9.0;
        Mon, 20 Nov 2023 21:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700546278; x=1701151078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9tJBkui5n25v+k5XBKmvmcM21ODsT8spSbeLAlavWA=;
        b=kooNRrx9Br2yn32wDT99mnvBOx35xAIMH1XbHNN+9iSrAeGIDEIf4e5WeOuuvzK81Y
         G6heUXgGC2i5syZZlLmXWWrEZBE15BnocDTpH1SWGMG8MetR/xzMuvi3rQ77rQPkHlIX
         Y2xrzjQodBrtOYGtanOp0yEdyVWZKB6NFpfhWxCEA5MRXz6veu8sd1zalEz33PMPh/7m
         n1tf7dnXDiLTv2CSjqXWbFJYZgDlmo29Nj++Yy1pXTXkRNuUGeipq413EpTip2qNAPtT
         lYYYXZdXcxf8U7skI4THUZzCxXmOTTiR5q9wo0Rl6VA7EW/kET3cfVfJDjXEaeCnVjDk
         /GyA==
X-Gm-Message-State: AOJu0Yx7BdkXwrXaFZHg4R1KxCrQ1XDapnB4Ve5iD0cJkhkYNcaK0aSa
        ALVeQm9hsfK+r+w4V1KSRLLn/xIM2m0sJA==
X-Google-Smtp-Source: AGHT+IFgCZLYWSaorPWE61yqrk/JB0OvjseZJP2o1QzblzQh7ubLPPPNZ1AsBaAXMTFaN9YfuSA6dQ==
X-Received: by 2002:a05:600c:3103:b0:40a:20f3:d126 with SMTP id g3-20020a05600c310300b0040a20f3d126mr6483267wmo.6.1700546277885;
        Mon, 20 Nov 2023 21:57:57 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c500d00b004083996dad8sm20285241wmr.18.2023.11.20.21.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 21:57:57 -0800 (PST)
Message-ID: <90ba18b8-1a31-498d-a103-5c91b80cea5b@kernel.org>
Date:   Tue, 21 Nov 2023 06:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] serial: sc16is7xx: improve regmap debugfs by using
 one regmap per port
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lech.perczak@camlingroup.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20231120163931.2872431-1-hugo@hugovil.com>
 <20231120163931.2872431-2-hugo@hugovil.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231120163931.2872431-2-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 11. 23, 17:39, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> With this current driver regmap implementation, it is hard to make sense
> of the register addresses displayed using the regmap debugfs interface,
> because they do not correspond to the actual register addresses documented
> in the datasheet. For example, register 1 is displayed as registers 04 thru
> 07:
...
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
...
>   #ifdef CONFIG_SERIAL_SC16IS7XX_SPI
>   static int sc16is7xx_spi_probe(struct spi_device *spi)
>   {
>   	const struct sc16is7xx_devtype *devtype;
> -	struct regmap *regmap;
> +	struct regmap *regmaps[2];

IMO, in all places, it would make sense to declare a VLA with 
devtype->nr_uart.

> +	unsigned int i;
>   	int ret;
>   
>   	/* Setup SPI bus */
> @@ -1732,11 +1736,20 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
>   		devtype = (struct sc16is7xx_devtype *)id_entry->driver_data;
>   	}
>   
> -	regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
> -			      (devtype->nr_uart - 1);
> -	regmap = devm_regmap_init_spi(spi, &regcfg);
> +	for (i = 0; i < devtype->nr_uart; i++) {
> +		regcfg.name = sc16is7xx_regmap_name(i);
> +		/*
> +		 * If read_flag_mask is 0, the regmap code sets it to a default
> +		 * of 0x80. Since we specify our own mask, we must add the READ
> +		 * bit ourselves:
> +		 */
> +		regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i) |
> +			SC16IS7XX_SPI_READ_BIT;
> +		regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
> +		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);

As you trip over the array until devtype->nr_uart which is of course up 
to 2. For now.

Or at least add an asserion: devtype->nr_uart <= 2 somewhere.

thanks,
-- 
js
suse labs

