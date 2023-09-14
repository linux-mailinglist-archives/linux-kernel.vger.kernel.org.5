Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A230079FCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjINHGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjINHGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:06:22 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F43CCD;
        Thu, 14 Sep 2023 00:06:17 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso82750366b.2;
        Thu, 14 Sep 2023 00:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675176; x=1695279976;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0RJpPE7uQtgfvrbSokmqLrrbNVnZSslc42DeGBWZE4=;
        b=LPTy6g2tYExWv8L0+su6Ju4Gn0wDG5o0jtcBaz4rtdN+Hnk3fxLzlSMze0qcoJVmSC
         ieIQOmSMNrEfMnohKTb6u5OnxmCWXvwsAQbC6aaytf6NAOJCFxoQq7tH5emzycB0MmPY
         eObgY8oiTEP8akRxCVstuPYT1Lb+MAUvIafyrUWNpHHQ/+6/G3f8HO3LhOtitxVfRu5R
         RvoqH+Db8G+X7CiDW8pShR6ka8K632VMmouy/NzhVzas/DXHVdSd0B7xlhPmYvgt1LLJ
         ERXcJcfpiXNmjmZFGNw/NLFr5lBlk0Xp3ZaiD2DCKpDCjO39z2toK3ybnUdBOJKR2MM2
         RWNA==
X-Gm-Message-State: AOJu0Yz5VObWpJEMJwWIv+z599r3lNKnFmd+qcf8cxs1jbV64ARh0Qb1
        P0j9rUHjB0XeU6SK7NAVh1C6++pcqJo=
X-Google-Smtp-Source: AGHT+IEnVD/4hR71vbwMg5BUWwWf2BmI6UhKCuTCIcHXo1Y28iX7K2JJZIXjqEQCPJZ4F25FhVjQIg==
X-Received: by 2002:a17:907:75d9:b0:9aa:2b9:4559 with SMTP id jl25-20020a17090775d900b009aa02b94559mr3875398ejc.41.1694675175877;
        Thu, 14 Sep 2023 00:06:15 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709060ac800b009ad875d12d7sm553499ejf.210.2023.09.14.00.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:06:15 -0700 (PDT)
Message-ID: <ac6d6641-7de3-423e-9164-fcd249d782fc@kernel.org>
Date:   Thu, 14 Sep 2023 09:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drivers/tty/serial: add driver for the ESP32 UART
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
 <20230913211449.668796-3-jcmvbkbc@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20230913211449.668796-3-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 09. 23, 23:14, Max Filippov wrote:
> Add driver for the UART controllers of the Espressif ESP32 and ESP32S3
> SoCs. Hardware specification is available at the following URLs:
> 
>    https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf
>    (Chapter 13 UART Controller)
>    https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
>    (Chapter 26 UART Controller)
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
...
> +#define UART_FIFO_REG			0x00
> +#define UART_INT_RAW_REG		0x04
> +#define UART_INT_ST_REG			0x08
> +#define UART_INT_ENA_REG		0x0c
> +#define UART_INT_CLR_REG		0x10
> +#define UART_RXFIFO_FULL_INT_MASK		0x00000001
> +#define UART_TXFIFO_EMPTY_INT_MASK		0x00000002
> +#define UART_BRK_DET_INT_MASK			0x00000080
> +#define UART_CLKDIV_REG			0x14
> +#define ESP32_UART_CLKDIV_MASK			0x000fffff
> +#define ESP32S3_UART_CLKDIV_MASK		0x00000fff
> +#define UART_CLKDIV_SHIFT			0
> +#define UART_CLKDIV_FRAG_MASK			0x00f00000
> +#define UART_CLKDIV_FRAG_SHIFT			20
> +#define UART_STATUS_REG			0x1c
> +#define ESP32_UART_RXFIFO_CNT_MASK		0x000000ff
> +#define ESP32S3_UART_RXFIFO_CNT_MASK		0x000003ff

Can you use GENMASK() for all these?

