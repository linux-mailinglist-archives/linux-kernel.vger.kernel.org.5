Return-Path: <linux-kernel+bounces-111587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F0886E34
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803341C20EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E747796;
	Fri, 22 Mar 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="CyTnfEUJ"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA647A53
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116750; cv=none; b=RjGJ+uaXiTJ6Ve1D8OAWfM9gzEiAX5gEylqUzXV7/zBFSmSSHJfibwUc08ZdFytlkcw6ZoVdQYK+DLuQb/TsNF6+VxMDpjRUlPH1E6meBueKBdacR30vYveyoWTCA14dGEiWDcbI6AFxjvN/46C3SplHRLPfBleLDx8MRNLRDq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116750; c=relaxed/simple;
	bh=xaP3sAbLubt6f1b7wDUbIs8Zobt3RgckgcUvcMqq0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm1iQidk/R8qXbkXR/WxFj8/QwmbbM8IXnAUFfgH98hUqE9VgUHrAi5KYcG+3tFrkcpWp3CeH8x2vTlf1Zqe5DLSuNeo5oi0fep0b2OzPjLh32xWFM9VrnpPdx3KzvIJt9F9K6qH6tR70WTxGsuAc97QxCHCZGjn+a7B0NePrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=CyTnfEUJ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78a06e38527so149257585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711116747; x=1711721547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccm1mtAb95qdb6lkqB0FItmGid6eaARPcUgc6MW739g=;
        b=CyTnfEUJHsymqTdVoMVhR2UT1dVcu8qtdw/0rW/bYjqnRmbzZQ53SD1Pq1LgyE44Ff
         B7YukyopaeBiXcJ7xV1Ul2U2Gar76bJItz4p6XUhgCfdrt+epVoNCQyVNytimSfv6YMe
         P5Y7XyAd17UzMkon81/v1e2zl1nS2ZRtiratCi0TL0aafrJckRSbBFl3qo7cEFr+iZcv
         /RrZmQhm0+oyAGHhbBKd9lH9Gpzahmk0KgMcn9XYG1vPE+MRImwtXoBH4UzGDL6qU3N7
         bEF7FxlBB6tcp+gq3LHA+V+7cu6fVsMmPUPv9bYSkmXdBFsSZaLChNPHOZ2/WIwYRE7r
         Q5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116747; x=1711721547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccm1mtAb95qdb6lkqB0FItmGid6eaARPcUgc6MW739g=;
        b=O5fjb15AHeCmbJLWJXujIK1AVtB9GZlVI1bTGmxrIZt07o6HMHTLq8QWA2BpJsykj3
         8qYpnp4tJrQAuch1MqHx+WCQujv/be/v3m09X/Q1YkMYsr+RP0UV0mocXlJYyz8WNKal
         MudHtYWDKzO5BqBwwXzexsbvyh6nTwGq64g+C0CFZ0BL4VhG8z2iCao+QxYHh+1nLO1M
         IknOX1dUyS5BREc9HuehgU3UB7D1SsZ47YCo2xYaJvKBOWf0soTH3yQyJF871rRrIeZ2
         pVoKM2ju+UQvUUO6E9va6TB0LVD1Jfkf4jU80fi//u5+n0RwtHHmL3NfYJh09KuY+ZFv
         SouQ==
X-Gm-Message-State: AOJu0YxVG8px0tZFfVVYkldgXP3o5H6l6N3eSzYEshxwSyoQaWRDFmke
	OrtWbDGvGvukDO3bCpCl3cuURWsRM8m9MS9aKzjNreE5LvZrojrfx3IOb4r4cOr5dLg6jV7cRqg
	d8LM=
X-Google-Smtp-Source: AGHT+IFnfaJOCDK6cUge2Q0kmiLhh1+As+3fWIT4dvDOMO5Q9mrgQY3RBqSVCXK7jYSLUb7CSofK/A==
X-Received: by 2002:a05:620a:5605:b0:789:d306:879a with SMTP id vu5-20020a05620a560500b00789d306879amr2427097qkn.7.1711116746679;
        Fri, 22 Mar 2024 07:12:26 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id bj23-20020a05620a191700b00789f34f225dsm782925qkb.71.2024.03.22.07.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 07:12:26 -0700 (PDT)
Message-ID: <193a134c-f0da-4a45-b45a-a3605f91cfa4@draconx.ca>
Date: Fri, 22 Mar 2024 10:12:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 regressions@lists.linux.dev, linux-serial@vger.kernel.org
References: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
 <20240322051531.GA5132@atomide.com>
 <d7337014-09ac-8a35-7159-e75ecd2707b6@draconx.ca>
 <20240322064843.GC5132@atomide.com> <20240322090657.GD5132@atomide.com>
Content-Language: en-US
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <20240322090657.GD5132@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-22 05:06, Tony Lindgren wrote:
[...]
> I can't reproduce this on qemu-system-sparc64, probably as it does not use
> the sunsab driver.
> 
> I noticed something though, I think we need to test for the port device
> instead for being runtime PM enabled.
> 
> Can you please test if the updated patch below make things work again?

Yes, with the below patch applied on top of 6.8 things are working.

Thanks,
  Nick

> 8< -------------------
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
>  	 * enabled, serial_port_runtime_resume() calls start_tx() again
>  	 * after enabling the device.
>  	 */
> -	if (pm_runtime_active(&port_dev->dev))
> +	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
>  		port->ops->start_tx(port);
>  	pm_runtime_mark_last_busy(&port_dev->dev);
>  	pm_runtime_put_autosuspend(&port_dev->dev)

