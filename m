Return-Path: <linux-kernel+bounces-167384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F908BA8C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6FFB22916
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AE514B075;
	Fri,  3 May 2024 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/DgM97g"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33B14A094;
	Fri,  3 May 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724968; cv=none; b=Au/ekzfusqwc5Y/8qfLX33xgtrmrLEbqZcSNnq+oCYOQo2QfoPZC1BkJuww6TviYYicRcbdR7KUs1SmBv8irjrgPXdfl4z2w4EUOG3NKqFSuYgevjWylmnKBrbDVfOc0SzcDVaaWXxyg97EDazCZ88VmSK2UVKDjHPrTpR/sYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724968; c=relaxed/simple;
	bh=z5tMOh05w4CILYxa4gJ2C2oMWNfnKPqfAztc64n2xRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZkirGn1Y390YJAAYexZALzNhIzdC9mFuYSgDRyGTLWmy6p68+nwauPyvQ5A3Whuhog/ccsQnxPQ2h1Tb0vsPLEuxK0GsuJvK21Tvj7uzgr7EoonrbEwkFY7X65ePcOTULBzQWYvjS6HQlkS8aSyw2OhC+RthyAAmrzjcVmfNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/DgM97g; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a55911bff66so1196595066b.0;
        Fri, 03 May 2024 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714724965; x=1715329765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg8/6y6GN9WB0V95WSfuKyZjIjlt/v4twVQhV3jB5sI=;
        b=W/DgM97gz7iT4U7XXzl7oVmTIcnnkaeySLW5FbPFwRaOy2cpE2OEYqagBdjG5WjtG2
         Y5028qF56n9lcVxT6iK+AWePDS4szcXxR/M1WUVE9MB4nnchLyfI4AsvNHzuKR5wPfqK
         FtlILCdD0AVXFx4n6nmr5ckfVHWioXOtGiEfJRpBa2HCCpA/MZ4VNtoATXHxVV6c54ym
         cI6gF+L6YVZu2PxXhtG4P8Z+FMI0OBWyaMnFMB02LJQi5dJ1zRcI5JEGyh+j51iEP5Bj
         YTs4kXD5QY59bfcXssWTXqNgRSZ71r9x3XjVucKmtbdEcpS+UZQ/UdadVBpXRag08ZA5
         Jj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714724965; x=1715329765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg8/6y6GN9WB0V95WSfuKyZjIjlt/v4twVQhV3jB5sI=;
        b=jpESDbQOwIORP8OUCri6jgVPE1oK+lXW+6mHe7p27O5mylU69+quIXV+VV6r2F0DaK
         +qbLyKOWqhg/KFWAl6tVo01TBr63VqiT/NqJLB7zx504fjOjGXaJq66kLfT+bzd7mfz7
         Wdwd+ACKsEt5beeScZ95HJE8klpf0e4/KzJ8/tE6q8lbrqGFe/qSpin3TatFkQCuJkth
         zWF23pZGybOdeY4fQi2NcPdH2xIbVn1cSVJ+cy3dXObIGTpOpyTbavhqcNo3hRavt+RA
         ZxhZupKH3fA7o2YKZDJQlyi2C9BYPz/xu5l3q04rZ8HXB9IgUPUfuOFgMKhJ5JSQpZ5I
         1LqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBZx4uLIXiU3K0f9LD/4GiPYsiwB+XeV0aFWlAjANgxia92BIgADKpkB+tZlPNpRroYEoFq7HgJt5t+LPDIZ+pkOTq2W4Ryy8qX8C68IwuMZVyE/bQ+ThW/Q7w0FWheRtXzy+VqRALAVLXP3+k6rafNy0V1k3kKZEYV0t6WSdqDC8F9b4=
X-Gm-Message-State: AOJu0YxVJoUwv0kJIFoeXJJPfZccdGRmIHJkS1SQXYhY7wW6VCB+Mq4S
	xN0ZELMow8cBuxbjFh+PW0rj4RHMicfE/zNQLH2VJ/IEldWcbYM=
X-Google-Smtp-Source: AGHT+IFbtr1hO4RS4o1oD7cS72QVf7gnw2fLXLrura2Ot5OWVY9QalK17siCBOXrlh9kiMPIQG21Qg==
X-Received: by 2002:a50:a6dc:0:b0:572:707f:1a99 with SMTP id f28-20020a50a6dc000000b00572707f1a99mr1057866edc.25.1714724964848;
        Fri, 03 May 2024 01:29:24 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:3a09:7a12:14f8:ab07? ([2a02:810b:f40:4600:3a09:7a12:14f8:ab07])
        by smtp.gmail.com with ESMTPSA id bd14-20020a056402206e00b00572bd30320esm1441904edb.82.2024.05.03.01.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 01:29:24 -0700 (PDT)
Message-ID: <d02920dd-e5b9-4280-a7b4-853f10c22a70@gmail.com>
Date: Fri, 3 May 2024 10:29:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add RK816 PMIC support
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20240416161237.2500037-1-knaerzche@gmail.com>
 <171472425816.1279735.1509285489643125462.b4-ty@kernel.org>
 <20240503081824.GI1227636@google.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240503081824.GI1227636@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 03.05.24 um 10:18 schrieb Lee Jones:
> On Fri, 03 May 2024, Lee Jones wrote:
>
>> On Tue, 16 Apr 2024 18:12:32 +0200, Alex Bee wrote:
>>> This series aims to add support for Rockchip RK816 PMIC series. As per
>>> datasheet it's targeted for RK3126/RK3128 (RK816-1), RK1108 (RK816-2) and
>>> PX3-SE (RK816-3) but might be used for other SoCs as well. The MFD consists
>>> of an integrated RTC, a GPIO controller, two 32k clock outputs, a power
>>> key, 3 buck- and 6 ldo regulators, 3 regulator-switches, and charger with
>>> integrated fuel gauge. Charger and fuel gauge are not part of this series.
>>> Two of the switches (otg/boost) are part of the binding, but not of
>>> the driver. They must only ever be enabled if no battery charging is
>>> happening, but it will be enabled automatically if a battery is attached
>>> and an external power source is connected. Thus that needs some
>>> incorporation of a yet to be added charger driver.
>>> Integration in the existing rk8xx-infrastructure was pretty straightforward
>>> and only needed very little tweaking. In order to not further bloat the
>>> driver(s) too much with additional `#define`s I tried to re-use existing
>>> ones wherever possible.
>>>
>>> [...]
>> Applied, thanks!
>>
>> [1/5] dt-bindings: mfd: Add rk816 binding
>>        commit: 06dfb41b1cf8d64327e5c4391e165f466506c4f0
>> [2/5] mfd: rk8xx: Add RK816 support
>>        commit: e9006f81faf8e438ea83626db578610e49f31576
>> [3/5] pinctrl: rk805: Add rk816 pinctrl support
>>        commit: 1bd97d64b5f0c01d03ecc9473ccfcf180dbbf54a
>> [4/5] regulator: rk808: Support apply_bit for rk808_set_suspend_voltage_range
>>        commit: 9f4e899c286b5127e2443d50e37ee2112efbfa2c
>> [5/5] regulator: rk808: Add RK816 support
>>        commit: 5eb068da74a0b443fb99a89d9e5062691649c470
> Submitted for build testing.
>
> If successful, I'll follow-up with a PR.

Great, thanks a lot.

Alex