> +#define UART_RXFIFO_CNT_SHIFT			0
> +#define UART_DSRN_MASK				0x00002000
> +#define UART_CTSN_MASK				0x00004000
> +#define ESP32_UART_TXFIFO_CNT_MASK		0x00ff0000
> +#define ESP32S3_UART_TXFIFO_CNT_MASK		0x03ff0000
> +#define UART_TXFIFO_CNT_SHIFT			16
> +#define UART_ST_UTX_OUT_MASK			0x0f000000
> +#define UART_ST_UTX_OUT_IDLE			0x00000000
> +#define UART_ST_UTX_OUT_SHIFT			24
> +#define UART_CONF0_REG			0x20
> +#define UART_PARITY_MASK			0x00000001
> +#define UART_PARITY_EN_MASK			0x00000002
> +#define UART_BIT_NUM_MASK			0x0000000c
> +#define UART_BIT_NUM_5				0x00000000
> +#define UART_BIT_NUM_6				0x00000004
> +#define UART_BIT_NUM_7				0x00000008
> +#define UART_BIT_NUM_8				0x0000000c
> +#define UART_STOP_BIT_NUM_MASK			0x00000030
> +#define UART_STOP_BIT_NUM_1			0x00000010
> +#define UART_STOP_BIT_NUM_2			0x00000030
> +#define UART_SW_RTS_MASK			0x00000040
> +#define UART_SW_DTR_MASK			0x00000080
> +#define UART_LOOPBACK_MASK			0x00004000
> +#define UART_TX_FLOW_EN_MASK			0x00008000
> +#define UART_RTS_INV_MASK			0x00800000
> +#define UART_DTR_INV_MASK			0x01000000
> +#define ESP32_UART_TICK_REF_ALWAYS_ON_MASK	0x08000000
> +#define ESP32S3_UART_TICK_REF_ALWAYS_ON_MASK	0x00000000
> +#define UART_CONF1_REG			0x24
> +#define ESP32_UART_RXFIFO_FULL_THRHD_MASK	0x0000007f
> +#define ESP32S3_UART_RXFIFO_FULL_THRHD_MASK	0x000003ff
> +#define UART_RXFIFO_FULL_THRHD_SHIFT		0
> +#define ESP32_UART_TXFIFO_EMPTY_THRHD_MASK	0x00007f00
> +#define ESP32S3_UART_TXFIFO_EMPTY_THRHD_MASK	0x000ffc00
> +#define ESP32_UART_TXFIFO_EMPTY_THRHD_SHIFT	8
> +#define ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT	10
> +#define ESP32_UART_RX_FLOW_EN_MASK		0x00800000
> +#define ESP32S3_UART_RX_FLOW_EN_MASK		0x00400000
...

> +static void esp32_uart_put_char_sync(struct uart_port *port, unsigned char c)

u8 for characters everywhere, please.

