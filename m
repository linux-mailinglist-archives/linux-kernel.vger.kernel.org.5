Return-Path: <linux-kernel+bounces-52169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0A8494E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B031F230E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466710A34;
	Mon,  5 Feb 2024 07:56:51 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44111190;
	Mon,  5 Feb 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119811; cv=none; b=TpOSvVOCeaLPTpGSJ8sdnZikbXK35WP/GOSeJykokZ+U0O2J6KaMHYLP1YPzY9Gkf/+ZJWEaMfI6HuIzmsdk9v53qlgxtIywpG4oFjhDENTnZ4W0sYsSDVlp4kryYMmosraNTjJIKitVscioBsrF8kigDr673b9MHDb3pKacj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119811; c=relaxed/simple;
	bh=bPBYHKOWAsw++0GbpcEfc945iVVSf64BuOwoMrpaGWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2tkXAD3LuIGztUeu2d6fFwVP5h3HZ7lQIL6FURgcuqveIweT1IJ0QuDx1lVSoAlHvOCw/vk/RycFc/Vw0xs7eCU5FBLPft7t6gKeVAo9gwGWbAJHcqkyJWwzf+/3ZBi3MRga8+ViSpiG4wFtqOJsGqYDSyFE5Nh8hrahbAcP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso1948288a12.2;
        Sun, 04 Feb 2024 23:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707119807; x=1707724607;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVcEqSZHQEPAF31Myvz/o3YQCpmBhb8/EGABHphGLK4=;
        b=TLDL7kvBh9ePkqKW0NHPOmwkRuVp2oNnrQ9geUnLpECUwESyLi/I4mGSM/3OXd4qSF
         j9jUrdr1cRAYH0mDuFke9pt8dTAu+u9fmiZWBoqDWT2O5T+reyIWfGPw9xdr7LUZSBdz
         hZECBG8ktO89OUrA8qTVS6JtTmXV9y4nVB1Wo5C0DieNlIQCJh47bxWDn0UHbIhR3QUb
         XKdJiM7m2vA3deog5IT4X0SStbIVMIVUA6DtOZFjqIKeLobD6oytXu11H/BHs5ANHGFK
         4ZxZmZRyN5W0U5MvY4sRs0HuxCxz6E1Bzs3NERujLNSBJvfk9ThLjyLVUT3b/Fezrbpk
         aAjw==
X-Gm-Message-State: AOJu0Yz+gmU5pKvYmM/sDB7GJnPjcwyy/6ExCTjyocqoRpli2Y1vHcli
	Ras0ocIJ7V4L9597uZGVlIymMqrCZWPdIaFAjkoT5cbk3qEcjx7rgbtB/pKndlc=
X-Google-Smtp-Source: AGHT+IHgx4a0xU/ZJI1tnxm70XzfGnbd44dk0xPkLOAYvihUUHsDslqceMnZqJ9Q0ExdsptqusWGTw==
X-Received: by 2002:a05:6402:12ca:b0:55e:b943:6277 with SMTP id k10-20020a05640212ca00b0055eb9436277mr4259119edx.22.1707119807042;
        Sun, 04 Feb 2024 23:56:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPAohRc6POrdHQc/hxOL9s8G0pPpSW/ZVv2js1BnhaK7iOQmTDXN2C3i9Exufs13XeMEL72ER1oOmu+EZ3ZVd8lOjKVVaLw4RO+wE0w1wt3u3OdGGAYm/Y1OqXiVaL0vK9ilLRdd04Rk+ZwjHo1UlU6J96yHpRdXKR8gYhrlaJ5765n5TJFrcu8cYNz3NgkNEzgG0PoHImCaSWzTfKvwcudw+MtDKnuoHLKw2iOFNqDQ4JS49rFlolVTqFrxDXevUREEGlwBfVtKtDeSaDn4spEg==
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id d17-20020aa7d5d1000000b0055eed463c4fsm3515104eds.84.2024.02.04.23.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 23:56:46 -0800 (PST)
Message-ID: <b8325c3f-bf5b-4c55-8dce-ef395edce251@kernel.org>
Date: Mon, 5 Feb 2024 08:56:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Add Burst mode
 transmission support in uart driver for reading from FIFO
Content-Language: en-US
To: Rengarajan S <rengarajan.s@microchip.com>,
 kumaravel.thiagarajan@microchip.com, tharunkumar.pasumarthi@microchip.com,
 gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: UNGLinuxDriver@microchip.com
