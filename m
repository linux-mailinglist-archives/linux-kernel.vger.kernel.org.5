Return-Path: <linux-kernel+bounces-48244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDD845909
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F3BB25C76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29135B686;
	Thu,  1 Feb 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWkQ0fk7"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2B86647;
	Thu,  1 Feb 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794619; cv=none; b=lmONTI7lUV8VqHNknA3egSHQ0qBUwQeXp+Tia7JtP7VJTLXFutz01MJH2XVmiLBzIrleG3BiorU2ehuQXL+BHfYsuTs9UejKS0Tf57jDF0SRjGWygYk+BB1iXva4EgdukWIEL1NFtzVIAkS0uZFJyfy0qLCYPNJ9RssOvdpodbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794619; c=relaxed/simple;
	bh=Y6xuwZ/UytPs1s0uPT289WKmjRvZNzYA5jAUKSKRGow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crxZR0BtL5BdzPySo+PihSRYzSfUPBGNNjuGbjM2LentuqJgEjGzlpkxPxRKRaI74W3rrBaBvN0XXopt+ZZg0/ZSCMaS0zlCjM+Au6o09uoYLLvPlKZcy5N/c908Qi4z0JDMkDOm8UlW+sEUJJXJR5UTKhaPClk0NTX7AVrykVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWkQ0fk7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-296043e44caso707951a91.0;
        Thu, 01 Feb 2024 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706794617; x=1707399417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NIOY7HRa3XDmbQkCgZJQXD0Vyc4i5CecSgVuCotRWD0=;
        b=YWkQ0fk7yeKg4suSY7ZrfpfDCHwGnZ//QcV0eoWH1h+jWbRlf1Vbjps+Eun9/NcX6V
         Px7kQLFFYzQqxV/6BkS+r2sgmUl8tO7SrXS4vgTLS5uxfMkmAlVe7IFDBtr1iAm29Xrf
         a6yCMVsQC8yXSpuTHv61Ec4QJL5szekeGYji6ZWSC5KqpRMjddY7J8Q4EfxQGgkavKFV
         IN7TwJX1XUGtzLPFFmXOCWGw2zVo56liYSm2WbUFsVh88mdI5dGV1FZBV62t5nHOrjDW
         X/vLwpvM7G5PFBlMBqkN5W8cNVwhWSB6YMDtW+gFdQDC/vlfEDeksAyR59pSbT/lpSk9
         IbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706794617; x=1707399417;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIOY7HRa3XDmbQkCgZJQXD0Vyc4i5CecSgVuCotRWD0=;
        b=UdFXZ/p/JoI3gc3OaZ8jGfaimIqXpovt7KoN/o533hTAppT0+QYSSnG5wI+WCZKVz/
         yS1sMUYCNpfIqkNBJT8VdcO5Ex3oGgF6sbehmaRXBrtrzQNkhlDgRAYrp6Af/mZLPnVh
         L29Nt0dzlgfvr+lv6oZjrKwkUNIG6+yTCJeXs4fSdPs1Xla5BS3o2CUArfJD0pr5Zpis
         FaB0cN2YPayUdXWkcNd3V0uoKZyechGgHu7ThKzwlOpNcBPix5zIb9oS3MCsEOCX6iqF
         Z6lxnpZI2W2qeuiWaJ8IEk+jVirDYtiY+Y+vV8z+D+QEY4ucqsVMeT0mlr4By6HsSUFX
         e/eQ==
X-Gm-Message-State: AOJu0Yz3Y2BxCcIiLLHCmRNLIADzSXnlSVSrGQ44cnsDLuJ4BpW4Tr0B
	/ewVIRV2red1WKjENY4ZpRj4yPK/S36ju/eOcp6RhUToqauV/wgLzwzYwy/4
X-Google-Smtp-Source: AGHT+IE87mn1kUx7KsvJ1kw4VnW2wGVQtKQwjkTKGie4+oCKmaWmUVUSmze+c//NEmTWv422isLx6g==
X-Received: by 2002:a17:90b:30c5:b0:295:1a47:d70f with SMTP id hi5-20020a17090b30c500b002951a47d70fmr4515280pjb.3.1706794616765;
        Thu, 01 Feb 2024 05:36:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQvkuKLc+GA8XZDsVfJEW8YCYHHXaoiokTfChGeswxJcXBRwpxku4nd4z4lzDUtkS2Mf9VEPr2adPz1vyS+YYQ4PskLASl1MhD70R+mF3X82bhDAmegRqmRMSOlq6yz4Gcas++UsC6+zL7NEeqQiNfl8FStcbow3WzAe1bEVjtsnRq2L4WU2q0zsRjpd6bow//EH/XDkbU6uXzz+5URKUL862vxnk0EcbHBObTM0SaCB2agpVvZik9ZoJ543PfKe2xTcjfn5gWQ2lyM/bZ6K/lym/kWVtvnuUH6oq6Db2c5KX8HggmtctiDgsgBvzaLNwFRK1iOfAw67dsHCZtzNhW7kaiZnEoooyVmukRV15QH4CYfnyPQiO65OG/2X8De8jC9OhgmXhkjycfQDgVobcBGiUThKKCQbp4NHXgqn8bJ5P3tk5pQLhfSPURNlo73wa4Y0vxrPqMTXD6Bsq7aXg4H09ld7Z1MqgbN3i0pFUpTAd0caZ12WZKoBKsxSRtOXkXO3J+yzrKA1N8GEkcl0pE0i4I7DHBUDWzGCMqxAavVa/WWH0KqNT4yoo3kBB20gCDEHT4ufnFZ84/c5188juWpDgrSqoXblJC4BpmN1tYwyVPaUDzlBkkhTCVwVY=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pb8-20020a17090b3c0800b00295fdf538e1sm2443191pjb.12.2024.02.01.05.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:36:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <313ec14d-c991-4bd0-a964-5759db108855@roeck-us.net>
Date: Thu, 1 Feb 2024 05:36:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] watchdog: rzg2l_wdt: Select PM
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
 <20240131102017.1841495-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUT3XFz2a+iWxrT2p_fbe+QCoXuhYprcWY9v4e5KA5q2w@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdUT3XFz2a+iWxrT2p_fbe+QCoXuhYprcWY9v4e5KA5q2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/1/24 00:52, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, Feb 1, 2024 at 2:30 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=y (e.g. the
>> clocks are enabled though pm_runtime_* specific APIs). To avoid building
>> a driver that don't work select CONFIG_PM.
>>
>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -912,6 +912,7 @@ config RENESAS_RZG2LWDT
>>          tristate "Renesas RZ/G2L WDT Watchdog"
>>          depends on ARCH_RENESAS || COMPILE_TEST
>>          select WATCHDOG_CORE
>> +       select PM
> 
> depends on PM
> 

Yes, I did not want to suggest that the driver should _select_ PM.
Sorry that I wasn't more specific.

Guenter

> The availability of PM is architecture/platform-specific, hence it
> must not be selected by individual drivers.
> 
>>          help
>>            This driver adds watchdog support for the integrated watchdogs in the
>>            Renesas RZ/G2L SoCs. These watchdogs can be used to reset a system.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 


