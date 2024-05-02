Return-Path: <linux-kernel+bounces-166073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E68B9592
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA03DB22514
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9413025740;
	Thu,  2 May 2024 07:48:33 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161922EF2;
	Thu,  2 May 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636113; cv=none; b=fkNAlhY86xit6soZ3cey19hK9mrwZwO5T7Ya79xmbrZMwXILuqrag0MYLt4wwTK5kJFbQh6Wzi/so9zHwQGVcePinGMlDdRy2u0TrydsyYc6/S6OihJwwGuBKIB9ggfGwByyCp79UZCBN6tBG4pnaeRDnz2PSv7/tuD6Oz7J3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636113; c=relaxed/simple;
	bh=AyqpGCcx3pzUH4PEPahOYjVChU9L8yeZkhdfWdIn+kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTgzv2J9qU2ElphHC69ESZ9Ry03sW8L+NSKWU3CW/EKytomTh0FkkRCdah+lN1PQLXaXuTJlhimUFYWaLXONDOnwlNfgaBeZZcAWtIRISPF9wzhxMLXtTpx7yicim4TV0dJi5y7zQDn04Wk9BIMI3rWBvpMS5vI3FrJw26lPGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58772187d8so889347666b.3;
        Thu, 02 May 2024 00:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636110; x=1715240910;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1VeJE3uwbizswlqzCeytkGg3Ha1OSAITb8Byl9VcCo=;
        b=RD9a5srTsjk4kqoPSc7fesU1BlV6bJIYtHn5Q/EeK8kHz0CH6DGV3fi2pvH4KISb3x
         iKxVOlhfZ3s792azjQMTQHRWAVhBFRt+eBQFWSuZSJCFeyOH0R0CGRL88Q9u1dqxQDXK
         WWmBmNgvSz0u/dd9pLnljDrcMNzpfkAx72WjGhi1Wzq6X73nBMw/GitRrsOZ9XbWv9A9
         xQbuIZ27uC6mJcOAv7ULA6gdJkst6CpDTKLd0Zr1VD7AhqVa79/C5aJJ0CfKs9B53392
         yrM0WsawdyFHGQrwa/gngh8r6PSFm6r16lNhLPV0PjyzL1AyKU1bM7GN8a9cUMFlDXUv
         39dg==
X-Forwarded-Encrypted: i=1; AJvYcCUORSlUIpTuav0xgHboihtPh0b7TTU++mB0TxgxZ6bIM1DX0J3FNg/hBCwSiU0YNeAYPJvfYSi03HHtcDUdlHuoKhiH0OG6O9IkxtkmT0jBLmxcW6aMqbV12FlR3t74qG0L36wwRk+3+JkRNYvKbrAspebiOM0YdtMSuYBUpztzw12R
X-Gm-Message-State: AOJu0Yw/33TpF/iBIRzBc/npXTREhuR9KBJQj+LWqt4tksl0FyGWtCNI
	qo6ukHGdkWxB7K6RTyPePBj/VLZVkLNpO/1SIhIeK2J6+cP0QBNTvuIsm6IA
X-Google-Smtp-Source: AGHT+IHw6JGrVZHzINIDlMQEgZSuZ1lMjhWpjRZ7CAqnhXIyKbkwyF/GiLlboDRyVURWz71mf3MR9g==
X-Received: by 2002:a17:906:c2ca:b0:a58:ab31:638e with SMTP id ch10-20020a170906c2ca00b00a58ab31638emr1002475ejb.44.1714636109493;
        Thu, 02 May 2024 00:48:29 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906369500b00a596ea236f4sm237646ejc.212.2024.05.02.00.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:48:28 -0700 (PDT)
Message-ID: <4f960a0b-85f3-403f-b75a-47fb1b4ea6aa@kernel.org>
Date: Thu, 2 May 2024 09:48:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: sc16is7xx: fix bug in sc16is7xx_set_baud()
 when using prescaler
To: Hugo Villeneuve <hugo@hugovil.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Ringle <jringle@gridpoint.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240430200431.4102923-1-hugo@hugovil.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240430200431.4102923-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30. 04. 24, 22:04, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> When using a high speed clock with a low baud rate, the 4x prescaler is
> automatically selected if required. In that case, sc16is7xx_set_baud()
> properly configures the chip registers, but returns an incorrect baud
> rate by not taking into account the prescaler value. This incorrect baud
> rate is then fed to uart_update_timeout().
> 
> For example, with an input clock of 80MHz, and a selected baud rate of 50,
> sc16is7xx_set_baud() will return 200 instead of 50.
> 
> Fix this by first changing the prescaler variable to hold the selected
> prescaler value instead of the MCR bitfield. Then properly take into
> account the selected prescaler value in the return value computation.
> 
> Also add better documentation about the divisor value computation.
> 
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> ---
> 
> Changes for V2:
> - Change prescaler type to "unsigned int" (Jiri S.)

Thanks.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs


