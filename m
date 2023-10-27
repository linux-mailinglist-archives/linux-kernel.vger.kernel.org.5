Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F77D918B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjJ0I3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjJ0I3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:29:46 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288801BE;
        Fri, 27 Oct 2023 01:29:42 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c5071165d5so22086461fa.0;
        Fri, 27 Oct 2023 01:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698395380; x=1699000180;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stJbb23w3VUqP0eHkdL98f2jZhQvcq9EYPxztKnA6VY=;
        b=VPrAr06OoUv+izTP6JFnd3aqFzGoVfW+XFE9VaWIESad/uJ7ubM0+aipB4mkgbbAZp
         Pe/HnQtd1MYaiozDbFQXj/d151ir7J1uSBf2BeNKrRYb+x7cKkJaWgVGxGyM9eA6sieA
         FvD+TVuZxgw644eb+XXoVWLToRgI4KXPLuhfJOMNkaES+UhPtxmqo1SPdgsInhVed2kL
         iZJKWyrL5KkhALmKCw6khebstE5c5b6sd0rUTJalzyhpnYWuDWyzjAZl17mv/KDYlWTg
         5E6M3f/lye24dY6nQp93kKF3xRegFxeSJM1bgOuBQQ7n7geFwYkNVMZthbIBey0iTjYp
         HwaQ==
X-Gm-Message-State: AOJu0YznJjuttF6XYwSL+PLxImspFlVwn7mk4axFmjwbz4aBOy9D0A2W
        eeCotNCXIvDoUr19eNLd1eI=
X-Google-Smtp-Source: AGHT+IFAj3Y6IG4ZWvAYqebBD+zyEarmRzLf/EZHCsiRr1qFHDFKzdzKc6zpyG0CGQgWF/u5ROm9aQ==
X-Received: by 2002:a2e:a167:0:b0:2c5:12ae:adb3 with SMTP id u7-20020a2ea167000000b002c512aeadb3mr1517585ljl.44.1698395380014;
        Fri, 27 Oct 2023 01:29:40 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id bg9-20020a05600c3c8900b004063cd8105csm4602183wmb.22.2023.10.27.01.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 01:29:39 -0700 (PDT)
Message-ID: <37a5e055-93b5-4f05-bcca-4caa5ed6f97f@kernel.org>
Date:   Fri, 27 Oct 2023 10:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tty: serial: 8250: Add support for MOXA PCIe boards
 to switch interface
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231027062440.7749-1-crescentcy.hsieh@moxa.com>
 <20231027062440.7749-3-crescentcy.hsieh@moxa.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231027062440.7749-3-crescentcy.hsieh@moxa.com>
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

On 27. 10. 23, 8:24, Crescent CY Hsieh wrote:
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

It's not "ENALBED".

Anyway, I am afraid you have to split the patch into two:
1) add the flag and core support (but wait a bit for others if they 
agree with this approach)
2) add the support for moxa.

> serial_core.c to make it possible to switch interface between RS232,
> RS422 and RS485.
...
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c

> @@ -2032,6 +2036,37 @@ static int pci_moxa_set_interface(const struct pci_dev *dev,
>   	return 0;
>   }
>   
> +/*
> + * MOXA PCIe boards support switching the serial interface using the ioctl
> + * command "TIOCSRS485".
> + *
> + *	RS232			= (no flags are set)
> + *	RS422			= SER_RS422_ENABLED
> + *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
> + *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
> + */
> +static int pci_moxa_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	struct pci_dev *dev = to_pci_dev(port->dev);
> +	u8 mode = MOXA_RS232;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		if (rs485->flags & SER_RS485_RX_DURING_TX)
> +			mode = MOXA_RS485_4W;
> +		else
> +			mode = MOXA_RS485_2W;
> +	} else if (rs485->flags & SER_RS422_ENABLED) {
> +		mode = MOXA_RS422;
> +	} else {
> +		if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
> +			return -ENODEV;
> +	}
> +
> +	return pci_moxa_set_interface(dev, port->port_id, mode);

Looks good to me now.

> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1305,7 +1305,7 @@ static int uart_get_icount(struct tty_struct *tty,
>   
>   #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
>   				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
> -				 SER_RS485_TERMINATE_BUS)
> +				 SER_RS485_TERMINATE_BUS | SER_RS422_ENABLED)
>   
>   static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *rs485)
>   {
> @@ -1371,11 +1371,26 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>   {
>   	u32 supported_flags = port->rs485_supported.flags;
>   
> -	if (!(rs485->flags & SER_RS485_ENABLED)) {
> +	if (!(rs485->flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS422_ENABLED)) {

maybe easier:
   if (!(rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED))) {
?

>   		memset(rs485, 0, sizeof(*rs485));
>   		return;
>   	}
>   
> +	/* Pick sane setting if the user enables both interfaces */
> +	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENABLED) {
> +		dev_warn_ratelimited(port->dev,
> +			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
> +			port->name, port->line);
> +		rs485->flags &= ~(SER_RS422_ENABLED);

No need for parens.

> +	}
> +
> +	/* Clear other bits and return if enable RS422 */

"if RS422 is enabled"
or
"if enabling RS422"

> +	if (rs485->flags & SER_RS422_ENABLED) {
> +		memset(rs485, 0, sizeof(*rs485));
> +		rs485->flags |= SER_RS422_ENABLED;
> +		return;
> +	}
> +
>   	/* Pick sane settings if the user hasn't */
>   	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
>   	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> @@ -1400,7 +1415,7 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>   static void uart_set_rs485_termination(struct uart_port *port,
>   				       const struct serial_rs485 *rs485)
>   {
> -	if (!(rs485->flags & SER_RS485_ENABLED))
> +	if (!(rs485->flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS422_ENABLED))

if (!(rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED))) {

thanks,
-- 
js
suse labs

