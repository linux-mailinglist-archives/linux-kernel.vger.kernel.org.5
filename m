Return-Path: <linux-kernel+bounces-25250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E4082CBBA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1731F22A14
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E912E52;
	Sat, 13 Jan 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eMWZUR++"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011A17541
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e62425c60so19004675e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 02:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705140842; x=1705745642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDetwflOykzL5RhAxaaI/u51dq18i05MsncmHilsi1o=;
        b=eMWZUR++XVu80xgAe4rMfMrjHqbNTb/y1pf8w/n8Irs1u9FtqFslwBHYhLqRoDX47x
         CHJWlp3BRbaGy58hbGd5rsvP99YPo5XUQHVWqeREW7+eK3ju0vP2LUQ2bcRnSq5bW2PF
         tg3u3vTheXWoXhRqIyZCcDvricY8Ux77ZI+YLl3T8TvGM134HUgA/FZToqfbN9mAlIvs
         ebdSFMicIVUcltpCPh1/ABjttPscdc5b3XNiUwlqr6fSvB/Yw9voDx/EGzj4+2QggTCr
         qcWbuSB5OX1vg9LiVWXLHCErft7uTOoUx51yWZUb8r17vgt8DoUdErqCKUy3UjE32UZR
         5esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705140842; x=1705745642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDetwflOykzL5RhAxaaI/u51dq18i05MsncmHilsi1o=;
        b=UA/m7xWTYUdEy7Zyw+/zRbYbqBNboGQi+aGAmBZq2B8yut25yr0E/V7keguMj0f3o4
         aEVnaNJpM50kUGPedcJh4HA2EyIoUHx6/9AOWoyYMk46Dan+8KHmtWECCLv6WIgqD0qy
         0xAYSTZ8RyNaqynQYRh0shePAP3F0xR+k9l2lvtJK9qaRZ5OFUiiLJ16SJP787GYpDWE
         JnBPjzJGUD3idxGA6wlNO6GX6i08pJnp9lIlsUD6y6spJdAHbIOajO4a+wcay8ddo8wq
         IyFU6hv8zHxnEbeF+Epny+6yIZTgVViuLw5GscsCs67G7jBHUd6lPl1v5JZi8M3FOtTF
         y1ug==
X-Gm-Message-State: AOJu0YxLO1fuZneuEqzHN0AOUfFKEkqybZv1kWd0IQaZUXInr8vvJ9T+
	dbiAxnRaIdS8QAocUYLpj1p6mJUAUdAeAw==
X-Google-Smtp-Source: AGHT+IFZ3DCtVK91Rdao2Q9Ai8lXJwRVm4MUO6nNsmnW7POWKovY0EtAWYNzwHjKXSN5iXVGrgWmqw==
X-Received: by 2002:a05:600c:4f50:b0:40e:5aa4:44f9 with SMTP id m16-20020a05600c4f5000b0040e5aa444f9mr1622321wmq.10.1705140841757;
        Sat, 13 Jan 2024 02:14:01 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b0040e4bcfd826sm8976075wmp.47.2024.01.13.02.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 02:14:01 -0800 (PST)
Message-ID: <a1ef3681-a3c9-47fd-ad9e-4e14182b1c1d@tuxon.dev>
Date: Sat, 13 Jan 2024 12:13:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: renesas: rzg3s-smarc: Add gpio keys
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231227130810.2744550-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVnsJfOtZPpr+_MRNkx-bSXrCm8Hy_j6Gy58WnGn_kaMA@mail.gmail.com>
 <30608a28-b1e3-4ad3-aad5-1033eb8adc6f@tuxon.dev>
 <CAMuHMdXokhEEARUSSY_x74A0eRGpeJ2Y30neMP57fnjRJ7HQeg@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXokhEEARUSSY_x74A0eRGpeJ2Y30neMP57fnjRJ7HQeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 12.01.2024 18:20, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Jan 12, 2024 at 4:38 PM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 12.01.2024 15:55, Geert Uytterhoeven wrote:
>>> On Wed, Dec 27, 2023 at 2:08 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> RZ SMARC Carrier II board has 3 user buttons called USER_SW1, USER_SW2,
>>>> USER_SW3. Add a DT node in device tree to propertly instantiate the
>>>> gpio-keys driver for these buttons.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
>>>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
>>>> @@ -14,6 +15,37 @@ aliases {
>>>>                 mmc1 = &sdhi1;
>>>>         };
>>>>
>>>> +       keys {
>>>
>>> Do you mind if I s/keys/keypad/ while applying? ...
>>
>> Is not actually a keypad... there are 3 buttons in a corner of the board...
>>
>> I see only 2 entries in arm64 and arm DTS directory following this pattern
>> for gpio-keys compatible node:
>>
>>  arch/arm/boot/dts/renesas/r8a7779-marzen.dts
>>  arch/arm/boot/dts/renesas/r8a7779-marzen.dts
>>
>> But if you prefer it like this, I have nothing against.
>>
>> Just asking, do you have a particular reason for naming it like this?
> 
> See the discussion in [1], and the resulting patch[2], which added the
> (so far) single user in arch/arm/boot/dts/renesas/r8a7779-marzen.dts
> 
> [1] https://lore.kernel.org/all/20231023144134.1881973-1-geert+renesas@glider.be

Ah, I remember part of this discussion. Good for me to rename it as you
proposed.

> [2] https://lore.kernel.org/all/eec1ccfb75c6215428609fdcaf3a37c75fe1fc87.1698228163.git.geert+renesas@glider.be
>>
>>>> +                       interrupt-parent = <&pinctrl>;
>>>
>>> ... and move these one level up, to avoid duplication?
>>
>> Moving it just near compatible will make the schema validation to fail with
>> this (driver is working, though):
>>
>> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: keys:
>> 'interrupt-parent' does not match any of the regexes:
>> '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$',
>> 'pinctrl-[0-9]+'
>>         from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
> 
> Oops, I had completely forgotten r8a7779-marzen.dts triggers this, too...
> Let's keep it for now.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

