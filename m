Return-Path: <linux-kernel+bounces-48076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2241E8456ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B621B28716
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B3615DBB0;
	Thu,  1 Feb 2024 12:05:54 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8C15F335;
	Thu,  1 Feb 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789153; cv=none; b=W98PaDXneSKAFnFjxjDaJ1+lAqtHvK5DOKKfJb9JLMoI+UtZ1GXt0wPBiCRkfhuKsh1g6iKRmLNHCqW0IMMh9caQXw+mMGwEofwTA4K0qT7iBtfktg0Hz+ZLRI45Jn14kfplLeFItJMnqCVTb+oLX+GO1U4MiA4xlC5gWUXqHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789153; c=relaxed/simple;
	bh=gQV96LeE0QMAhw3Sunz9Wk9iH67y7JHPY/mEJ6hp/ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdr3UOAIUJoAXJHmCnbn8peTgHr08LWkgmCsgkT7bsy8ZUghFhgLQ+vxld4xUeD8LRKEKF4AVON2X4QYc+A2Cu71KhgG/Vgi1sTWswRQ04sb0BV4ICx08DChecG0YOFrFFSguZBG/sML/mge8FO6zlGr5vZO8qOEhuuEIeXGYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d07d74be60so2498891fa.3;
        Thu, 01 Feb 2024 04:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706789144; x=1707393944;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fjOoUvz+p1Glr5jyHqYPv+9kiOEbm6VD6iqXP6pNtw=;
        b=swq/St1zIHO/IUHPuKXwUkoa30h+CX4P+RWGl/l/yTW+ZbrBOOf/Jlcunvt+ELHcED
         UZN2BB3Dzbsbfx2gf0jPko955imi3Vw5LIoB0/XHLu6d7bUVBscnqjO2Lzi0Qeamv8o2
         7Eti7ND8IWjjzfR7rZmT6upmxyRy78Vk7itchXWA1sw3PAMvnmEr90XMHJyU1y5yTwnL
         2Y9a+d9L9Fl0xQyxTpD6sb1q0yQM+w7t1s9b8rAh3GxZggxug0v58KlLIA3VTZ7E/mSc
         e2ZY/t3Id1lpOWukEXKbfkPNpL6ukbim2J0Dn4YKYmqST+l2F4oZkt/BiRBfF+678yrc
         /Q9Q==
X-Gm-Message-State: AOJu0YzD6kNAIZCIvz20Ho1wSEWg8RWMQWMbvF4z7Dv8XfKqbSGpuOoL
	93dPAew+EBcUb5+GfxhIvETo0XhkauTTfb0NgavLY4g+AN6T9n0T
X-Google-Smtp-Source: AGHT+IGZC0QfBQ4l8HdsMGlFNcjSGY6S1HLX0pqMo8PkW/5+l5A0xllFqIUg4e4XeIe6JcNvsjybCQ==
X-Received: by 2002:a05:651c:19a8:b0:2d0:4ef8:347a with SMTP id bx40-20020a05651c19a800b002d04ef8347amr4272991ljb.18.1706789143806;
        Thu, 01 Feb 2024 04:05:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUNFGV5Tm04Ju2FjYay2XauTsKUmTHPXWQIDhv7vqEwLOMATXnb7ObOYQHB7PsC4/UeOONTVGaCP+Ze4YgMOdTclneQGnKpknmuTwWbFldt0BxYXrWKLZPgwClp7guql9xeTTJvrFmy+O5fnYufzo3GB3W4qHzCRCf1O4jyy5nvP/gGzFzCtQzkfHICGn53dhzER9DXONbEavoaOqH6yDq6saLxVB1rDjahiKY/Nh58LSJRNM9cOM6O1cloYXvbyEYkQS3DnEH9ZpzeLVh4c2GX5o0VKObiPGW9BeVXDIWphOt7egbftPbIaOeZFGK+kHALvndxihsrlKVqJg==
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7c9da000000b005581573e251sm6752683edt.2.2024.02.01.04.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:05:43 -0800 (PST)
Message-ID: <3935b841-77b7-4265-a727-98a358cd56be@kernel.org>
Date: Thu, 1 Feb 2024 13:05:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: mxs-auart: fix tx
Content-Language: en-US
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Kronborg <emil.kronborg@protonmail.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240201105557.28043-1-jirislaby@kernel.org>
 <20240201105557.28043-2-jirislaby@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240201105557.28043-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01. 02. 24, 11:55, Jiri Slaby (SUSE) wrote:
> Emil reports:
>    After updating Linux on an i.MX28 board, serial communication over
>    AUART broke. When I TX from the board and measure on the TX pin, it
>    seems like the HW fifo is not emptied before the transmission is
>    stopped.
> 
> MXS performs weird things with stop_tx(). The driver makes it
> conditional on uart_tx_stopped().
> 
> So the driver needs special handling. Pass the brand new UART_TX_NOSTOP
> to uart_port_tx_flags() and handle the stop on its own.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reported-by: Emil Kronborg <emil.kronborg@protonmail.com>
> Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
> Closes: https://lore.kernel.org/all/miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw/

Am I unable to send a proper patch anymore?

I forgot to add mxs+arm maintainers:
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org

I can resend with those fixed, if you prefer...

> ---
>   drivers/tty/serial/mxs-auart.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 3ec725555bcc..4749331fe618 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -605,13 +605,16 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
>   		return;
>   	}
>   
> -	pending = uart_port_tx(&s->port, ch,
> +	pending = uart_port_tx_flags(&s->port, ch, UART_TX_NOSTOP,
>   		!(mxs_read(s, REG_STAT) & AUART_STAT_TXFF),
>   		mxs_write(ch, s, REG_DATA));
>   	if (pending)
>   		mxs_set(AUART_INTR_TXIEN, s, REG_INTR);
>   	else
>   		mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
> +
> +	if (uart_tx_stopped(&s->port))
> +               mxs_auart_stop_tx(&s->port);
>   }
>   
>   static void mxs_auart_rx_char(struct mxs_auart_port *s)

-- 
js
suse labs


