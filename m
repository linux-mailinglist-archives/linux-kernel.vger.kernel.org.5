Return-Path: <linux-kernel+bounces-61817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71458516EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BD71F21F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A713F1E4B3;
	Mon, 12 Feb 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtNtKiyD"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE703A8C9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747631; cv=none; b=DxvKfK0QwHz8wPUYROlstIKMEGog6f1rnu8U50Vs+IUWI3q+j+YUkUMs5VeWgndVJGr9sGNyp8HvHesf5vigU3M6+MonSidYIwJtybw99LaW6QJUjABdpEZoXosbINXJU+gsT4sAWlP2QllBmSmga8NTZHcFth/9bomhFv/v7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747631; c=relaxed/simple;
	bh=IhQAKpuPrgzYPj8eGChOmKdNzeEYV7muCE4GmdmJGQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzcFlzf/UBRO+e0B0PENt/Yv6LLOfN9zLxS5WaRoq3YtYKfjHjBjYYtZ+ACDyZOOAOcFW1fCnsvI539kZDaAkk9DifhEQQJtb6vUwaVHiI42519tUrDUVElbZScBeyOoCamJy4LCv2Qt6PUsQ91nMgTvv3nn/5CjKPHuYsZIL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtNtKiyD; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c031a077d5so1278002b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707747629; x=1708352429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyBJeVAbVLOUugM8uBMgD4ijJoIOfpy1k/OkoITELdI=;
        b=VtNtKiyDunRbaiZFiHfe3G+NrKpBZRLUVMeuHCILbMCskPc8yOP7DKvLEGF85Kq6Do
         Dr+O8Ifwd83NXWYM7Lw7LItb+jpUjSY6VdqliROZKseVYul3P9jO0x6dn6kq0tz2uifg
         pzVZxADsx/rGTcdaPmD6iXKqFs+UnGgqre1l+hLWyMwe2aN9ZzoIiGDv92+RJflOzGve
         6gv3I/tMgNeV4VyE+ttJJE2f9qsnEzNqjyTlXnvBst+fa18OUSEG759JqA1u8Ym2r7+A
         xuaXbeQQ2/UekdW35avkS5QmHHq+lnhOiyFOvktrQQoOcjX2C7u9E/CwBvuUXBIEBFoT
         FXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707747629; x=1708352429;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyBJeVAbVLOUugM8uBMgD4ijJoIOfpy1k/OkoITELdI=;
        b=NA0nlrTGXiRRqfqE+seL/jX6uyp/JnPRkf0Nt25PniSklK1RtADygxuNo4TtF9KDQt
         W8aXaydOTJmUKnE7bxuH7t3NhTvSlL7u1iAT8pIQ0dnCVgK6/6Z7PzVtBWV2IY+48jY6
         pjMXAC5FnXiYpwGka2DpR+ZrKRSexPaIEyfKenm92gLlE/mBQM8SEl5d1TkRrfQWzMqD
         y2eejShbExP9oP4XyvguphTkwyh3qUO//nYARyhiM0T6UZWAGzibOIiax5ElcFiEUoNA
         WGOdbWhpTXqAXGxwa8g3D0Rtenr8+rDl3UXw0fQjAga6tHUrZNMFkE6QRkGz9kJhRtwY
         busw==
X-Forwarded-Encrypted: i=1; AJvYcCXb831g8IaygMgAhaAKkUkYQkh0O5ad784C0POg1oNN/ISy8taoay/WTpRLoUZuipyvRp1/dhzjU4Xr4oxcna5xRo3NOfv+Puh2GP0o
X-Gm-Message-State: AOJu0YxixiABjygU3NQI+VuVCpKl8A8c8ThNu8dYwKhs3n1YBbOeUjPa
	Ld8tnCjdFxuJsvnjVadSHCmf1edFuaIpPKG3KxmVyZB68DYEi7sPhALZUuf8kB0=
X-Google-Smtp-Source: AGHT+IEGwcabb0YbhKwmetbqxIxk8MR6hwoLl7QmVWgc4fBr5tMkd3EHAZxNjeVus+2aEpCRzz2hUA==
X-Received: by 2002:a05:6808:4384:b0:3bf:e02e:6429 with SMTP id dz4-20020a056808438400b003bfe02e6429mr6045776oib.24.1707747629328;
        Mon, 12 Feb 2024 06:20:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnJp0TmICHcK9u990k/r8Wr9NMlUp/F3Ktj/d4g2A/wGijqSF1rMoOayxG2H2BfX+C5y2JDzQSNOpLI3Cgjr0+F2CbVR8MU69JP8+uyTP3Z/h/XdnIaIkNED7ihwuEYahQlncrMl/gpAmiT7u2DA6pPWHd+sBdmxx1uMSYuqf3F1PkbAEiNR9S/T198MlN+V+Nll16+VJNpr3ES4UMxzKhI5HxxMXNyFIENiM80W/VHOHk1bx2UpwGje7A5GYQlJUa41QhF2ePbN+KcWLcAMXTaU96Kf68E2i1AIVhxVDKF1MQIDqK3QE/GQD/snBCjArbRdeMRcGORv4/p9C6IHBTGpWS/U3v/QwFHcxg6Rep+s4UiAVqIuNG32US3Vb0xf4Zqx4P+c+qjXguGZo=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id pe5-20020a05620a850500b00783f77b968fsm2053452qkn.109.2024.02.12.06.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:20:28 -0800 (PST)
Message-ID: <b836cf9d-dc71-4835-b45f-1092aafa1dfd@linaro.org>
Date: Mon, 12 Feb 2024 15:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit,hd44780: drop redundant
 GPIO node
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda
 <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <ZcofhWb8stiddmru@smile.fi.intel.com>
 <906db6a6-48ba-41e5-be23-1dea0ecf96ee@linaro.org>
 <Zcomjp9oH9VfO3NA@smile.fi.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zcomjp9oH9VfO3NA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 15:09, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 02:56:43PM +0100, Krzysztof Kozlowski wrote:
>> On 12/02/2024 14:39, Andy Shevchenko wrote:
>>> On Mon, Feb 12, 2024 at 09:34:24AM +0100, Krzysztof Kozlowski wrote:
> 
> ...
> 
>>>> -    i2c {
>>>> -            #address-cells = <1>;
>>>> -            #size-cells = <0>;
>>>>  
>>>> -            pcf8574: pcf8574@27 {
>>>> -                    compatible = "nxp,pcf8574";
>>>> -                    reg = <0x27>;
>>>> -                    gpio-controller;
>>>> -                    #gpio-cells = <2>;
>>>> -            };
>>>> -    };
>>>
>>> In patch 3 you updated the lines that have lost their sense due to this one.
>>
>> How did they lose it?
> 
> Now they are referring to the non-existed node in the example. OTOH, there is
> already hc595 case...

All of the bindings examples do it. It's expected.

> 
> The Q here (as you pointed out that it's better to name nodes in generic way),
> how these names are okay with the schema (hc595, pcf8574) as being referred to?

They are not OK, although I don't see the name "hc595". There is phandle
to the hc595 label, but that's fine. Not a node name.

Best regards,
Krzysztof


