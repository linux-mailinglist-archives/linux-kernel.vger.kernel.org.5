Return-Path: <linux-kernel+bounces-46005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B294843923
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C714028C149
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B35DF1F;
	Wed, 31 Jan 2024 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q37RelVY"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275F42055
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689973; cv=none; b=ZC5/pfoksk+nZxg9U2+mCMqAoL5gK2a+LjxGkEF9tuAt6Xk3Lp0Y7lJdJ6/yQatm9fDtlqHXjfDi4OaBrKa1INvGp6KYHL1qXPoJU6LJakxD6E6AB5FC0y4JeWLyPp3TL/+8uDlr17uy+tWSqP0X5boMc0rI9w0Zk1XDW7KhsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689973; c=relaxed/simple;
	bh=yw1eN8wIAGgmVr2d0+fFa0ALsi18715HRVLMQJvxpbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+rDZNy0GjZysFAKySx/i7PAYFDcyqwJZFdOiXHKIlNCGwtObmazZoEpjmlUjD+orxstohh6ASNgfqC/lHoBkwLwR8P516I0UR/IN3XuqhGUyeCwhaQlKvNlc0vxpNlwZpmiYtku1WR2jGUWhrW5RNNlVMqc0ZfNpjMIWlsFGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q37RelVY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a35e9161b8cso368457866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689969; x=1707294769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GR5aVhZneHFyoFCB3oZIB9MTp0pKwfBVVrj0ITj8IUI=;
        b=q37RelVYMYsXbL4Na3d/CvjF3lKTYsVBl7pKVPuVIJ4y7hVjoVmirsJDr7atN1nggP
         mcAsskXGAoYuDyP4giBdsrq8/VIARebgm6A53V01mzVPDXp0FjVcTYCAyVskY0EAQ8/a
         9Kept401eB0netH9SXJLQgkg/ooZK7Wx/IDLiFKXqR2roc341zYCL32mcrHSkRKRKSJK
         jPSWJtuRys59lRYxXKIiDIHnMtSngOzSuLL0rsWNwthJC15z0GSMViGDKDUgQ+j7oF/+
         v6I/XAnz4QrGH5ClnL16rDTaVdksldm6mae+hzNLAh8YPp9w6X2SZIsiWf1NmY4OMryp
         xUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689969; x=1707294769;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GR5aVhZneHFyoFCB3oZIB9MTp0pKwfBVVrj0ITj8IUI=;
        b=GuW2R+HJT0DUqSa021PehXK4zACGirPSk7atJ8jeB9/7e41Ntp1DFsqH/38g7l2tms
         xutNS/O4EM4FhsilmE84xkKXgGCV1pp6bur51zkzgTUHNK00LgY1C5uyYEAldcS1h5D5
         hwsPz5w7H3YkEKAFESDmN+CaAHt2xX+YrQHycRLq3EyrDXS546QTzLxn2kjg1LaPXRS3
         pzvmv5pY6i1z/dGu2xJZOX4hGatS4cKVgclH3KChkoGd5/S865bvcpWvmZ7t4HHS84xk
         cuI0m7oqXm6dGyQ4SKFUsPNedQiImI2URBwy8jJo9qXJ/IE7/6hcXhRaib95ZsUO4y0U
         mQSQ==
X-Gm-Message-State: AOJu0YytYN43NN+7Kpe56X3PYsmIfznp4xyr0ElsSCT2IdZR8FwVITuM
	P7zZtAp/KVBTn3ddn2TH3gyaseQeEN8n6ayjNUO7r8mMFSBn0jC1KpNu2yALnNE=
X-Google-Smtp-Source: AGHT+IFtfkA+EybiR1YliXWZqbPQSODeYreUd/8yXXZ+CVtwwanRt4sorZZtf8JuHr1umBgaXB3V4w==
X-Received: by 2002:a17:906:faec:b0:a2c:3596:b0c1 with SMTP id lu44-20020a170906faec00b00a2c3596b0c1mr619576ejb.75.1706689969055;
        Wed, 31 Jan 2024 00:32:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW5zJk84D6Kq0omYtneabIPmgjgoTzDs/mbrRpRaDhq6H6VOCcHjNpUbhsBOZ/M8CyH603jQQxrrm1MhLmaXeZ7O8eV0RT3DNSg+DS8/IRKCE+Q2HEOQZ7onJSGL5fZ4Lz4Vpl6LLo240x9FfHBo0RYS561vhsArl1KtpRaxmu7GdCZqZ9cec8DAR4K5F8bQHQ9sT5nhnMRO7UOkZ6Nu9SVgyCFyOppHYrkb7QiUcWTRQtXeMPdxbeSlhA+XloD2I7YhKYI7vJzidJdXjTUETAuKdvh8ie3BCSUd0bGmyPS/h8I3tKlMaMmcwFYmrEytSrmQbPqgbgIC7cZ2SqXexVQxfkT1CycUcuqOmNYJA6y88cYGYoH8ZQjA0FiiGxKP6dstXOc/+H2Ufr26ipg66DZo6HymYXDQiDGj0qN3+EPgzjaNA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a34c07816e3sm5919866ejc.73.2024.01.31.00.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:32:48 -0800 (PST)
Message-ID: <69783a3d-a158-4582-93d2-3f120e2e9ea6@linaro.org>
Date: Wed, 31 Jan 2024 09:32:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ARM: dts: samsung: exynos5420-galaxy-tab-common: sort
 node properties
Content-Language: en-US
To: Henrik Grimler <henrik@grimler.se>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20240130-galaxy-tab-s-cleanup-v1-0-d4e17857241d@grimler.se>
 <20240130-galaxy-tab-s-cleanup-v1-1-d4e17857241d@grimler.se>
 <a04aa883-d9b8-480b-a9df-8c31bef1165c@linaro.org>
 <20240131082401.GA6710@samsung-a5>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131082401.GA6710@samsung-a5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 09:25, Henrik Grimler wrote:
> Hi Krzysztof,
> 
> On Wed, Jan 31, 2024 at 08:19:39AM +0100, Krzysztof Kozlowski wrote:
>> On 30/01/2024 21:40, Henrik Grimler wrote:
>>> Sort all node properties according to dts coding style guidelines, to
>>> make dtsi easier to follow.
>>>
>>> Signed-off-by: Henrik Grimler <henrik@grimler.se>
>>> ---
>>>  .../dts/samsung/exynos5420-galaxy-tab-common.dtsi  | 23 +++++++++++-----------
>>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
>>> index f525b2f5e4e0..0c1aeafc025b 100644
>>> --- a/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
>>> +++ b/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
>>> @@ -103,8 +103,8 @@ &cpu4 {
>>>  };
>>>  
>>>  &gpu {
>>> -	status = "okay";
>>>  	mali-supply = <&buck4_reg>;
>>> +	status = "okay";
>>
>> Such changes should come from a tool, but since we do not have them, I
>> don't want to bother with properties re-shuffling.
> 
> Noted, thanks. I will drop this patch and send a v2 in a few hours.

No need for v2, unless some other comments pop up. I will just apply #2
and #3 from this set.

Best regards,
Krzysztof


