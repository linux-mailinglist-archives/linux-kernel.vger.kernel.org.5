Return-Path: <linux-kernel+bounces-57616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D949784DB6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095AC1C22F32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218CF6A334;
	Thu,  8 Feb 2024 08:28:04 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81569E19;
	Thu,  8 Feb 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380883; cv=none; b=H/mtn8LHGQHqJBwUb8oygrBjWXpmSpkiwMsCwQ4NQN38RiqI4glrCJGhKbus60lYOY0oQN4xmS/uM0pKWhSFqP7ugS1IPFRmyOAwHxrRUuKfo9B9xxqRlf1Y/b/6bg2iPJmSEzIMwp0B9DX41BBkNyNJ6gaVnmwNWr29xFJD1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380883; c=relaxed/simple;
	bh=Hwq9yOi7lEEwol8ReKQt8DR4NwTOqg+StGLb5yhhHh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9rTH0TyO/UnOToc5SUF4PwZLtvHUCfEyMYMhnya0aThyjUi4cOFP2PMi8DM5flP1EERDZxh93sZCeyCn+DVFjD4xWeYYLDfhz+7qU8GETJyxrq3+yTyw+FbGG/ImhD/038OlpyS6uX9ctm5qHB34ta9ntWSNNoDiIxceolqeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a383016f428so165709466b.2;
        Thu, 08 Feb 2024 00:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380880; x=1707985680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3J6JVDLj3OBm0DJVE2MBrRYH5ybiC+R9pZpfi4H1hU=;
        b=U28aG/TqEWtO+KZ9+GXBU7CWUGBexJl5U4qWA0DeG2KmRN7p/tyxVSBA1e4DC88IrR
         a4w6mdWkc5oYwgJKs9OkUEM8HJQOkMP8dgK8uY0cPYydnb5Piss/D5TI+S55nSuO2uEc
         i8nM/cuyh6AZRvITWpKG+53eWptIceWz9YRToBQDc/R0fS810dfQMiM+BpgkN/n+wIU7
         sM/ql1aPGkf7RYwq+oxmn0QcsnrgWj2/c/dEQ9fuz020DbvcI5YnhuYEPvcsQQc5JTMy
         ecSjYWR29fZMhCSxcHbSa01MgzFuPf5DKUwfyiWaBwOn5QDNY129wBsJghnqOlo8nNzO
         CRYQ==
X-Gm-Message-State: AOJu0YxrKL1gi5hZ+0qNN4Dz+0dxGhu2pgKb5enr+6CqN2RVzE4hv2o8
	EJVEjpb0c813FWt91oFfydnqdFw3owDkXnvURB7NEN0tic62ON/4
X-Google-Smtp-Source: AGHT+IEQJ4eiihqNCqjO7DCJyd6GBR3isw4XzGXBKDH8Sa4hM1JWV5fejo1NO24Mez9cRT5S+la1RA==
X-Received: by 2002:a17:906:a213:b0:a36:3806:8911 with SMTP id r19-20020a170906a21300b00a3638068911mr7007534ejy.43.1707380879456;
        Thu, 08 Feb 2024 00:27:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeejN98P8Sxgk9QklCeEnAeSxfOUjfH4tqMGE9bk4aYYqm5IrlSikzQamURwd4o3K7JJj0pLgqm9swvzVCESJpm7TCRkgSVCm/x9XqJPuvwF5sGetLkCGC/pSXGUbuNnQDGbWvi9vQ0myQO279uVsEoh3lS5aYDRJjqfowA8yfzuXurT+D8XAteQyc4pkTlZXyy+sGmfxpOb1/PGfxw5B79+OFsdhFJtEDl0qpmUOG9cuLhPgLVuMBCsBAVdeLBGP5mrmz5jTUp0Fr6EV9E18K1gAZc0toGJ+//B3bh+0VQk5iRLrb4RFWuknHcEUUj6nAmyA1X2bLiSMG3yL2h2leU9oxg8UmX/1tQdcIDsj6lmerAcrqTUiMQarv/I47KgYkKRR8WJNzrGztsIyGRiiTL0cFJ85CJxq5PNSLFugSDgwcL/wnIARPIMSG
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id i17-20020a170906265100b00a38576aefabsm1635151ejc.161.2024.02.08.00.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 00:27:58 -0800 (PST)
Message-ID: <beb599e2-ebc5-4b26-82c3-908830effd5a@kernel.org>
Date: Thu, 8 Feb 2024 09:27:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: port: Don't suspend if the port is still busy
Content-Language: en-US
To: Yicong Yang <yangyicong@huawei.com>, gregkh@linuxfoundation.org,
 tony@atomide.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
 tglx@linutronix.de, yangyicong@hisilicon.com, linuxarm@huawei.com,
 prime.zeng@hisilicon.com, jonathan.cameron@huawei.com, fanghao11@huawei.com
References: <20240208075216.48915-1-yangyicong@huawei.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240208075216.48915-1-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08. 02. 24, 8:52, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> We accidently met the issue that the bash prompt is not shown after the
> previous command done and until the next input if there's only one CPU
> (In our issue other CPUs are isolated by isolcpus=). Further analysis
> shows it's because the port entering runtime suspend even if there's
> still pending chars in the buffer and the pending chars will only be
> processed in next device resuming. We are using amba-pl011 and the
> problematic flow is like below:

..
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -19,8 +19,13 @@
>   /* Only considers pending TX for now. Caller must take care of locking */
>   static int __serial_port_busy(struct uart_port *port)
>   {
> -	return !uart_tx_stopped(port) &&
> -		uart_circ_chars_pending(&port->state->xmit);
> +	if (uart_tx_stopped(port))
> +		return 0;
> +
> +	if (uart_circ_chars_pending(&port->state->xmit))
> +		return -EBUSY;

Why do you do this change at all? If anything, __serial_port_busy() 
should be made to return a bool and not to return an error. Look how it 
is named -- returning EBUSY is sort of unexpected in my eyes. And if 
this needed to be done, it should have been in a separate patch anyway.

And then:

> @@ -46,8 +51,33 @@ static int serial_port_runtime_resume(struct device *dev)
>   	return 0;
>   }
>   
> +static int serial_port_runtime_suspend(struct device *dev)
> +{
> +	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
> +	struct uart_port *port;
> +	unsigned long flags;
> +	int ret;

bool busy;

> +
> +	port = port_dev->port;
> +
> +	if (port->flags & UPF_DEAD)
> +		return 0;
> +
> +	uart_port_lock_irqsave(port, &flags);
> +	ret = __serial_port_busy(port);
> +	if (ret)

busy = ...
if (busy)

> +		port->ops->start_tx(port);
> +	uart_port_unlock_irqrestore(port, flags);
> +
> +	if (ret)

if (busy)

> +		pm_runtime_mark_last_busy(dev);
> +
> +	return ret;

return busy ? -EBUSY : 0;

> +}

thanks,
-- 
js
suse labs