References: <20240125100006.153342-1-rengarajan.s@microchip.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240125100006.153342-1-rengarajan.s@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 01. 24, 11:00, Rengarajan S wrote:
> pci1xxxx_handle_irq reads the burst status and checks if the FIFO
> is empty and is ready to accept the incoming data. The handling is
> done in pci1xxxx_tx_burst where each transaction processes data in
> block of DWORDs, while any remaining bytes are processed individually,
> one byte at a time.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
> ---
>   drivers/tty/serial/8250/8250_pci1xxxx.c | 106 ++++++++++++++++++++++++
>   1 file changed, 106 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 558c4c7f3104..d53605bf908d 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
..
> @@ -344,6 +348,105 @@ static void pci1xxxx_rx_burst(struct uart_port *port, u32 uart_status)
>   	}
>   }
>   
> +static void pci1xxxx_process_write_data(struct uart_port *port,
> +					struct circ_buf *xmit,
> +					int *data_empty_count,

count is unsigned, right?

> +					u32 *valid_byte_count)
> +{
> +	u32 valid_burst_count = *valid_byte_count / UART_BURST_SIZE;
> +
> +	/*
> +	 * Each transaction transfers data in DWORDs. If there are less than
> +	 * four remaining valid_byte_count to transfer or if the circular
> +	 * buffer has insufficient space for a DWORD, the data is transferred
> +	 * one byte at a time.
> +	 */
> +	while (valid_burst_count) {
> +		if (*data_empty_count - UART_BURST_SIZE < 0)

Huh?

*data_empty_count < UART_BURST_SIZE

instead?

> +			break;
> +		if (xmit->tail > (UART_XMIT_SIZE - UART_BURST_SIZE))

Is this the same as easy to understand:

CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE) < UART_BURST_SIZE

?

> +			break;
> +		writel(*(unsigned int *)&xmit->buf[xmit->tail],
> +		       port->membase + UART_TX_BURST_FIFO);

What about unaligned accesses?

And you really wanted to spell u32 explicitly, not uint.

> +		*valid_byte_count -= UART_BURST_SIZE;
> +		*data_empty_count -= UART_BURST_SIZE;
> +		valid_burst_count -= UART_BYTE_SIZE;
> +
> +		xmit->tail = (xmit->tail + UART_BURST_SIZE) &
> +			     (UART_XMIT_SIZE - 1);

uart_xmit_advance()

> +	}
> +
> +	while (*valid_byte_count) {
> +		if (*data_empty_count - UART_BYTE_SIZE < 0)
> +			break;
> +		writeb(xmit->buf[xmit->tail], port->membase +
> +		       UART_TX_BYTE_FIFO);
> +		*data_empty_count -= UART_BYTE_SIZE;
> +		*valid_byte_count -= UART_BYTE_SIZE;
> +
> +		/*
> +		 * When the tail of the circular buffer is reached, the next
> +		 * byte is transferred to the beginning of the buffer.
> +		 */
> +		xmit->tail = (xmit->tail + UART_BYTE_SIZE) &
> +			     (UART_XMIT_SIZE - 1);

uart_xmit_advance()

> +
> +		/*
> +		 * If there are any pending burst count, data is handled by
> +		 * transmitting DWORDs at a time.
> +		 */
> +		if (valid_burst_count && (xmit->tail <
> +		   (UART_XMIT_SIZE - UART_BURST_SIZE)))
> +			break;
> +	}
> +}

This nested double loop is _really_ hard to follow. It's actually 
terrible with cut & paste mistakes.

Could these all loops be simply replaced by something like this pseudo 
code (a single loop):

while (data_empty_count) {
   cnt = CIRC_CNT_TO_END();
   if (!cnt)
     break;
   if (cnt < UART_BURST_SIZE || (tail & 3)) { // is_unaligned()
     writeb();
     cnt = 1;
   } else {
     writel()
     cnt = UART_BURST_SIZE;
   }
   uart_xmit_advance(cnt);
   data_empty_count -= cnt;
}

?


> +static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	u32 valid_byte_count;
> +	int data_empty_count;
> +	struct circ_buf *xmit;
> +
> +	xmit = &port->state->xmit;
> +
> +	if (port->x_char) {
> +		writeb(port->x_char, port->membase + UART_TX);
> +		port->icount.tx++;
> +		port->x_char = 0;
> +		return;
> +	}
> +
> +	if ((uart_tx_stopped(port)) || (uart_circ_empty(xmit))) {
> +		port->ops->stop_tx(port);

This looks weird standing here. You should handle this below along with RPM.

> +	} else {

The condition should be IMO inverted with this block in its body:

> +		data_empty_count = (pci1xxxx_read_burst_status(port) &
> +				    UART_BST_STAT_TX_COUNT_MASK) >> 8;
> +		do {
> +			valid_byte_count = uart_circ_chars_pending(xmit);
> +
> +			pci1xxxx_process_write_data(port, xmit,
> +						    &data_empty_count,
> +						    &valid_byte_count);
> +
> +			port->icount.tx++;

Why do you increase the stats only once per burst? (Solved by 
uart_xmit_advance() above.)

> +			if (uart_circ_empty(xmit))
> +				break;
> +		} while (data_empty_count && valid_byte_count);
> +	}
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	 /*
> +	  * With RPM enabled, we have to wait until the FIFO is empty before
> +	  * the HW can go idle. So we get here once again with empty FIFO and
> +	  * disable the interrupt and RPM in __stop_tx()
> +	  */
> +	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
> +		port->ops->stop_tx(port);

I wonder why this driver needs this and others don't? Should they be 
fixed too?

> +}
> +
>   static int pci1xxxx_handle_irq(struct uart_port *port)
>   {
>   	unsigned long flags;
> @@ -359,6 +462,9 @@ static int pci1xxxx_handle_irq(struct uart_port *port)
>   	if (status & UART_BST_STAT_LSR_RX_MASK)
>   		pci1xxxx_rx_burst(port, status);
>   
> +	if (status & UART_BST_STAT_LSR_THRE)
> +		pci1xxxx_tx_burst(port, status);
> +
>   	spin_unlock_irqrestore(&port->lock, flags);
>   
>   	return 1;

-- 
js
suse labs


