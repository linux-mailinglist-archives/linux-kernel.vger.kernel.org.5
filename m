Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69237D471C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjJXFyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjJXFym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:54:42 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4119D;
        Mon, 23 Oct 2023 22:54:39 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40859c466efso21197965e9.3;
        Mon, 23 Oct 2023 22:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698126878; x=1698731678;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhD7iOg0HoIyJp5L6C6NIB+fHBPORTpn/ViRkE3zKlA=;
        b=m9kmhWLt7jDHXBPHgFghjO4ynxPExjzc7WyVK3u3CkNgQiD09Mo8buLvXeVmxoSNnv
         TjV/XMOUpHpVgmsGLpyBcDcoGsAwMtXGKguaBffSIPINHMHxWS7bBaKAd2+JsLcRxQBO
         XC2GU3ais/E02r/FE5gIZ+6rFnglHp/EPBJPGobIpq8vruTIDgM6M+J0m67gSKsJiLHm
         HTeVS1fOU7tOJBfUfrFBDlNknMLJPMftMLaWYXNwKLEFyoO1tuTcQysxjt5lYoTU+GFS
         A58UkrNQV7svIYyD79EAI6Msz4TaSWCDsvZTY9Sq0pvHO6zRoVWi7yyv8RIXUMpm8y/m
         0H6A==
X-Gm-Message-State: AOJu0Yx2fTRdkRJ/8+dsICUyOW79+ISuPO+Ok3qdx06jSe8ga7KvqoYr
        yiXe+PSK9jIwffvXF4jKczPMe98mqZc=
X-Google-Smtp-Source: AGHT+IE7ykVK+5d/va69E1PNd0zsha/Wou7RxjtYXqxdAMeSsUtDYEU/GOY7xTP7lbj1Hm2vtQ3KSw==
X-Received: by 2002:a05:600c:468d:b0:409:ca6:d79d with SMTP id p13-20020a05600c468d00b004090ca6d79dmr974745wmo.18.1698126877358;
        Mon, 23 Oct 2023 22:54:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b003fee6e170f9sm11113282wms.45.2023.10.23.22.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 22:54:36 -0700 (PDT)
Message-ID: <ade1f1a4-0fa9-4233-9061-5a76178c94fb@kernel.org>
Date:   Tue, 24 Oct 2023 07:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 tty-next 2/2] serial: 8250: add driver for NI UARTs
Content-Language: en-US
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231023210458.447779-1-brenda.streiff@ni.com>
 <20231023210458.447779-3-brenda.streiff@ni.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231023210458.447779-3-brenda.streiff@ni.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 23, 23:04, Brenda Streiff wrote:
> The National Instruments (NI) 16550 is a 16550-like UART with larger
> FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
> patch adds a driver that can operate this UART, which is used for
> onboard serial ports in several NI embedded controller designs.
> 
> Portions of this driver were originally written by Jaeden Amero and
> Karthik Manamcheri, with extensive cleanups and refactors since.

...

> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_ni.c
...
> +static int ni16550_probe(struct platform_device *pdev)
> +{
> +	const struct ni16550_device_info *info;
> +	struct device *dev = &pdev->dev;
> +	struct uart_8250_port uart = {};
> +	unsigned int prescaler = 0;
> +	struct ni16550_data *data;
> +	const char *portmode;
> +	int txfifosz, rxfifosz;

Why not unsigned?

> +	int rs232_property;

bool

> +	int ret;
> +	int irq;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&uart.port.lock);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = ni16550_get_regs(pdev, &uart.port);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* early setup so that serial_in()/serial_out() work */
> +	serial8250_set_defaults(&uart);
> +
> +	info = device_get_match_data(dev);
> +
> +	uart.port.dev		= dev;
> +	uart.port.irq		= irq;
> +	uart.port.irqflags	= IRQF_SHARED;
> +	uart.port.flags		= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
> +					| UPF_FIXED_PORT | UPF_FIXED_TYPE;
> +	uart.port.startup	= ni16550_port_startup;
> +	uart.port.shutdown	= ni16550_port_shutdown;
> +
> +	/*
> +	 * Hardware instantiation of FIFO sizes are held in registers.
> +	 */
> +	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
> +	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
> +
> +	dev_dbg(dev, "NI 16550 has TX FIFO size %d, RX FIFO size %d\n",
> +		txfifosz, rxfifosz);
> +
> +	uart.port.type		= PORT_16550A;
> +	uart.port.fifosize	= txfifosz;
> +	uart.tx_loadsz		= txfifosz;
> +	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
> +	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
> +
> +	/*
> +	 * Declaration of the base clock frequency can come from one of:
> +	 * - static declaration in this driver (for older ACPI IDs)
> +	 * - a "clock-frquency" ACPI or OF device property
> +	 * - an associated OF clock definition
> +	 */
> +	if (info->uartclk)
> +		uart.port.uartclk = info->uartclk;
> +	if (device_property_read_u32(dev, "clock-frequency",
> +				     &uart.port.uartclk)) {
> +		data->clk = devm_clk_get_optional_enabled(dev, NULL);
> +		if (data->clk)

!IS_ERR(data->clk)

> +			uart.port.uartclk = clk_get_rate(data->clk);
> +	}
> +
> +	if (!uart.port.uartclk) {
> +		dev_err(dev, "unable to determine clock frequency!\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	if (info->prescaler)
> +		prescaler = info->prescaler;
> +	device_property_read_u32(dev, "clock-prescaler", &prescaler);
> +
> +	if (prescaler != 0) {
> +		uart.port.set_mctrl = ni16550_set_mctrl;
> +		ni16550_config_prescaler(&uart, (u8)prescaler);
> +	}
> +
> +	/*
> +	 * The determination of whether or not this is an RS-485 or RS-232 port
> +	 * can come from a device property (if present), or it can come from
> +	 * the PMR (if present), and otherwise we're solely an RS-485 port.
> +	 *
> +	 * This is a device-specific property, and thus has a vendor-prefixed
> +	 * "ni,serial-port-mode" form as a devicetree binding. However, there
> +	 * are old devices in the field using "transceiver" as an ACPI device
> +	 * property, so we have to check for that as well.
> +	 */
> +	if (!device_property_read_string(dev, "ni,serial-port-mode", &portmode) ||
> +	    !device_property_read_string(dev, "transceiver", &portmode)) {
> +		rs232_property = strncmp(portmode, "RS-232", 6) == 0;
> +
> +		dev_dbg(dev, "port is in %s mode (via device property)",

\n missing here and there.

> +			rs232_property ? "RS-232" : "RS-485");
> +	} else if (info->flags & NI_HAS_PMR) {
> +		rs232_property = is_pmr_rs232_mode(&uart);
> +
> +		dev_dbg(dev, "port is in %s mode (via PMR)",
> +			rs232_property ? "RS-232" : "RS-485");
> +	} else {
> +		rs232_property = 0;
> +
> +		dev_dbg(dev, "port is fixed as RS-485");
> +	}
> +
> +	if (!rs232_property) {
> +		/*
> +		 * Neither the 'transceiver' property nor the PMR indicate
> +		 * that this is an RS-232 port, so it must be an RS-485 one.
> +		 */
> +		ni16550_rs485_setup(&uart.port);
> +	}
> +
> +	ret = serial8250_register_8250_port(&uart);
> +	if (ret < 0)
> +		goto err;
> +	data->line = ret;
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +
> +err:
> +	clk_disable_unprepare(data->clk);

But you use devm_?

> +	return ret;
> +}
> +
> +static int ni16550_remove(struct platform_device *pdev)
> +{
> +	struct ni16550_data *data = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(data->clk);
> +	serial8250_unregister_port(data->line);

This should be likely inverted. But I don't know if it matters here at all.

Actually, devm_ again, so the first is unnecessary?

> +	return 0;
> +}
...
> +MODULE_AUTHOR("Jaeden Amero <jaeden.amero@ni.com>");
> +MODULE_AUTHOR("Karthik Manamcheri <karthik.manamcheri@ni.com>");

Do the addresses work? Why not CC them?

thanks,
-- 
js
suse labs

