Return-Path: <linux-kernel+bounces-138211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499389EE24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9801F23722
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF66B1552F7;
	Wed, 10 Apr 2024 09:04:41 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961E313C9C2;
	Wed, 10 Apr 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739881; cv=none; b=tBYfS1O0wrdA71FmcdKNGm3y13sX9z92lNOTCeEqAQjipqnPoQH2vzD6ItaOpKoCRP+E4cTtstzrI8ke1kFcjGnVtG7M9OaGwJ+/xAkMGgZr+3P+OXNKshw4tVdJqkIQNy2JFrXAauhDSUhUJyYsaqXSDAcxrWTv/8KwiMTT8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739881; c=relaxed/simple;
	bh=yC1fHnN++BPpkQjf58bLfmmcbueNBtdWeMQ2Fls3OaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=paYZ9z1NIJ2ExZNwmPgnFnZNqkk0zg94hQ6fYGYWF5VWCWMDgACiB/iV58Nrp9QdJlF9HXIAiDJ3QybfuUmNam8nNm0M0IPr3Tt87z0+pASC+7GlYV6pmSjtV1SNWjCVdtV3HE+1LiZ55VrSOV80cLt0NjyWuSpYeR5rGSYV2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56fd7df9ea9so334848a12.0;
        Wed, 10 Apr 2024 02:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712739878; x=1713344678;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSRbPEsYEHh8o1F+T+KrAr6gkHV7VXnnnB4LL4c3yKI=;
        b=f5Emf1lMWHjmwdFq3LrjjYEelvTOYNTL/drkVUwOwn/XeBVLrZ9vZf44tjME/twdod
         +MTvCczF0COsjISBc+CUX5jNXJkYBrDErhjWjsAmSk5ue1FGRyopd+DW4JeO1JSvF5R9
         B1P21jGaB0b4qTSAMj528D8VzbLRh2WFm0TwMKskBFLFJ1YCc1BgfrtjSjmDIDbEGKFZ
         2SutjOiF1U5c2NJSlfrx5XHlWy9Ex0R89M9qB/BzZAzzsgQygvu0xd9scQ79xDaeZ0nB
         cy36I8Mx+a7gfdZOzdFv6pxia/H3Z2yI1gmdrFfofTbBoDaoearm3JznQxZNXZA1GNoq
         V/fg==
X-Forwarded-Encrypted: i=1; AJvYcCVzVpT0xOonzIq2yMpx3vYsW/s791c8jbTMloYibg2SDRb0Adcu807K9tiFuP80U4lzvsWG7iwQX/sLWrKvYpKnTNUqhv4LKD9O1NU0Dc+GvJc/HeP7lLZJsCplaTjySawZXGgPFB0RciEL
X-Gm-Message-State: AOJu0YzjQN9SOmvmxJTDJNFmvvSi6iyAFZnwxZRmHut//GXtDMiNzF59
	9uJhUppb2RCUsGJAEwr7FfHNIVxbLPMrtyYJYY8vOnOWl1wC6sFZe7yYCVtp4C4=
X-Google-Smtp-Source: AGHT+IFlqwA3VpuaQbkMbHZHnkhIS3ZLMINC/6P8/QHZVQOqt7JvaZp0yCKD0KEBS7w2RpGmedWsWg==
X-Received: by 2002:a17:906:155a:b0:a51:b2a6:8bf3 with SMTP id c26-20020a170906155a00b00a51b2a68bf3mr1152437ejd.66.1712739877636;
        Wed, 10 Apr 2024 02:04:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090668c600b00a46d049ff63sm6655145ejr.21.2024.04.10.02.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 02:04:36 -0700 (PDT)
Message-ID: <52a83cb5-ef4f-46f5-ad90-1f64b4d588e2@kernel.org>
Date: Wed, 10 Apr 2024 11:04:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] serial: core: Extract uart_alloc_xmit_buf() and
 uart_free_xmit_buf()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240409174057.1104262-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240409174057.1104262-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 04. 24, 19:40, Andy Shevchenko wrote:
> After conversion to the kfifo, it becomes possible to extract two helper
> functions for better maintenance and code deduplication. Do it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/serial_core.c | 98 ++++++++++++++++++--------------
>   1 file changed, 54 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index dd6cf525d98d..ba2d6065fe02 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -243,25 +243,12 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
>   	uart_port_unlock_irq(uport);
>   }
>   
> -/*
> - * Startup the port.  This will be called once per open.  All calls
> - * will be serialised by the per-port mutex.
> - */
> -static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> -			     bool init_hw)
> +static int uart_alloc_xmit_buf(struct tty_port *port)
>   {
> -	struct uart_port *uport = uart_port_check(state);
> +	struct uart_state *state = container_of(port, struct uart_state, port);
> +	struct uart_port *uport;
>   	unsigned long flags;
>   	unsigned long page;
> -	int retval = 0;
> -
> -	if (uport->type == PORT_UNKNOWN)
> -		return 1;
> -
> -	/*
> -	 * Make sure the device is in D0 state.
> -	 */
> -	uart_change_pm(state, UART_PM_STATE_ON);
>   
>   	/*
>   	 * Initialise and allocate the transmit and temporary
> @@ -271,7 +258,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>   	if (!page)
>   		return -ENOMEM;
>   
> -	uart_port_lock(state, flags);
> +	uport = uart_port_lock(state, flags);
>   	if (!state->port.xmit_buf) {
>   		state->port.xmit_buf = (unsigned char *)page;
>   		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
> @@ -281,11 +268,58 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>   		uart_port_unlock(uport, flags);
>   		/*
>   		 * Do not free() the page under the port lock, see
> -		 * uart_shutdown().
> +		 * uart_free_xmit_buf().
>   		 */
>   		free_page(page);
>   	}
>   
> +	return 0;
> +}
> +
> +static void uart_free_xmit_buf(struct tty_port *port)
> +{
> +	struct uart_state *state = container_of(port, struct uart_state, port);
> +	struct uart_port *uport;
> +	unsigned long flags;
> +	char *xmit_buf;
> +
> +	/*
> +	 * Do not free() the transmit buffer page under the port lock since
> +	 * this can create various circular locking scenarios. For instance,
> +	 * console driver may need to allocate/free a debug object, which
> +	 * can end up in printk() recursion.
> +	 */
> +	uport = uart_port_lock(state, flags);
> +	xmit_buf = port->xmit_buf;
> +	port->xmit_buf = NULL;
> +	INIT_KFIFO(port->xmit_fifo);
> +	uart_port_unlock(uport, flags);
> +
> +	free_page((unsigned long)xmit_buf);
> +}

I see very much of tty_port_alloc_xmit_buf() and 
tty_port_free_xmit_buf() in here :).

Currently, different locks are used, so the patch is, I think, good for 
now. For future, we should switch to the tty port helpers.

Actually have you looked if the different locking is an issue at all? 
IOW, isn't the tty_port's (and its xmit buf) lifetime enough w/o uart 
port locks?

thanks,
-- 
js
suse labs


