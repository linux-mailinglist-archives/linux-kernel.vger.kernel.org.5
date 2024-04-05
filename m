Return-Path: <linux-kernel+bounces-132422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FADE8994B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8CE1C2269F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405821A06;
	Fri,  5 Apr 2024 05:25:09 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88A12E5B;
	Fri,  5 Apr 2024 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712294709; cv=none; b=UbcjvjZduWto2yPzA1G6KDnfiUPPefjL4FR2jD6qqXwAmYgL68zeKs8VsQVTvSMLVW5/PdyMwPSIz11v8OnCf8z6ieaPbHXgiR+uTs/cucqylegaoMoEbOvifXgSVf18uEHyKwQjI7tJDKZwS6pM8U07yqNj9Q9V15gw7Ij1hM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712294709; c=relaxed/simple;
	bh=qjhqmeZyakIcB2WRtmXiuW6Vv533y6WL9gqqXtxnRQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFY9MTLoVP0ABET5qUBMw8f6wW0hKlkCOjS5tejbHPOJ9Ueq0TtMfzVwvzzb1VcglnPyB5vYLGEshFsPglSH5Wmi4Lwle8CReAgUn1OZ/WRgGzWzSbudReR8aFHUDr2PKPl51KKzzwAxYn6amsRvoMD9esikdFPdv5mNGwQtWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d700beb60bso28662111fa.1;
        Thu, 04 Apr 2024 22:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712294705; x=1712899505;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsUr+8mmX+b7++95BZ8RJ5aoU3lTnpPg5pKUZvrJrQ4=;
        b=eASrV94Eg2AfpnEqqsbybty07OVhYBCkcKmATbAfXJAArY1aPafH6QhrTwhnrRW6ve
         SaO+Y+uV3ZuAkkL0+j0H/3vByg5siZ00qrtQ3qz57i/A8+08tN+CMAdoLSGO+aaq9VFv
         EFTSzc3XgFAh5A7lZM9Uyr8bHl1TF3Tt2KFjhJ7gJxdEOXvfgi9MGs6O9sng0G5lSQwX
         ituQhdPj2CbW6vYBavtp4sP6D7o5GLGiUc4eDNNGeveOpbK7mBZRf/Y8rFeaiu28vKty
         DGENCQQfGzjnhUioEK74G6gV32l8WxzskpnYSbEoDYdHybmV7VoH3kq9aG+ksvvd3CNe
         fgKg==
X-Forwarded-Encrypted: i=1; AJvYcCUAsm2qSdRn66/VZ7T9WiyLHO1vxz/jXhUn6zYC2c+GjO/TV2dJA9OorN9I3pNZVtgQ3hzbWKyAslgnv7OwWkekzEEY7nsPcG6nLOD9aYk++5WfsVWuPFV/InfTATQYM4P5wabW4X71Vtwj
X-Gm-Message-State: AOJu0YwBSTtH7Kn1LNmj7aiYAnKWDTV0W+Fgt4fA16K95jawO1aR9WOs
	gugYj8g8EilwCNOf++HyWckNQ7Dl+pjCC6JO3roeyYS1lt/KNkps
X-Google-Smtp-Source: AGHT+IEPX+SSJwUEuh9wTd60ayLVODL8vrQc1rZZUAI6ZKFL1fl6iLwemPkqLzf5DNMoLaBS2US3Ow==
X-Received: by 2002:a05:651c:124d:b0:2d6:fd22:8065 with SMTP id h13-20020a05651c124d00b002d6fd228065mr509980ljh.1.1712294705136;
        Thu, 04 Apr 2024 22:25:05 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id oz10-20020a1709077d8a00b00a4e533085aesm415776ejc.129.2024.04.04.22.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 22:25:04 -0700 (PDT)
Message-ID: <f0f200b0-34dc-430b-b55e-b133faf4db44@kernel.org>
Date: Fri, 5 Apr 2024 07:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] serial: core: Clearing the circular buffer before
 NULLifying it
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 kernel test robot <oliver.sang@intel.com>
References: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 04. 24, 16:59, Andy Shevchenko wrote:
> The circular buffer is NULLified in uart_tty_port_shutdown()
> under the spin lock. However, the PM or other timer based callbacks
> may still trigger after this event without knowning that buffer pointer
> is not valid. Since the serial code is a bit inconsistent in checking
> the buffer state (some rely on the head-tail positions, some on the
> buffer pointer), it's better to have both aligned, i.e. buffer pointer
> to be NULL and head-tail possitions to be the same, meaning it's empty.
> This will prevent asynchronous calls to dereference NULL pointer as
> reported recently in 8250 case:
> 
>    BUG: kernel NULL pointer dereference, address: 00000cf5
>    Workqueue: pm pm_runtime_work
>    EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
>    ...
>    ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
>    __start_tx (drivers/tty/serial/8250/8250_port.c:1551)
>    serial8250_start_tx (drivers/tty/serial/8250/8250_port.c:1654)
>    serial_port_runtime_suspend (include/linux/serial_core.h:667 drivers/tty/serial/serial_port.c:63)
>    __rpm_callback (drivers/base/power/runtime.c:393)
>    ? serial_port_remove (drivers/tty/serial/serial_port.c:50)
>    rpm_suspend (drivers/base/power/runtime.c:447)

Yeah, I noticed start_tx() is called repeatedly after shutdown() 
yesterday too. So thanks for looking into this.

And it's pretty weird. I think it's new with the runtime PM (sure, /me 
reads Fixes: now). I am not sure if it is documented, but most of the 
code in tty/ assumes NO ordinary ->ops (like start_tx()) are called 
after shutdown(). Actually, to me it occurs like serial8250_start_tx() 
should not be called in the first place. It makes no sense after all.

BTW cannot be x_char en/queued at that time too (the other check in the 
if)? But again, serial8250_start_tx() should not be called after shutdown().

> The proposed change will prevent ->start_tx() to be called during
> suspend on shut down port.
> 
> Fixes: 43066e32227e ("serial: port: Don't suspend if the port is still busy")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202404031607.2e92eebe-lkp@intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> I have got into the very similar issue while working on max3100 driver.
> I haven't checked the 8250 case, but for mine the culprit is the same
> and this patch fixes it. Hence I assume it will fix the 8250 case as
> well.
> 
>   drivers/tty/serial/serial_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index a005fc06a077..ba3a674a8bbf 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1788,6 +1788,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
>   	 * Free the transmit buffer.
>   	 */
>   	uart_port_lock_irq(uport);
> +	uart_circ_clear(&state->xmit);
>   	buf = state->xmit.buf;
>   	state->xmit.buf = NULL;
>   	uart_port_unlock_irq(uport);

-- 
js
suse labs


