Return-Path: <linux-kernel+bounces-52155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281688494A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09652858CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DAF10A28;
	Mon,  5 Feb 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OB6hrEeJ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBC10A01
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118830; cv=none; b=KsKEEt79rZLT1ZZ/IpbvJdYuYC4B5MND9Np8dVTw5oOkVyOt6iPtiGqnAY42fZKNoKWqRQkjG0b485Dtlu7gQTLpikzhWMpufTSzf8wkh7hbI2e+NwqBy5UdKWF2myTBvcTpMVaD7uQJFQZLyHoUpx0QoSLyiH7mIGGS28VrLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118830; c=relaxed/simple;
	bh=nchm5OkmdUiGHfGrvQjwb7fWah4XvwZHrPlRwY4bvrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrB6kjUJTAvUM+L14x/10Wdz2KakN4GOb8mWEp1vGIYlfH3mh2hFU8x6Wqq5Saf3qFHMmVwUjg4p/5vWQpmL9sSjEzyli36H4RJTazLJMbsTeU7lThMHgt/5VRnlxWFCPiP07JwWciqbkljGd4/KRFZcp1CTE94DVuhwp7H901A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OB6hrEeJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so548135366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 23:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707118827; x=1707723627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GthxkzbELfg5v97NX2sB3ey9m+gwXsiTo/60XeoocpE=;
        b=OB6hrEeJET8N45CQjanxSCjJOmaBnw7Fgs/eyHg8I9Zkv0QKwwz4nocTiIgUnEJwVh
         khF1LK5vWe4jPENgRJ+WzuxyW1oosMoodebidlXLUXwiQNwOX7VpmnOSg2+nRzUt52qS
         fbzYuNk3i3LkHbqRFG2iq7VCrkdiQMcZZyXEFsxR5NHjn4K8Oauf30AuKwILoAgyZGTX
         tLBs5gk/t1GMV3ITcNzE4iVi3Za4nTtScko0Et7vzZ2YXfjZvCE8j80nwDo0ETYyas5C
         9Q5ZSFXjNeFYxzBV+WgFV4FDFSwisDSy03/kJFBB/cigdDQN572Wbm2SbhMsvL76o+Uk
         k8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707118827; x=1707723627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GthxkzbELfg5v97NX2sB3ey9m+gwXsiTo/60XeoocpE=;
        b=Vju679Z4wEAKp09XM2SEqJLziVyEX2taf45sXdrf2jK5EDXDByeKXClcM4Nb7t5DC/
         aAL+cik9hOhHtjIXDVdmmtQGxz0hPH+N4plo2PuSNuIFcrKWRhfUiEFVN8CRoTzfT+dV
         z32E0Pft17YvJTtMeiJ7zlj+1xwkAGzJo9z4+B4Y12qoZO2n9HwtXVuuT+RJKSTKg9Sj
         936jMrcM+vOVsrRAYj5jbL+DhwokY0Tu/8TpTJ6EaytTKAz0M4UGh3VbtUnIsNiyCcnV
         bUHWdRzGX73x0UPjzUEci77RxYRuvp20Y17yVCKEJIJv8k5AjC6Es5Bfhax0QIVQ3VMw
         BL0g==
X-Gm-Message-State: AOJu0Yx3Tfch4oGtVBwAojZzJEFchysQgXtAergyhb2JvnGiAI9m3K53
	kfoi5Q2/P0BbU1ypUo6jQCQTW6cqmkNDqii27j53GEVdms3F+GJUvGLgY35qKLMOqxVhO7ZoIkM
	2azg=
X-Google-Smtp-Source: AGHT+IFBW2mMfC/A1uOX5nC+Ja2o9B3szYgbN9OHzQtLcKELeq7AyNv0o/iynMN6HAKwJtmqYL40OQ==
X-Received: by 2002:a17:906:2f08:b0:a35:9a1a:620c with SMTP id v8-20020a1709062f0800b00a359a1a620cmr9676819eji.45.1707118826844;
        Sun, 04 Feb 2024 23:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUOAA/YniSLTzuLbO5mHwMc17/oIj0pikzJTY6iOFDaHaiSHlzPgUHeCAG9X01y/IQw7/3+k9jflcGmEngDH7kTaz2+GdJCTosxRhm0iWi+nXQEUAtkRX0P47/1KyVsMEO0Hs62/EWfUZZxVl6CycLc4Qwl6NcaIdc0IoyzbPQIYXuU5vb0Oxvx0GNk0Q6Pn7kYh84wlnXXjaw8mYZfLZYCtminqpTLZqQlhwEqBIiZjYRrynVZsKXB7ewk+RJKFxHChl9p+65IwkfgNQZLRhSgNH6oCui7FoVG9h3BdTg7roaKSe14iS09NnnquvK+BjL7tcMeaa9m7yDWGDwbXQqmz/uuD8JrbBiG7x1zduH14pkLmhHCAZI3tX0MJA2jwTFtCuV+ygQxGaFMq2f83WZ0+0fWTF/qahmAg5yF5HGMVK1/XLmGT1L41f5D81b9ndSDrYRueg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id st1-20020a170907c08100b00a35aaa70875sm4017567ejc.42.2024.02.04.23.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 23:40:26 -0800 (PST)
Message-ID: <bd253c6d-999c-4ba6-a80d-c7e077d1261a@linaro.org>
Date: Mon, 5 Feb 2024 08:40:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: samsung: honor fifosize from dts at first
Content-Language: en-US
To: Tamseel Shams <m.shams@samsung.com>, alim.akhtar@samsung.com,
 linux-fsd@tesla.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <CGME20240202212456epcas5p15589813cd79526e9d0c444082e2f0e51@epcas5p1.samsung.com>
 <20240202212448.74840-1-m.shams@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240202212448.74840-1-m.shams@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 22:24, Tamseel Shams wrote:
> Currently for platforms which passes UART fifosize from DT gets
> override by local driver structure "s3c24xx_serial_drv_data",
> which is not indentded. Change the code to honor fifosize from
> device tree at first.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 71d17d804fda..e4c4c9f4f9b0 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1990,8 +1990,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	}
>  
>  	if (np) {
> -		of_property_read_u32(np,
> -			"samsung,uart-fifosize", &ourport->port.fifosize);
> +		ret = of_property_read_u32(np, "samsung,uart-fifosize", &ourport->port.fifosize);
>  
>  		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
>  			switch (prop) {
> @@ -2009,10 +2008,13 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (ourport->drv_data->fifosize[index])
> -		ourport->port.fifosize = ourport->drv_data->fifosize[index];
> -	else if (ourport->info->fifosize)
> -		ourport->port.fifosize = ourport->info->fifosize;

I think ret is not initialized here.



Best regards,
Krzysztof


