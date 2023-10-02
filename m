Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C67B4C32
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjJBHFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjJBHFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:05:38 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49A9F;
        Mon,  2 Oct 2023 00:05:34 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-313e742a787so1586169f8f.1;
        Mon, 02 Oct 2023 00:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230333; x=1696835133;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJm2q62qrX+iVKV047NAIq/AT9zmpWfhQyKoz3ijfZc=;
        b=HmP8blnRrSqfCvWJPwwERtj6zLg1wLuMFwkbbXOdwpS9XXGOsbAPEgx5aHrx7hIUFL
         VfXimrELvSmN96AJ55nZ6aciwGNrkr+03/+MtuB9Z1uQNZD0BmbiVLsFdpMa3FElXgAE
         sxk6s3Kq2MxnIl83PrTVeo2G1R8trYrx4t0lP/o7ziKPk4sELG5l286nr+betWneRhLW
         d7zO64CffamQkdLfTjn1yWxWdzT8p1P6l5p5E1eQaPHop15ocduLKabwOVGWd83NlD9y
         wi8JpnnHTkw9BISpJx4h7r/SwaUVo+xFyCb16Ypt4KrbxRMhMbq5zUIUY3Ip56lxr/M4
         eRUQ==
X-Gm-Message-State: AOJu0Yxp1zjvrqfej5rbD/3otD5I9naJFMol5IjKgZ9Wl29cDiRJv7+A
        usOpTcmKVA5gegvH8jo9r9Y=
X-Google-Smtp-Source: AGHT+IEGiYyCaiN05UrOJ84WRbR1OgpnTt7aoiVG41JK/MPzsnTIYmknQOjgw0Fe+3SeUzPlAlJMYA==
X-Received: by 2002:a5d:6a11:0:b0:324:84bc:d5ab with SMTP id m17-20020a5d6a11000000b0032484bcd5abmr9068418wru.1.1696230332822;
        Mon, 02 Oct 2023 00:05:32 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id f21-20020a1c6a15000000b0040641a9d49bsm6550512wmc.17.2023.10.02.00.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:05:32 -0700 (PDT)
Message-ID: <1e99f3c4-e0b8-4951-80c3-f3c5a1eb5277@kernel.org>
Date:   Mon, 2 Oct 2023 09:05:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tty: serial: 8250: Add support for MOXA Mini PCIe
 boards
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-3-crescentcy.hsieh@moxa.com>
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
In-Reply-To: <20231002015702.30509-3-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 10. 23, 3:57, Crescent CY Hsieh wrote:
> Add support for MOXA Mini PCIe serial boards:
> 
> - CP102N: 2 ports | RS232
> - CP104N: 4 ports | RS232
> - CP112N: 2 ports | RS232/RS422/RS485
> - CP114N: 4 ports | RS232/RS422/RS485
> - CP132N: 2 ports | RS422/RS485
> - CP134N: 4 ports | RS422/RS485
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 54 ++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index a010790ccfcd..a70546ac361e 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1887,6 +1887,42 @@ pci_sunix_setup(struct serial_private *priv,
>   	return setup_port(priv, port, bar, offset, 0);
>   }
>   
> +#define MOXA_PUART_GPIO_EN	0x09
> +#define MOXA_PUART_GPIO_OUT	0x0A
> +
> +#define MOXA_GPIO_SET_ALL_OUTPUT	0x0F
> +
> +static int pci_moxa_init(struct pci_dev *dev)
> +{
> +	unsigned short device = dev->device;
> +	unsigned long iobar_addr = pci_resource_start(dev, 2);

resource_size_t

> +	int num_ports = (device & 0x00F0) >> 4;
> +	unsigned char val;

u8

> +
> +	outb(MOXA_GPIO_SET_ALL_OUTPUT, iobar_addr + MOXA_PUART_GPIO_EN);

You need to comment in the commit log why this doesn't matter for other 
moxa cards.

> +	/*
> +	 * Enable hardware buffer to prevent break signal output when system boot up.

boots up.

> +	 * This hardware buffer is only supported on Mini PCIe series.
> +	 */
> +	if (device == 0x1027 ||	/* MOXA_CP102N */
> +	    device == 0x1046 ||	/* MOXA_CP104N */
> +	    device == 0x1121 ||	/* MOXA_CP112N */
> +	    device == 0x1145 ||	/* MOXA_CP114N */
> +	    device == 0x1323 ||	/* MOXA_CP132N */
> +	    device == 0x1343) {	/* MOXA_CP134N */

Why not use the definitions below? You should define a function for this 
anyway.

> +		/* Set GPIO direction */
> +		val = inb(iobar_addr + MOXA_PUART_GPIO_EN);
> +		val |= (1 << 2);

Too magic constant. Use BIT() and define that 2 as some constant.

> +		outb(val, iobar_addr + MOXA_PUART_GPIO_EN);
> +		/* Enable low GPIO */
> +		val = inb(iobar_addr + MOXA_PUART_GPIO_OUT);
> +		val &= ~(1 << 2);
> +		outb(val, iobar_addr + MOXA_PUART_GPIO_OUT);
> +	}

One more \n here.

> +	return num_ports;
> +}
> +
>   static int pci_moxa_setup(struct serial_private *priv,
>   			  const struct pciserial_board *board,
>   			  struct uart_8250_port *port,
> @@ -1973,6 +2009,13 @@ static int pci_moxa_setup(struct serial_private *priv,
>   #define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
>   #define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
>   #define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
> +/* MOXA Mini PCIe */
> +#define PCI_DEVICE_ID_MOXA_CP102N	0x1027
> +#define PCI_DEVICE_ID_MOXA_CP104N	0x1046
> +#define PCI_DEVICE_ID_MOXA_CP112N	0x1121
> +#define PCI_DEVICE_ID_MOXA_CP114N	0x1145
> +#define PCI_DEVICE_ID_MOXA_CP132N	0x1323
> +#define PCI_DEVICE_ID_MOXA_CP134N	0x1343

I am not sure it matters they are mini PCIe. I would sort them into the 
above preexisting list instead.

>   
>   /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
>   #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
> @@ -2638,6 +2681,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
>   		.device		= PCI_ANY_ID,
>   		.subvendor	= PCI_ANY_ID,
>   		.subdevice	= PCI_ANY_ID,
> +		.init		= pci_moxa_init,
>   		.setup		= pci_moxa_setup,
>   	},
>   	{
> @@ -5365,6 +5409,16 @@ static const struct pci_device_id serial_pci_tbl[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),	 0, 0, pbn_moxa_8 },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),	 0, 0, pbn_moxa_8 },
>   
> +	/*
> +	 * MOXA Mini PCIe
> +	 */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102N), 0, 0, pbn_moxa_2 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104N), 0, 0, pbn_moxa_4 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP112N), 0, 0, pbn_moxa_2 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114N), 0, 0, pbn_moxa_4 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132N), 0, 0, pbn_moxa_2 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134N), 0, 0, pbn_moxa_4 },

PCI_VDEVICE() again?

thanks,
-- 
js
suse labs

