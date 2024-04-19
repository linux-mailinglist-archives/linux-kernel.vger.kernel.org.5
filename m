Return-Path: <linux-kernel+bounces-151067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF518AA895
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923901F21F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2EA381D5;
	Fri, 19 Apr 2024 06:45:11 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CD2206B;
	Fri, 19 Apr 2024 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509110; cv=none; b=dpTY8jBnSskvvEMNRMRLezl4S1VGpaOn6OpjLNhODgMr7U2KPWycd1l5PfMZL+suHlYagY/zEQAAPCSiflBm9Eln3U/1G9cM4SctaqDdtyJnGtZOhn9vzeY/X3TltlwZkt2LkGpMVlnDCYp19o/IpCkhN01Pj9a0mL09j4h6jGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509110; c=relaxed/simple;
	bh=BYJfFB3o4z4DlnqnsEJgtuXRJsUFcJABhy/592EEOTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srdkPvtSK82akSlFYVE4tQ7LgFWUc2iQZr0IRU5FHLKPQPCoji10cmEiEZUls3wk6SyIcJAAYndhhbNVrpC6Fb5ZCS+pKLRyRQtfDcZAy1G/gzFSUUnIsRyBgKjAeH7duoEWSl7iimqT44VrDbnf6tv3wSg4U7+JoVkRktD+f44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a555b203587so181071366b.3;
        Thu, 18 Apr 2024 23:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713509107; x=1714113907;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXIvdpEd+7151YjFeMND2OHmgnAdxNKLUK95CtrZCdI=;
        b=gQGLFcB1JH8n/ORR1aAJXGhQOanDkuOLmtvDfWoexBWaA5XvN1sy+/jzYS6jM7w/Tt
         2+OenTgwt7zgdpWt4ngyM1eJ4l/x8VmzuMjuSLR5plPLtkt1TrMWM6lCcmN0lt+nb5/H
         UqgX8+t9ev5feeZx8rCnnKhlkyrp6zMLDDcCoHXWexE+H2t3KVUp5Jxf+eqYuivrw4fY
         +sZVcDETRr87fxT/drMfNQfjS3mYBxWrdt9dqH2WzOhpmmAJwQ/AhFH4Ry/JDpzUx2rD
         41uQjtX7RYu7kqD/Pkqx62aP+QyKwoz+UKiW6IHkB61Z8fxqc7FAlaEZKAy+SgXZRvFp
         ziRA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Fn5Bfs3fvaEgbG/XLmn1bNQ01jwfkjvN6fIXX5+soGeBvLqS7BXniE4ebke7JzSXwq1Zh0r7ohIVY85oV1NWQyNbr4/RJ5MhnCQXFHDbHrinbkcAAd22j0QMuG5WO8pVh9u9FjR8MBNp
X-Gm-Message-State: AOJu0YxYrpSroxLAcEJxHxOG4Oq5SDtL6L6lOPXNmkwwqblcMwkVbuk4
	XdwKBobRa7e/8FDI9+I1JDviO38IoGeFuMRsz4cAVl83Z7ce//VO
X-Google-Smtp-Source: AGHT+IFcA73FFOmxY7aTA5rxa2eWhA56cSRnUbV2wiUKZOyqKo2C668xTzXLBl3e/aFv7RSiA+rUVg==
X-Received: by 2002:a17:907:3ea8:b0:a52:56e8:2245 with SMTP id hs40-20020a1709073ea800b00a5256e82245mr1335980ejc.47.1713509107067;
        Thu, 18 Apr 2024 23:45:07 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id cd19-20020a170906b35300b00a4673706b4dsm1798254ejb.78.2024.04.18.23.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 23:45:06 -0700 (PDT)
Message-ID: <07021359-27b4-4e7c-b8cc-3090f59ff219@kernel.org>
Date: Fri, 19 Apr 2024 08:45:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
 Vladimir Zapolskiy <vz@mleia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lech Perczak <lech.perczak@camlingroup.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
 <20240418170610.759838-4-rilian.la.te@ya.ru>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240418170610.759838-4-rilian.la.te@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 04. 24, 19:06, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> XR20M1172 register set is mostly compatible with SC16IS762, but it has
> a support for additional division rates of UART with special DLD register.
> So, add handling this register by appropriate devicetree bindings.
> 
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> ---
>   drivers/tty/serial/sc16is7xx.c | 55 +++++++++++++++++++++++++++++++---
>   1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index a300eebf1401..59376c637467 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
..
> @@ -218,6 +219,20 @@
>   #define SC16IS7XX_TCR_RX_HALT(words)	((((words) / 4) & 0x0f) << 0)
>   #define SC16IS7XX_TCR_RX_RESUME(words)	((((words) / 4) & 0x0f) << 4)
>   
> +/*
> + * Divisor Fractional Register bits (EXAR extension)
> + * EXAR hardware is mostly compatible with SC16IS7XX, but supports additional feature:
> + * 4x and 8x divisor, instead of default 16x. It has a special register to program it.
> + * Bits 0 to 3 is fractional divisor, it used to set value of last 16 bits of
> + * uartclk * (16 / divisor) / baud, in case of default it will be uartclk / baud.
> + * Bits 4 and 5 used as switches, and should not be set to 1 simultaneously.
> + */
> +
> +#define XR20M117X_DLD_16X		0
> +#define XR20M117X_DLD_DIV(m)	((m) & GENMASK(3, 0))

Again, why not set this up as a mask and use FIELD_PREP?

Could you stop submitting this many series in such a short time lapse? 
It makes reviewing a major PITA.

-- 
js
suse labs


