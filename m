Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C4804F45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjLEJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346632AbjLEJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:56:18 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E34D59;
        Tue,  5 Dec 2023 01:56:12 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3316c6e299eso4725530f8f.1;
        Tue, 05 Dec 2023 01:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770171; x=1702374971;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCpUoGEbLa7UgEiPGpxMZ6i6kOTLzyq3xsvNy4X6SA0=;
        b=oaPe+ADOiV/s8DuiBkkDxGtm0wPQ3WxYj3EEBIYI9j6tGkAHXYMs4VfxgI94GrXGw5
         Nev9CjK6aEoys57LvBPj1VliltMusiWzwu6b3CIDI+NnuxclORB+yhewveGaPWAZyYck
         r2vi9GcfGWVnfQR5yo58DNpmellxHnzCwheR2cSRy6vdb9KUZ00ijKZkEHYOFnkbBqBi
         9c66EJEO9Cj2QkurpZNE/LtEoQcPio7AV6K/jFPBjNrTrXfML79VLR18oKGpjsb2/xVp
         Jd8oMP6WbTt9ghCF2rEGBVb+dtwaBzodu8kFQf3lwbYSl9sgkiRVn/YTyaWmvRMV12Ov
         +NBA==
X-Gm-Message-State: AOJu0Yy9Bp2hMMHdVO0o5KZRmR1aFkU9gvZyQQo9ff7rDczI6wpC0Fhb
        jjsLgkJoAgtmPAysZn6Q3YI=
X-Google-Smtp-Source: AGHT+IErga5sMFcOAXTtwbBqiAzKsvmtb3tfiJ5mpDctNhrImPKy2RXAdmg4Zz6tiUMSv/PO7R35tQ==
X-Received: by 2002:a05:600c:5013:b0:40b:5e21:c596 with SMTP id n19-20020a05600c501300b0040b5e21c596mr213614wmr.100.1701770170934;
        Tue, 05 Dec 2023 01:56:10 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b0040b2976eb02sm18178185wmb.10.2023.12.05.01.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:56:10 -0800 (PST)
Message-ID: <2c3824d7-0960-4de7-8fae-01478fdef8fe@kernel.org>
Date:   Tue, 5 Dec 2023 10:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] tty: i3c: add TTY over I3C master support
To:     Frank Li <Frank.Li@nxp.com>, miquel.raynal@bootlin.com
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
 <20231130224408.3591288-8-Frank.Li@nxp.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20231130224408.3591288-8-Frank.Li@nxp.com>
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

On 30. 11. 23, 23:44, Frank Li wrote:
> In typical embedded Linux systems, UART consoles require at least two pins,
> TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> present, we can save these two pins by using this driver. Pins is crucial
> resources, especially in small chip packages.
> 
> This introduces support for using the I3C bus to transfer console tty data,
> effectively replacing the need for dedicated UART pins. This not only
> conserves valuable pin resources but also facilitates testing of I3C's
> advanced features, including early termination, in-band interrupt (IBI)
> support, and the creation of more complex data patterns. Additionally,
> it aids in identifying and addressing issues within the I3C controller
> driver.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
...
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -412,6 +412,19 @@ config RPMSG_TTY
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called rpmsg_tty.
>   
> +config I3C_TTY
> +	tristate "TTY over I3C"
> +	depends on I3C
> +	help
> +	  Select this options if you'd like use TTY over I3C master controller

this option
to use
add a period to the end.

> +
> +	  This makes it possible for user-space programs to send and receive
> +	  data as a standard tty protocol. I3C provide relatively higher data
> +	  transfer rate and less pin numbers, SDA/SCL are shared with other
> +	  devices.
> +
> +	  If unsure, say N
> +
>   endif # TTY
>   
>   source "drivers/tty/serdev/Kconfig"
...
> --- /dev/null
> +++ b/drivers/tty/i3c_tty.c
> @@ -0,0 +1,443 @@
...
> +struct ttyi3c_port {
> +	struct tty_port port;
> +	int minor;
> +	spinlock_t xlock; /* protect xmit */
> +	char tx_buff[I3C_TTY_TRANS_SIZE];
> +	char rx_buff[I3C_TTY_TRANS_SIZE];

These should be u8 as per the other changes throughout the tty layer.

> +	struct i3c_device *i3cdev;
> +	struct work_struct txwork;
> +	struct work_struct rxwork;
> +	struct completion txcomplete;
> +	unsigned long status;
> +	int buf_overrun;

Can this be ever negative?

> +};
> +
> +struct workqueue_struct *workqueue;

Is this related:
     Still below items not be fixed (according to Jiri Slaby's comments)
     - rxwork thread: need trigger from two position.
     - common thread queue: need some suggestion
?

As I don't remember, could you elaborate again why you need your own 
workqueue? You need to do it in the commit log anyway.

...
> +static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +	unsigned long flags;
> +	bool is_empty;
> +	int ret;
> +
> +	spin_lock_irqsave(&sport->xlock, flags);
> +	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
> +	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
> +	spin_unlock_irqrestore(&sport->xlock, flags);
> +
> +	if (!is_empty)
> +		queue_work(workqueue, &sport->txwork);
> +
> +	return ret;
> +}
> +
> +static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +	unsigned long flags;
> +	int ret = 0;

Unneeded initialization.

