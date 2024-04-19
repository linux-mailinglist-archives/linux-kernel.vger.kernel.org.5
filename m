Return-Path: <linux-kernel+bounces-151021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E18AA809
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CB71C20E54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D03BE5A;
	Fri, 19 Apr 2024 05:45:10 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C9BE49;
	Fri, 19 Apr 2024 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505509; cv=none; b=Q4XSpDhTha7pW7U1d6snMIi0kPRRbjpNRux71z+OPSzjoqGQdei28Gy0R1i1qn2NFnUfBpbKHoz9+xv8Ska7xm4KLSkD7gES2zmRr89BCs3HngUglBAKPvdxQG4FLRRT2a2sxFUBhBlRdBxooZU5nWjwf0Q212gkJ+H7bQTnyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505509; c=relaxed/simple;
	bh=rh1pnq0wAHeiN0BizArHWgSh/qi7Tm3cN2bw41OzXlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cf//OMb6yirzNFCPaLyKgRZkF2qnJdKDaoYJuo2PfE2ksPxqlWkR0dMKrk5iVNHobIx8mxeLWy8baUfGlqskRSEEYc1fDlpD4qrA2xqbwjAIsHRSjlFYaKMjoSef9u4Cf0HeKofJp6c5Z1Jk0XTDywVeRF9m0mfuxoUzvIz8iFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a55602507a9so190801166b.3;
        Thu, 18 Apr 2024 22:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713505506; x=1714110306;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx9GPlZFmNFO6IN0jAsuyE0mf6S3h8zFagHqKXxGM0o=;
        b=dj/yMySrZjcQ4qK1TBA8Rg8zy3iji93PeBCy/Pl/AuyTeajspndQg9G0aghlx8RJVb
         qzIxq2WF99bx4MBmxFstUVDxa85j0GQlAu0nY1tizegO7CSkmMAYbPLY+7L78rC/wo1F
         2kpzEh3XJ9HnWDhuWzqTUfpIUGHmranQzIQORy1DNRyTugAWX9pRGSQ0Vs8WnQ44dk75
         V7/a4d70WWE0CxEe9qOn6kJ0YvGybfQBO1LUQaYnTtL0JSb1P7T2FROeyzafOgo1MvRs
         9LvrQvSaB4Rnncu834rHZinKxGYukVORWOwJ/UU442DAwY1O9mqaq19243Iz+xR87M8s
         yJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUz2ujGDRMNT97Y0qacAEmcfIhZsby6Szc4d8OJdO0uDSMVkWq4XfzKuO6aUmsqlt9eNoO2L5SkuMTp3uKbpEMpwYiaLPmc0aKZzmzcqnJTyvRtvKJvFMIuBRbhKva7oPAflV7dPBJR84RO
X-Gm-Message-State: AOJu0YyPLY9FPUX0/c/PT2NsQ9eiK5Bhw/k2vgTbgmO9Ib8sJaTeyR4a
	FjXhECDoc97HaL0YwrsriLyo+2XIz+ucjSU73ZA1QX1B1PalutcM
X-Google-Smtp-Source: AGHT+IFcsQJ+fcrrjDGRRQbEJ/HnTGFheC1poa5MqAGAL8hpKSaKdKXR7TplGoxmnE8EzIlmKO97Hw==
X-Received: by 2002:a17:906:a24c:b0:a55:59e6:13f5 with SMTP id bi12-20020a170906a24c00b00a5559e613f5mr773920ejb.26.1713505506123;
        Thu, 18 Apr 2024 22:45:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ww4-20020a170907084400b00a51d88e6164sm1724474ejb.203.2024.04.18.22.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 22:45:05 -0700 (PDT)
Message-ID: <5cee4da4-1620-449c-8160-ff4168b0688e@kernel.org>
Date: Fri, 19 Apr 2024 07:45:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
To: Konstantin <rilian.la.te@ya.ru>
Cc: Konstantin <ria.freelander@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lech Perczak <lech.perczak@camlingroup.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240418132508.3447800-1-rilian.la.te@ya.ru>
 <20240418132508.3447800-4-rilian.la.te@ya.ru>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240418132508.3447800-4-rilian.la.te@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 04. 24, 15:25, Konstantin wrote:
> From: Konstantin <ria.freelander@gmail.com>
> 
> Its register set is mostly compatible with SC16IS762, but
> it has a support for additional division rates of UART
> with special DLD register. So, add handling this register
> via UPF_MAGIC_MULTIPLIER port flag.
> 
> Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> ---
>   drivers/tty/serial/sc16is7xx.c | 54 ++++++++++++++++++++++++++++++++--
>   1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index a300eebf1401..7fc1c19b3891 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -65,6 +65,7 @@
>   /* Special Register set: Only if ((LCR[7] == 1) && (LCR != 0xBF)) */
>   #define SC16IS7XX_DLL_REG		(0x00) /* Divisor Latch Low */
>   #define SC16IS7XX_DLH_REG		(0x01) /* Divisor Latch High */
> +#define SC16IS7XX_DLD_REG		(0x02) /* Divisor Latch Mode (only on EXAR chips) */
>   
>   /* Enhanced Register set: Only if (LCR == 0xBF) */
>   #define SC16IS7XX_EFR_REG		(0x02) /* Enhanced Features */
> @@ -218,6 +219,20 @@
>   #define SC16IS7XX_TCR_RX_HALT(words)	((((words) / 4) & 0x0f) << 0)
>   #define SC16IS7XX_TCR_RX_RESUME(words)	((((words) / 4) & 0x0f) << 4)
>   
> +/* Divisor Latch Mode bits (EXAR extension)
> + *
> + * EXAR hardware is mostly compatible with SC16IS7XX, but supports additional feature:
> + * 4x and 8x divisor, instead of default 16x. It has a special register to program it.
> + * Bits 0 to 3 is fractional divisor, it used to set value of last 16 bits of
> + * uartclk * (16 / divisor) / baud, in case of default it will be uartclk / baud.
> + * Bits 4 and 5 used as switches, and should not be set to 1 simultaneously.
> + */
> +
> +#define SC16IS7XX_DLD_16X		0
> +#define SC16IS7XX_DLD_DIV(m)	((m) & 0xf)

Why not to use GENMASK() here and FIELD_PREP() in the code?

> +#define SC16IS7XX_DLD_8X		BIT(4)
> +#define SC16IS7XX_DLD_4X		BIT(5)
> +
>   /*
>    * TLR register bits
>    * If TLR[3:0] or TLR[7:4] are logical 0, the selectable trigger levels via the
..
> @@ -559,13 +582,29 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>   	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
>   	u8 lcr;
>   	u8 prescaler = 0;
> -	unsigned long clk = port->uartclk, div = clk / 16 / baud;
> +	u8 divisor = 16;
> +	u8 dld_mode = SC16IS7XX_DLD_16X;
> +	bool has_dld = !!(port->flags & UPF_MAGIC_MULTIPLIER);

No need for !!.

> +	unsigned long clk = port->uartclk, div, div16;

All these locals would deserve better ordering.

..
> @@ -1014,6 +1055,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
>   	unsigned int lcr, flow = 0;
>   	int baud;
>   	unsigned long flags;
> +	bool has_dld = !!(port->flags & UPF_MAGIC_MULTIPLIER);

Ditto.

>   
>   	kthread_cancel_delayed_work_sync(&one->ms_work);
>   
thanks,
-- 
js
suse labs


