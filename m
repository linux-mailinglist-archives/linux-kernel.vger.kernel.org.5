Return-Path: <linux-kernel+bounces-44053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B554841CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E841C2573E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01F524B5;
	Tue, 30 Jan 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFycYLGe"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDA524D1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600242; cv=none; b=aUEGYGLn1eXOxK3qxkvPVOEMv7trOmciMmZqDcFMCd0Aek5sfjyq4tAiOIyUjHePb396a890auwFYrNuJcMr8UpSQwKnG8GDZkJ+d6TXHCuYkFrHYQuQs8PIa2nmKvBd5khLfgdPd3uFZcBi2OZFMfVup4a+I5Dr2GZD5rCxjw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600242; c=relaxed/simple;
	bh=ACTir32HymE0CC38XtAl5VcnMtTkJP2cpwHUffbxKhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rF+rPwxneumYyZuIr56EKxN9hkuwlTCiyciO7vf2vArHwgi2c1dbPq4WAFZvEsWvbljlDxvgEeSVSdWWj5/il+GGZuZJ/v75npeUghD/VlJjW5m8KS4Gi0gdRf1Ae9NGzNctJYgxgh+4VZCFaZTlTocHaq78yGUNyGaJaKMaQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFycYLGe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so1214463a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706600238; x=1707205038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYRwj5TM3vf02ly8MM0afv8cVsWp35r89nrVDKEcFOE=;
        b=RFycYLGeYMpzdkaNiSPEkjZjIzSsV8I4ZSJ9JkHMaVZZDaKUsWXFs0lRAFIJhZt7Ga
         RQVd+HrJlxyFiWcHGY18f+ca+v4VanNUnap5boo/KyGgmLSSBDK3gn/nl77yC34NKABM
         n17vwsJKWYlo5E0ykEGIpzIO7h8AU4EpoiKOk5sPLtOInAqG/GAH2nrU2A02PYT/VA2o
         ff7Abc3FsnHHlz6l8Yad8RMaY1apjn5YPuyB4qKVH9DhpQHhncUQ6W/uY9pZSg/4Tuj+
         w6C9AqsulktCTtENFJ53mXct9s4V/S++VmUgHyWOB6BjZUFPpD3qK6z898yddbG/kif/
         N63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600238; x=1707205038;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYRwj5TM3vf02ly8MM0afv8cVsWp35r89nrVDKEcFOE=;
        b=bCSjoqNsHWsR+VtU6ZHXNXlzjhWxVQnlraPJXA7wHewmLEuoX67B00uA5QksU+xzQ7
         C7E1Qa8DGdRupDPa6bbQ1y/qH9vm3fs6S8IMTGJnLDXplAZW9om/jPKOJbFWXRR6LfO/
         Slc40m083j1qXbBihSK9P0FkY+Om3YsTB85Xv9gSBpXiIgHI8ZsJ8Pl/WfssswkevrnZ
         P6Je6z5dYGseE+pICatgmWsaM+fxAdL4iphJPzDj1UYI/lXc/fNb91mNqh3xRskK4chd
         wv1YvKlNk+EP4SyCoWWJ4yaM92DKGX64uJ24G42gbs2MbxXqs29IgnV29Wk2K7z2fgQU
         rtUA==
X-Gm-Message-State: AOJu0Yy4Z3MURtCv88HsJUdvSxMtn0S2pddw6sDRcegHym1oOAOE5Nq/
	Bt00KOUgkwJT8eXHZ2BElCKMz5We4la8vnHV2y6TjYTJzqouGupIb/qO4S9Zrgc=
X-Google-Smtp-Source: AGHT+IHuYGldkbVfNdVrAN5LJAn/kQB7BWJj4t48pTtPV+pj3cUFE/MYEi7v7AEu1XUpJ0JSM9BKxA==
X-Received: by 2002:aa7:c555:0:b0:55f:2a30:a79d with SMTP id s21-20020aa7c555000000b0055f2a30a79dmr1557162edr.42.1706600238281;
        Mon, 29 Jan 2024 23:37:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402340b00b0055f11bd3564sm1386629edc.8.2024.01.29.23.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 23:37:17 -0800 (PST)
Message-ID: <a4324473-e0c6-4d53-8de0-03b69480e40b@linaro.org>
Date: Tue, 30 Jan 2024 08:37:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240126063500.2684087-1-wenst@chromium.org>
 <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org>
 <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
 <21568334-b21f-429e-81cd-5ce77accaf3c@linaro.org>
 <CAGXv+5HxXzjigN3Bp96vkv71WfTJ1S2b7Wgafc4GxLmhu6+jMg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGXv+5HxXzjigN3Bp96vkv71WfTJ1S2b7Wgafc4GxLmhu6+jMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/01/2024 04:32, Chen-Yu Tsai wrote:
> On Mon, Jan 29, 2024 at 3:34 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 29/01/2024 04:38, Chen-Yu Tsai wrote:
>>
>>>>> +allOf:
>>>>> +  - $ref: bluetooth-controller.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - mediatek,mt7921s-bluetooth
>>>>
>>>> Can it be also WiFi on separate bus? How many device nodes do you need
>>>> for this device?
>>>
>>> For the "S" variant, WiFi is also on SDIO. For the other two variants,
>>> "U" and "E", WiFi goes over USB and PCIe respectively. On both those
>>> variants, Bluetooth can either go over USB or UART. That is what I
>>> gathered from the pinouts. There are a dozen GPIO pins which don't
>>> have detailed descriptions though. If you want a comprehensive
>>> binding of the whole chip and all its variants, I suggest we ask
>>> MediaTek to provide it instead. My goal with the binding is to document
>>> existing usage and allow me to upstream new device trees.
>>>
>>> For now we only need the Bluetooth node. The WiFi part is perfectly
>>> detectable, and the driver doesn't seem to need the WiFi reset pin.
>>> The Bluetooth driver only uses its reset pin to reset a hung controller.
>>
>> Then suffix "bluetooth" seems redundant.
> 
> I think keeping the suffix makes more sense though. The chip is a two
> function piece, and this only targets one of the functions. Also, the

That's why I asked and you said there is only one interface: SDIO.

> compatible string is already used in an existing driver [1] and
> soon-to-be in-tree device tree [2].

That's not the way to upstream compatible. You cannot send it bypassing
bindings and review and later claim that's an ABI.


Best regards,
Krzysztof


