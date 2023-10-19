Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DDF7CF00E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjJSGY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSGY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:24:57 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FE1BE;
        Wed, 18 Oct 2023 23:24:55 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40651a726acso66250085e9.1;
        Wed, 18 Oct 2023 23:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697696693; x=1698301493;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8PRDTflJ4UXV9ZO5LwnSfS1FDe1mCJ5OgI2BICQvko=;
        b=qm38wYePl6hsJri1oz8yAPZcz9xDaJ1MCWp8glycoCCxM6ygbEmZWQykruGnEXuyYF
         x/OSjoeZyLp5+3qhqlCqR9nF7wPxaJZX2DLTkxRpZp0BbuAhX+KSDRjue+Yl9AEqpaH1
         VaeBeuchvNfxakkfEpepQQe60+w5kx/bYrPNDWpDst9ws6Z+5WFZSKp9gJcR1esDu5Yc
         XFLDpGwVU98hBuxRJ9o1KGiqtsPX7e1ouRX1QgRBWOKgns0LLtrdIaimR5mLOkQNZa3x
         iyUlQtcjJ5IJ6r/TuY4ddQnHzpeHj/E3HeLyYA14u7ABddDjZ14/4PA6Bs/NZwDGaLEM
         imcQ==
X-Gm-Message-State: AOJu0YwMbsLfoNtzBABYsJSwGFrU4YNQZWrxwq1O1IV1W/DHF4HzyxYK
        jLlG96DQyyM1I+EVmV2Q9xrJw2DuNvU=
X-Google-Smtp-Source: AGHT+IEa7r+HIe6pIlJmzEQkPR8sQKSQM4tEeenIJ9CDGHlJDZYyWE31Nrlcr+F2vYZoEJr6XNFtEg==
X-Received: by 2002:a05:6000:1112:b0:32d:8958:c570 with SMTP id z18-20020a056000111200b0032d8958c570mr780548wrw.29.1697696693434;
        Wed, 18 Oct 2023 23:24:53 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id g15-20020adfe40f000000b0032d88e370basm3711853wrm.34.2023.10.18.23.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 23:24:53 -0700 (PDT)
Message-ID: <59728ca9-cf2b-452d-b24c-1ee1e31a1f04@kernel.org>
Date:   Thu, 19 Oct 2023 08:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] tty: serial: 8250: Add support for MOXA PCIe
 boards to switch interface between RS422/RS485
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
 <20231018091739.10125-7-crescentcy.hsieh@moxa.com>
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
In-Reply-To: <20231018091739.10125-7-crescentcy.hsieh@moxa.com>
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

On 18. 10. 23, 11:17, Crescent CY Hsieh wrote:
> MOXA PCIe boards have 4 serial interfaces and don't require additional
> stuff to switch between interfaces:
> 
> - RS232
> - RS422
> - RS485_2W (half-duplex)
> - RS485_4W (full-duplex)
> 
> By using ioctl command "TIOCRS485", it can switch between default
> interface and RS485 if supported.
> 
> That means, for RS422/RS485 board, it can switch between RS422 and
> RS485 by setting the flags within struct serial_rs485.
> 
> However, for the RS232/RS422/RS485 board, it can only switch between
> RS232 and RS485, there's no flag for switching interface into RS422.
> 
> This patch uses "SER_RS485_TERMINATE_BUS" to represent RS422 as a
> workaround solution:
> 
> - RS232                   = (no flags are set)
> - RS422                   = SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS
> - RS485_2W (half-duplex)  = SER_RS485_ENABLED
> - RS485_4W (full-duplex)  = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 58 ++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 29a28e72b..098ac466b 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1974,6 +1974,10 @@ pci_sunix_setup(struct serial_private *priv,
>   #define MOXA_RS485_2W	0x0F
>   #define MOXA_UIR_OFFSET	0x04
>   
> +static const struct serial_rs485 pci_moxa_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
> +};
> +
>   static bool pci_moxa_is_mini_pcie(unsigned short device)
>   {
>   	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
> @@ -2024,6 +2028,46 @@ static int pci_moxa_set_interface(const struct pci_dev *dev,
>   	return 0;
>   }
>   
> +/*
> + * MOXA PCIe boards support switching the serial interface using the ioctl
> + * command "TIOCSRS485", but there is currently no dedicated flag for switching
> + * to RS422. As a workaround, we utilize the "SER_RS485_TERMINATE_BUS" flag to
> + * represent RS422.
> + *
> + *	RS232			= (no flags are set)
> + *	RS422			= SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS
> + *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
> + *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
> + */
> +static int pci_moxa_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	struct pci_dev *dev = to_pci_dev(port->dev);
> +	unsigned short device = dev->device;
> +	u8 mode = MOXA_RS232;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		if (rs485->flags & SER_RS485_TERMINATE_BUS) {
> +			mode = MOXA_RS422;
> +		} else {
> +			if (rs485->flags & SER_RS485_RX_DURING_TX)
> +				mode = MOXA_RS485_4W;
> +			else
> +				mode = MOXA_RS485_2W;
> +		}
> +	} else {
> +		/*
> +		 * RS232 is not supported for MOXA PCIe boards with device IDs
> +		 * matching the pattern 0x*3**.
> +		 */
> +		if (pci_moxa_match_second_digit(device, 0x0300))

The same here:
if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))

> +			return -EOPNOTSUPP;
> +	}
> +
> +	return pci_moxa_set_interface(dev, port->port_id, mode);
> +}
> +
>   static int pci_moxa_init(struct pci_dev *dev)
>   {
>   	unsigned short device = dev->device;
> @@ -2063,9 +2107,23 @@ pci_moxa_setup(struct serial_private *priv,
>   		const struct pciserial_board *board,
>   		struct uart_8250_port *port, int idx)
>   {
> +	struct pci_dev *dev = priv->dev;
> +	unsigned short device = dev->device;
>   	unsigned int bar = FL_GET_BASE(board->flags);
>   	int offset;
>   
> +	/*
> +	 * For the device IDs of MOXA PCIe boards match the pattern 0x*1** and 0x*3**,
> +	 * these boards support switching interface between RS422/RS485 using TIOCSRS485.
> +	 */
> +	if (pci_moxa_match_second_digit(device, 0x0100) ||
> +	    pci_moxa_match_second_digit(device, 0x0300)) {

if (pci_moxa_supported_rs(dev) & (MOXA_SUPP_RS422 | MOXA_SUPP_RS485) ==
     MOXA_SUPP_RS422 | MOXA_SUPP_RS485)

or maybe even simple:

if (pci_moxa_supported_rs(dev) & MOXA_SUPP_RS485)
?

> +		port->port.rs485_config = pci_moxa_rs485_config;
> +		port->port.rs485_supported = pci_moxa_rs485_supported;
> +
> +		if (pci_moxa_match_second_digit(device, 0x0300))

if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))

> +			port->port.rs485.flags |= SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS;
> +	}
>   	if (board->num_ports == 4 && idx == 3)
>   		offset = 7 * board->uart_offset;
>   	else

-- 
js
suse labs

