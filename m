Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F917CEFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjJSGQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjJSGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:16:37 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4254132;
        Wed, 18 Oct 2023 23:16:34 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4084095722aso8988315e9.1;
        Wed, 18 Oct 2023 23:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697696193; x=1698300993;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ica4N+7RyNmpGN1N9IQavbgkqo3Q/yk+TeBHBZrgDl8=;
        b=i0CeCKuCbBoEZTgaGjx6h3/eKlbgthhnnKo2V0PcrBGcBzuBA1f3u25OPxwxn5HvAa
         REBt3KZW2t/4qgTmkeNAQ6rh0orJxo6AktWRO27wRPJx3beKcBxCLb2SEyvDKQC18GhE
         la8GBAAXAku8qi7hxv/F3eMbVcpB8aDW1simSJ1X24ihOdeU5YzLa70IhbCeVQUuNBYA
         8llLCfVBnnX6gUrd+CtAo23F5NPu/0RK4A49YSeAmPpf6VNaG9s+MK2aReHsnvCWY65w
         bgDljJDqk8iiVMMqV9SFuY1DP661p2/KGRl7wGUbKdaE8SufDn5dDj8zO7tryw8Zuubw
         7Wcw==
X-Gm-Message-State: AOJu0YxqY+cS9EEu3BU7cw/cjGlwh/tFhVQHwDdGh8DNkd+jhLej7Nbn
        xxRXOylbrl4xvlu8lbsk74clVNkd0d8=
X-Google-Smtp-Source: AGHT+IFz5sUqzcw72tGieUVEHkq5LBETTpLD9yrV4N9LdiR/WLBUEpfhP1ETmResaEU/yzUt588wOA==
X-Received: by 2002:adf:f4c9:0:b0:32d:b2e0:ed76 with SMTP id h9-20020adff4c9000000b0032db2e0ed76mr897229wrp.49.1697696192921;
        Wed, 18 Oct 2023 23:16:32 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b003233b554e6esm3645177wrx.85.2023.10.18.23.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 23:16:32 -0700 (PDT)
Message-ID: <935b5603-2e86-4d19-af50-d8833f9d8c41@kernel.org>
Date:   Thu, 19 Oct 2023 08:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe
 boards not work by default
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
 <20231018091739.10125-6-crescentcy.hsieh@moxa.com>
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
In-Reply-To: <20231018091739.10125-6-crescentcy.hsieh@moxa.com>
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

On 18. 10. 23, 11:17, Crescent CY Hsieh wrote:
> MOXA PCIe RS422/RS485 boards will not function by default because of the
> initial default serial interface of all MOXA PCIe boards is set to RS232.
> 
> This patch fixes the problem above by setting the initial default serial
> interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 52 ++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index b2be3783f..29a28e72b 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
...
> @@ -1981,13 +1987,59 @@ static bool pci_moxa_is_mini_pcie(unsigned short device)
>   	return false;
>   }
>   
> +/*
> + * The second digit of the MOXA PCIe device ID in hexadecimal indicates
> + * which serial interface modes this board supports:
> + *
> + *	0x*0** - RS232
> + *	0x*1** - RS232/RS422/RS485
> + *	0x*3** - RS422/RS485
> + *	0x*6** - RS232
> + */
> +static bool pci_moxa_match_second_digit(unsigned short device,
> +					unsigned short pattern)
> +{
> +	return (device & 0x0F00) == pattern;
> +}

Actually, would it make sense to define the below instead:

enum {
    MOXA_SUPP_RS232 = BIT(0),
    MOXA_SUPP_RS422 = BIT(1),
    MOXA_SUPP_RS485 = BIT(2),
};

u32 pci_moxa_supported_rs(struct pci_dev *dev)
{
    switch (dev->device & 0x0f00) {
    case 0x0000:
    case 0x0600: // or default: ???
      return MOXA_SUPP_RS232;
    case 0x0100:
      return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
    case 0x0300:
      return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
    }

    return 0;
}

...
>   static int pci_moxa_init(struct pci_dev *dev)
>   {
>   	unsigned short device = dev->device;
>   	resource_size_t iobar_addr = pci_resource_start(dev, 2);
> +	unsigned int i;
>   	unsigned int num_ports = (device & 0x00F0) >> 4;
>   	u8 val;
>   
> +	/*
> +	 * For the device IDs of MOXA PCIe boards match the pattern 0x*3**,
> +	 * the initial default serial interface mode should be set to RS422.
> +	 */
> +	if (pci_moxa_match_second_digit(device, 0x0300)) {

And here:
if (pci_moxa_supported_rs(dev) == MOXA_SUPP_RS422 | MOXA_SUPP_RS485)

or perhaps:
if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
?

> +		for (i = 0; i < num_ports; ++i)
> +			pci_moxa_set_interface(dev, i, MOXA_RS422);
> +	}
>   	/*
>   	 * Enable hardware buffer to prevent break signal output when system boots up.
>   	 * This hardware buffer is only supported on Mini PCIe series.

-- 
js
suse labs