> +{
> +	while (esp32_uart_tx_fifo_cnt(port) >= ESP32_UART_TX_FIFO_SIZE)
> +		cpu_relax();

No timeout? There should be one.

> +	esp32_uart_put_char(port, c);
> +}
> +
> +static void esp32_uart_transmit_buffer(struct uart_port *port)
> +{
> +	struct circ_buf *xmit = &port->state->xmit;
> +	u32 tx_fifo_used = esp32_uart_tx_fifo_cnt(port);
> +
> +	while (!uart_circ_empty(xmit) && tx_fifo_used < ESP32_UART_TX_FIFO_SIZE) {
> +		esp32_uart_put_char(port, xmit->buf[xmit->tail]);
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		port->icount.tx++;
> +		++tx_fifo_used;
> +	}

Why not using uart_port_tx_limited()?

> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	if (uart_circ_empty(xmit)) {
> +		esp32_uart_stop_tx(port);
> +	} else {
> +		u32 int_ena;
> +
> +		int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
> +		esp32_uart_write(port, UART_INT_ENA_REG,
> +				 int_ena | UART_TXFIFO_EMPTY_INT_MASK);
> +	}
> +}
> +
> +static void esp32_uart_txint(struct uart_port *port)
> +{
> +	esp32_uart_transmit_buffer(port);
> +}
> +
> +static irqreturn_t esp32_uart_int(int irq, void *dev_id)
> +{
> +	struct uart_port *port = dev_id;
> +	u32 status;
> +
> +	status = esp32_uart_read(port, UART_INT_ST_REG);
> +
> +	if (status & (UART_RXFIFO_FULL_INT_MASK | UART_BRK_DET_INT_MASK))
> +		esp32_uart_rxint(port);
> +	if (status & UART_TXFIFO_EMPTY_INT_MASK)
> +		esp32_uart_txint(port);
> +
> +	esp32_uart_write(port, UART_INT_CLR_REG, status);
> +	return IRQ_HANDLED;

This should be IRQ_RETVAL(status) or similar. To let the system disable 
the irq in case the HW gets crazy.

> +static void esp32_uart_start_tx(struct uart_port *port)
> +{
> +	esp32_uart_transmit_buffer(port);
> +}
> +
> +static void esp32_uart_stop_rx(struct uart_port *port)
> +{
> +	u32 int_ena;
> +
> +	int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
> +	esp32_uart_write(port, UART_INT_ENA_REG,
> +			 int_ena & ~UART_RXFIFO_FULL_INT_MASK);
> +}
> +
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
> +	spin_lock_irqsave(&port->lock, flags);
> +	esp32_uart_write(port, UART_CONF1_REG,
> +			 (1 << UART_RXFIFO_FULL_THRHD_SHIFT) |
> +			 (1 << port_variant(port)->txfifo_empty_thrhd_shift));
> +	esp32_uart_write(port, UART_INT_CLR_REG,
> +			 UART_RXFIFO_FULL_INT_MASK |
> +			 UART_BRK_DET_INT_MASK);
> +	esp32_uart_write(port, UART_INT_ENA_REG,
> +			 UART_RXFIFO_FULL_INT_MASK |
> +			 UART_BRK_DET_INT_MASK);
> +	spin_unlock_irqrestore(&port->lock, flags);

So interrupts can be coming now, but you don't handle them yet?

> +	ret = devm_request_irq(port->dev, port->irq, esp32_uart_int, 0,
> +			       DRIVER_NAME, port);

You don't disable clk and interrupts in case of failure?

> +	pr_debug("%s, request_irq: %d, conf1 = %08x, int_st = %08x, status = %08x\n",
> +		 __func__, ret,
> +		 esp32_uart_read(port, UART_CONF1_REG),
> +		 esp32_uart_read(port, UART_INT_ST_REG),
> +		 esp32_uart_read(port, UART_STATUS_REG));
> +	return ret;
> +}
...
> +static void esp32_uart_set_termios(struct uart_port *port,
> +				   struct ktermios *termios,
> +				   const struct ktermios *old)
> +{
> +	unsigned long flags;
> +	u32 conf0, conf1;
> +	u32 baud;
> +	const u32 rx_flow_en = port_variant(port)->rx_flow_en;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	conf0 = esp32_uart_read(port, UART_CONF0_REG) &
> +		~(UART_PARITY_EN_MASK | UART_PARITY_MASK |
> +		  UART_BIT_NUM_MASK | UART_STOP_BIT_NUM_MASK);

Perhaps it would be more readable as:
conf0 = esp32_uart_read(port, UART_CONF0_REG);
conf0 &= ~(UART_PARITY_EN_MASK | ...);
?

> +	conf1 = esp32_uart_read(port, UART_CONF1_REG) &
> +		~rx_flow_en;
> +
> +	if (termios->c_cflag & PARENB) {
> +		conf0 |= UART_PARITY_EN_MASK;
> +		if (termios->c_cflag & PARODD)
> +			conf0 |= UART_PARITY_MASK;
> +	}


> +static void esp32_uart_release_port(struct uart_port *port)
> +{
> +}
> +
> +static int esp32_uart_request_port(struct uart_port *port)
> +{
> +	return 0;
> +}

Drop these two.

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
> +		dev_err(&pdev->dev, "driver limited to %d serial ports\n",
> +			UART_NR);
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
> +
> +	esp32_uart_ports[port->line] = sport;
> +
> +	platform_set_drvdata(pdev, port);
> +
> +	ret = uart_add_one_port(&esp32_uart_reg, port);
> +	return ret;

You can skip ret here and return directly.

thanks,
-- 
js
suse labs