> +
> +	spin_lock_irqsave(&sport->xlock, flags);
> +	ret = kfifo_put(&sport->port.xmit_fifo, ch);
> +	spin_unlock_irqrestore(&sport->xlock, flags);
> +
> +	return ret;
> +}
...
> +static void tty_i3c_rxwork(struct work_struct *work)
> +{
> +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
> +	struct i3c_priv_xfer xfers;
> +	int retry = I3C_TTY_RETRY;

Likely, should be unsigned.

> +	u16 status = BIT(0);
> +	int ret;
> +
> +	memset(&xfers, 0, sizeof(xfers));
> +	xfers.data.in = sport->rx_buff;
> +	xfers.len = I3C_TTY_TRANS_SIZE;
> +	xfers.rnw = 1;
> +
> +	do {
> +		if (test_bit(I3C_TTY_RX_STOP, &sport->status))
> +			break;
> +
> +		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> +
> +		if (xfers.actual_len) {
> +			ret = tty_insert_flip_string(&sport->port, sport->rx_buff,
> +						     xfers.actual_len);
> +			if (ret < xfers.actual_len)
> +				sport->buf_overrun++;
> +
> +			retry = I3C_TTY_RETRY;
> +			continue;
> +		}
> +
> +		status = BIT(0);
> +		i3c_device_getstatus_format1(sport->i3cdev, &status);
> +		/*
> +		 * Target side needs some time to fill data into fifo. Target side may not
> +		 * have hardware update status in real time. Software update status always
> +		 * needs some delays.
> +		 *
> +		 * Generally, target side have circular buffer in memory, it will be moved
> +		 * into FIFO by CPU or DMA. 'status' just show if circular buffer empty. But
> +		 * there are gap, especially CPU have not response irq to fill FIFO in time.
> +		 * So xfers.actual will be zero, wait for little time to avoid flood
> +		 * transfer in i3c bus.
> +		 */
> +		usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> +		retry--;
> +
> +	} while (retry && (status & BIT(0)));
> +
> +	tty_flip_buffer_push(&sport->port);
> +}
> +
> +static void tty_i3c_txwork(struct work_struct *work)
> +{
> +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
> +	struct i3c_priv_xfer xfers;
> +	int retry = I3C_TTY_RETRY;

Detto.

> +	unsigned long flags;
> +	int ret;
> +
> +	xfers.rnw = 0;
> +	xfers.data.out = sport->tx_buff;
> +
> +	while (!kfifo_is_empty(&sport->port.xmit_fifo) && retry) {
> +		xfers.len = kfifo_len(&sport->port.xmit_fifo);
> +		xfers.len = min_t(u16, I3C_TTY_TRANS_SIZE, xfers.len);
> +
> +		xfers.len = kfifo_out_peek(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);

Can this simply be:
xfers.len = kfifo_out_peek(&sport->port.xmit_fifo, sport->tx_buff, 
I3C_TTY_TRANS_SIZE);
?

> +
> +		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> +		if (ret) {
> +			/*
> +			 * Target side may not move data out of FIFO. delay can't resolve problem,
> +			 * just reduce some possiblity. Target can't end I3C SDR mode write
> +			 * transfer, discard data is reasonable when FIFO overrun.
> +			 */
> +			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> +			retry--;
> +		} else {
> +			retry = I3C_TTY_RETRY;
> +			ret = kfifo_out(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);

Just to make sure: xfers.len is nor overwritten by 
i3c_device_do_priv_xfers(), right?

> +		}
> +	}
> +
> +	spin_lock_irqsave(&sport->xlock, flags);

Why do you take the lock here, but not during the kfifo operations above?

> +	if (kfifo_is_empty(&sport->port.xmit_fifo))
> +		complete(&sport->txcomplete);
> +	spin_unlock_irqrestore(&sport->xlock, flags);
> +}

> +static int __init i3c_tty_init(void)
> +{
> +	int ret;
> +
> +	i3c_tty_driver = tty_alloc_driver(I3C_TTY_MINORS,
> +					  TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +
> +	if (IS_ERR(i3c_tty_driver))
> +		return PTR_ERR(i3c_tty_driver);
> +
> +	i3c_tty_driver->driver_name = "ttyI3C";
> +	i3c_tty_driver->name = "ttyI3C";
> +	i3c_tty_driver->minor_start = 0,
> +	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
> +	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
> +	i3c_tty_driver->init_termios = tty_std_termios;
> +	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
> +					       CLOCAL;
> +	i3c_tty_driver->init_termios.c_lflag = 0;
> +
> +	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
> +
> +	ret = tty_register_driver(i3c_tty_driver);
> +	if (ret)
> +		goto err_tty_register_driver;
> +
> +	ret = i3c_driver_register(&i3c_driver);
> +	if (ret)
> +		goto err_i3c_driver_register;
> +
> +	workqueue = alloc_workqueue("ttyI3C", 0, 0);

Can it happen that you already queue something on this wq, while not 
allocated yet? I mean: should this be done first in i3c_tty_init()?

> +	if (!workqueue) {
> +		ret = PTR_ERR(workqueue);
> +		goto err_alloc_workqueue;
> +	}
> +
> +	return 0;
> +
> +err_alloc_workqueue:
> +	i3c_driver_unregister(&i3c_driver);
> +
> +err_i3c_driver_register:
> +	tty_unregister_driver(i3c_tty_driver);
> +
> +err_tty_register_driver:
> +	tty_driver_kref_put(i3c_tty_driver);
> +
> +	return ret;
> +}
> +
> +static void __exit i3c_tty_exit(void)
> +{
> +	i3c_driver_unregister(&i3c_driver);
> +	tty_unregister_driver(i3c_tty_driver);
> +	tty_driver_kref_put(i3c_tty_driver);
> +	idr_destroy(&i3c_tty_minors);

What about the wq?

> +}

regards,
-- 
js
suse labs

