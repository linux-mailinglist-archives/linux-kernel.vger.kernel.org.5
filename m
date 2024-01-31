Return-Path: <linux-kernel+bounces-46409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144DB843F48
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473F01C22771
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280FB7868D;
	Wed, 31 Jan 2024 12:17:21 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D6762E1;
	Wed, 31 Jan 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703440; cv=none; b=VtgEQ1tnkTQk04wpPSYSo1XUkCewJ6mOyGSsaR20zwCW3N2tOhtdLKHHkBmwB++wvMf4EbaXeCN+GnygDZcrslk8yrefRRof9/NAwGB1Kdueo74ubhxZQjyUQH+Fj79uEblA3fQxX0f1wEkKG3N3fo6h8zf+yFOXpDqVYnlrb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703440; c=relaxed/simple;
	bh=2Jd8suf/i+X9NPKqBbfMbRQ9p3KeFGUCPjxpdR3RPug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGcxwCgKqUSInB5X8qn4Zopt7cNpr3YVFfBMPRItlzwzVn8GPIyFL1fvCLA9is69ORuXz/HmWg4ncD+XhpN58qhe2LPSaVL8EZlPBjGlY1D5eAsPIejaS29cQLXhTjVbaFdDrhD9jKWHv1zBuG4xzAINNgYclvFtQLG3MXF1YjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ae3cc8a6aso2989510f8f.2;
        Wed, 31 Jan 2024 04:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706703437; x=1707308237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHJldCCa2RiZRYmUsOT7GhzTqaQY4pc8Kw/XJx9UWNg=;
        b=D0jahaJLNrtKWl7JZyp5KzvK3GUVcE32mnniocUpdoX10FunRB70xikAcYow7jRNeX
         1/NPH633NaiSbv/hR875DQr9OMGXrrnGgQrRn0ZBM7u+wpD5EHJuqykxJ+yKQSVkAp6e
         21lHkA/luxpymfdzmOLB45W/KEXIFh0KctehF7tURvfWrPdbBIGGT2hvd9Jsnu1dLakT
         obqObeKiFAjr0ZFEUqMMBGRhxGYpRsZEy8KUimNNKoPtcoBGeOx+4QQPsHl7hagh9o5a
         0M8Q+45i+wO7jdpuqdfxJwRs2sACXDUnyjHnYjVxt8qffrEBTf9JgidVgKDbRj6kVALQ
         6aHw==
X-Gm-Message-State: AOJu0YywuyKy3SV/lo7XiR0LJ4Y1/jU9JQU0IFj12manyTLHpdNe1ubC
	nYpi4aLVSnQPvwzs1/NTMo6DtYhzecJ8NmJUBWz17PNew97S7R2fWVoEw4LK3w24bA==
X-Google-Smtp-Source: AGHT+IFlzvUi6VKjP0ghuuI8IU3niKY68ZU8rSasTYqK6vZWdAIHMnGsxhjfpAiGozplvcx1bvnCvQ==
X-Received: by 2002:adf:e5d1:0:b0:33a:f51a:f7ba with SMTP id a17-20020adfe5d1000000b0033af51af7bamr1165491wrn.49.1706703436928;
        Wed, 31 Jan 2024 04:17:16 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d6e87000000b0033addeabd6fsm12647036wrz.18.2024.01.31.04.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:17:16 -0800 (PST)
Message-ID: <2decb1ec-050d-45f5-b136-d39c59bf4e55@kernel.org>
Date: Wed, 31 Jan 2024 13:17:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: core: introduce uart_port_tx_flags()
Content-Language: en-US
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Kronborg <emil.kronborg@protonmail.com>
References: <20240131121359.7855-1-jirislaby@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240131121359.7855-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31. 01. 24, 13:13, Jiri Slaby (SUSE) wrote:
> And an enum with a flag: UART_TX_NOSTOP. To NOT call
> __port->ops->stop_tx() when the circular buffer is empty. mxs-uart needs
> this (see the next patch).
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Emil Kronborg <emil.kronborg@protonmail.com>
> ---
>   include/linux/serial_core.h | 32 +++++++++++++++++++++++++++-----
>   1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 536b2581d3e2..edefb6d73604 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -748,8 +748,17 @@ struct uart_driver {
>   
>   void uart_write_wakeup(struct uart_port *port);
>   
> -#define __uart_port_tx(uport, ch, tx_ready, put_char, tx_done, for_test,      \
> -		for_post)						      \
> +/**
> + * enum UART_TX_FLAGS -- flags for uart_port_tx_flags()
> + *
> + * @UART_TX_NOSTOP: don't call port->ops->stop_tx() on empty buffer
> + */
> +enum UART_TX_FLAGS {
> +	UART_TX_NOSTOP = BIT(0),
> +};
> +
> +#define __uart_port_tx(uport, ch, flags, tx_ready, put_char, tx_done,	      \
> +		       for_test, for_post)				      \
>   ({									      \
>   	struct uart_port *__port = (uport);				      \
>   	struct circ_buf *xmit = &__port->state->xmit;			      \
> @@ -777,7 +786,7 @@ void uart_write_wakeup(struct uart_port *port);
>   	if (pending < WAKEUP_CHARS) {					      \
>   		uart_write_wakeup(__port);				      \
>   									      \
> -		if (pending == 0)					      \
> +		if (((flags) & UART_TX_NOSTOP) && pending == 0)		      \

Hold on, this is obviously inverted!

-- 
js
suse labs


