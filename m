Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F37A73EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjITHWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjITHWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:22:45 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C1D8;
        Wed, 20 Sep 2023 00:22:39 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso863045266b.2;
        Wed, 20 Sep 2023 00:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194557; x=1695799357;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqV+WqtWSovAmjaAS8oCvSAf2hHfhSrpAVKUBeqrcCg=;
        b=rTsxVEEVFww6l1LSosVBkkhbdEL1foOcB2wkcviCWdcsF3ig3nFy9dgN41KFkhW+XL
         /6h5mBJWKdW4hav1BYVOAAH9ehmt8PRr+5Ll6iX29ckNkqRuZbL1YpcoM/JRYw8+hkkb
         Kbskgx3C5WBcBG35pay9/NB69hU3By92jtJne889lPV2MmMalqYhXsoIRyQriRgjYeyG
         f5H4+2sPfmvzt6SgokHppVtE+ux3IhqJUIlVO6P64+DAvvdEvgON486tFHdsADCHDLYV
         oMOBAcbNnymjpRPGkBhDfsi4tDuAv4v5Xv9F/YSES/peuyrmxv8XZU3AxZEZvBr+wupI
         K+yw==
X-Gm-Message-State: AOJu0YyZMW308yk2T8XzWCAx1H5jcm2FZKBaKMAkBY/dd8hbALgSXiV7
        C0fwfMcwOijQsTKF+9BEtso=
X-Google-Smtp-Source: AGHT+IHkprxRbSFfXxFJnc1KOHTyomySMC4QUTOkx6mX5zj+FVB1azoom6piwpg4Gsr3H8pinS1W6A==
X-Received: by 2002:a17:906:3110:b0:9ae:2f33:4ad0 with SMTP id 16-20020a170906311000b009ae2f334ad0mr1403844ejx.71.1695194557217;
        Wed, 20 Sep 2023 00:22:37 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id fi26-20020a170906da1a00b0099bc8db97bcsm8841526ejb.131.2023.09.20.00.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 00:22:36 -0700 (PDT)
Message-ID: <553a8dbd-08b9-488a-a024-f89697908b41@kernel.org>
Date:   Wed, 20 Sep 2023 09:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drivers/tty/serial: add driver for the ESP32 UART
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
 <20230920022644.2712651-4-jcmvbkbc@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20230920022644.2712651-4-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 09. 23, 4:26, Max Filippov wrote:
> Add driver for the UART controllers of the Espressif ESP32 and ESP32S3
> SoCs. Hardware specification is available at the following URLs:
...
> +static void esp32_uart_rxint(struct uart_port *port)
> +{
> +	struct tty_port *tty_port = &port->state->port;
> +	u32 rx_fifo_cnt = esp32_uart_rx_fifo_cnt(port);
> +	unsigned long flags;
> +	u32 i;
> +
> +	if (!rx_fifo_cnt)
> +		return;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	for (i = 0; i < rx_fifo_cnt; ++i) {
> +		u32 rx = esp32_uart_read(port, UART_FIFO_REG);
> +		u32 brk = 0;
> +
> +		++port->icount.rx;

Should yuou increment this only in case of insert_flip_char()?

> +		if (!rx) {
> +			brk = esp32_uart_read(port, UART_INT_ST_REG) &
> +				UART_BRK_DET_INT;
> +		}
> +		if (brk) {
> +			esp32_uart_write(port, UART_INT_CLR_REG, brk);
> +			++port->icount.brk;
> +			uart_handle_break(port);
> +		} else {
> +			if (uart_handle_sysrq_char(port, (unsigned char)rx))
> +				continue;
> +			tty_insert_flip_char(tty_port, rx, TTY_NORMAL);
> +		}

This is heavy. Is it equivalent to:
if (!rx && esp32_uart_read(port, UART_INT_ST_REG) &
     UART_BRK_DET_INT) {
   esp32_uart_write(port, UART_INT_CLR_REG, brk);
   ++port->icount.brk;
   uart_handle_break(port);
   continue;
}

if (uart_handle_sysrq_char(port, (unsigned char)rx))
   continue;

tty_insert_flip_char(tty_port, rx, TTY_NORMAL);

?

> +	}
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	tty_flip_buffer_push(tty_port);
> +}
...
> +static void esp32_uart_put_char_sync(struct uart_port *port, u8 c)
> +{
> +	unsigned long timeout;
> +
> +	timeout = jiffies + msecs_to_jiffies(1000);

I.e. plus HZ?

> +	while (esp32_uart_tx_fifo_cnt(port) >= ESP32_UART_TX_FIFO_SIZE) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_warn(port->dev, "timeout waiting for TX FIFO\n");
> +			return;
> +		}
> +		cpu_relax();
> +	}
> +	esp32_uart_put_char(port, c);
> +}
> +
> +static void esp32_uart_transmit_buffer(struct uart_port *port)
> +{
> +	u32 tx_fifo_used = esp32_uart_tx_fifo_cnt(port);
> +
> +	if (tx_fifo_used < ESP32_UART_TX_FIFO_SIZE) {

Invert the condition and return here?

> +		unsigned int pending;
> +		u8 ch;
> +
> +		pending = uart_port_tx_limited(port, ch,
> +					       ESP32_UART_TX_FIFO_SIZE - tx_fifo_used,
> +					       true, esp32_uart_put_char(port, ch),
> +					       ({}));
> +		if (pending) {
> +			u32 int_ena;
> +
> +			int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
> +			int_ena |= UART_TXFIFO_EMPTY_INT;
> +			esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
> +		}
> +	}
> +}


