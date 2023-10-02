Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6ED7B4C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjJBHOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjJBHOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:14:40 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E033A4;
        Mon,  2 Oct 2023 00:14:37 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3215f19a13aso16082551f8f.3;
        Mon, 02 Oct 2023 00:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230876; x=1696835676;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3be6umIySU+1cB0812vUQ5iOPpKZmPyZ4S+6w3/9Zw=;
        b=TgGMdhqG3mv3vBxWQlENFlZO4nQGASA0OuHD2+JFhacmgo5sJk7T7a3xl6gqQbbfGE
         6BchY/wQ50Din8ZaFCd9VdOvFrV0TW04dREoyX9QysMD3Tdig0+JzIk4Hadqg6W52Fao
         TiUGJkOYYjttp3yRL03DSONhpUuDsHtqu0us+6Pd19yRQhZusBOC6mSgU7IkzWil6hqj
         lpxxJ+83vcms6G3BWAkT2ZMjMSD/ynkQSBW5mPm8n6/AwU4pmFUfcnw1myQWyacCDw7l
         hFUK/3mqQR690mTsapENYKrz4pqWc+b9V/G/PRuBQJ2Ad23SlG6Zjl4AhnnGbjnuzkXd
         HIBA==
X-Gm-Message-State: AOJu0Ywqitb2FNG8kfelcgnIfm0fi8o7wQ/OWiG1fNNkWLrgGEIYt/Q9
        1CbeMhN61k8Rnw5tSVQTlnM=
X-Google-Smtp-Source: AGHT+IEGKTuRedPGm9URKrutCgw6I00Skmw04Z/CvsntBH9e+lVgB1rdfXmWyti8atvYVt/kCVJo1w==
X-Received: by 2002:adf:fc4c:0:b0:321:63d4:55ca with SMTP id e12-20020adffc4c000000b0032163d455camr9271887wrs.26.1696230875600;
        Mon, 02 Oct 2023 00:14:35 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id u26-20020adfa19a000000b003232d122dbfsm17310546wru.66.2023.10.02.00.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:14:32 -0700 (PDT)
Message-ID: <73a6b0ae-d94e-4a9e-9964-0484c95c8226@kernel.org>
Date:   Mon, 2 Oct 2023 09:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards
 not work by default
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-4-crescentcy.hsieh@moxa.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231002015702.30509-4-crescentcy.hsieh@moxa.com>
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
> MOXA PCIe RS422/RS485 boards will not function by default because of the
> initial default serial interface of all MOXA PCIe boards is set to RS232.
> 
> This patch fixes the problem above by setting the initial default serial
> interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 39 +++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index a70546ac361e..31bfe5381000 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1890,17 +1890,54 @@ pci_sunix_setup(struct serial_private *priv,
>   #define MOXA_PUART_GPIO_EN	0x09
>   #define MOXA_PUART_GPIO_OUT	0x0A
>   
> +#define MOXA_RS232	0x00
> +#define MOXA_RS422	0x01
> +#define MOXA_RS485_4W	0x0B
> +#define MOXA_RS485_2W	0x0F
> +#define MOXA_UIR_OFFSET	0x04
> +
>   #define MOXA_GPIO_SET_ALL_OUTPUT	0x0F
>   
> +static int pci_moxa_set_interface(struct pci_dev *dev,

can it be const?

> +				  unsigned int port_idx,
> +				  unsigned char mode)

u8

> +{
> +	unsigned long iobar_addr = pci_resource_start(dev, 2);

resource_size_t

> +	unsigned long UIR_addr = iobar_addr + MOXA_UIR_OFFSET + (port_idx / 2);

resource_size_t. Why the parentheses?

> +	unsigned char val, intf;

u8

> +	val = inb(UIR_addr);
> +
> +	if (port_idx % 2) {
> +		intf = mode << 4;
> +		val &= 0x0F;
> +	} else {
> +		intf = mode;
> +		val &= 0xF0;
> +	}
> +	val |= intf;

May be better:
   if (port_idx % 2) {
     val &= 0x0F;
     val |= mode << 4;
   } else {
     val &= 0xF0;
     val |= mode;
   }
(no need for intf)?


> +	outb(val, UIR_addr);
> +
> +	return 0;
> +}
> +
>   static int pci_moxa_init(struct pci_dev *dev)
>   {
>   	unsigned short device = dev->device;
>   	unsigned long iobar_addr = pci_resource_start(dev, 2);
> +	int i;

unsigned

>   	int num_ports = (device & 0x00F0) >> 4;

And this one too (in the previous patch).

>   	unsigned char val;
>   
>   	outb(MOXA_GPIO_SET_ALL_OUTPUT, iobar_addr + MOXA_PUART_GPIO_EN);
> -
> +	/*
> +	 * For the device IDs of MOXA PCIe boards match the pattern 0x*3**,
> +	 * the initial default serial interface mode should be set to RS422.
> +	 */
> +	if ((device & 0x0F00) == 0x0300) {
> +		for (i = 0; i < num_ports; ++i)
> +			pci_moxa_set_interface(dev, i, MOXA_RS422);
> +	}
>   	/*
>   	 * Enable hardware buffer to prevent break signal output when system boot up.
>   	 * This hardware buffer is only supported on Mini PCIe series.

-- 
js
suse labs

