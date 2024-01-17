Return-Path: <linux-kernel+bounces-29149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E883099D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906F91F227BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DC219F7;
	Wed, 17 Jan 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMoUMe1S"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02035219F1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504869; cv=none; b=dwlZUgnPO4NHCTMozMq8fmrcOgy+Uj+WXZ3cfYnFuWJL3GZ2X42vtsEjiNPwsJeOUDzLs3egolEMiFtMx75H3pxPSYbsLmVgP+84r3GW0qatLjVttV27cmaf0XaA6Y2w0hd3sMTNcm3T1bvHXJKz/aSmzfC5dnKGK0F0uivIzOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504869; c=relaxed/simple;
	bh=4G1Tn6v7j/jLr+kYv1kbODzvvKkSNeQrP9leqIw7tns=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=kevMgmBEPCYK22xCI/hpvVYSAqYsNyj5/T2BtviUowNOmgC3tqcnCvnnZPLoH2/70iQpz89eKjyVs5ZsIbBWXIhohX7H6Ohxm1hKe94qr2esTchK0wvF5oe05dvv0Imvpw1eLFBig05Go8U4NkoF/M3axhxc+c0ii9atXejfnUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FMoUMe1S; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so19718561a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705504866; x=1706109666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6mXkwaeC7f3VoPVkeFuNIXjvDEXw6n2C1AO6L3ywPQ=;
        b=FMoUMe1SQ2uVOm+FVqQlSxHopiO2pmponK4IlCCDjOwRBw8Qy+n6U5inzzGzJZP5m+
         EVpxUxi7tccR/ib4lPBKsLXsOGzRuNxCgWjvfYqqrZxM0CleQIpywSgdNLeHFLlyJnHF
         nbq6pvZduB7auGBmC6ZomnFC1QrDS2DJASNjQvGTOL+4d1angv0gkVdylbBUPgZxKP9J
         5fgp+JlCsZbsTi+BvSGVeWdPr8/rNa5zPDVT0cJCbIsvvmb/AcMp0mva9JKvITiVFt19
         CS/RJ7zGt0F/IaTcYNdKf8Dei10IxGlzdwXFvvfoN8qa8UOkRrWHubmhSivOM5I9zyxD
         I+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705504866; x=1706109666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6mXkwaeC7f3VoPVkeFuNIXjvDEXw6n2C1AO6L3ywPQ=;
        b=Kivd2FUNAi1goBXgnwaeZGG2A/kWZj0R2SHoTzn3IDm15WP50x2Pkk1/tIcVkkwI99
         RPMAV/bpJq5xfKD60m4ErTeaWUj2UQModmkVl8fAFWe1GXLOy9QMhSGuy1tPLYGwwgOl
         4OYoVp5G0IhtTdlZNMwryg56jtHMgGN6CJicfUybASKuWqRX+PILkaOMyt3kCwMcIds0
         whQ+YRXDcdmOa4cm1eR1N/TY6oECKtOduKmQVzBQJWvbUR7yP9kirqCoDSQLX8/zxijX
         uTBgbIfdfAXIhD16Bq+PRAo96+rR3zGlkHFGfOIEianlmXHuJUBQebTytOc5ptkBLzfZ
         wCFg==
X-Gm-Message-State: AOJu0YwcDE97tLfi8E6GiFPKLfLdc2LwON+Fzm3FY75rV4bEBn3WbyCM
	1Ct9Z8HVXWGJLQBhtZMpcShD62Ep+Q1Q7A==
X-Google-Smtp-Source: AGHT+IEe1isqvANXjeZi6N5z+PBOsdfsSdSqLqyAM1UWT6D8Aei+PHlMhoR+M/24YwkRm0sc6tSzIw==
X-Received: by 2002:aa7:cd45:0:b0:558:abf4:69c9 with SMTP id v5-20020aa7cd45000000b00558abf469c9mr1058985edw.6.1705504866271;
        Wed, 17 Jan 2024 07:21:06 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id o9-20020a056402444900b00559dd0a5146sm792527edb.44.2024.01.17.07.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 07:21:05 -0800 (PST)
Message-ID: <b21a54a7-fe13-4a29-8e7e-6b653d5c24ef@linaro.org>
Date: Wed, 17 Jan 2024 15:21:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-11-tudor.ambarus@linaro.org>
 <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/16/24 18:21, Sam Protsenko wrote:
> On Wed, Jan 10, 2024 at 4:23 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> ``max_count`` negative values are not used. Since ``port->fifosize``
>> is an unsigned int, make ``max_count`` the same.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/tty/serial/samsung_tty.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index 90c49197efc7..dbbe6b8e3ceb 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -760,8 +760,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
>>  static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
>>  {
>>         struct uart_port *port = &ourport->port;
>> +       unsigned int max_count = port->fifosize;
> 
> What if port->fifosize is 0? Then this code below:
> 
>     while (max_count-- > 0) {
> 
> would cause int overflow, if max_count is unsigned?
> 

good catch, Sam!

I'm thinking of amending this and add at the beginning of the method:

if (!max_count)
	return tty_flip_buffer_push(&port->state->port);

Thanks!
ta