> +static irqreturn_t esp32_uart_int(int irq, void *dev_id)
> +{
> +	struct uart_port *port = dev_id;
> +	u32 status;
> +
> +	status = esp32_uart_read(port, UART_INT_ST_REG);
> +
> +	if (status & (UART_RXFIFO_FULL_INT | UART_BRK_DET_INT))
> +		esp32_uart_rxint(port);
> +	if (status & UART_TXFIFO_EMPTY_INT)
> +		esp32_uart_txint(port);
> +
> +	esp32_uart_write(port, UART_INT_CLR_REG, status);

\n here please.

> +	return IRQ_RETVAL(status);
> +}

> +static int esp32_uart_startup(struct uart_port *port)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +	struct esp32_port *sport = container_of(port, struct esp32_port, port);
> +
> +	ret = clk_prepare_enable(sport->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(port->dev, port->irq, esp32_uart_int, 0,
> +			       DRIVER_NAME, port);
> +	if (ret) {
> +		clk_disable_unprepare(sport->clk);
> +		return ret;
> +	}
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	esp32_uart_write(port, UART_CONF1_REG,
> +			 (1 << UART_RXFIFO_FULL_THRHD_SHIFT) |

BIT() ?

> +			 (1 << port_variant(port)->txfifo_empty_thrhd_shift));

And here?

> +	esp32_uart_write(port, UART_INT_CLR_REG, UART_RXFIFO_FULL_INT | UART_BRK_DET_INT);
> +	esp32_uart_write(port, UART_INT_ENA_REG, UART_RXFIFO_FULL_INT | UART_BRK_DET_INT);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	pr_debug("%s, conf1 = %08x, int_st = %08x, status = %08x\n",
> +		 __func__,
> +		 esp32_uart_read(port, UART_CONF1_REG),
> +		 esp32_uart_read(port, UART_INT_ST_REG),
> +		 esp32_uart_read(port, UART_STATUS_REG));

\n here. Is this debug printout somehow useful?

> +	return ret;
> +}
> +
> +static void esp32_uart_shutdown(struct uart_port *port)
> +{
> +	struct esp32_port *sport = container_of(port, struct esp32_port, port);
> +
> +	esp32_uart_write(port, UART_INT_ENA_REG, 0);
> +	devm_free_irq(port->dev, port->irq, port);

I wonder why to use devm_ after all?

> +	clk_disable_unprepare(sport->clk);
> +}
> +
> +static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
> +{
> +	u32 div = port->uartclk / baud;
> +	u32 frag = (port->uartclk * 16) / baud - div * 16;
> +
> +	if (div <= port_variant(port)->clkdiv_mask) {
> +		esp32_uart_write(port, UART_CLKDIV_REG,
> +				 div | FIELD_PREP(UART_CLKDIV_FRAG, frag));
> +		return true;
> +	}

\n

> +	return false;
> +}
...
> +static int __init esp32s3_uart_early_console_setup(struct earlycon_device *device,
> +						   const char *options)
> +{
> +	device->port.private_data = (void *)&esp32s3_variant;

No need to cast, right?

\n

> +	return esp32xx_uart_early_console_setup(device, options);
> +}
...
> +static int esp32_uart_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	static const struct of_device_id *match;
> +	struct uart_port *port;
> +	struct esp32_port *sport;
> +	struct resource *res;
> +	int ret;
> +
> +	match = of_match_device(esp32_uart_dt_ids, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;
> +
> +	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> +	if (!sport)
> +		return -ENOMEM;
> +
> +	port = &sport->port;
> +
> +	ret = of_alias_get_id(np, "serial");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> +		return ret;
> +	}
> +	if (ret >= UART_NR) {
> +		dev_err(&pdev->dev, "driver limited to %d serial ports\n", UART_NR);
> +		return -ENOMEM;
> +	}
> +
> +	port->line = ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	port->mapbase = res->start;
> +	port->membase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(port->membase))
> +		return PTR_ERR(port->membase);
> +
> +	sport->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(sport->clk))
> +		return PTR_ERR(sport->clk);
> +
> +	port->uartclk = clk_get_rate(sport->clk);
> +	port->dev = &pdev->dev;
> +	port->type = PORT_ESP32UART;
> +	port->iotype = UPIO_MEM;
> +	port->irq = platform_get_irq(pdev, 0);
> +	port->ops = &esp32_uart_pops;
> +	port->flags = UPF_BOOT_AUTOCONF;
> +	port->has_sysrq = 1;
> +	port->fifosize = ESP32_UART_TX_FIFO_SIZE;
> +	port->private_data = (void *)match->data;

No need to cast.

> +
> +	esp32_uart_ports[port->line] = sport;
> +
> +	platform_set_drvdata(pdev, port);
> +
> +	return uart_add_one_port(&esp32_uart_reg, port);
> +}

regards,
-- 
js
suse labs

