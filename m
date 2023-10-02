Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B57B4C7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjJBHTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjJBHTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:19:32 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8858E;
        Mon,  2 Oct 2023 00:19:29 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so15548961f8f.2;
        Mon, 02 Oct 2023 00:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696231168; x=1696835968;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1U6U3KNDGs0XZSoJYImrlwF6CkKUoqhpnW6EhLbj0A=;
        b=mNb/Kp5ms+QzZhPfH4pbDlxqIIyeqw9Yy18vHyXQjXYxoOcFjepfbXrrRQtmYr7SNs
         OprYkBO/Fqa8vxMt0rf7ETA9SptranaX4UuG3mkTd0SO5lnh5JndF7Z+MdpxyvKywIbJ
         3E4WLYnxgWbVGb7FvH81FN6Vlo8krmpummAIgnEnAK5FNZXVNmfieqoJy0GwRVMQHM8T
         upaCerieLBToP8wda7i0xhgkrxP8npRuw7rKxFkyCXD+GFTpGM32CfnLgL19ND13C/Qs
         wSh9hFvnqRiRKW4d/LZo1qlAFeZrggyZp2EGI29XCXiKjfnRuk3qFXJofsYf3YLF3RbO
         myJg==
X-Gm-Message-State: AOJu0YzgdkDrXFxkVvW6NzmmlIOxN+68iQyIIx7khg0lQZbFNHWfm18q
        Da0OW9XMlTCrja8wM7F0hqBR+K62ncA=
X-Google-Smtp-Source: AGHT+IE8++zQ+yGGlGuFHi36qFmuNS83KeIfcn8yhgDE3hehF+HWw+JfmaMonZGj2cclKvne1FcAMg==
X-Received: by 2002:a5d:500b:0:b0:31f:f1f4:ca8e with SMTP id e11-20020a5d500b000000b0031ff1f4ca8emr9458720wrt.36.1696231167547;
        Mon, 02 Oct 2023 00:19:27 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id c5-20020adfef45000000b00326dd5486dcsm5184647wrp.107.2023.10.02.00.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:19:27 -0700 (PDT)
Message-ID: <92aed0d9-791f-4708-8a73-4c78457a710e@kernel.org>
Date:   Mon, 2 Oct 2023 09:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tty: serial: 8250: Add support for MOXA PCIe boards
 to switch interface between RS422/RS485
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
 <20231002015702.30509-5-crescentcy.hsieh@moxa.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231002015702.30509-5-crescentcy.hsieh@moxa.com>
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
> This patch adds a flag call "SER_RS422_ENALBED" in serial.h and modifies

Hopefully not SER_RS422_ENALBED.

> serial_core.c to make it possible to switch interface between RS232,
> RS422 and RS485.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 41 ++++++++++++++++++++++++++++++
>   drivers/tty/serial/serial_core.c   | 20 ++++++++++++---
>   include/uapi/linux/serial.h        |  4 +++
>   3 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 31bfe5381000..86dce37f08c0 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1898,6 +1898,10 @@ pci_sunix_setup(struct serial_private *priv,
>   
>   #define MOXA_GPIO_SET_ALL_OUTPUT	0x0F
>   
> +static const struct serial_rs485 pci_moxa_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS422_ENABLED,
> +};
> +
>   static int pci_moxa_set_interface(struct pci_dev *dev,
>   				  unsigned int port_idx,
>   				  unsigned char mode)
> @@ -1921,6 +1925,30 @@ static int pci_moxa_set_interface(struct pci_dev *dev,
>   	return 0;
>   }
>   
> +static int pci_moxa_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	struct pci_dev *dev = to_pci_dev(port->dev);
> +	unsigned short device = dev->device;
> +	unsigned char mode = MOXA_RS232;

u8

> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		if (rs485->flags & SER_RS485_RX_DURING_TX)
> +			mode = MOXA_RS485_4W;
> +		else
> +			mode = MOXA_RS485_2W;
> +	} else if (rs485->flags & SER_RS422_ENABLED) {
> +		mode = MOXA_RS422;
> +	} else {
> +		if ((device & 0x0F00) == 0x0300) {

This is the second time you test this. Introduce a function.

> +			pci_warn(dev, "RS232 interface is not supported.");

Don't spam the logs.

> +			return -EINVAL;
> +		}
> +	}

