Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71F17F0BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 07:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjKTGOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 01:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKTGOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 01:14:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE889126
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 22:14:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso13182695e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 22:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700460873; x=1701065673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbbQXlLM5rzQD/2Q3ynuAoYoACD7YY6nmC8tH95Lw5U=;
        b=SXAvK+LUHUvVNYrXHgMbByyw/BTUJAw81uk81cygdcxEhGOUsKTSIBX6SfBl3p0hTs
         ZO4vjYCtfNs5Ykpl7RqdN4lrahN1jBV3SNNzlXQcjRwDwguCfWn+wsxBgIZcmodFVKwE
         50vcQsK4xPfcpQ1o1o3iEFoyRK6vz1GZL3Ib1DC9/3zK5zhxk2n7R0LtvcxlVNv75FtQ
         hlPCnCfDJJChREmjJieIZ7LwrACSYhOXOkRBi1pARpB9Ip/r9+FoDdtezCxfGZ2zszat
         4iQdivC8zZOYnA13Fy1ryVzJDRsMR2LlSoM7TGEYsgdIfYgkbIZtHC3pJxrLd/JVi8qt
         rrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700460873; x=1701065673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbbQXlLM5rzQD/2Q3ynuAoYoACD7YY6nmC8tH95Lw5U=;
        b=oTMjB8MuA84Z1LCVPusEMbNUugbBs9bWMjPRlavzto8bi1+DrzdzY8GV/ff9c3Mlio
         KJjjWffQaVPvnrKmfXkdDKm0n3Jb4b2FTllqKQCHMXoniFMTrsdVpORQJ0etSY2w39Jt
         NYjEcOMhPMojuKFMwT2ouPcM5XGmRnlre8/Iv0tuMa4eHzEAekJyAv5F926RRkBqM/BH
         ygoWM5QV2FLhNeY5e7Hn+xByLl121ABMt18fZKILPw8Afo9Mj4ZAHS57A5cqASQ3NOuZ
         3OwIKLBoUkj9OlSqI5VoOWIvbtbdAl0ewj04PibvV1asRevDJRr5Qd8kRFL/tTN9j1Fh
         ibxQ==
X-Gm-Message-State: AOJu0YwD20DiYKBGYRIqJVJGf4L/08ZJx+NN0JBLjXQYbfL+jXTpeMMF
        vc+g/s/6vfGie0rvjoLF1LPHJg==
X-Google-Smtp-Source: AGHT+IGzKv935lOdpZd3Z+/Bot9oeXhwBAS3lV+3fYuXbVgc69YgQXsGKDnfj1wjbrzAY3h8y9FHeg==
X-Received: by 2002:a05:600c:3c9b:b0:40a:3e41:7dd8 with SMTP id bg27-20020a05600c3c9b00b0040a3e417dd8mr4698567wmb.13.1700460872980;
        Sun, 19 Nov 2023 22:14:32 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b00405959469afsm12486333wms.3.2023.11.19.22.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 22:14:32 -0800 (PST)
Message-ID: <ccfcf2a5-c04b-4781-8658-d63044b9b9c6@tuxon.dev>
Date:   Mon, 20 Nov 2023 08:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: atmel: convert not to use
 dma_request_slave_channel()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe,

On 19.11.2023 17:55, Christophe JAILLET wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
> 
> Switch to the preferred function and update the error handling accordingly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Also update atmel_prepare_rx_dma()
> ---
>  drivers/tty/serial/atmel_serial.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 1946fafc3f3e..6aeb4648843b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1013,14 +1013,18 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	struct device *mfd_dev = port->dev->parent;
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
> +	struct dma_chan *chan;

There is no need for this.

>  	int ret, nent;
>  
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
> -	if (atmel_port->chan_tx == NULL)
> +	chan = dma_request_chan(mfd_dev, "tx");
> +	if (IS_ERR(chan)) {
> +		atmel_port->chan_tx = NULL;
>  		goto chan_err;
> +	}
> +	atmel_port->chan_tx = chan;
>  	dev_info(port->dev, "using %s for tx DMA transfers\n",
>  		dma_chan_name(atmel_port->chan_tx));
>  
> @@ -1188,6 +1192,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
>  	struct circ_buf		*ring;
> +	struct dma_chan *chan;

Ditto

>  	int ret, nent;
>  
>  	ring = &atmel_port->rx_ring;
> @@ -1195,9 +1200,12 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_CYCLIC, mask);
>  
> -	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
> -	if (atmel_port->chan_rx == NULL)
> +	chan = dma_request_chan(mfd_dev, "rx");
> +	if (IS_ERR(chan)) {
> +		atmel_port->chan_rx = NULL;
>  		goto chan_err;
> +	}
> +	atmel_port->chan_rx = chan;
>  	dev_info(port->dev, "using %s for rx DMA transfers\n",
>  		dma_chan_name(atmel_port->chan_rx));
>  
