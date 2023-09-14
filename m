Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD0179FD07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjINHQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjINHQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:16:12 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFE9CF1;
        Thu, 14 Sep 2023 00:16:07 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5008d16cc36so1020819e87.2;
        Thu, 14 Sep 2023 00:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675766; x=1695280566;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQKwYFe5CLeNtVBqbexL2j1DmX2BRrnWvOJJEMjcysc=;
        b=WzoAum0cTgfp/qweI/6NkLJUcArxxPaik1buWwbovwpUfAdugQ2B6ixKVJ8zmmmO8f
         F5kvoML5hNqL1GYtIu0Y0uTiG6GhHxhR4UTE5w5cUKnfXZZn6cZL/pA+NkARU2Mh2f9H
         iVFHNYEf8ZfCYWhGc25yHc727FCYv1z6CNhnyuPZVX7eQLN2maz8u+LK5qjk2LnnhpVe
         nLTSjAvMqzQcAZb7DVfyDFcw9GH6MIhGUe1+6RiWS7K9/9LsQyMDYt2RxlA/TFljiS/f
         jlksykI7x/fa1aioSxEYteY/1LtWHuFeXqZhKygQdmSmDOuAs7X0QIN1VdQX0L2oc5Tp
         j5/g==
X-Gm-Message-State: AOJu0YzVbLweFYb8FYFh0FOHly2G4EGidK9ctaZmFduZFzAG0n0H91FV
        ybcQbfOH63ezsEEI0UnxEFs0Uy7L/zw=
X-Google-Smtp-Source: AGHT+IHUStCr3i1+KoeDhu0J4tI/gXDV5LpK1o/m9P26H082Ms5GntiXGaCcrC8h510L+UB/hqom5Q==
X-Received: by 2002:a05:6512:2521:b0:4fe:629:9265 with SMTP id be33-20020a056512252100b004fe06299265mr4099119lfb.20.1694675765747;
        Thu, 14 Sep 2023 00:16:05 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id q18-20020aa7da92000000b0052cdc596652sm530340eds.23.2023.09.14.00.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:16:05 -0700 (PDT)
Message-ID: <6f95d492-2f5e-42e8-acdd-210d6a03b14c@kernel.org>
Date:   Thu, 14 Sep 2023 09:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drivers/tty/serial: add ESP32S3 ACM device driver
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
 <20230913211449.668796-5-jcmvbkbc@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20230913211449.668796-5-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 09. 23, 23:14, Max Filippov wrote:
> Add driver for the ACM  controller of the Espressif ESP32S3 Soc.
> Hardware specification is available at the following URL:
> 
>    https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
>    (Chapter 33 USB Serial/JTAG Controller)
...

> +static void esp32s3_acm_put_char_sync(struct uart_port *port, unsigned char c)
> +{
> +	while (!esp32s3_acm_tx_fifo_free(port))
> +		cpu_relax();

No limits...

> +	esp32s3_acm_put_char(port, c);
> +	esp32s3_acm_push(port);
> +}
> +
> +static void esp32s3_acm_transmit_buffer(struct uart_port *port)
> +{

tx helper.

> +	struct circ_buf *xmit = &port->state->xmit;
> +	u32 tx_fifo_used = esp32s3_acm_tx_fifo_cnt(port);
> +
> +	if (esp32s3_acm_tx_fifo_free(port)) {
> +		while (!uart_circ_empty(xmit) && tx_fifo_used < ESP32S3_ACM_TX_FIFO_SIZE) {
> +			esp32s3_acm_put_char(port, xmit->buf[xmit->tail]);
> +			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +			port->icount.tx++;
> +			++tx_fifo_used;
> +		}
> +	}
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	if (uart_circ_empty(xmit)) {
> +		esp32s3_acm_stop_tx(port);
> +	} else {
> +		u32 int_ena;
> +
> +		int_ena = esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_ENA_REG);
> +		esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
> +				  int_ena | USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ENA_MASK);
> +	}
> +
> +	if (tx_fifo_used > 0 && tx_fifo_used < ESP32S3_ACM_TX_FIFO_SIZE)
> +		esp32s3_acm_write(port, USB_SERIAL_JTAG_EP1_CONF_REG,
> +				  USB_SERIAL_JTAG_WR_DONE_MASK);
> +}


> +static irqreturn_t esp32s3_acm_int(int irq, void *dev_id)
> +{
> +	struct uart_port *port = dev_id;
> +	u32 status;
> +
> +	status = esp32s3_acm_read(port, USB_SERIAL_JTAG_INT_ST_REG);
> +	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_CLR_REG, status);
> +
> +	if (status & USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ST_MASK)
> +		esp32s3_acm_rxint(port);
> +	if (status & USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ST_MASK)
> +		esp32s3_acm_txint(port);
> +
> +	return IRQ_HANDLED;

IRQ_STATUS()

> +}

> +static int esp32s3_acm_startup(struct uart_port *port)
> +{
> +	int ret = 0;
> +
> +	esp32s3_acm_write(port, USB_SERIAL_JTAG_INT_ENA_REG,
> +			  USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA_MASK);
> +	ret = devm_request_irq(port->dev, port->irq, esp32s3_acm_int, 0,
> +			       DRIVER_NAME, port);
> +	return ret;

No need for ret. Or not, you don't handle the failure properly again 
(disable ints). And the order appears to be switched too.


> +static void
> +esp32s3_acm_console_write(struct console *co, const char *s, unsigned int count)
> +{
> +	struct uart_port *port = esp32s3_acm_ports[co->index];
> +	unsigned long flags;
> +	int locked = 1;

bool? ANd in the otrher driver too.

> +
> +	if (port->sysrq)
> +		locked = 0;
> +	else if (oops_in_progress)
> +		locked = spin_trylock_irqsave(&port->lock, flags);
> +	else
> +		spin_lock_irqsave(&port->lock, flags);
> +
> +	esp32s3_acm_string_write(port, s, count);
> +
> +	if (locked)
> +		spin_unlock_irqrestore(&port->lock, flags);
> +}


> +#ifdef CONFIG_CONSOLE_POLL
> +static int esp32s3_acm_earlycon_read(struct console *con, char *s, unsigned int n)
> +{
> +	struct earlycon_device *dev = con->data;
> +	int num_read = 0;

num looks like should be unsigned?

> +
> +	while (num_read < n) {
> +		int c = esp32s3_acm_poll_get_char(&dev->port);
> +
> +		if (c == NO_POLL_CHAR)
> +			break;
> +		s[num_read++] = c;
> +	}
> +	return num_read;
> +}
> +#endif


> +static int esp32s3_acm_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct uart_port *port;
> +	struct resource *res;
> +	int ret;
> +
> +	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
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
> +	port->dev = &pdev->dev;
> +	port->type = PORT_ESP32ACM;
> +	port->iotype = UPIO_MEM;
> +	port->irq = platform_get_irq(pdev, 0);
> +	port->ops = &esp32s3_acm_pops;
> +	port->flags = UPF_BOOT_AUTOCONF;
> +	port->has_sysrq = 1;
> +	port->fifosize = ESP32S3_ACM_TX_FIFO_SIZE;
> +
> +	esp32s3_acm_ports[port->line] = port;
> +
> +	platform_set_drvdata(pdev, port);
> +
> +	ret = uart_add_one_port(&esp32s3_acm_reg, port);
> +	return ret;

return imm.

> +}

regards,
-- 
js
suse labs