add \n here

> +	return pci_moxa_set_interface(dev, port->line, mode);
> +}
> +
>   static int pci_moxa_init(struct pci_dev *dev)
>   {
>   	unsigned short device = dev->device;
> @@ -1965,9 +1993,22 @@ static int pci_moxa_setup(struct serial_private *priv,
>   			  struct uart_8250_port *port,
>   			  int idx)
>   {
> +	struct pci_dev *dev = priv->dev;
> +	unsigned short device = dev->device;
>   	unsigned int bar = FL_GET_BASE(board->flags);
>   	int offset;
>   
> +	/*
> +	 * For the device IDs of MOXA PCIe boards match the pattern 0x*3** and 0x*1**,
> +	 * these boards support switching interface between RS422/RS485 using TIOCSRS485.
> +	 */
> +	if ((device & 0x0F00) == 0x0100 || (device & 0x0F00) == 0x0300) {

Use helpers.

> +		port->port.rs485_config = pci_moxa_rs485_config;
> +		port->port.rs485_supported = pci_moxa_rs485_supported;
> +
> +		if ((device & 0x0F00) == 0x0300)
> +			port->port.rs485.flags = SER_RE422_ENABLED;
> +	}
>   	if (board->num_ports == 4 && idx == 3)
>   		offset = 7 * board->uart_offset;
>   	else
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 7bdc21d5e13b..f316d9705809 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1299,7 +1299,7 @@ static int uart_get_icount(struct tty_struct *tty,
>   
>   #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
>   				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
> -				 SER_RS485_TERMINATE_BUS)
> +				 SER_RS485_TERMINATE_BUS | SER_RS422_ENALBED)

So have you tested this at all?

> @@ -1365,11 +1365,23 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>   {
>   	u32 supported_flags = port->rs485_supported.flags;
>   
> -	if (!(rs485->flags & SER_RS485_ENABLED)) {
> +	if (!(rs485->flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS422_ENABLED)) {
>   		memset(rs485, 0, sizeof(*rs485));
>   		return;
>   	}
> -
> +	/* Pick sane setting if the user enables both interfaces */
> +	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENABLED) {
> +		dev_warn_ratelimited(port->dev,
> +			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
> +			port->name, port->line);
> +		rs485->flags &= ~(SER_RS422_ENABLED);

No need for parens.

> +	}
> +	/* Clear other bits and return if enalbe RS422 */

enable

> +	if (rs485->flags & SER_RS422_ENABLED) {
> +		memset(rs485, 0, sizeof(*rs485));
> +		rs485->flags |= SER_RS422_ENABLED;
> +		return;
> +	}
>   	/* Pick sane settings if the user hasn't */
>   	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
>   	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> @@ -1394,7 +1406,7 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>   static void uart_set_rs485_termination(struct uart_port *port,
>   				       const struct serial_rs485 *rs485)
>   {
> -	if (!(rs485->flags & SER_RS485_ENABLED))
> +	if (!(rs485->flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS422_ENABLED))
>   		return;
>   
>   	gpiod_set_value_cansleep(port->rs485_term_gpio,
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 53bc1af67a41..427609fd52cb 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -137,6 +137,8 @@ struct serial_icounter_struct {
>    * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>    * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
>    * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
> + *
> + * * %SER_RS422_ENABLED		- RS422 enabled.
>    */
>   struct serial_rs485 {
>   	__u32	flags;
> @@ -149,6 +151,8 @@ struct serial_rs485 {
>   #define SER_RS485_ADDR_RECV		(1 << 7)
>   #define SER_RS485_ADDR_DEST		(1 << 8)
>   
> +#define SER_RS422_ENABLED		(1 << 9)
> +
>   	__u32	delay_rts_before_send;
>   	__u32	delay_rts_after_send;
>   

thanks,
-- 
js
suse labs

