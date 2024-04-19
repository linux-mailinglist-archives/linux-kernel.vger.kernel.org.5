Return-Path: <linux-kernel+bounces-151065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310518AA889
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805E12831A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8E4381C8;
	Fri, 19 Apr 2024 06:42:19 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D6C8FF;
	Fri, 19 Apr 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508938; cv=none; b=OPykPehFEoXSvlzQNemXrLlr5TW/8AXpzacAaVmpNH8hrTtX4m66tk2y2Ain6+fzVD0lb42Xj7qZB9RVj9QgzUlO4EZG5KC19YJ6WOkzj7FOhV0VPEfKS9TdzMA0OOa0sBsKxlWgTS/yYmYLDIzqzO4m8Ik4L2Tn/YuVIjwoEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508938; c=relaxed/simple;
	bh=4QwSAdaHJ+jSoNAFurZ4vkDf+ZSWnJ4D31nzVNVlaOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOtlwrKFSze1nJQ8wVPxQsSJOanyg5vfuZMNl33U+2zc2ejWIEjhflEtXetZh5M2GfnjDaoa2JRXQRw4gHYRGAZuiDnuC4OJx88Opp4M50nRvaOFNTXoZfQw3aTMmusMXqh9wZA1wQVJ0B5jcbqso90aI6AltH5Asjmpw+aoboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a556d22fa93so194304166b.3;
        Thu, 18 Apr 2024 23:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713508935; x=1714113735;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK1cw/DjfU20qIlgWW74LMBKEyMpUlbo8nQGzacK178=;
        b=R7aQb4ACuxqICD658Vs/0slK333mzs2MEQDzbC69pejE2RXwqCmkDYr9FjmRX9sPjX
         ghp8FJFTXjamAZrw7DaJcIbmUt7aI6QgvuAoi5uGeRGPHBwVtzTUbXnB6jA1CbBlO+J6
         2sIgI1a8msWCD4a3nKc0pL286OVYNjqu9BwOhXOCa0DlT0uvPLa0Zu5kzxQxKn6DmeLU
         mselBvh9IfDcTOXJX0MzGhQP44qntsgmeuq5P7Hl4hHb67eWvKudRCrtrObjWVkgQrpc
         x1pFni+jxEfqWjgwaSV0l3VwGkNhZpdY5fz92LWpc2CE6kLBowEasGJvcoVPKKuXIgJd
         VcAg==
X-Forwarded-Encrypted: i=1; AJvYcCWVnlid1/7k2DTZ8y2QtSPuDyIj3d5MIRCrwXN4k8hiTSQB/zhIqF7WqdloAJzddKaKyvrqcFe5JkbqrvYIs286q903573EFqlBYALoaK3zlmiwMm4pXiTWr19KmaDlaclK2TPrQGaInGBj
X-Gm-Message-State: AOJu0YwVRsXuJ5Ot1uB9SAuo4ZcRQ4KiWvzNV8K1mJ67YZfQpQEskxVQ
	R2wl7mndGxbjXMEH4aTSyq29Fx95zcp9/c09ewtYTgDv8k8A+XVC
X-Google-Smtp-Source: AGHT+IFbyCbfWpvHU9qLiqtgo5nVS9UXGAK5AESXpOV+hQs4hM43DIJUzPk7rHnwrGdvTjKz1taeDA==
X-Received: by 2002:a17:906:3450:b0:a52:5a23:3c2e with SMTP id d16-20020a170906345000b00a525a233c2emr747727ejb.43.1713508935023;
        Thu, 18 Apr 2024 23:42:15 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906119600b00a51a9d87570sm1796612eja.17.2024.04.18.23.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 23:42:14 -0700 (PDT)
Message-ID: <92d2c6cb-77d5-4bf5-9d4a-ab5b03f3f044@kernel.org>
Date: Fri, 19 Apr 2024 08:42:13 +0200
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
> @@ -556,16 +579,33 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
>   
>   static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>   {
> +	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
>   	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
> -	u8 lcr;
> +	unsigned long clk = port->uartclk, div, div16;
> +	bool has_dld = s->devtype->has_dld;
> +	u8 dld_mode = XR20M117X_DLD_16X;
>   	u8 prescaler = 0;
> -	unsigned long clk = port->uartclk, div = clk / 16 / baud;
> +	u8 divisor = 16;
> +	u8 lcr;
> +
> +	if (has_dld && DIV_ROUND_CLOSEST(clk, baud) < 16)
> +		divisor = 1 << (fls(DIV_ROUND_CLOSEST(clk, baud)) - 1);

Do you mimic roundup_pow_of_two()?

-- 
js
suse labs


