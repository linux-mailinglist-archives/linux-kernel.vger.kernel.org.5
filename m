Return-Path: <linux-kernel+bounces-29166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD48309F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67D3B24CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFEB21A12;
	Wed, 17 Jan 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbZPYEKU"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4821A06
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506111; cv=none; b=BzyGrGlCgWj4fOXkV6y89Xrg/BknZ8QBSilJwTgqMuxAmOo+aHr1wqMVfHNky/kXgpYx/McTa6Ea7ID/uHTAYMWeLT6m6sv9lxaQ193xp8uFK041cT+PHxoY9HgdKMA678Zp1CVzMmQt9cMt8POZm7VJr+HcsqbFuiXT1gDBm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506111; c=relaxed/simple;
	bh=vHheadTKQnQTYXZrVwuGynn/8EJeowYAzDnoEsdgR20=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=hn2MlrkjqbNO+jAS1vr+T0nfVvv1Oee624gnocWH2UhIV20eEn4sTwgDUsrrqmJro0ISnPmrdul2fsmBxZ8f6PzzUR9vxF8IHNAHmjzS2X+e0hLUdAhzs+eTq63bFIpfsw4N+z43QI2YFTEUI9UsJwHReCiIA5l+wec81tlqZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbZPYEKU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2dda9d67ceso379499566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705506108; x=1706110908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fQy90wubVF9sUgzIcE4yEfTB5Nsm0VF+3ircigyYGQ=;
        b=lbZPYEKUjyrplCDkOIMGTAHXfTVuKWQfPUYmPUPNusA/MPMljYyMX9KMhYaFHmc/L5
         GLufz+L2KDPkP6+Qbymg4ef8g3eQ87DlMnSYXgKG4X53umV2wkk17s/zwuazy7kWYx1c
         I05bqX6DODANH1K9mBZBesATdbMtdY4pncPJaNo4dr50Ey3PXRC/aAZg3ugcCZL0UHAo
         5s/zR5EcbQGAg9HHINJTWProwDhKh1xedxhwcSaz5tfekv245+J10CgUiicOIPfW4Bsd
         rYvfF9JMrjO3jtSVuUwAjZMctxt8QiCXsBcSF7KZG69MdaWCvRHPhEfZotYQDguT2VEw
         kcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506108; x=1706110908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fQy90wubVF9sUgzIcE4yEfTB5Nsm0VF+3ircigyYGQ=;
        b=ipgAJaawnpzG4jLAg5X/FCgBI8GnTvgmG+ep5oCliA8wysTsE8B7v6XB9qFungUaut
         MxI1ZKutOcBqiYPLmOn15IvkUvWsVn5ND3E9Xpx7mN63XpSm39Gm8hKxyXkIRPe0hWCZ
         9H1p2KzTPVpM/q8ruWdcoI4u9zF00NOoGfmpBy2//r+IOVNCvX9v2Zr1GdkB9I/QFujI
         scKde920kVcGtmMOjCWmlrDrOsEVzEzjV2Iagt2WjwtxL2vWB3d+7yDTbMb5okHSWfJ4
         a0dkhwsr4mK5mL47JNczuLhFKfsjdV34NkLH3cDPHzC8t/4nFm9AsJIZIqgIjcgTXq9M
         4vAg==
X-Gm-Message-State: AOJu0Yz0C0OzCffHbM815cbjlwmFkmbvAAyOyqsSTose22pSJwCgPHiX
	ZoljN8hw7ugnPqyZZyaBzdtSbTK+QwsURw==
X-Google-Smtp-Source: AGHT+IH6sUZYoZLyrdAyeTyHowfW9FJUNk/hfgFlCDe53Ai+kvCACnfWXb82GjAet9JFj6uuOuoFFw==
X-Received: by 2002:a17:906:a08a:b0:a27:361f:f604 with SMTP id q10-20020a170906a08a00b00a27361ff604mr3995772ejy.47.1705506108050;
        Wed, 17 Jan 2024 07:41:48 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id wr8-20020a170907700800b00a2e08b24ea3sm3240579ejb.174.2024.01.17.07.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 07:41:47 -0800 (PST)
Message-ID: <6b6b1512-18a2-48bd-b284-8f4deff84309@linaro.org>
Date: Wed, 17 Jan 2024 15:41:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] tty: serial: samsung: don't compare with zero an if
 (bitwise expression)
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-12-tudor.ambarus@linaro.org>
 <CAPLW+4mKBwsc9VLrGTd2k6d0n-K9TZAjH6M8trcK3Av8TQ2Ngg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4mKBwsc9VLrGTd2k6d0n-K9TZAjH6M8trcK3Av8TQ2Ngg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/16/24 18:38, Sam Protsenko wrote:
> On Wed, Jan 10, 2024 at 4:24 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Since an if tests the numeric value of an expression, certain coding
>> shortcuts can be used. The most obvious one is writing
>>     if (expression)
>> instead of
>>     if (expression != 0)
>>
>> Since our case is a bitwise expression, it's more natural and clear to
>> use the ``if (expression)`` shortcut.
> 
> Maybe the author of this code:
> 
>     (ufstat & info->tx_fifomask) != 0
> 
> just wanted to outline (logically) that the result of this bitwise
> operation produces FIFO length, which he checks to have non-zero
> length? Mechanically of course it doesn't matter much, and I guess

that's a bitwise AND with the fifo mask to check if the fifo is empty or
not, it doesn't care about the length, just if the fifo is empty. IOW if
any of those bits are set, the fifo is not empty. I think not comparing
with zero explicitly is better. At the same time I'm fine dropping the
patch as well. So please tell me if you want me to reword the commit
message or drop the patch entirely.

> everyone can understand what's going on there even without '!= 0'
> part. But it looks quite intentional to me, because in the same 'if'
> block the author uses this as well:
> 
>     (ufstat & info->tx_fifofull)

tx_fifofull is just a bit in the register, in my case BIT(24). If that
bit is one, the fifo is full. Not comparing with zero is fine here, as
we're interested just in that bit/flag.

> 
> without any comparison operators.
> 
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/tty/serial/samsung_tty.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index dbbe6b8e3ceb..f2413da14b1d 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -988,8 +988,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
>>         u32 ufcon = rd_regl(port, S3C2410_UFCON);
>>
>>         if (ufcon & S3C2410_UFCON_FIFOMODE) {
>> -               if ((ufstat & info->tx_fifomask) != 0 ||
>> -                   (ufstat & info->tx_fifofull))
>> +               if ((ufstat & info->tx_fifomask) || (ufstat & info->tx_fifofull))
> 
> Does this line fit into 80 characters? If no, please rework it so it

it fits

> does. I guess it's also possible to get rid of superfluous braces
> there, but then the code might look confusing, and I'm not sure if
> checkpatch would be ok with that.
> 

I find it better with the braces.

Thanks!
ta

